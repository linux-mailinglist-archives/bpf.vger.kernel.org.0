Return-Path: <bpf+bounces-40023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0202597AD10
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3942834A6
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D3C158A13;
	Tue, 17 Sep 2024 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpZ641AA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499515667E;
	Tue, 17 Sep 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563032; cv=none; b=a2HRa87fB25N0g2AalobNCWQF18crZLjFtn+omKk+lT8/hqFHTIPeodLLtNabNt5n9npltRM2HsaYJQg2o4WHXoQvjZcY9HOaTSaIKJt0/DoEebThyivjWQl21RJPux1oSLILSDx/RZaW0zD6I2IT+X+1RwlWZ2nei9lgTmgfoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563032; c=relaxed/simple;
	bh=h/QmTo1KvZhaAd/PjbHW8qmqQposFpAVwPsudk425Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZqUFjJwf11jvDrXtsLhVN6ib60ES60VzT3qzTOof+EqseZ3MDwym97mgJEYHTQXrcmu8h/X1Mx4trsX4wD3wounBPAA8CCd/jZJWeBRE39CM5hxdvtCsVLXxfVTNgEhhJhynKOBPSDOUF6JkkZbUpitERasXnPAfQ2w8d9cxmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpZ641AA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389DCC4CEC6;
	Tue, 17 Sep 2024 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563032;
	bh=h/QmTo1KvZhaAd/PjbHW8qmqQposFpAVwPsudk425Lc=;
	h=From:To:Cc:Subject:Date:From;
	b=WpZ641AAsui1/5e6nz19v9VvtTsriJgA1g7mSdZlSVSKcZC7xYW80YL+FNeiFo1pO
	 YZ6R6FCTuIGKsAbTGulnf4Q3WvtLeYR9WwQ4RuxKrb/Rn81Y+ayIU5pjbkq2JUzUDx
	 Kn13T9q00Ho9B7k/HfWahok/kkelJdDRt6DDgRpM/j866YHjKipgmk45KGquR97X8P
	 4RmqlptlymkjIUejdcHQB8mKGnKOZakEgnTPz2NWGY8kAHvAo1FsnQEIAyf3SX8xPx
	 a2W8orqyAa72C5SjPrNi04E+zGjRfB0NavpsY6OfupFx5IHc2sJpJoEhnBbOSumYP8
	 kmrBFskf1cclA==
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
Subject: [PATCHv4 00/14] uprobe, bpf: Add session support
Date: Tue, 17 Sep 2024 10:50:10 +0200
Message-ID: <20240917085024.765883-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
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

It's based on Peter's perf/core:
  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core

v4 changes:
  - rework the uprobe consumer allocation based on Oleg's suggestions [Oleg]
  - moved docs about handler return values to uprobes.h header [Oleg]
  - use libbpf's attach_uprobe_multi for session attach [Andrii]
  - make verifier to check session return values [Andrii]
  - various small review changes
  - added more tests
  - added acks

patch #6 is already in bpf-next tree, but we need that as dependency

thanks,
jirka


---
Jiri Olsa (14):
      uprobe: Add data pointer to consumer handlers
      uprobe: Add support for session consumer
      bpf: Add support for uprobe multi session attach
      bpf: Add support for uprobe multi session context
      bpf: Allow return values 0 and 1 for uprobe/kprobe session
      libbpf: Fix uretprobe.multi.s programs auto attachment
      libbpf: Add support for uprobe multi session attach
      selftests/bpf: Add uprobe session test
      selftests/bpf: Add uprobe session cookie test
      selftests/bpf: Add uprobe session recursive test
      selftests/bpf: Add uprobe session verifier test for return value
      selftests/bpf: Add kprobe session verifier test for return value
      selftests/bpf: Add uprobe session single consumer test
      selftests/bpf: Add consumers stress test on single uprobe

 include/linux/uprobes.h                                            |  29 +++++++++-
 include/uapi/linux/bpf.h                                           |   1 +
 kernel/bpf/syscall.c                                               |   9 ++-
 kernel/bpf/verifier.c                                              |  10 ++++
 kernel/events/uprobes.c                                            | 150 ++++++++++++++++++++++++++++++++++++++++----------
 kernel/trace/bpf_trace.c                                           |  66 ++++++++++++++++------
 kernel/trace/trace_uprobe.c                                        |  12 ++--
 tools/include/uapi/linux/bpf.h                                     |   1 +
 tools/lib/bpf/bpf.c                                                |   1 +
 tools/lib/bpf/libbpf.c                                             |  22 +++++++-
 tools/lib/bpf/libbpf.h                                             |   4 +-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c              |   2 +-
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c         |   2 +
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c         | 252 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c          |  31 +++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_consumer_stress.c   |  29 ++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session.c           |  71 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c    |  48 ++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c |  44 +++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c    |  44 +++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c          |  31 +++++++++++
 21 files changed, 798 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_consumer_stress.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c

