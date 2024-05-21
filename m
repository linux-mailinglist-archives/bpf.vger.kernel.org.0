Return-Path: <bpf+bounces-30101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9BB8CAC78
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A172816BD
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901C371B3D;
	Tue, 21 May 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVgBONYJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250945BE4;
	Tue, 21 May 2024 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288513; cv=none; b=h7xBarV0Ny8JR5mBmSo6GxjsbNFh/QosRJU/Un4XvGuRtQtgUHmNqNvxKykDGMcWsubmcSk40wEgIzvBXf6fqlR7HaUom0HfcWmoLcnol9j5EPAa6k9hjJJj9/E6gc52tQ8TXBEO5FyTZPhzD29G5ARsQvVR/q9rrlkYYRWwz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288513; c=relaxed/simple;
	bh=t6KrsjjS2cDjiQKKZKmCqoWmzszzaptCBic8EsD0Lcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kemAbKBuGocxl2ZMDI2Luv5OHDHU3ccSjKj6ze8OEwsOoS6Ne40qq6fV89e/6OHE3n8hEdK7aTnMJBx3auYTBhgU+1djtStazv8NaXx+N3ymajvyowlsHdhhQpU5915jack9iXvtWAsMRKNzC47ImHaB/sLXDJws9/iOYzuX4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVgBONYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6634AC2BD11;
	Tue, 21 May 2024 10:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716288512;
	bh=t6KrsjjS2cDjiQKKZKmCqoWmzszzaptCBic8EsD0Lcs=;
	h=From:To:Cc:Subject:Date:From;
	b=EVgBONYJQggmaCPfwSOj4nXhhd9yInDgZzkSfx54efX438ljLBKovHogUSb9eQhYQ
	 9PrvB4Ha1eyFgG03mi9HH7wyYt+liD1Vypyr+z62CiKmxNSoymaExskdmWRxS7Ct/O
	 kxSgqdYSFpM3ooEKpqdcRj8zwPRjI1Zu851tK8YT0mEk9Q48LqpHEcrYc4Ur5qa9TI
	 wW+wP2R+9fp2TqWOwL5+8xC5HSq6gZx+xqWnpx4bfG1cw7g2mAcAYzCTcPZ1uJ/VVB
	 FCMNjdk0b5wwUDCDyu9MbGralMKiTFbrnkDspLaSqf2+iZvWNow4UpGd8PVVl5M539
	 95G5aXdqmz0IQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCHv6 bpf-next 0/9] uprobe: uretprobe speed up
Date: Tue, 21 May 2024 12:48:16 +0200
Message-ID: <20240521104825.1060966-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
as part of the effort on speeding up the uprobes [0] coming with
return uprobe optimization by using syscall instead of the trap
on the uretprobe trampoline.

The speed up depends on instruction type that uprobe is installed
and depends on specific HW type, please check patch 1 for details.

Patches 1-8 are based on bpf-next/master, but patch 2 and 3 are
apply-able on linux-trace.git tree probes/for-next branch.
Patch 9 is based on man-pages master.

v6 changes:
- separate shadow stack fix for current uretprobe in patch 1
- skip shadow stack test when uprobe is not compiled int [Masami]
- fix retprobe with the shadow stack, using iret return when
  shadow stack is detected
- I kept the acks on patch 3, because the shadow stack change is
  minimal and the original code is almost untouched
- added shadow stack bpf selftest
- rebased man page

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  uretprobe_syscall

thanks,
jirka


Notes to check list items in Documentation/process/adding-syscalls.rst:

- System Call Alternatives
  New syscall seems like the best way in here, because we need
  just to quickly enter kernel with no extra arguments processing,
  which we'd need to do if we decided to use another syscall.

- Designing the API: Planning for Extension
  The uretprobe syscall is very specific and most likely won't be
  extended in the future.

  At the moment it does not take any arguments and even if it does
  in future, it's allowed to be called only from trampoline prepared
  by kernel, so there'll be no broken user.

- Designing the API: Other Considerations
  N/A because uretprobe syscall does not return reference to kernel
  object.

- Proposing the API
  Wiring up of the uretprobe system call is in separate change,
  selftests and man page changes are part of the patchset.

- Generic System Call Implementation
  There's no CONFIG option for the new functionality because it
  keeps the same behaviour from the user POV.

- x86 System Call Implementation
  It's 64-bit syscall only.

- Compatibility System Calls (Generic)
  N/A uretprobe syscall has no arguments and is not supported
  for compat processes.

- Compatibility System Calls (x86)
  N/A uretprobe syscall is not supported for compat processes.

- System Calls Returning Elsewhere
  N/A.

- Other Details
  N/A.

- Testing
  Adding new bpf selftests and ran ltp on top of this change.

- Man Page
  Attached.

- Do not call System Calls in the Kernel
  N/A.


[0] https://lore.kernel.org/bpf/ZeCXHKJ--iYYbmLj@krava/
---
Jiri Olsa (8):
      x86/shstk: Make return uprobe work with shadow stack
      uprobe: Wire up uretprobe system call
      uprobe: Add uretprobe syscall to speed up return probe
      selftests/x86: Add return uprobe shadow stack test
      selftests/bpf: Add uretprobe syscall test for regs integrity
      selftests/bpf: Add uretprobe syscall test for regs changes
      selftests/bpf: Add uretprobe syscall call from user space test
      selftests/bpf: Add uretprobe shadow stack test

 arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
 arch/x86/include/asm/shstk.h                                |   4 +
 arch/x86/kernel/shstk.c                                     |  16 ++++
 arch/x86/kernel/uprobes.c                                   | 124 ++++++++++++++++++++++++++++-
 include/linux/syscalls.h                                    |   2 +
 include/linux/uprobes.h                                     |   3 +
 include/uapi/asm-generic/unistd.h                           |   5 +-
 kernel/events/uprobes.c                                     |  24 ++++--
 kernel/sys_ni.c                                             |   2 +
 tools/include/linux/compiler.h                              |   4 +
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 123 ++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 385 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_syscall.c          |  15 ++++
 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  17 ++++
 tools/testing/selftests/x86/test_shadow_stack.c             | 145 ++++++++++++++++++++++++++++++++++
 15 files changed, 860 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c

Jiri Olsa (1):
      man2: Add uretprobe syscall page

 man/man2/uretprobe.2 | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 man/man2/uretprobe.2

