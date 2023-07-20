Return-Path: <bpf+bounces-5441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6B975AD12
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891831C211B8
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1540A17755;
	Thu, 20 Jul 2023 11:35:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F9E17749
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241F6C433C7;
	Thu, 20 Jul 2023 11:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689852955;
	bh=8alHatLbTQn5XvjLsDlDwyLYvoxDTur9fyb+q5c3YiI=;
	h=From:To:Cc:Subject:Date:From;
	b=P0bve2x78A1GtP+9sY321IofzaRn6PZng82U5hQDU6BhNBPe7NJ36AozhXd/j4OIv
	 8U00vaFezrzJ7j8fI7bB7l32eYh0491NAUtJAFiz+UsXOLxlWiFBOB+Gzsxfd6GnZ7
	 mRo+M8GjE460UL1BzHoCJ38i7Hy6Zg5TMlcQ9dMw35g1MGyvYwKuVo719LOaICAwCR
	 mLT2ASeAooZP8KQlzWqsZiRUcW/VoYHJmlMFrl6YRFK7yqix2UaT5xFZJHTCOnTxgD
	 3LBK8XMQIFCNxI3FYBK9hUp77sXvO+usqhSCHPLwE//WI4BsCFf1lDybqZD+iw5Qkm
	 oAhjiX3AsgcMQ==
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
	Hao Luo <haoluo@google.com>
Subject: [PATCHv4 bpf-next 00/28] bpf: Add multi uprobe link
Date: Thu, 20 Jul 2023 13:35:22 +0200
Message-ID: <20230720113550.369257-1-jolsa@kernel.org>
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

v4 changes:
  - fixed path leak in bpf_uprobe_multi_link_attach error path [Andrii]
  - move libbpf_elf.h to libbpf_internal.h [Andrii]
  - many fixes for new elf helpers [Andrii]
  - fixes in bpf_program__attach_uprobe_multi [Andrii]
  - changed uprobe multi link detection [Andrii]
  - changed uprobe multi link detection in usdt code [Andrii]
  - moved get_time_ns to testing_helpers.h [Andrii]
  - moved bench/usdt test code just to uprobe_multi [Andrii]
  - added special progs object for uprobe bench program [Andrii]
  - moved BPF_F_KPROBE_MULTI_RETURN macro to enum [Andrii]
  - fixed error found by CI [David]
  - several minor changes [Andrii]
  - added acks

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
 kernel/bpf/syscall.c                                       | 122 ++++++++++++--------------
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
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 414 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi.c           | 101 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_bench.c     |  15 ++++
 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c      |  16 ++++
 tools/testing/selftests/bpf/testing_helpers.h              |  10 +++
 tools/testing/selftests/bpf/uprobe_multi.c                 |  91 +++++++++++++++++++
 24 files changed, 1990 insertions(+), 316 deletions(-)
 create mode 100644 tools/lib/bpf/elf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c

