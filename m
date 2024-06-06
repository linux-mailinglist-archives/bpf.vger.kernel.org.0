Return-Path: <bpf+bounces-31546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04958FF7AC
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 00:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DBE286C99
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 22:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865413C81C;
	Thu,  6 Jun 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WEje9+0H"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4CD53C;
	Thu,  6 Jun 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713114; cv=none; b=no3WuPVmlE5Zqgr3fjFhPhRdyqVk8q2TqaLiRDMj1vcU27y80iXM+dM0V7FAJSlCqnBqCi9IBHj/shr1njX/kyrTbxJ6FiphCc9tnksOVsL4l5ipTre2t8Slk6/nx9uqYaTiMGrV0JdsuXu7N2TN16RrlFAtvA5Jo34+YuHxIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713114; c=relaxed/simple;
	bh=ZAAHVF1zE5e16uz24lH0zQpf9wUpPOSxiAgHqnFh7Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ohDeF2rV/EINN4RJb1/6BPPnXAPeh0XUT/xXGn/OXw76Ed4juxoqATyZdFZoMnPMMgj/EIkFWgSoOwykUpcTIachtJV7Du4y5nZccNEIUux52pM8Ok9NlCl+DNCm5EGoWMHpM1AzNop4skVjZ9aKbWp1IO4Y7O6rsih74S6/MZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WEje9+0H; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=gYBbA5pYnYQ9t9RhSbMMXOUIhHRwfzMtNUg/R/4nd8E=; b=WEje9+0H6VaqresXe4a4BiuB7r
	vHU3g+S92IKkjeUIjDXzYD19qeJJMDLvscSaBYf4+m4cgHp/JXNdL5kMI3clWb+LQKRHDBgn5KxUG
	4bJgAG4cKYi0Y2pyLe7wqk1Ct8nKQjyPVmOAGa3wrUXEhRnUQYGfyehoKvFoTjiQ2IKgBCV0cRdxY
	k93RBn7/uiVWJs+dJ+sXtRSa9uHfyY999gbnwCFfwG7s587XO/1We9W8EumI51g3I6qRAe1MA3EZT
	z++WgoQ61l6K/XASQwMAr1AVWEnIuTj69cQhlJb/8vRctKGCcn/sqJ+nWZhhr15zXA/s7Pqia2TqD
	AC1ZBIfA==;
Received: from 32.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.32] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sFLe7-000Cxj-CQ; Fri, 07 Jun 2024 00:31:47 +0200
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
Subject: pull-request: bpf-next 2024-06-06
Date: Fri,  7 Jun 2024 00:31:46 +0200
Message-Id: <20240606223146.23020-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27298/Thu Jun  6 10:30:08 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 54 non-merge commits during the last 10 day(s) which contain
a total of 50 files changed, 1887 insertions(+), 527 deletions(-).

The main changes are:

1) Add a user space notification mechanism via epoll when a struct_ops object
   is getting detached/unregistered, from Kui-Feng Lee.

2) Big batch of BPF selftest refactoring for sockmap and BPF congctl tests,
   from Geliang Tang.

3) Add BTF field (type and string fields, right now) iterator support to libbpf
   instead of using existing callback-based approaches, from Andrii Nakryiko.

4) Extend BPF selftests for the latter with a new btf_field_iter selftest,
   from Alan Maguire.

5) Add new kfuncs for a generic, open-coded bits iterator, from Yafang Shao.

6) Fix BPF selftests' kallsyms_find() helper under kernels configured with
   CONFIG_LTO_CLANG_THIN, from Yonghong Song.

7) Remove a bunch of unused structs in BPF selftests, from David Alan Gilbert.

8) Convert test_sockmap section names into names understood by libbpf so it
   can deduce program type and attach type, from Jakub Sitnicki.

9) Extend libbpf with the ability to configure log verbosity via LIBBPF_LOG_LEVEL
   environment variable, from Mykyta Yatsenko.

10) Fix BPF selftests with regards to bpf_cookie and find_vma flakiness
    in nested VMs, from Song Liu.

11) Extend riscv32/64 JITs to introduce shift/add helpers to generate Zba
    optimization, from Xiao Wang.

