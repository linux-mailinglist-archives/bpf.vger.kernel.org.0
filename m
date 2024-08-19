Return-Path: <bpf+bounces-37488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A4E9567F0
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 12:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCA0280C92
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 10:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B938B1607A4;
	Mon, 19 Aug 2024 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6Gy4Nop"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B015FA75;
	Mon, 19 Aug 2024 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062468; cv=none; b=jPnJ103UWu4DvSGGly54ZZmhpt8G0xB7k3aH+dD6aSrPmtK8CqA2CPDqax5P0Vtn+SdG+rF+LLiCuPZcL+5KIxLTPqsGotrdqN7ou9zsLcf/zjdgsWT1+9yOosCsKKCe+qFIP4mlp3OonjHho7FXMFl2I6bII3zps/ElSAk3VYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062468; c=relaxed/simple;
	bh=s0zAxlyXNZ+O9S3b8lRDOQsTtc9BspZrt7J09VPJZ3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q37We68QmedgETpz6GZGHmuUUMorApvPkoiqZ/LGyHxy3jEjOcjr6VtGBPQgKXEMJkP/VtA1ujWaWg32HQapAY7815nE8/DQS8nWIO3mV0DvtvGB+dLDG7I0toLS2n6/iXicc1zBozTTvGJczeO1gym9GHXh5SJlr8/Jgqc7nK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6Gy4Nop; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724062467; x=1755598467;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s0zAxlyXNZ+O9S3b8lRDOQsTtc9BspZrt7J09VPJZ3k=;
  b=A6Gy4Nop+yv25BYKqXgs9UaMZu9sGiNu+TfHy4gP2MdCYj6CF2kN/EDK
   WCKM8L+C3nNsmtMWYDHSA1zKz9y2hLF/w8HzKEZ+Q4GcebcAJgToGDSQr
   YNPy+hLkkkd9cEz9eNWwOLiwKnOsyiJJ8AR9CBMMPtY7XXg/FcHi6F4fg
   smNJGgac3+nZ3AswT/BPEIL5IDL+3bgR/tmcOiXd1VRtQ/mX2m5RF9ODg
   yw+mupcMFMrACaUZlYudPTEVXEyf940i/vnhm/pqF7T++YoAcf398w4Dq
   VqMp11nb+NDgRaOcR5RITjhW3NKXTZua8PzZpJKfIJqmVt8AWbWlDQv+j
   Q==;
X-CSE-ConnectionGUID: 8GKVlGf6SAarZEjvKTJZSw==
X-CSE-MsgGUID: +u2vHC0KQnaVVvSVtE2TWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22443450"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22443450"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:14:27 -0700
X-CSE-ConnectionGUID: HoSDcKyeSpi9Ww5gdWiYMg==
X-CSE-MsgGUID: trlfEET5Sq2x8vkfSmN16A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="65000841"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 19 Aug 2024 03:14:19 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6EC1E135E8;
	Mon, 19 Aug 2024 11:14:17 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>
Subject: [PATCH iwl-net v3 0/6] ice: fix synchronization between .ndo_bpf() and reset
Date: Mon, 19 Aug 2024 12:05:37 +0200
Message-ID: <20240819100606.15383-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PF reset can be triggered asynchronously, by tx_timeout or by a user. With some
unfortunate timings both ice_vsi_rebuild() and .ndo_bpf will try to access and
modify XDP rings at the same time, causing system crash.

The first patch factors out rtnl-locked code from VSI rebuild code to avoid
deadlock. The following changes lock rebuild and .ndo_bpf() critical sections
with an internal mutex as well and provide complementary fixes.

v2: https://lore.kernel.org/netdev/20240724164840.2536605-1-larysa.zaremba@intel.com/
v2->v3:
* deconfig VSI when coalesce allocation fails in ice_vsi_rebuild (patch 2/6)
* rebase and resolve conflicts in patch 3 and 4
* add tags from v2

v1: https://lore.kernel.org/netdev/20240610153716.31493-1-larysa.zaremba@intel.com/
v1->v2:
* use mutex for locking
* redefine critical sections
* account for short time between rebuild and VSI being open
* add netif_queue_set_napi() patch, so ICE_RTNL_WAITS_FOR_RESET strategy can be
  dropped, no more rtnl-locked code in ice_vsi_rebuild()
* change the test case from waiting for tx_timeout to happen to actively firing
  resets through sysfs, this adds more minor fixes on top

Larysa Zaremba (6):
  ice: move netif_queue_set_napi to rtnl-protected sections
  ice: protect XDP configuration with a mutex
  ice: check for XDP rings instead of bpf program when unconfiguring
  ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset
  ice: remove ICE_CFG_BUSY locking from AF_XDP code
  ice: do not bring the VSI up, if it was down before the XDP setup

 drivers/net/ethernet/intel/ice/ice.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_base.c |  11 +-
 drivers/net/ethernet/intel/ice/ice_lib.c  | 179 ++++++++--------------
 drivers/net/ethernet/intel/ice/ice_lib.h  |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c |  47 ++++--
 drivers/net/ethernet/intel/ice/ice_xsk.c  |  18 +--
 6 files changed, 106 insertions(+), 161 deletions(-)

-- 
2.43.0


