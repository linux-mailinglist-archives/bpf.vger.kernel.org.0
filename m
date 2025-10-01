Return-Path: <bpf+bounces-70070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B69AABAF79E
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 09:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68703178BB7
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 07:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041752749F2;
	Wed,  1 Oct 2025 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="map3QfJm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBE79F2
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304832; cv=none; b=eyJWmyNK13ccz77t818jQJzuMqF+gvHiYDZnewj1ArCJhQzxNgTqTuic/LeU67IGLBsjTtxpgQKC7tVU3zMt9StQIJzKfT3XRg2qnLqcE6EFSglJ7NuG5WpAWviAai9yIrOKvzDGTy2F+nrQKPjRv0vfBedwZ6aS8bCrzHRBRRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304832; c=relaxed/simple;
	bh=wsWXUZblALi/C0CMuXX943KbHWNk/tomO6b1IuUZa/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jon3iJlO9n7AgiNg4tNr222ZSe5OrQ+EZDTit7jvRkjtrKYYZh3j/TxZB+vwFE66gcK+jevIzA64jmU66Mm/G6iGnvSZ0jyzJe9XEzwzXXOFj3WALoLaB1o9NjH6SyqBqGJ064R4V/RPoHKYE2xNkKLd5rofq7ULV4cEzUc0hWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=map3QfJm; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so11108194a91.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 00:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759304830; x=1759909630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZaBBQ9S9hkim1gxD11YEoFF1zVlqLEiLLem586vQ4RU=;
        b=map3QfJmYfB2xh3Fn568X3mmfCc2jYet/VxEfa+pycdr1fq5y3/tLeenBEs0KwZw4I
         Nj1mWX2l2/+/q68lH5hSGn2SRukEDvQe1GszczMHLgu/KrqDeiOvmeEU8w0GwcvgPnC3
         82edqq6IkxwJAkiH6bdNvNI64vIo2k5vK7dRGT3Dl8/N/9SAx3JAgCeucNy9lcMJt0Yw
         CSKK6yekQ/53TLt/WFAtnLaeBl41qwRo++Az8ppVfAtFFm3VrKv8w3ZEc4RiUeUfcoAO
         D39fcQtJH4y+gMT0qQJR72+fU/Hhab/xwwK35DH1sm76HLp/fBHtqePjKn9yBHJM31H1
         I0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759304830; x=1759909630;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZaBBQ9S9hkim1gxD11YEoFF1zVlqLEiLLem586vQ4RU=;
        b=YFNp+SMWb1Au3PoXVQMxrDiMmtCwdnCIUKMeZZwZzLC5WqIet1HHX62UP5YAiSssMo
         3UARJBZJAtObhQilZh3m8uNSO+56mV9Y3TtEITbBq7xrwL+7oL2ltcqeTfK9YorBbawY
         S/oKM8mMgxgOV4AukB/NHT87RXA1oqo7t+ndy3cgxHCP6Esl40m2qoFcefaN+EU2nsuU
         j0b9chTLAfxfVvFpDQ3EQLUxv8ahxdPEB8+ZBLA5YxQLQnmsy+9fxIj3XqG9N1z39qWG
         CTvwwKxI0LEgUXTkRNH5GWo9NuQrf2Iokykqb1kqzqxW1J1KtTdfuMMmaQAVUpKNoqf5
         Z+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWI7BnDNJ2l9NoSmf9QGPA1akbgspjhAl7AvF7nCoQuXKowuKqdRhx3EWFiyIUyAOlLaig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHBrf5yFV5hEXo0Sww9YfJXh1pxqeR4/14TDE24TlD2aCk0Gw
	Bwn5WZDcV5rL3RHJ3OOt05wk2i72YeOhmfgfzJjN3uRuKZMeVpWmyFWG3Pkxipix/r5SRvrnMgw
	FVg==
X-Google-Smtp-Source: AGHT+IE6A2KE2XI2nuJTHnOhE/kE1PB7DsW8NTdvhNzcgI3JeaPiCA8vogJmf808tZzeZsL5C2YRxRK2QA==
X-Received: from pjnj4.prod.google.com ([2002:a17:90a:8404:b0:332:8246:26ae])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b10:b0:32e:c649:e583
 with SMTP id 98e67ed59e1d1-339a6f302camr2888453a91.22.1759304829407; Wed, 01
 Oct 2025 00:47:09 -0700 (PDT)
Date: Wed,  1 Oct 2025 07:47:04 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001074704.2817028-1-tavip@google.com>
Subject: [PATCH net v2] xdp: update mem type when page pool is used for
 generic XDP
From: Octavian Purdila <tavip@google.com>
To: kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, kuniyu@google.com, 
	aleksander.lobakin@intel.com, maciej.fijalkowski@intel.com, toke@redhat.com, 
	lorenzo@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>, syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

When a BPF program that supports BPF_F_XDP_HAS_FRAGS is issuing
bpf_xdp_adjust_tail and a large packet is injected via /dev/net/tun a
crash occurs due to detecting a bad page state (page_pool leak).

This is because xdp_buff does not record the type of memory and
instead relies on the netdev receive queue xdp info. Since
netif_alloc_rx_queues only calls xdp_rxq_info_reg mem.type is going to
be set to MEM_TYPE_PAGE_SHARED. So shrinking will eventually call
page_frag_free. But with current multi-buff support for
BPF_F_XDP_HAS_FRAGS programs buffers are allocated via the page pool
in skb_cow_data_for_xdp.

