Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5D30CB11
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 20:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhBBTMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 14:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbhBBTGi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 14:06:38 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7536C0617AB
        for <bpf@vger.kernel.org>; Tue,  2 Feb 2021 11:03:00 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l18so3002510pji.3
        for <bpf@vger.kernel.org>; Tue, 02 Feb 2021 11:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NUfGs35qGoHpDrRDAnP7qHs518RtK2f1VxTBTJHOdq8=;
        b=Lu0lr25MFrLnP/clSRYOXtWC7Q8dAP91qw6JExkrMq6K/N5IUH1M+yneUaTO/87SKo
         0oDtFVZMjMRPiN/AgKAbVmQ1DdXRHDc7/GBmXh3tDVUyES0KftfDTW/X+31xMqK0XyJb
         yCgnZ2dvF4RQR7PjTbBURRJzxatmGxcOOjXyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NUfGs35qGoHpDrRDAnP7qHs518RtK2f1VxTBTJHOdq8=;
        b=omfTlJ527bJcYLi17NncSdHSARMR0iB8O54arqLFErlJeJo3+am3QvnkL6XMKjjP81
         L+HfJurUYkkSF/b6rZ+iOSGMKVKCDWp2AFEPpckRAPC6AEmX73NBYMw015pjXe9uUNRP
         PMBJ+yqS12vQrP81rjtFENeJmBXMWCc0wZSwSIhqExa1IvHa/k/nPoxf/gTaMUIjgo+j
         CBNJtMTkxMao4n4tZj5vpYbyNEUq7NDhBSidVeCzTEiVr//oCbTFTSmyOnga/Nq7Nbkp
         wfw49/WoYRIANe0uvfaN7trkwt3eEled002Iq7GOpP4QsMK4y3qpy4iEgrjd2Sqbbl1C
         81pw==
X-Gm-Message-State: AOAM531N12y3gKsRrqC5N8ZcKnM47ifelKiloSlclYqGeyUVQyUAZxKd
        Xx49tN76Bc5cEWD2A6amdzzWUQ==
X-Google-Smtp-Source: ABdhPJwxV+dAKCoa7ZePhj8UecxcgkmmpYe2KqbJ7EyJNZC2OGvKclsFqpV5//1We6WqJR0rXo0hEw==
X-Received: by 2002:a17:90a:5317:: with SMTP id x23mr5762106pjh.154.1612292580130;
        Tue, 02 Feb 2021 11:03:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x3sm23534698pfp.98.2021.02.02.11.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 11:02:59 -0800 (PST)
Date:   Tue, 2 Feb 2021 11:02:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     wanghongzhe <wanghongzhe@huawei.com>
Cc:     luto@amacapital.net, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, wad@chromium.org, yhs@fb.com
Subject: Re: [PATCH v1 1/1] Firstly, as Andy mentioned, this should be
 smp_rmb() instead of rmb(). considering that TSYNC is a cross-thread
 situation, and rmb() is a mandatory barrier which should not be used to
 control SMP effects, since mandatory barriers impose unnecessary overhead on
 both SMP and UP systems, as kernel Documentation said.
Message-ID: <202102021100.DB383A44@keescook>
References: <B1DC6A42-15AF-4804-B20E-FC6E2BDD1C8E@amacapital.net>
 <1612260787-28015-1-git-send-email-wanghongzhe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612260787-28015-1-git-send-email-wanghongzhe@huawei.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 02, 2021 at 06:13:07PM +0800, wanghongzhe wrote:
