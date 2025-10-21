Return-Path: <bpf+bounces-71581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A795BF7420
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C338C5067EC
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA5342CB8;
	Tue, 21 Oct 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GlnTlnj0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sMo0E4T+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0hPcoWu6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tec1mRF4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C534216B
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059245; cv=none; b=BUaHxn7r5DzMyg4eXiFVy63AGBztQNGVc5wZCEKeBOs2sE907KWOK2RRdQMDCOlH+WQSOeyG85TgTOlV6N4xX7/NcVK8/qPSftM1FbVY+abMz9Y7Y/dQLjT79R7UCYyY8QROMQ+jOsWOvr1YhnyN70OHltaYyiYvIFdQIT94oRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059245; c=relaxed/simple;
	bh=hixvYbrC0kxLMAUZVabKLa+06sPY4gK9W7EK7YKFeoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLJksu43zDu1CBavDc9tK2RDuKZzs9Umkov8Q1bxjFS3khvoxn0AlQE4abxs0WaeLMwe0eQPvk/KC7+CUhkvSZP6DHi67EmmTU1/EKT5ZsDG0ZYBzzavG8iHDh34EUsA6C3DoMJ7vmDXhALjTRK1Cy1OkcoWrUCnpMA/jY6d+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GlnTlnj0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sMo0E4T+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0hPcoWu6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tec1mRF4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D82B81F38D;
	Tue, 21 Oct 2025 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761059236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZFLuloM4HcoGuPMqKzXBmieGYZFizjS9WkGw+2k5t9o=;
	b=GlnTlnj007QOycU4Nm5dJ22ZkfbWA6EJbunDOBuVBX4Okk+W1G/zweD2Kxyvkf0mnZ7ZNo
	1UbtYmqsonEA48Ftd2saM2ewlGAqiBZi1QaxieSFvWveFgN2P1NJGW8NOy2FPqPgXS+fRE
	a7B68cHgzoq4g78wlv5fcnVlrligXsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761059236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZFLuloM4HcoGuPMqKzXBmieGYZFizjS9WkGw+2k5t9o=;
	b=sMo0E4T+ZgllN3ijUu9UNgp1ICrUIHKTzt4ubj2wfksA/5OWGn0hpC9d7NVC7PttYIdWe6
	A+xVsb9IFg9G7EAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761059231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZFLuloM4HcoGuPMqKzXBmieGYZFizjS9WkGw+2k5t9o=;
	b=0hPcoWu6b3vbV7/rzr/ziX/T3df+/+pysf1nfRx65FWa2GM2zWNK9cBKpvfSvlkeE4wLl4
	t0ftKVW7T3d88rFRbwkLURqrO9rXPuOq35ZKgpRCGR0jcf4/2/IZTzrQloMqa9AoovhfpJ
	DRu0M6AW1+9EQUnOo+pctiKSoHg08l8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761059231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZFLuloM4HcoGuPMqKzXBmieGYZFizjS9WkGw+2k5t9o=;
	b=Tec1mRF4jnKZgFwklkiqtjlcUSVJ96YlZDAFwlWTPMMtGzSHi/kNv7lvQZYK8aDY+3mxzt
	LsmhNnfHzzdXncCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57EE8139D2;
	Tue, 21 Oct 2025 15:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JxPCEp+h92igFQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 21 Oct 2025 15:07:11 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: csmate@nop.hu,
	kerneljasonxing@gmail.com,
	maciej.fijalkowski@intel.com,
	bjorn@kernel.org,
	sdf@fomichev.me,
	jonathan.lemon@gmail.com,
	bpf@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net] xsk: avoid data corruption on cq descriptor number
Date: Tue, 21 Oct 2025 17:06:56 +0200
Message-ID: <20251021150656.6704-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nop.hu,gmail.com,intel.com,kernel.org,fomichev.me,vger.kernel.org,suse.de];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30

Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
production"), the descriptor number is store in skb control block and
xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
pool's completion queue.

skb control block shouldn't be used for this purpose as after transmit
xsk doesn't have control over it and other subsystems could use it. This
leads to the following kernel panic due to a NULL pointer dereference.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
 RIP: 0010:xsk_destruct_skb+0xd0/0x180
 [...]
 Call Trace:
  <IRQ>
  ? napi_complete_done+0x7a/0x1a0
  ip_rcv_core+0x1bb/0x340
  ip_rcv+0x30/0x1f0
  __netif_receive_skb_one_core+0x85/0xa0
  process_backlog+0x87/0x130
  __napi_poll+0x28/0x180
  net_rx_action+0x339/0x420
  handle_softirqs+0xdc/0x320
  ? handle_edge_irq+0x90/0x1e0
  do_softirq.part.0+0x3b/0x60
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x60/0x70
  __dev_direct_xmit+0x14e/0x1f0
  __xsk_generic_xmit+0x482/0xb70
  ? __remove_hrtimer+0x41/0xa0
  ? __xsk_generic_xmit+0x51/0xb70
  ? _raw_spin_unlock_irqrestore+0xe/0x40
  xsk_sendmsg+0xda/0x1c0
  __sys_sendto+0x1ee/0x200
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x84/0x2f0
  ? __pfx_pollwake+0x10/0x10
  ? __rseq_handle_notify_resume+0xad/0x4c0
  ? restore_fpregs_from_fpstate+0x3c/0x90
  ? switch_fpu_return+0x5b/0xe0
  ? do_syscall_64+0x204/0x2f0
  ? do_syscall_64+0x204/0x2f0
  ? do_syscall_64+0x204/0x2f0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>
 [...]
 Kernel panic - not syncing: Fatal exception in interrupt
 Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

