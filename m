Return-Path: <bpf+bounces-16276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614B87FF2FE
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E951C20FEE
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D35101B;
	Thu, 30 Nov 2023 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FOslEIe6"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E37196;
	Thu, 30 Nov 2023 06:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=aTlCflmir4ZRjLUdQjpictemSnOBH7eouCz8U6Drrmc=; b=FOslEIe6SDT15z1UofVIx8YclG
	KnebGT3vIpY3GN1BuuNKuURRwl01JTe23/veTEhmAxo1GUTCIicLms8x8eGUmxRj/XJQ6q4hxtki3
	x1ibrAzMLu2rp5yr7CLSwGcow7vUxvvIZpulv7jOW8/TOWCBupTmJso54X1qxzR8kOWmA+JQaSpUN
	/1XZTDPQLj81lgrtPwOrRkpZmiDI0vBcmQSX4DgjEBKzBfRj4Ynobuc+QRslLKtF5ukAAZibvpUrj
	9Sx/CVafRxIID586QRo44i3jbvIqOBc21Jdij5ihL/9zExeX5H426YNiKIhf30kxDT1+8RefWgKQE
	szt1x3dw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8iTV-000Pr2-FH; Thu, 30 Nov 2023 15:57:09 +0100
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
Subject: pull-request: bpf-next 2023-11-30
Date: Thu, 30 Nov 2023 15:57:08 +0100
Message-Id: <20231130145708.32573-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27109/Thu Nov 30 09:44:04 2023)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 30 non-merge commits during the last 7 day(s) which contain
a total of 58 files changed, 1598 insertions(+), 154 deletions(-).

There is a small merge conflict in Documentation/netlink/specs/netdev.yaml
between net-next merge of a379972973a8 ("Merge branch 'net-page_pool-add-
netlink-based-introspection'") and bpf-next commit 48eb03dd2630 ("xsk: Add
TX timestamp and TX checksum offload support") - resolution is to take both
hunks with xsk-features hunk coming right after the xdp-rx-metadata.

The main changes are:

1) Add initial TX metadata implementation for AF_XDP with support in mlx5
   and stmmac drivers. Two types of offloads are supported right now, that
   is, TX timestamp and TX checksum offload, from Stanislav Fomichev with
   stmmac implementation from Song Yoong Siang.

2) Change BPF verifier logic to validate global subprograms lazily instead of
   unconditionally before the main program, so they can be guarded using BPF
   CO-RE techniques, from Andrii Nakryiko.

3) Add BPF link_info support for uprobe multi link along with bpftool
   integration for the latter, from Jiri Olsa.

4) Use pkg-config in BPF selftests to determine ld flags which is in
   particular needed for linking statically, from Akihiko Odaki.

5) Fix a few BPF selftest failures to adapt to the upcoming LLVM18, from
   Yonghong Song.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Daniel Borkmann, Eduard Zingerman, Jakub Kicinski, 
Johan Almbladh, Quentin Monnet, Song Liu, Song Yoong Siang, Yafang Shao, 
Yonghong Song

----------------------------------------------------------------

The following changes since commit 45c226dde742a92e22dcd65b96bf7e02620a9c19:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-23 12:20:58 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to f690ff9122d2ca8e38769f3bcf217bd3df681a36:

  bpf/tests: Remove duplicate JSGT tests (2023-11-30 12:17:33 +0100)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Akihiko Odaki (3):
      selftests/bpf: Choose pkg-config for the target
      selftests/bpf: Override PKG_CONFIG for static builds
      selftests/bpf: Use pkg-config for libelf

Alexei Starovoitov (1):
      Merge branch 'xsk-tx-metadata'

Andrii Nakryiko (5):
      bpf: Emit global subprog name in verifier logs
      bpf: Validate global subprogs lazily
      selftests/bpf: Add lazy global subprog validation tests
      Merge branch 'bpf-add-link_info-support-for-uprobe-multi-link'
      Merge branch 'selftests-bpf-use-pkg-config-to-determine-ld-flags'

Eduard Zingerman (1):
      libbpf: Start v1.4 development cycle

Jiri Olsa (6):
      libbpf: Add st_type argument to elf_resolve_syms_offsets function
      bpf: Store ref_ctr_offsets values in bpf_uprobe array
      bpf: Add link_info support for uprobe multi link
      selftests/bpf: Use bpf_link__destroy in fill_link_info tests
      selftests/bpf: Add link_info test for uprobe_multi link
      bpftool: Add support to display uprobe_multi links

