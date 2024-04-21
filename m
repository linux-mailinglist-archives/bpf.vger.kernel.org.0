Return-Path: <bpf+bounces-27336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBB18AC0FE
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 21:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DADB20B28
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5B1405F8;
	Sun, 21 Apr 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZaB4ytO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3D111AD;
	Sun, 21 Apr 2024 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728534; cv=none; b=Y0iP/TnWWvS6vxVPoZ1p5h+wxd4tyBHmXE6fVEN2OnvDiP7A4cpV2O57K83gwkWKwtpgnWxTvRM8XfC4wqkV/FdPhAYEdFx0/uHlPlkklhfMZ/7UVX4XsGuv9osqjh/nEzg+Gc+xWXwTUCVzRj8c1AynBLEe2eiRIyL4TxbHIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728534; c=relaxed/simple;
	bh=gIKpSlxxyTXiwHNJi87AQFzch96UtGO6YnydbxDTCHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXR24WQttGjSbhbeja/ECtq7hZgx+Pn1TtDXwn6m8OCWstTmOOZVncWuDqOFeCirZcVK7dEae9M3UGSUnTQs4pg7xey9Kakiy/pdHQ0ZI5hzUguTWQVFvj3F/DGUxb/7sSvhJn0bdoBBjwVkBjxrbPGY4RD24CcIiWWbO3nl1Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZaB4ytO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B45C113CE;
	Sun, 21 Apr 2024 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713728533;
	bh=gIKpSlxxyTXiwHNJi87AQFzch96UtGO6YnydbxDTCHc=;
	h=From:To:Cc:Subject:Date:From;
	b=gZaB4ytOauw4EDbDgzzkzYtw9H4vlC15TA4wv1npMAVnmpSBWwVGGle4ZZ4OuGcKb
	 8gZMdv4SSAgNOiPIcFiQ7g0dwaEoic2o4RVjbBfWKuOsJEffM3iv0g3lh4f/4SIEP3
	 0jnAtlHq5Qeb1LhU5lPBYVf1+acY4/6DXklt5tDor6obCY+Hz+DzzhZcTjspvifM4B
	 p5Am065u4yKELu0nMn2iyEj2mjGmVTiQ6w/gfXOC1V9XADRh15aMfLMKXevDSL17M0
	 Loqsz9NwRBPN0FvVKz/yfimG36sK/jlQTl+Ow7xSqNh47Zsn80GjLoc9XajrH42syt
	 tQh3tdNJ1cgKQ==
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
Subject: [PATCHv3 bpf-next 0/7] uprobe: uretprobe speed up
Date: Sun, 21 Apr 2024 21:41:59 +0200
Message-ID: <20240421194206.1010934-1-jolsa@kernel.org>
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

v3 changes:
  - added source ip check if the uretprobe syscall is called from
    trampoline and sending SIGILL to process if it's not
  - keep x86 compat process to use standard breakpoint
  - split syscall wiring into separate change
  - ran ltp and syzkaller locally, no issues found [Masami]
  - building uprobe_compat binary in selftests which breaks
    CI atm because of missing 32-bit delve packages, I will
    need to fix that in separate changes once this is acked
  - added man page change
  - there were several changes so I removed acks [Oleg Andrii]

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

 arch/x86/entry/syscalls/syscall_64.tbl                    |   1 +
 arch/x86/kernel/uprobes.c                                 | 115 ++++++++++++++++++++++++++++++
 include/linux/syscalls.h                                  |   2 +
 include/linux/uprobes.h                                   |   3 +
 include/uapi/asm-generic/unistd.h                         |   5 +-
 kernel/events/uprobes.c                                   |  24 +++++--
 kernel/sys_ni.c                                           |   2 +
 tools/include/linux/compiler.h                            |   4 ++
 tools/testing/selftests/bpf/.gitignore                    |   1 +
 tools/testing/selftests/bpf/Makefile                      |   6 +-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c     | 123 +++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c   | 362 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_syscall.c        |  15 ++++
 tools/testing/selftests/bpf/progs/uprobe_syscall_call.c   |  15 ++++
 tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c |  13 ++++
 15 files changed, 681 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_call.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c


Jiri Olsa (1):
      man2: Add uretprobe syscall page

 man2/uretprobe.2 | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 man2/uretprobe.2

