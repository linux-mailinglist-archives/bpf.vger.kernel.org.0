Return-Path: <bpf+bounces-44340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824579C1E48
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5E51C20F1A
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACBC1EE03C;
	Fri,  8 Nov 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf37ETsR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787C1E1C29;
	Fri,  8 Nov 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073554; cv=none; b=snPXurTeJiOOUNjZMtjQUUZzUajeWdvxYl66Ak/ik8Zb2EW3d1VG0/jSH3zAlbzonf0hZJXdTAbVqnMVgE9t9Uq+iDuG++SaCRNPxEdv84knkEr/u2HGe7La/TOfNeyxSwaL2eUKbiUwd5QrrDgQPGAxHhCRaZb5ewgcDyTvhXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073554; c=relaxed/simple;
	bh=DlaqznImQXYX1sv03yCEQEkG4Rcr3MjdRRGOPmOm12U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j0JShK1jyqKDeE82rS4FqDjAlmLDlYMpRpOcflFqnqt66t9ZOZuEKuOogy/jwL1t8jz0pq10s4sCPaxMMI3COvAXZPfe44pp5qVuBqldwMdFM+oUI1vVzaKV3TcHDf8uzqCKlw/ftWW+WoQxxN/esZXUYxNyX5thJTsjKHlny9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf37ETsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F709C4CECD;
	Fri,  8 Nov 2024 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731073553;
	bh=DlaqznImQXYX1sv03yCEQEkG4Rcr3MjdRRGOPmOm12U=;
	h=From:To:Cc:Subject:Date:From;
	b=Rf37ETsR2eZkx91LRDuGsTf7omjQET03oDI6ONerOec1cq6UBvGHKvSOmdBGvE63I
	 IwfqJ2Z/m2NRWn6xfmCez1fDNUFSunP6Iz+zEXwn+ttNObqpYy6eSnYIlcTJ3R0fcS
	 mcr9opoUND8W2afFjoQQu6jcUJ5QTXWoGtyMRT+x4S+THljzmt//gLf13mi/LePUi2
	 wXHNHDPN9hEAy3waLJp29NeqoO9ZnJWPKy5F4O0khM6t/MpO1KhC9KIm7KqJiw887m
	 S9t1sbBFKd+1TnZnT6G+qG6/TucbrcmKqGTaO3RtKxKfQB6amcYr8PkzbEmm3Xyi35
	 tcsABoGWU8Cow==
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
Subject: [PATCHv9 bpf-next 00/13] bpf: Add uprobe session support
Date: Fri,  8 Nov 2024 14:45:31 +0100
Message-ID: <20241108134544.480660-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
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

v9 changes:
  - rebased on bpf-next/master with perf/core tag merged (thanks Peter!)

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
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c         | 337 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c          |  31 ++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c         |   6 +-
 tools/testing/selftests/bpf/progs/uprobe_multi_session.c           |  71 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c    |  48 ++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c |  44 +++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c    |  44 +++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c          |  31 ++++++++
 17 files changed, 653 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c

