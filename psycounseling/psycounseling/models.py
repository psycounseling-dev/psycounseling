# from django.db import connections
from django.db import models


class Classifier(models.Model):
    id = models.PositiveIntegerField(primary_key=True)
    parent = models.ForeignKey('self', models.DO_NOTHING, blank=True, null=True)
    class_code = models.CharField(max_length=30)
    class_name = models.CharField(max_length=50, blank=True, null=True)
    note = models.CharField(max_length=255, blank=True, null=True)
    is_system = models.CharField(max_length=1)
    entry_id = models.PositiveIntegerField()
    entry_time = models.DateTimeField()
    update_id = models.PositiveIntegerField(blank=True, null=True)
    update_time = models.DateTimeField(blank=True, null=True)
    is_readonly = models.CharField(max_length=1)
    
    class Meta:
        managed = False
        db_table = 'classifier'


class Item(models.Model):
    iid = models.AutoField(primary_key=True)
    parent_iid = models.ForeignKey('self', models.DO_NOTHING,
                                   db_column='parent_iid',
                                   blank=True, null=True)
    classifier = models.ForeignKey(Classifier, models.DO_NOTHING)
    code = models.CharField(max_length=30, blank=True, null=True)
    code_lit = models.CharField(max_length=30, blank=True, null=True)
    code_num = models.IntegerField(blank=True, null=True)
    name = models.CharField(max_length=80, blank=True, null=True)
    full_name = models.CharField(max_length=160, blank=True, null=True)
    item_name = models.CharField(max_length=80, blank=True, null=True)
    note = models.CharField(max_length=255, blank=True, null=True)
    status_iid = models.PositiveIntegerField()
    entry_id = models.PositiveIntegerField()
    entry_time = models.DateTimeField()
    update_id = models.PositiveIntegerField(blank=True, null=True)
    update_time = models.DateTimeField(blank=True, null=True)
    sort_idx = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'item'


class Attachment(models.Model):
    file_name = models.TextField(blank=True, null=True)
    file_type = models.TextField(blank=True, null=True)
    file_path = models.TextField(blank=True, null=True)
    file_url = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'attachment'


class Calendar(models.Model):
    cdate = models.DateField(primary_key=True)
    day_type_iid = models.PositiveIntegerField()
    entry_id = models.PositiveIntegerField()
    entry_tyme = models.DateTimeField()
    update_id = models.PositiveIntegerField(blank=True, null=True)
    updatetime = models.DateTimeField(db_column='UpdateTime', blank=True, null=True)  

    class Meta:
        managed = False
        db_table = 'calendar'


class Comment(models.Model):
    post = models.ForeignKey('Post', models.DO_NOTHING)
    entry_id = models.PositiveIntegerField()
    entry_date = models.DateTimeField()
    key = models.CharField(max_length=255)
    value = models.TextField(blank=True, null=True)
    karma = models.IntegerField()
    status_iid = models.PositiveIntegerField()
    type_iid = models.PositiveIntegerField()
    parent_id = models.PositiveIntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'comment'


class Commentmeta(models.Model):
    comment = models.ForeignKey(Comment, models.DO_NOTHING, blank=True, null=True)
    key = models.CharField(max_length=255)
    value = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'commentmeta'