12) Enable BPF programs to declare arrays and struct fields with kptr,
    bpf_rb_root, and bpf_list_head, from Kui-Feng Lee.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alan Maguire, Alexei Starovoitov, Björn Töpel, Eduard Zingerman, Jakub 
Sitnicki, Jiri Olsa, John Fastabend, Lennart Poettering, Quentin Monnet

----------------------------------------------------------------

The following changes since commit 4b3529edbb8ff069d762c6947e055e10c1748170:

  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2024-05-28 07:27:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to f85af9d955ac9601174e1c64f4b3308c1cae4a7e:

  selftests/bpf: Drop useless arguments of do_test in bpf_tcp_ca (2024-06-06 23:04:06 +0200)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alan Maguire (1):
      selftests/bpf: Add btf_field_iter selftests

Alexei Starovoitov (1):
      Merge branch 'enable-bpf-programs-to-declare-arrays-of-kptr-bpf_rb_root-and-bpf_list_head'

Andrii Nakryiko (7):
      Merge branch 'bpf-add-a-generic-bits-iterator'
      libbpf: keep FD_CLOEXEC flag when dup()'ing FD
      libbpf: Add BTF field iterator
      libbpf: Make use of BTF field iterator in BPF linker code
      libbpf: Make use of BTF field iterator in BTF handling code
      bpftool: Use BTF field iterator in btfgen
      libbpf: Remove callback-based type/string BTF field visitor helpers

Dr. David Alan Gilbert (3):
      selftests/bpf: Remove unused struct 'scale_test_def'
      selftests/bpf: Remove unused 'key_t' structs
      selftests/bpf: Remove unused struct 'libcap'

Geliang Tang (18):
      selftests/bpf: Drop struct post_socket_opts
      selftests/bpf: Add start_server_str helper
      selftests/bpf: Use post_socket_cb in connect_to_fd_opts
      selftests/bpf: Use post_socket_cb in start_server_str
      selftests/bpf: Use start_server_str in do_test in bpf_tcp_ca
      selftests/bpf: Fix tx_prog_fd values in test_sockmap
      selftests/bpf: Drop duplicate definition of i in test_sockmap
      selftests/bpf: Use bpf_link attachments in test_sockmap
      selftests/bpf: Replace tx_prog_fd with tx_prog in test_sockmap
      selftests/bpf: Drop prog_fd array in test_sockmap
      selftests/bpf: Fix size of map_fd in test_sockmap
      selftests/bpf: Check length of recv in test_sockmap
      selftests/bpf: Drop duplicate bpf_map_lookup_elem in test_sockmap
      selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
      selftests/bpf: Add start_test helper in bpf_tcp_ca
      selftests/bpf: Use start_test in test_dctcp_fallback in bpf_tcp_ca
      selftests/bpf: Use start_test in test_dctcp in bpf_tcp_ca
      selftests/bpf: Drop useless arguments of do_test in bpf_tcp_ca

Jakub Sitnicki (1):
      selftests/bpf: use section names understood by libbpf in test_sockmap

Jeff Johnson (1):
      test_bpf: Add missing MODULE_DESCRIPTION()

Kui-Feng Lee (15):
      bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
      bpf: enable detaching links of struct_ops objects.
      bpf: support epoll from bpf struct_ops links.
      bpf: export bpf_link_inc_not_zero.
      selftests/bpf: test struct_ops with epoll
      bpftool: Change pid_iter.bpf.c to comply with the change of bpf_link_fops.
      bpf: Remove unnecessary checks on the offset of btf_field.
      bpf: Remove unnecessary call to btf_field_type_size().
      bpf: refactor btf_find_struct_field() and btf_find_datasec_var().
      bpf: create repeated fields for arrays.
      bpf: look into the types of the fields of a struct type recursively.
      bpf: limit the number of levels of a nested struct type.
      selftests/bpf: Test kptr arrays and kptrs in nested struct fields.
      selftests/bpf: Test global bpf_rb_root arrays and fields in nested struct types.
      selftests/bpf: Test global bpf_list_head arrays.

Martin KaFai Lau (2):
      Merge branch 'use network helpers, part 5'
      Merge branch 'Notify user space when a struct_ops object is detached/unregistered'

