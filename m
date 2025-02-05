Return-Path: <bpf+bounces-50498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EED8A28758
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 11:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3DF7A6E30
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 10:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D64222A80C;
	Wed,  5 Feb 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mX7Cpudp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3A1547D8;
	Wed,  5 Feb 2025 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749936; cv=none; b=mzslCUTnjOahtcvvFB6Vd/i+xHW1A6crRxtmCQ7mAvkPUC45qMb8ejo/evIvqDpykebtWAbbtFL/twIN2qsgU+jjCkzI47Zr915Rr6NwT1DcD5VlZmUCmflwfEloOso4w0zNBbr1ryFvxqDZIr+peVhg1FKtCyqL9q9pPGlWpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749936; c=relaxed/simple;
	bh=oaE6MvXosBwRaUfGg7gC0cYDCnNk9prSVztT1QQcdj0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LQ+mLdUdYi63rUxEFBGdXQ+Sk8bmxkSvO2s13qgdfiEj/PP1jn1aL6toIpoWHZDwlE706SfpukOEWu/AsEx4QjUV+sC/j9P6SZG+l6/5LAsk1iMUKe3q48hxyHxtAHL7IT5VMWuCskWd+zUFjJr9mfnD8q+mn34oZTfHHIIT2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mX7Cpudp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738749936; x=1770285936;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oaE6MvXosBwRaUfGg7gC0cYDCnNk9prSVztT1QQcdj0=;
  b=mX7Cpudp7SykbfHBzcmNdQ9SWrcfMqHdEEJsarw09ikWZc0i8xU4iq3w
   Cbbntx+t8YlQ+wRkVg8p2UFsFKZzSxgAAvP+IMiK4Fg3HyBAtv5J+odlB
   QUP5USRruHbH9KQwmFYn2aTzHYVafj1okpWXaNSKmA1tTwLp0v+vhAMLS
   cSGgfdjtYVuz7jVHblLGIflNHDxtYSPc2Iv0aXNDIXC93KLpzjN7JTV9t
   uLDHPrh39o9Nlxjb4MANvIG5tROY+BXhmQbq2zNXi2qaOSFxRV9S3vRjs
   wpauRT3e9Q9l7gm9BTg0uX4Q8PY8rigzuNdni5eg+GDJx/qQq1afQXwOw
   A==;
X-CSE-ConnectionGUID: +U2/eMqyQdC6NgN6ELx3yw==
X-CSE-MsgGUID: q1h/FNAFReO+h0B3/CnHDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39204625"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39204625"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 02:05:35 -0800
X-CSE-ConnectionGUID: RaRy/qV4SDObdLKqG2hLRg==
X-CSE-MsgGUID: 86KMttjBS/m9E6JVm5lvUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111297683"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa007.jf.intel.com with ESMTP; 05 Feb 2025 02:05:27 -0800
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
	Russell King <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v2 0/9] igc: Add support for Frame Preemption feature in IGC
Date: Wed,  5 Feb 2025 05:05:15 -0500
Message-Id: <20250205100524.1138523-1-faizal.abdul.rahim@linux.intel.com>
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

 drivers/net/ethernet/intel/igc/igc.h          |  17 +-
 drivers/net/ethernet/intel/igc/igc_defines.h  |  19 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  74 ++++++
 drivers/net/ethernet/intel/igc/igc_main.c     |  96 +++++++-
 drivers/net/ethernet/intel/igc/igc_regs.h     |  16 ++
 drivers/net/ethernet/intel/igc/igc_tsn.c      | 210 +++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.h      |  34 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  16 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  41 +---
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 174 +++-----------
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |   5 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   8 +-
 include/linux/ethtool.h                       |  62 +++++
 net/ethtool/mm.c                              | 225 +++++++++++++++++-
 14 files changed, 780 insertions(+), 217 deletions(-)

--
2.34.1


