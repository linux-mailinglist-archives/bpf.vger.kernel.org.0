Return-Path: <bpf+bounces-42466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D559A47DB
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E5B1C21F7F
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8464A206066;
	Fri, 18 Oct 2024 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="aW1LQD5I"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9814185B48;
	Fri, 18 Oct 2024 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283067; cv=none; b=JxkysoPY3LW1cxg+LfUYTlU8CseG/qwJVei3O7KhcgByLswmmP+ZLwNm1Rf437LbmYm/sK93sq34Mwkj2oBwQwoQbBjYVYYzHa1stEWdz8M3UdmL6zmUwKa1yb/rLGEuG55BZ/y14awvuiPSrm8xPvsmF5qoii5XBGqySoc/s6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283067; c=relaxed/simple;
	bh=QQ0vgp33pjvkKRw9Etds7wOGrOISNeMYBwteSE9sZfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rNBO5hcP58xIaOKIeAzT0UUby9YNn59pToVR9KvpMdF5VGEP/5j7tWf01dwRRKZyTNyqVf4ZLNrU2NGKGSiWjYXJDwzJ9PtR76Hcn7jlXeBBGj7r5t+yBysoiYJ3zfuDRco0NAYfzIAn/rOIZWa1FnJHAihQT7ngCNOKcbDj4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=aW1LQD5I; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=WW+i2Ne2jyWvYltfeCFb87hSWbJ/wKPQQYuetGtHt6A=; b=aW1LQD5IHpcQUtE0WyDrk41bbi
	LVI7AB3YeGxieQt6PWb1B0dLQQb5phQlvj/S9oAkzWMhR444J7IYAOB0MmJCLTZK57guiRmLXNdPs
	m1FZ4aLPIrOOwY/5AN4B5+m9pdIxx/zUtKtk2yugU2dl8qXH3j196kdpmxqf73ooqZB+/1hjKqQoi
	WKKaio26KP0JRz1VV2MRIpOy/+c0g69pz99K16cjEgGa1HtVguiAqgnouIwSFuR9p/GV6kxYQONuu
	LNZKdriALFYIAmWvNxg0QsHf9tvf12q/EPQjVQyd/wB8acStgdeHhfVJkeFa8PVcrkOiuOEFI8Os0
	du54M8iQ==;
Received: from 12.248.197.178.dynamic.cust.swisscom.net ([178.197.248.12] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t1tWH-000MS8-3i; Fri, 18 Oct 2024 22:24:21 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] bpf for v6.12-rc4
Date: Fri, 18 Oct 2024 22:24:20 +0200
Message-Id: <20241018202420.17746-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27431/Fri Oct 18 10:53:06 2024)

Hi Linus,

The following changes since commit 684a64bf32b6e488004e0ad7f0d7e922798f65b6:

  Merge tag 'nfs-for-6.12-1' of git://git.linux-nfs.org/projects/anna/linux-nfs (2024-09-24 15:44:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f:

  lib/buildid: Handle memfd_secret() files in build_id_parse() (2024-10-17 21:30:32 +0200)

----------------------------------------------------------------
BPF fixes:

- Fix BPF verifier to not affect subreg_def marks in its range
  propagation, from Eduard Zingerman.

- Fix a truncation bug in the BPF verifier's handling of
  coerce_reg_to_size_sx, from Dimitar Kanaliev.

- Fix the BPF verifier's delta propagation between linked
  registers under 32-bit addition, from Daniel Borkmann.

- Fix a NULL pointer dereference in BPF devmap due to missing
  rxq information, from Florian Kauer.

- Fix a memory leak in bpf_core_apply, from Jiri Olsa.

- Fix an UBSAN-reported array-index-out-of-bounds in BTF
  parsing for arrays of nested structs, from Hou Tao.

- Fix build ID fetching where memory areas backing the file
  were created with memfd_secret, from Andrii Nakryiko.

- Fix BPF task iterator tid filtering which was incorrectly
  using pid instead of tid, from Jordan Rome.

