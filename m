Return-Path: <bpf+bounces-47260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9419F6C86
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7FE16C23D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC441FA8DA;
	Wed, 18 Dec 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLSQNew4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D31F9F50;
	Wed, 18 Dec 2024 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543923; cv=none; b=rdh2q+fNtscZTxLeRfm9wlaPAQDWw8n8CFxgrUD9PSs+ZA5xeHhV8XqfIsyUwCWznDsODBHcwS2TrZgTlInrO4hDTkOqM7bZjMS9aCBACRN/A1wyYNAvxBVwqzZMP+az239I0QDZPp+IC/AZGWqHXvroQaxaee44r9HKRtJfXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543923; c=relaxed/simple;
	bh=+ATQ3fLYydshMThk1zPlL0WngjXRHdvU1A1dfJjAKVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dHnkIia3d2z6IO9U69gpNdtrSZRimLk6smAPT+Mg0e/DjC4fp4c9/j82ON/0i0vxYNdHe6g1qKGawl6KCchZcmQRTWPo7G1dJ2IKucgPcRpH+DsGC476y8vgImVRpZ2zSGqLNns3dtxpz2oKTp013WwiIJcC2CSUYzPb2J4nuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLSQNew4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734543922; x=1766079922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+ATQ3fLYydshMThk1zPlL0WngjXRHdvU1A1dfJjAKVw=;
  b=NLSQNew4K1SL6v4cG3jxPzjPgk9hR/FGngpRlbev9b9jyhY+zGe6DeTv
   Kj5h9508cBbfug58wfMW21lTbXtRQGqsbhbnqMit4uO2aOUhCd3rbfay5
   IqsvA4P4AFfjFymoxJEiLeV9z2pyKxUXQ7FzcVamYPnn+BXKt1iKzCVwQ
   6e6vhDwmhdVHMphxNJDZB/LgVKGD7mI8cX2f1I6yUMtkRVrGvfqXmBeC8
   5FavnIfIOq53KNW8/HEljbg9cYDW45yFryw6Ao0qeiZQy5e2RCYJcuPs6
   sjJcJ4rWx/teQYOeN3UdtCzfLnQWXqtIxtaFh3qDu29eMda6LaOBPZUNk
   w==;
X-CSE-ConnectionGUID: SiNQijJiTLyhHeKwxcm2ZA==
X-CSE-MsgGUID: RqptBb8FR8inRMfKFbwBBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22620945"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="22620945"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 09:45:21 -0800
X-CSE-ConnectionGUID: E4Awc4FzTTORLsCV1l54ww==
X-CSE-MsgGUID: nZFARySJTZa4OIkZPolMkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121192185"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 18 Dec 2024 09:45:17 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] xdp: a fistful of generic changes pt. III
Date: Wed, 18 Dec 2024 18:44:28 +0100
Message-ID: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

XDP for idpf is currently 5.(6) chapters:
* convert Rx to libeth;
* convert Tx and stats to libeth;
* generic XDP and XSk code changes;
* generic XDP and XSk code additions pt. 1;
* generic XDP and XSk code additions pt. 2 (you are here);
* actual XDP for idpf via new libeth_xdp;
* XSk for idpf (via ^).

Part III.3 does the following:
* adds generic functions to build skbs from xdp_buffs (regular and
  XSk) and attach frags to xdp_buffs (regular and XSk);
* adds helper to optimize XSk xmit in drivers;
* add generic loop unroll hint macros.

Everything is prereq for libeth_xdp, but will be useful standalone
as well: less code in drivers, faster XSk XDP_PASS, smaller object
code.

Alexander Lobakin (7):
  page_pool: add page_pool_dev_alloc_netmem()
  xdp: add generic xdp_buff_add_frag()
  xdp: add generic xdp_build_skb_from_buff()
  xsk: make xsk_buff_add_frag() really add the frag via
    __xdp_buff_add_frag()
  xsk: add generic XSk &xdp_buff -> skb conversion
  xsk: add helper to get &xdp_desc's DMA and meta pointer in one go
  unroll: add generic loop unroll helpers

 include/linux/skbuff.h                     |  16 +-
 include/linux/unroll.h                     |  44 +++++
 include/net/page_pool/helpers.h            |   9 ++
 include/net/xdp.h                          |  98 +++++++++++-
 include/net/xdp_sock_drv.h                 |  41 ++++-
 include/net/xsk_buff_pool.h                |   8 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c |  30 +---
 drivers/net/ethernet/intel/ice/ice_xsk.c   |  32 +---
 net/core/xdp.c                             | 178 +++++++++++++++++++++
 net/xdp/xsk_buff_pool.c                    |  40 +++++
 10 files changed, 431 insertions(+), 65 deletions(-)

---
Each patch except trivial 0001 was on the lists already.

Since the not applied part of Chapter III.2:
* rebase on top of Mina's netmem fixes;
* 0003: remove redundant double CONFIG_PAGE_POOL check (one inside
  and another one outside of skb_mark_for_recycle()) (Jakub);
* 0005: remove !CONFIG_PAGE_POOL code as unreachable (eBPF always
  selects it) (also Jakub);
* 0005: actually check the pfmemalloc flag of newly allocated frags;
* drop exporting static_key_{inc,dec}_cpuslocked() -- were used on
  slowpath in very unlikely case where saving a few cycles looked
  worse and less convienient than the "regular" way.
-- 
2.47.1


