Return-Path: <bpf+bounces-50917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE5EA2E4FA
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 08:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD5C188B3F5
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723901ADC79;
	Mon, 10 Feb 2025 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bH2jnpZA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FA2B9A9;
	Mon, 10 Feb 2025 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170944; cv=none; b=QF/uHWTpX5+RTW9/rpJS+afn7gXrq3LevghFJDdXKzI5zCTaBVQnO39qiOT7jyzjsfre77RVmsUofUfKDxUMoJiEFAeIHWTxjhkwRAJDHQh/9xyF4mwE23thHbG2I+Jjr1t2ZWuDECDbHrd7LkvRT6pKNXvTGKpLnMJr5fMNsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170944; c=relaxed/simple;
	bh=A6TYIK8aSCSb7ZF6jkLTpTG8icNieANxjH4vH8Z6hF4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oWEheS99O5jzpDrJMMgKirNcKe8rjxsZ11epQVWYTiFUVUYFObX1HLI/zpBGrJt6146OLjKECGURpGh1aCBcKJL7n8VVvfWKWGbhgn77cc3iHWb9X57YnCm8waV5j3zM+lCdSTSXjLB5xwbvxR0iI5c3jht23+yZgrcGBjwG2rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bH2jnpZA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170942; x=1770706942;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A6TYIK8aSCSb7ZF6jkLTpTG8icNieANxjH4vH8Z6hF4=;
  b=bH2jnpZAdSyM8kl1p91L8P4qgNsg4iiVThOxniM2YqzWt/Nb1KuGWhVa
   eYhnzZVkSTZ/aHm/Nwfam82vngQ8MsdzVE8qrjWzsgJLrmMLlZNqYY0Ap
   X9Y/MrXB+89Opp6WoJefnvtriD8MuWURhdWIgJTCRxcPljtfLkQfRvA0F
   HJoKBd8ztXNrJv8VClqpuILBYA/HJveYotx9bNdbJ+d2fZZUwTVu28zsv
   4PZR6Nd4qQYkK1XtpcMPcdfVkMdh8MSTzMp5PKnlsvGqq6/m61euUhqNA
   Ma6/1HkbHIKNsMbqoVaWpKXn+ByaqWhbmcnqOh2+kvpkR79HRhJDnfpr8
   w==;
X-CSE-ConnectionGUID: AzIKxufZT828kpWiB0j6XA==
X-CSE-MsgGUID: qnbFBQzaSY+ARTDUjqZJlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="38937739"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="38937739"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 23:02:21 -0800
X-CSE-ConnectionGUID: n1Yl94JKQPCqLknRIXgRfw==
X-CSE-MsgGUID: 0HQLcWpFQYmCJ2RkSR63Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="112622438"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa010.fm.intel.com with ESMTP; 09 Feb 2025 23:02:13 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v4 0/9] igc: Add support for Frame Preemption feature in IGC
Date: Mon, 10 Feb 2025 02:01:58 -0500
Message-Id: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduces support for the FPE feature in the IGC driver.

The patches aligns with the upstream FPE API:
https://patchwork.kernel.org/project/netdevbpf/cover/20230220122343.1156614-1-vladimir.oltean@nxp.com/
https://patchwork.kernel.org/project/netdevbpf/cover/20230119122705.73054-1-vladimir.oltean@nxp.com/

It builds upon earlier work:
https://patchwork.kernel.org/project/netdevbpf/cover/20220520011538.1098888-1-vinicius.gomes@intel.com/

The patch series adds the following functionalities to the IGC driver:
a) Configure FPE using `ethtool --set-mm`.
b) Display FPE settings via `ethtool --show-mm`.
c) View FPE statistics using `ethtool --include-statistics --show-mm'.
e) Enable preemptible/express queue with `fp`:
   tc qdisc add ... root taprio \
   fp E E P P

Change Log:
v3 -> v4:
- Fix compilation warnings introduced by this patch series

v2 -> v3:
- Implement configure_tx() mmsv callback (Vladimir)
- Use static_branch_inc() and static_branch_dec() (Vladimir)
- Add adapter->fpe.mmsv.pmac_enabled as extra check (Vladimir)
- Remove unnecessary error check in igc_fpe_init_tx_descriptor() (Vladimir)
- Additional places to use FIELD_PREP() instead of manual bit manipulation (Vladimir)
- IGC_TXD_POPTS_SMD_V and IGC_TXD_POPTS_SMD_R type change to enum (Vladimir)
- Remove unnecessary netif_running() check in igc_fpe_xmit_frame (Vladimir)
- Rate limit print in igc_fpe_send_mpacket (Vladimir)

v1 -> v2:
- Extract the stmmac verification logic into a common library (Vladimir)
- igc to use common library for verification (Vladimir)
- Fix syntax for kernel-doc to use "Return:" (Vladimir)
- Use FIELD_GET instead of manual bit masking (Vladimir)
- Don't assign 0 to statistics counter in igc_ethtool_get_mm_stats() (Vladimir)
- Use pmac-enabled as a condition to allow MAC address value 0 (Vladimir)
- Define macro register value in increasing value order (Vladimir)
- Fix tx-min-frag-size handling for igc (Vladimir)
- Handle link state changes with verification in igc (Vladimir)
- Add static key for fast path code (Vladimir)
- rx_min_frag_size get from constant (Vladimir)

v1: https://patchwork.kernel.org/project/netdevbpf/cover/20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com/
v2: https://patchwork.kernel.org/project/netdevbpf/cover/20250205100524.1138523-1-faizal.abdul.rahim@linux.intel.com/
v3: https://patchwork.kernel.org/project/netdevbpf/cover/20250207165649.2245320-1-faizal.abdul.rahim@linux.intel.com/

Faizal Rahim (8):
  igc: Rename xdp_get_tx_ring() for non-xdp usage
  igc: Optimize the TX packet buffer utilization
  igc: Set the RX packet buffer size for TSN mode
  igc: Add support for frame preemption verification
  igc: Add support to set tx-min-frag-size
  igc: Add support for preemptible traffic class in taprio
  igc: Add support to get MAC Merge data via ethtool
  igc: Add support to get frame preemption statistics via ethtool

Vladimir Oltean (1):
  net: ethtool: mm: extract stmmac verification logic into common
    library

 drivers/net/ethernet/intel/igc/igc.h          |  18 +-
 drivers/net/ethernet/intel/igc/igc_base.h     |   1 +
 drivers/net/ethernet/intel/igc/igc_defines.h  |  16 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  76 ++++++
 drivers/net/ethernet/intel/igc/igc_main.c     | 101 +++++++-
 drivers/net/ethernet/intel/igc/igc_regs.h     |  16 ++
 drivers/net/ethernet/intel/igc/igc_tsn.c      | 219 ++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.h      |  34 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  16 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  41 +---
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 174 +++-----------
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |   5 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   8 +-
 include/linux/ethtool.h                       |  61 +++++
 net/ethtool/mm.c                              | 224 +++++++++++++++++-
 15 files changed, 793 insertions(+), 217 deletions(-)

--
2.34.1