- Several fixes for BPF sockmap and BPF sockhash redirection
  in combination with vsocks, from Michal Luczaj.

- Fix riscv BPF JIT and make BPF_CMPXCHG fully ordered,
  from Andrea Parri.

- Fix riscv BPF JIT under CONFIG_CFI_CLANG to prevent the
  possibility of an infinite BPF tailcall, from Pu Lehui.

- Fix a build warning from resolve_btfids that bpf_lsm_key_free
  cannot be resolved, from Thomas Weißschuh.

- Fix a bug in kfunc BTF caching for modules where the wrong
  BTF object was returned, from Toke Høiland-Jørgensen.

- Fix a BPF selftest compilation error in cgroup-related tests
  with musl libc, from Tony Ambardar.

- Several fixes to BPF link info dumps to fill missing fields,
  from Tyrone Wu.

- Add BPF selftests for kfuncs from multiple modules, checking
  that the correct kfuncs are called, from Simon Sundberg.

- Ensure that internal and user-facing bpf_redirect flags
  don't overlap, also from Toke Høiland-Jørgensen.

- Switch to use kvzmalloc to allocate BPF verifier environment,
  from Rik van Riel.

- Use raw_spinlock_t in BPF ringbuf to fix a sleep in atomic
  splat under RT, from Wander Lairson Costa.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
----------------------------------------------------------------
Alexei Starovoitov (3):
      Merge branch 'check-the-remaining-info_cnt-before-repeating-btf-fields'
      Merge branch 'fix-caching-of-btf-for-kfuncs-in-the-verifier'
      Merge branch 'fix-truncation-bug-in-coerce_reg_to_size_sx-and-extend-selftests'

Andrea Parri (1):
      riscv, bpf: Make BPF_CMPXCHG fully ordered

Andrii Nakryiko (1):
      lib/buildid: Handle memfd_secret() files in build_id_parse()

Daniel Borkmann (4):
      bpf: Sync uapi bpf.h header to tools directory
      bpf: Fix incorrect delta propagation between linked registers
      bpf: Fix print_reg_state's constant scalar dump
      selftests/bpf: Add test case for delta propagation

Dimitar Kanaliev (3):
      bpf: Fix truncation bug in coerce_reg_to_size_sx()
      selftests/bpf: Add test for truncation after sign extension in coerce_reg_to_size_sx()
      selftests/bpf: Add test for sign extension in coerce_subreg_to_size_sx()

Eduard Zingerman (2):
      bpf: sync_linked_regs() must preserve subreg_def
      selftests/bpf: Verify that sync_linked_regs preserves subreg_def

Florian Kauer (2):
      bpf: devmap: provide rxq after redirect
      bpf: selftests: send packet to devmap redirect XDP

Hou Tao (2):
      bpf: Check the remaining info_cnt before repeating btf fields
      selftests/bpf: Add more test case for field flattening

Jiri Olsa (1):
      bpf: Fix memory leak in bpf_core_apply

Jordan Rome (2):
      bpf: Fix iter/task tid filtering
      bpf: Properly test iter/task tid filtering

Martin KaFai Lau (1):
      Merge branch 'bpf: devmap: provide rxq after redirect'

Michal Luczaj (4):
      bpf, sockmap: SK_DROP on attempted redirects of unsupported af_vsock
      vsock: Update rx_bytes on read_skb()
      vsock: Update msg_count on read_skb()
      bpf, vsock: Drop static vsock_bpf_prot initialization

Pu Lehui (1):
      riscv, bpf: Fix possible infinite tailcall when CONFIG_CFI_CLANG is enabled

Rik van Riel (1):
      bpf: use kvzmalloc to allocate BPF verifier environment

Simon Sundberg (2):
      selftests/bpf: Provide a generic [un]load_module helper
      selftests/bpf: Add test for kfunc module order

Thomas Weißschuh (1):
      bpf, lsm: Remove bpf_lsm_key_free hook

Toke Høiland-Jørgensen (2):
      bpf: Make sure internal and UAPI bpf_redirect flags don't overlap
      bpf: fix kfunc btf caching for modules

