Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2432298293
	for <lists+bpf@lfdr.de>; Sun, 25 Oct 2020 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415255AbgJYQcC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Oct 2020 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415245AbgJYQcC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Oct 2020 12:32:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243EDC061755;
        Sun, 25 Oct 2020 09:32:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so10234997wmi.3;
        Sun, 25 Oct 2020 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/1PhpiaGrcRVzr2dnc2fyLo2nw7qkVLeNf9/Q+x9ahw=;
        b=nawbTnLPKD4DqjmM6ewryum9JjjHTDkAV9TxsBc9YR0pLaH4o6SX+Qhxp6loGifbwQ
         x3a0RTan1yxkaHDewsSeLWngtY7jHGLS16ADsm8J1aYwHiUA+ju6/AzkjTQ8YXpztzNv
         9orEtUzPt9WdEReSU9f7DmgsWUPanLA71+swdDSJlcdrspWFWXyHhH7ENH03TB1K0MGD
         1YGzSH56L5NbAl5xmy8Atf384e/tvm7mU4O8R/gmXl3WtW3moHjkkXT68GkVSHS3XR7x
         ueA6ZlG0dOqw1kcqF0azu684aRe8y61AhaEl0sJ8wkQ+YhREQuyKCx+5oPjLPHIxUAUt
         sOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/1PhpiaGrcRVzr2dnc2fyLo2nw7qkVLeNf9/Q+x9ahw=;
        b=CRzvvAcT6i/gXuoLFn53uMCQpobOa4uZpclMTbaoTv8UagOZUTpWVpGXKJzBqAP9G1
         FblZu7ACapWnBQ2KPAFbdSnAZiMSUxiKxGgN7tbZ+5hOM1MnDNaPj5ok5bS6X4rkkeWe
         Uc2TWwWWQsBWUIzqDqQtRQCPqP5FRsq+GbNusi9RohdmILN4HvuNLbK39ZpYCUMeg2fw
         w0XiPemt7uhephfHfsuR39XGJhK5QTp0/p0hGhrkNi4AGxRKukbmmxsA2W6v+CMLl8Pv
         BfIF0CgmeVqcK5SRGOdNWR8Jx8J4l+zT6FnMNm2kYvNUmA93rxATJthVlXr1Dc7y5UwM
         326A==
X-Gm-Message-State: AOAM532TxyWxA2S+CaGE86QUiAOaIPpBr+Tl7Yoqu3aUXxcvo5qi4rwe
        9A8mUdmzSbFJpAohDpODoJM=
X-Google-Smtp-Source: ABdhPJx7vk/G55nR+opoaTDKe9KNtkkb51flCTuqdIOrlydlq4WIf1jjqKd6YFnpwhE9+W9ZRj732A==
X-Received: by 2002:a7b:c00a:: with SMTP id c10mr3285431wmb.119.1603643520712;
        Sun, 25 Oct 2020 09:32:00 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id c18sm17512627wrq.5.2020.10.25.09.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2020 09:31:59 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Sargun Dhillon <sargun@sargun.me>,
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
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.pizza>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco>
 <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco>
 <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco>
 <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <CAG48ez3kpEDO1x_HfvOM2R9M78Ach9O_4+Pjs-vLLfqvZL+13A@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <656a37b5-75e3-0ded-6ba8-3bb57b537b24@gmail.com>
Date:   Sun, 25 Oct 2020 17:31:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3kpEDO1x_HfvOM2R9M78Ach9O_4+Pjs-vLLfqvZL+13A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jann,

