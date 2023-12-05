Return-Path: <bpf+bounces-16790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1464806038
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B18BB21072
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB666E2AE;
	Tue,  5 Dec 2023 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NliZEoxb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A68B18F;
	Tue,  5 Dec 2023 13:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810647; x=1733346647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kj6pEmB338Ic4Gh12ntrKi0G9SJXjBINIhr4CPVXh0Y=;
  b=NliZEoxbubrQbkHFffJaJJQWQ8dJnC4YiOSq70bZpNzYBKpz42xbeZZn
   uBFkm/WipUVwBtcipxvQjoSzSBW/ZoMPf5sRakLwebZhXwuk1QGoiKXFC
   XJityl4GB4nBESi8U/s8UcfNxxGoPkfpIt+n/w/A9Uo/lE9dJaBzAQy1s
   WIiAcbUUbLRumYsfkut0dLCNJ5hkUB4ruaeeasvvnm6RNJozw6JrFvzqK
   QXixzNX1BBw6TMB7A9zm4ylcBTvewheOwc4jltpivno32fihP4vBQNQdF
   zP6rQ0QB0okUrwXP4BtSBpDD0xleEymthV/nh4hIrI2CzyT0yygl9ClXA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373421783"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="373421783"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:10:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774757572"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="774757572"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2023 13:10:41 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8981834328;
	Tue,  5 Dec 2023 21:10:38 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v8 00/18] XDP metadata via kfuncs for ice + VLAN hint
Date: Tue,  5 Dec 2023 22:08:29 +0100
Message-ID: <20231205210847.28460-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces XDP hints via kfuncs [0] to the ice driver.

Series brings the following existing hints to the ice driver:
 - HW timestamp
 - RX hash with type

Series also introduces VLAN tag with protocol XDP hint, it now be accessed by
XDP and userspace (AF_XDP) programs. They can also be checked with xdp_metadata
test and xdp_hw_metadata program.

Impact of these patches on ice performance:
ZC:
* Full hints implementation decreases pps in ZC mode by less than 3%
  (64B, rxdrop)

skb (packets with invalid IP, dropped by stack):
* Overall, patchset improves peak performance in skb mode by about 0.5%

[0] https://patchwork.kernel.org/project/netdevbpf/cover/20230119221536.3349901-1-sdf@google.com/

v7:
https://lore.kernel.org/bpf/20231115175301.534113-1-larysa.zaremba@intel.com/
v6:
https://lore.kernel.org/bpf/20231012170524.21085-1-larysa.zaremba@intel.com/
Intermediate RFC v2:
https://lore.kernel.org/bpf/20230927075124.23941-1-larysa.zaremba@intel.com/
Intermediate RFC v1:
https://lore.kernel.org/bpf/20230824192703.712881-1-larysa.zaremba@intel.com/
v5:
https://lore.kernel.org/bpf/20230811161509.19722-1-larysa.zaremba@intel.com/
v4:
https://lore.kernel.org/bpf/20230728173923.1318596-1-larysa.zaremba@intel.com/
v3:
https://lore.kernel.org/bpf/20230719183734.21681-1-larysa.zaremba@intel.com/
v2:
https://lore.kernel.org/bpf/20230703181226.19380-1-larysa.zaremba@intel.com/
v1:
https://lore.kernel.org/all/20230512152607.992209-1-larysa.zaremba@intel.com/

Changes since v7:
* shorten timestamp assignment in ice
* change first argument of ice_fill_rx_descs back to xsk_buff_pool
* fix kernel-doc for ice_run_xdp_zc
* add missing XSK_CHECK_PRIV_TYPE() in ice
* resolved selftests merge conflicts with TX hints
* AF_INET patch adds new packet generation, not replaces AF_XDP one
* fix destination port in xdp_metadata

Changes since v6:
* add ability to fill cb of all xdp_buffs in xsk_buff_pool
* place just pointer to packet context in ice_xdp_buff
* add const qualifiers in veth implementation
* generate uapi for VLAN hint

Changes since v5:
* drop checksum hint from the patchset entirely
* Alex's patch that lifts the data_meta size limitation is no longer
  required in this patchset, so will be sent separately
