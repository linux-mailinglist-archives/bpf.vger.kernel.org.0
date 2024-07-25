Return-Path: <bpf+bounces-35651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 098DA93C666
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 17:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE181F22B5B
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D262419DF58;
	Thu, 25 Jul 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQfU5y3e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544BA1993AE;
	Thu, 25 Jul 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921437; cv=none; b=J7hzfeq0szxtwJN8FpvtgO4AkuMIHDkVxEOIhUfSMbRjeWSCGf/frcrbQVlE8i2mm5roO5YktNzXXUfsEbSILDXQiXD5s55IDTr5CJULMfm2g3cH4p5Nhz1nvUOP2WtUIvGmbvZpYIEikrU8O+ha16RyK0heIIRQ+kpjbvt57Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921437; c=relaxed/simple;
	bh=WyvMe12wEO2/XINU91Z4ZoowICExNXoxIN9iR471PA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rynOvkQCpcrEvlI2OaNxXMPW9vRVDn8lsShTJreQwufCa5lGXfXZSSII+mip7xv8iHrkrJdh8YhghBGBpKKFcuaCNDfjmMNS1bvgo4I1xceBGMsmab7pramPfIG5YFVYegLS3YDjxiKUSZkK7TMLI15O7Km8oT3JqxdA12ldTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQfU5y3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2A1C116B1;
	Thu, 25 Jul 2024 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921436;
	bh=WyvMe12wEO2/XINU91Z4ZoowICExNXoxIN9iR471PA4=;
	h=From:To:Cc:Subject:Date:From;
	b=TQfU5y3exqn6+IyLhz2L2y6YC1sR8BiuPEs5wLulaGoMpbJXOwSz+WVOo13p4ZU+Q
	 RX2ZXkSgCbJ+gE8wtZWGVnK3DZbFM/Ig9RJ8HNePuJ2Exxqt2yWA0K+K1FzM2xw4G2
	 j7gBDF5WpyjXnqUIIvlKxke4Re5I5FvCuMe3zt5dhRIA2qd4j4SgiKzRr84UY3TScq
	 eeLEqWDJ76hfMgB69Jo+EOoXath4q0lcDHB09DOhXX9sTZuj4+vkdO0l3QY66vQgZV
	 mBKZKsFqJwinJlB1uabm618msUTpoaqdIrgZxnw7jMgE6XN1LeTZp8Kjx61VmXDCyQ
	 9+stBwHUl3ZDg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.11-rc1
Date: Thu, 25 Jul 2024 08:30:35 -0700
Message-ID: <20240725153035.808889-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit d7e78951a8b8b53e4d52c689d927a6887e6cfadf:

  Merge tag 'net-6.11-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-07-19 14:58:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc1

for you to fetch changes up to af65ea42bd1d28d818b74b9b3b4f8da7ada9f88b:

  Merge branch 'tap-tun-harden-by-dropping-short-frame' (2024-07-25 08:07:07 -0700)

----------------------------------------------------------------
A lot of networking people were at a conference last week, busy
catching COVID, so relatively short PR. Including fixes from bpf
and netfilter.

Current release - regressions:

 - tcp: process the 3rd ACK with sk_socket for TFO and MPTCP

Current release - new code bugs:

 - l2tp: protect session IDR and tunnel session list with one lock,
   make sure the state is coherent to avoid a warning

 - eth: bnxt_en: update xdp_rxq_info in queue restart logic

 - eth: airoha: fix location of the MBI_RX_AGE_SEL_MASK field

Previous releases - regressions:

 - xsk: require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len,
   the field reuses previously un-validated pad

Previous releases - always broken:

 - tap/tun: drop short frames to prevent crashes later in the stack

 - eth: ice: add a per-VF limit on number of FDIR filters

 - af_unix: disable MSG_OOB handling for sockets in sockmap/sockhash

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Ahmed Zaki (1):
      ice: Add a per-VF limit on number of FDIR filters

Andrii Nakryiko (1):
      libbpf: Fix no-args func prototype BTF dumping syntax

Bailey Forrest (1):
      gve: Fix an edge case for TSO skb validity check

Breno Leitao (1):
      net: mediatek: Fix potential NULL pointer dereference in dummy net_device handling

Dan Carpenter (1):
      mISDN: Fix a use after free in hfcmulti_tx()

Donald Hunter (1):
      bpftool: Fix typo in usage help

Dongli Zhang (1):
      tun: add missing verification for short frame

Florian Westphal (1):
      netfilter: nft_set_pipapo_avx2: disable softinterrupts

