Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A27298521
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 01:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420859AbgJZAc3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Oct 2020 20:32:29 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36675 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420857AbgJZAc3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Oct 2020 20:32:29 -0400
Received: by mail-pj1-f67.google.com with SMTP id d22so811425pjz.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2020 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CsIU/W0BTwXYVtKEV+7B6DvVVf887wE6s7LJfI5jPZQ=;
        b=gjSx9OkYK0F201HMOba+DaS1gfGu88uaAWHzay0NvfJMz8deRRj88ibYk07CrEjiAk
         zj0Q+JE+AMt5fUHiAH/GVv7jPzOnznxhcPWZ0CVIUYrBxOiIGA3YLDIDm8eFuRsCX4yA
         oeTE6RhmL80X/x/JvK7tz/XlSr88LW4SKm1ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CsIU/W0BTwXYVtKEV+7B6DvVVf887wE6s7LJfI5jPZQ=;
        b=mBCvMYxx8bJoA7dgcQP7ayBPLh1//eBdkkOi4+74Sd4bZuUsQY994Rplzy/pL/EiqX
         wBHWGeTtS48d21xGRDOdQjbkbKASMFw8JyJQs6nO4nJcShTMW9sVDi6ZDCIoX067/tjk
         hyREfd7JECDMUyeJOgk96hBioMSPiJP53gu5I5YQrje3p3F8L0C70WEXIBhEGB3sAkR9
         r1lsKCbyC6a3HBWgb9R7PhU3jMmGPb5l1OZyWMapt7yDdgegf1y3sjVw1wtW/5UY6WFH
         FbKX20zFKqMIcMOk1cnWqOrPAaCSFk+VrBrhxWmKQSsV88xR7BmQBc38odPCbakxH1vz
         DAkw==
X-Gm-Message-State: AOAM530gP4DkqYQ1nuC4hKcuk59GEifxij+L5gxXbTHCCO427ONF8p6t
        +TMT15SCjA8dH6BEBQMU4RHmSg==
X-Google-Smtp-Source: ABdhPJwr1X6t3j45azHrIhS2mdTinP5F/ALvbWtggXrg1TXkO52IHM8o2EHJ9eVysLv3wSDWuvXFLw==
X-Received: by 2002:a17:902:204:b029:d3:9c43:3715 with SMTP id 4-20020a1709020204b02900d39c433715mr5895361plc.74.1603672347924;
        Sun, 25 Oct 2020 17:32:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 198sm2997682pfx.194.2020.10.25.17.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 17:32:26 -0700 (PDT)
Date:   Sun, 25 Oct 2020 17:32:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
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
Subject: Re: For review: seccomp_user_notif(2) manual page
Message-ID: <202010251725.2BD96926E3@keescook>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco>
 <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco>
 <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco>
 <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 01, 2020 at 03:52:02AM +0200, Jann Horn wrote:
> On Thu, Oct 1, 2020 at 1:25 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > On Thu, Oct 01, 2020 at 01:11:33AM +0200, Jann Horn wrote:
> > > On Thu, Oct 1, 2020 at 1:03 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > > > On Wed, Sep 30, 2020 at 10:34:51PM +0200, Michael Kerrisk (man-pages) wrote:
> > > > > On 9/30/20 5:03 PM, Tycho Andersen wrote:
> > > > > > On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pages) wrote:
> > > > > >>        ┌─────────────────────────────────────────────────────┐
> > > > > >>        │FIXME                                                │
> > > > > >>        ├─────────────────────────────────────────────────────┤
> > > > > >>        │From my experiments,  it  appears  that  if  a  SEC‐ │
> > > > > >>        │COMP_IOCTL_NOTIF_RECV   is  done  after  the  target │
> > > > > >>        │process terminates, then the ioctl()  simply  blocks │
> > > > > >>        │(rather than returning an error to indicate that the │
> > > > > >>        │target process no longer exists).                    │
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
> > > > I remembered wrong, it's actually in the tree: 99cdb8b9a573 ("seccomp:
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

Wait, why? Do you mean a ioctl calling loop (rather than a poll event
loop)? I think poll would be fine, but a "try calling RECV and expect to
return ENOENT" loop would change. But I don't think anyone would do this
exactly because it _currently_ acts like O_NONBLOCK, yes?

> probably also have to add some stupid counter in place of the
> semaphore's counter that we can use to preserve the old behavior of
> returning -ENOENT once for each cancelled request. :(

I only see this in Debian Code Search:
https://sources.debian.org/src/crun/0.15+dfsg-1/src/libcrun/seccomp_notify.c/?hl=166#L166
which is using epoll_wait():
https://sources.debian.org/src/crun/0.15+dfsg-1/src/libcrun/container.c/?hl=1326#L1326

I expect LXC is using it. :)

Let's change it ASAP! ;)

-Kees

