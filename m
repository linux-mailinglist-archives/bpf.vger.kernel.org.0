Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0832804E2
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 19:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbgJARMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 13:12:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53001 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732871AbgJARMN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 13:12:13 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@canonical.com>)
        id 1kO27m-00081s-FG
        for bpf@vger.kernel.org; Thu, 01 Oct 2020 17:12:10 +0000
Received: by mail-ed1-f71.google.com with SMTP id j1so2460960edv.7
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 10:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R1wJmFfDlNS2ZK16MyLmhBE/huODDJnjpuBQkOKkIq0=;
        b=udare7ZHHUs3nABk2Dm/3G+AowelF2AdYawcmicKNT2UT4BCIdtYJJC3Fdq/qGSzuP
         2uNrRUdK/T1jOZKv0PkffEZIXx55tujU35/vEPgyDHsTeyeCqaiilOqdDuryL0HIeqaq
         yyGnQ40yL7jleaU9pGDaKq6eRXAeK8r7vZ/4ujEaj7w/LQ+X+oXxAowcJlKkdz3IBURl
         lWlQ9FJT1vdAxOORNiqZ4oN5HvqK41Q2YEMTXG3ZI8sYbHqFTSXIHGTDtdv+c/JE0O3A
         sdvB6JgqBbswnkuOdn8/R5kkk9V4xZaeh/UU7yyGh5Ko8QK5LDGCI8VpGzPGIYesmw9f
         1G2A==
X-Gm-Message-State: AOAM531n2kSqkWnarrFgogeJzPR/bkBFNliw7UkH8eemORLVv29glyIa
        G8WFmnXExY1WzabaTH4H5Hf7XBNGza1zN2zlptTOfAdShWHiue5L2Qdu0YVevshofGxZgjC2+WN
        xVdRDth9ZcHDuVEKsD8czlGk5frUCGQ==
X-Received: by 2002:a17:906:b74a:: with SMTP id fx10mr8883934ejb.232.1601572329842;
        Thu, 01 Oct 2020 10:12:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4vHLdiKnihkbjdlGKbr1buFcgisWIoA1Dsbv/iU/iTwRqIjmoZt3gmk1xWndAA0SxTZa58g==
X-Received: by 2002:a17:906:b74a:: with SMTP id fx10mr8883899ejb.232.1601572329483;
        Thu, 01 Oct 2020 10:12:09 -0700 (PDT)
Received: from gmail.com ([176.32.19.8])
        by smtp.gmail.com with ESMTPSA id d24sm4644094edp.17.2020.10.01.10.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:12:08 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:12:06 +0200
From:   Christian Brauner <christian.brauner@canonical.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Jann Horn <jannh@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>
Subject: Re: For review: seccomp_user_notif(2) manual page
Message-ID: <20201001171206.jvkdx4htqux5agdv@gmail.com>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
 <20201001125043.dj6taeieatpw3a4w@gmail.com>
 <CAG48ez2U1K2XYZu6goRYwmQ-RSu7LkKSOhPt8_wPVEUQfm7Eeg@mail.gmail.com>
 <20201001165850.GC1260245@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001165850.GC1260245@cisco>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 01, 2020 at 10:58:50AM -0600, Tycho Andersen wrote:
