Return-Path: <bpf+bounces-7565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F509779432
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8D6282265
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA76C1171A;
	Fri, 11 Aug 2023 16:20:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5D11701;
	Fri, 11 Aug 2023 16:20:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D00992;
	Fri, 11 Aug 2023 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691770803; x=1723306803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ig8Rsyw6R9Hqmc8W6Jm8TKLVYM7OHcEFUQj1E4PPqDE=;
  b=lmU/by82aRoOvAo869/0ZkKy54G3/kjL1hqbZVtqwncbcu+Fv7/7a5Av
   uLHHKtqKqVGDP3SEuCHF863jZdXHhv2yc2Obtgxf+9pbyQfVVghg5y/SB
   hR+ahGdKsxoo7V5ZVypi4qKOFPgA4u1dHXfQFg0JWzuBeiXDhuGUZx28s
   G3jJrYzQfeLf+qybb1Dy8LQJuItMHHtKNaVbPMCLvFJXxtu4EYIuUky8d
   3QgTkqyHdWbjgominfBe6RV4vC7W6s6TVadfAhSP8Xd0446/79QB8d8TJ
   yM3Tg2+KnCjs20EfyEf1Em5eLoX8oOZrs1Hzj7too6OAbQzFtX0LNlhBC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="351314292"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="351314292"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 09:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="906500929"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="906500929"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2023 09:19:55 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9ECC9332A0;
	Fri, 11 Aug 2023 17:19:53 +0100 (IST)
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
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH bpf-next v5 00/21] XDP metadata via kfuncs for ice
Date: Fri, 11 Aug 2023 18:14:48 +0200
Message-ID: <20230811161509.19722-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series introduces XDP hints via kfuncs [0] to the ice driver.

Series brings the following existing hints to the ice driver:
 - HW timestamp
 - RX hash with type

Series also introduces new hints and adds their implementation
to ice and veth:
 - VLAN tag with protocol
 - Checksum status

The data above can now be accessed by XDP and userspace (AF_XDP) programs.
They can also be checked with xdp_metadata test and xdp_hw_metadata program.

[0] https://patchwork.kernel.org/project/netdevbpf/cover/20230119221536.3349901-1-sdf@google.com/

v4:
https://lore.kernel.org/bpf/20230728173923.1318596-1-larysa.zaremba@intel.com/
v3:
https://lore.kernel.org/bpf/20230719183734.21681-1-larysa.zaremba@intel.com/
v2:
https://lore.kernel.org/bpf/20230703181226.19380-1-larysa.zaremba@intel.com/
v1:
https://lore.kernel.org/all/20230512152607.992209-1-larysa.zaremba@intel.com/

Changes since v4:
- Drop the concept of partial checksum from the hint design
- Drop the concept of checksum level from the hint design

Changes since v3:
- use XDP_CHECKSUM_VALID_LVL0 + csum_level instead of csum_level + 1
- fix spelling mistakes
- read XDP timestamp unconditionally
- add TO_STR() macro

Changes since v2:
- redesign checksum hint, so now it gives full status
- rename vlan_tag -> vlan_tci, where applicable
- use open_netns() and close_netns() in xdp_metadata
- improve VLAN hint documentation
- replace CFI with DEI
- use VLAN_VID_MASK in xdp_metadata
- make vlan_get_tag() return -ENODATA
- remove unused rx_ptype in ice_xsk.c
- fix ice timestamp code division between patches

Changes since v1:
- directly return RX hash, RX timestamp and RX checksum status
  in skb-common functions
- use intermediate enum value for checksum status in ice
- get rid of ring structure dependency in ice kfunc implementation
- make variables const, when possible, in ice implementation
- use -ENODATA instead of -EOPNOTSUPP for driver implementation
- instead of having 2 separate functions for c-tag and s-tag,
  use 1 function that outputs both VLAN tag and protocol ID
- improve documentation for introduced hints
- update xdp_metadata selftest to test new hints
- implement new hints in veth, so they can be tested in xdp_metadata
- parse VLAN tag in xdp_hw_metadata

Aleksander Lobakin (1):
  net, xdp: allow metadata > 32

Larysa Zaremba (20):
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
  selftests/bpf: Allow VLAN packets in xdp_hw_metadata
  selftests/bpf: Add flags and new hints to xdp_hw_metadata
  veth: Implement VLAN tag and checksum XDP hint
  net: make vlan_get_tag() return -ENODATA instead of -EINVAL
  selftests/bpf: Use AF_INET for TX in xdp_metadata
  selftests/bpf: Check VLAN tag and proto in xdp_metadata
  selftests/bpf: check checksum state in xdp_metadata

 Documentation/networking/xdp-rx-metadata.rst  |  11 +-
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 412 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  23 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  27 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  15 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  19 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  29 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 343 ++++++++++++---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  18 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  26 +-
 drivers/net/veth.c                            |  42 ++
 include/linux/if_vlan.h                       |   4 +-
 include/linux/skbuff.h                        |  13 +-
 include/net/xdp.h                             |  29 +-
 kernel/bpf/offload.c                          |   4 +
 net/core/xdp.c                                |  57 +++
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 187 ++++----
 .../selftests/bpf/progs/xdp_hw_metadata.c     |  48 +-
 .../selftests/bpf/progs/xdp_metadata.c        |  16 +
 tools/testing/selftests/bpf/testing_helpers.h |   3 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  67 ++-
 tools/testing/selftests/bpf/xdp_metadata.h    |  42 +-
 25 files changed, 995 insertions(+), 446 deletions(-)

-- 
2.41.0


