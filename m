Return-Path: <bpf+bounces-5354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FE7759D9D
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4612819EA
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A17275B0;
	Wed, 19 Jul 2023 18:41:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FAB275A4;
	Wed, 19 Jul 2023 18:41:44 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3186B6;
	Wed, 19 Jul 2023 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689792103; x=1721328103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Axyvzdd9KzHBUYTgGRXq8jCLDiRZwPwVdRBFgqLl9ms=;
  b=S8QUJ1OqMp+rHIqkwnmKRignk2tpP6Wr0qZ67F9HG5mQ26azP9mpyw92
   9DacO4VG8DbC3rx8u1By7HaFCuJwRfimz196Hp2cjjQuWExE29aVxFRSn
   999fYPUfzcMPejLQ+f9uWMouyFWRXPZ8ooFuLyGKSzyAYUyUlOrp9y5Ab
   91V1gV+EjoeBGYGix1DppslTyKIVGRGtWaUX13yX0wN7SLcDWNJhvDasG
   hNjg/wxGV04Bjub44CcU3E6XGSVP6WUIKykoNLZAtZ9472gmdFt4wKVV6
   aLd44++BUWRs9txU8bkf8L7EbHFLiLg7+I+JsEsn3tsO2PNKFjx3sm5PH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356504654"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356504654"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:41:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674405558"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674405558"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 11:41:36 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E84AD33BE5;
	Wed, 19 Jul 2023 19:41:34 +0100 (IST)
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
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 00/21] XDP metadata via kfuncs for ice
Date: Wed, 19 Jul 2023 20:37:13 +0200
Message-ID: <20230719183734.21681-1-larysa.zaremba@intel.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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

v2:
https://lore.kernel.org/bpf/20230703181226.19380-1-larysa.zaremba@intel.com/
v1:
https://lore.kernel.org/all/20230512152607.992209-1-larysa.zaremba@intel.com/

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
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 346 ++++++++++++---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  18 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  26 +-
 drivers/net/veth.c                            |  46 ++
 include/linux/if_vlan.h                       |   4 +-
 include/linux/netdevice.h                     |   5 +
 include/linux/skbuff.h                        |  13 +-
 include/net/xdp.h                             |  58 ++-
 kernel/bpf/offload.c                          |   4 +
 net/core/xdp.c                                |  57 +++
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 213 +++++----
 .../selftests/bpf/progs/xdp_hw_metadata.c     |  47 +-
 .../selftests/bpf/progs/xdp_metadata.c        |  10 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  79 +++-
 tools/testing/selftests/bpf/xdp_metadata.h    |  39 +-
 25 files changed, 1063 insertions(+), 444 deletions(-)

-- 
2.41.0


