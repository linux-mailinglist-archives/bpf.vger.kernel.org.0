Return-Path: <bpf+bounces-40515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F3989768
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 22:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6B32830DB
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9DC13BC2F;
	Sun, 29 Sep 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7hQhK4D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789418EB0;
	Sun, 29 Sep 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643445; cv=none; b=RpLkAkPcm6O9dgl5iitZnsnW8GFfPZUFz2YWr3wzH/qTHV9KzftrIJmSmAai/Y2VnDbQY1PiOYGG2UC7aob282udMbjWnXEGTKZ9MBzbOGGu9/zzqd5MpuydzC2enI6oa9PkFsAZkD3lUO88M/4r5XXkg3tuiPq2RCpwZg5ffKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643445; c=relaxed/simple;
	bh=Suqh0zl7SOWbmpoXGqTt1K3EKX7jBF08yX+TqSXmcHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wpz5dcogmHPiWcuBFUosuo/jMsAALfAX3d+o7WGWSTSSrFOuYoyt+hWyYfceILBeMaRdB6pUX1dOd5V7JT7ZzwlVRmBPV5lVepkdbM2uzCV7GTwoXtqoqNGnBmUGX2PC/M8Hl5xpdnszR6VRgi0DXhhMObSUU0yfSK9kZshCtOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7hQhK4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B131CC4CEC5;
	Sun, 29 Sep 2024 20:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727643444;
	bh=Suqh0zl7SOWbmpoXGqTt1K3EKX7jBF08yX+TqSXmcHM=;
	h=From:To:Cc:Subject:Date:From;
	b=O7hQhK4DI5DnfTeNCamnKEN3ZiNVwBGYk+gzwN578XGS5VXfAABv7up7iGXViLUj+
	 OdxowpUbOmoALhGY+PbyfDmjAhC5sHIt32LcflH7smkL3kgwFYahtdyhfT9gGd4Bgr
	 pG9S5W/IR9Dd90JOP0zx/L6jLENBA7yxBgPBhTlAUDt3mfX0B21AefZo/XAs1tbz1X
	 fPPAdMApbdsfbmXsRHnGd9ePEJqv1qXtq/BxNAmU1op0CELIVYTqHGx/EXlcgMTIY7
	 xl4fht350hRaXLyxOeR4eXVhX9YfUkIiFeythI5uiEPxwcrNZkFGVTCE34+UYjzPBn
	 sbBrjSVpEo+nQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv5 bpf-next 00/13] uprobe, bpf: Add session support
Date: Sun, 29 Sep 2024 22:57:04 +0200
Message-ID: <20240929205717.3813648-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this patchset is adding support for session uprobe attachment and
using it through bpf link for bpf programs.

The session means that the uprobe consumer is executed on entry
and return of probed function with additional control:
  - entry callback can control execution of the return callback
  - entry and return callbacks can share data/cookie

On more details please see patch #2.

Kernel uprobe changes are applicable on Peter's perf/core:
  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core

The whole patchset is based on bpf-next/master because the tooling
bits need changes that are not yet merged in peter's tree.

v5 changes:
  - removed IWANTMYCOOKIE return value, instead we pass cookie when both
    'handler' and 'ret_handler' callbacks are defined in consumer [Andrii]
  - move return_consumer_find call under uc->ret_handler check [Oleg] 
  - dropped uprobe stress selftest, don't think it's needed

thanks,
jirka


---
Jiri Olsa (13):
      uprobe: Add data pointer to consumer handlers
      uprobe: Add support for session consumer
      bpf: Add support for uprobe multi session attach
      bpf: Add support for uprobe multi session context
      bpf: Allow return values 0 and 1 for uprobe/kprobe session
      libbpf: Add support for uprobe multi session attach
      selftests/bpf: Add uprobe session test
      selftests/bpf: Add uprobe session cookie test
      selftests/bpf: Add uprobe session recursive test
      selftests/bpf: Add uprobe session verifier test for return value
      selftests/bpf: Add kprobe session verifier test for return value
      selftests/bpf: Add uprobe session single consumer test
      selftests/bpf: Add uprobe sessions to consumer test

 include/linux/uprobes.h                                            |  25 +++++++--
 include/uapi/linux/bpf.h                                           |   1 +
 kernel/bpf/syscall.c                                               |   9 +++-
 kernel/bpf/verifier.c                                              |  10 ++++
 kernel/events/uprobes.c                                            | 148 +++++++++++++++++++++++++++++++++++++++++------------
 kernel/trace/bpf_trace.c                                           |  66 +++++++++++++++++-------
 kernel/trace/trace_uprobe.c                                        |  12 +++--
 tools/include/uapi/linux/bpf.h                                     |   1 +
 tools/lib/bpf/bpf.c                                                |   1 +
 tools/lib/bpf/libbpf.c                                             |  22 ++++++--
 tools/lib/bpf/libbpf.h                                             |   4 +-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c              |   2 +-
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c         |   2 +
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c         | 233 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c          |  31 ++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c         |  16 +++++-
 tools/testing/selftests/bpf/progs/uprobe_multi_session.c           |  71 ++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c    |  48 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c |  44 ++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c    |  44 ++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c          |  31 ++++++++++++
 21 files changed, 744 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c

