Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8055D27F7DC
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 04:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgJACOf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 22:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgJACOf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 22:14:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96795C0613D0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 19:14:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lo4so5679395ejb.8
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 19:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VRlF+sTfUEUU0FQV/Q3ZTIfFAHBYdXbqZatAP+Y9VjY=;
        b=f3D4rSyONiBy/W2syYMtXYxEiZxsifbXExflXIoDgFLYJaq88Fye9iITAygHX0Inau
         94AyiPomN616HnDcapWTX7fv1JiE7wFoC7v7CGcBX4h3ObrkigSJekXbgkrObeDgb8sA
         RoePxFu67r3XoJaEPM8u2UGZdHgBWVWWciLe7zB2C32HVmLdywhAnM6XV9PG5GpX0DvI
         ix1v3FQCqnYVPBd5u6kN3TyXKZYWMZEbJXQF83FDnR0n8xs7nobbIdjyzYkj9y3ye20i
         unMoq/H84N4g7kWMxVnH5h0nwEh01QJ09jrh6oGSqFwyb22qu+9FNVlqLXAiqafRe4e+
         z4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VRlF+sTfUEUU0FQV/Q3ZTIfFAHBYdXbqZatAP+Y9VjY=;
        b=GaocybDwk9SfAvU3Jx8sw0gCdsSZTYG2/xW7xLtqMTTjKXNo0VcjujJ1IkgboMnfuO
         rZ8m+0dOxZpSVng7+MsIiJtYBgILsAA8p6mmfTceM1Ku1MBZ3brwfvRmhM5Mtx2UMx9o
         CiwrTHphWEcIbSEKHO4eedDf1wMKNpWUBEB0h4wK/SgqK84LfXyj/LifWR0rWRy5W3dT
         /Ryxod56+dRM6XuSifuoYBkcy7O8TWeI6QLX5dy6V2i88drCaRRRVfoCuuA3dnfkqHvg
         YsI3ae3CtV3Lc7rHixmF42BI7QaEOsDVFf49pqGAdjtR8s9LfeO9M79crdSjjqFIK6kN
         o6wA==
X-Gm-Message-State: AOAM533KxF25ooAJFO77vGimamGqjjXLclVNMbkn1qBZ18JJuiWsErnC
        FKlYVE4uegs5AkSS4Nxg7L3lVD6pEaSGPZ7QOAW0gQ==
X-Google-Smtp-Source: ABdhPJzFEQyU1Y0EFbRA6jhr+9dXp0C5I/GT8CyTqnw3SfFunhixdX0N+3zH6ptOPj+ZsewB07FSBmbyi/DGnGjyGEM=
X-Received: by 2002:a17:907:94cf:: with SMTP id dn15mr5974052ejc.114.1601518472957;
 Wed, 30 Sep 2020 19:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco> <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
In-Reply-To: <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 04:14:06 +0200
Message-ID: <CAG48ez3kpEDO1x_HfvOM2R9M78Ach9O_4+Pjs-vLLfqvZL+13A@mail.gmail.com>
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

On Thu, Oct 1, 2020 at 3:52 AM Jann Horn <jannh@google.com> wrote:
> On Thu, Oct 1, 2020 at 1:25 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > On Thu, Oct 01, 2020 at 01:11:33AM +0200, Jann Horn wrote:
> > > On Thu, Oct 1, 2020 at 1:03 AM Tycho Andersen <tycho@tycho.pizza> wro=
te:
> > > > On Wed, Sep 30, 2020 at 10:34:51PM +0200, Michael Kerrisk (man-page=
s) wrote:
> > > > > On 9/30/20 5:03 PM, Tycho Andersen wrote:
> > > > > > On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-=
pages) wrote:
> > > > > >>        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> > > > > >>        =E2=94=82FIXME                                         =
       =E2=94=82
> > > > > >>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> > > > > >>        =E2=94=82From my experiments,  it  appears  that  if  a=
  SEC=E2=80=90 =E2=94=82
> > > > > >>        =E2=94=82COMP_IOCTL_NOTIF_RECV   is  done  after  the  =
target =E2=94=82
> > > > > >>        =E2=94=82process terminates, then the ioctl()  simply  =
blocks =E2=94=82
> > > > > >>        =E2=94=82(rather than returning an error to indicate th=
at the =E2=94=82
> > > > > >>        =E2=94=82target process no longer exists).             =
       =E2=94=82
