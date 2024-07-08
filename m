Return-Path: <bpf+bounces-34148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17FA92ABD2
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D850D1C22058
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB214F13A;
	Mon,  8 Jul 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ewu+mo5p"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB7A5674E;
	Mon,  8 Jul 2024 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476870; cv=none; b=oiYmzcTgJ3Mtmjf/+a5m2OPdgWPHO57uNNK8LzDY/A6629gM4lkaaJjdTWwfv5osvWxE6ciFo4BWt0RGSfqvmGjXDdUk8t/FVfuU8f/B6eb4mZRzM13BODIxMvXy2GRF51s2qtSfiXYuL9vHreR3NlzdZEml5bOVgrEscBKuFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476870; c=relaxed/simple;
	bh=oiEB/6MtUyIy+6ryOm05TPHIGQ5owj8/lPH5aCdN+WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SgF2TR9nqZCU3L5C5tvODtO4C360Ow1Uy3igOqD5MQMNNX5kv614dfwwS1lH7J4XrxUtaa7ZUP6YLKnvxBQu0ssF4NoauJZyofWkubFzw710vQCShqtObCtdA39wmn+rziFeA3a3mfRY+wwg4qlrDFjAfWJMlkm04Wbvtb2X8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ewu+mo5p; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720476869; x=1752012869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oiEB/6MtUyIy+6ryOm05TPHIGQ5owj8/lPH5aCdN+WM=;
  b=Ewu+mo5pC6tzYhxwxatnli7X953B8v/P/gpi1ptXLL7rl2Nh1Gt0fK4D
   HLw3UQx3/lt0HVCDcRj7wMHpcjHFCL0I9x9jVGfYpNXFs96z9aqA3qlr3
   B8wM+sTEZOTQBbKtuVYQe0TcDa83AhKmzrkhdQdYBR0hRKcxkP+WqN2fN
   ebTK8xKJw9xesZPoc1Psw+/k/7khO0UZsYsXb7cUf/p2eLTzPFNtjmfna
   4v9PCm95y+1iJFUij8w4uIkAr97PYxW5VwyHE0u1aR/2Lf2FaZeSsFtXu
   oLD7G+cYLtAEsdxLB+AIir9o1R7uz3dKIPrJ2gSu+AnaBs66ct/eoZZjt
   Q==;
X-CSE-ConnectionGUID: J24Z9SSXRm6s7HL+00KD5A==
X-CSE-MsgGUID: BJKkhzXaRzSs6Obxze6yfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17340091"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17340091"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 15:14:28 -0700
X-CSE-ConnectionGUID: dZlV96GPTx6o+Go6G6StAw==
X-CSE-MsgGUID: jAWNYe/9Qg25S+KIm15g4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52237705"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 08 Jul 2024 15:14:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	shannon.nelson@amd.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH net 0/8][pull request] ice: fix AF_XDP ZC timeout and concurrency issues
Date: Mon,  8 Jul 2024 15:14:06 -0700
Message-ID: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
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
$dev, Tx timeout occured and then most of the time ice driver was unable
to recover from that state.

These patches combined together solve the described above issue on
customer side. Main focus here is to forbid producing Tx descriptors
when either carrier is not yet initialized or process of bringing
interface down has already started.
---
Olek,
we decided not to check IFF_UP as you initially suggested. Reason is
that when link goes down netif_running() has broader scope than IFF_UP
being set as the former (the __LINK_STATE_START bit) is cleared earlier
in the core.

The following are changes since commit 83c36e7cfd74e41a5c145640dba581b38f12aa15:
  docs: networking: devlink: capitalise length value
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Maciej Fijalkowski (7):
  ice: don't busy wait for Rx queue disable in ice_qp_dis()
  ice: replace synchronize_rcu with synchronize_net
  ice: modify error handling when setting XSK pool in ndo_bpf
  ice: toggle netif_carrier when setting up XSK pool
  ice: improve updating ice_{t, r}x_ring::xsk_pool
  ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
  ice: xsk: fix txq interrupt mapping

Michal Kubiak (1):
  ice: respect netif readiness in AF_XDP ZC related ndo's

 drivers/net/ethernet/intel/ice/ice.h      |  11 +-
 drivers/net/ethernet/intel/ice/ice_base.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c |   6 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 159 +++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |   4 +-
 6 files changed, 109 insertions(+), 77 deletions(-)

-- 
2.41.0


