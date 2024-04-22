Return-Path: <bpf+bounces-27402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B9E8ACC97
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBA81C22755
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7893D146D66;
	Mon, 22 Apr 2024 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlvudMG3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B3413E40D
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787967; cv=none; b=MA1usbyL82MgvKM1pIIztY+Kzq4RkkMHhM+e46YujYL3fVSHbtqClLWrNgHiG9/u5y0FPG42NUn3YXVd6VPILmQ6KIr/SCECoHgDbXTCJypcSKImLyGmZ7TA844QZDiBpegE8huIiOWVmNC1ssyqgwMH/gRziQ+TkRHOXcpMQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787967; c=relaxed/simple;
	bh=4+3QDNfQimwXwE99o5xUQpsmIH/oHnKTRg7CLsZPMco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rx3xbiMCl60VqUY6BjZoGKfNz1TK9U7uzJEpMUDOMCWxIH2sX66fwzx83Rw7rxHaGwHN6aoaBztZ1CN5AESsS59+ZDkmgoBx+eazI+lrt59lgX/IMkouVKLpyZOAHTE7btAwOauqeS+Vu5y5qd6EWZ6AvCp5TBnR9uwb5H00q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlvudMG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE16C113CC;
	Mon, 22 Apr 2024 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713787966;
	bh=4+3QDNfQimwXwE99o5xUQpsmIH/oHnKTRg7CLsZPMco=;
	h=From:To:Cc:Subject:Date:From;
	b=QlvudMG3wgiONlswXDo+fhLB+YYJX57U8m3zWpyP0aplI7uXrR8sc9nd4yTG7o2vw
	 /Zr/uEFPDZVSvH9r9WVwjYVjm4GHINPyo2okdb1qN41Pkg2z7qwlXBMPsx8gZQle+8
	 AAdep1L2eRU1yCyo2DXcQzFU/od6d7nMzRCw/1PQYQvW+xdA/9DNh0M9SY+9ayABKO
	 at679yD0ZAib7hNHB6v14iL3WmywiXCRvmrWklKbJku6GFyUAC/dszCuf5kAjKIt3n
	 vCmpdax+Hn6QBXFOgmDYVAYAeMFCu49c7e/vjv2EFsV2kfCpOphoI5zT+F9JRlyp+L
	 jQOrOlM9nIQNA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
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
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH bpf-next 0/7] bpf: Introduce kprobe_multi session attach
Date: Mon, 22 Apr 2024 14:12:34 +0200
Message-ID: <20240422121241.1307168-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding support to attach kprobe program through kprobe_multi link
in a session mode, which means:
  - program is attached to both function entry and return
  - entry program can decided if the return program gets executed
  - entry program can share u64 cookie value with return program

The initial RFC for this was posted in [0] and later discussed more
and which ended up with the session idea [1]

Having entry together with return probe for given function is common
use case for tetragon, bpftrace and most likely for others.

At the moment if we want both entry and return probe to execute bpf
program we need to create two (entry and return probe) links. The link
for return probe creates extra entry probe to setup the return probe.
The extra entry probe execution could be omitted if we had a way to
use just single link for both entry and exit probe.

In addition the possibility to control the return program execution
and sharing data within entry and return probe allows for other use
cases.

Changes from last RFC version [1]:
  - changed wrapper name to session 
  - changed flag to adding new attach type for session:
      BPF_TRACE_KPROBE_MULTI_SESSION
    it's more convenient wrt filtering on kfuncs setup and seems
    to make more sense alltogether
  - renamed bpf_kprobe_multi_is_return to bpf_session_is_return
  - added bpf_session_cookie kfunc, which actually already works
    on current fprobe implementation (not just fprobe-on-fgraph)
    and it provides the shared data between entry/return probes [Andrii]

    we could actually make the cookie size configurable.. thoughts?
    (it's 8 bytes atm)

  - better attach setup conditions changes [Andrii]
  - I'm not including uprobes change atm, because it needs extra
    uprobe change so I'll post it separately

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/session_data

thanks,
jirka


[0] https://lore.kernel.org/bpf/20240207153550.856536-1-jolsa@kernel.org/
[1] https://lore.kernel.org/bpf/20240228090242.4040210-1-jolsa@kernel.org/
---
Jiri Olsa (7):
      bpf: Add support for kprobe multi session attach
      bpf: Add support for kprobe multi session context
      bpf: Add support for kprobe multi session cookie
      libbpf: Add support for kprobe multi session attach
      libbpf: Add kprobe session attach type name to attach_type_name
      selftests/bpf: Add kprobe multi session test
      selftests/bpf: Add kprobe multi wrapper cookie test

 include/uapi/linux/bpf.h                                        |   1 +
 kernel/bpf/btf.c                                                |   3 +++
 kernel/bpf/syscall.c                                            |   7 +++++-
 kernel/bpf/verifier.c                                           |   7 ++++++
 kernel/trace/bpf_trace.c                                        | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 tools/include/uapi/linux/bpf.h                                  |   1 +
 tools/lib/bpf/bpf.c                                             |   1 +
 tools/lib/bpf/libbpf.c                                          |  41 ++++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h                                          |   4 +++-
 tools/testing/selftests/bpf/bpf_kfuncs.h                        |   3 +++
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c      |  84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kprobe_multi_session.c        | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c |  56 ++++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 396 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c

