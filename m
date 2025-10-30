Return-Path: <bpf+bounces-73014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5259C207FC
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8569A188B759
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3C230BCB;
	Thu, 30 Oct 2025 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AKOvQAAQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IjAloasN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XttQy+ro";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IAUP+Z5O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA701A7AE3
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833069; cv=none; b=G9ZzW/Sk9w+1N9FP5NTlTbwWhUEbVW4ihUj+CLyHM+a8QBTuV/z83rKwL+i2NxTQ436jL0WaYD5HymEYj80InQygSN8t0M2K0OwXFGOtdqRpwfi8vb7gFkygXD8+BJ+yiCtIcTDnTi0VNMHtSa9kK/TQzJvquhnGDS3wdHWEol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833069; c=relaxed/simple;
	bh=cDFHJ3Ac8G5d2p50z+19mx9jVg1vbpkyhkXtsfi3pAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEsQLtTZ6DXO6ehMxVAem0bB4JY1zG+R0ge4/PYPMvrts2X1dvvqHrcpu64h8oqIpvNy2bi8kDvdCcEqAp3Reidx8x2iBJQhy+pgUsPJWYlb5OsvZOGs2LIJPRJhIuuiGMqhLEuNXufDeGWAJ551PXyUOfn53Fx6hHcKSmlL5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AKOvQAAQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IjAloasN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XttQy+ro; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IAUP+Z5O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CAAFE3371B;
	Thu, 30 Oct 2025 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761833061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o7YyrSOH2QLNsgcISh8hBytUZ1hCCVjc9jS7W/QNySY=;
	b=AKOvQAAQchaSpOZ8xtcKUT+pzrfrYBklhsz8MjjrttZLtFue+CJEK67IE/C1DHBkbhBPkU
	lVWiwZ8Z4DaZZJXzSR/EniYZZiGC8BJaFpqqkhb7HEZ+pJO2Ga4TZTKuqpLC29r9X+OisE
	50RCNjsbzUP/kxn4U81u+o+yzK8Er/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761833061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o7YyrSOH2QLNsgcISh8hBytUZ1hCCVjc9jS7W/QNySY=;
	b=IjAloasNJGJk7p//p3pFNDUxsK7Ujxx7Y76bhTQK7UyiLVTP81ygmAaOu+7iJPs4bB/da7
	mv4fKyppIgcD37Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XttQy+ro;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IAUP+Z5O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761833057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o7YyrSOH2QLNsgcISh8hBytUZ1hCCVjc9jS7W/QNySY=;
	b=XttQy+roIeeAMU2rUMvqNDS/QCc6aFRYw1qmB/mZu8IpI7VRGs5Gqy1FDwmCHYmmFsv+gx
	RUQ7fNrfHNeZdiI4ooOOAga+N1EG6FEK8ge6lYtCX6qn81efooB06yqXQ1vc47TV9N/8zH
	D2XOgpjkhH/f5OnePcfbPhsDH4fLdRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761833057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o7YyrSOH2QLNsgcISh8hBytUZ1hCCVjc9jS7W/QNySY=;
	b=IAUP+Z5ODi1vRndJOhMKvlRMldEHZ90EBFxj4D3QmDEnjnbpgxTnxeAaYQ1aBFQHmThX0B
	Y9ivXGAwhIB9WlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04FC61396A;
	Thu, 30 Oct 2025 14:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8GAXOmBwA2kMCQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 30 Oct 2025 14:04:16 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: csmate@nop.hu,
	kerneljasonxing@gmail.com,
	maciej.fijalkowski@intel.com,
	bjorn@kernel.org,
	sdf@fomichev.me,
	jonathan.lemon@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net v3] xsk: avoid data corruption on cq descriptor number
