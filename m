Return-Path: <bpf+bounces-407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C175A700B3D
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 17:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D989B1C2123C
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9707DBE5A;
	Fri, 12 May 2023 15:19:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D872412E;
	Fri, 12 May 2023 15:19:43 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779E4C0;
	Fri, 12 May 2023 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683904781; x=1715440781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AEHmn3N8eoQi8YuZE7vwKcyyiqTTaYlvbYO6EcoCop8=;
  b=WFEy9yqrQpncjAqwMNQSXsPIwGfRwiedwaMMxFtVwEfig5IDJJztqcTy
   vXMvfxVbU5xAKRqRkk+eU3e/aS1nRWN3tceYuL5k3EHFQ2DDPsjJRdWHI
   d87xOSz8hoslAfBadfOwpCUomf0A83MSoV3jYwzAYzx/GZcu3FopakFvu
   A42hp5XSl6qrb5p6bA4gJlAdlM9g1MQu7uyPEGb/kjYzJw16mT+ho5MS3
   QOMOzVqM5MMzVHn4QlL2DMbtn67LvrB9leC4LqbqnnKyH/5jTRFw+gAK6
   TnYP7cDvtNSvT4yx9ueNd55mDZCWcCXyzXq9odKKGXrp/yN9hyBiPs5Pd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="349651128"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="349651128"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 08:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="1030118846"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="1030118846"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 12 May 2023 08:19:35 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2306C35FB7;
	Fri, 12 May 2023 16:19:34 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 00/15] new kfunc XDP hints and ice implementation
Date: Fri, 12 May 2023 17:16:24 +0200
Message-Id: <20230512151639.992033-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series introduces XDP hints support into ice driver and adds new kfunc
hints that utilize hardware capabilities.

- patches 01-04 refactors driver descriptor to skb fields processing code,
  making it more reusable without changing any behavior.

- patches 05-08 add support add support for existing hints (timestamp and 
  hash) in ice driver.

- patches 09-12 introduce new kfunc hints, namely 2 VLAN tag hints 
  (ctag & stag separately) and "checksum level", which is basically
  a CHECKSUM_UNNECESSARY indicator. Then those hints are implemented in
  ice driver.

- patches 13-15 adjust xdp_hw_metadata to account for new hints.

- in particular, patch 14 lifts the limitation on data_meta size to be
  32 or lower, because all the information that needs to be passed into
  AF_XDP from XDP in xdp_hw_metadata no longer fits into 32 bytes.

Aleksander Lobakin (1):
  net, xdp: allow metadata > 32

Larysa Zaremba (14):
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
  xdp: Add checksum level hint
  ice: Implement checksum level hint
  selftests/bpf: Allow VLAN packets in xdp_hw_metadata
  selftests/bpf: Add flags and new hints to xdp_hw_metadata

 Documentation/networking/xdp-rx-metadata.rst  |  14 +-
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 412 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  18 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  13 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  23 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 311 +++++++++++--
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  13 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  16 +-
 include/linux/netdevice.h                     |   3 +
 include/linux/skbuff.h                        |  13 +-
 include/net/xdp.h                             |  16 +-
 kernel/bpf/offload.c                          |   6 +
 net/core/xdp.c                                |  36 ++
 .../selftests/bpf/progs/xdp_hw_metadata.c     |  49 ++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  29 +-
 tools/testing/selftests/bpf/xdp_metadata.h    |  36 +-
 19 files changed, 738 insertions(+), 296 deletions(-)

-- 
2.35.3


