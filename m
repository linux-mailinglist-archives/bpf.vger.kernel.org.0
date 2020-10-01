Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A6227F799
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 03:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgJABwb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 21:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJABwb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 21:52:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7325C061755
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 18:52:30 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so5617865ejo.9
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 18:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1bLW1cuECr8U7GaM7z86G6hDD6exav2AJLPz5W/9Rmc=;
        b=kWsAhO4IucLVoZpMkahGgNES5DttbXTJpcoZ05moKrnMJckcHdlnDveEpyQqJc8ldL
         QfmGxf8Eh4Ts/puB9RclgWUNuwb8+d/iVmtJDeUBqGiXQbFScpcYNmbeq7REh8GBZzeT
         kLpXr6famz6F0NUDrEYV8TJ5EJq6Nq8M6GVDbEf26mf8kaU1XPG2YffLFbMei3Nk91vQ
         QdDbgSTH81W6Vq5el8rE1yJwMjFMyj2dtgPTKf+GCr0p1w2ZwEJrKJ3piLN2eBBO7yzq
         DUiUUF2/1A5woJuzwtDu3Xmtc/UNDykkbFsVApnq68QIoe/tglaDjWjVMTFxgl8A6CWl
         gExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1bLW1cuECr8U7GaM7z86G6hDD6exav2AJLPz5W/9Rmc=;
        b=mF998TRvDJozmVfhJPKzEiFcCia4XXOM94gCu2/xYK1fwoupk109Wni9FLUoKy0omv
         dVgPZJNYx4TeB0A0Ck6uV1StwhT1TK3y0tNXq88Bl7SCdJM1zsTMpaHog2tY1SzU1HzF
         zSo4fkE2gBLQ2CxnWg/LDT0GBjuWVonFfr3HpH/f7jZCbKkAtlu0XtkUsT8pjOgFL/l5
         DtH8fPoqGSVbwogbTWIPOfNP95zyb+Dz8hfCzdZ49HDH3lpq1XC8uGdhvUfNk0MyCzsb
         Ugpf9GawirMSbfeJzANLkx7nP8y4nNPsQaimRskjss2vW8XLHDnu5IjjOXF9rJd5VzPf
         VKqQ==
X-Gm-Message-State: AOAM533GXl2annCOPIwGbbRFVoQRY82kdfBgXUE3TH4t7y0GIouf8wzp
        KvLZju6FmYFDpPV5stWzN/2ProTvf297vhXEQ/pSVA==
X-Google-Smtp-Source: ABdhPJy9aveDYFv4Gp14hKtilrKvNnkWXVsoiclevL5nYsStDKDifSDiKxQQKSwQqipgFKjnKXSV1kjDNtmgRMOszBo=
X-Received: by 2002:a17:906:1f94:: with SMTP id t20mr5795435ejr.493.1601517149212;
 Wed, 30 Sep 2020 18:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco>
In-Reply-To: <20200930232456.GB1260245@cisco>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 03:52:02 +0200
Message-ID: <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 1:25 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> On Thu, Oct 01, 2020 at 01:11:33AM +0200, Jann Horn wrote:
> > On Thu, Oct 1, 2020 at 1:03 AM Tycho Andersen <tycho@tycho.pizza> wrote=
:
> > > On Wed, Sep 30, 2020 at 10:34:51PM +0200, Michael Kerrisk (man-pages)=
 wrote:
> > > > On 9/30/20 5:03 PM, Tycho Andersen wrote:
> > > > > On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pa=
ges) wrote:
> > > > >>        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> > > > >>        =E2=94=82FIXME                                           =
     =E2=94=82
> > > > >>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> > > > >>        =E2=94=82From my experiments,  it  appears  that  if  a  =
SEC=E2=80=90 =E2=94=82
> > > > >>        =E2=94=82COMP_IOCTL_NOTIF_RECV   is  done  after  the  ta=
rget =E2=94=82
> > > > >>        =E2=94=82process terminates, then the ioctl()  simply  bl=
ocks =E2=94=82
> > > > >>        =E2=94=82(rather than returning an error to indicate that=
 the =E2=94=82
> > > > >>        =E2=94=82target process no longer exists).               =
     =E2=94=82
> > > > >
> > > > > Yeah, I think Christian wanted to fix this at some point,
> > > >
> > > > Do you have a pointer that discussion? I could not find it with a
> > > > quick search.
> > > >
> > > > > but it's a
> > > > > bit sticky to do.
> > > >
> > > > Can you say a few words about the nature of the problem?
> > >
> > > I remembered wrong, it's actually in the tree: 99cdb8b9a573 ("seccomp=
:
> > > notify about unused filter"). So maybe there's a bug here?
> >
> > That thing only notifies on ->poll, it doesn't unblock ioctls; and
> > Michael's sample code uses SECCOMP_IOCTL_NOTIF_RECV to wait. So that
> > commit doesn't have any effect on this kind of usage.
>
> Yes, thanks. And the ones stuck in RECV are waiting on a semaphore so
> we don't have a count of all of them, unfortunately.
>
> We could maybe look inside the wait_list, but that will probably make
> people angry :)

The easiest way would probably be to open-code the semaphore-ish part,
and let the semaphore and poll share the waitqueue. The current code
kind of mirrors the semaphore's waitqueue in the wqh - open-coding the
entire semaphore would IMO be cleaner than that. And it's not like
semaphore semantics are even a good fit for this code anyway.