> > > > > >
> > > > > > Yeah, I think Christian wanted to fix this at some point,
> > > > >
> > > > > Do you have a pointer that discussion? I could not find it with a
> > > > > quick search.
> > > > >
> > > > > > but it's a
> > > > > > bit sticky to do.
> > > > >
> > > > > Can you say a few words about the nature of the problem?
> > > >
> > > > I remembered wrong, it's actually in the tree: 99cdb8b9a573 ("secco=
mp:
> > > > notify about unused filter"). So maybe there's a bug here?
> > >
> > > That thing only notifies on ->poll, it doesn't unblock ioctls; and
> > > Michael's sample code uses SECCOMP_IOCTL_NOTIF_RECV to wait. So that
> > > commit doesn't have any effect on this kind of usage.
> >
> > Yes, thanks. And the ones stuck in RECV are waiting on a semaphore so
> > we don't have a count of all of them, unfortunately.
> >
> > We could maybe look inside the wait_list, but that will probably make
> > people angry :)
>
> The easiest way would probably be to open-code the semaphore-ish part,
> and let the semaphore and poll share the waitqueue. The current code
> kind of mirrors the semaphore's waitqueue in the wqh - open-coding the
> entire semaphore would IMO be cleaner than that. And it's not like
> semaphore semantics are even a good fit for this code anyway.
>
> Let's see... if we didn't have the existing UAPI to worry about, I'd
> do it as follows (*completely* untested). That way, the ioctl would
> block exactly until either there actually is a request to deliver or
> there are no more users of the filter. The problem is that if we just
> apply this patch, existing users of SECCOMP_IOCTL_NOTIF_RECV that use
> an event loop and don't set O_NONBLOCK will be screwed. So we'd
> probably also have to add some stupid counter in place of the
> semaphore's counter that we can use to preserve the old behavior of
> returning -ENOENT once for each cancelled request. :(
>
> I guess this is a nice point in favor of Michael's usual complaint
> that if there are no man pages for a feature by the time the feature
> lands upstream, there's a higher chance that the UAPI will suck
> forever...

And I guess this would be the UAPI-compatible version - not actually
as terrible as I thought it might be. Do y'all want this? If so, feel
free to either turn this into a proper patch with Co-developed-by, or
tell me that I should do it and I'll try to get around to turning it
into something proper.

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 676d4af62103..d08c453fcc2c 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -138,7 +138,7 @@ struct seccomp_kaddfd {
  * @notifications: A list of struct seccomp_knotif elements.
  */
 struct notification {
-       struct semaphore request;
+       bool canceled_reqs;
        u64 next_id;
        struct list_head notifications;
 };
@@ -859,7 +859,6 @@ static int seccomp_do_user_notification(int this_syscal=
l,
        list_add(&n.list, &match->notif->notifications);
        INIT_LIST_HEAD(&n.addfd);

-       up(&match->notif->request);
        wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
        mutex_unlock(&match->notify_lock);

@@ -901,8 +900,20 @@ static int seccomp_do_user_notification(int this_sysca=
ll,
         * *reattach* to a notifier right now. If one is added, we'll need =
to
         * keep track of the notif itself and make sure they match here.
         */
-       if (match->notif)
+       if (match->notif) {
                list_del(&n.list);
+
+               /*
+                * We are stuck with a UAPI that requires that after a spur=
ious
+                * wakeup, SECCOMP_IOCTL_NOTIF_RECV must return immediately=
.
+                * This is the tracking for that, keeping track of whether =
we
+                * canceled a request after waking waiters, but before user=
space
+                * picked up the notification.
+                */
+               if (n.state =3D=3D SECCOMP_NOTIFY_INIT)
+                       match->notif->canceled_reqs =3D true;
+       }
+
 out:
        mutex_unlock(&match->notify_lock);

@@ -1178,6 +1189,7 @@ static long seccomp_notify_recv(struct
seccomp_filter *filter,
                                void __user *buf)
 {
        struct seccomp_knotif *knotif =3D NULL, *cur;
+       DECLARE_WAITQUEUE(wait, current);
        struct seccomp_notif unotif;
        ssize_t ret;

@@ -1190,11 +1202,9 @@ static long seccomp_notify_recv(struct
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
@@ -1202,14 +1212,32 @@ static long seccomp_notify_recv(struct
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
+               if (filter->notif->canceled_reqs) {
+                       ret =3D -ENOENT;
+                       goto out;
+               } else {
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
+               }
        }

        unotif.id =3D knotif->id;
@@ -1220,6 +1248,8 @@ static long seccomp_notify_recv(struct
seccomp_filter *filter,
        wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
        ret =3D 0;
 out:
+       filter->notif->canceled_reqs =3D false;
+       finish_wait(&filter->wqh, &wait);
        mutex_unlock(&filter->notify_lock);

        if (ret =3D=3D 0 && copy_to_user(buf, &unotif, sizeof(unotif))) {
@@ -1233,10 +1263,8 @@ static long seccomp_notify_recv(struct
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

@@ -1485,7 +1513,6 @@ static struct file *init_listener(struct
seccomp_filter *filter)
        if (!filter->notif)
                goto out;

-       sema_init(&filter->notif->request, 0);
        filter->notif->next_id =3D get_random_u64();
        INIT_LIST_HEAD(&filter->notif->notifications);