Tony Ambardar (2):
      selftests/bpf: Fix error compiling cgroup_ancestor.c with musl libc
      selftests/bpf: Fix cross-compiling urandom_read

Tyrone Wu (6):
      bpf: fix unpopulated name_len field in perf_event link info
      selftests/bpf: fix perf_event link info name_len assertion
      bpf: Fix unpopulated path_size when uprobe_multi fields unset
      selftests/bpf: Assert link info uprobe_multi count & path_size if unset
      bpf: Fix link info netfilter flags to populate defrag flag
      selftests/bpf: Add asserts for netfilter link info

Wander Lairson Costa (1):
      bpf: Use raw_spinlock_t in ringbuf

 arch/riscv/net/bpf_jit_comp64.c                    |   8 +-
 include/net/sock.h                                 |   5 +
 include/uapi/linux/bpf.h                           |  13 +--
 kernel/bpf/bpf_lsm.c                               |   4 -
 kernel/bpf/btf.c                                   |  15 ++-
 kernel/bpf/devmap.c                                |  11 +-
 kernel/bpf/log.c                                   |   3 +-
 kernel/bpf/ringbuf.c                               |  12 +-
 kernel/bpf/syscall.c                               |  29 +++--
 kernel/bpf/task_iter.c                             |   2 +-
 kernel/bpf/verifier.c                              |  36 ++++--
 kernel/trace/bpf_trace.c                           |  36 +++---
 lib/buildid.c                                      |   5 +
 net/core/filter.c                                  |   8 +-
 net/core/sock_map.c                                |   8 ++
 net/netfilter/nf_bpf_link.c                        |   3 +-
 net/vmw_vsock/virtio_transport_common.c            |  14 ++-
 net/vmw_vsock/vsock_bpf.c                          |   8 --
 tools/include/uapi/linux/bpf.h                     |  22 ++--
 tools/testing/selftests/bpf/Makefile               |  22 +++-
 .../selftests/bpf/bpf_test_modorder_x/Makefile     |  19 ++++
 .../bpf/bpf_test_modorder_x/bpf_test_modorder_x.c  |  39 +++++++
 .../selftests/bpf/bpf_test_modorder_y/Makefile     |  19 ++++
 .../bpf/bpf_test_modorder_y/bpf_test_modorder_y.c  |  39 +++++++
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |  27 ++++-
 .../selftests/bpf/prog_tests/cgroup_ancestor.c     |   2 +-
 tools/testing/selftests/bpf/prog_tests/cpumask.c   |   1 +
 .../selftests/bpf/prog_tests/fill_link_info.c      |  18 ++-
 .../selftests/bpf/prog_tests/kfunc_module_order.c  |  55 +++++++++
 .../bpf/prog_tests/netfilter_link_attach.c         |  42 ++++++-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c   | 125 +++++++++++++++++++--
 tools/testing/selftests/bpf/progs/cpumask_common.h |   5 +
 .../testing/selftests/bpf/progs/cpumask_failure.c  |  35 ++++++
 .../testing/selftests/bpf/progs/cpumask_success.c  |  78 ++++++++++++-
 .../selftests/bpf/progs/kfunc_module_order.c       |  30 +++++
 .../bpf/progs/test_xdp_with_devmap_helpers.c       |   2 +-
 .../selftests/bpf/progs/verifier_linked_scalars.c  |  34 ++++++
 tools/testing/selftests/bpf/progs/verifier_movsx.c |  40 +++++++
 .../selftests/bpf/progs/verifier_scalar_ids.c      |  67 +++++++++++
 tools/testing/selftests/bpf/testing_helpers.c      |  34 ++++--
 tools/testing/selftests/bpf/testing_helpers.h      |   2 +
 42 files changed, 847 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_test_modorder_x/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_modorder_x/bpf_test_modorder_x.c
 create mode 100644 tools/testing/selftests/bpf/bpf_test_modorder_y/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_modorder_y/bpf_test_modorder_y.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_module_order.c
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_module_order.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_linked_scalars.c

