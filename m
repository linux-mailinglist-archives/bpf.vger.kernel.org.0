Return-Path: <bpf+bounces-28064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609798B52C6
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 10:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD4E1C21103
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E0515E90;
	Mon, 29 Apr 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRHy/cCA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09814A8D;
	Mon, 29 Apr 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377659; cv=none; b=H17bLcYpkh11/CMrF/c96NtP811fw546asOGYYi9OcIenpqjYbW1jibDDJ13REc1eQm0ghZC9NwRVrn4COuZCDQyW4wrISlwno2U06QPmpMXe9mYgp29FykpZEuc+Ww/EW4IoGCnPcyhpGtmabttalXYJokeHW8lFHCPQgqcGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377659; c=relaxed/simple;
	bh=XPeJX+Fp9+O76h6hmQ5WiXULYABz5dq/6CK9CQDq5DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5L6MSaYzoeRLWVuyT0XKVDMA8+6QjJy40CF63YpfaxsAord/C5YlB8qlC/grvYNTSyyw9OvUP69Eg0FxQcuIdENlGuOTS9hmkHBqybAzE1LJS6+awkVBJL2qsFZN7COgxYXdp8/IskTYorK5Z4A/WR9/HHbsVpuA5UoA8ofOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRHy/cCA; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5176f217b7bso6939396e87.0;
        Mon, 29 Apr 2024 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714377655; x=1714982455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+j62qIUnszPg6Zk+bFKXpqij8+kdOVWoS/e1ryACzWU=;
        b=HRHy/cCAhhz6Wid6O/Eg4d7gGUFVZsL9SBzKJIPKE2sdXdo7CGkCobGmclg8Oa1sX5
         I4kCqKWM8IpjRrwvLHhbWnlIRNcZ7QB7HfBFMjGbHgMJAYlLcPoPOK7wnSrw+ccDM0KO
         gAXGs7QhIwZvTiGdqJhCgITVHJqcghD26y7geo2CfQE6YsrNC+Y2zVBsJy6Ju/GQSiwn
         cwU9DM95GaF5VJ4PdwPLyzqP4H3/ENguK+PHetDWvHTt9Q6Y5IAE4oBbNq7tcGr+lmxw
         GkGx7o0RGLweqPuT/O5zwjOSLgxb/OCRw3jsbejJ2pdTHVF5CHDJeg+YzApvM9csymUe
         Yjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714377655; x=1714982455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+j62qIUnszPg6Zk+bFKXpqij8+kdOVWoS/e1ryACzWU=;
        b=XbNR+1Mg5lwNT3Ja2V1xlY/rmU/eBgCesUZ/+WXW6ur5CRV0qMuUk9Pv81riq44zEL
         2ryyBRPkYyQhgQhuHeR7jMo+u260Mb+Lw/UhLQ+TPA5qLXg2UEXXNvRR96qvXCsEEGrE
         by57sXgoUMHTlNpT9RUHgweI9jw8SfcO2NbaQLs0H736dJYDG0wr0P3SoCZnghuz2v0w
         q1+tCaDySBeEJ1W3HvBMwkucqvH+I5lw/2x8MwqRE4EUjaxWD/iqF/xYnLIk0HkLmcY9
         jBXT6H3zlAoGAN/swQW09PX85Bxw503xkh7/LQ+F7TYlcfzM+ZIHWxurnQdAuPoYnKxG
         t/bA==
X-Forwarded-Encrypted: i=1; AJvYcCW96ra4QIr7/LTH8YjtFB3YP57rRXL+veScNwEhwSUL8PMqn0Xb7cGKCLIigowFFzRDfYUVkr1aqarnGcOPRyxb7gZrKZtnbhbcSnz6eqSYKUaINaPfxN3ETRisSMibIa6l
X-Gm-Message-State: AOJu0YwOEFo0nGG33vbEGi0YbqUCuLgN6/kX1mIAjbuRsqx5WGUikZBP
	02FGh45LV5f/F3Hd0AVw4xOd8G6ZLyrF5EKM5M5xcVk8g8Klz+iF
X-Google-Smtp-Source: AGHT+IGAwxjD9GjWfv3PN4b7ZYgQnCy/zm7JieZYZQCwuzh/QbGl4ZnRHzYHuisGZMCptSe7ycUYuQ==
X-Received: by 2002:a05:6512:baa:b0:51d:d630:365c with SMTP id b42-20020a0565120baa00b0051dd630365cmr1231462lfv.4.1714377654950;
        Mon, 29 Apr 2024 01:00:54 -0700 (PDT)