> Secondly, the smp_rmb() should be put between reading SYSCALL_WORK_SECCOMP and reading
> seccomp.mode, not between reading seccomp.mode and seccomp->filter, to make
> sure that any changes to mode from another thread have been seen after
> SYSCALL_WORK_SECCOMP was seen, as the original comment shown. This issue seems to be
> misintroduced at 13aa72f0fd0a9f98a41cefb662487269e2f1ad65 which aims to
> refactor the filter callback and the API. So the intuitive solution is to put
> it back like:
> 
> Thirdly, however, we can go further to improve the performace of checking
> syscall, considering that smp_rmb is always executed on the syscall-check
> path at each time for both FILTER and STRICT check while the TSYNC case
> which may lead to race condition is just a rare situation, and that in
> some arch like Arm64 smp_rmb is dsb(ishld) not a cheap barrier() in x86-64.
> 
> As a result, smp_rmb() should only be executed when necessary, e.g, it is
> only necessary when current thread's mode is SECCOMP_MODE_DISABLED at the
> first TYSNCed time, because after that the current thread's mode will always
> be SECCOMP_MODE_FILTER (and SYSCALL_WORK_SECCOMP will always be set) and can not be
> changed anymore by anyone. In other words, after that, any thread can not
> change the mode (and SYSCALL_WORK_SECCOMP), so the race condition disappeared, and
> no more smb_rmb() needed ever.
> 
> So the solution is to read mode again behind smp_rmb() after the mode is seen
> as SECCOMP_MODE_DISABLED by current thread at the first TSYNCed time, and if
> the new mode don't equals to SECCOMP_MODE_FILTER, do BUG(), go to FILTER path
> otherwise.
> 
> RFC -> v1:
>  - replace rmb() with smp_rmb()
>  - move the smp_rmb() logic to the middle between SYSCALL_WORK_SECCOMP and mode
> 
> Signed-off-by: wanghongzhe <wanghongzhe@huawei.com>
> Reviewed-by: Andy Lutomirski <luto@amacapital.net>
> ---
>  kernel/seccomp.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 952dc1c90229..a621fb913ec6 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1160,12 +1160,6 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  	int data;
>  	struct seccomp_data sd_local;
>  
> -	/*
> -	 * Make sure that any changes to mode from another thread have
> -	 * been seen after SYSCALL_WORK_SECCOMP was seen.
> -	 */
> -	rmb();
> -
>  	if (!sd) {
>  		populate_seccomp_data(&sd_local);
>  		sd = &sd_local;
> @@ -1289,7 +1283,6 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  
>  int __secure_computing(const struct seccomp_data *sd)
>  {
> -	int mode = current->seccomp.mode;
>  	int this_syscall;
>  
>  	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
> @@ -1299,10 +1292,26 @@ int __secure_computing(const struct seccomp_data *sd)
>  	this_syscall = sd ? sd->nr :
>  		syscall_get_nr(current, current_pt_regs());
>  
> -	switch (mode) {
> +	/*
> +	 * Make sure that any changes to mode from another thread have
> +	 * been seen after SYSCALL_WORK_SECCOMP was seen.
> +	 */
> +	smp_rmb();

Let's start with a patch that just replaces rmb() with smp_rmb() and
then work on optimizing. Can you provide performance numbers that show
rmb() (and soon smp_rmb()) is causing actual problems here?

> +
> +	switch (current->seccomp.mode) {
>  	case SECCOMP_MODE_STRICT:
>  		__secure_computing_strict(this_syscall);  /* may call do_exit */
>  		return 0;
> +	/*
> +	 * Make sure that change to mode (from SECCOMP_MODE_DISABLED to
> +	 * SECCOMP_MODE_FILTER) from another thread using TSYNC ability
> +	 * have been seen after SYSCALL_WORK_SECCOMP was seen. Read mode again behind
> +	 * smp_rmb(), if it equals SECCOMP_MODE_FILTER, go to the right path.
> +	 */
> +	case SECCOMP_MODE_DISABLED:
> +		smp_rmb();
> +		if (unlikely(current->seccomp.mode != SECCOMP_MODE_FILTER))
> +			BUG();

BUG() should never be used[1]. This is a recoverable situation, I think, and
should be handled as such.

-Kees

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

>  	case SECCOMP_MODE_FILTER:
>  		return __seccomp_filter(this_syscall, sd, false);
>  	default:
> -- 
> 2.19.1
> 

-- 
Kees Cook
