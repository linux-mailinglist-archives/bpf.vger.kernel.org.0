Return-Path: <bpf+bounces-53036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCCAA4BC0F
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 11:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A81891B24
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61A1F17EB;
	Mon,  3 Mar 2025 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaliZTMc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2AA94A;
	Mon,  3 Mar 2025 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997653; cv=none; b=n8QZnJssI+2+DzUnU7om0iR+m8ZQ8skfdVM/cRTn2msm/CSVv9xcnyWBFdxHDisp5X5Oy6CHkobkf9hB5xhnQGfAxryjeH6/WoWoYGQpGSuEnChJ1rokTpe6II9FbwnBhT3Ki4JzD1cyoi/TAIP+aq/RMTHAmdJnK0Qg8L/zbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997653; c=relaxed/simple;
	bh=FDz6ptuo+7Aft80tGDKuObfSvghbYDAnsgP6ShdB+h8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ebs9VfiwtDMGFcukclqcafh6kNVnjsmqDURab94tyD8agoaML8cMC3CXOGXv2irjUf2c4A2em+IxMaFnHTG3V1JQ5umuVNCKH6qJdaPHaobfXC19uOVbF3Mbn7jWuaVrNxpOP7sHB5J8/GF/DAbuOZQFDkdfxDdHE9kIvfNSMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaliZTMc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740997652; x=1772533652;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FDz6ptuo+7Aft80tGDKuObfSvghbYDAnsgP6ShdB+h8=;
  b=PaliZTMcgQvn8FZFOuSvoAKMkreEtbxYU5D3I7tCHDoIpKjk1bNX0qVW
   ez4BStApzgjlWBlR+52WSHdL0BvgDtNrtdLNdTuHwMMa8b+vht0ghzrJz
   E3+PL731aNaYUKMz0NVTn0E4BN2a7JL31gnvkQ4Q/Pjt+Kz2GrjL6BuPX
   gLeXFYCrezUFwQNsDjlQMICAM9PFndzPUhoqq0z46EANvXcwH8wOCOOkI
   zILuxVQRDsGDLXdNk/pZEG7UgJfvSH7vBcU66LQzS45LPGhu+UvAyZibH
   etWdHfKLFsrdnmnMB1HsTNWtJBFp2mfxufh8sI7CNGeOokU/pECDce5Bs
   Q==;
X-CSE-ConnectionGUID: wd5osdPuRSSkjta9anY1Og==
X-CSE-MsgGUID: Ru7dRF1lS7WRnF+88/ff7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="64310033"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="64310033"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:27:31 -0800
X-CSE-ConnectionGUID: hMmtywriTWO7zIp6xwLCmg==
X-CSE-MsgGUID: 3pHgk5o+Sj624jh43tBMjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="122569850"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa005.fm.intel.com with ESMTP; 03 Mar 2025 02:27:22 -0800
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
Subject: [PATCH iwl-next v7 0/9] igc: Add support for Frame Preemption feature in IGC
Date: Mon,  3 Mar 2025 05:26:49 -0500
Message-Id: <20250303102658.3580232-1-faizal.abdul.rahim@linux.intel.com>
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
e) Block setting preemptible tc in taprio since it is not supported yet.
   Existing code already blocks it in mqprio.

Tested:
Enabled CONFIG_PROVE_LOCKING, CONFIG_DEBUG_ATOMIC_SLEEP, CONFIG_DMA_API_DEBUG, and CONFIG_KASAN
1) selftests
2) netdev down/up cycles
3) suspend/resume cycles
4) fpe verification

No bugs or unusual dmesg logs were observed.
Ran 1), 2) and 3) with and without the patch series, compared dmesg and selftest logs — no differences found.

Change Log:
v6 -> v7:
- Squash the cpu param to the prev line (Przemek Kitszel)
- Use igc_ prefix for fpe_t (Przemek Kitszel)
- Move new ops to different line in igc_ethtool_ops (Przemek Kitszel)
- Documentation for igc_enable_empty_addr_recv (): rx -> Rx (Przemek Kitszel)
- Documentation for igc_enable_empty_addr_recv (): s/IGC/the driver/ (Przemek Kitszel)
- Change preferred style of init, from { }, to {} (Przemek Kitszel)
- Remove inclusion of umbrella header <linux/kernel.h> in igc_tsn.c (Przemek Kitszel)
- End enum with "," in igc_txd_popts_type (Przemek Kitszel)
- Remove unnecessary braces in igc_fpe_is_verify_or_response() (Przemek Kitszel)

v5 -> v6:
- Added Tested-by: Furong Xu for patch 1/9 (Vladimir, Furong Xu)
- Updated logic in ethtool_mmsv_link_state_handle() (Vladimir, Furong Xu)
- Swap sequence of function call in stmmac_set_mm() (Furong Xu)
- Log an error if igc_enable_empty_addr_recv() fails (Vladimir)
- Move the patch ".. Block setting preemptible traffic .." before ".. Add support to get MAC Merge data .." (Vladimir)
- Move mmsv function kernel-doc from .h to .c file (Vladimir)

v4 -> v5:
- Remove "igc: Add support for preemptible traffic class in taprio" patch (Vladimir)
- Add a new patch "igc: Block setting preemptible traffic classes in taprio" (Vladimir)
- Add kernel-doc for mmsv api (Vladimir)
- olininfo_status to use host byte order (Simon)
- status_error should host byte type (Simon)
- Some code was misplaced in the wrong patch (Vladimir)
- Mix of tabs and spaces in patch description (Vladimir)
- Created igc_is_pmac_enabled() to reduce code repetition (Vladimir)

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
v4: https://patchwork.kernel.org/project/netdevbpf/cover/20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com/
v5: https://patchwork.kernel.org/project/netdevbpf/cover/20250220025349.3007793-1-faizal.abdul.rahim@linux.intel.com/
v6: https://patchwork.kernel.org/project/netdevbpf/cover/20250227140158.2129988-1-faizal.abdul.rahim@linux.intel.com/

Faizal Rahim (8):
  igc: Rename xdp_get_tx_ring() for non-xdp usage
  igc: Optimize the TX packet buffer utilization
  igc: Set the RX packet buffer size for TSN mode
  igc: Add support for frame preemption verification
  igc: Add support to set tx-min-frag-size
  igc: Block setting preemptible traffic class in taprio
  igc: Add support to get MAC Merge data via ethtool
  igc: Add support to get frame preemption statistics via ethtool

Vladimir Oltean (1):
  net: ethtool: mm: extract stmmac verification logic into common
    library

 drivers/net/ethernet/intel/igc/igc.h          |  15 +-
 drivers/net/ethernet/intel/igc/igc_base.h     |   1 +
 drivers/net/ethernet/intel/igc/igc_defines.h  |  15 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  76 +++++
 drivers/net/ethernet/intel/igc/igc_main.c     |  66 +++-
 drivers/net/ethernet/intel/igc/igc_regs.h     |  16 +
 drivers/net/ethernet/intel/igc/igc_tsn.c      | 192 +++++++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.h      |  52 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  16 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  41 +--
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 174 +++--------
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |   5 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   8 +-
 include/linux/ethtool.h                       |  73 +++++
 net/ethtool/mm.c                              | 281 +++++++++++++++++-
 15 files changed, 814 insertions(+), 217 deletions(-)

--
2.34.1


