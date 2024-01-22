Return-Path: <bpf+bounces-20041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733178375E8
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 23:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E25CB230D7
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41CD487AF;
	Mon, 22 Jan 2024 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGuf/RYV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5AF4878A;
	Mon, 22 Jan 2024 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961780; cv=none; b=iTjCKo9DjkKcdki7r82Ji9sO0GUbJJexhU2VhRVdZa5I27F6Rk/iEWT2ycCkQe73ZAQj7BXshyh8kwhVfP8eHxNaZUBb6PucZZuKDSKNAHB/deVpIJDUtTQGDW8xNxMpnN7aSbYMQkBxSl+NMnQ1gl83MtlcPDAp9OQZWDp0Inc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961780; c=relaxed/simple;
	bh=VHR9MavX+FfaIMqh+/3w74h7tG9QgHOB/7JBdInQVHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fep0czeP86nZU/f9+a5VvKKY2aGqzdhSfwchNEtMjroPuLQE5Eaj7GbqIBeu+ouv4VwE02/PQa9q+mYVrkVuNUwm0qlB0KqZQXjp6RFXKUnwzgyyERSLdSpaatrqDQv5bQ2bFgRkXZvkzAlQBhQMiG1ZaXiHXwKWKTAp7qQhLu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGuf/RYV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705961779; x=1737497779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VHR9MavX+FfaIMqh+/3w74h7tG9QgHOB/7JBdInQVHw=;
  b=TGuf/RYVL/ATyfUJyvcZpETcsOMHRWQW8e3ebzMKWt6RMDiRKsXpYjAG
   dVQgcg+jtOsS80cxdIgcyXbfZryDQYViHJ1pYuIsrWeny4H5KuRKXSwUT
   t5q7Oqvtw4Tu5D4/IhXc8Xlf6wK04yHnSHQVOr0to6NIV1uhZTPgCPdl2
   cPQ9nKrpPm9PM0+RBg6Wi7XM52gkIlsDU/WhcHbyQdafHBR3I5bMcMkFT
   qDPISpcx574KBx5CRyX6Il9EqCaIk51G7KHIElaFlpnBz+3n9+/wloRPk
   YMTtF57yPDc87bUiXxx0UliazQ/PRI3SGuDEoHVWXC2iAUjWZSYGKhAHS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="7995474"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="7995474"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:16:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1360451"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 14:16:15 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	martin.lau@linux.dev,
	tirthendu.sarkar@intel.com,
	john.fastabend@gmail.com,
	horms@kernel.org
Subject: [PATCH v5 bpf 00/11] net: bpf_xdp_adjust_tail() and Intel mbuf fixes
Date: Mon, 22 Jan 2024 23:15:59 +0100
Message-Id: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,

after a break followed by dealing with sickness, here is a v5 that makes
bpf_xdp_adjust_tail() actually usable for ZC drivers that support XDP
multi-buffer. Since v4 I tried also using bpf_xdp_adjust_tail() with
positive offset which exposed yet another issues, which can be observed
by increased commit count when compared to v3.

John, in the end I think we should remove handling
MEM_TYPE_XSK_BUFF_POOL from __xdp_return(), but it is out of the scope
for fixes set, IMHO.

Thanks,
Maciej

v5:
- pick correct version of patch 5 [Simon]
- elaborate a bit more on what patch 2 fixes

v4:
- do not clear frags flag when deleting tail; xsk_buff_pool now does
  that
- skip some NULL tests for xsk_buff_get_tail [Martin, John]
- address problems around registering xdp_rxq_info
- fix bpf_xdp_frags_increase_tail() for ZC mbuf

v3:
- add acks
- s/xsk_buff_tail_del/xsk_buff_del_tail
- address i40e as well (thanks Tirthendu)

v2:
- fix !CONFIG_XDP_SOCKETS builds
- add reviewed-by tag to patch 3


Maciej Fijalkowski (10):
  xsk: recycle buffer in case Rx queue was full
  xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags
  xsk: fix usage of multi-buffer BPF helpers for ZC XDP
  ice: work on pre-XDP prog frag count
  ice: remove redundant xdp_rxq_info registration
  intel: xsk: initialize skb_frag_t::bv_offset in ZC drivers
  ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue
  xdp: reflect tail increase for MEM_TYPE_XSK_BUFF_POOL
  i40e: set xdp_rxq_info::frag_size
  i40e: update xdp_rxq_info::frag_size for ZC enabled Rx queue

Tirthendu Sarkar (1):
  i40e: handle multi-buffer packets that are shrunk by xdp prog

 drivers/net/ethernet/intel/i40e/i40e_main.c   | 47 ++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 49 +++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |  7 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 19 ++++---
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 ++++++++----
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  4 +-
 include/net/xdp_sock_drv.h                    | 26 ++++++++++
 net/core/filter.c                             | 43 ++++++++++++----
 net/xdp/xsk.c                                 | 12 +++--
 net/xdp/xsk_buff_pool.c                       |  3 ++
 12 files changed, 167 insertions(+), 79 deletions(-)

-- 
2.34.1


