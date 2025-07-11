Return-Path: <bpf+bounces-63009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEDCB0160F
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129DC5A544F
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F5D207E1D;
	Fri, 11 Jul 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0MgCYy2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A9202976;
	Fri, 11 Jul 2025 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222584; cv=none; b=gtBWvedVmo3Tw/fDfWGgC8a8gX00gSi1bbfDZGjvVYxCHgrP3WjA0+jnJ9egBzNWOkZ2LmOgvmxM2ShSZmvqkJckUFwRJqeWcy9E0HYnGUWdAfAop4I5Ib/a/sLVZSvvb11Yqi/f/OBK+OJEGdtXxmNDq9T0l5BAhtNRHFQfnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222584; c=relaxed/simple;
	bh=9bh7znodlw8FlXp/na//YSh9kRdbfbFY0AFANoOPt+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F13bCtGW8UnygeBrU6euI4yA9Tpbsf9koQyP/G1X11/o+JHrgBIMvJeX1Gkm6/awY63X4GWMOGTlVwyQdhY58NFpnJLZku1XRQ7UqBrXu/6q/H7FIbJx8vIzhQVND9w2Zw2u1tXI8Dmek/9qCvdGWnsWhSehU9zaBn7k5SQjzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0MgCYy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D635BC4CEFC;
	Fri, 11 Jul 2025 08:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222583;
	bh=9bh7znodlw8FlXp/na//YSh9kRdbfbFY0AFANoOPt+Q=;
	h=From:To:Cc:Subject:Date:From;
	b=T0MgCYy2yD58wkhMifpgEp1TXMyDvKtayNpsOxtRiwjmbfNEXyK2LDZzF/yPtzox2
	 LyqNd1O+/lbR2fvJOW8194IVHuUXUCgGlIj9cvnit00ZpRXmLTzsa0/i1cIbTeWoc6
	 NY7tJTkO44CFbE09uTUaZvh2vVfEujE9xZHv7qoFKPF18LpU++MgKlao3Rh7N4Hr3J
	 AWP6vzzl6WSaOpp6BLVN9S/iy9kh+Y+y7+zOSF5tf+1sfC8RxWqihmcBx4+5qVLP5W
	 bqRgl1Scpg3vcs6Q9ftZ1AmGUXQmKFhzZuGySvf0+MhBOXeEEmc/Vd5hl1AV50y7tz
	 D1QRfPmXVKEew==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv5 perf/core 00/22] uprobes: Add support to optimize usdt probes on x86_64
Date: Fri, 11 Jul 2025 10:29:08 +0200
Message-ID: <20250711082931.3398027-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
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
        usermode-count :  152.501 ± 0.012M/s
        syscall-count  :   14.463 ± 0.062M/s
-->     uprobe-nop     :    3.160 ± 0.005M/s
        uprobe-push    :    3.003 ± 0.003M/s
        uprobe-ret     :    1.100 ± 0.003M/s
        uprobe-nop5    :    3.132 ± 0.012M/s
        uretprobe-nop  :    2.103 ± 0.002M/s
        uretprobe-push :    2.027 ± 0.004M/s
        uretprobe-ret  :    0.914 ± 0.002M/s
        uretprobe-nop5 :    2.115 ± 0.002M/s

after the change:
        usermode-count :  152.343 ± 0.400M/s
        syscall-count  :   14.851 ± 0.033M/s
        uprobe-nop     :    3.204 ± 0.005M/s
        uprobe-push    :    3.040 ± 0.005M/s
        uprobe-ret     :    1.098 ± 0.003M/s
-->     uprobe-nop5    :    7.286 ± 0.017M/s
        uretprobe-nop  :    2.144 ± 0.001M/s
        uretprobe-push :    2.069 ± 0.002M/s
        uretprobe-ret  :    0.922 ± 0.000M/s
        uretprobe-nop5 :    3.487 ± 0.001M/s

I see bit more speed up on Intel (above) compared to AMD. The big nop5
speed up is partly due to emulating nop5 and partly due to optimization.

The key speed up we do this for is the USDT switch from nop to nop5:
	uprobe-nop     :    3.160 ± 0.005M/s
	uprobe-nop5    :    7.286 ± 0.017M/s

Changes from v4:
- reworked search for trampoline page, dropped Oleg's ack from that patch
  because of the change [Masami]

Changes from v3:
- rebased on top of tip/master + bpf-next/master + mm/mm-nonmm-unstable
- reworked patch#8 to lookup trampoline trampoline every 4GB so we don't
  waste page frames in some cases [Masami]
- several minor fixes [Masami]
- added acks [Oleg, Alejandro, Masami]

