from django.urls import path
from . import views

urlpatterns = [
    path("posts/", views.PostCreateList.as_view(), name = "post-view-create"),
    path("posts/<int>:pk", views.PostUpdateDelete.as_view(), name = "post_update-delete")
]