Return-Path: <bpf+bounces-28099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E538B5A94
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787D71F20F60
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801FC757E5;
	Mon, 29 Apr 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi7Xwlvi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F565657D4;
	Mon, 29 Apr 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398714; cv=none; b=B1vrqlx7B60AChN0PsLDoXLj+Vu7acyTfd6D58DjNjy82T/YKksasEdyWgfIT2WNNE4+8iFRw3y3WvnEPt5JRjAVgzQHhTqaZLgeDxoZ+ZWLjLO2jXU9RGA8GCYiBeOYdQh5CYA9u85qg7S84uFondp/aqZuDNjspmxdSqC+bNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398714; c=relaxed/simple;
	bh=e49NOt2GVVU+FTbdBwqIZXJOMOkE6tmLHI8TTI3eSTE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmXaJ7GwXZYxSxElAtwUclzac5gKLmDcPfHTZQWL0h0Ij/xex0l2ql6nX43ZeKHB9bSwvv8KR+3uIYSMGbvrnbBbBujYwCOXwFR4Yu3DbXvvhnWIoKvGe6Cf0rAnI7xyuNQnwbAs9uyYu71OeFMtHkFmk6P4ZCMQ9UlGPAQrZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi7Xwlvi; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so6956851a12.2;
        Mon, 29 Apr 2024 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714398710; x=1715003510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WYX0X6pbfizvC4oo2kjnxKoSIPTNaayha5yZW/AwVEU=;
        b=Oi7XwlviBnxZOrXDFCAUTQTsBeF/3ft7ZswRwidczjTcCERmRiGt0WKRaNsbDm/9MD
         82ChuVYxZwG6GjtHEY6SVmkI9Vj0A6reVHStf3rkmjtiYgqaG3i1cmX6cL1AO3yFMTok
         gIAQbxUzF1wW7bwf2ZJACem/FTJJnNfsjh0Lwhlf79/dasFeXImTqhLOsNlLJENV0P8B
         j9pYeYVyRGz2pTdQtf4ZmwbX3OUM4oRguX0rgf0DIfenxkW1gFP0Czn3kXv7O2Ek2B9e
         FFfBmzQIsn7DsWj5Gmv5w2Jmd0CkWEVFWG7W7aep/OCXBbm6aJdzPkT5Y8PIUNdHeMWC
         llrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398710; x=1715003510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYX0X6pbfizvC4oo2kjnxKoSIPTNaayha5yZW/AwVEU=;
        b=U1Sst1mhfQ/cJHluy6tJpkcJurQt8gZzJo5kjS6Ze7Eeazv/GH6LdoA9f6uZ/8Uoot
         yUHAxsmEcSilAiqabSKsFteK4CPTQCQPnx84drjGMy7iYodZ2WqitStjVIrdgB+HgAik
         rvT8qg4Kxej8yu85KgNx9UXTyrs2IoMLscnUm88eSmjm/Z1Advm4nz77ktknH6ojzC1k
         EW8rByBFOGUaASsA5k5tI1lLxhiacaYh78gMu8yug/5B3Za6LyX38OWVi076FlAosdlG
         Wp/5c+DiWz+MPFunvwMNBOc3qzjxUHsPYrVBTKtTPB7gBXmcZtxhP9hPr6zAHQpqL14Y
         NnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnSaXhMkAjR65POA7MgNX40cuZb/B8+eR74ic003f4leaPRMnkF29vyxALLAyfSN7qoPfUtk2nEfJB5xHTFJAyFay2JShqiEzo4ACAcCNgTIIQiVXTzBleBS+sFpsaQ0n9
X-Gm-Message-State: AOJu0YyrbGwslOLoHr56SGJV3zXH4uSjCqAiEYieMN4f7hqPREiCQylc
	VocBffC+KM/igLfqA5fmK6/JU1OXLdkWFZVS06IJHGIxr6e2us/E
X-Google-Smtp-Source: AGHT+IGMIjFVUQLQ3SYJFBmyCh6Th4YjbgO+QtQAMEV1CdaGAPtjurOXaW/PI9GDqdTNVOZ3Eq0X2A==
X-Received: by 2002:a50:8e5e:0:b0:570:5b3d:4f60 with SMTP id 30-20020a508e5e000000b005705b3d4f60mr8003113edx.25.1714398710224;
        Mon, 29 Apr 2024 06:51:50 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id y20-20020a056402271400b00572300f0768sm6019931edd.79.2024.04.29.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:51:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 Apr 2024 15:51:47 +0200
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Andy Lutomirski <luto@amacapital.net>, Peter Anvin <hpa@zytor.com>,
	Adrian Bunk <bunk@kernel.org>,
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	andrii@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
Message-ID: <Zi-l8xKhMbdJ-NBo@krava>
References: <0000000000009dfa6d0617197994@google.com>
 <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com>
 <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
 <Zi9Ts1HcqiKzy9GX@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi9Ts1HcqiKzy9GX@gmail.com>

On Mon, Apr 29, 2024 at 10:00:51AM +0200, Ingo Molnar wrote:

SNIP

