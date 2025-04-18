Return-Path: <bpf+bounces-56237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16231A93B08
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3D7189CBB1
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E0B215F6A;
	Fri, 18 Apr 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3Uwi3Iu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93E213E89;
	Fri, 18 Apr 2025 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994316; cv=none; b=G29Wgh+QtMbaAR9mog60tu/IoJRzws6ASlGbAHKQHxm+BCTK3xW7xKbZnUSF3QPVccN4YSiwAT+/yLM2OtNwpFa6ijUI0/foMd/Av4lt816REIIwbPu0zItMUw8riqNjHZ5oR9JH1AArdH+0YjBTtd3OeTsrU/nAa5zfnwS7lZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994316; c=relaxed/simple;
	bh=xqgpaY93D1rOJgzOV/8X2FRs9Z+GmQNa/gFVzslPY8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qy1XLi+t4Tb06/W73dRsZKXItKggQA7UeNcHDOpSuWG976NRKL2iVJjHw7OPad3Go0O1heE8BMkyMT5jNgb/vV5K0NLbEVNf9YBpWIRi+siARf0kc7MSmT0kwqeyzoUXcMxHq6jB+8orCfq82y5DNbuLmXcS6nQ8A8l0q0/940Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3Uwi3Iu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994314; x=1776530314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xqgpaY93D1rOJgzOV/8X2FRs9Z+GmQNa/gFVzslPY8c=;
  b=B3Uwi3IumUCg2y5MqqUFpwZ9A5mdyDHzEn9I7+728DGEok6iB3+L882G
   KtSalUQwQmqlOJQPvLOHNyBnUwLUgLiXcn6eTabtB5xXKTNgGCoHTm6NO
   qqH8ynHMEkwq++Y7/9bInFQYkvNNEC62/SSE7TCh7CalX8eWfzG+isMuF
   MI4qy2nWFgdVHNOr0wI5/C2EWhCxk1ZsVNzi0WmzChLh3Dy71uz4SyST3
   3VrXN9LRNKMnzrJfF76uk3E2KtfqTBqy+BL/FOwq5R34t4L0HMQkPSYHB
   6NhrG9kwJR6k5ma2/sTvBd+u6Y+UF7eAyN3bzpGfMiuDbOGjne3uezk0n
   A==;
X-CSE-ConnectionGUID: O959xCboTKmnlUkJgpBLgg==
X-CSE-MsgGUID: /m6X2oIgQRaXwwXrgQYXTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50454246"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="50454246"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:38:32 -0700
X-CSE-ConnectionGUID: +Tbp8mEFSiePHVO4giZG7g==
X-CSE-MsgGUID: erEenTHARDWNKFJ8TG/WsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="130892216"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Apr 2025 09:38:32 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	faizal.abdul.rahim@linux.intel.com,
	vinicius.gomes@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	przemyslaw.kitszel@intel.com,
	chwee.lin.choong@intel.com,
	yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	xiaolei.wang@windriver.com,
	hayashi.kunihiko@socionext.com,
	ast@kernel.org,
	jesper.nilsson@axis.com,
	mcoquelin.stm32@gmail.com,
	rmk+kernel@armlinux.org.uk,
	fancer.lancer@gmail.com,
	kory.maincent@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	hkelam@marvell.com,
	alexandre.torgue@foss.st.com,
	daniel@iogearbox.net,
	linux-arm-kernel@lists.infradead.org,
	hawk@kernel.org,
	quic_jsuraj@quicinc.com,
	gal@nvidia.com,
	john.fastabend@gmail.com,
	0x1207@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next 00/14][pull request] igc: Add support for Frame Preemption
Date: Fri, 18 Apr 2025 09:38:06 -0700
Message-ID: <20250418163822.3519810-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Faizal Rahim says:

Introduce support for the FPE feature in the IGC driver.

The patches aligns with the upstream FPE API:
https://patchwork.kernel.org/project/netdevbpf/cover/20230220122343.1156614-1-vladimir.oltean@nxp.com/
https://patchwork.kernel.org/project/netdevbpf/cover/20230119122705.73054-1-vladimir.oltean@nxp.com/

It builds upon earlier work:
https://patchwork.kernel.org/project/netdevbpf/cover/20220520011538.1098888-1-vinicius.gomes@intel.com/

The patch series adds the following functionalities to the IGC driver:
a) Configure FPE using `ethtool --set-mm`.
b) Display FPE settings via `ethtool --show-mm`.
c) View FPE statistics using `ethtool --include-statistics --show-mm'.
e) Block setting preemptible tc in taprio since it is not supported yet.
   Existing code already blocks it in mqprio.

Tested:
Enabled CONFIG_PROVE_LOCKING, CONFIG_DEBUG_ATOMIC_SLEEP, CONFIG_DMA_API_DEBUG, and CONFIG_KASAN
1) selftests
2) netdev down/up cycles
3) suspend/resume cycles
4) fpe verification

No bugs or unusual dmesg logs were observed.
Ran 1), 2) and 3) with and without the patch series, compared dmesg and selftest logs - no differences found.
---
IWL: https://lore.kernel.org/intel-wired-lan/20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com/

The following are changes since commit 8066e388be48f1ad62b0449dc1d31a25489fa12a:
  net: add UAPI to the header guard in various network headers
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Faizal Rahim (13):
  net: stmmac: move frag_size handling out of spin_lock
  net: ethtool: mm: reset verification status when link is down
  igc: rename xdp_get_tx_ring() for non-xdp usage
  igc: rename I225_RXPBSIZE_DEFAULT and I225_TXPBSIZE_DEFAULT
  igc: use FIELD_PREP and GENMASK for existing TX packet buffer size
  igc: optimize TX packet buffer utilization for TSN mode
  igc: use FIELD_PREP and GENMASK for existing RX packet buffer size
  igc: set the RX packet buffer size for TSN mode
  igc: add support for frame preemption verification
  igc: add support to set tx-min-frag-size
  igc: block setting preemptible traffic class in taprio
  igc: add support to get MAC Merge data via ethtool
  igc: add support to get frame preemption statistics via ethtool

Vladimir Oltean (1):
  net: ethtool: mm: extract stmmac verification logic into common
    library

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/igc/igc.h          |  15 +-
 drivers/net/ethernet/intel/igc/igc_base.h     |   1 +
 drivers/net/ethernet/intel/igc/igc_defines.h  |  55 +++-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  81 +++++
 drivers/net/ethernet/intel/igc/igc_main.c     |  69 ++++-
 drivers/net/ethernet/intel/igc/igc_regs.h     |  16 +
 drivers/net/ethernet/intel/igc/igc_tsn.c      | 210 ++++++++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.h      |  52 ++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  16 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  41 +--
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 174 +++--------
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |   5 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   8 +-
 include/linux/ethtool.h                       |  73 +++++
 net/ethtool/mm.c                              | 279 +++++++++++++++++-
 17 files changed, 876 insertions(+), 221 deletions(-)

-- 
2.47.1


