Return-Path: <bpf+bounces-6352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A707685AE
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C4C2817E5
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09A72102;
	Sun, 30 Jul 2023 13:42:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67412363
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 13:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC04C433C7;
	Sun, 30 Jul 2023 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690724548;
	bh=gNAYvcn8dkYg1j7qB7qcZgydH8KCO3Wswu3Z4Eyjaso=;
	h=From:To:Cc:Subject:Date:From;
	b=tpzLiWZpozHdGUX10EEW7CN2lB8BklvE+HYs2cpUjIz8WeYeJ1GirhIRl959CuL3u
	 EL8xNYT0Bk+oU73NV+pR6fl9G2Lp0hX7Tnpc4CpI13UFXjd9f3g71kGECNtWRwcmfk
	 nFgFeI1AUndbiFiKmfWwl9Nb4X7NqNGtPz0UtI8MDz4iC5bqJeoSI8AttQN+xJqMHw
	 icNN7RwKKWoKgCXzd1a/Ce/qUvSwx3bE7JjgthCm/BTvkxmlGSHp2lmTm6p4Pc5SwL
	 cJj3061GWYb+tegHc0ejoCtuwWiBBVo+/hOTKzkPOtByJpwV3WV86XHDG7Xeb46YZT
	 j8XMEbdSn+6Kw==
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv5 bpf-next 00/28] bpf: Add multi uprobe link
Date: Sun, 30 Jul 2023 15:41:55 +0200
Message-ID: <20230730134223.94496-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this patchset is adding support to attach multiple uprobes and usdt probes
through new uprobe_multi link.

The current uprobe is attached through the perf event and attaching many
uprobes takes a lot of time because of that.

The main reason is that we need to install perf event for each probed function
and profile shows perf event installation (perf_install_in_context) as culprit.

The new uprobe_multi link just creates raw uprobes and attaches the bpf
program to them without perf event being involved.

In addition to being faster we also save file descriptors. For the current
uprobe attach we use extra perf event fd for each probed function. The new
link just need one fd that covers all the functions we are attaching to.

v5 changes:
  - fixed BPF_LINK_CREATE_LAST_FIELD [Yafang Shao]
  - rebased to latest bpf-next/master
  - small changes in pid test

There's support for bpftrace [2] and tetragon [1].

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  uprobe_multi

thanks,
jirka


[1] https://github.com/cilium/tetragon/pull/936
[2] https://github.com/iovisor/bpftrace/compare/master...olsajiri:bpftrace:uprobe_multi
[3] https://lore.kernel.org/bpf/20230628115329.248450-1-laoar.shao@gmail.com/
---
Jiri Olsa (28):
      bpf: Switch BPF_F_KPROBE_MULTI_RETURN macro to enum
      bpf: Add attach_type checks under bpf_prog_attach_check_attach_type
      bpf: Add multi uprobe link
      bpf: Add cookies support for uprobe_multi link
      bpf: Add pid filter support for uprobe_multi link
      bpf: Add bpf_get_func_ip helper support for uprobe link
      libbpf: Add uprobe_multi attach type and link names
      libbpf: Move elf_find_func_offset* functions to elf object
      libbpf: Add elf_open/elf_close functions
      libbpf: Add elf symbol iterator
      libbpf: Add elf_resolve_syms_offsets function
      libbpf: Add elf_resolve_pattern_offsets function
      libbpf: Add bpf_link_create support for multi uprobes
      libbpf: Add bpf_program__attach_uprobe_multi function
      libbpf: Add support for u[ret]probe.multi[.s] program sections
      libbpf: Add uprobe multi link detection
      libbpf: Add uprobe multi link support to bpf_program__attach_usdt
      selftests/bpf: Move get_time_ns to testing_helpers.h
      selftests/bpf: Add uprobe_multi skel test
      selftests/bpf: Add uprobe_multi api test
      selftests/bpf: Add uprobe_multi link test
      selftests/bpf: Add uprobe_multi test program
      selftests/bpf: Add uprobe_multi bench test
      selftests/bpf: Add uprobe_multi usdt test code
      selftests/bpf: Add uprobe_multi usdt bench test
      selftests/bpf: Add uprobe_multi cookie test
      selftests/bpf: Add uprobe_multi pid filter tests
      selftests/bpf: Add extra link to uprobe_multi tests

 include/linux/trace_events.h                               |   6 ++
 include/uapi/linux/bpf.h                                   |  22 ++++-
 kernel/bpf/syscall.c                                       | 134 ++++++++++++++--------------
 kernel/trace/bpf_trace.c                                   | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h                             |  22 ++++-
 tools/lib/bpf/Build                                        |   2 +-
 tools/lib/bpf/bpf.c                                        |  11 +++
 tools/lib/bpf/bpf.h                                        |  11 ++-
 tools/lib/bpf/elf.c                                        | 440 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c                                     | 388 ++++++++++++++++++++++++++++++++++++++++++---------------------------------------
 tools/lib/bpf/libbpf.h                                     |  51 +++++++++++
 tools/lib/bpf/libbpf.map                                   |   1 +
 tools/lib/bpf/libbpf_internal.h                            |  21 +++++
 tools/lib/bpf/usdt.c                                       | 116 ++++++++++++++++--------
 tools/testing/selftests/bpf/Makefile                       |   5 ++
 tools/testing/selftests/bpf/bench.h                        |   9 --
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c        |  78 +++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c |   8 --
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 415 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi.c           | 101 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_bench.c     |  15 ++++
 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c      |  16 ++++
 tools/testing/selftests/bpf/testing_helpers.h              |  10 +++
 tools/testing/selftests/bpf/uprobe_multi.c                 |  91 +++++++++++++++++++
 24 files changed, 1996 insertions(+), 323 deletions(-)
 create mode 100644 tools/lib/bpf/elf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c