> The attached patch looks like the ObviouslyCorrect(tm) thing to do.
> 
> NOTE! This broken code goes back to this commit in 2011:
> 
>   4fc3490114bb ("x86-64: Set siginfo and context on vsyscall emulation faults")
> 
> ... and back then the reason was to get all the siginfo details right. 
> Honestly, I do not for a moment believe that it's worth getting the siginfo 
> details right here, but part of the commit says:
> 
>     This fixes issues with UML when vsyscall=emulate.
> 
> ... and so my patch to remove this garbage will probably break UML in this 
> situation.
> 
> I do not believe that anybody should be running with vsyscall=emulate in 
> 2024 in the first place, much less if you are doing things like UML. But 
> let's see if somebody screams.
> 
> Not-Yet-Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com

fwiw I can no longer trigger the invalid wait context bug
with this change

Tested-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  arch/x86/entry/vsyscall/vsyscall_64.c | 25 ++-----------------------
>  arch/x86/include/asm/processor.h      |  1 -
>  arch/x86/mm/fault.c                   | 33 +--------------------------------
>  3 files changed, 3 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index a3c0df11d0e6..3b0f61b2ea6d 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -98,11 +98,6 @@ static int addr_to_vsyscall_nr(unsigned long addr)
>  
>  static bool write_ok_or_segv(unsigned long ptr, size_t size)
>  {
> -	/*
> -	 * XXX: if access_ok, get_user, and put_user handled
> -	 * sig_on_uaccess_err, this could go away.
> -	 */
> -
>  	if (!access_ok((void __user *)ptr, size)) {
>  		struct thread_struct *thread = &current->thread;
>  
> @@ -123,7 +118,6 @@ bool emulate_vsyscall(unsigned long error_code,
>  	struct task_struct *tsk;
>  	unsigned long caller;
>  	int vsyscall_nr, syscall_nr, tmp;
> -	int prev_sig_on_uaccess_err;
>  	long ret;
>  	unsigned long orig_dx;
>  
> @@ -234,12 +228,8 @@ bool emulate_vsyscall(unsigned long error_code,
>  		goto do_ret;  /* skip requested */
>  
>  	/*
> -	 * With a real vsyscall, page faults cause SIGSEGV.  We want to
> -	 * preserve that behavior to make writing exploits harder.
> +	 * With a real vsyscall, page faults cause SIGSEGV.
>  	 */
> -	prev_sig_on_uaccess_err = current->thread.sig_on_uaccess_err;
> -	current->thread.sig_on_uaccess_err = 1;
> -
>  	ret = -EFAULT;
>  	switch (vsyscall_nr) {
>  	case 0:
> @@ -262,23 +252,12 @@ bool emulate_vsyscall(unsigned long error_code,
>  		break;
>  	}
>  
> -	current->thread.sig_on_uaccess_err = prev_sig_on_uaccess_err;
> -
>  check_fault:
>  	if (ret == -EFAULT) {
>  		/* Bad news -- userspace fed a bad pointer to a vsyscall. */
>  		warn_bad_vsyscall(KERN_INFO, regs,
>  				  "vsyscall fault (exploit attempt?)");
> -
> -		/*
> -		 * If we failed to generate a signal for any reason,
> -		 * generate one here.  (This should be impossible.)
> -		 */
> -		if (WARN_ON_ONCE(!sigismember(&tsk->pending.signal, SIGBUS) &&
> -				 !sigismember(&tsk->pending.signal, SIGSEGV)))
> -			goto sigsegv;
> -
> -		return true;  /* Don't emulate the ret. */
> +		goto sigsegv;
>  	}
>  
>  	regs->ax = ret;
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 811548f131f4..78e51b0d6433 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -472,7 +472,6 @@ struct thread_struct {
>  	unsigned long		iopl_emul;
>  
>  	unsigned int		iopl_warn:1;
> -	unsigned int		sig_on_uaccess_err:1;
>  
>  	/*
>  	 * Protection Keys Register for Userspace.  Loaded immediately on
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 6b2ca8ba75b8..f26ecabc9424 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -724,39 +724,8 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
>  	WARN_ON_ONCE(user_mode(regs));
>  
>  	/* Are we prepared to handle this kernel fault? */
> -	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
> -		/*
> -		 * Any interrupt that takes a fault gets the fixup. This makes
> -		 * the below recursive fault logic only apply to a faults from
> -		 * task context.
> -		 */
> -		if (in_interrupt())
> -			return;
> -
> -		/*
> -		 * Per the above we're !in_interrupt(), aka. task context.
> -		 *
> -		 * In this case we need to make sure we're not recursively
> -		 * faulting through the emulate_vsyscall() logic.
> -		 */
> -		if (current->thread.sig_on_uaccess_err && signal) {
> -			sanitize_error_code(address, &error_code);
> -
> -			set_signal_archinfo(address, error_code);
> -
> -			if (si_code == SEGV_PKUERR) {
> -				force_sig_pkuerr((void __user *)address, pkey);
> -			} else {
> -				/* XXX: hwpoison faults will set the wrong code. */
> -				force_sig_fault(signal, si_code, (void __user *)address);
> -			}
> -		}
> -
> -		/*
> -		 * Barring that, we can do the fixup and be happy.
> -		 */
> +	if (fixup_exception(regs, X86_TRAP_PF, error_code, address))
>  		return;
> -	}
>  
>  	/*
>  	 * AMD erratum #91 manifests as a spurious page fault on a PREFETCH
> 

