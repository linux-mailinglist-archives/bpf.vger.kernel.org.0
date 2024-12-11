Return-Path: <bpf+bounces-46625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD19ECD40
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF2F162C7C
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C4122C34A;
	Wed, 11 Dec 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZWSIuCN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9F23FD1E;
	Wed, 11 Dec 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924049; cv=none; b=mcgB30uk9M1Y8F0gv7WkBDlrC120ZzMt6koyGJ4Zry8Uth8S75KHouLpuofj1XIpghmuz9A5XfhXkcC+6F7Q/iDmpoOPHm8bd9lN5LyCGgBq7hYMcvH4qFHCukKXxTjGr/BxHXTRmf4150yhgEx8ZM0bvkde4J1n29HLzPeuNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924049; c=relaxed/simple;
	bh=OyO4NuOOCEs49xUCD/A5hVrJ7mLsH/26AW6mnDtM+bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ts/s0fJ/zz9bs7FKOCbTcrfMn04t2cFwWfngnSRqTmcWNpsgV0vq1QgqBJdFEDzi1R25wIV43ntdDcqn4ntfpveEU3dmcMSuxqAXgQfisx61QyFsbdT++3yBWuB5FRZke92+DKvbP5Rt09/R4PsfOmrP//b4JXRqVkRinx/F3SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZWSIuCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9844BC4CED2;
	Wed, 11 Dec 2024 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924048;
	bh=OyO4NuOOCEs49xUCD/A5hVrJ7mLsH/26AW6mnDtM+bc=;
	h=From:To:Cc:Subject:Date:From;
	b=AZWSIuCNzFpazFCK8tGOMBldSANFbgWIRsk1LSN9E2z2NjvruZRCLgA6wF/AEBaIU
	 /8R2Kc0KRBpQvB+wz6Rsvb70LzZQY9kDipT5sTeVtj0lYwQj0WG5N1qijwXMQRmOjN
	 t4+bt6o407X2KIrly0dQGDKbSYdSuD7p/rGEhlH9AYRiDgqP8MjytBldpU8cxpnxEa
	 Ks72JTlxE1/ciwAtDDaS4VvThv9UnrooxNgdwSaUyJRe1+LQn8KNk1xi4l0K3n7KeY
	 PDcDUvBO3t5lZbf1noc706eSeCQqVREINauSUOKQFJ4tr6LL/VCSWW84pQ723ZcDTN
	 6/aDOTruRzYTw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 00/13] uprobes: Add support to optimize usdt probes on x86_64
Date: Wed, 11 Dec 2024 14:33:49 +0100
Message-ID: <20241211133403.208920-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
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

      usermode-count :  233.831 ± 0.257M/s
      syscall-count  :   12.107 ± 0.038M/s
  --> uprobe-nop     :    3.246 ± 0.004M/s
      uprobe-push    :    3.057 ± 0.000M/s
      uprobe-ret     :    1.113 ± 0.003M/s
  --> uprobe-nop5    :    6.751 ± 0.037M/s
      uretprobe-nop  :    1.740 ± 0.015M/s
      uretprobe-push :    1.677 ± 0.018M/s
      uretprobe-ret  :    0.852 ± 0.005M/s
      uretprobe-nop5 :    6.769 ± 0.040M/s


v1 changes:
- rebased on top of bpf-next/master
- couple of function/variable renames [Andrii]
- added nop5 emulation [Andrii]
- added checks to arch_uprobe_verify_opcode [Andrii]
- fixed arch_uprobe_is_callable/find_nearest_page [Andrii]
- used CALL_INSN_OPCODE [Masami]
- added uprobe-nop5 benchmark [Andrii]
- using atomic64_t in tramp_area [Andri]
- using single page for all uprobe trampoline mappings

thanks,
jirka


---
Jiri Olsa (13):
      uprobes: Rename arch_uretprobe_trampoline function
      uprobes: Make copy_from_page global
      uprobes: Add nbytes argument to uprobe_write_opcode
      uprobes: Add arch_uprobe_verify_opcode function
      uprobes: Add mapping for optimized uprobe trampolines
      uprobes/x86: Add uprobe syscall to speed up uprobe
      uprobes/x86: Add support to emulate nop5 instruction
      uprobes/x86: Add support to optimize uprobes
      selftests/bpf: Use 5-byte nop for x86 usdt probes
      selftests/bpf: Add uprobe/usdt optimized test
      selftests/bpf: Add hit/attach/detach race optimized uprobe test
      selftests/bpf: Add uprobe syscall sigill signal test
      selftests/bpf: Add 5-byte nop uprobe trigger bench

 arch/x86/entry/syscalls/syscall_64.tbl                  |   1 +
 arch/x86/include/asm/uprobes.h                          |   7 +++
 arch/x86/kernel/uprobes.c                               | 255 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/syscalls.h                                |   2 +
 include/linux/uprobes.h                                 |  25 +++++++-
 kernel/events/uprobes.c                                 | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 kernel/fork.c                                           |   1 +
 kernel/sys_ni.c                                         |   1 +
 tools/testing/selftests/bpf/bench.c                     |  12 ++++
 tools/testing/selftests/bpf/benchs/bench_trigger.c      |  42 +++++++++++++
 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 326 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_optimized.c    |  29 +++++++++
 tools/testing/selftests/bpf/sdt.h                       |   9 ++-
 14 files changed, 880 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_optimized.c