class Dues(models.Model):
    member_id = models.PositiveIntegerField()
    oper_date = models.DateField()
    iban = models.IntegerField(db_column='IBAN', blank=True, null=True)  # Field name made lowercase.
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    purpose_iid = models.ForeignKey('Item', models.DO_NOTHING, db_column='purpose_iid')
    status_iid = models.PositiveIntegerField()
    entry_id = models.PositiveIntegerField()
    entry_time = models.DateTimeField()
    note = models.CharField(max_length=255, blank=True, null=True)
    transaction_no = models.IntegerField(blank=True, null=True)
    period = models.ForeignKey('Period', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'dues'

class Period(models.Model):
    begin_date = models.ForeignKey(Calendar, models.DO_NOTHING, db_column='begin_date', to_field='cdate')
    end_date = models.DateField()

    class Meta:
        managed = False
        db_table = 'period'

class Event(models.Model):
    type_iid = models.PositiveIntegerField()
    key = models.CharField(max_length=255)
    value = models.TextField(blank=True, null=True)
    period = models.ForeignKey(Period, models.DO_NOTHING)
    note = models.CharField(max_length=255, blank=True, null=True)
    url = models.CharField(max_length=255, blank=True, null=True)
    status_iid = models.ForeignKey(Item, models.DO_NOTHING, db_column='status_iid')
    entry_id = models.PositiveIntegerField()
    entry_time = models.DateTimeField()
    update_id = models.PositiveIntegerField(blank=True, null=True)
    update_time = models.DateTimeField(blank=True, null=True)
    post = models.ForeignKey('Post', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'event'


class FailedLogin(models.Model):
    user = models.ForeignKey('User', models.DO_NOTHING, blank=True, null=True)
    user_login = models.CharField(max_length=150)
    failed_login_date = models.DateTimeField()
    login_attempt_ip = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'failed_login'


class FixedDues(models.Model):
    type_iid = models.ForeignKey('Item', models.DO_NOTHING, db_column='type_iid', blank=True, null=True)
    begin_date = models.DateField()
    end_date = models.DateField()
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    status_iid = models.PositiveIntegerField()
    entry_id = models.PositiveIntegerField()
    entry_time = models.DateTimeField()
    update_id = models.PositiveIntegerField(blank=True, null=True)
    update_time = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'fixed_dues'


class Image(models.Model):
    post = models.ForeignKey('Post', models.DO_NOTHING)
    url = models.CharField(max_length=600)
    file_name = models.CharField(max_length=600)
    attachment = models.ForeignKey(Attachment, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'image'


class LoginActivity(models.Model):
    user = models.ForeignKey('User', models.DO_NOTHING, blank=True, null=True)
    user_login = models.CharField(max_length=150)
    in_date = models.DateTimeField()
    out_date = models.DateTimeField()
    ip_address = models.CharField(max_length=100)
    browser_type = models.CharField(max_length=150)

    class Meta:
        managed = False
        db_table = 'login_activity'


class LoginLockdown(models.Model):
    user = models.ForeignKey('User', models.DO_NOTHING, blank=True, null=True)
    user_login = models.CharField(max_length=150)
    lockdown_date = models.DateTimeField()
    release_date = models.DateTimeField()
    ip_address = models.CharField(max_length=100)
    lock_reason = models.CharField(max_length=128)
    unlock_key = models.CharField(max_length=128)

    class Meta:
        managed = False
        db_table = 'login_lockdown'


class Member(models.Model):
    type_iid = models.ForeignKey(Item, models.DO_NOTHING, db_column='type_iid')
    user_id = models.PositiveIntegerField(blank=True, null=True)
    tax_code = models.CharField(max_length=20, blank=True, null=True)
    last_name = models.CharField(max_length=50, blank=True, null=True)
    first_name = models.CharField(max_length=50, blank=True, null=True)
    middle_name = models.CharField(max_length=50, blank=True, null=True)
    org_name = models.CharField(max_length=250, blank=True, null=True)
    country_iid = models.PositiveIntegerField(blank=True, null=True)
    doc_type_iid = models.PositiveIntegerField(blank=True, null=True)
    doc_series = models.CharField(max_length=10, blank=True, null=True)
    doc_num = models.CharField(max_length=30, blank=True, null=True)
    sex_iid = models.PositiveIntegerField(blank=True, null=True)
    birthday = models.DateField(blank=True, null=True)
    status_iid = models.PositiveIntegerField()
    close_date = models.DateField(blank=True, null=True)
    entry_id = models.PositiveIntegerField()
    entry_time = models.DateTimeField()
    update_iid = models.PositiveIntegerField(blank=True, null=True)
    update_time = models.DateTimeField(blank=True, null=True)
    note = models.CharField(max_length=200, blank=True, null=True)
    reestr_num = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member'


class Menu(models.Model):
    parent_id = models.PositiveIntegerField(blank=True, null=True)
    status_iid = models.PositiveIntegerField()
    type_iid = models.PositiveIntegerField()
    # language_iid = models.PositiveIntegerField()
    key = models.CharField(max_length=255)
    value = models.TextField(blank=True, null=True)
    entry_id = models.PositiveIntegerField()
    entry_date = models.DateTimeField()
    update_id = models.PositiveIntegerField(blank=True, null=True)
    update_date = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'menu'


class Options(models.Model):
    id = models.PositiveIntegerField(primary_key=True)
    key = models.CharField(unique=True, max_length=255)
    value = models.TextField(blank=True, null=True)
    is_autoload = models.CharField(max_length=1)

    class Meta:
        managed = False
        db_table = 'options'



class Post(models.Model):
    menu = models.ForeignKey(Menu, models.DO_NOTHING)
    parent_id = models.PositiveIntegerField(blank=True, null=True)
    status_iid = models.ForeignKey(Item, models.DO_NOTHING, db_column='status_iid')
    type_iid = models.PositiveIntegerField()
    entry_id = models.PositiveIntegerField()
    entry_date = models.DateTimeField()
    update_id = models.PositiveIntegerField(blank=True, null=True)
    update_date = models.DateTimeField(blank=True, null=True)
    key = models.CharField(max_length=255)
    value = models.TextField(blank=True, null=True)
    title = models.TextField()
    excerpt = models.TextField()

    class Meta:
        managed = False
        db_table = 'post'


class Postmeta(models.Model):
    post = models.ForeignKey(Post, models.DO_NOTHING)
    key = models.CharField(max_length=255)
    value = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'postmeta'


class SupportReply(models.Model):
    request = models.ForeignKey('User', models.DO_NOTHING)
    user_id = models.PositiveIntegerField()
    key = models.CharField(max_length=255)
    value = models.TextField(blank=True, null=True)
    entry_date = models.DateTimeField()
    entry_id = models.PositiveIntegerField()

    class Meta:
        managed = False
        db_table = 'support_reply'


class SupportRequest(models.Model):
    user = models.ForeignKey('User', models.DO_NOTHING)
    key = models.CharField(max_length=255)
    value = models.TextField(blank=True, null=True)
    entry_date = models.DateTimeField()
    entry_id = models.PositiveIntegerField()

    class Meta:
        managed = False
        db_table = 'support_request'


class TransLog(models.Model):
    timestamp = models.DateTimeField()
    level = models.IntegerField()
    source = models.CharField(max_length=200)
    message = models.TextField()
    value = models.TextField(blank=True, null=True)
    user = models.ForeignKey('User', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'trans_log'


class User(models.Model):
    login = models.CharField(max_length=60)
    psw = models.CharField(max_length=255)
    nicename = models.CharField(max_length=50)
    email = models.CharField(max_length=100)
    url = models.CharField(max_length=100)
    registered = models.DateTimeField()
    activation_key = models.CharField(max_length=255)
    status_iid = models.PositiveIntegerField()
    display_name = models.CharField(max_length=250)
    type_iid = models.ForeignKey(Item, models.DO_NOTHING, db_column='type_iid')
    begin_date = models.DateField(blank=True, null=True)
    end_date = models.DateField(blank=True, null=True)
    expire_date = models.DateField(blank=True, null=True)
    post_id = models.IntegerField(blank=True, null=True)
    tel_num = models.CharField(max_length=20, blank=True, null=True)
    entry_id = models.PositiveIntegerField(blank=True, null=True)
    entry_time = models.DateTimeField()
    update_id = models.PositiveIntegerField(blank=True, null=True)
    update_time = models.DateTimeField(blank=True, null=True)
    note = models.CharField(max_length=200, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'user'


class UserGroup(models.Model):
    code = models.CharField(max_length=30)
    name = models.CharField(max_length=50)
    note = models.CharField(max_length=255, blank=True, null=True)
    status_iid = models.ForeignKey(Item, models.DO_NOTHING, db_column='status_iid')
    entry_id = models.PositiveIntegerField()
    entry_time = models.DateTimeField()
    update = models.ForeignKey(User, models.DO_NOTHING, blank=True, null=True)
    update_time = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'user_group'


class UserGroupContent(models.Model):
    id = models.PositiveIntegerField(primary_key=True)
    user = models.ForeignKey(User, models.DO_NOTHING)
    group = models.ForeignKey(UserGroup, models.DO_NOTHING)
    entry_id = models.PositiveIntegerField()
    entry_time = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'user_group_content'


class Usermeta(models.Model):
    id = models.PositiveIntegerField(primary_key=True)
    user = models.ForeignKey(User, models.DO_NOTHING)
    key = models.CharField(max_length=255)
    value = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'usermeta'