Fred Li (1):
      bpf: Fix a segment issue when downgrading gso_size

Hangbin Liu (1):
      selftests: forwarding: skip if kernel not support setting bridge fdb learning limit

Hou Tao (1):
      bpf, events: Use prog to emit ksymbol event for main program

Ido Schimmel (1):
      ipv4: Fix incorrect source address in Record Route option

Jakub Kicinski (3):
      MAINTAINERS: make Breno the netconsole maintainer
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'tap-tun-harden-by-dropping-short-frame'

James Chapman (1):
      l2tp: make session IDR and tunnel session list coherent

Jay Vosburgh (1):
      MAINTAINERS: Update bonding entry

Johannes Berg (1):
      net: bonding: correctly annotate RCU in bond_should_notify_peers()

Liwei Song (1):
      tools/resolve_btfids: Fix comparison of distinct pointer types warning in resolve_btfids

Lorenzo Bianconi (1):
      net: airoha: Fix MBI_RX_AGE_SEL_MASK definition

Matthieu Baerts (NGI0) (1):
      tcp: process the 3rd ACK with sk_socket for TFO/MPTCP

Michal Luczaj (4):
      af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
      selftests/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()
      selftests/bpf: Parametrize AF_UNIX redir functions to accept send() flags
      selftests/bpf: Test sockmap redirect for AF_UNIX MSG_OOB

Naveen N Rao (2):
      MAINTAINERS: Update email address of Naveen
      MAINTAINERS: Update powerpc BPF JIT maintainers

Paolo Abeni (2):
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'nf-24-07-24' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Petr Machata (1):
      net: nexthop: Initialize all fields in dumped nexthops

Puranjay Mohan (1):
      selftests/bpf: fexit_sleep: Fix stack allocation for arm64

Shigeru Yoshida (1):
      tipc: Return non-zero value from tipc_udp_addr2str() on error

Si-Wei Liu (1):
      tap: add missing verification for short frame

Simon Horman (1):
      net: stmmac: Correct byte order of perfect_match

Stanislav Fomichev (2):
      xsk: Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len
      selftests/bpf: Add XDP_UMEM_TX_METADATA_LEN to XSK TX metadata test

Taehee Yoo (1):
      bnxt_en: update xdp_rxq_info in queue restart logic

Wojciech Drewek (1):
      ice: Fix recipe read procedure

 .mailmap                                           |  2 +
 Documentation/networking/xsk-tx-metadata.rst       | 16 ++--
 MAINTAINERS                                        | 19 +++--
 drivers/isdn/hardware/mISDN/hfcmulti.c             |  7 +-
 drivers/net/bonding/bond_main.c                    |  7 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 17 +++++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       | 22 +++++-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h          |  3 +
 drivers/net/ethernet/intel/ice/ice_switch.c        |  8 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 16 ++++
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h |  1 +
 drivers/net/ethernet/mediatek/airoha_eth.c         |  2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  3 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  4 +-
 drivers/net/tap.c                                  |  5 ++
 drivers/net/tun.c                                  |  3 +
 include/uapi/linux/if_xdp.h                        |  4 +
 kernel/events/core.c                               | 26 +++----
 net/core/filter.c                                  | 15 +++-
 net/ipv4/nexthop.c                                 |  7 +-
 net/ipv4/route.c                                   |  2 +-
 net/ipv4/tcp_input.c                               |  3 -
 net/l2tp/l2tp_core.c                               | 32 ++++----
 net/netfilter/nft_set_pipapo_avx2.c                | 12 ++-
 net/tipc/udp_media.c                               |  5 +-
 net/unix/af_unix.c                                 | 41 ++++++++++-
 net/unix/unix_bpf.c                                |  3 +
 net/xdp/xdp_umem.c                                 |  9 ++-
 tools/bpf/bpftool/prog.c                           |  2 +-
 tools/bpf/resolve_btfids/main.c                    |  2 +-
 tools/include/uapi/linux/if_xdp.h                  |  4 +
 tools/lib/bpf/btf_dump.c                           |  8 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |  1 -
 .../testing/selftests/bpf/prog_tests/fexit_sleep.c |  8 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 85 +++++++++++++++-------
 .../selftests/bpf/prog_tests/xdp_metadata.c        |  3 +-
 .../bpf/progs/btf_dump_test_case_multidim.c        |  4 +-
 .../bpf/progs/btf_dump_test_case_syntax.c          |  4 +-
 .../net/forwarding/bridge_fdb_learning_limit.sh    | 18 +++++
 43 files changed, 319 insertions(+), 122 deletions(-)