> 
> I guess this is a nice point in favor of Michael's usual complaint
> that if there are no man pages for a feature by the time the feature
> lands upstream, there's a higher chance that the UAPI will suck
> forever...
> 
> 
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 676d4af62103..f0f4c68e0bc6 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -138,7 +138,6 @@ struct seccomp_kaddfd {
>   * @notifications: A list of struct seccomp_knotif elements.
>   */
>  struct notification {
> -       struct semaphore request;
>         u64 next_id;
>         struct list_head notifications;
>  };
> @@ -859,7 +858,6 @@ static int seccomp_do_user_notification(int this_syscall,
>         list_add(&n.list, &match->notif->notifications);
>         INIT_LIST_HEAD(&n.addfd);
> 
> -       up(&match->notif->request);
>         wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
>         mutex_unlock(&match->notify_lock);
> 
> @@ -1175,9 +1173,10 @@ find_notification(struct seccomp_filter *filter, u64 id)
> 
> 
>  static long seccomp_notify_recv(struct seccomp_filter *filter,
> -                               void __user *buf)
> +                               void __user *buf, bool blocking)
>  {
>         struct seccomp_knotif *knotif = NULL, *cur;
> +       DECLARE_WAITQUEUE(wait, current);
>         struct seccomp_notif unotif;
>         ssize_t ret;
> 
> @@ -1190,11 +1189,9 @@ static long seccomp_notify_recv(struct
> seccomp_filter *filter,
> 
>         memset(&unotif, 0, sizeof(unotif));
> 
> -       ret = down_interruptible(&filter->notif->request);
> -       if (ret < 0)
> -               return ret;
> -
>         mutex_lock(&filter->notify_lock);
> +
> +retry:
>         list_for_each_entry(cur, &filter->notif->notifications, list) {
>                 if (cur->state == SECCOMP_NOTIFY_INIT) {
>                         knotif = cur;
> @@ -1202,14 +1199,32 @@ static long seccomp_notify_recv(struct
> seccomp_filter *filter,
>                 }
>         }
> 
> -       /*
> -        * If we didn't find a notification, it could be that the task was
> -        * interrupted by a fatal signal between the time we were woken and
> -        * when we were able to acquire the rw lock.
> -        */
>         if (!knotif) {
> -               ret = -ENOENT;
> -               goto out;
> +               /* This has to happen before checking &filter->users. */
> +               prepare_to_wait(&filter->wqh, &wait, TASK_INTERRUPTIBLE);
> +
> +               /*
> +                * If all users of the filter are gone, throw an error instead
> +                * of pointlessly continuing to block.
> +                */
> +               if (refcount_read(&filter->users) == 0) {
> +                       ret = -ENOTCON;
> +                       goto out;
> +               }
> +               if (blocking) {
> +                       /* No notifications pending - wait for one,
> then retry. */
> +                       mutex_unlock(&filter->notify_lock);
> +                       schedule();
> +                       mutex_lock(&filter->notify_lock);
> +                       if (signal_pending(current)) {
> +                               ret = -EINTR;
> +                               goto out;
> +                       }
> +                       goto retry;
> +               } else {
> +                       ret = -ENOENT;
> +                       goto out;
> +               }
>         }
> 
>         unotif.id = knotif->id;
> @@ -1220,6 +1235,7 @@ static long seccomp_notify_recv(struct
> seccomp_filter *filter,
>         wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
>         ret = 0;
>  out:
> +       finish_wait(&filter->wqh, &wait);
>         mutex_unlock(&filter->notify_lock);
> 
>         if (ret == 0 && copy_to_user(buf, &unotif, sizeof(unotif))) {
> @@ -1233,10 +1249,8 @@ static long seccomp_notify_recv(struct
> seccomp_filter *filter,
>                  */
>                 mutex_lock(&filter->notify_lock);
>                 knotif = find_notification(filter, unotif.id);
> -               if (knotif) {
> +               if (knotif)
>                         knotif->state = SECCOMP_NOTIFY_INIT;
> -                       up(&filter->notif->request);
> -               }
>                 mutex_unlock(&filter->notify_lock);
>         }
> 
> @@ -1412,11 +1426,12 @@ static long seccomp_notify_ioctl(struct file
> *file, unsigned int cmd,
>  {
>         struct seccomp_filter *filter = file->private_data;
>         void __user *buf = (void __user *)arg;
> +       bool blocking = !(file->f_flags & O_NONBLOCK);
> 
>         /* Fixed-size ioctls */
>         switch (cmd) {
>         case SECCOMP_IOCTL_NOTIF_RECV:
> -               return seccomp_notify_recv(filter, buf);
> +               return seccomp_notify_recv(filter, buf, blocking);
>         case SECCOMP_IOCTL_NOTIF_SEND:
>                 return seccomp_notify_send(filter, buf);
>         case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
> @@ -1485,7 +1500,6 @@ static struct file *init_listener(struct
> seccomp_filter *filter)
>         if (!filter->notif)
>                 goto out;
> 
> -       sema_init(&filter->notif->request, 0);
>         filter->notif->next_id = get_random_u64();
>         INIT_LIST_HEAD(&filter->notif->notifications);

-- 
Kees Cook
