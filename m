Return-Path: <bpf+bounces-72918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9323DC1D932
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C74584E3CA9
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D708831E11D;
	Wed, 29 Oct 2025 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5DUJrH9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77B31A7F3;
	Wed, 29 Oct 2025 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776010; cv=none; b=p8imCYCSfyhxLjYERswGV0kbNRUcXlXPcRh+0z+ZSIWH7YB9sbJMJH0vJ3V/QbgZL5QWH/JVBvTzP68ZAPSjXwMSLhxlIZG+NySavrK77IILOu2l+/JZNqiF6Jp6C5yWSlcb7+xuyEsGjHpLmnfTTS7kiQrNliOtCv4yvJQLvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776010; c=relaxed/simple;
	bh=yGfiM90QTa6QHeNtOlsT5jBmIWQ925bx5xk6uTgvzvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdViMuPgARwgI7Y46uUJy0Hxpk397iroHA65oeFyB09C0XZzeVjkRATkeDclRBOtQQCKGE7coqNc1Yn5ok7yw3YyUT3ez1KQe4MWBVnP18ogv05aJij4ZVB81SpaH6SEGAZ56cRSGE6VEX3oIWDgIFkb2O46d1eUaKy9n7oY9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5DUJrH9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761776008; x=1793312008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yGfiM90QTa6QHeNtOlsT5jBmIWQ925bx5xk6uTgvzvM=;
  b=e5DUJrH9GQ3MuJ2aPePv9u8kEosGbjkrv3hxuPf33jch3jJJAq6AFdwT
   Iw/Xxg6RCBPaAx3597i6fsZX0pdnr2Nu3VsFbdVBY3PMnY73YUkGZ0Ktr
   2zMXLU8lj77GQAwGcKftGtKZmEN9E2/QenVoPZIta8nJSHjxLMLCe8DgT
   /F9PniDcIo9UeRFtFOtrwrlmTcFsP370I3ouKkrrSQxdYIuDQsG21cLHt
   uiDB7m7iMwF0X4zq5nI1ZxEGo0veyik7js04ofneKhWdSPOafX5reRrj6
   viu1/vLnnypz/7JbX/NEY3UOjFMfSwZitq9GYCl0aD+HKmzO1omXgOtEo
   Q==;
X-CSE-ConnectionGUID: +NKcWmUET9CiSMUAfbHueQ==
X-CSE-MsgGUID: icVL4vefTzWTiiIxj7DM/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63820772"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="63820772"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:13:28 -0700
X-CSE-ConnectionGUID: iQq4gz1dSuWRYJL3A+wiHg==
X-CSE-MsgGUID: SMlPAqbKRtyZqzWppi01Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216643402"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 29 Oct 2025 15:13:25 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	kuba@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v5 bpf 2/2] veth: update mem type in xdp_buff
Date: Wed, 29 Oct 2025 23:13:15 +0100
Message-Id: <20251029221315.2694841-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When skb's headroom is not sufficient for XDP purposes,
skb_pp_cow_data() returns new skb with requested headroom space. This
skb was provided by page_pool.

For CONFIG_DEBUG_VM=y and XDP program that uses bpf_xdp_adjust_tail()
against a skb with frags, and mentioned helper consumed enough amount of
bytes that in turn released the page, following splat was observed:

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

Fix this by using new helper xdp_convert_skb_to_buff() that, besides
init/prepare xdp_buff, will check if page used for linear part of
xdp_buff comes from page_pool. We assume that linear data and frags will
have same memory provider as currently XDP API does not provide us a way
to distinguish it (the mem model is registered for *whole* Rx queue and
here we speak about single buffer granularity).

Before releasing xdp_buff out of veth via XDP_{TX,REDIRECT}, mem type on
xdp_rxq associated with xdp_buff is restored to its original model. We
need to respect previous setting at least until buff is converted to
frame, as frame carries the mem_type. Add a page_pool variant of
veth_xdp_get() so that we avoid refcount underflow when draining page
frag.

Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/veth.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3046142cb8e..187f30e2cb4b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -733,7 +733,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 	}
 }
 
-static void veth_xdp_get(struct xdp_buff *xdp)
+static void veth_xdp_get_shared(struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 	int i;
@@ -746,12 +746,33 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 		__skb_frag_ref(&sinfo->frags[i]);
 }
 
+static void veth_xdp_get_pp(struct xdp_buff *xdp)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i;
+
+	page_pool_ref_page(virt_to_page(xdp->data));
+	if (likely(!xdp_buff_has_frags(xdp)))
+		return;
+
+	for (i = 0; i < sinfo->nr_frags; i++) {
+		skb_frag_t *frag = &sinfo->frags[i];
+
+		page_pool_ref_page(netmem_to_page(frag->netmem));
+	}
+}
+
+static void veth_xdp_get(struct xdp_buff *xdp)
+{
+	xdp->rxq->mem.type == MEM_TYPE_PAGE_POOL ?
+		veth_xdp_get_pp(xdp) : veth_xdp_get_shared(xdp);
+}
+
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 					struct xdp_buff *xdp,
 					struct sk_buff **pskb)
 {
 	struct sk_buff *skb = *pskb;
-	u32 frame_sz;
 
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
 	    skb_shinfo(skb)->nr_frags ||
@@ -762,19 +783,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 		skb = *pskb;
 	}
 
-	/* SKB "head" area always have tailroom for skb_shared_info */
-	frame_sz = skb_end_pointer(skb) - skb->head;
-	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
-	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
-			 skb_headlen(skb), true);
-
-	if (skb_is_nonlinear(skb)) {
-		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
-		xdp_buff_set_frags_flag(xdp);
-	} else {
-		xdp_buff_clear_frags_flag(xdp);
-	}
+	xdp_convert_skb_to_buff(skb, xdp, &rq->xdp_rxq);
 	*pskb = skb;
 
 	return 0;
@@ -822,24 +831,24 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	case XDP_TX:
 		veth_xdp_get(xdp);
 		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
 		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 			trace_xdp_exception(rq->dev, xdp_prog, act);
 			stats->rx_drops++;
 			goto err_xdp;
 		}
 		stats->xdp_tx++;
+		rq->xdp_rxq.mem = rq->xdp_mem;
 		rcu_read_unlock();
 		goto xdp_xmit;
 	case XDP_REDIRECT:
 		veth_xdp_get(xdp);
 		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
 		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 			stats->rx_drops++;
 			goto err_xdp;
 		}
 		stats->xdp_redirect++;
+		rq->xdp_rxq.mem = rq->xdp_mem;
 		rcu_read_unlock();
 		goto xdp_xmit;
 	default:
-- 
2.43.0