The approach proposed store the first address also in the xsk_addr_node
along with the number of descriptors. The head xsk_addr_node is
referenced by skb_shinfo(skb)->destructor_arg. The rest of the fragments
store the address on the list.

This is less efficient as the kmem_cache must be initialized even if a
single fragment is received and also 4 bytes are wasted when storing
each address.

Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: Please notice I am not an XDP expert so I cannot tell if this
would cause a performance regression, advice is welcomed.
---
 net/xdp/xsk.c | 57 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..203934aeade6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -37,18 +37,14 @@
 #define MAX_PER_SOCKET_BUDGET 32
 
 struct xsk_addr_node {
+	u32 num_descs;
 	u64 addr;
 	struct list_head addr_node;
 };
 
-struct xsk_addr_head {
-	u32 num_descs;
-	struct list_head addrs_list;
-};
-
 static struct kmem_cache *xsk_tx_generic_cache;
 
-#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
+#define XSK_TX_HEAD(skb) ((struct xsk_addr_node *)((skb_shinfo(skb)->destructor_arg)))
 
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
@@ -569,12 +565,11 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 	spin_lock_irqsave(&pool->cq_lock, flags);
 	idx = xskq_get_prod(pool->cq);
 
-	xskq_prod_write_addr(pool->cq, idx,
-			     (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
+	xskq_prod_write_addr(pool->cq, idx, XSK_TX_HEAD(skb)->addr);
 	descs_processed++;
 
-	if (unlikely(XSKCB(skb)->num_descs > 1)) {
-		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
+	if (unlikely(XSK_TX_HEAD(skb)->num_descs > 1)) {
+		list_for_each_entry_safe(pos, tmp, &XSK_TX_HEAD(skb)->addr_node, addr_node) {
 			xskq_prod_write_addr(pool->cq, idx + descs_processed,
 					     pos->addr);
 			descs_processed++;
@@ -582,6 +577,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 			kmem_cache_free(xsk_tx_generic_cache, pos);
 		}
 	}
+	kmem_cache_free(xsk_tx_generic_cache, XSK_TX_HEAD(skb));
 	xskq_prod_submit_n(pool->cq, descs_processed);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
@@ -597,12 +593,12 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
 {
-	XSKCB(skb)->num_descs++;
+	XSK_TX_HEAD(skb)->num_descs++;
 }
 
 static u32 xsk_get_num_desc(struct sk_buff *skb)
 {
-	return XSKCB(skb)->num_descs;
+	return XSK_TX_HEAD(skb)->num_descs;
 }
 
 static void xsk_destruct_skb(struct sk_buff *skb)
@@ -619,16 +615,16 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 }
 
 static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
-			      u64 addr)
+			      struct xsk_addr_node *head, u64 addr)
 {
-	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
-	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
+	INIT_LIST_HEAD(&head->addr_node);
+	head->addr = addr;
+	head->num_descs = 0;
 	skb->dev = xs->dev;
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
-	XSKCB(skb)->num_descs = 0;
 	skb->destructor = xsk_destruct_skb;
-	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
+	skb_shinfo(skb)->destructor_arg = (void *)head;
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
@@ -638,11 +634,12 @@ static void xsk_consume_skb(struct sk_buff *skb)
 	struct xsk_addr_node *pos, *tmp;
 
 	if (unlikely(num_descs > 1)) {
-		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
+		list_for_each_entry_safe(pos, tmp, &XSK_TX_HEAD(skb)->addr_node, addr_node) {
 			list_del(&pos->addr_node);
 			kmem_cache_free(xsk_tx_generic_cache, pos);
 		}
 	}
+	kmem_cache_free(xsk_tx_generic_cache, XSK_TX_HEAD(skb));
 
 	skb->destructor = sock_wfree;
 	xsk_cq_cancel_locked(xs->pool, num_descs);
@@ -712,6 +709,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	buffer = xsk_buff_raw_get_data(pool, addr);
 
 	if (!skb) {
+		struct xsk_addr_node *head_addr;
+
 		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
 
 		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
@@ -720,7 +719,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 		skb_reserve(skb, hr);
 
-		xsk_skb_init_misc(skb, xs, desc->addr);
+		head_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+		if (!head_addr)
+			return ERR_PTR(-ENOMEM);
+
+		xsk_skb_init_misc(skb, xs, head_addr, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
@@ -736,7 +739,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		 * would be dropped, which implies freeing all list elements
 		 */
 		xsk_addr->addr = desc->addr;
-		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
+		list_add_tail(&xsk_addr->addr_node, &XSK_TX_HEAD(skb)->addr_node);
 	}
 
 	len = desc->len;
@@ -774,6 +777,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 {
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
+	struct page *page;
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
@@ -791,6 +795,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		len = desc->len;
 
 		if (!skb) {
+			struct xsk_addr_node *head_addr;
+
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
 			tr = dev->needed_tailroom;
 			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
@@ -804,7 +810,13 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
+			head_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+			if (!head_addr) {
+				__free_page(page);
+				err = -ENOMEM;
+				goto free_err;
+			}
+			xsk_skb_init_misc(skb, xs, head_addr, desc->addr);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -814,7 +826,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct xsk_addr_node *xsk_addr;
-			struct page *page;
 			u8 *vaddr;
 
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
@@ -843,7 +854,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
 
 			xsk_addr->addr = desc->addr;
-			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
+			list_add_tail(&xsk_addr->addr_node, &XSK_TX_HEAD(skb)->addr_node);
 		}
 	}
 
-- 
2.51.0


