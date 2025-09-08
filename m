Return-Path: <bpf+bounces-67784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A0BB49A6E
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4671BC52A7
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A6A2D5C6C;
	Mon,  8 Sep 2025 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIxIwS1P"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC22698A2;
	Mon,  8 Sep 2025 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361491; cv=none; b=E/cIPw4IAZJvmnrse6Eky2WLqEZAyJSSSBHDqXX72Bb8p4UtsJFBmwvljKs6uMP2RocSf6WLDDSUdICkV4ZnqbsMxQWQNTFIWjjTwgRZF9LXyEI2H7t5kZhyaWPS4xMawXit4uAlz//GhJMCPWg9VsSrzwuXrwlQXclTHi4Mt7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361491; c=relaxed/simple;
	bh=tH1ImA5bTuWqG9h2H7j9iN13xvN2sIiDfZRqSpLr58A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ENgEr9BAPiBvD8vkYjp0dLbCmmQAr35AYd54D/Lc+t6tTzqVKXcXtSgYsQkUj4qEAiLdn1hfssprxL97lmRpz4ES5JtoeiAfXEu/6nRAchehJElTeMBrk9AvmxCVwtBHOBC2EthiEVJjdMBptfBhC5d+Wrw/ISsUTj/fD6LDpEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIxIwS1P; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757361491; x=1788897491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tH1ImA5bTuWqG9h2H7j9iN13xvN2sIiDfZRqSpLr58A=;
  b=FIxIwS1PMuBC7ZW2pbG+/8CnlOKZiYs5DI5Tcz8OreFEfGtwfBZ89kYZ
   ctPFegwiVd30xgH4nfvjA5T2AQjqJaQznpbXak56WV5c+3Jb3Dyj/KoMh
   m1Wakx1aFDTv62xpal+8x78xV3nS3whd54oYmtIMievTBWcBggpr7Q73B
   ChAmCifpaFbF1yYIWFxKflodFD9VTmd/KoR6PNdLBTQIccSB0toRT4/KH
   6en1CmKvO6AP7bQ7g42l+UYw8HS2IxcfXjZ/W5ORKP5FjGRtvwPa+sRZK
   qKCJNwTutcZJEo/tQIcxovtUeiG65EfsuogVV60SLd2d216q0a37ucvNz
   g==;
X-CSE-ConnectionGUID: V1Q2Uw+zTCSdcqVCLkywyQ==
X-CSE-MsgGUID: 62l0vzNSRbKmHIooALxzlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77088868"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="77088868"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 12:58:10 -0700
X-CSE-ConnectionGUID: ac0PcofkSkm6c/VhFFd1+g==
X-CSE-MsgGUID: K7/+LvdpQ9Ki9FW+pUkL1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="177189709"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2025 12:58:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	przemyslaw.kitszel@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	sdf@fomichev.me,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next 00/13][pull request] idpf: add XDP support
Date: Mon,  8 Sep 2025 12:57:30 -0700
Message-ID: <20250908195748.1707057-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexander Lobakin says:

Add XDP support (w/o XSk for now) to the idpf driver using the libeth_xdp
sublib. All possible verdicts, .ndo_xdp_xmit(), multi-buffer etc. are here.
In general, nothing outstanding comparing to ice, except performance --
let's say, up to 2x for .ndo_xdp_xmit() on certain platforms and
scenarios.
idpf doesn't support VLAN Rx offload, so only the hash hint is
available for now.

Patches 1-7 are prereqs, without which XDP would either not work at all or
work slower/worse/...
---
IWL: https://lore.kernel.org/intel-wired-lan/20250826155507.2138401-1-aleksander.lobakin@intel.com/

The following are changes since commit c6142e1913de563ab772f7b0e4ae78d6de9cc5b1:
  Merge branch '10g-qxgmii-for-aqr412c-felix-dsa-and-lynx-pcs-driver'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Alexander Lobakin (9):
  xdp, libeth: make the xdp_init_buff() micro-optimization generic
  idpf: fix Rx descriptor ready check barrier in splitq
  idpf: use a saner limit for default number of queues to allocate
  idpf: link NAPIs to queues
  idpf: add support for nointerrupt queues
  idpf: use generic functions to build xdp_buff and skb
  idpf: add support for XDP on Rx
  idpf: add support for .ndo_xdp_xmit()
  idpf: add XDP RSS hash hint

Michal Kubiak (4):
  idpf: add 4-byte completion descriptor definition
  idpf: remove SW marker handling from NAPI
  idpf: prepare structures to support XDP
  idpf: implement XDP_SETUP_PROG in ndo_bpf for splitq

 drivers/net/ethernet/intel/idpf/Kconfig       |   2 +-
 drivers/net/ethernet/intel/idpf/Makefile      |   2 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  31 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  11 +-
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  67 ++-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 110 ++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 424 ++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 140 ++++--
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  11 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 173 ++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   1 -
 drivers/net/ethernet/intel/idpf/xdp.c         | 454 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/xdp.h         | 172 +++++++
 include/net/libeth/xdp.h                      |  11 +-
 include/net/xdp.h                             |  28 +-
 17 files changed, 1217 insertions(+), 427 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.h

-- 
2.47.1