Song Yoong Siang (1):
      net: stmmac: Add Tx HWTS support to XDP ZC

Stanislav Fomichev (14):
      bpftool: mark orphaned programs during prog show
      selftests/bpf: update test_offload to use new orphaned property
      xsk: Support tx_metadata_len
      xsk: Add TX timestamp and TX checksum offload support
      tools: ynl: Print xsk-features from the sample
      net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
      xsk: Document tx_metadata_len layout
      xsk: Validate xsk_tx_metadata flags
      xsk: Add option to calculate TX checksum in SW
      selftests/xsk: Support tx_metadata_len
      selftests/bpf: Add csum helpers
      selftests/bpf: Add TX side to xdp_metadata
      selftests/bpf: Convert xdp_hw_metadata to XDP_USE_NEED_WAKEUP
      selftests/bpf: Add TX side to xdp_hw_metadata

Yonghong Song (1):
      bpf: Fix a few selftest failures due to llvm18 change

Yujie Liu (1):
      bpf/tests: Remove duplicate JSGT tests

 Documentation/netlink/specs/netdev.yaml            |  19 +-
 Documentation/networking/index.rst                 |   1 +
 Documentation/networking/xdp-rx-metadata.rst       |   2 +
 Documentation/networking/xsk-tx-metadata.rst       |  79 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |  72 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h   |  11 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/tx.c    |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  12 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  64 +++++-
 include/linux/bpf.h                                |   2 +
 include/linux/netdevice.h                          |   2 +
 include/linux/skbuff.h                             |  14 +-
 include/net/xdp_sock.h                             | 111 ++++++++++
 include/net/xdp_sock_drv.h                         |  34 +++
 include/net/xsk_buff_pool.h                        |   8 +
 include/uapi/linux/bpf.h                           |  10 +
 include/uapi/linux/if_xdp.h                        |  47 +++-
 include/uapi/linux/netdev.h                        |  16 ++
 kernel/bpf/verifier.c                              |  83 +++++--
 kernel/trace/bpf_trace.c                           |  86 +++++++-
 lib/test_bpf.c                                     |   2 -
 net/bpf/test_run.c                                 |   2 +-
 net/core/netdev-genl.c                             |  13 +-
 net/xdp/xdp_umem.c                                 |  11 +-
 net/xdp/xsk.c                                      |  56 ++++-
 net/xdp/xsk_buff_pool.c                            |   2 +
 net/xdp/xsk_queue.h                                |  19 +-
 tools/bpf/bpftool/link.c                           | 105 ++++++++-
 tools/bpf/bpftool/prog.c                           |  14 +-
 tools/include/uapi/linux/bpf.h                     |  10 +
 tools/include/uapi/linux/if_xdp.h                  |  61 +++++-
 tools/include/uapi/linux/netdev.h                  |  16 ++
 tools/lib/bpf/elf.c                                |   5 +-
 tools/lib/bpf/libbpf.c                             |   2 +-
 tools/lib/bpf/libbpf.map                           |   3 +
 tools/lib/bpf/libbpf_internal.h                    |   3 +-
 tools/lib/bpf/libbpf_version.h                     |   2 +-
 tools/net/ynl/generated/netdev-user.c              |  19 ++
 tools/net/ynl/generated/netdev-user.h              |   3 +
 tools/net/ynl/samples/netdev.c                     |  10 +-
 tools/testing/selftests/bpf/Makefile               |  14 +-
 tools/testing/selftests/bpf/README.rst             |   2 +-
 tools/testing/selftests/bpf/network_helpers.h      |  43 ++++
 .../selftests/bpf/prog_tests/fill_link_info.c      | 242 +++++++++++++++++++--
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   |   2 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/prog_tests/xdp_metadata.c        |  33 ++-
 .../selftests/bpf/progs/test_fill_link_info.c      |   6 +
 .../selftests/bpf/progs/test_global_func12.c       |   4 +-
 .../selftests/bpf/progs/test_global_func17.c       |   1 +
 .../selftests/bpf/progs/verifier_global_subprogs.c |  92 ++++++++
 .../bpf/progs/verifier_subprog_precision.c         |   4 +-
 tools/testing/selftests/bpf/test_offload.py        |  15 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      | 235 +++++++++++++++++---
 tools/testing/selftests/bpf/xsk.c                  |   3 +
 tools/testing/selftests/bpf/xsk.h                  |   1 +
 58 files changed, 1598 insertions(+), 154 deletions(-)
 create mode 100644 Documentation/networking/xsk-tx-metadata.rst
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_subprogs.c

