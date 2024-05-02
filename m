Return-Path: <bpf+bounces-28432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3C28B9AB1
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 14:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88CF1F22069
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1967D408;
	Thu,  2 May 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdf/6/Ee"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF5D26A;
	Thu,  2 May 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652601; cv=none; b=IbKWHoFOxV9j7Zfllyc3pjoVPThS+sDcpPMLKR2qfo/l9olSjn9MbHVlhJWoZmeUPau/Q/t2syxuvDBaYWizUFvyf+NLzazbL6+GkrS6obO3egsbGc9AlAXkoZdFZYnVeS/8Tf/dyNLYAYawKt5UHdo55ya9NE364pvCVGFbRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652601; c=relaxed/simple;
	bh=BfrjHbaH4kx1eIxa8k9QBveZGnfSIPLRTzKMvB0B4Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTzhhFkiDxOFGBrukJT/ncoWtfH8Cl9mStDkt3kkgrcU46k63n4iZuRIQj7g1/qcB2TtEHJqxBW1syUAYLB/qOXWIIAtad9MJ/SqiIa46G04BP1U9LX3ILTuFBd8WMcYO9Y5lJcqAExDZsPAFlJda/0rON12GqjNKVUtTJK0dTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdf/6/Ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63637C113CC;
	Thu,  2 May 2024 12:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714652601;
	bh=BfrjHbaH4kx1eIxa8k9QBveZGnfSIPLRTzKMvB0B4Iw=;
	h=From:To:Cc:Subject:Date:From;
	b=bdf/6/EeLG8MDB3J1wGX4LWC3UYH06zM+8U/vnRBmeP91POn1GVSvZgOIWwKd0uUu
	 iJVPpissrk4qmQYcIUx1k5D/5fcNW/JU3FEczOzAm1UpTOgCUjBMfNGYrOyEQHY84B
	 mwx6UKU7SRAD+xVnfwQeo3R/s5Sr7EvlT8940LK46aC8fdPweR5CI+OWOjG4x5y2Io
	 Bf9Fqa6asUXsEiRs/AQzhubgiETs+GmnqFcS5KVcN4RkOat6PDIXhLbL2F3Z95Kl+m
	 5TNYFaQRUi3Wp6p94BV/7j5ikTY3p43yzb2nOcLcAEJw74TkdnnvvinmUKj9BUusU0
	 O6nmY+8sak0Rw==
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
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCHv4 bpf-next 0/7] uprobe: uretprobe speed up
Date: Thu,  2 May 2024 14:23:06 +0200
Message-ID: <20240502122313.1579719-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
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

Patches 1-6 are based on bpf-next/master, but path 1 and 2 are
apply-able on linux-trace.git tree probes/for-next branch.
Patch 7 is based on man-pages master.

v4 changes:
  - added acks [Oleg,Andrii,Masami]
  - reworded the man page and adding more info to NOTE section [Masami]
  - rewrote bpf tests not to use trace_pipe [Andrii]
  - cc-ed linux-man list

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  uretprobe_syscall

thanks,
jirka


Notes to check list items in Documentation/process/adding-syscalls.rst:

- System Call Alternatives
  New syscall seems like the best way in here, becase we need
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
  Wiring up of the uretprobe system call si in separate change,
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
Jiri Olsa (6):
      uprobe: Wire up uretprobe system call
      uprobe: Add uretprobe syscall to speed up return probe
      selftests/bpf: Add uretprobe syscall test for regs integrity
      selftests/bpf: Add uretprobe syscall test for regs changes
      selftests/bpf: Add uretprobe syscall call from user space test
      selftests/bpf: Add uretprobe compat test

 arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
 arch/x86/kernel/uprobes.c                                   | 115 ++++++++++++++++++++++++++++
 include/linux/syscalls.h                                    |   2 +
 include/linux/uprobes.h                                     |   3 +
 include/uapi/asm-generic/unistd.h                           |   5 +-
 kernel/events/uprobes.c                                     |  24 ++++--
 kernel/sys_ni.c                                             |   2 +
 tools/include/linux/compiler.h                              |   4 +
 tools/testing/selftests/bpf/.gitignore                      |   1 +
 tools/testing/selftests/bpf/Makefile                        |   7 +-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 123 ++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 382 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_syscall.c          |  15 ++++
 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  17 +++++
 14 files changed, 691 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c

Jiri Olsa (1):
      man2: Add uretprobe syscall page

 man2/uretprobe.2 | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 man2/uretprobe.2

