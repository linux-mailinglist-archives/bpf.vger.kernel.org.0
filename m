Return-Path: <bpf+bounces-16346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA1800360
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 06:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE591B2109F
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 05:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3819BE7E;
	Fri,  1 Dec 2023 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdBv04z6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F193170C;
	Thu, 30 Nov 2023 21:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701409998; x=1732945998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rNUFphnEkQB+qWot/63Nna2HVEbtWnhUjyaz1RNUd68=;
  b=MdBv04z6GYo1k3KcUtbAdJL5Kj9svzrjZkJIjtE5NHWGcAZGQj/uhW0c
   C0Yl8G9dWzyMvFwNPj6t6ml7eW+Nb0X8s5fZsXZaQclRd/Ha6yBfb1c2F
   cFxYbti4N93Xjkl/PXJDu+IbFFVFVMM7Sg/Qa1ON7Yg5kzAXnoaKrsVt8
   KeDjD+gNK1EMRhhgD3lQfoxdVcgC5N/fYj49tPgrbx/OjkKzB07ZsDuhU
   NJ/nAHbEX6+1FnHyg1VKlMxgg68L7PUyMXuRA/3rJFStihcOFCIy8jK+P
   dsnyoV795GBAZqofp0uOt26SYrRTo6ST36Kho0ycd6O5retooztXlLEUC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="373623981"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="373623981"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 21:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="763004522"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="763004522"
Received: from ppgyli0104.png.intel.com ([10.126.160.64])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2023 21:53:04 -0800
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next v2 0/3] net: stmmac: EST implementation
Date: Fri,  1 Dec 2023 13:52:49 +0800
Message-Id: <20231201055252.1302-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
This patchset extends EST interrupt handling support to DWXGMAC IP
followed by refactoring of EST implementation. Added a separate
module for EST and moved all EST related functions to the new module.

Also added support for EST cycle-time-extension.

changelog v2:
* Refactor EST implementation as suggested by Serge and Jakub
* Added support for EST cycle-time-extension

Rohan G Thomas (3):
  net: stmmac: xgmac: EST interrupts handling
  net: stmmac: Refactor EST implementation
  net: stmmac: Add support for EST cycle-time-extension

 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   4 -
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 137 ---------------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  51 ------
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  16 --
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  53 ------
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  21 +++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  22 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   1 +
 .../net/ethernet/stmicro/stmmac/stmmac_est.c  | 165 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_est.h  |  64 +++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |   4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   8 +-
 15 files changed, 276 insertions(+), 275 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h

-- 
2.26.2