To fix this issue use the same approach that is used in
cpu_map_bpf_prog_run_xdp: declare an xdp_rxq_info structure on the
stack instead of using the xdp_rxq_info structure from the netdev rx
queue. And update mem.type to reflect how the buffers are allocated,
in this case to MEM_TYPE_PAGE_POOL if skb_cow_data_for_xdp is used.

Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Signed-off-by: Octavian Purdila <tavip@google.com>
---

v2:
- use a local xdp_rxq_info structure and update mem.type instead of
  skipping using page pool if the netdev xdp_rxq_info is not set to
  MEM_TYPE_PAGE_POOL (which is always the case currently)
v1: https://lore.kernel.org/netdev/20250924060843.2280499-1-tavip@google.com/

 include/linux/netdevice.h |  4 +++-
 kernel/bpf/cpumap.c       |  2 +-
 kernel/bpf/devmap.c       |  2 +-
 net/core/dev.c            | 32 +++++++++++++++++++++-----------
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3a3b761abfb..41585414e45c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -78,6 +78,7 @@ struct udp_tunnel_nic_info;
 struct udp_tunnel_nic;
 struct bpf_prog;
 struct xdp_buff;
+struct xdp_rxq_info;
 struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
@@ -4149,7 +4150,8 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 }
 
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
-			     const struct bpf_prog *xdp_prog);
+			     const struct bpf_prog *xdp_prog,
+			     struct xdp_rxq_info *rxq);
 void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
 int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb);
 int netif_rx(struct sk_buff *skb);
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index c46360b27871..a057a58ba969 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -145,7 +145,7 @@ static u32 cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 	for (u32 i = 0; i < skb_n; i++) {
 		struct sk_buff *skb = skbs[i];
 
-		act = bpf_prog_run_generic_xdp(skb, &xdp, rcpu->prog);
+		act = bpf_prog_run_generic_xdp(skb, &xdp, rcpu->prog, NULL);
 		switch (act) {
 		case XDP_PASS:
 			skbs[pass++] = skb;
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 482d284a1553..29459b79bacb 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -512,7 +512,7 @@ static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab_netdev
 	__skb_pull(skb, skb->mac_len);
 	xdp.txq = &txq;
 
-	act = bpf_prog_run_generic_xdp(skb, &xdp, dst->xdp_prog);
+	act = bpf_prog_run_generic_xdp(skb, &xdp, dst->xdp_prog, NULL);
 	switch (act) {
 	case XDP_PASS:
 		__skb_push(skb, skb->mac_len);
diff --git a/net/core/dev.c b/net/core/dev.c
index 8d49b2198d07..365c43ffc9c1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5230,10 +5230,10 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 }
 
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
-			     const struct bpf_prog *xdp_prog)
+			     const struct bpf_prog *xdp_prog,
+			     struct xdp_rxq_info *rxq)
 {
 	void *orig_data, *orig_data_end, *hard_start;
-	struct netdev_rx_queue *rxqueue;
 	bool orig_bcast, orig_host;
 	u32 mac_len, frame_sz;
 	__be16 orig_eth_type;
@@ -5251,8 +5251,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	frame_sz = (void *)skb_end_pointer(skb) - hard_start;
 	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	rxqueue = netif_get_rxqueue(skb);
-	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
+	if (!rxq)
+		rxq = &netif_get_rxqueue(skb)->xdp_rxq;
+	xdp_init_buff(xdp, frame_sz, rxq);
 	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
 			 skb_headlen(skb) + mac_len, true);
 	if (skb_is_nonlinear(skb)) {
@@ -5331,17 +5332,23 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	return act;
 }
 
-static int
-netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
+static int netif_skb_check_for_xdp(struct sk_buff **pskb,
+				   const struct bpf_prog *prog,
+				   struct xdp_rxq_info *rxq)
 {
 	struct sk_buff *skb = *pskb;
 	int err, hroom, troom;
+	struct page_pool *pool;
 
+	pool = this_cpu_read(system_page_pool.pool);
 	local_lock_nested_bh(&system_page_pool.bh_lock);
-	err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, prog);
+	err = skb_cow_data_for_xdp(pool, pskb, prog);
 	local_unlock_nested_bh(&system_page_pool.bh_lock);
-	if (!err)
+	if (!err) {
+		rxq->mem.type = MEM_TYPE_PAGE_POOL;
+		rxq->mem.id = pool->xdp_mem_id;
 		return 0;
+	}
 
 	/* In case we have to go down the path and also linearize,
 	 * then lets do the pskb_expand_head() work just once here.
@@ -5379,13 +5386,13 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 
 	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
-		if (netif_skb_check_for_xdp(pskb, xdp_prog))
+		if (netif_skb_check_for_xdp(pskb, xdp_prog, xdp->rxq))
 			goto do_drop;
 	}
 
 	__skb_pull(*pskb, mac_len);
 
-	act = bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog);
+	act = bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog, xdp->rxq);
 	switch (act) {
 	case XDP_REDIRECT:
 	case XDP_TX:
@@ -5442,7 +5449,10 @@ int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 
 	if (xdp_prog) {
-		struct xdp_buff xdp;
+		struct xdp_rxq_info rxq = {};
+		struct xdp_buff xdp = {
+			.rxq = &rxq,
+		};
 		u32 act;
 		int err;
 
-- 
2.51.0.618.g983fd99d29-goog


