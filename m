Return-Path: <bpf+bounces-54441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132A9A6A51C
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB70881E22
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F321CFE0;
	Thu, 20 Mar 2025 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0wskPf2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97A27701;
	Thu, 20 Mar 2025 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470927; cv=none; b=tJcdi/rc0R3EK7qXJZBDOB2NLahOXJV2Ye78L400yLrevJc9ffK1qF1mxmAuXSxyaUAtE4HLhO2tbLoMKfxBVm9HSL/8npQvV9fUR2SjnxRbD+++eUtbuOFR58nd+TE2BEFM03HxPMz/PY01P+H1Wn3brylGZH0a09yLeuht5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470927; c=relaxed/simple;
	bh=HMRR1e3vegCWtPNgWb/evYFL7zXfhK3xc62fYep7GTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=it5Goph02HafD7ieZa+Irbgy/uUgfcZF0EN4TprX0oGIPUDhKDggKkZ4UStT788assY4pj1h4P/2Yhso9HMm/CsA0/FoD+T2vvyPzpl8iYTaj3VwUcAtHpMB4rcE7Q7QJ1h5Gp0O0iwUOTU/ymZAAruCdBZCfKzronLOdAVgksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0wskPf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EA4C4CEDD;
	Thu, 20 Mar 2025 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742470926;
	bh=HMRR1e3vegCWtPNgWb/evYFL7zXfhK3xc62fYep7GTA=;
	h=From:To:Cc:Subject:Date:From;
	b=j0wskPf2nXkswNfKuvs7Wj/jv9Ox9vLIBfdoRid56LnX9zSCo+g0I/zIUxSLaQnwK
	 zsJo7/RfZ8FT+DiqE/L9P7vkwsiVNdEkbuPeCodtJ5lCxdBW96sZikfumkbdhaGrKp
	 aYSk/b5WYMLUa1OGXri5GtJvjnZwdBc5ZFPB4eKEe0t4EeswpDscHD/h10Zf5x/Yh/
	 cKgB3iW4o3vVJjkmXROXplBG5Th3cmnzKYw32+IVOc6iO3PXf7UTYSAHE003sv/pUA
	 Dz4w3bQ28lltzsSSyxGj3HHfSb0Sqo64E/G+6R3kjtbHhzltnnM9mIsIT4dLF7Cc8D
	 MjDPuujalt0Hw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eyal Birger <eyal.birger@gmail.com>,
	kees@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv3 00/23] uprobes: Add support to optimize usdt probes on x86_64
Date: Thu, 20 Mar 2025 12:41:35 +0100
Message-ID: <20250320114200.14377-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hi,
this patchset adds support to optimize usdt probes on top of 5-byte
nop instruction.

The generic approach (optimize all uprobes) is hard due to emulating
possible multiple original instructions and its related issues. The
usdt case, which stores 5-byte nop seems much easier, so starting
with that.

The basic idea is to replace breakpoint exception with syscall which
is faster on x86_64. For more details please see changelog of patch 8.

The run_bench_uprobes.sh benchmark triggers uprobe (on top of different
original instructions) in a loop and counts how many of those happened
per second (the unit below is million loops).

There's big speed up if you consider current usdt implementation
(uprobe-nop) compared to proposed usdt (uprobe-nop5):

current:
        usermode-count :  152.604 ± 0.044M/s
        syscall-count  :   13.359 ± 0.042M/s
-->     uprobe-nop     :    3.229 ± 0.002M/s
        uprobe-push    :    3.086 ± 0.004M/s
        uprobe-ret     :    1.114 ± 0.004M/s
        uprobe-nop5    :    1.121 ± 0.005M/s
        uretprobe-nop  :    2.145 ± 0.002M/s
        uretprobe-push :    2.070 ± 0.001M/s
        uretprobe-ret  :    0.931 ± 0.001M/s
        uretprobe-nop5 :    0.957 ± 0.001M/s

after the change:
        usermode-count :  152.448 ± 0.244M/s
        syscall-count  :   14.321 ± 0.059M/s
        uprobe-nop     :    3.148 ± 0.007M/s
        uprobe-push    :    2.976 ± 0.004M/s
        uprobe-ret     :    1.068 ± 0.003M/s
