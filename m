Return-Path: <bpf+bounces-31374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F4D8FBCE7
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B178C1C21FE4
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856614A634;
	Tue,  4 Jun 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2hvvJec"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934A2F25;
	Tue,  4 Jun 2024 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531353; cv=none; b=mQqHeyP1hB33Dbcq4JjuxviC5sBKvF79zwZPf/v4x6WAgHF+6Olr9hTo47tFoc/lTMN4UaXDjLkzDHxEHQPVSS34EMuxhIG6JNT4XFyYgSMQHhR6dgHFEYah/N8q9KYfQUO6Cc4JZOFlJQ1Sl5VIjh1uRsFZ3qhHNRb6SXx/Ajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531353; c=relaxed/simple;
	bh=C03j361njVg4JXjPqtmUFvHRfGoTtT0HMO6MWEnBjD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNFjkpocRdVty6MDatZwDBUnqyCGV5bOG5cfdoOFp8UZ02JQj7pEYHiNK434atXOmzxQabTa2GOryijkX0uNUdD4WHv486gDMfh7hDH2x56yyuCaHeLdtuL+bFhyoj4/tHrmxWbEVJsEskottoyJoNsVUtEyqNHREZ3APrLTF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2hvvJec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69386C2BBFC;
	Tue,  4 Jun 2024 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531352;
	bh=C03j361njVg4JXjPqtmUFvHRfGoTtT0HMO6MWEnBjD4=;
	h=From:To:Cc:Subject:Date:From;
	b=P2hvvJec59HIjb+GZyxy03zJn2BlxDfq6sbLaCZ5Atpi+j8EaeOZncwNmzFYiywbo
	 UnY8pTupbLpVXDtgOdiTkJDW1qxltXliyK8NwWwHQ+2SGzs0RsHxK5ioCZfNBhR6EZ
	 FiDYoNth9CCsfdZEH8y/r0YnlUyKmo6uu7cy4WKlHEuO9iI3qO4gc7GpP2rvPX88vR
	 T9k1onrmgU2tyWhvQGFzifD1Wgn0wTunq3SxdYstSbHpIuJBq4RbwhXg5Hg5zJStnN
	 fRg+e5GH6yl4gGyp4VsMQ5KIFdnKA3yHUgjzmdv0ouA1DzkusDpFcfHrIXEdltP0JJ
	 Yd8U9vnJp2d6w==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC bpf-next 00/10] uprobe, bpf: Add session support
Date: Tue,  4 Jun 2024 22:02:11 +0200
Message-ID: <20240604200221.377848-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this patchset is adding support for session uprobe attachment
and using it through bpf link for bpf programs.

The session means that the uprobe consumer is executed on entry
and return of probed function with additional control:
  - entry callback can control execution of the return callback
  - entry and return callbacks can share data/cookie

On more details please see patch #1.

thanks,
jirka


---
Jiri Olsa (10):
      uprobe: Add session callbacks to uprobe_consumer
      bpf: Add support for uprobe multi session attach
      bpf: Add support for uprobe multi session context
      libbpf: Add support for uprobe multi session attach
      libbpf: Add uprobe session attach type names to attach_type_name
      selftests/bpf: Move ARRAY_SIZE to bpf_misc.h
      selftests/bpf: Add uprobe session test
      selftests/bpf: Add uprobe session errors test
      selftests/bpf: Add uprobe session cookie test
      selftests/bpf: Add uprobe session recursive test

 include/linux/uprobes.h                                            |  18 ++++++++++
 include/uapi/linux/bpf.h                                           |   1 +
 kernel/bpf/syscall.c                                               |   9 +++--
 kernel/events/uprobes.c                                            |  69 +++++++++++++++++++++++++++++++++-----
 kernel/trace/bpf_trace.c                                           |  72 +++++++++++++++++++++++++++++++---------
 tools/include/uapi/linux/bpf.h                                     |   1 +
 tools/lib/bpf/bpf.c                                                |   1 +
 tools/lib/bpf/libbpf.c                                             |  51 ++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h                                             |   4 ++-
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c         | 153 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h                       |   2 ++
 tools/testing/selftests/bpf/progs/iters.c                          |   2 --
 tools/testing/selftests/bpf/progs/kprobe_multi_session.c           |   3 +-
 tools/testing/selftests/bpf/progs/linked_list.c                    |   5 +--
 tools/testing/selftests/bpf/progs/netif_receive_skb.c              |   5 +--
 tools/testing/selftests/bpf/progs/profiler.inc.h                   |   5 +--
 tools/testing/selftests/bpf/progs/setget_sockopt.c                 |   5 +--
 tools/testing/selftests/bpf/progs/test_bpf_ma.c                    |   4 ---
 tools/testing/selftests/bpf/progs/test_sysctl_loop1.c              |   5 +--
 tools/testing/selftests/bpf/progs/test_sysctl_loop2.c              |   5 +--
 tools/testing/selftests/bpf/progs/test_sysctl_prog.c               |   5 +--
 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c      |   1 +
 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h      |   2 --
 tools/testing/selftests/bpf/progs/uprobe_multi_session.c           |  52 +++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c    |  50 ++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c |  44 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c     |   2 --
 27 files changed, 507 insertions(+), 69 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c

