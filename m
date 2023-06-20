Return-Path: <bpf+bounces-2880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E03FC736657
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070F41C20BF0
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2685BAD2B;
	Tue, 20 Jun 2023 08:35:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3310E5
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D88FC433C8;
	Tue, 20 Jun 2023 08:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250154;
	bh=C/diXzSE8rAKAumOvGzImnGe5+0rgGLIY/6jLJtN9s4=;
	h=From:To:Cc:Subject:Date:From;
	b=Qm1ysZgmGNqSLsLbP4gQzBMxz2k94DGGLqHcfpCq3d4rmD6i5lhQ/fMc79Bwl9xL9
	 u7PC3HWRqE0EmwHlvKp7TKRRcENTu94BcDeph8SXtOQtGq6V2CWfNQAgejYyZqBZOc
	 8sVhJKuaAYF/+Igjucr8I5xkTZ3o9mI5T60yIqeAyds3StybLW08SLUTXFML91tI+T
	 0ASOJnX2tG620CwwZlPRZp4EFVuVfrsnXNuTlQgsuGd3CRJElFCa4fO06ho9tsDg0L
	 9xRDmyux4Z4blvV0aadj30RFYosTNoR3oXPKLnFHxzhrhuFkj7K26L75Cxw971ENtI
	 qFDPHEYHwEptQ==
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
Subject: [PATCHv2 bpf-next 00/24] bpf: Add multi uprobe link
Date: Tue, 20 Jun 2023 10:35:26 +0200
Message-ID: <20230620083550.690426-1-jolsa@kernel.org>
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

v2 changes:
  - allow to run sleepable programs [Alexei]
  - allow user to specify only single path [Andrii]
  - pid filter support [Andrii]
  - add 'u[ret]probe.multi.s' section defs [Andrii]
  - add acked [Andrii]
  - remove WARN_ON_ONCE in bpf_uprobe_multi_cookie [Andrii]
  - merge tools uapi change with kernel change [Andrii]
  - drop ref_ctr_offset from struct bpf_uprobe [Andrii]
  - use generic string parsing instead of specific pattern matching
    in attach_uprobe_multi [Andrii]

followup changes:
  - move elf specific code into separate C object [Andrii]
  - will send fill_info support when [3] is merged [Andrii]

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  uprobe_multi

The support for bpftrace [2] and tetragon [1] is updated to v2 API changes.

thanks,
jirka


[1] https://github.com/cilium/tetragon/pull/936
[2] https://github.com/iovisor/bpftrace/compare/master...olsajiri:bpftrace:uprobe_multi
[3] https://lore.kernel.org/bpf/20230612151608.99661-1-laoar.shao@gmail.com/
[4] https://lore.kernel.org/bpf/20230613113119.2348619-1-jolsa@kernel.org/
---
Jiri Olsa (24):
      bpf: Add multi uprobe link
      bpf: Add cookies support for uprobe_multi link
      bpf: Add pid filter support for uprobe_multi link
      bpf: Add bpf_get_func_ip helper support for uprobe link
      libbpf: Add uprobe_multi attach type and link names
      libbpf: Add elf symbol iterator
      libbpf: Add open_elf/close_elf functions
      libbpf: Add elf_find_multi_func_offset function
      libbpf: Add elf_find_pattern_func_offset function
      libbpf: Add bpf_link_create support for multi uprobes
      libbpf: Add bpf_program__attach_uprobe_multi_opts function
      libbpf: Add support for u[ret]probe.multi[.s] program sections
      libbpf: Add uprobe multi link detection
      libbpf: Add uprobe multi link support to bpf_program__attach_usdt
      selftests/bpf: Add uprobe_multi skel test
      selftests/bpf: Add uprobe_multi api test
      selftests/bpf: Add uprobe_multi link test
      selftests/bpf: Add uprobe_multi test program
      selftests/bpf: Add uprobe_multi bench test
      selftests/bpf: Add usdt_multi test program
      selftests/bpf: Add usdt_multi bench test
      selftests/bpf: Add uprobe_multi cookie test
      selftests/bpf: Add uprobe_multi pid filter tests
      selftests/bpf: Add extra link to uprobe_multi tests

 include/linux/trace_events.h                               |   6 ++
 include/uapi/linux/bpf.h                                   |  16 ++++
 kernel/bpf/syscall.c                                       |  14 +++-
 kernel/trace/bpf_trace.c                                   | 349 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h                             |  16 ++++
 tools/lib/bpf/bpf.c                                        |  11 +++
 tools/lib/bpf/bpf.h                                        |  11 ++-
 tools/lib/bpf/libbpf.c                                     | 645 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 tools/lib/bpf/libbpf.h                                     |  31 +++++++
 tools/lib/bpf/libbpf.map                                   |   1 +
 tools/lib/bpf/libbpf_internal.h                            |   7 ++
 tools/lib/bpf/usdt.c                                       | 120 ++++++++++++++++++++-------
 tools/testing/selftests/bpf/Makefile                       |  10 +++
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c        |  78 ++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 449 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi.c           | 110 +++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c      |  16 ++++
 tools/testing/selftests/bpf/uprobe_multi.c                 |  53 ++++++++++++
 tools/testing/selftests/bpf/usdt_multi.c                   |  24 ++++++
 19 files changed, 1841 insertions(+), 126 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c
 create mode 100644 tools/testing/selftests/bpf/usdt_multi.c

