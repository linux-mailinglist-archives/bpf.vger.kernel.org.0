Return-Path: <bpf+bounces-33512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C335691E587
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6225B28226F
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D785316DC0C;
	Mon,  1 Jul 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv+e6pqG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAF13C908;
	Mon,  1 Jul 2024 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852090; cv=none; b=RYBchjnIB6eypBQX6C1fF6MS2Rtv0kZymykY0527Ajj9G9PdlZ90NROaB8m18KL4s4q6NK8/gj9+BWJPxWX4wBhJEkd3qBXZP4aO82xbKRvQ9LZlPJOh986VagoIWUPWovsyTUQ+v0fG0aFx8cVVT93vpC+6SYLvtIwLHEF4Kls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852090; c=relaxed/simple;
	bh=VfnhXIhr14f+lpsqP2ceowyzVnzWbWx+KrHHLZOIpKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MjYI+fSeIXzDJhir64O/lvylhm1dRqqzEYdOApcip8IdNX0vMU9+ehjko28CeXDm2jo/yMwBVqFws3rBpP9pW8fQHc804xzPiftrKbZAO8GgB7ygx5w6Rl+LjaG/rU84Xb3sh6SLcF+ID1+EM8CC0DLbAnI0KWDqo+Dr4jGdQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv+e6pqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B158C2BD10;
	Mon,  1 Jul 2024 16:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852089;
	bh=VfnhXIhr14f+lpsqP2ceowyzVnzWbWx+KrHHLZOIpKw=;
	h=From:To:Cc:Subject:Date:From;
	b=Yv+e6pqGy+9/OAno1z8vGGgd5GUI9tAJN0nJd6UScFF3Li3ufwSwhAHRfuXDuENAl
	 tiXVAXRDfUWTzeE569A+Sco4H9Q//hQqQFvj/TVygIcBWb6Lc6fjUqhZxxO3DaVIZZ
	 ctVtS964MjwXqidVemgoI2NF1QG0rOte0YZGMVdxMsyGlagsT863BgJGydsdMdcVI1
	 wcFgWPLkgwXh/g18bduGXXiQgc70UBzrUC2XiXdCCsTYD4Xdjo77LnpgIGda40VKob
	 OzjugahM2BtvUFzBbHFrrIfn6Vw6ugayp7Adb/sHokB7SnHD+08QzGJGIQf9EmwXW6
	 d+eH2FHKA5s4g==
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
Subject: [PATCHv2 bpf-next 0/9] uprobe, bpf: Add session support
Date: Mon,  1 Jul 2024 18:41:06 +0200
Message-ID: <20240701164115.723677-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
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

v2 changes:
  - re-implement uprobe session support [Andrii]
  - added test for mixed uprobe consumers

thanks,
jirka


---
Jiri Olsa (9):
      uprobe: Add support for session consumer
      bpf: Add support for uprobe multi session attach
      bpf: Add support for uprobe multi session context
      libbpf: Add support for uprobe multi session attach
      libbpf: Add uprobe session attach type names to attach_type_name
      selftests/bpf: Add uprobe session test
      selftests/bpf: Add uprobe session cookie test
      selftests/bpf: Add uprobe session recursive test
      selftests/bpf: Add uprobe session consumers test

 include/linux/uprobes.h                                            |  16 +++-
 include/uapi/linux/bpf.h                                           |   1 +
 kernel/bpf/syscall.c                                               |   9 ++-
 kernel/events/uprobes.c                                            | 129 ++++++++++++++++++++++++++++++---
 kernel/trace/bpf_trace.c                                           |  54 ++++++++++----
 kernel/trace/trace_uprobe.c                                        |  12 ++-
 tools/include/uapi/linux/bpf.h                                     |   1 +
 tools/lib/bpf/bpf.c                                                |   1 +
 tools/lib/bpf/libbpf.c                                             |  51 ++++++++++++-
 tools/lib/bpf/libbpf.h                                             |   4 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c         | 333 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session.c           |  53 ++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_consumers.c |  53 ++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c    |  48 ++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c |  44 +++++++++++
 15 files changed, 771 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_consumers.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c

