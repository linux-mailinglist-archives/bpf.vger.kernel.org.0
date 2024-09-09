Return-Path: <bpf+bounces-39269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3797100D
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069C3282BAD
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E221B0100;
	Mon,  9 Sep 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPvywAhd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9788172BCE;
	Mon,  9 Sep 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867961; cv=none; b=rdUHw9IdBB9lk/JqL6K9cYrS2KxPXP7hvNWaGAi4ekhhTLEWf+BCzpAWj0/5QR4CUAxMiG0DkE2ynVlTpQyWAFC6XYLdSl5qpPC6gjxXKZbTOJy0QJtIs8vS4qBaezaolNevn3/htDybR/lHy/RfNPwDBV8uSgsYKf0iUHuAzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867961; c=relaxed/simple;
	bh=hkp2XJ44C4h1Dc+ECWxmdqBOBf3WyFmB4ocsNaK+RlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kaDSLPVW8jDMQ18g4YvPmTlfzRfVOL/IpxMcvHIGKKpYzVtcXqJMqlBvEWLukXlysARYsWnfEJMusYotXoeUVs534pS3jr+GHWoK7+lx9x3tWERiEHiLjrIiKQH/lg3/45MufG2WlM12wmydqU+pKay/iSP7tVOcf0J/u99Weuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPvywAhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CEBC4CEC5;
	Mon,  9 Sep 2024 07:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725867960;
	bh=hkp2XJ44C4h1Dc+ECWxmdqBOBf3WyFmB4ocsNaK+RlI=;
	h=From:To:Cc:Subject:Date:From;
	b=UPvywAhdSXEskazgRTWGQNdRRSlw5O9srgZ49TjXd36DDxtLbYZ21SlylJfEUkgM2
	 O1cRdERx6tLzt4Oz+NLdhgpmmotA84nR2Uu5Firopi1URYV2U+rTTDvyjTNc+QGp7I
	 iEc8NszpCIFNIytojilPP4ic23QBQgh1vu9Xqz+yw0/jwnbo2Bvzx8mI8Pig3acXYI
	 0tImGc0vMiXzUcjlPd1sfs4Q2wQXis2uzD0FK3+2vYn6UtrdKJdZKflNw+v2cvvFLv
	 pqi7rPlIG2Rdz+ptgBv+oYLOYvPGZ5Vks6ZkjCmJmNjb2CBUmz+7scsr0onxH+6I7G
	 2dDe65sk0i7kg==
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
Subject: [PATCHv3 0/7] uprobe, bpf: Add session support
Date: Mon,  9 Sep 2024 09:45:47 +0200
Message-ID: <20240909074554.2339984-1-jolsa@kernel.org>
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

On more details please see patch #1.

It's based on Peter's perf/core:
  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core


v3 changes:
  - rebased on top of Andrii's recent changes in Peter's perf/core [2]
  - I kept the session cookie instead of introducing generic session
    data, because it makes the change much more complicated, I think
    it can be added as a followup if it's needed
  - addressed several small review fixes [Andrii]
  - added uprobe.session.s section and test [Andrii]
  - kept acks from previous version on patches that did not change

thanks,
jirka


---
Jiri Olsa (7):
      uprobe: Add support for session consumer
      bpf: Add support for uprobe multi session attach
      bpf: Add support for uprobe multi session context
      libbpf: Add support for uprobe multi session attach
      selftests/bpf: Add uprobe session test
      selftests/bpf: Add uprobe session cookie test
      selftests/bpf: Add uprobe session recursive test

 include/linux/uprobes.h                                            |  17 +++++++++--
 include/uapi/linux/bpf.h                                           |   1 +
 kernel/bpf/syscall.c                                               |   9 ++++--
 kernel/events/uprobes.c                                            | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 kernel/trace/bpf_trace.c                                           |  59 ++++++++++++++++++++++++++-----------
 kernel/trace/trace_uprobe.c                                        |  12 +++++---
 tools/include/uapi/linux/bpf.h                                     |   1 +
 tools/lib/bpf/bpf.c                                                |   1 +
 tools/lib/bpf/libbpf.c                                             |  51 ++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h                                             |   4 ++-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c              |   2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c         | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session.c           |  71 ++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c    |  48 ++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c |  44 ++++++++++++++++++++++++++++
 15 files changed, 531 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c