Received: from gmail.com (1F2EF175.nat.pool.telekom.hu. [31.46.241.117])
        by smtp.gmail.com with ESMTPSA id fw5-20020a170906c94500b00a5908cb01b4sm345991ejb.17.2024.04.29.01.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 01:00:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 29 Apr 2024 10:00:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hillf Danton <hdanton@sina.com>, Andy Lutomirski <luto@amacapital.net>,
	Peter Anvin <hpa@zytor.com>, Adrian Bunk <bunk@kernel.org>,
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	andrii@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] x86/mm: Remove broken vsyscall emulation code from the page
 fault code
Message-ID: <Zi9Ts1HcqiKzy9GX@gmail.com>
References: <0000000000009dfa6d0617197994@google.com>
 <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com>
 <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The attached patch is ENTIRELY UNTESTED, but looks like the
> ObviouslyCorrect(tm) thing to do.
> 
> NOTE! This broken code goes back to commit 4fc3490114bb ("x86-64: Set
> siginfo and context on vsyscall emulation faults") in 2011, and back
> then the reason was to get all the siginfo details right. Honestly, I
> do not for a moment believe that it's worth getting the siginfo
> details right here, but part of the commit says
> 
>     This fixes issues with UML when vsyscall=emulate.
> 
> and so my patch to remove this garbage will probably break UML in this
> situation.
> 
> I cannot find it in myself to care, since I do not believe that
> anybody should be running with vsyscall=emulate in 2024 in the first
> place, much less if you are doing things like UML. But let's see if
> somebody screams.
> 
> Also, somebody should obviously test my COMPLETELY UNTESTED patch.
>
> Did I make it clear enough that this is UNTESTED and just does
> crapectgomy on something that is clearly broken?
> 
>            Linus "UNTESTED" Torvalds

I did some Simple Testing™, and nothing seemed to break in any way visible 
to me, and the diffstat is lovely:

    3 files changed, 3 insertions(+), 56 deletions(-)

Might stick this into tip:x86/mm and see what happens?

I'd love to remove the rest of the vsyscall emulation code as well. I don't 
think anyone cares about vsyscall emulation anymore (let alone in an UML 
context), IIRC it requires ancient glibc I don't think we even support 
anymore (but I'm unsure about the exact version cutoff).

I created a changelog from your email, editing parts of it, and added your 
Net-Yet-Signed-off-by tag.

Thanks,

	Ingo

===================================>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 18:33:41 -0700
Subject: [PATCH] x86/mm: Remove broken vsyscall emulation code from the page fault code

The syzbot-reported stack trace from hell in this discussion thread
actually has three nested page faults:

  https://lore.kernel.org/r/000000000000d5f4fc0616e816d4@google.com

... and I think that's actually the important thing here:

 - the first page fault is from user space, and triggers the vsyscall 
   emulation.

 - the second page fault is from __do_sys_gettimeofday(), and that should 
   just have caused the exception that then sets the return value to 
   -EFAULT

 - the third nested page fault is due to _raw_spin_unlock_irqrestore() -> 
   preempt_schedule() -> trace_sched_switch(), which then causes a BPF 
   trace program to run, which does that bpf_probe_read_compat(), which 
   causes that page fault under pagefault_disable().

It's quite the nasty backtrace, and there's a lot going on.

The problem is literally the vsyscall emulation, which sets

        current->thread.sig_on_uaccess_err = 1;

and that causes the fixup_exception() code to send the signal *despite* the 
exception being caught.

And I think that is in fact completely bogus.  It's completely bogus 
exactly because it sends that signal even when it *shouldn't* be sent - 
like for the BPF user mode trace gathering.

In other words, I think the whole "sig_on_uaccess_err" thing is entirely 
broken, because it makes any nested page-faults do all the wrong things.

Now, arguably, I don't think anybody should enable vsyscall emulation any 
more, but this test case clearly does.

I think we should just make the "send SIGSEGV" be something that the 
vsyscall emulation does on its own, not this broken per-thread state for 
something that isn't actually per thread.

The x86 page fault code actually tried to deal with the "incorrect nesting" 
by having that:

                if (in_interrupt())
                        return;

which ignores the sig_on_uaccess_err case when it happens in interrupts, 
but as shown by this example, these nested page faults do not need to be 
about interrupts at all.

IOW, I think the only right thing is to remove that horrendously broken 
code.

The attached patch looks like the ObviouslyCorrect(tm) thing to do.

NOTE! This broken code goes back to this commit in 2011:

  4fc3490114bb ("x86-64: Set siginfo and context on vsyscall emulation faults")

... and back then the reason was to get all the siginfo details right. 
Honestly, I do not for a moment believe that it's worth getting the siginfo 
details right here, but part of the commit says:

    This fixes issues with UML when vsyscall=emulate.

... and so my patch to remove this garbage will probably break UML in this 
situation.

I do not believe that anybody should be running with vsyscall=emulate in 
2024 in the first place, much less if you are doing things like UML. But 
let's see if somebody screams.

Not-Yet-Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 25 ++-----------------------
 arch/x86/include/asm/processor.h      |  1 -
 arch/x86/mm/fault.c                   | 33 +--------------------------------
 3 files changed, 3 insertions(+), 56 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index a3c0df11d0e6..3b0f61b2ea6d 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -98,11 +98,6 @@ static int addr_to_vsyscall_nr(unsigned long addr)
 
 static bool write_ok_or_segv(unsigned long ptr, size_t size)
 {
-	/*
-	 * XXX: if access_ok, get_user, and put_user handled
-	 * sig_on_uaccess_err, this could go away.
-	 */
-
 	if (!access_ok((void __user *)ptr, size)) {
 		struct thread_struct *thread = &current->thread;
 
@@ -123,7 +118,6 @@ bool emulate_vsyscall(unsigned long error_code,
 	struct task_struct *tsk;
 	unsigned long caller;
 	int vsyscall_nr, syscall_nr, tmp;
-	int prev_sig_on_uaccess_err;
 	long ret;
 	unsigned long orig_dx;
 
@@ -234,12 +228,8 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto do_ret;  /* skip requested */
 
 	/*
-	 * With a real vsyscall, page faults cause SIGSEGV.  We want to
-	 * preserve that behavior to make writing exploits harder.
+	 * With a real vsyscall, page faults cause SIGSEGV.
 	 */
-	prev_sig_on_uaccess_err = current->thread.sig_on_uaccess_err;
-	current->thread.sig_on_uaccess_err = 1;
-
 	ret = -EFAULT;
 	switch (vsyscall_nr) {
 	case 0:
@@ -262,23 +252,12 @@ bool emulate_vsyscall(unsigned long error_code,
 		break;
 	}
 
-	current->thread.sig_on_uaccess_err = prev_sig_on_uaccess_err;
-
 check_fault:
 	if (ret == -EFAULT) {
 		/* Bad news -- userspace fed a bad pointer to a vsyscall. */
 		warn_bad_vsyscall(KERN_INFO, regs,
 				  "vsyscall fault (exploit attempt?)");
-
-		/*
-		 * If we failed to generate a signal for any reason,
-		 * generate one here.  (This should be impossible.)
-		 */
-		if (WARN_ON_ONCE(!sigismember(&tsk->pending.signal, SIGBUS) &&
-				 !sigismember(&tsk->pending.signal, SIGSEGV)))
-			goto sigsegv;
-
-		return true;  /* Don't emulate the ret. */
+		goto sigsegv;
 	}
 
 	regs->ax = ret;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f131f4..78e51b0d6433 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -472,7 +472,6 @@ struct thread_struct {
 	unsigned long		iopl_emul;
 
 	unsigned int		iopl_warn:1;
-	unsigned int		sig_on_uaccess_err:1;
 
 	/*
 	 * Protection Keys Register for Userspace.  Loaded immediately on
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6b2ca8ba75b8..f26ecabc9424 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -724,39 +724,8 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 	WARN_ON_ONCE(user_mode(regs));
 
 	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
-		/*
-		 * Any interrupt that takes a fault gets the fixup. This makes
-		 * the below recursive fault logic only apply to a faults from
-		 * task context.
-		 */
-		if (in_interrupt())
-			return;
-
-		/*
-		 * Per the above we're !in_interrupt(), aka. task context.
-		 *
-		 * In this case we need to make sure we're not recursively
-		 * faulting through the emulate_vsyscall() logic.
-		 */
-		if (current->thread.sig_on_uaccess_err && signal) {
-			sanitize_error_code(address, &error_code);
-
-			set_signal_archinfo(address, error_code);
-
-			if (si_code == SEGV_PKUERR) {
-				force_sig_pkuerr((void __user *)address, pkey);
-			} else {
-				/* XXX: hwpoison faults will set the wrong code. */
-				force_sig_fault(signal, si_code, (void __user *)address);
-			}
-		}
-
-		/*
-		 * Barring that, we can do the fixup and be happy.
-		 */
+	if (fixup_exception(regs, X86_TRAP_PF, error_code, address))
 		return;
-	}
 
 	/*
 	 * AMD erratum #91 manifests as a spurious page fault on a PREFETCH

