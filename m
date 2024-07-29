Return-Path: <bpf+bounces-35917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3239093FEB7
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FED2821CA
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5D7188CC5;
	Mon, 29 Jul 2024 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+pWqe1D"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1E43152;
	Mon, 29 Jul 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283645; cv=none; b=XdqVh8eVGwNyiO1ieWfbo2UGuExe5i0hm9NjGlVWalzsY/pVtW7ipbOTVqeThgHD6UGH+djo1073QpaqZGJc6xjv6jKkVvbSewPJzaF6rpH5y1evSCAKSt/WbqoZ5TDY9UXpfikawUn5f3aojozhxQ4rNUQRHUaBTv3T508FWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283645; c=relaxed/simple;
	bh=VtstHWeYePnlour2DE34TcD9zpx6jc0H7BoD063yGYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8EeZTdEAOO9FR1AyJTodxH+yx6/yRKKYIUhIo8kzsw7DCFYl7kCgl86QRzMcEZAxxrZ8YLq24S9hCmbnwA95ewSDjiVG8SKvxj7PMWa/D5FZt/xMK1sSl8An9+RW4+jNDC9fDxhZVJL5kPKG6XlCGxrFYXooXh5daFXH42S7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+pWqe1D; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722283643; x=1753819643;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VtstHWeYePnlour2DE34TcD9zpx6jc0H7BoD063yGYg=;
  b=g+pWqe1DWAn5SjeLhQf1w3smDCPBJPWinVk1TJL1U9LiAfldY30fW29j
   0ojl078gsKQtFkx2dwbX2qZGx2Zh6Rqp2GCWaWe7B/TAvmNm1aNO72SvY
   OFiVTkrUc86swyy7wmHSojYFqkoKLqYV3XiBLSfThAcTvKhGvtqcMOcgb
   ayUYX8wylGQuvwHf2Ul0aqy16MZi6FExExYgBf7zqOdhpqUUybiJO7CQV
   /RejsvIsS/TeDsGzHIwMzmRUKdAYhpm/BGTh+CuQEbjQlMi8OxXKOMyn+
   fAdruUl+JOjomhuPlXGunsueYOzULgvqXMbwmlmN67rJW6LPtykekY8K3
   A==;
X-CSE-ConnectionGUID: DhMmuFRfRTudzgPk11z9EQ==
X-CSE-MsgGUID: h0dgKIrbRIyzZU2X0pYIRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23818491"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="23818491"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 13:07:22 -0700
X-CSE-ConnectionGUID: eu3DUqFvR7yzj/PeKsOq/A==
X-CSE-MsgGUID: I1DorhkPS6adYUyUlM2etw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54681276"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Jul 2024 13:07:23 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH net v2 0/8][pull request] ice: fix AF_XDP ZC timeout and concurrency issues
Date: Mon, 29 Jul 2024 13:07:06 -0700
Message-ID: <20240729200716.681496-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maciej Fijalkowski says:

Changes included in this patchset address an issue that customer has
been facing when AF_XDP ZC Tx sockets were used in combination with flow
control and regular Tx traffic.

After executing:
ethtool --set-priv-flags $dev link-down-on-close on
ethtool -A $dev rx on tx on

launching multiple ZC Tx sockets on $dev + pinging remote interface (so
that regular Tx traffic is present) and then going through down/up of
$dev, Tx timeout occurred and then most of the time ice driver was unable
to recover from that state.

These patches combined together solve the described above issue on
customer side. Main focus here is to forbid producing Tx descriptors when
either carrier is not yet initialized or process of bringing interface
down has already started.

v2:
* in patch 6, use a single READ_ONCE against xsk_pool within napi [Jakub]

v1: https://lore.kernel.org/netdev/20240708221416.625850-1-anthony.l.nguyen@intel.com/
---
Olek,
we decided not to check IFF_UP as you initially suggested. Reason is
that when link goes down netif_running() has broader scope than IFF_UP
being set as the former (the __LINK_STATE_START bit) is cleared earlier
in the core.

The following are changes since commit 039564d2fd37b122ec0d268e2ee6334e7169e225:
  Merge branch 'mptcp-endpoint-readd-fixes' into main
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Maciej Fijalkowski (7):
  ice: don't busy wait for Rx queue disable in ice_qp_dis()
  ice: replace synchronize_rcu with synchronize_net
  ice: modify error handling when setting XSK pool in ndo_bpf
  ice: toggle netif_carrier when setting up XSK pool
  ice: improve updating ice_{t,r}x_ring::xsk_pool
  ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
  ice: xsk: fix txq interrupt mapping

Michal Kubiak (1):
  ice: respect netif readiness in AF_XDP ZC related ndo's

 drivers/net/ethernet/intel/ice/ice.h      |  11 +-
 drivers/net/ethernet/intel/ice/ice_base.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c |  10 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 184 +++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |  14 +-
 6 files changed, 135 insertions(+), 90 deletions(-)

-- 
2.42.0