Let's see... if we didn't have the existing UAPI to worry about, I'd
do it as follows (*completely* untested). That way, the ioctl would
block exactly until either there actually is a request to deliver or
there are no more users of the filter. The problem is that if we just
apply this patch, existing users of SECCOMP_IOCTL_NOTIF_RECV that use
an event loop and don't set O_NONBLOCK will be screwed. So we'd
probably also have to add some stupid counter in place of the
semaphore's counter that we can use to preserve the old behavior of
returning -ENOENT once for each cancelled request. :(

I guess this is a nice point in favor of Michael's usual complaint
that if there are no man pages for a feature by the time the feature
lands upstream, there's a higher chance that the UAPI will suck
forever...



diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 676d4af62103..f0f4c68e0bc6 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -138,7 +138,6 @@ struct seccomp_kaddfd {
  * @notifications: A list of struct seccomp_knotif elements.
  */
 struct notification {
-       struct semaphore request;
        u64 next_id;
        struct list_head notifications;
 };
@@ -859,7 +858,6 @@ static int seccomp_do_user_notification(int this_syscal=
l,
        list_add(&n.list, &match->notif->notifications);
        INIT_LIST_HEAD(&n.addfd);

-       up(&match->notif->request);
        wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
        mutex_unlock(&match->notify_lock);

@@ -1175,9 +1173,10 @@ find_notification(struct seccomp_filter *filter, u64=
 id)


 static long seccomp_notify_recv(struct seccomp_filter *filter,
-                               void __user *buf)
+                               void __user *buf, bool blocking)
 {
        struct seccomp_knotif *knotif =3D NULL, *cur;
+       DECLARE_WAITQUEUE(wait, current);
        struct seccomp_notif unotif;
        ssize_t ret;

@@ -1190,11 +1189,9 @@ static long seccomp_notify_recv(struct
seccomp_filter *filter,

        memset(&unotif, 0, sizeof(unotif));

-       ret =3D down_interruptible(&filter->notif->request);
-       if (ret < 0)
-               return ret;
-
        mutex_lock(&filter->notify_lock);
+
+retry:
        list_for_each_entry(cur, &filter->notif->notifications, list) {
                if (cur->state =3D=3D SECCOMP_NOTIFY_INIT) {
                        knotif =3D cur;
@@ -1202,14 +1199,32 @@ static long seccomp_notify_recv(struct
seccomp_filter *filter,
                }
        }

-       /*
-        * If we didn't find a notification, it could be that the task was
-        * interrupted by a fatal signal between the time we were woken and
-        * when we were able to acquire the rw lock.
-        */
        if (!knotif) {
-               ret =3D -ENOENT;
-               goto out;
+               /* This has to happen before checking &filter->users. */
+               prepare_to_wait(&filter->wqh, &wait, TASK_INTERRUPTIBLE);
+
+               /*
+                * If all users of the filter are gone, throw an error inst=
ead
+                * of pointlessly continuing to block.
+                */
+               if (refcount_read(&filter->users) =3D=3D 0) {
+                       ret =3D -ENOTCON;
+                       goto out;
+               }
+               if (blocking) {
+                       /* No notifications pending - wait for one,
then retry. */
+                       mutex_unlock(&filter->notify_lock);
+                       schedule();
+                       mutex_lock(&filter->notify_lock);
+                       if (signal_pending(current)) {
+                               ret =3D -EINTR;
+                               goto out;
+                       }
+                       goto retry;
+               } else {
+                       ret =3D -ENOENT;
+                       goto out;
+               }
        }

        unotif.id =3D knotif->id;
@@ -1220,6 +1235,7 @@ static long seccomp_notify_recv(struct
seccomp_filter *filter,
        wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
        ret =3D 0;
 out:
+       finish_wait(&filter->wqh, &wait);
        mutex_unlock(&filter->notify_lock);

        if (ret =3D=3D 0 && copy_to_user(buf, &unotif, sizeof(unotif))) {
@@ -1233,10 +1249,8 @@ static long seccomp_notify_recv(struct
seccomp_filter *filter,
                 */
                mutex_lock(&filter->notify_lock);
                knotif =3D find_notification(filter, unotif.id);
-               if (knotif) {
+               if (knotif)
                        knotif->state =3D SECCOMP_NOTIFY_INIT;
-                       up(&filter->notif->request);
-               }
                mutex_unlock(&filter->notify_lock);
        }

@@ -1412,11 +1426,12 @@ static long seccomp_notify_ioctl(struct file
*file, unsigned int cmd,
 {
        struct seccomp_filter *filter =3D file->private_data;
        void __user *buf =3D (void __user *)arg;
+       bool blocking =3D !(file->f_flags & O_NONBLOCK);

        /* Fixed-size ioctls */
        switch (cmd) {
        case SECCOMP_IOCTL_NOTIF_RECV:
-               return seccomp_notify_recv(filter, buf);
+               return seccomp_notify_recv(filter, buf, blocking);
        case SECCOMP_IOCTL_NOTIF_SEND:
                return seccomp_notify_send(filter, buf);
        case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
@@ -1485,7 +1500,6 @@ static struct file *init_listener(struct
seccomp_filter *filter)
        if (!filter->notif)
                goto out;

-       sema_init(&filter->notif->request, 0);
        filter->notif->next_id =3D get_random_u64();
        INIT_LIST_HEAD(&filter->notif->notifications);
