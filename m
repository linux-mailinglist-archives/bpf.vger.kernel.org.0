Return-Path: <bpf+bounces-3894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD447461FE
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AB0280E4F
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E732510966;
	Mon,  3 Jul 2023 18:17:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F1100DD;
	Mon,  3 Jul 2023 18:17:10 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575BCE60;
	Mon,  3 Jul 2023 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688408200; x=1719944200;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8LOkKCUf/lCFx2H2v1v9sFUPEOVkpb3UN6V5E13pSJU=;
  b=D2dYySY2/5/SWDKTA3B7llT25gjn+dycvEXsyPSqVsaX0F8DZV6ThcQ0
   JRAlznLcTgDO8h7Cx8tsPLw+iJWXclAuVmcS8l0Q/ie6EpKbIuGKUP21S
   eS130EwXwigSqQFxdBJcoJespuxJEZ35SEtQTsNZJIwkoj+oIB/3MXMqU
   0iRv0ayqA1MycWvF1upbyhKMXMEee8kqoi0oH3eIrsq6Z9uR5XUC8NpsM
   B7KxiTw9h1XFb+wEH+ecd6eFzX/llJRFFsW6gHct+fWOg2FJ13a86mfrk
   lsz072X7qLqGJMTdygGVkFceDnSjgIicUq8AeAO4YwvN/C2US1yTtl0tI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="428982844"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="428982844"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:16:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="753816380"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="753816380"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga001.jf.intel.com with ESMTP; 03 Jul 2023 11:16:28 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6F16B35803;
	Mon,  3 Jul 2023 19:16:26 +0100 (IST)
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
Subject: [PATCH bpf-next v2 00/20] XDP metadata via kfuncs for ice
Date: Mon,  3 Jul 2023 20:12:06 +0200
Message-ID: <20230703181226.19380-1-larysa.zaremba@intel.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series introduces XDP hints via kfuncs [0] to the ice driver.

Series brings the following existing hints to the ice driver:
 - HW timestamp
 - RX hash with type

Series also introduces new hints and adds their implementation
to ice and veth:
 - VLAN tag with protocol
 - Checksum level

The data above can now be accessed by XDP and userspace (AF_XDP) programs.
They can also be checked with xdp_metadata test and xdp_hw_metadata program.

[0] https://patchwork.kernel.org/project/netdevbpf/cover/20230119221536.3349901-1-sdf@google.com/

v1:
https://lore.kernel.org/all/20230512152607.992209-1-larysa.zaremba@intel.com/

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

Larysa Zaremba (19):
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
  xdp: Add checksum level hint
  ice: Implement checksum level hint
  selftests/bpf: Allow VLAN packets in xdp_hw_metadata
  selftests/bpf: Add flags and new hints to xdp_hw_metadata
  veth: Implement VLAN tag and checksum level XDP hint
  selftests/bpf: Use AF_INET for TX in xdp_metadata
  selftests/bpf: Check VLAN tag and proto in xdp_metadata
  selftests/bpf: check checksum level in xdp_metadata

 Documentation/networking/xdp-rx-metadata.rst  |  11 +-
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 412 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  23 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  26 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  15 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  15 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  29 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 339 +++++++++++---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  16 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  18 +-
 drivers/net/veth.c                            |  40 ++
 include/linux/netdevice.h                     |   3 +
 include/linux/skbuff.h                        |  13 +-
 include/net/xdp.h                             |  14 +-
 kernel/bpf/offload.c                          |   4 +
 net/core/xdp.c                                |  41 ++
 tools/testing/selftests/bpf/network_helpers.c |  37 +-
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 195 ++++-----
 .../selftests/bpf/progs/xdp_hw_metadata.c     |  45 +-
 .../selftests/bpf/progs/xdp_metadata.c        |  11 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  42 +-
 tools/testing/selftests/bpf/xdp_metadata.h    |  36 +-
 26 files changed, 953 insertions(+), 441 deletions(-)

-- 
2.41.0


