Return-Path: <bpf+bounces-38816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDF696A684
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BA7286032
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51D71917D8;
	Tue,  3 Sep 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDyVMY+u"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E118BBAD;
	Tue,  3 Sep 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388251; cv=none; b=m4DPgQb7sx+O+d9g8DudMit0DoHjVv971v+yj/0CQ5j5rTWRXyomE3eDNxiyCutaMJ4SV52fxPfZgRGtPRD6PBvhZC22vKdb/KoJX2MDgY4sZpxIbZ05p0/41T4D7THdaF56csfx8V6YgTffkeMHOkcj/GGM5lLMuhMe+JeRVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388251; c=relaxed/simple;
	bh=quS9VeWupp1GQi0efBikj9gy/ekY2XGsx7F4kOK5muE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQdrCcEaFByepg3KFNdbWW5EYa2vX2n7EUQ56pjHmwOBg8IIikzVW0/2VDnHAnk29BwiLyzJ6+g7gJWHjK0pDKYJrd7CRrISA1d6O9bL5J90WiHS4ULa18fQvEgSZNhRbhhN2x/92LWRMLa1aGG+uDFG6k1yAoYXgF92PfexY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDyVMY+u; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725388249; x=1756924249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=quS9VeWupp1GQi0efBikj9gy/ekY2XGsx7F4kOK5muE=;
  b=jDyVMY+ufVLhhP5Zuk7Mrvnq7UHSiYejy5Tl1uYgeuY96FX8+PnCWA9s
   JipVpBsPlK7BrF/YOll1q0Y2Nht/HcF55rpaLr9VA2/FLzWFBFHTuVQBZ
   jJKyZY0as3r8ZlSC7Xq9+9EtkUzDA7s76bp11/lL6/yQavrXmlZ9w6ZrB
   HbgCp1d332+Gabxd5HuLYfhklmNYG0EtDq8PB2EqekcxpFAzIb70x23D3
   cI6m1slYPyAuZE9F6Ar2s9SlVsMcW7IwAlu+C1CEGqZFOHhWep9im71sl
   ckVHjTrx9yJHvj6dkEwfE2LJ5DdkDOAWHQXyRFdyIfoV1rCpmRLeDPamd
   w==;
X-CSE-ConnectionGUID: dpl2SNMmQwSuBBU3Pe9ogA==
X-CSE-MsgGUID: MmqG5VZvQcOaDLZiakkqBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24146986"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24146986"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:30:48 -0700
X-CSE-ConnectionGUID: JR/UhkVNRS2GOAyf9Z6jsA==
X-CSE-MsgGUID: 395M0Ah5Qsufe7Q29iblig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="88250209"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2024 11:30:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	larysa.zaremba@intel.com,
	wojciech.drewek@intel.com,
	michal.kubiak@intel.com,
	jacob.e.keller@intel.com,
	amritha.nambiar@intel.com,
	przemyslaw.kitszel@intel.com,
	sridhar.samudrala@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH net 0/6][pull request] ice: fix synchronization between .ndo_bpf() and reset
Date: Tue,  3 Sep 2024 11:30:26 -0700
Message-ID: <20240903183034.3530411-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Larysa Zaremba says:

PF reset can be triggered asynchronously, by tx_timeout or by a user. With some
unfortunate timings both ice_vsi_rebuild() and .ndo_bpf will try to access and
modify XDP rings at the same time, causing system crash.

The first patch factors out rtnl-locked code from VSI rebuild code to avoid
deadlock. The following changes lock rebuild and .ndo_bpf() critical sections
with an internal mutex as well and provide complementary fixes.
---
IWL: https://lore.kernel.org/intel-wired-lan/20240823095933.17922-1-larysa.zaremba@intel.com/

The following are changes since commit cfd433cecef929b4d92685f570f1a480762ec260:
  Merge branch 'ptp-ocp-fix-serial-port-information-export'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

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
2.42.0


