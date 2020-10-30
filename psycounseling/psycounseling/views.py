from django.shortcuts import render
from .models import Menu

def showMenu(request):
    resultsdisplay = Menu.objects.all()
    return render(request, "page1.html", {"Menu": resultsdisplay})