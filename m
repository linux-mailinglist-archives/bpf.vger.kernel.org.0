Return-Path: <bpf+bounces-67182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030D3B4070B
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631035641EC
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD0C311C0C;
	Tue,  2 Sep 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYLGCcUK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4C92DEA77;
	Tue,  2 Sep 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823716; cv=none; b=Ertiiv1NbzUxxj6H12Iujv5fc7lLQo9UKq/SxalpYNc/6YvaMfrs9NioQZkZ1HdV8TYjrvbTX4uVYglx0v3iHfN10w9812TjmMZit2vWTy6wCULm94JXg6Bml4BWH5GqO/8bd36WEFcKu0AjPUTq759+OtSJNb2NkheSaQyq/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823716; c=relaxed/simple;
	bh=N24nlm+kQ3jC8awxfDsEzAyVYXN9c8rmf4oiujA97ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7CZ4s3hlMV79+okxet3qq/R83LJIqb+Ql+CyxxDBK70eJJx8dvG//dBir1cJ5g1iQWO6N6NoGRRZS22udKjtu3kAPLbOYtdZMDXVrSEYXEGeGnudSomlR7EOK9KHKxYFxgyC8fQtXJMRE4uufPQSlLJfOSo8ja5Ll/gHQIcowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYLGCcUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB929C4CEED;
	Tue,  2 Sep 2025 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823715;
	bh=N24nlm+kQ3jC8awxfDsEzAyVYXN9c8rmf4oiujA97ns=;
	h=From:To:Cc:Subject:Date:From;
	b=ZYLGCcUKuJW3aFhe2fn/TlqaVf2qVov4NkBm91mhBBo+8TGhP5PMRBnPWeDLMEPWI
	 n8T0sz82s9nPQCoSdHg+OCmJQtpCbNifjauTPH4BOOk8E0QKyDomKeslalBXAiqV8u
	 oAglYPNIeUqfr/0R5XQjDe5JyMc7XhUkGigqmkQcVz+nwgwEMjVgB+dEoReIrMbIhd
	 x69wByS+LrOB06FLH5/4LIbO62yk5qWoza3BsRZK30EFWFLx1+79KFIFAVQtbQ/MQE
	 ntHKxqQeyHIjoq5J5JyhieOwurJdJFeB0ba7lbztxDtGJ1x0JnTQPVTjTfvgapSaQg
	 jpq9dWVAKSk4w==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 00/11] uprobes: Add unique uprobe
Date: Tue,  2 Sep 2025 16:34:53 +0200
Message-ID: <20250902143504.1224726-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this patchset adds unique uprobe and support to change userspace
task's registers from within bpf uprobe program.

We recently had several requests for tetragon to be able to change
user application function return value or divert its execution through
instruction pointer change.

v1 changes (from rfc [1]):
- added unique probe support
- added more tests

thanks,
jirka


[1] https://lore.kernel.org/bpf/20250801210238.2207429-1-jolsa@kernel.org/
---
Jiri Olsa (11):
      uprobes: Add unique flag to uprobe consumer
      uprobes: Skip emulate/sstep on unique uprobe when ip is changed
      perf: Add support to attach standard unique uprobe
      bpf: Add support to attach uprobe_multi unique uprobe
      bpf: Allow uprobe program to change context registers
      libbpf: Add support to attach unique uprobe_multi uprobe
      libbpf: Add support to attach generic unique uprobe
      selftests/bpf: Add uprobe multi context registers changes test
      selftests/bpf: Add uprobe multi context ip register change test
      selftests/bpf: Add uprobe multi unique attach test
      selftests/bpf: Add uprobe unique attach test

 include/linux/bpf.h                                        |   1 +
 include/linux/trace_events.h                               |   2 +-
 include/linux/uprobes.h                                    |   1 +
 include/uapi/linux/bpf.h                                   |   3 +-
 kernel/events/core.c                                       |  12 ++++-
 kernel/events/uprobes.c                                    |  43 ++++++++++++++--
 kernel/trace/bpf_trace.c                                   |   7 +--
 kernel/trace/trace_event_perf.c                            |   4 +-
 kernel/trace/trace_probe.h                                 |   2 +-
 kernel/trace/trace_uprobe.c                                |   9 ++--
 tools/include/uapi/linux/bpf.h                             |   3 +-
 tools/lib/bpf/libbpf.c                                     |  36 +++++++++++---
 tools/lib/bpf/libbpf.h                                     |   8 ++-
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c        |   1 +
 tools/testing/selftests/bpf/prog_tests/uprobe.c            | 111 ++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 248 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi.c           |  38 ++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_unique.c    |  34 +++++++++++++
 18 files changed, 534 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_unique.c

