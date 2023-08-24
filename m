Return-Path: <bpf+bounces-8498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA6D78788B
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160A8281613
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 19:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A0B15AEE;
	Thu, 24 Aug 2023 19:33:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2EE14A81;
	Thu, 24 Aug 2023 19:33:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22101BDF;
	Thu, 24 Aug 2023 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692905627; x=1724441627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vpZrNDwG531EI/mB/TFW3JzHeD1i02TeQmZYqpldh0w=;
  b=l1hYKjpCKjUblwbOyp46AlmILWMghRBCYaaxCCGvIzB/C60tujnzCv45
   0ASsqB9/q0F2KIW1sqyharkOTSZl4eCjROBt9yoQl+T7BJhI+qC+1fQFY
   WW678+0kvudIONYGfCHFFXPLVI5jJIsB8kjQ10CAMkLhMhEHgBqvlsbeD
   N4y/tPcMt/8lZjDA4Z1L3pt6Ff0aIf5kGkEL3nktPEfb63t4Tr96qHkMP
   Qci87cfnKb4dP/6ldTr0/qPMRv1FdwmPNt8YVPTNkHcL7VVDmX3+WyGjg
   NOYSA5KcEuh4uM++XRVqmZiQff7NaiEhgA3QctHDE4/hrA5B4TR0s1r3g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374516542"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374516542"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 12:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802667322"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802667322"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2023 12:33:40 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D249F33EA3;
	Thu, 24 Aug 2023 20:33:36 +0100 (IST)
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
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [RFC bpf-next 00/23] XDP metadata via kfuncs for ice + mlx5
Date: Thu, 24 Aug 2023 21:26:39 +0200
Message-ID: <20230824192703.712881-1-larysa.zaremba@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
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

[0] https://lore.kernel.org/bpf/CAADnVQLNeO81zc4f_z_UDCi+tJ2LS4dj2E1+au5TbXM+CPSyXQ@mail.gmail.com/
[1] https://lore.kernel.org/bpf/20230811161509.19722-1-larysa.zaremba@intel.com/

Aleksander Lobakin (1):
  net, xdp: allow metadata > 32

Larysa Zaremba (22):
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
  mlx5: implement VLAN tag XDP hint
  mlx5: implement RX checksum XDP hint

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
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  10 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 116 +++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  12 +-
 drivers/net/veth.c                            |  42 ++
 include/linux/if_vlan.h                       |   4 +-
 include/linux/mlx5/device.h                   |   4 +-
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
 29 files changed, 1124 insertions(+), 459 deletions(-)

-- 
2.41.0