On 10/1/20 4:14 AM, Jann Horn wrote:
> On Thu, Oct 1, 2020 at 3:52 AM Jann Horn <jannh@google.com> wrote:
>> On Thu, Oct 1, 2020 at 1:25 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>>> On Thu, Oct 01, 2020 at 01:11:33AM +0200, Jann Horn wrote:
>>>> On Thu, Oct 1, 2020 at 1:03 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>>>>> On Wed, Sep 30, 2020 at 10:34:51PM +0200, Michael Kerrisk (man-pages) wrote:
>>>>>> On 9/30/20 5:03 PM, Tycho Andersen wrote:
>>>>>>> On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pages) wrote:
>>>>>>>>        ┌─────────────────────────────────────────────────────┐
>>>>>>>>        │FIXME                                                │
>>>>>>>>        ├─────────────────────────────────────────────────────┤
>>>>>>>>        │From my experiments,  it  appears  that  if  a  SEC‐ │
>>>>>>>>        │COMP_IOCTL_NOTIF_RECV   is  done  after  the  target │
>>>>>>>>        │process terminates, then the ioctl()  simply  blocks │
>>>>>>>>        │(rather than returning an error to indicate that the │
>>>>>>>>        │target process no longer exists).                    │
>>>>>>>
>>>>>>> Yeah, I think Christian wanted to fix this at some point,
>>>>>>
>>>>>> Do you have a pointer that discussion? I could not find it with a
>>>>>> quick search.
>>>>>>
>>>>>>> but it's a
>>>>>>> bit sticky to do.
>>>>>>
>>>>>> Can you say a few words about the nature of the problem?
>>>>>
>>>>> I remembered wrong, it's actually in the tree: 99cdb8b9a573 ("seccomp:
>>>>> notify about unused filter"). So maybe there's a bug here?
>>>>
>>>> That thing only notifies on ->poll, it doesn't unblock ioctls; and
>>>> Michael's sample code uses SECCOMP_IOCTL_NOTIF_RECV to wait. So that
>>>> commit doesn't have any effect on this kind of usage.
>>>
>>> Yes, thanks. And the ones stuck in RECV are waiting on a semaphore so
>>> we don't have a count of all of them, unfortunately.
>>>
>>> We could maybe look inside the wait_list, but that will probably make
>>> people angry :)
>>
>> The easiest way would probably be to open-code the semaphore-ish part,
>> and let the semaphore and poll share the waitqueue. The current code
>> kind of mirrors the semaphore's waitqueue in the wqh - open-coding the
>> entire semaphore would IMO be cleaner than that. And it's not like
>> semaphore semantics are even a good fit for this code anyway.
>>
>> Let's see... if we didn't have the existing UAPI to worry about, I'd
>> do it as follows (*completely* untested). That way, the ioctl would
>> block exactly until either there actually is a request to deliver or
>> there are no more users of the filter. The problem is that if we just
>> apply this patch, existing users of SECCOMP_IOCTL_NOTIF_RECV that use
>> an event loop and don't set O_NONBLOCK will be screwed. So we'd
>> probably also have to add some stupid counter in place of the
>> semaphore's counter that we can use to preserve the old behavior of
>> returning -ENOENT once for each cancelled request. :(
>>
>> I guess this is a nice point in favor of Michael's usual complaint
>> that if there are no man pages for a feature by the time the feature
>> lands upstream, there's a higher chance that the UAPI will suck
>> forever...
> 
> And I guess this would be the UAPI-compatible version - not actually
> as terrible as I thought it might be. Do y'all want this? If so, feel
> free to either turn this into a proper patch with Co-developed-by, or
> tell me that I should do it and I'll try to get around to turning it
> into something proper.

Thanks for taking a shot at this.

I tried applying the patch below to vanilla 5.9.0.
(There's one typo: s/ENOTCON/ENOTCONN).

It seems not to work though; when I send a signal to my test
target process that is sleeping waiting for the notification
response, the process enters the uninterruptible D state.
Any thoughts?

Thanks,

Michael

> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 676d4af62103..d08c453fcc2c 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -138,7 +138,7 @@ struct seccomp_kaddfd {
>   * @notifications: A list of struct seccomp_knotif elements.
>   */
>  struct notification {
> -       struct semaphore request;
> +       bool canceled_reqs;
>         u64 next_id;
>         struct list_head notifications;
>  };
> @@ -859,7 +859,6 @@ static int seccomp_do_user_notification(int this_syscall,
>         list_add(&n.list, &match->notif->notifications);
>         INIT_LIST_HEAD(&n.addfd);
> 
> -       up(&match->notif->request);
>         wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
>         mutex_unlock(&match->notify_lock);
> 
> @@ -901,8 +900,20 @@ static int seccomp_do_user_notification(int this_syscall,
>          * *reattach* to a notifier right now. If one is added, we'll need to
>          * keep track of the notif itself and make sure they match here.
>          */
> -       if (match->notif)
> +       if (match->notif) {
>                 list_del(&n.list);
> +
> +               /*
> +                * We are stuck with a UAPI that requires that after a spurious
> +                * wakeup, SECCOMP_IOCTL_NOTIF_RECV must return immediately.
> +                * This is the tracking for that, keeping track of whether we
> +                * canceled a request after waking waiters, but before userspace
> +                * picked up the notification.
> +                */
> +               if (n.state == SECCOMP_NOTIFY_INIT)
> +                       match->notif->canceled_reqs = true;
> +       }
> +
>  out:
>         mutex_unlock(&match->notify_lock);
> 
> @@ -1178,6 +1189,7 @@ static long seccomp_notify_recv(struct
> seccomp_filter *filter,
>                                 void __user *buf)
>  {
>         struct seccomp_knotif *knotif = NULL, *cur;
> +       DECLARE_WAITQUEUE(wait, current);
>         struct seccomp_notif unotif;
>         ssize_t ret;
> 
> @@ -1190,11 +1202,9 @@ static long seccomp_notify_recv(struct
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
> @@ -1202,14 +1212,32 @@ static long seccomp_notify_recv(struct
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
> +               if (filter->notif->canceled_reqs) {
> +                       ret = -ENOENT;
> +                       goto out;
> +               } else {
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
> +               }
>         }
> 
>         unotif.id = knotif->id;
> @@ -1220,6 +1248,8 @@ static long seccomp_notify_recv(struct
> seccomp_filter *filter,
>         wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
>         ret = 0;
>  out:
> +       filter->notif->canceled_reqs = false;
> +       finish_wait(&filter->wqh, &wait);
>         mutex_unlock(&filter->notify_lock);
> 
>         if (ret == 0 && copy_to_user(buf, &unotif, sizeof(unotif))) {
> @@ -1233,10 +1263,8 @@ static long seccomp_notify_recv(struct
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
> @@ -1485,7 +1513,6 @@ static struct file *init_listener(struct
> seccomp_filter *filter)
>         if (!filter->notif)
>                 goto out;
> 
> -       sema_init(&filter->notif->request, 0);
>         filter->notif->next_id = get_random_u64();
>         INIT_LIST_HEAD(&filter->notif->notifications);
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
