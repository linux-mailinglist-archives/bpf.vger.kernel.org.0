Return-Path: <bpf+bounces-35530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C493B55D
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162511C239D2
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4F715EFC0;
	Wed, 24 Jul 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1ZREMuV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187B15EFA0;
	Wed, 24 Jul 2024 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840311; cv=none; b=Ss7Wjfg3fSzGPbtuIoc8gJUh2yNhWJoxrUJOak0+F8Pb+y5a/rQLpZGo8d1DOsWitm2eAO8C4mNFAVhyiZQ/Dmx1EM+KQZ1CmM4DX9DcYxEVp1tUEK2kaBb9xlNA3q89C/k2T9/zkRy+PjKUB0bGchOi5IhFj/IfQzbgNAs1KSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840311; c=relaxed/simple;
	bh=rsVz+LhgSFt8cu91zlcAvS+TOmocgJJ/c2yTNsJ47XE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bkl0uxS+BnYBdYgoX6mHzRMaLz3jF0nmid+sgL50+TJadS7j6FHgwU/8H5OtD2C9grqLezXnq5E9iSXjq9qcoiN9K3MicQ/Vpgg0VDV/QafSvcNYl7reGXklm19Sbpxua7nBZJazSkNLWBjRCgBCgkEnn+tJvQzheTJhrL2uViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1ZREMuV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721840310; x=1753376310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rsVz+LhgSFt8cu91zlcAvS+TOmocgJJ/c2yTNsJ47XE=;
  b=b1ZREMuVzXu3NQ5GHmdwNF5LKx53BgShYqr98b1BgPiL5FhETDXuNSy8
   yYF47CYcuojtuUIpQbSeF5DHfJFghls4QPaM8deHyXllPGWnapAcBRvqO
   Rqin2sbEJJLrCzHW8IVRnUC7K43EyxPfq/cQPN+9B1484PEDj2hznd0fZ
   jnQl7Svgoi0DUf5XrfwMRiu4D3p+MaoSsJ0p+bAjLdZt692py8byoSkU9
   J88WOEU8FNcfdjT16rNhGyhXqifNxKMLcuxth+vuR+VatO/NecG7Q4Wi1
   uVSnCritloFPxt0Y+qkwvPg3B5emsGnWbRrXiQRkKeZHCHrD4ht5gV/Sh
   Q==;
X-CSE-ConnectionGUID: kI26JWEoQyeI0AdTEolrvg==
X-CSE-MsgGUID: 91CU5LCoRs6fmaEwnDNkYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30679727"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30679727"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 09:58:29 -0700
X-CSE-ConnectionGUID: JaAMf6SKT36fJrtSfnXnFQ==
X-CSE-MsgGUID: M9OmluhuRcSSUQtvTT9B2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="56960617"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jul 2024 09:58:25 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3B34B28785;
	Wed, 24 Jul 2024 17:58:23 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
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
Subject: [PATCH iwl-net v2 0/6] ice: fix synchronization between .ndo_bpf() and reset
Date: Wed, 24 Jul 2024 18:48:31 +0200
Message-ID: <20240724164840.2536605-1-larysa.zaremba@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_lib.c  | 171 +++++++---------------
 drivers/net/ethernet/intel/ice/ice_lib.h  |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c |  47 ++++--
 drivers/net/ethernet/intel/ice/ice_xsk.c  |  18 +--
 6 files changed, 102 insertions(+), 157 deletions(-)

-- 
2.43.0


