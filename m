Return-Path: <bpf+bounces-52343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E77AA4226E
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BAA1706EC
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33C078F2D;
	Mon, 24 Feb 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYXkNJbp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211021A29A;
	Mon, 24 Feb 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405718; cv=none; b=h4bXzDiavAS03kykrCU4WxxBKprOwen3lDqHneQPRanNCq/Qby6Fw2aqN5+/A8vgCbPEi9TY8RuLpGfMKD9lhjJD8fBzQENSBlIeSrq3N6ven9ORu4r+bZuUFaiq6z5JiXZ99qr8NCV4xNgAvI8c3HZFN9qZc00r7i2HglpfqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405718; c=relaxed/simple;
	bh=XpLkgpXiELKYDF5SxtkwlqDt74f1mFK/7OQcFGFEGXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GYd5G/lS8ajonA7wBKBsobDresUhujBHyqw1UfPO6iLF9Lk0Qxnft5vREwKgHuRTPwaK6IMNqQknMGghVTwhmPejTAdalzeudOkbKYRgEiIu7fj+rH/qQZ9YIo0wQcZh0Oj5REumF0rXsc+TUAk9NYkOQ08zDwdnd3PJQxkHugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYXkNJbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66E9C4CED6;
	Mon, 24 Feb 2025 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405717;
	bh=XpLkgpXiELKYDF5SxtkwlqDt74f1mFK/7OQcFGFEGXU=;
	h=From:To:Cc:Subject:Date:From;
	b=lYXkNJbpmdYak0n71ruHvVVAKdFDI8TB2d6m+zAiq8acBEoZCzJIyImTOCSy37sfU
	 zYpSf1sRVyqABIszvEbLpniyKTIZo0rE8cbdcK+gYauaInF9Q5WrXb53B5sC5r1tWs
	 sokznkCri8ApSZJooF9DMteKFPRue4GwGdTMh16u4NFJDqjrIOO65SgzrkU3k4ZTP5
	 4qWIqcXKkky40Fb4kXenN5P2SLXxqkhzBNaVsxYTSmCHR/bmupreugggO3JbhjH2Ul
	 vfF+JhGMNIhlnmesKtIZXXVVa8bhoiOEW0B7bENGFK6tKIn3grwWyjHEzc/ab12jm9
	 7KMYR0v1KM5Kg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
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
Subject: [PATCH RFCv2 00/18] uprobes: Add support to optimize usdt probes on x86_64
Date: Mon, 24 Feb 2025 15:01:32 +0100
Message-ID: <20250224140151.667679-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
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

  # ./benchs/run_bench_uprobes.sh 

          usermode-count :  818.386 ± 1.886M/s
          syscall-count  :    8.923 ± 0.003M/s
  -->     uprobe-nop     :    3.086 ± 0.005M/s
          uprobe-push    :    2.751 ± 0.001M/s
          uprobe-ret     :    1.481 ± 0.000M/s
  -->     uprobe-nop5    :    4.016 ± 0.002M/s
          uretprobe-nop  :    1.712 ± 0.008M/s
          uretprobe-push :    1.616 ± 0.001M/s
          uretprobe-ret  :    1.052 ± 0.000M/s
          uretprobe-nop5 :    2.015 ± 0.000M/s


rfc v2 changes:
- make uretprobe work properly with optimized uprobe
- make the uprobe optimized code x86_64 specific [Peter]
- rework the verify function logic, using it now as callback
- fix find_nearest_page to include [PAGE_SIZE, ... ] area [Andrii]
- try lockless vma lookup in in_uprobe_trampoline [Peter]
- do per partes instructions update using int3 like in text_poke_bp_batch [David]
- map uprobe trampoline via single global page [Thomas]
- keep track of uprobes per mm_struct

pending todo (follow ups):
- use PROCMAP_QUERY in tests
- alloc 'struct uprobes_state' for mm_struct only when needed [Andrii]
- seccomp change for new uprobe syscall (same as for uretprobe)

thanks,
jirka


---
Jiri Olsa (18):
      uprobes: Rename arch_uretprobe_trampoline function
      uprobes: Make copy_from_page global
      uprobes: Move ref_ctr_offset update out of uprobe_write_opcode
      uprobes: Add uprobe_write function
      uprobes: Add nbytes argument to uprobe_write_opcode
      uprobes: Add orig argument to uprobe_write and uprobe_write_opcode
      uprobes: Add swbp argument to arch_uretprobe_hijack_return_addr
      uprobes/x86: Add uprobe syscall to speed up uprobe
      uprobes/x86: Add mapping for optimized uprobe trampolines
      uprobes/x86: Add mm_uprobe objects to track uprobes within mm
      uprobes/x86: Add support to emulate nop5 instruction
      uprobes/x86: Add support to optimize uprobes
      selftests/bpf: Reorg the uprobe_syscall test function
      selftests/bpf: Use 5-byte nop for x86 usdt probes
      selftests/bpf: Add uprobe/usdt syscall tests
      selftests/bpf: Add hit/attach/detach race optimized uprobe test
      selftests/bpf: Add uprobe syscall sigill signal test
      selftests/bpf: Add 5-byte nop uprobe trigger bench

 arch/arm/probes/uprobes/core.c                              |   4 +-
 arch/arm64/kernel/probes/uprobes.c                          |   2 +-
 arch/csky/kernel/probes/uprobes.c                           |   2 +-
 arch/loongarch/kernel/uprobes.c                             |   2 +-
 arch/mips/kernel/uprobes.c                                  |   2 +-
 arch/powerpc/kernel/uprobes.c                               |   2 +-
 arch/riscv/kernel/probes/uprobes.c                          |   2 +-
 arch/s390/kernel/uprobes.c                                  |   2 +-
 arch/sparc/kernel/uprobes.c                                 |   2 +-
 arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
 arch/x86/include/asm/uprobes.h                              |   6 ++
 arch/x86/kernel/uprobes.c                                   | 530 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/syscalls.h                                    |   2 +
 include/linux/uprobes.h                                     |  23 +++-
 kernel/events/uprobes.c                                     | 147 +++++++++++++++++--------
 kernel/fork.c                                               |   1 +
 kernel/sys_ni.c                                             |   1 +
 tools/testing/selftests/bpf/bench.c                         |  12 +++
 tools/testing/selftests/bpf/benchs/bench_trigger.c          |  42 ++++++++
 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh     |   2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 342 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  34 +++++-
 tools/testing/selftests/bpf/sdt.h                           |   9 +-
 23 files changed, 1093 insertions(+), 79 deletions(-)

