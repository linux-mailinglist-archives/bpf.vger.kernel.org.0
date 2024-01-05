Return-Path: <bpf+bounces-19134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCD58258EA
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 18:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4992854B3
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53032193;
	Fri,  5 Jan 2024 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Dfe5m+t2"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2432187;
	Fri,  5 Jan 2024 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=bWf3yT97gabATZJg4RvJhEH+r1LG8ILH7khMGadV3yo=; b=Dfe5m+t2VMT8qeV9YTsuqgkHjy
	SPp07U2XxBgiIMqMkE51CwBwUg+QviU0UhmYzvBwN947kUwmncKFf9qKRCr68sCbjLeWNXmPGNO7/
	bSjggFKW9QfG+d3NuczXqHpMr1dQiqG/GQxcdaRIJx5PY1UYP0hkCCNaAw9YwUi4cGIp9vV3xQTnc
	9XYw0VJUvulBLcXg1g/fqcYgo8cvzGGCZLanNP1MfNJ8LgXbSc7SNV9Va9ZeolbzL7iPnEcZSmhvc
	nkAXhBWRQLomimm9F8/gg0E6qjS7+7P5GQZy+IAUBaUPJ1l3cgq0ik9lumvpQMxPuqvtojXdsZtDA
	ZeMSB2LQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rLnZB-000OHO-Te; Fri, 05 Jan 2024 18:01:06 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2024-01-05
Date: Fri,  5 Jan 2024 18:01:05 +0100
Message-Id: <20240105170105.21070-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27145/Fri Jan  5 10:40:31 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 40 non-merge commits during the last 2 day(s) which contain
a total of 73 files changed, 1526 insertions(+), 951 deletions(-).

The main changes are:

1) Fix a memory leak when streaming AF_UNIX sockets were inserted into multiple
   sockmap slots/maps, from John Fastabend.

2) Fix gotol in s390 BPF JIT with large offsets, from Ilya Leoshkevich.

3) Fix reattachment branch in bpf_tracing_prog_attach() and reject the request
   if there is no valid attach_btf, from Jiri Olsa.

4) Remove deprecated bpfilter kernel leftovers given the project is developed
   in user space (https://github.com/facebook/bpfilter), from Quentin Deslandes.

5) Relax tracing BPF program recursive attach rules given right now it is not
   possible to create tracing program call cycles, from Dmitrii Dolgov.

6) Fix excessive memory consumption for the bpf_global_percpu_ma for systems
   with a large number of CPUs, from Yonghong Song.

7) Small x86 BPF JIT cleanup to reuse emit_nops instead of open-coding memcpy
   of x86_nops, from Leon Hwang.

8) Follow-up for libbpf to support __arg_ctx global function argument tag
   semantics to complement the merged kernel side, from Andrii Nakryiko.

9) Introduce "volatile compare" macros for BPF selftests in order to make the
   latter more robust against compiler optimization, from Alexei Starovoitov.

10) Small simplification in verifier's size checking of helper accesses along
    with additional selftests, from Andrei Matei.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot & happy new year!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Daniel Borkmann, Hou Tao, Jakub Sitnicki, Jiri Olsa, 
John Fastabend, Kumar Kartikeya Dwivedi, Song Liu, Xingwei Lee, Yonghong 
Song

----------------------------------------------------------------

