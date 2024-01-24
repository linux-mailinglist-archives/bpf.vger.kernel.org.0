Return-Path: <bpf+bounces-20261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63583B1FB
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8F51F22A50
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738A8131E27;
	Wed, 24 Jan 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSBdW1qu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455C77F36;
	Wed, 24 Jan 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123773; cv=none; b=KmpU0VzaOhqSL0FUrRCy7RCRqD8syfbuJi0MF/frqzIj45dJaSdErYw8clH+cZji9aSQdMDFqd2g8b3oPJvPzGEgSzB0ET+mZ5CYjS3BTj446coGiPMusRmZoOGVr2MdTCXyw4Ixv5tKzdSaYfZdwJrnQLFUaMjxSR3PwLuFJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123773; c=relaxed/simple;
	bh=m6U/0/1KJmUAWxkEnwjfTQGWq3gYu7kd0lNyKdS5oSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nTPrfSRUpJg9CFHBA0Uf5kl2ZDGNisvx1qR/8zzcEF4OWE2EJM2retR8nQw0JazxgyIZ3FlhedW+fTk7qRsVow2Zqdmiaz0RweiztdVomQGtQjWX82GNJkG4bkG1vGVzOBtkGXVw0ZgNs2oJOixwYnRmQcTyqhULuW5MRKP4hmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSBdW1qu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706123771; x=1737659771;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m6U/0/1KJmUAWxkEnwjfTQGWq3gYu7kd0lNyKdS5oSs=;
  b=SSBdW1qup1sDfiJanj+l6ybmUDGDTzHadF9bKA3qKBCowi+e7YO9khH2
   Xu7V/Yg8hMPXUEouU2WeOBAOmG8o0s/jbuoRbMtfsm4HWdJ6VaYfUYpBE
   tPjzAPKhgj87eAJZDtofY8BBLS6ysEZ1dd8v13s3NcUD2jQAezmWuRz9T
   dmRYfX+K09PNFlLxaicT45R8f0FQk1lI1jVaFE1RTVRdd9ZypjIkd6WAo
   hsgEDcNEvaQ2mXfuVHmKBRu4qWUxmJk5GZ9BAWWKEBiZlq7pG/CqMSPLY
   2OwvCcSpsOY59syc4OVnLdoVJEu5G8KCNVkBhtNGEDVq7Vc08RMAZwcfh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1822883"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1822883"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:16:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820553428"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820553428"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2024 11:16:06 -0800
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
	horms@kernel.org,
	kuba@kernel.org
Subject: [PATCH v6 bpf 00/11] net: bpf_xdp_adjust_tail() and Intel mbuf fixes
Date: Wed, 24 Jan 2024 20:15:51 +0100
Message-Id: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey,

after a break followed by dealing with sickness, here is a v6 that makes
bpf_xdp_adjust_tail() actually usable for ZC drivers that support XDP
multi-buffer. Since v4 I tried also using bpf_xdp_adjust_tail() with
positive offset which exposed yet another issues, which can be observed
by increased commit count when compared to v3.

John, in the end I think we should remove handling
MEM_TYPE_XSK_BUFF_POOL from __xdp_return(), but it is out of the scope
for fixes set, IMHO.

Thanks,
Maciej

v6:
- add acks [Magnus]
- fix spelling mistakes [Magnus]
- avoid touching xdp_buff in xp_alloc_{reused,new_from_fq}() [Magnus]
- s/shrink_data/bpf_xdp_shrink_data [Jakub]
- remove __shrink_data() [Jakub]
- check retvals from __xdp_rxq_info_reg() [Magnus]

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
 drivers/net/ethernet/intel/ice/ice_base.c     | 37 ++++++++------
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 19 ++++---
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 ++++++++----
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  4 +-
 include/net/xdp_sock_drv.h                    | 27 ++++++++++
 net/core/filter.c                             | 44 ++++++++++++++---
 net/xdp/xsk.c                                 | 12 +++--
 net/xdp/xsk_buff_pool.c                       |  1 +
 12 files changed, 187 insertions(+), 89 deletions(-)

-- 
2.34.1