Changes from v2:
- rebased on top of tip/master + mm/mm-stable + 1 extra change [1]
- added acks [Oleg,Andrii]
- more details changelog for patch 1 [Masami]
- several tests changes [Andrii]
- add explicit PAGE_SIZE low limit to vm_unmapped_area call [Andrii]


This patchset is adding new syscall, here are notes to check list items
in Documentation/process/adding-syscalls.rst:

- System Call Alternatives
  New syscall seems like the best way in here, because we need
  just to quickly enter kernel with no extra arguments processing,
  which we'd need to do if we decided to use another syscall.

- Designing the API: Planning for Extension
  The uprobe syscall is very specific and most likely won't be
  extended in the future.

- Designing the API: Other Considerations
  N/A because uprobe syscall does not return reference to kernel
  object.

- Proposing the API
  Wiring up of the uprobe system call is in separate change,
  selftests and man page changes are part of the patchset.

- Generic System Call Implementation
  There's no CONFIG option for the new functionality because it
  keeps the same behaviour from the user POV.

- x86 System Call Implementation
  It's 64-bit syscall only.

- Compatibility System Calls (Generic)
  N/A uprobe syscall has no arguments and is not supported
  for compat processes.

- Compatibility System Calls (x86)
  N/A uprobe syscall is not supported for compat processes.

- System Calls Returning Elsewhere
  N/A.

- Other Details
  N/A.

- Testing
  Adding new bpf selftests.

- Man Page
  Attached.

- Do not call System Calls in the Kernel
  N/A

pending todo (or follow ups):
- use PROCMAP_QUERY in tests
- alloc 'struct uprobes_state' for mm_struct only when needed [Andrii]
- use mm_cpumask(vma->vm_mm) in text_poke_sync

thanks,
jirka


Cc: Alejandro Colomar <alx@kernel.org>
Cc: Eyal Birger <eyal.birger@gmail.com>
Cc: kees@kernel.org

[1] https://lore.kernel.org/linux-trace-kernel/20250514101809.2010193-1-jolsa@kernel.org/T/#u
---
Jiri Olsa (21):
      uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
      uprobes: Rename arch_uretprobe_trampoline function
      uprobes: Make copy_from_page global
      uprobes: Add uprobe_write function
      uprobes: Add nbytes argument to uprobe_write
      uprobes: Add is_register argument to uprobe_write and uprobe_write_opcode
      uprobes: Add do_ref_ctr argument to uprobe_write function
      uprobes/x86: Add mapping for optimized uprobe trampolines
      uprobes/x86: Add uprobe syscall to speed up uprobe
      uprobes/x86: Add support to optimize uprobes
      selftests/bpf: Import usdt.h from libbpf/usdt project
      selftests/bpf: Reorg the uprobe_syscall test function
      selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
      selftests/bpf: Add uprobe/usdt syscall tests
      selftests/bpf: Add hit/attach/detach race optimized uprobe test
      selftests/bpf: Add uprobe syscall sigill signal test
      selftests/bpf: Add optimized usdt variant for basic usdt test
      selftests/bpf: Add uprobe_regs_equal test
      selftests/bpf: Change test_uretprobe_regs_change for uprobe and uretprobe
      seccomp: passthrough uprobe systemcall without filtering
      selftests/seccomp: validate uprobe syscall passes through seccomp

 arch/arm/probes/uprobes/core.c                              |   2 +-
 arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
 arch/x86/include/asm/uprobes.h                              |   7 ++
 arch/x86/kernel/uprobes.c                                   | 554 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/syscalls.h                                    |   2 +
 include/linux/uprobes.h                                     |  20 +++-
 kernel/events/uprobes.c                                     | 100 ++++++++++++-----
 kernel/fork.c                                               |   1 +
 kernel/seccomp.c                                            |  32 ++++--
 kernel/sys_ni.c                                             |   1 +
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 518 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 tools/testing/selftests/bpf/prog_tests/usdt.c               |  38 ++++---
 tools/testing/selftests/bpf/progs/uprobe_syscall.c          |   4 +-
 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  60 +++++++++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c        |  11 +-
 tools/testing/selftests/bpf/usdt.h                          | 545 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c               | 107 ++++++++++++++----
 17 files changed, 1891 insertions(+), 112 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/usdt.h

Jiri Olsa (1):
      man2: Add uprobe syscall page

 man/man2/uprobe.2    |  1 +
 man/man2/uretprobe.2 | 36 ++++++++++++++++++++++++------------
 2 files changed, 25 insertions(+), 12 deletions(-)
 create mode 100644 man/man2/uprobe.2

