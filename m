Return-Path: <bpf+bounces-19937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF083317B
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4681F2175D
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF7E5914A;
	Fri, 19 Jan 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCCiGFdl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439201E48E;
	Fri, 19 Jan 2024 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707056; cv=none; b=qXKDNpjlzH6qPItPdFbMnXA7HZ+UQI6FK81ijeSoBlR63cCFnqh/D/DL8bM85+ZR5M2hbjj8ElO5VbI4U74meLM7EH+AmViUeLauON13A2zyNZ/acwR6YtDtz3w2CFUpb0LJdKRh9fUPLe0q9cBpJcVFXdxFO4R0FGLEjqIDSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707056; c=relaxed/simple;
	bh=rzAoW+a+/BNoVTcy3pCJF5bnbiY67qtfHBrwcC2RdwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eaDZaKGmCaJmrvBGTVSGJVxH328lP40Hw2rpJBpGryEagki9tlrXvj86Q6YXIO/QTd7mH9zW2aK0cnE0FwN2JUsxso2D505S/f5sGHvo4etMT7ss1Np7N36e1Su3wYjSYQR3hdwetKFuhBltORi8zNgxnMEwH0B91okCskIUBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCCiGFdl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707054; x=1737243054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rzAoW+a+/BNoVTcy3pCJF5bnbiY67qtfHBrwcC2RdwM=;
  b=PCCiGFdlcuJsu7JFh49X6HHIwYCX1hw/TUF0FlVbzH8Ja0IF7PFmKojW
   U3JsqZg8XvDSSgKoykojyoooYU216HsgNlFOj/TvFmjJrP3r0k1/Vms46
   vQ+abrn+PUJcPdUDgCPUPCr3VUUKQw+NommGpHHx0OXbOa558cD3JFMN8
   rC/N++PKndyJaM6tvz/KewHn4EEo/eOw5rvJqeVT25J6EN5K6pp73cnC8
   Tw+5VpsAV0J54sQjXnngWJWFIYM2joajxZJNglZCE+PjiKnboPbNce6xl
   8Ikt5B4OyvvS5WUD4qJ9kqx3SJPIPxx5ojbKDWg6iizlbSpuWpnTaTczx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="771462"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="771462"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:30:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904277409"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="904277409"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2024 15:30:48 -0800
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
	john.fastabend@gmail.com
Subject: [PATCH v4 bpf 00/11] net: bpf_xdp_adjust_tail() and Intel mbuf fixes
Date: Sat, 20 Jan 2024 00:30:26 +0100
Message-Id: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,

after a break followed by dealing with sickness, here is a v4 that makes
bpf_xdp_adjust_tail() actually usable for ZC drivers that support XDP
multi-buffer. This time I tried also using bpf_xdp_adjust_tail() with
positive offset which exposed yet another issues, which can be observed
by increased commit count when compared to v3.

John, in the end I think we should remove handling
MEM_TYPE_XSK_BUFF_POOL from __xdp_return(), but it is out of the scope
for fixes set, IMHO.

Thanks,
Maciej

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

 drivers/net/ethernet/intel/i40e/i40e_main.c   | 47 +++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 51 +++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |  7 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 19 ++++---
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 +++++++----
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  4 +-
 include/net/xdp_sock_drv.h                    | 26 ++++++++++
 net/core/filter.c                             | 43 ++++++++++++----
 net/xdp/xsk.c                                 | 12 +++--
 net/xdp/xsk_buff_pool.c                       |  3 ++
 12 files changed, 168 insertions(+), 80 deletions(-)

-- 
2.34.1


