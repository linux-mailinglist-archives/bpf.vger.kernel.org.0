Return-Path: <bpf+bounces-72571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC21C15B17
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD661887B5E
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D63346A10;
	Tue, 28 Oct 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aXG2ovEh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m1kzASuz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aXG2ovEh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m1kzASuz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E720346788
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667341; cv=none; b=KQi6UKnfYpZdGxS+/IJ/kLuVaIM3gQIccDsUs+D9Q6PNwySGBdeQyLFRfSzBM9MMNiVaaHz/TGJgqz4nGppiHqzTajmVfwZJ4+bPh5Jg+LiLT554MRH/OkgaBnSJ0Dhu8znM0En42gzD6KZAxlmLEn5XtJw7XLDlme0sClLOpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667341; c=relaxed/simple;
	bh=sOlM6uFqSEBCIOPF8Hg9enq2ffJprvNKB+UIpY+C8XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6muounUfDgkkfwwRzUyNfi8JrFbxVzOKMnfbn0DEcDcOtU9qggUE0eBXA9WdCJ+Ki9D0VLneA+98PITWNsiUD/Kwh1Low+Pz2u27Gu4y4H/SqivSxRLgdMo8d/hF5Koh5sM2ZZtX79SYCFRifyEMMi/hNFE+38Z3h658UdNM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aXG2ovEh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m1kzASuz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aXG2ovEh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m1kzASuz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B40CC1F46E;
	Tue, 28 Oct 2025 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761667336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npnoSap1x9oyKBWEqU8oDPY0CzyqCFfUDoVbZTtAnrY=;
	b=aXG2ovEhdWW8y3clV46qjacvIWpdSkYhKVnCtez+MkTzh5yB3MEaqmkcBjoKSSmtYDjTJ6
	aZmfasHYTMT4waQB33UOPSsh1hprOuX9Nsd6yPUR4fsWMZwy2RJ99ORIGOrHXpYO1rQnD0
	7h/sdNkspt6tF0EPsmmdf5/aJHpie6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761667336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npnoSap1x9oyKBWEqU8oDPY0CzyqCFfUDoVbZTtAnrY=;
	b=m1kzASuzsCG0oR7nW/10Bql8n2F7haIRJrhPXkL4q+z5J1QdA70h1KbxJRWCWd85oPKq/H
	9H60tVAc164CZXAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761667336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npnoSap1x9oyKBWEqU8oDPY0CzyqCFfUDoVbZTtAnrY=;
	b=aXG2ovEhdWW8y3clV46qjacvIWpdSkYhKVnCtez+MkTzh5yB3MEaqmkcBjoKSSmtYDjTJ6
	aZmfasHYTMT4waQB33UOPSsh1hprOuX9Nsd6yPUR4fsWMZwy2RJ99ORIGOrHXpYO1rQnD0
	7h/sdNkspt6tF0EPsmmdf5/aJHpie6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761667336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npnoSap1x9oyKBWEqU8oDPY0CzyqCFfUDoVbZTtAnrY=;
	b=m1kzASuzsCG0oR7nW/10Bql8n2F7haIRJrhPXkL4q+z5J1QdA70h1KbxJRWCWd85oPKq/H
	9H60tVAc164CZXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3159013A7D;
	Tue, 28 Oct 2025 16:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WE4ACQjpAGlcfAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 28 Oct 2025 16:02:16 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	kerneljasonxing@gmail.com,
	fw@strlen.de,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 bpf] xsk: avoid data corruption on cq descriptor number
Date: Tue, 28 Oct 2025 17:02:00 +0100
Message-ID: <20251028160200.4204-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028160200.4204-1-fmancera@suse.de>
References: <20251028160200.4204-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,gmail.com,strlen.de,suse.de];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -6.80

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
  ?1082000 switch_fpu_return+0x5b/0xe0
  ? do_syscall_64+0x204/0x2f0
  ? do_syscall_64+0x204/0x2f0
  ? do_syscall_64+0x204/0x2f0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>
 [...]
 Kernel panic - not syncing: Fatal exception in interrupt
 Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Use the skb XDP extension to store the number of cq descriptors along
with a list of umem addresses.

Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: I did some testing with xdpsock tool, all good so far. Anyway, XDP
expert testing would be really welcomed.
---
 net/xdp/xsk.c | 81 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 21 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..4f3fc005d1f5 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -41,15 +41,8 @@ struct xsk_addr_node {
 	struct list_head addr_node;
 };
 
-struct xsk_addr_head {
-	u32 num_descs;
-	struct list_head addrs_list;
-};
-
 static struct kmem_cache *xsk_tx_generic_cache;
 
