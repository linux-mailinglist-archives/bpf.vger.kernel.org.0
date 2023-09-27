Return-Path: <bpf+bounces-10921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C37AFD2D
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 09:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8AC1D282469
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C641CA9C;
	Wed, 27 Sep 2023 07:57:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C691C285;
	Wed, 27 Sep 2023 07:57:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2FFBF;
	Wed, 27 Sep 2023 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801456; x=1727337456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+sMo3K8VEzjw6/6fyalMby3hEJHRRhqPjbbn9wZxKRQ=;
  b=WURTU/IyYmNYjS2YXZUMNepobi5GEJgD9o/asZYK8Xnt6ZZ1pbStXGn+
   EfGrfrvvvZFq3tYvphRODw6Q6yEM38/lEzBRG1uExGbXDpacoUMZ4duxs
   PDN9t0tLj8QQOcPAG48l0EecgCgs+oPfec88Dlyc3ghrqEYq9G2qLcrZH
   vooB4L/FrdupCykG3ASvH9wWq2yLoiLJQzyI5fTkY23ne8xBt5y5pXMqH
   Twp4K568gJ9irSynaqY17tC5rXhSCmP6CFwVgYb1r4LOxjsEgq9sTq+ln
   8ZnzB7qTEsWTRBHFIEbijTEych2RpYVpjjDrPgGDjkscD3TUH90S2S2Lb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366817799"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366817799"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1080039365"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="1080039365"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2023 00:57:28 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0B6097EAC3;
	Wed, 27 Sep 2023 08:57:26 +0100 (IST)
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
	Jesper Dangaard Brouer <brouer@redhat.com>,
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
Subject: [RFC bpf-next v2 00/24] XDP metadata via kfuncs for ice + mlx5
Date: Wed, 27 Sep 2023 09:51:00 +0200
Message-ID: <20230927075124.23941-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexei has requested an implementation of VLAN and checksum XDP hints
for one more driver [0].

This series is exactly the v5 of "XDP metadata via kfuncs for ice" [1]
with 2 additional patches for mlx5.

Firstly, there is a VLAN hint implementation. I am pretty sure this
one works and would not object adding it to the main series, if someone
from nvidia ACKs it.

The second patch is a checksum hint implementation and it is very rough.
There is logic duplication and some missing features, but I am sure it
captures the main points of the potential end implementation.

I think it is unrealistic for me to provide a fully working mlx5 checksum
hint implementation (complex logic, no HW), so would much rather prefer
not having it in my main series. My main intension with this RFC is
to prove proposed hints functions are suitable for non-intel HW.

On Maciej's request, I provide some numbers about impact of these patches
on ice performance.
ZC:
* Full hints implementation before addition of the static key decreases
  pps in ZC mode by 6%
* Adding a static key eliminates this drop. Overall performce difference
  compared to a clean tree in inconsequential.

skb (packets with invalid IP, dropped by stack):
* Overall, patchset improves performance in skb mode by 2%

[0] https://lore.kernel.org/bpf/CAADnVQLNeO81zc4f_z_UDCi+tJ2LS4dj2E1+au5TbXM+CPSyXQ@mail.gmail.com/
[1] https://lore.kernel.org/bpf/20230811161509.19722-1-larysa.zaremba@intel.com/

Changes since RFC v1:
* new patch: hide some ice hints code behind a static key
* fixed several bugs in ZC mode (ice)
* change argument order in VLAN hint kfunc (tci, proto -> proto, tci)
* cosmetic changes
* analyze performance impact

Aleksander Lobakin (1):
  net, xdp: allow metadata > 32

Larysa Zaremba (23):
  ice: make RX hash reading code more reusable
  ice: make RX HW timestamp reading code more reusable
  ice: make RX checksum checking code more reusable
  ice: Make ptype internal to descriptor info processing
  ice: Introduce ice_xdp_buff
  ice: Support HW timestamp hint
  ice: Support RX hash XDP hint
  ice: Support XDP hints in AF_XDP ZC mode
  xdp: Add VLAN tag hint
  ice: Implement VLAN tag hint
  ice: use VLAN proto from ring packet context in skb path
  xdp: Add checksum hint
  ice: Implement checksum hint
  ice: put XDP meta sources assignment under a static key condition
  selftests/bpf: Allow VLAN packets in xdp_hw_metadata
  selftests/bpf: Add flags and new hints to xdp_hw_metadata
  veth: Implement VLAN tag and checksum XDP hint
  net: make vlan_get_tag() return -ENODATA instead of -EINVAL
  selftests/bpf: Use AF_INET for TX in xdp_metadata
  selftests/bpf: Check VLAN tag and proto in xdp_metadata
  selftests/bpf: check checksum state in xdp_metadata
  mlx5: implement VLAN tag XDP hint
  mlx5: implement RX checksum XDP hint

 Documentation/networking/xdp-rx-metadata.rst  |  11 +-
 drivers/net/ethernet/intel/ice/ice.h          |   3 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 412 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  35 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  25 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  16 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  20 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  29 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 330 +++++++++++---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  18 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  49 ++-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  10 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 115 +++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  12 +-
 drivers/net/veth.c                            |  42 ++
 include/linux/if_vlan.h                       |   4 +-
 include/linux/mlx5/device.h                   |   4 +-
 include/linux/skbuff.h                        |  13 +-
 include/net/xdp.h                             |  33 +-
 include/uapi/linux/netdev.h                   |   8 +-
 net/core/xdp.c                                |  56 +++
 tools/include/uapi/linux/netdev.h             |   8 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 187 ++++----
 .../selftests/bpf/progs/xdp_hw_metadata.c     |  48 +-
 .../selftests/bpf/progs/xdp_metadata.c        |  16 +
 tools/testing/selftests/bpf/testing_helpers.h |   3 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  67 ++-
 tools/testing/selftests/bpf/xdp_metadata.h    |  42 +-
 30 files changed, 1161 insertions(+), 459 deletions(-)

-- 
2.41.0