Mykyta Yatsenko (2):
      libbpf: Configure log verbosity with env variable
      libbpf: Auto-attach struct_ops BPF maps in BPF skeleton

Song Liu (1):
      selftests/bpf: Fix bpf_cookie and find_vma in nested VM

Swan Beaujard (1):
      bpftool: Fix typo in MAX_NUM_METRICS macro name

Xiao Wang (1):
      riscv, bpf: Introduce shift add helper with Zba optimization

Yafang Shao (2):
      bpf: Add bits iterator
      selftests/bpf: Add selftest for bits iter

Yonghong Song (2):
      selftests/bpf: Ignore .llvm.<hash> suffix in kallsyms_find()
      selftests/bpf: Fix send_signal test with nested CONFIG_PARAVIRT

 Documentation/bpf/libbpf/libbpf_overview.rst       |   8 +
 arch/riscv/net/bpf_jit.h                           |  33 +++
 arch/riscv/net/bpf_jit_comp32.c                    |   3 +-
 arch/riscv/net/bpf_jit_comp64.c                    |   9 +-
 include/linux/bpf.h                                |  13 +-
 kernel/bpf/bpf_struct_ops.c                        |  75 ++++-
 kernel/bpf/btf.c                                   | 310 ++++++++++++-------
 kernel/bpf/helpers.c                               | 119 ++++++++
 kernel/bpf/syscall.c                               |  34 ++-
 kernel/bpf/verifier.c                              |   4 +-
 lib/test_bpf.c                                     |   1 +
 net/bpf/bpf_dummy_struct_ops.c                     |   4 +-
 net/ipv4/bpf_tcp_ca.c                              |   6 +-
 tools/bpf/bpftool/gen.c                            |  52 +++-
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c          |   7 +-
 tools/bpf/bpftool/skeleton/profiler.bpf.c          |  14 +-
 tools/lib/bpf/btf.c                                | 328 ++++++++++++---------
 tools/lib/bpf/libbpf.c                             |  89 +++++-
 tools/lib/bpf/libbpf.h                             |  23 +-
 tools/lib/bpf/libbpf.map                           |   2 +
 tools/lib/bpf/libbpf_internal.h                    |  36 ++-
 tools/lib/bpf/linker.c                             |  58 ++--
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c          |   4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   6 +-
 tools/testing/selftests/bpf/network_helpers.c      |  32 +-
 tools/testing/selftests/bpf/network_helpers.h      |   8 +-
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |   2 +-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  | 196 ++++++++----
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |   6 -
 .../selftests/bpf/prog_tests/btf_field_iter.c      | 161 ++++++++++
 tools/testing/selftests/bpf/prog_tests/cpumask.c   |   5 +
 tools/testing/selftests/bpf/prog_tests/find_vma.c  |   4 +-
 .../testing/selftests/bpf/prog_tests/linked_list.c |  12 +
 tools/testing/selftests/bpf/prog_tests/rbtree.c    |  47 +++
 .../testing/selftests/bpf/prog_tests/send_signal.c |   3 +-
 .../selftests/bpf/prog_tests/sockopt_inherit.c     |   2 +-
 .../bpf/prog_tests/test_struct_ops_module.c        |  57 ++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/bpf_iter_bpf_array_map.c   |   6 -
 .../bpf/progs/bpf_iter_bpf_percpu_array_map.c      |   6 -
 .../testing/selftests/bpf/progs/cpumask_success.c  | 171 +++++++++++
 tools/testing/selftests/bpf/progs/linked_list.c    |  42 +++
 tools/testing/selftests/bpf/progs/rbtree.c         |  77 +++++
 .../selftests/bpf/progs/struct_ops_detach.c        |  10 +
 .../selftests/bpf/progs/test_sockmap_kern.h        |  20 +-
 .../selftests/bpf/progs/verifier_bits_iter.c       | 153 ++++++++++
 tools/testing/selftests/bpf/test_sockmap.c         | 132 ++++-----
 .../selftests/bpf/test_tcp_check_syncookie_user.c  |   4 +-
 tools/testing/selftests/bpf/test_verifier.c        |   5 -
 tools/testing/selftests/bpf/trace_helpers.c        |  13 +-
 50 files changed, 1887 insertions(+), 527 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_detach.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.c

