Return-Path: <bpf+bounces-73501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78545C331C7
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 22:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A53D4E3CF9
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1D1346793;
	Tue,  4 Nov 2025 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb6/a0fl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB47346786;
	Tue,  4 Nov 2025 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293255; cv=none; b=JRt3J8qWR3YIzerS6njNhVf2K3Arho57A1m9X3xeRfpp9SNhNIw9b/mvb8BXNcettnmxgpV6UpdXi56CzEH5r/eAurekCxi2AZ7qeC18n1sVdc62YiZTZQwEjSulgnHrtlY66mNm7y3E4UVVW786Qkm9EjDP3FlgE3huZa66yg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293255; c=relaxed/simple;
	bh=Op2pC1JDl8mx3DWTCZ3ftO5dFMbBcYhpWeHtIc78JKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPRb53/f7cO4EGpLZmsp4PZCjwSYtjuB1R4qcAsMMWqWFmOCyBaVoMVtHtMLrHsiHTBAxefX5+vcXTn+tf+hJ7p+faIn3R5OTEpmUFdckAPHwh1jADU5aluNacWm1Are4ZjEAAuifpcA/jOCz3RK+Y8vCj6+l0k/pcGd/1OYv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kb6/a0fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395C1C4CEF7;
	Tue,  4 Nov 2025 21:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762293254;
	bh=Op2pC1JDl8mx3DWTCZ3ftO5dFMbBcYhpWeHtIc78JKg=;
	h=From:To:Cc:Subject:Date:From;
	b=kb6/a0flhl0KuPo/JNjKP1E8tOzo+5tZzLT7uIe9TVGb0T7sDjVS7iyDA9yNW2rO9
	 eoSRKF/AamoP424O/HoSrJ7vMyNEm1sG/m7s0PKYZHtxrUAjjxTfqPZ52un6EuaGps
	 0zoVXso9fFLXkTlIy3tkv8drb4U0npKhMMbPKVhtuEbcbk1YW+t1LzgXdJvLr6L2JT
	 /P0ngMEaVZtRl4CGMlIrKpH7dtpXVB9hd/2rEUUCf5IMTQ5C3sh9QxnUWDx0fadRQn
	 U9b0Zn4AQmov1IZds+khTGa/Qk6SU56PgxZAxz+2R73XMsgkY16/nat9pt/V+viuhS
	 W4cqIqJ0LDWsQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCHv3 0/4] x86/fgraph,bpf: Fix ORC stack unwind from return probe
Date: Tue,  4 Nov 2025 22:54:01 +0100
Message-ID: <20251104215405.168643-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
sending fix for ORC stack unwind issue reported in here [1], where
the ORC unwinder won't go pass the return_to_handler function and
we get no stacktrace.

Sending fix for that together with unrelated stacktrace fix (patch 1),
so the attached test can work properly.

It's based on:
  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
  probes/for-next

v1: https://lore.kernel.org/bpf/20251027131354.1984006-1-jolsa@kernel.org/
v2: https://lore.kernel.org/bpf/20251103220924.36371-3-jolsa@kernel.org/

v3 changes:
- fix assert condition in test

thanks,
jirka


[1] https://lore.kernel.org/bpf/aObSyt3qOnS_BMcy@krava/
---
Jiri Olsa (4):
      Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
      x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe
      selftests/bpf: Add stacktrace ips test for kprobe_multi/kretprobe_multi
      selftests/bpf: Add stacktrace ips test for raw_tp

 arch/x86/events/core.c                                  |  10 +++----
 arch/x86/include/asm/ftrace.h                           |   5 ++++
 arch/x86/kernel/ftrace_64.S                             |   8 +++++-
 include/linux/ftrace.h                                  |  10 ++++++-
 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/stacktrace_ips.c      |  49 +++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c    |  26 +++++++++++++++++
 7 files changed, 251 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
 create mode 100644 tools/testing/selftests/bpf/progs/stacktrace_ips.c