-#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
-
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -562,6 +555,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 				      struct sk_buff *skb)
 {
 	struct xsk_addr_node *pos, *tmp;
+	struct xdp_skb_ext *ext;
 	u32 descs_processed = 0;
 	unsigned long flags;
 	u32 idx;
@@ -573,14 +567,16 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 			     (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
 	descs_processed++;
 
-	if (unlikely(XSKCB(skb)->num_descs > 1)) {
-		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
+	ext = skb_ext_find(skb, SKB_EXT_XDP);
+	if (unlikely(ext && ext->num_descs > 1)) {
+		list_for_each_entry_safe(pos, tmp, &ext->addrs_list, addr_node) {
 			xskq_prod_write_addr(pool->cq, idx + descs_processed,
 					     pos->addr);
 			descs_processed++;
 			list_del(&pos->addr_node);
 			kmem_cache_free(xsk_tx_generic_cache, pos);
 		}
+		skb_ext_del(skb, SKB_EXT_XDP);
 	}
 	xskq_prod_submit_n(pool->cq, descs_processed);
 	spin_unlock_irqrestore(&pool->cq_lock, flags);
@@ -597,12 +593,19 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
 {
-	XSKCB(skb)->num_descs++;
+	struct xdp_skb_ext *ext;
+
+	ext = skb_ext_find(skb, SKB_EXT_XDP);
+	if (ext)
+		ext->num_descs++;
 }
 
 static u32 xsk_get_num_desc(struct sk_buff *skb)
 {
-	return XSKCB(skb)->num_descs;
+	struct xdp_skb_ext *ext;
+
+	ext = skb_ext_find(skb, SKB_EXT_XDP);
+	return (ext && ext->num_descs > 1) ? ext->num_descs : 1;
 }
 
 static void xsk_destruct_skb(struct sk_buff *skb)
@@ -621,12 +624,9 @@ static void xsk_destruct_skb(struct sk_buff *skb)
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
 	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
 }
@@ -636,12 +636,15 @@ static void xsk_consume_skb(struct sk_buff *skb)
 	struct xdp_sock *xs = xdp_sk(skb->sk);
 	u32 num_descs = xsk_get_num_desc(skb);
 	struct xsk_addr_node *pos, *tmp;
+	struct xdp_skb_ext *ext;
 
-	if (unlikely(num_descs > 1)) {
-		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
+	ext = skb_ext_find(skb, SKB_EXT_XDP);
+	if (unlikely(ext && ext->num_descs > 1)) {
+		list_for_each_entry_safe(pos, tmp, &ext->addrs_list, addr_node) {
 			list_del(&pos->addr_node);
 			kmem_cache_free(xsk_tx_generic_cache, pos);
 		}
+		skb_ext_del(skb, SKB_EXT_XDP);
 	}
 
 	skb->destructor = sock_wfree;
@@ -727,16 +730,32 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 				return ERR_PTR(err);
 		}
 	} else {
+		struct xdp_skb_ext *ext;
+
 		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
 		if (!xsk_addr)
 			return ERR_PTR(-ENOMEM);
 
+		ext = skb_ext_find(skb, SKB_EXT_XDP);
+		if (!ext) {
+			ext = skb_ext_add(skb, SKB_EXT_XDP);
+			if (!ext)
+				return ERR_PTR(-ENOMEM);
+			memset(ext, 0, sizeof(*ext));
+			INIT_LIST_HEAD(&ext->addrs_list);
+			ext->num_descs = 1;
+		} else if (ext->num_descs == 0) {
+			INIT_LIST_HEAD(&ext->addrs_list);
+			ext->num_descs = 1;
+		}
+
 		/* in case of -EOVERFLOW that could happen below,
 		 * xsk_consume_skb() will release this node as whole skb
 		 * would be dropped, which implies freeing all list elements
 		 */
 		xsk_addr->addr = desc->addr;
-		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
+		list_add_tail(&xsk_addr->addr_node, &ext->addrs_list);
+		xsk_inc_num_desc(skb);
 	}
 
 	len = desc->len;
@@ -804,6 +823,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
+			if (!skb_ext_add(skb, SKB_EXT_XDP)) {
+				err = -ENOMEM;
+				goto free_err;
+			}
+
 			xsk_skb_init_misc(skb, xs, desc->addr);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
@@ -814,6 +838,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct xsk_addr_node *xsk_addr;
+			struct xdp_skb_ext *ext;
 			struct page *page;
 			u8 *vaddr;
 
@@ -828,6 +853,22 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 			}
 
+			ext = skb_ext_find(skb, SKB_EXT_XDP);
+			if (!ext) {
+				ext = skb_ext_add(skb, SKB_EXT_XDP);
+				if (!ext) {
+					__free_page(page);
+					err = -ENOMEM;
+					goto free_err;
+				}
+				memset(ext, 0, sizeof(*ext));
+				INIT_LIST_HEAD(&ext->addrs_list);
+				ext->num_descs = 1;
+			} else if (ext->num_descs == 0) {
+				INIT_LIST_HEAD(&ext->addrs_list);
+				ext->num_descs = 1;
+			}
+
 			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
 			if (!xsk_addr) {
 				__free_page(page);
@@ -843,12 +884,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
 
 			xsk_addr->addr = desc->addr;
-			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
+			list_add_tail(&xsk_addr->addr_node, &ext->addrs_list);
+			xsk_inc_num_desc(skb);
 		}
 	}
 
-	xsk_inc_num_desc(skb);
-
 	return skb;
 
 free_err:
@@ -857,7 +897,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
-		xsk_inc_num_desc(xs->skb);
 		xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
 	} else {
-- 
2.51.0


