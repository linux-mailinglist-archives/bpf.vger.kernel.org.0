Return-Path: <bpf+bounces-3767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F58743748
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60EE1C20B7F
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF4EA957;
	Fri, 30 Jun 2023 08:33:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB60C1FB8
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9F7C433C8;
	Fri, 30 Jun 2023 08:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114030;
	bh=+YizOm+oWZkwRTAnfDT9lDpgW7EUZIpIHjU4PDKXzxE=;
	h=From:To:Cc:Subject:Date:From;
	b=hl21Q5fwDsFavQJeaIksHEK3chhFFP+AqnrEf/YZwbV0ed/+Eg9ZCUjW5C6lu8QeZ
	 G5+kEzapzPVs259SQxdKj5TODCiYpvkmgXnvb7YvK0x625P4OPHJ71X2TB3wgWioX4
	 3YyykyD8Bpff4wa4IG1xPWQOETxlLAGmzoLOuQ2CayY7ukqBYfgLM22hWW+H+xx0y8
	 XzNzO781yJ7l6H740GwL5jil4G/QhvTKoIRi1PPz9ys+VkncdI+jJyiEI8i5xLhC64
	 16YfJQX3vEfq4WYOss65CFA9sqzeQC8S3VzKA+3nmicmlzg+MMUV3onUKbTKI0lO8e
	 1AqxjZeNqVUiA==
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
Subject: [PATCHv3 bpf-next 00/26] bpf: Add multi uprobe link
Date: Fri, 30 Jun 2023 10:33:18 +0200
Message-ID: <20230630083344.984305-1-jolsa@kernel.org>
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

v3 changes:
  - consolidate attach type checks in bpf_prog_attach_check_attach_type [Andrii]
  - remove bpf_prog_active check [Alexei]
  - change rcu locking [Andrii]
  - allocate ref_ctr_offsets conditionally [Andrii]
  - remove ctx check from bpf_uprobe_multi_cookie [Andrii]
  - move some elf_* functions in elf.c object [Andrii]
  - fix uprobe link detection code [Andrii]
  - add usdt.s program section [Andrii]
  - rename bpf_program__attach_uprobe_multi_opts to bpf_program__attach_uprobe_multi [Andrii]
  - remove extra case from attach_uprobe_multi [Andrii]
  - rework usdt_manager_attach_usdt [Andrii]
  - rework/rename new elf_find_* functions [Andrii]
  - elf iterator fixes [Andrii]
    - renames
    - elf_sym_iter_next loop restruct
    - return directly GElf_Sym in elf_sym
    - add elf_sym_offset helper
    - add st_type arg elf_sym_iter_new
    - get rid of '_' prefixed functions
    - simplify offsets handling
    - other smaller changes
  - added acks
  - todo:
    - seems like more elf_* helpers could go in elf.c object,
      I'll send that as follow up
    - will send fill_info support when [3] is merged [Andrii]


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
Jiri Olsa (26):
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
 kernel/bpf/syscall.c                                       | 122 ++++++++++++-------------
 kernel/trace/bpf_trace.c                                   | 346 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h                             |  16 ++++
 tools/lib/bpf/Build                                        |   2 +-
 tools/lib/bpf/bpf.c                                        |  11 +++
 tools/lib/bpf/bpf.h                                        |  11 ++-
 tools/lib/bpf/elf.c                                        | 435 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c                                     | 396 ++++++++++++++++++++++++++++++++++++++++++---------------------------------------
 tools/lib/bpf/libbpf.h                                     |  27 ++++++
 tools/lib/bpf/libbpf.map                                   |   1 +
 tools/lib/bpf/libbpf_elf.h                                 |  24 +++++
 tools/lib/bpf/libbpf_internal.h                            |   3 +
 tools/lib/bpf/usdt.c                                       | 109 +++++++++++++++--------
 tools/testing/selftests/bpf/Makefile                       |  10 +++
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c        |  78 ++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 449 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi.c           | 110 +++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c      |  16 ++++
 tools/testing/selftests/bpf/uprobe_multi.c                 |  53 +++++++++++
 tools/testing/selftests/bpf/usdt_multi.c                   |  24 +++++
 22 files changed, 1969 insertions(+), 296 deletions(-)
 create mode 100644 tools/lib/bpf/elf.c
 create mode 100644 tools/lib/bpf/libbpf_elf.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_usdt.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c
 create mode 100644 tools/testing/selftests/bpf/usdt_multi.c

