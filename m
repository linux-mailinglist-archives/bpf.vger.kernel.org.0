Return-Path: <bpf+bounces-12048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352EE7C73C2
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FEF1C21154
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37211339AA;
	Thu, 12 Oct 2023 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ah7yQW6L"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F72B76E;
	Thu, 12 Oct 2023 17:12:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D92B7;
	Thu, 12 Oct 2023 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697130760; x=1728666760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AU5WQZnJB4MsmwO/vorGeCBj1LsumsIqK9Eo87FY3Kk=;
  b=Ah7yQW6LhMqaanPBg+CfspuQDy87iWUA7rYqNyHw/9eCgksTcebBtE2W
   +CcBVCtslPIAFGh1rdQGPQGV0gdeGhly/+9dRbxkXSyuSWxBlzDrPkL5h
   MPObWws9aXSN/ogd0Le0cY12sO5dMkD3FWkXBTlk/nrrtmj0EPEXbYC82
   MnisUDGdr5shyPPddY39dDAGLK65faR5AXMu2rtbXyVXEJEVgqNABm+Vx
   Yrj4rorOZ6lxmcIGOkubu4Ghljy0aAJdU82M1NJeK4KZtDibkpRzjRepf
   w1SjiOMYf7CaJOw0wBRFqOG6uoWdN7OzmRxbpMaYTuttUIRx1IqKZAD5n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416027516"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="416027516"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="783773891"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="783773891"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2023 10:11:46 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3F4A733BFF;
	Thu, 12 Oct 2023 18:11:43 +0100 (IST)
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
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v6 00/18] XDP metadata via kfuncs for ice + VLAN hint
Date: Thu, 12 Oct 2023 19:05:06 +0200
Message-ID: <20231012170524.21085-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series introduces XDP hints via kfuncs [0] to the ice driver.

Series brings the following existing hints to the ice driver:
 - HW timestamp
 - RX hash with type

Series also introduces VLAN tag with protocol XDP hint, it now be accessed by
XDP and userspace (AF_XDP) programs. They can also be checked with xdp_metadata
test and xdp_hw_metadata program.

On Maciej's request, I provide some numbers about impact of these patches
on ice performance.
ZC:
* Full hints implementation before addition of the static key decreases
  pps in ZC mode by 6%
* Adding a static key eliminates this drop. Overall performce difference
  compared to a clean tree in inconsequential.

skb (packets with invalid IP, dropped by stack):
* Overall, patchset improves peak performance in skb mode by about 0.5%

[0] https://patchwork.kernel.org/project/netdevbpf/cover/20230119221536.3349901-1-sdf@google.com/

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

Larysa Zaremba (18):
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
  ice: put XDP meta sources assignment under a static key condition
  veth: Implement VLAN tag XDP hint
  net: make vlan_get_tag() return -ENODATA instead of -EINVAL
  mlx5: implement VLAN tag XDP hint
  selftests/bpf: Allow VLAN packets in xdp_hw_metadata
  selftests/bpf: Add flags and VLAN hint to xdp_hw_metadata
  selftests/bpf: Use AF_INET for TX in xdp_metadata
  selftests/bpf: Check VLAN tag and proto in xdp_metadata

 Documentation/networking/xdp-rx-metadata.rst  |   8 +-
 drivers/net/ethernet/intel/ice/ice.h          |   3 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 412 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  35 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  25 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  16 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  20 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  29 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 209 ++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  18 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  49 ++-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  15 +
 drivers/net/veth.c                            |  19 +
 include/linux/if_vlan.h                       |   4 +-
 include/linux/mlx5/device.h                   |   2 +-
 include/net/xdp.h                             |   9 +
 include/uapi/linux/netdev.h                   |   5 +-
 net/core/xdp.c                                |  33 ++
 tools/include/uapi/linux/netdev.h             |   5 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 184 ++++----
 .../selftests/bpf/progs/xdp_hw_metadata.c     |  38 +-
 .../selftests/bpf/progs/xdp_metadata.c        |   5 +
 tools/testing/selftests/bpf/testing_helpers.h |   3 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  38 +-
 tools/testing/selftests/bpf/xdp_metadata.h    |  34 +-
 27 files changed, 816 insertions(+), 406 deletions(-)

-- 
2.41.0