> On Thu, Oct 01, 2020 at 05:47:54PM +0200, Jann Horn via Containers wrote:
> > On Thu, Oct 1, 2020 at 2:54 PM Christian Brauner
> > <christian.brauner@canonical.com> wrote:
> > > On Wed, Sep 30, 2020 at 05:53:46PM +0200, Jann Horn via Containers wrote:
> > > > On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
> > > > <mtk.manpages@gmail.com> wrote:
> > > > > NOTES
> > > > >        The file descriptor returned when seccomp(2) is employed with the
> > > > >        SECCOMP_FILTER_FLAG_NEW_LISTENER  flag  can  be  monitored  using
> > > > >        poll(2), epoll(7), and select(2).  When a notification  is  pend‐
> > > > >        ing,  these interfaces indicate that the file descriptor is read‐
> > > > >        able.
> > > >
> > > > We should probably also point out somewhere that, as
> > > > include/uapi/linux/seccomp.h says:
> > > >
> > > >  * Similar precautions should be applied when stacking SECCOMP_RET_USER_NOTIF
> > > >  * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting on the
> > > >  * same syscall, the most recently added filter takes precedence. This means
> > > >  * that the new SECCOMP_RET_USER_NOTIF filter can override any
> > > >  * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allowing all
> > > >  * such filtered syscalls to be executed by sending the response
> > > >  * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_TRACE can equally
> > > >  * be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.
> > > >
> > > > In other words, from a security perspective, you must assume that the
> > > > target process can bypass any SECCOMP_RET_USER_NOTIF (or
> > > > SECCOMP_RET_TRACE) filters unless it is completely prohibited from
> > > > calling seccomp(). This should also be noted over in the main
> > > > seccomp(2) manpage, especially the SECCOMP_RET_TRACE part.
> > >
> > > So I was actually wondering about this when I skimmed this and a while
> > > ago but forgot about this again... Afaict, you can only ever load a
> > > single filter with SECCOMP_FILTER_FLAG_NEW_LISTENER set. If there
> > > already is a filter with the SECCOMP_FILTER_FLAG_NEW_LISTENER property
> > > in the tasks filter hierarchy then the kernel will refuse to load a new
> > > one?
> > >
> > > static struct file *init_listener(struct seccomp_filter *filter)
> > > {
> > >         struct file *ret = ERR_PTR(-EBUSY);
> > >         struct seccomp_filter *cur;
> > >
> > >         for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> > >                 if (cur->notif)
> > >                         goto out;
> > >         }
> > >
> > > shouldn't that be sufficient to guarantee that USER_NOTIF filters can't
> > > override each other for the same task simply because there can only ever
> > > be a single one?
> > 
> > Good point. Exceeeept that that check seems ineffective because this
> > happens before we take the locks that guard against TSYNC, and also
> > before we decide to which existing filter we want to chain the new
> > filter. So if two threads race with TSYNC, I think they'll be able to
> > chain two filters with listeners together.
> 
> Yep, seems the check needs to also be in seccomp_can_sync_threads() to
> be totally effective,
> 
> > I don't know whether we want to eternalize this "only one listener
> > across all the filters" restriction in the manpage though, or whether
> > the man page should just say that the kernel currently doesn't support
> > it but that security-wise you should assume that it might at some
> > point.
> 
> This requirement originally came from Andy, arguing that the semantics
> of this were/are confusing, which still makes sense to me. Perhaps we
> should do something like the below?

I think we should either keep up this restriction and then cement it in
the manpage or add a flag to indicate that the notifier is
non-overridable.
I don't care about the default too much, i.e. whether it's overridable
by default and exclusive if opting in or the other way around doesn't
matter too much. But from a supervisor's perspective it'd be quite nice
to be able to be sure that a notifier can't be overriden by another
notifier.

I think having a flag would provide the greatest flexibility but I agree
that the semantics of multiple listeners are kinda odd.

Below looks sane to me though again, I'm not sitting in fron of source
code.

Christian

> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 3ee59ce0a323..7b107207c2b0 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -376,6 +376,18 @@ static int is_ancestor(struct seccomp_filter *parent,
>  	return 0;
>  }
>  
> +static bool has_listener_parent(struct seccomp_filter *child)
> +{
> +	struct seccomp_filter *cur;
> +
> +	for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> +		if (cur->notif)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /**
>   * seccomp_can_sync_threads: checks if all threads can be synchronized
>   *
> @@ -385,7 +397,7 @@ static int is_ancestor(struct seccomp_filter *parent,
>   * either not in the correct seccomp mode or did not have an ancestral
>   * seccomp filter.
>   */
> -static inline pid_t seccomp_can_sync_threads(void)
> +static inline pid_t seccomp_can_sync_threads(unsigned int flags)
>  {
>  	struct task_struct *thread, *caller;
>  
> @@ -407,6 +419,11 @@ static inline pid_t seccomp_can_sync_threads(void)
>  				 caller->seccomp.filter)))
>  			continue;
>  
> +		/* don't allow TSYNC to install multiple listeners */
> +		if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER &&
> +		    !has_listener_parent(thread->seccomp.filter))
> +			continue;
> +
>  		/* Return the first thread that cannot be synchronized. */
>  		failed = task_pid_vnr(thread);
>  		/* If the pid cannot be resolved, then return -ESRCH */
> @@ -637,7 +654,7 @@ static long seccomp_attach_filter(unsigned int flags,
>  	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
>  		int ret;
>  
> -		ret = seccomp_can_sync_threads();
> +		ret = seccomp_can_sync_threads(flags);
>  		if (ret) {
>  			if (flags & SECCOMP_FILTER_FLAG_TSYNC_ESRCH)
>  				return -ESRCH;
> @@ -1462,12 +1479,9 @@ static const struct file_operations seccomp_notify_ops = {
>  static struct file *init_listener(struct seccomp_filter *filter)
>  {
>  	struct file *ret = ERR_PTR(-EBUSY);
> -	struct seccomp_filter *cur;
>  
> -	for (cur = current->seccomp.filter; cur; cur = cur->prev) {
> -		if (cur->notif)
> -			goto out;
> -	}
> +	if (has_listener_parent(current->seccomp.filter))
> +		goto out;
>  
>  	ret = ERR_PTR(-ENOMEM);
>  	filter->notif = kzalloc(sizeof(*(filter->notif)), GFP_KERNEL);
