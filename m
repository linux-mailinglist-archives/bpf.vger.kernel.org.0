Return-Path: <bpf+bounces-68557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7747B5A447
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A676F1727BE
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE6B31FECA;
	Tue, 16 Sep 2025 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og4NIeTC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4CF29B796;
	Tue, 16 Sep 2025 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059588; cv=none; b=jpzhRfxHmroWD0fsxiZET0EkQHmz9owVCALWR44aSn3Z2Edxeob4qJzbBhZcqJM+I3OjNJHzODb8YlMDg9tdTTlNeSWwPIqv0Y9iTq1lb9BBRWXMF054BfRkr7XZY2WbM0b2bM3jqIIeoSf3nwybUUDlwJd1hXvI2K4o7auPWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059588; c=relaxed/simple;
	bh=4ea4qh1sUkV8Bj/GBxDdwCshflmkWqDAlZdAmpWsCys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGnEnOYf8RS9Ync9GJQ0thlf70wT5bPDrLfemdQWN+qgikozPEEDpDc0wAmrChcW6CZ2IfigbOBZdhs7xuS7WOkgg0EHgFxBGpDkhUfHcjSu6Vu6sXsHLdjRPbdLvvcUO4mnjtUPvZ3Z8JD/uqQUN902sUeUZUkZJnu0Y4NcnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og4NIeTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5159C4CEEB;
	Tue, 16 Sep 2025 21:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758059588;
	bh=4ea4qh1sUkV8Bj/GBxDdwCshflmkWqDAlZdAmpWsCys=;
	h=From:To:Cc:Subject:Date:From;
	b=og4NIeTCQlO3q57iYyyButEKTntFlai27NYkF+tiVpz3vahWcXhfNUZ/ZukLTz/vc
	 X44b9EiYywo/Cqy79WWcoszE6fhSOrcXWovgNa+NypNe92G8ZnLsTUCwXgA7m4y7o9
	 2MbZC+q6/lpOYgbduXKxbAW8QQLq0zhQEnS/NzDrqMTcNMzkg9yDLOtjt4T+cxgRQN
	 v/FFzOvwlBbbYVPwDNbSmYRnrH3gYYPnrv6NeCZfcy1x8kMHyf9MlWUDyK8IzAZjit
	 gseDvuEcxUv8yr1c9bjPCG6yTEBjJqYzYI2rd21S0ZQS0awg5AsF+s4NJJ4yChHYsU
	 xF43LV44UyWqA==
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
Subject: [PATCHv4 bpf-next 0/6] uprobe,bpf: Allow to change app registers from uprobe registers
Date: Tue, 16 Sep 2025 23:52:55 +0200
Message-ID: <20250916215301.664963-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we recently had several requests for tetragon to be able to change
user application function return value or divert its execution through
instruction pointer change.

This patchset adds support for uprobe program to change app's registers
including instruction pointer.

v4 changes:
- rebased on bpf-next/master, we will handle the future simple conflict
  with tip/perf/core
- changed condition in kprobe_prog_is_valid_access [Andrii]
- added acks

thanks,
jirka


---
Jiri Olsa (6):
      bpf: Allow uprobe program to change context registers
      uprobe: Do not emulate/sstep original instruction when ip is changed
      selftests/bpf: Add uprobe context registers changes test
      selftests/bpf: Add uprobe context ip register change test
      selftests/bpf: Add kprobe write ctx attach test
      selftests/bpf: Add kprobe multi write ctx attach test

 include/linux/bpf.h                                        |   1 +
 kernel/events/core.c                                       |   4 +++
 kernel/events/uprobes.c                                    |   7 +++++
 kernel/trace/bpf_trace.c                                   |   9 ++++--
 tools/testing/selftests/bpf/prog_tests/attach_probe.c      |  28 +++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c |  27 ++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/uprobe.c            | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/kprobe_write_ctx.c       |  22 +++++++++++++
 tools/testing/selftests/bpf/progs/test_uprobe.c            |  38 +++++++++++++++++++++++
 9 files changed, 289 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_write_ctx.c

