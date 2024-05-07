Return-Path: <bpf+bounces-28987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC5F8BF263
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 01:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94567285098
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1811C8FC9;
	Tue,  7 May 2024 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8AzfSeB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90828139D16;
	Tue,  7 May 2024 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123595; cv=none; b=aseURWuVorkqT0tocuYSFc/lYsBe06p9EF3nYQeuDNRL1KZnLFbLxX/1aV+ZnAbHZMWTjmetK6DsWQmfLGD3pHPpFMrk2vHiU+j6jjGDC5IpgEH6OE3vOi5RAog7WgO3FQ/USOloPU7Eci4DWbTSijnin2BDlJu+7QyjyoVRsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123595; c=relaxed/simple;
	bh=Zpc25XZiv6MhNUzAJdH/DyOn/hx46bbrTRVDiHKwGUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyTWGtu1Rbfet/ixvRTdd3u/JXP+jiSY04+Iu/rGI2D2pkWz/e04VYr81ZBA8NJ2EG3ZeJ6G3IUiRNi/PlbVCCV9lrWoRhdY2wHMjcGP1QAwUErwawQhPLM6dx9K4AGRCoh4AJvIoEk0ah33I7PLG8DdcfU0BLG2hoLLA6VwHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8AzfSeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C0CC3277B;
	Tue,  7 May 2024 23:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123595;
	bh=Zpc25XZiv6MhNUzAJdH/DyOn/hx46bbrTRVDiHKwGUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e8AzfSeBoDgFH5dH2hxEH0/w61Rk4rTK6p632p4NZt5dMAURka1arQ11kFokwp7Z1
	 Y/X/l8UhSUOfqhUMW+P7bz1qWmJcuA64c8ZI6gFqffyTUPKFR1qDqui7o2lMA8lfCd
	 j0B7kl160XHH1YGHP6X7bnYFQIZDf6/l6EgMBNk7uGFUWfefQ3xv7gubKGSQH2b4UG
	 kFIRxwktZOMRMn1LyNUfeVBIuBA09r/oxRqSwsJLDeCM+efNnrSP4HX4nfDWYYcskj
	 gNXiDQfB0h74pPsPYmE36ETYMuRJC2wJsz47t2yGLQQHo2mRLBeZuFTAgM1eE0jkdp
	 MTfNHEoS28+lQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	peterz@infradead.org,
	xin3.li@intel.com,
	ubizjak@gmail.com,
	rick.p.edgecombe@intel.com,
	arnd@arndb.de,
	mjguzik@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 19/25] x86/mm: Remove broken vsyscall emulation code from the page fault code
Date: Tue,  7 May 2024 19:12:06 -0400
Message-ID: <20240507231231.394219-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 02b670c1f88e78f42a6c5aee155c7b26960ca054 ]

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

Reported-and-tested-by: syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 28 ++---------------------
 arch/x86/include/asm/processor.h      |  1 -
 arch/x86/mm/fault.c                   | 33 +--------------------------
 3 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 4af81df133ee8..5d4ca8b942939 100644
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
 
@@ -120,10 +115,8 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 bool emulate_vsyscall(unsigned long error_code,
 		      struct pt_regs *regs, unsigned long address)
 {
-	struct task_struct *tsk;
 	unsigned long caller;
 	int vsyscall_nr, syscall_nr, tmp;
-	int prev_sig_on_uaccess_err;
 	long ret;
 	unsigned long orig_dx;
 
@@ -172,8 +165,6 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto sigsegv;
 	}
 
-	tsk = current;
-
 	/*
 	 * Check for access_ok violations and find the syscall nr.
 	 *
@@ -234,12 +225,8 @@ bool emulate_vsyscall(unsigned long error_code,
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
@@ -262,23 +249,12 @@ bool emulate_vsyscall(unsigned long error_code,
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
index 94ea13adb724a..3ed6cc7785037 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -519,7 +519,6 @@ struct thread_struct {
 	unsigned long		iopl_emul;
 
 	unsigned int		iopl_warn:1;
-	unsigned int		sig_on_uaccess_err:1;
 
 	/*
 	 * Protection Keys Register for Userspace.  Loaded immediately on
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f20636510eb1e..2fc007752ceb1 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -737,39 +737,8 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
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
-- 
2.43.0


