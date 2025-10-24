Return-Path: <bpf+bounces-72010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C7C05A49
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 12:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9F30504195
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A031062C;
	Fri, 24 Oct 2025 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0n6AA1Nm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NFUddAfD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="emsfwdQL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S9OoCNoI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F02FE041
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302485; cv=none; b=fAAPTJ3LnwdCWm7CsA0iOOEX3ChnKoKFTLCKcV81CtOPwvjiVJf1Tm1i+ln/V7+euRfxZJp7SY6FX1BPw1b3gji+6VkwiqE3miEZiAUC7jIbOSXDmmLlmZT0OeDbwzYFFt9du9jKxZOKNo0pj0hoR/B2PZqH8KNSevFxkojzGuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302485; c=relaxed/simple;
	bh=li6KSp9cre7+afqkFOJCiB/+pjP3e1iaKEH4VasOQ80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NU1+kYptp78BqpkwQQ8mc3YVJkCVUE/Ndfdh4fiFQi74wDmaEX+n9yLT4EVhCeRf/iDBzZS4bLCWqpeR76KAO0Cg7aiRWEXZXof3ZKZRj95qWAiI5+RgBxyYdvXQybmz7V2RXpm6YAadJ7+PdCpgpHlkavMG2GEVGMoxVnmcsxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0n6AA1Nm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NFUddAfD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=emsfwdQL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S9OoCNoI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 611B01F443;
	Fri, 24 Oct 2025 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761302476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GxewOv61lIhFO1u6lbyVbaaV2olLn0w+aW8dk+FDhK4=;
	b=0n6AA1NmCbljap9Usg39T+Rapi5TCjuM1ePqMo9zSFmjjtbuk3gClwSgLJ+XJgHp48+3QP
	SM66v8I5wdqJHKBz6dl9/lsxUOFUrTSrSefu6N33KwHarj3ARrrC4OsDph9OlTjCYilEpU
	q0EaxYLSiFcGFGPA8Jejjj17PZAES58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761302476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GxewOv61lIhFO1u6lbyVbaaV2olLn0w+aW8dk+FDhK4=;
	b=NFUddAfDfsmOtytPfiVPU9SbztRFATsjqxSu08noi9BvpFk8UocV8OHioCTXuCvlAoKiFx
	eEqDb3DNZS36RCCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=emsfwdQL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S9OoCNoI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761302472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GxewOv61lIhFO1u6lbyVbaaV2olLn0w+aW8dk+FDhK4=;
	b=emsfwdQLrEF7xYSPcrfvDo4kPargHb+NyqKGSizc07rCZ6PZlVC1BAqXNCTYn1BgBRJLNW
	79DApMQaaWMl2VTcgo+M33XtIus8govaHTR/W21DyAPgAB8tpaayuxz5SEPivHrthaJBqX
	LUGlvQ6GoX1Jxpv7p3FYvxt0i4xj/Lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761302472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GxewOv61lIhFO1u6lbyVbaaV2olLn0w+aW8dk+FDhK4=;
	b=S9OoCNoILsfW1kG8yWfNalG077r+vG8LJl/eYNUPpcYRc/YxfDQS7Ld7et0ug1xikRnTKk
	HSQWVDyFk+tm7uDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98CE813AEF;
	Fri, 24 Oct 2025 10:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dS6QIsdX+2jPXAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 24 Oct 2025 10:41:11 +0000
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
Subject: [PATCH net v2] xsk: avoid data corruption on cq descriptor number
Date: Fri, 24 Oct 2025 12:40:49 +0200
Message-ID: <20251024104049.20902-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 611B01F443
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nop.hu,gmail.com,intel.com,kernel.org,fomichev.me,vger.kernel.org,davemloft.net,google.com,redhat.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 

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

The approach proposed stores the first address also in the xsk_addr_node
along with the number of descriptors. The head xsk_addr_node is
referenced in skb_shinfo(skb)->destructor_arg. The rest of the fragments
store the address on the list.

This is less efficient as 4 bytes are wasted when storing each address.

Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: fix erroneous page handling and fix typos on commit message.
---
 net/xdp/xsk.c | 52 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..965cf071b036 100644
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
@@ -720,7 +717,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 		skb_reserve(skb, hr);
 
-		xsk_skb_init_misc(skb, xs, desc->addr);
+		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+		if (!xsk_addr)
+			return ERR_PTR(-ENOMEM);
+
+		xsk_skb_init_misc(skb, xs, xsk_addr, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
@@ -736,7 +737,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		 * would be dropped, which implies freeing all list elements
 		 */
 		xsk_addr->addr = desc->addr;
-		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
+		list_add_tail(&xsk_addr->addr_node, &XSK_TX_HEAD(skb)->addr_node);
 	}
 
 	len = desc->len;
@@ -773,6 +774,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				     struct xdp_desc *desc)
 {
 	struct net_device *dev = xs->dev;
+	struct xsk_addr_node *xsk_addr;
 	struct sk_buff *skb = xs->skb;
 	int err;
 
@@ -804,7 +806,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
+			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+			if (!xsk_addr) {
+				err = -ENOMEM;
+				goto free_err;
+			}
+			xsk_skb_init_misc(skb, xs, xsk_addr, desc->addr);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -813,7 +820,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			}
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
-			struct xsk_addr_node *xsk_addr;
 			struct page *page;
 			u8 *vaddr;
 
@@ -843,7 +849,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
 
 			xsk_addr->addr = desc->addr;
-			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
+			list_add_tail(&xsk_addr->addr_node, &XSK_TX_HEAD(skb)->addr_node);
 		}
 	}
 
-- 
2.51.0