* new patch: hide some ice hints code behind a static key
* fix several bugs in ZC mode (ice)
* change argument order in VLAN hint kfunc (tci, proto -> proto, tci)
* cosmetic changes
* analyze performance impact

Changes since v4:
* Drop the concept of partial checksum from the hint design
* Drop the concept of checksum level from the hint design

Changes since v3:
* use XDP_CHECKSUM_VALID_LVL0 + csum_level instead of csum_level + 1
* fix spelling mistakes
* read XDP timestamp unconditionally
* add TO_STR() macro

Changes since v2:
* redesign checksum hint, so now it gives full status
* rename vlan_tag -> vlan_tci, where applicable
* use open_netns() and close_netns() in xdp_metadata
* improve VLAN hint documentation
* replace CFI with DEI
* use VLAN_VID_MASK in xdp_metadata
* make vlan_get_tag() return -ENODATA
* remove unused rx_ptype in ice_xsk.c
* fix ice timestamp code division between patches

Changes since v1:
* directly return RX hash, RX timestamp and RX checksum status
  in skb-common functions
* use intermediate enum value for checksum status in ice
* get rid of ring structure dependency in ice kfunc implementation
* make variables const, when possible, in ice implementation
* use -ENODATA instead of -EOPNOTSUPP for driver implementation
* instead of having 2 separate functions for c-tag and s-tag,
  use 1 function that outputs both VLAN tag and protocol ID
* improve documentation for introduced hints
* update xdp_metadata selftest to test new hints
* implement new hints in veth, so they can be tested in xdp_metadata
* parse VLAN tag in xdp_hw_metadata

Larysa Zaremba (17):
  ice: make RX hash reading code more reusable
  ice: make RX HW timestamp reading code more reusable
  ice: Make ptype internal to descriptor info processing
  ice: Introduce ice_xdp_buff
  ice: Support HW timestamp hint
  ice: Support RX hash XDP hint
  ice: Support XDP hints in AF_XDP ZC mode
  xdp: Add VLAN tag hint
  ice: Implement VLAN tag hint
  ice: use VLAN proto from ring packet context in skb path
  veth: Implement VLAN tag XDP hint
  net: make vlan_get_tag() return -ENODATA instead of -EINVAL
  mlx5: implement VLAN tag XDP hint
  selftests/bpf: Allow VLAN packets in xdp_hw_metadata
  selftests/bpf: Add flags and VLAN hint to xdp_hw_metadata
  selftests/bpf: Add AF_INET packet generation to xdp_metadata
  selftests/bpf: Check VLAN tag and proto in xdp_metadata

Maciej Fijalkowski (1):
  xsk: add functions to fill control buffer

 Documentation/netlink/specs/netdev.yaml       |   4 +
 Documentation/networking/xdp-rx-metadata.rst  |   8 +-
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_base.c     |  15 +
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 412 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_main.c     |  21 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  16 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  19 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  32 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 207 ++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  18 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  17 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  15 +
 drivers/net/veth.c                            |  19 +
 include/linux/if_vlan.h                       |   4 +-
 include/linux/mlx5/device.h                   |   2 +-
 include/net/xdp.h                             |   9 +
 include/net/xdp_sock_drv.h                    |  17 +
 include/net/xsk_buff_pool.h                   |   2 +
 include/uapi/linux/netdev.h                   |   3 +
 net/core/xdp.c                                |  33 ++
 net/xdp/xsk_buff_pool.c                       |  12 +
 tools/include/uapi/linux/netdev.h             |   3 +
 tools/net/ynl/generated/netdev-user.c         |   1 +
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 134 +++++-
 .../selftests/bpf/progs/xdp_hw_metadata.c     |  38 +-
 .../selftests/bpf/progs/xdp_metadata.c        |   5 +
 tools/testing/selftests/bpf/testing_helpers.h |   3 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  34 +-
 tools/testing/selftests/bpf/xdp_metadata.h    |  34 +-
 31 files changed, 851 insertions(+), 310 deletions(-)

-- 
2.41.0