The following changes since commit 2ab1efad60ad119b616722b81eeb73060728028c:

  net/sched: cls_api: complement tcf_tfilter_dump_policy (2024-01-03 11:54:39 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 5fe4ee6ae187523f710f1b93024437a073d88b17:

  Merge branch 'relax-tracing-prog-recursive-attach-rules' (2024-01-04 20:40:54 -0800)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (10):
      selftests/bpf: Attempt to build BPF programs with -Wsign-compare
      bpf: Introduce "volatile compare" macros
      selftests/bpf: Convert exceptions_assert.c to bpf_cmp
      selftests/bpf: Remove bpf_assert_eq-like macros.
      bpf: Add bpf_nop_mov() asm macro.
      selftests/bpf: Convert profiler.c to bpf_cmp.
      Merge branch 'bpf-reduce-memory-usage-for-bpf_global_percpu_ma'
      Merge branch 'libbpf-side-__arg_ctx-fallback-support'
      Merge branch 's390-bpf-fix-gotol-with-large-offsets'
      Merge branch 'relax-tracing-prog-recursive-attach-rules'

Andrei Matei (2):
      bpf: Simplify checking size of helper accesses
      bpf: Add a possibly-zero-sized read test

Andrii Nakryiko (11):
      Merge branch 'bpf-simplify-checking-size-of-helper-accesses'
      Merge branch 'bpf-volatile-compare'
      libbpf: make uniform use of btf__fd() accessor inside libbpf
      libbpf: use explicit map reuse flag to skip map creation steps
      libbpf: don't rely on map->fd as an indicator of map being created
      libbpf: use stable map placeholder FDs
      libbpf: move exception callbacks assignment logic into relocation step
      libbpf: move BTF loading step after relocation step
      libbpf: implement __arg_ctx fallback logic
      selftests/bpf: add arg:ctx cases to test_global_funcs tests
      selftests/bpf: add __arg_ctx BTF rewrite test

Dmitrii Dolgov (3):
      bpf: Relax tracing prog recursive attach rules
      selftests/bpf: Add test for recursive attachment of tracing progs
      selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach

Ilya Leoshkevich (3):
      s390/bpf: Fix gotol with large offsets
      selftests/bpf: Double the size of test_loader log
      selftests/bpf: Test gotol with large offsets

Jiri Olsa (1):
      bpf: Fix re-attachment branch in bpf_tracing_prog_attach

John Fastabend (5):
      bpf: sockmap, fix proto update hook to avoid dup calls
      bpf: sockmap, added comments describing update proto rules
      bpf: sockmap, add tests for proto updates many to single map
      bpf: sockmap, add tests for proto updates single socket to many map
      bpf: sockmap, add tests for proto updates replace socket

Leon Hwang (1):
      bpf, x86: Use emit_nops to replace memcpy x86_nops

Martin KaFai Lau (1):
      Merge branch 'fix sockmap + stream  af_unix memleak'

Quentin Deslandes (1):
      bpfilter: remove bpfilter

Yonghong Song (9):
      bpf: Avoid unnecessary extra percpu memory allocation
      bpf: Add objcg to bpf_mem_alloc
      bpf: Allow per unit prefill for non-fix-size percpu memory allocator
      bpf: Refill only one percpu element in memalloc
      bpf: Use smaller low/high marks for percpu allocation
      bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
      selftests/bpf: Cope with 512 bytes limit with bpf_global_percpu_ma
      selftests/bpf: Add a selftest with > 512-byte percpu allocation size
      bpf: Remove unnecessary cpu == 0 check in memalloc

 arch/loongarch/configs/loongson3_defconfig         |   1 -
 arch/s390/net/bpf_jit_comp.c                       |   2 +-
 arch/x86/net/bpf_jit_comp.c                        |  47 +-
 include/linux/bpf.h                                |   1 +
 include/linux/bpf_mem_alloc.h                      |   8 +
 include/linux/bpfilter.h                           |  24 -
 include/linux/skmsg.h                              |   5 +
 include/uapi/linux/bpfilter.h                      |  21 -
 kernel/bpf/memalloc.c                              |  93 +++-
 kernel/bpf/syscall.c                               |  32 +-
 kernel/bpf/verifier.c                              |  94 ++--
 net/Kconfig                                        |   2 -
 net/Makefile                                       |   1 -
 net/bpfilter/.gitignore                            |   2 -
 net/bpfilter/Kconfig                               |  23 -
 net/bpfilter/Makefile                              |  20 -
 net/bpfilter/bpfilter_kern.c                       | 136 -----
 net/bpfilter/bpfilter_umh_blob.S                   |   7 -
 net/bpfilter/main.c                                |  64 ---
 net/bpfilter/msgfmt.h                              |  17 -
 net/ipv4/Makefile                                  |   2 -
 net/ipv4/bpfilter/Makefile                         |   2 -
 net/ipv4/bpfilter/sockopt.c                        |  71 ---
 net/ipv4/ip_sockglue.c                             |  12 -
 net/unix/unix_bpf.c                                |  21 +-
 tools/bpf/bpftool/feature.c                        |   4 -
 tools/lib/bpf/libbpf.c                             | 570 ++++++++++++++++-----
 tools/lib/bpf/libbpf_internal.h                    |  14 +
 tools/testing/selftests/bpf/Makefile               |   1 +
 tools/testing/selftests/bpf/bpf_experimental.h     | 220 +++-----
 tools/testing/selftests/bpf/config.aarch64         |   1 -
 tools/testing/selftests/bpf/config.s390x           |   1 -
 tools/testing/selftests/bpf/config.x86_64          |   1 -
 .../selftests/bpf/prog_tests/recursive_attach.c    | 151 ++++++
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 214 +++++++-
 .../testing/selftests/bpf/prog_tests/test_bpf_ma.c |  20 +-
 .../selftests/bpf/prog_tests/test_global_funcs.c   | 106 ++++
 .../bpf/progs/bpf_iter_bpf_percpu_hash_map.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_task_vmas.c       |   2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tasks.c |   2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern4.c      |   2 +-
 .../bpf/progs/cgroup_getset_retval_setsockopt.c    |   2 +-
 .../selftests/bpf/progs/cgrp_ls_sleepable.c        |   2 +-
 .../testing/selftests/bpf/progs/cpumask_success.c  |   2 +-
 tools/testing/selftests/bpf/progs/exceptions.c     |  20 +-
 .../selftests/bpf/progs/exceptions_assert.c        |  80 +--
 .../testing/selftests/bpf/progs/fentry_recursive.c |  14 +
 .../selftests/bpf/progs/fentry_recursive_target.c  |  25 +
 tools/testing/selftests/bpf/progs/iters.c          |   4 +-
 tools/testing/selftests/bpf/progs/iters_task_vma.c |   3 +-
 tools/testing/selftests/bpf/progs/linked_funcs1.c  |   2 +-
 tools/testing/selftests/bpf/progs/linked_funcs2.c  |   2 +-
 tools/testing/selftests/bpf/progs/linked_list.c    |   2 +-
 tools/testing/selftests/bpf/progs/local_storage.c  |   2 +-
 tools/testing/selftests/bpf/progs/lsm.c            |   2 +-
 tools/testing/selftests/bpf/progs/normal_map_btf.c |   2 +-
 .../selftests/bpf/progs/percpu_alloc_fail.c        |  18 +
 tools/testing/selftests/bpf/progs/profiler.inc.h   |  68 +--
 .../testing/selftests/bpf/progs/sockopt_inherit.c  |   2 +-
 tools/testing/selftests/bpf/progs/sockopt_multi.c  |   2 +-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c        |   2 +-
 tools/testing/selftests/bpf/progs/test_bpf_ma.c    |  68 +--
 .../selftests/bpf/progs/test_core_reloc_kernel.c   |   2 +-
 .../selftests/bpf/progs/test_core_reloc_module.c   |   8 +-
 tools/testing/selftests/bpf/progs/test_fsverity.c  |   2 +-
 .../bpf/progs/test_global_func_ctx_args.c          |  49 ++
 .../selftests/bpf/progs/test_skc_to_unix_sock.c    |   2 +-
 .../selftests/bpf/progs/test_xdp_do_redirect.c     |   2 +-
 tools/testing/selftests/bpf/progs/verifier_gotol.c |  19 +
 .../bpf/progs/verifier_helper_value_access.c       |  45 +-
 .../selftests/bpf/progs/verifier_raw_stack.c       |   2 +-
 tools/testing/selftests/bpf/test_loader.c          |   2 +-
 tools/testing/selftests/hid/config                 |   1 -
 73 files changed, 1526 insertions(+), 951 deletions(-)
 delete mode 100644 include/linux/bpfilter.h
 delete mode 100644 include/uapi/linux/bpfilter.h
 delete mode 100644 net/bpfilter/.gitignore
 delete mode 100644 net/bpfilter/Kconfig
 delete mode 100644 net/bpfilter/Makefile
 delete mode 100644 net/bpfilter/bpfilter_kern.c
 delete mode 100644 net/bpfilter/bpfilter_umh_blob.S
 delete mode 100644 net/bpfilter/main.c
 delete mode 100644 net/bpfilter/msgfmt.h
 delete mode 100644 net/ipv4/bpfilter/Makefile
 delete mode 100644 net/ipv4/bpfilter/sockopt.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c

