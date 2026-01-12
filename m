Return-Path: <bpf+bounces-78625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA1AD157BD
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 22:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0D9A301C08D
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 21:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411343446A4;
	Mon, 12 Jan 2026 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFrLolB5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57D0342512;
	Mon, 12 Jan 2026 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254614; cv=none; b=PiV6nyXZ+7BNEMOc9+eXjX1dkMbdQkIO++dSa1OtIbFL6bcEmy4cRTpDKm7cCSqStaQIObu3vX19K6YYihnaRvGhAEnydoajvaWsqnD7khX+8ecO2JZGuq+42pO5/34OABArkhOTpLQUt4rEhfpDVu/Do4KEawoLpvkB6c6oDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254614; c=relaxed/simple;
	bh=ajNpjb6n2s84loIPdjzeQXwqcnHNnx6ykiY8orO5VdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYoNgq18aRoUWTvIblBJFTlVPwtsc3YWK7jASEUOV8f2kbCitGLMoPJNlYFdFu/LCKZlQ+YPe3xyTIrsbftePHcLcSE6+Tt6OIdsA+2jms0fEUO6TbHYE55cR0xR+bB6Cfn1x3rMPFif5zWmOrvoGBLhJwVGHhHqwhIMXJHuURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFrLolB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B26C116D0;
	Mon, 12 Jan 2026 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768254614;
	bh=ajNpjb6n2s84loIPdjzeQXwqcnHNnx6ykiY8orO5VdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rFrLolB5Wr2cdV+yJ96zWImAQXdOkO7TLKU9TSQB/5b8wWrWKDmWtTsdiPO45/I0Q
	 BlOtqXezod64LAWEiulCpwQk1qA+fmu+RyW+xNwRH0ZVBlV0DnnUyf/VAHLfCmp3DV
	 piynMwqwpSi31H23LxRHdqKN387SxaPT500bVk0WML5T08Fw7h9b6aWYD98Y4WhbLX
	 nNm0Vf/JtaCZvuhg2hnqydQUKAmIdzGBYH7JXSKW/Li3kHp08I43GXqC2+jdwo2dO8
	 VjhE8yqKXyb2kCfdTs3p/5T3DJ/t+i3+wbEj7Djw/bvTspCc7TxX86PzVFO36Iatk5
	 8osaaOhT6YZyg==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/4] x86/fgraph,bpf: Switch kprobe_multi program stack unwind to hw_regs path
Date: Mon, 12 Jan 2026 22:49:38 +0100
Message-ID: <20260112214940.1222115-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112214940.1222115-1-jolsa@kernel.org>
References: <20260112214940.1222115-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Mahe reported missing function from stack trace on top of kprobe
multi program. The missing function is the very first one in the
stacktrace, the one that the bpf program is attached to.

  # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
  Attaching 1 probe...

        do_syscall_64+134
        entry_SYSCALL_64_after_hwframe+118

  ('*' is used for kprobe_multi attachment)

The reason is that the previous change (the Fixes commit) fixed
stack unwind for tracepoint, but removed attached function address
from the stack trace on top of kprobe multi programs, which I also
overlooked in the related test (check following patch).

The tracepoint and kprobe_multi have different stack setup, but use
same unwind path. I think it's better to keep the previous change,
which fixed tracepoint unwind and instead change the kprobe multi
unwind as explained below.

The bpf program stack unwind calls perf_callchain_kernel for kernel
portion and it follows two unwind paths based on X86_EFLAGS_FIXED
bit in pt_regs.flags.

When the bit set we unwind from stack represented by pt_regs argument,
otherwise we unwind currently executed stack up to 'first_frame'
boundary.

The 'first_frame' value is taken from regs.rsp value, but ftrace_caller
and ftrace_regs_caller (ftrace trampoline) functions set the regs.rsp
to the previous stack frame, so we skip the attached function entry.

If we switch kprobe_multi unwind to use the X86_EFLAGS_FIXED bit,
we can control the start of the unwind and get back the attached
function address. As another benefit we also cut extra unwind cycles
needed to reach the 'first_frame' boundary.

The speedup can be meassured with trigger bench for kprobe_multi
program and stacktrace support.

- without bpf_get_stackid call:

    # ./bench -w2 -d5  -a  -p1  trig-kprobe-multi

    Summary: hits    0.857 ± 0.003M/s (  0.857M/prod), drops 0.000 ± 0.000M/s, total operations 0.857 ± 0.003M/s

-  with bpf_get_stackid call:

    # ./bench -w2 -d5  -a -g -p1  trig-kprobe-multi

    Summary: hits    1.302 ± 0.002M/s (  1.302M/prod), drops 0.000 ± 0.000M/s, total operations 1.302 ± 0.002M/s

Note the '-g' option for stacktrace added in following change.

To recreate same stack setup for return probe as we have for entry
probe, we set the instruction pointer to the attached function address,
which gets us the same unwind setup and same stack trace.

With the fix, entry probe:

  # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
  Attaching 1 probe...

        __x64_sys_newuname+9
        do_syscall_64+134
        entry_SYSCALL_64_after_hwframe+118

return probe:

  # bpftrace -e 'kretprobe:__x64_sys_newuname* { print(kstack)}'
  Attaching 1 probe...

        __x64_sys_newuname+4
        do_syscall_64+134
        entry_SYSCALL_64_after_hwframe+118

Fixes: 6d08340d1e35 ("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"")
Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/ftrace.h | 2 +-
 kernel/trace/fgraph.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index b08c95872eed..c56e1e63b893 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -57,7 +57,7 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 }
 
 #define arch_ftrace_partial_regs(regs) do {	\
-	regs->flags &= ~X86_EFLAGS_FIXED;	\
+	regs->flags |= X86_EFLAGS_FIXED;	\
 	regs->cs = __KERNEL_CS;			\
 } while (0)
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index cc48d16be43e..6279e0a753cf 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -825,7 +825,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	}
 
 	if (fregs)
-		ftrace_regs_set_instruction_pointer(fregs, ret);
+		ftrace_regs_set_instruction_pointer(fregs, trace.func);
 
 	bit = ftrace_test_recursion_trylock(trace.func, ret);
 	/*
-- 
2.52.0