-->     uprobe-nop5    :    7.038 ± 0.007M/s
        uretprobe-nop  :    2.109 ± 0.004M/s
        uretprobe-push :    2.035 ± 0.001M/s
        uretprobe-ret  :    0.908 ± 0.001M/s
        uretprobe-nop5 :    3.377 ± 0.009M/s

I see bit more speed up on Intel (above) compared to AMD. The big nop5
speed up is partly due to emulating nop5 and partly due to optimization.

The key speed up we do this for is the USDT switch from nop to nop5:
        uprobe-nop     :    3.148 ± 0.007M/s
        uprobe-nop5    :    7.038 ± 0.007M/s


rfc v3 changes:
- I tried to have just single syscall for both entry and return uprobe,
  but it turned out to be slower than having two separated syscalls,
  probably due to extra save/restore processing we have to do for
  argument reg, I see differences like:

    2 syscalls:      uprobe-nop5    :    7.038 ± 0.007M/s
    1 syscall:       uprobe-nop5    :    6.943 ± 0.003M/s

- use instructions (nop5/int3/call) to determine the state of the
  uprobe update in the process
- removed endbr instruction from uprobe trampoline
- seccomp changes

pending todo (or follow ups):
- shadow stack fails for uprobe session setup, will fix it in next version
- use PROCMAP_QUERY in tests
- alloc 'struct uprobes_state' for mm_struct only when needed [Andrii]

thanks,
jirka


Cc: Eyal Birger <eyal.birger@gmail.com>
Cc: kees@kernel.org
---
Jiri Olsa (23):
      uprobes: Rename arch_uretprobe_trampoline function
      uprobes: Make copy_from_page global
      uprobes: Move ref_ctr_offset update out of uprobe_write_opcode
      uprobes: Add uprobe_write function
      uprobes: Add nbytes argument to uprobe_write_opcode
      uprobes: Add orig argument to uprobe_write and uprobe_write_opcode
      uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
      uprobes/x86: Add uprobe syscall to speed up uprobe
      uprobes/x86: Add mapping for optimized uprobe trampolines
      uprobes/x86: Add support to emulate nop5 instruction
      uprobes/x86: Add support to optimize uprobes
      selftests/bpf: Use 5-byte nop for x86 usdt probes
      selftests/bpf: Reorg the uprobe_syscall test function
      selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
      selftests/bpf: Add uprobe/usdt syscall tests
      selftests/bpf: Add hit/attach/detach race optimized uprobe test
      selftests/bpf: Add uprobe syscall sigill signal test
      selftests/bpf: Add optimized usdt variant for basic usdt test
      selftests/bpf: Add uprobe_regs_equal test
      selftests/bpf: Change test_uretprobe_regs_change for uprobe and uretprobe
      selftests/bpf: Add 5-byte nop uprobe trigger bench
      seccomp: passthrough uprobe systemcall without filtering
      selftests/seccomp: validate uprobe syscall passes through seccomp

 arch/arm/probes/uprobes/core.c                              |   2 +-
 arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
 arch/x86/include/asm/uprobes.h                              |   7 ++
 arch/x86/kernel/uprobes.c                                   | 540 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/syscalls.h                                    |   2 +
 include/linux/uprobes.h                                     |  19 +++-
 kernel/events/uprobes.c                                     | 141 +++++++++++++++++-------
 kernel/fork.c                                               |   1 +
 kernel/seccomp.c                                            |  32 ++++--
 kernel/sys_ni.c                                             |   1 +
 tools/testing/selftests/bpf/bench.c                         |  12 +++
 tools/testing/selftests/bpf/benchs/bench_trigger.c          |  42 ++++++++
 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh     |   2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 453 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 tools/testing/selftests/bpf/prog_tests/usdt.c               |  38 ++++---
 tools/testing/selftests/bpf/progs/uprobe_syscall.c          |   4 +-
 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  41 ++++++-
 tools/testing/selftests/bpf/sdt.h                           |   9 +-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c        |  11 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c               | 107 ++++++++++++++----
 20 files changed, 1338 insertions(+), 127 deletions(-)

