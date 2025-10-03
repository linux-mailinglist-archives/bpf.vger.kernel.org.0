Return-Path: <bpf+bounces-70300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 893E8BB71C6
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 16:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18DB44ED46D
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082631FDE39;
	Fri,  3 Oct 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmDPOsbN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F071F8ACA;
	Fri,  3 Oct 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500187; cv=none; b=dbFbLAL5ue7npSh3DMdFHDm7sszHfIro5ZcwLvOKqFJ5tD02BIHzfKz7Rr954yseN+9BbLDkUE6A0/EQcwSrdN7ivz5ND0WIfqTypywdSGmQyroWy648Q0IQGQfOwaKQ3gMnS6FkmMDC+eGss95BRANmc3VaVS3kGwNx0Q5wIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500187; c=relaxed/simple;
	bh=eqJWymf6BKvUMuphEGUgcMTaSTyldrF7JMSr19bWKtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t8lk1UjVXlhWj5aKEdJwJYZKqLoyn/DCGOYcQ25Y5saUyFfIG1d26jZUkwXKiNMVD50+8qSDMyFztSSPWnwiytVSpLkd1h/onrNTVii/cn5WZLaITnlOyXDPIMu7voNacdDJoLewHHLBEQRzHQMUqcPV3WFalsgqaDsZMx17sRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmDPOsbN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759500186; x=1791036186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eqJWymf6BKvUMuphEGUgcMTaSTyldrF7JMSr19bWKtQ=;
  b=CmDPOsbN/fsT8Ifxr6LdDpfrXMsYNwEP8MGBuHHzZB3U3y4X6KNMA797
   eufQtNDkAd86IyaqVkRk2G3YPvugiROp8mWqe594SXIpooeKIdwPmEFga
   G4D/5WHm6vK/7gOlcfP2WhSMmHjlmy0amElAmeH3k10jY36Cbv4PXjeeO
   kCzX/aFpgseQc5AVjvVns2bcocQTPyEAk15230FLDYjGF4AgaYectgBdi
   EZwCBDbQShDrwFm0Gnh37V2sMVmkZ0Hbb9EfseP+fyQKydOq5nyBjjn7y
   rGDXkl1uazA6ueDW4WgYG8FErNFG1AcJDJU3dRY79/mVoBFDO51ti6tU2
   w==;
X-CSE-ConnectionGUID: zBfmBj5MTfq6aLokScAFSg==
X-CSE-MsgGUID: rcIFgfFiRMijVZRVUe8IDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="73210312"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="73210312"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 07:03:06 -0700
X-CSE-ConnectionGUID: ZYtXLopnRpeKZtR8oPiFlA==
X-CSE-MsgGUID: otEboiR7Qai+DeFUeQz59Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="183580155"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa004.jf.intel.com with ESMTP; 03 Oct 2025 07:03:03 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	andrii@kernel.org,
	stfomichev@gmail.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf 2/2] veth: update mem type in xdp_buff
Date: Fri,  3 Oct 2025 16:02:43 +0200
Message-Id: <20251003140243.2534865-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Veth calls skb_pp_cow_data() which makes the underlying memory to
originate from system page_pool. For CONFIG_DEBUG_VM=y and XDP program
that uses bpf_xdp_adjust_tail(), following splat was observed:

[   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
[   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11c98b
[   32.210084] flags: 0x1fffe0000000000(node=0|zone=1|lastcpupid=0x7fff)
[   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000 0000000000000000
[   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
[   32.220900] page dumped because: page_pool leak
[   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
[   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G O        6.17.0-rc5-gfec474d29325 #6969 PREEMPT
[   32.224638] Tainted: [O]=OOT_MODULE
[   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   32.224641] Call Trace:
[   32.224644]  <IRQ>
[   32.224646]  dump_stack_lvl+0x4b/0x70
[   32.224653]  bad_page.cold+0xbd/0xe0
[   32.224657]  __free_frozen_pages+0x838/0x10b0
[   32.224660]  ? skb_pp_cow_data+0x782/0xc30
[   32.224665]  bpf_xdp_shrink_data+0x221/0x530
[   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
[   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
[   32.224673]  ? xsk_destruct_skb+0x321/0x800
[   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
[   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
[   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
[   32.224688]  ? veth_set_channels+0x920/0x920
[   32.224691]  ? get_stack_info+0x2f/0x80
[   32.224693]  ? unwind_next_frame+0x3af/0x1df0
[   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
[   32.224700]  ? common_startup_64+0x13e/0x148
[   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
[   32.224706]  ? stack_trace_save+0x84/0xa0
[   32.224709]  ? stack_depot_save_flags+0x28/0x820
[   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
[   32.224716]  ? timerqueue_add+0x217/0x320
[   32.224719]  veth_poll+0x115/0x5e0
[   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
[   32.224726]  ? update_load_avg+0x1cb/0x12d0
[   32.224730]  ? update_cfs_group+0x121/0x2c0
[   32.224733]  __napi_poll+0xa0/0x420
[   32.224736]  net_rx_action+0x901/0xe90
[   32.224740]  ? run_backlog_napi+0x50/0x50
[   32.224743]  ? clockevents_program_event+0x1cc/0x280
[   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
[   32.224749]  handle_softirqs+0x151/0x430
[   32.224752]  do_softirq+0x3f/0x60
[   32.224755]  </IRQ>

It's because xdp_rxq with mem model set to MEM_TYPE_PAGE_SHARED was used
when initializing xdp_buff.

Fix this by using new helper xdp_update_mem_type() that will check if
page used for linear part of xdp_buff comes from page_pool. We assume
that linear data and frags will have same memory provider as currently
XDP API does not provide us a way to distinguish it (the mem model is
registered for *whole* Rx queue and here we speak about single buffer
granularity).

Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/veth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3046142cb8e..2ccc40e57d12 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -814,6 +814,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	orig_data = xdp->data;
 	orig_data_end = xdp->data_end;
 
+	xdp_update_mem_type(xdp);
+
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	switch (act) {
-- 
2.43.0