Date: Thu, 30 Oct 2025 15:03:55 +0100
Message-ID: <20251030140355.4059-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CAAFE3371B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[nop.hu,gmail.com,intel.com,kernel.org,fomichev.me,vger.kernel.org,davemloft.net,google.com,redhat.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	TAGGED_RCPT(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.51

Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
production"), the descriptor number is stored in skb control block and
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

Instead use the skb destructor_arg pointer along with pointer tagging.
As pointers are always aligned to 8B, use the bottom bit to indicate
whether this a single address or an allocated struct containing several
addresses.

Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: remove some leftovers on skb_build and simplify fragmented traffic
logic

v3: drop skb extension approach, instead use pointer tagging in
destructor_arg to know whether we have a single address or an allocated
struct with multiple ones. Also, move from bpf to net as requested

Note: tested with the crash reproducer and xdpsock tool
---
 net/xdp/xsk.c | 130 ++++++++++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 56 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..d7354a3e2545 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -36,20 +36,13 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET 32
 
-struct xsk_addr_node {
-	u64 addr;
-	struct list_head addr_node;
-};
-
-struct xsk_addr_head {
+struct xsk_addrs {
 	u32 num_descs;
-	struct list_head addrs_list;
+	u64 addrs[MAX_SKB_FRAGS + 1];
 };
 
 static struct kmem_cache *xsk_tx_generic_cache;
 
-#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
-
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -558,29 +551,53 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 	return ret;
 }
 
+static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
+{
+	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+}
+
+static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
+{
+	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
+}
+
+static u32 xsk_get_num_desc(struct sk_buff *skb)
+{
+	struct xsk_addrs *xsk_addr;
+
+	if (xsk_skb_destructor_is_addr(skb))
+		return 1;
+
+	xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+
+	return xsk_addr->num_descs;
+}
+
 static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 				      struct sk_buff *skb)
 {
-	struct xsk_addr_node *pos, *tmp;
+	u32 num_descs = xsk_get_num_desc(skb);
+	struct xsk_addrs *xsk_addr;
 	u32 descs_processed = 0;
 	unsigned long flags;
-	u32 idx;
+	u32 idx, i;
 
 	spin_lock_irqsave(&pool->cq_lock, flags);
 	idx = xskq_get_prod(pool->cq);
 
-	xskq_prod_write_addr(pool->cq, idx,
-			     (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
-	descs_processed++;
+	if (unlikely(num_descs > 1)) {
+		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
 
-	if (unlikely(XSKCB(skb)->num_descs > 1)) {
-		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
+		for (i = 0; i < num_descs; i++) {
 			xskq_prod_write_addr(pool->cq, idx + descs_processed,
-					     pos->addr);
+					     xsk_addr->addrs[i]);
 			descs_processed++;
-			list_del(&pos->addr_node);
-			kmem_cache_free(xsk_tx_generic_cache, pos);
 		}
+		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
+	} else {
+		xskq_prod_write_addr(pool->cq, idx,
+				     xsk_skb_destructor_get_addr(skb));
+		descs_processed++;
 	}
 	xskq_prod_submit_n(pool->cq, descs_processed);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
@@ -595,16 +612,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
-static void xsk_inc_num_desc(struct sk_buff *skb)
-{
-	XSKCB(skb)->num_descs++;
-}
-
-static u32 xsk_get_num_desc(struct sk_buff *skb)
-{
-	return XSKCB(skb)->num_descs;
-}
-
 static void xsk_destruct_skb(struct sk_buff *skb)
 {
 	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
@@ -621,27 +628,22 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
 			      u64 addr)
 {
-	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
-	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
 	skb->dev = xs->dev;
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
-	XSKCB(skb)->num_descs = 0;
 	skb->destructor = xsk_destruct_skb;
-	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
+	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
 {
 	struct xdp_sock *xs = xdp_sk(skb->sk);
 	u32 num_descs = xsk_get_num_desc(skb);
-	struct xsk_addr_node *pos, *tmp;
+	struct xsk_addrs *xsk_addr;
 
 	if (unlikely(num_descs > 1)) {
-		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
-			list_del(&pos->addr_node);
-			kmem_cache_free(xsk_tx_generic_cache, pos);
-		}
+		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
 	}
 
 	skb->destructor = sock_wfree;
@@ -701,7 +703,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 {
 	struct xsk_buff_pool *pool = xs->pool;
 	u32 hr, len, ts, offset, copy, copied;
-	struct xsk_addr_node *xsk_addr;
 	struct sk_buff *skb = xs->skb;
 	struct page *page;
 	void *buffer;
@@ -727,16 +728,27 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 				return ERR_PTR(err);
 		}
 	} else {
-		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
-		if (!xsk_addr)
-			return ERR_PTR(-ENOMEM);
+		struct xsk_addrs *xsk_addr;
+
+		if (xsk_skb_destructor_is_addr(skb)) {
+			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
+						     GFP_KERNEL);
+			if (!xsk_addr)
+				return ERR_PTR(-ENOMEM);
+
+			xsk_addr->num_descs = 1;
+			xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
+			skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
+		} else {
+			xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+		}
 
 		/* in case of -EOVERFLOW that could happen below,
 		 * xsk_consume_skb() will release this node as whole skb
 		 * would be dropped, which implies freeing all list elements
 		 */
-		xsk_addr->addr = desc->addr;
-		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
+		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
+		xsk_addr->num_descs++;
 	}
 
 	len = desc->len;
@@ -813,7 +825,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			}
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
-			struct xsk_addr_node *xsk_addr;
+			struct xsk_addrs *xsk_addr;
 			struct page *page;
 			u8 *vaddr;
 
@@ -828,11 +840,20 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 			}
 
-			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
-			if (!xsk_addr) {
-				__free_page(page);
-				err = -ENOMEM;
-				goto free_err;
+			if (xsk_skb_destructor_is_addr(skb)) {
+				xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
+							     GFP_KERNEL);
+				if (!xsk_addr) {
+					__free_page(page);
+					err = -ENOMEM;
+					goto free_err;
+				}
+
+				xsk_addr->num_descs = 1;
+				xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
+				skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
+			} else {
+				xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
 			}
 
 			vaddr = kmap_local_page(page);
@@ -842,13 +863,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
 
-			xsk_addr->addr = desc->addr;
-			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
+			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
+			xsk_addr->num_descs++;
 		}
 	}
 
-	xsk_inc_num_desc(skb);
-
 	return skb;
 
 free_err:
@@ -857,7 +876,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
-		xsk_inc_num_desc(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
 	} else {
@@ -1904,7 +1922,7 @@ static int __init xsk_init(void)
 		goto out_pernet;
 
 	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
-						 sizeof(struct xsk_addr_node),
+						 sizeof(struct xsk_addrs),
 						 0, SLAB_HWCACHE_ALIGN, NULL);
 	if (!xsk_tx_generic_cache) {
 		err = -ENOMEM;
-- 
2.51.0


