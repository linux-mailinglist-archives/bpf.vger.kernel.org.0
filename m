Return-Path: <bpf+bounces-8748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D6A7896F8
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C935A1C20DC5
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2CFDDD7;
	Sat, 26 Aug 2023 13:44:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED0CA58
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 13:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AC5C433C7;
	Sat, 26 Aug 2023 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693057491;
	bh=oFKyndOxe6LHZACuQUiWjyjDTRuOBgWPpdfdATB1Dug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Rt7F/XMiZy780lu2ZKlBR7T7ydImNaVJEnqCZ5cXIIJ3/Mo5NxpAyvJJSVip8EpIw
	 DqSf2qCQCwpBFvpwt9iM1jArX7UOKG+fVihKEjemO9oERbttfmnU7UUOmTaN4RlEuw
	 E6B9Lhrho0Et2xyjuT6aSh2LiagMUISvRdc3d1/VLj7iRKy6tOD4TzfL6vlnNps2Ee
	 7BssZAx68OpYx9y4VNrm0ZqTcrjgoB0VB8k/P0y/o274rmkF+/Sp+87Iq3ESOv9Bnj
	 5lj1xm12RFXBZ5JF4rde6y96tqxw67Wj+KU9RTw2gvP79w7LM+jeG/74LjWILW6kei
	 9Qd9JGLofJG5w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Cc: bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>,
 yonghong.song@linux.dev, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Puranjay Mohan <puranjay12@gmail.com>
Subject: RISC-V uprobe bug (Was: Re: WARNING: CPU: 3 PID: 261 at
 kernel/bpf/memalloc.c:342)
In-Reply-To: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
Date: Sat, 26 Aug 2023 15:44:48 +0200
Message-ID: <87v8d19aun.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
> selftests on bpf-next 9e3b47abeb8f.
>
> I'm able to reproduce the hang by multiple runs of:
>  | ./test_progs -a link_api -a linked_list
> I'm currently investigating that.

+Guo for uprobe

This was an interesting bug. The hang is an ebreak (RISC-V breakpoint),
that puts the kernel into an infinite loop.

To reproduce, simply run the BPF selftest:
./test_progs -v -a link_api -a linked_list

First the link_api test is being run, which exercises the uprobe
functionality. The link_api test completes, and test_progs will still
have the uprobe active/enabled. Next the linked_list test triggered a
WARN_ON (which is implemented via ebreak as well).

Now, handle_break() is entered, and the uprobe_breakpoint_handler()
returns true exiting the handle_break(), which returns to the WARN
ebreak, and we have merry-go-round.

Lucky for the RISC-V folks, the BPF memory handler had a WARN that
surfaced the bug! ;-)

This patch fixes the issue, but it's probably a prettier variant:
--8<--
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f798c853bede..1198cb879d2f 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -248,23 +248,29 @@ static inline unsigned long get_break_insn_length(uns=
igned long pc)
=20
 void handle_break(struct pt_regs *regs)
 {
+       bool user =3D user_mode(regs);
+
 #ifdef CONFIG_KPROBES
-       if (kprobe_single_step_handler(regs))
-               return;
+       if (!user) {
+               if (kprobe_single_step_handler(regs))
+                       return;
=20
-       if (kprobe_breakpoint_handler(regs))
-               return;
+               if (kprobe_breakpoint_handler(regs))
+                       return;
+       }
 #endif
 #ifdef CONFIG_UPROBES
-       if (uprobe_single_step_handler(regs))
-               return;
+       if (user) {
+               if (uprobe_single_step_handler(regs))
+                       return;
=20
-       if (uprobe_breakpoint_handler(regs))
-               return;
+               if (uprobe_breakpoint_handler(regs))
+                       return;
+       }
 #endif
        current->thread.bad_cause =3D regs->cause;
=20
-       if (user_mode(regs))
+       if (user)
                force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->e=
pc);
 #ifdef CONFIG_KGDB
        else if (notify_die(DIE_TRAP, "EBREAK", regs, 0, regs->cause, SIGTR=
AP)
--8<--

I'll cook a cleaner/proper patch for this, unless the uprobes folks has
a better solution.


Bj=C3=B6rn

