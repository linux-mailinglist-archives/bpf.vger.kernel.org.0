Return-Path: <bpf+bounces-42468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED59A4848
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA15B282D1E
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF02076B8;
	Fri, 18 Oct 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOHnhjEJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5B205E34;
	Fri, 18 Oct 2024 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284079; cv=none; b=p6jxflqwivJqbQ/786FDLRXUkNDFKp7xynZYeGVUdUvtvgF3e3XaYID2wE8oCD1XS6fLMQHSFL2CfypcXfUBDKHizH+qXoi3/QqFVIEdBOJbA8h08Ivh0lITkNTbLzT9/QkoeqzQSkaFoCTS484O9xr1PgPdk3P2hmvTBVPHmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284079; c=relaxed/simple;
	bh=3w86+D41DnoNc+KtLo6d91LXVAVERGefsyWQQhrHJt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I5Ah3IhLfQ0xJJGEmQV1NIYdK5gfTrj7h88FSJu1qm3YkLOkuJFSEfJlV5EBtgKnqseKnPRshIfCdn6WTUYg2R75x3+Q5sLGqUPKBXKj8bLbbWFOY9bvYyNlXQ6+vRzSXgpBP/YFHS6b5AXSs+tr1HpdPy4QlyssweetQiYtrN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOHnhjEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EA6C4CEC3;
	Fri, 18 Oct 2024 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729284078;
	bh=3w86+D41DnoNc+KtLo6d91LXVAVERGefsyWQQhrHJt8=;
	h=From:To:Cc:Subject:Date:From;
	b=lOHnhjEJdHpqMfOMj4xyFmO/IyiTAWM7/C+L3C+iOsd4iwonV3geQBIjPFUNq0rjL
	 1s0U7EcFDavmAc4sHVuoBa5tDsWVgRqy0A2K2Sx1CJv8rikAfZoIfTTpZ6Q85fVNub
	 8menN/oyDvtil0JbuHBn/QBWN4leyC8pXyw2DROqFy5tF8CYrKutaZd6ZsAFG2PW0v
	 REvM6NXoitjctucCfCOzjOOv4B8MtclhigXnjQ8TejzuiMd5UcO7eNw2XIjB2zJFII
	 pP7uyxox1xahfst7xqO57ctmGL0yLZFtRtbVh6EDxvqqDFKwMo2s8S64Y2gPcMr1tM
	 p1Ozk4Ri8hUiA==
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
Subject: [PATCHv8 bpf-next 00/13] bpf: Add uprobe session support
Date: Fri, 18 Oct 2024 22:40:56 +0200
Message-ID: <20241018204109.713820-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
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

Uprobe changes (on top of perf/core [1] are posted in here [2].
This patchset is based on bpf-next/master and will be merged once
we pull [2] in bpf-next/master.

v8 changes:
  - split and sepatate only the bpf-next/master patches
  - rebased and reposted to proper ppl/lists

thanks,
jirka


[1] git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
[2] https://lore.kernel.org/bpf/20241018202252.693462-1-jolsa@kernel.org/T/#ma43c549c4bf684ca1b17fa638aa5e7cbb46893e9
---
Jiri Olsa (13):
      bpf: Allow return values 0 and 1 for kprobe session
      bpf: Force uprobe bpf program to always return 0
      bpf: Add support for uprobe multi session attach
      bpf: Add support for uprobe multi session context
      libbpf: Add support for uprobe multi session attach
      selftests/bpf: Add uprobe session test
      selftests/bpf: Add uprobe session cookie test
      selftests/bpf: Add uprobe session recursive test
      selftests/bpf: Add uprobe session verifier test for return value
      selftests/bpf: Add kprobe session verifier test for return value
      selftests/bpf: Add uprobe session single consumer test
      selftests/bpf: Add uprobe sessions to consumer test
      selftests/bpf: Add threads to consumer test

 include/uapi/linux/bpf.h                                           |   1 +
 kernel/bpf/syscall.c                                               |   9 ++-
 kernel/bpf/verifier.c                                              |  10 +++
 kernel/trace/bpf_trace.c                                           |  57 +++++++++++----
 tools/include/uapi/linux/bpf.h                                     |   1 +
 tools/lib/bpf/bpf.c                                                |   1 +
 tools/lib/bpf/libbpf.c                                             |  19 ++++-
 tools/lib/bpf/libbpf.h                                             |   4 +-
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c         |   2 +
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c         | 336 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c          |  31 ++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c         |   6 +-
 tools/testing/selftests/bpf/progs/uprobe_multi_session.c           |  71 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c    |  48 ++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c |  44 +++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c    |  44 +++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c          |  31 ++++++++
 17 files changed, 654 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c

