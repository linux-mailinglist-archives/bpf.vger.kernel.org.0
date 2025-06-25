Return-Path: <bpf+bounces-61544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D13AE894B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A884A6A0F
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 16:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E3F2D5402;
	Wed, 25 Jun 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STfFHJI9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AD2D23B8;
	Wed, 25 Jun 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867836; cv=none; b=RAm4UXj0ueWtNz76IDgg4CrjdH485n1B3dhaJ5zo3aw4TElm8qwtuLN7CYZvaFIfiuHcvTLWEKV3kcDyB6G04NtnJIfVELlYiSREKiVdZ55K9iwvwvVnN/Ea3I/C1SSok6tQDJSPf3tZZP+D5j4Vc8SWFunNhjuz89xYp5Kq0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867836; c=relaxed/simple;
	bh=4VNy85BUiywaXD9Mqe5C4cqxPjoK22ldzoO5xhVanSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyeqXLCj/396WSWc7iodwo+Vz7COGpE0qE0iAWHgpLHi0Pnar7GIndihj9JBoX32kFS7ZGNCKjrereXQUHWSsiyqMThSA+Eyllfi5kK1fHuuPY5l8jgqYaasVcWrzTAGzwjP3P7iQ9/MQDLLoaxxei89LQsUZkpdm+66LTOeoYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STfFHJI9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-236192f8770so1267345ad.0;
        Wed, 25 Jun 2025 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867833; x=1751472633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uU4X+SI62dfgcKBBMkPrylaI2hont+JORdjl4bJDSKE=;
        b=STfFHJI9u7nIjbrJSCc8v9Xlo5N+fTxOdgtg5PS+yCiCejcglsyizZG89o+irTib7D
         hjOhoJqbvhZHA0Fb/26Qv2Qi77J0BTyugL/QWgBDt0lj5rTikhF29JETkIvb9cCA9l9i
         1EnkE98GLhZ2sC3h6P2pnXOObjoJCsrt2mfeC0Y5FhyOuiGhVVOlZEReU+JOBM0mXLVS
         jHL6M9CxX/8V9yJEmsSOOsMpdJcYaf1KXYO/qT6uCRWctiBCartKTsl7LVTawaq38qzQ
         L7Tc8S4QjefQS9L2UjI65OVzoSmrmmhVuUvpgRBAgX/N1TW6dQNTirCVWaSNLX7uxLJx
         /DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867833; x=1751472633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uU4X+SI62dfgcKBBMkPrylaI2hont+JORdjl4bJDSKE=;
        b=rZ3x1QciRdo+q4Bvy8UhT+feco/Bs9o0XU+69oc06rCVMjljrAylIUrppYwXGcGNky
         LCUGHzPFSEd3dccNFWudSGNpJLNchR4uWqNxyYapl4cqb3u8XL9tvoYGAmmYCk417StZ
         JKzPVEgC3b8T5J/SEj5hn3H5Egr86StXk4NVIgaHpnoM4ATbgc8Mi00MIVGBaQ2SRSg+
         U3ARRQyTsaK73ue38EVfH0ZkcH5NvQy7DsNeq4jDU1sX4uBAqszLaAoqM7N9Q02qkIZE
         51L6J6Gayb/B/3793+jMhrCoh4Ch5uRXHXm1A2ZmldPVlK1DYFoNMM5cqpel09wjiMfs
         AUug==
X-Forwarded-Encrypted: i=1; AJvYcCVFVhbdEV1Sgwcbqmk4Ont9qyzOVefS/QqmP8sUijkMb2BxokEHYP2rdt1nORClvGKQSUFQZ4qfFUNSVXV8@vger.kernel.org, AJvYcCXO0mhP0Hxo4uVWrpzZWI5Qq0CQqmyL4uoppS5kKgcRmsbIDko5SPFnVgh21gbSlCp8NQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBoHq+c/0ih3JuxKDkwZE0Un6oVtgCa3Xy3oiGOTET7NXgSLrA
	Pv2dwp9U/o1WCN78bjuJxTbxLVWeDQRrl835MWzn90wyZbs6xo0dn08e+AvDew==
X-Gm-Gg: ASbGncshMY9g3DPHBpTCRVGihv3WLH8ty988n2scoWRznXlqccHxr4oWrffDGvue0m/
	Ez/W67JX5WvmdNvmdPyAytZpfb0Uq/+Gb8cPa46v+1/M1G1xtW69udIwuZWjKyCsDcVZrYiJdHk
	17xBL1jnIkvBqytGdavDblWikQnj0y007SMJVSA0byvA9DJTbS+m3C+SygI9Mcv1ymomLttOVTe
	fcxRbbk3LG/mJcXohr2yoBD8yPicrIjMdDsuSbea6/CoCsU5H4hPO/sSHHMwoFf6UTvsaRl/6c0
	WuD+C/FBy/1CTQARAT/2/VyT6XMIB/4+BbSPcRVOBD23h4mSA7RswLTxgPrNBqA6v0DqMCvp8FI
	p/g==
X-Google-Smtp-Source: AGHT+IEtOCWRRtycCWE6b2ddeIkB621raQHnk3klmvycYJo2xwdbq//kpd/UA+wGQ7RO8gQtx2zEWA==
X-Received: by 2002:a17:902:8212:b0:221:751f:cfbe with SMTP id d9443c01a7336-2390a4e1c2fmr1517585ad.19.1750867833222;
        Wed, 25 Jun 2025 09:10:33 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1cf0:45c2:bdd1:b92d])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-237d873845esm143219175ad.243.2025.06.25.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:10:32 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 3/4] virtio-net: create a helper to check received mergeable buffer's length
Date: Wed, 25 Jun 2025 23:08:48 +0700
Message-ID: <20250625160849.61344-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625160849.61344-1-minhquangbui99@gmail.com>
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we have repeated code to check the received mergeable buffer's
length with allocated size. This commit creates a helper to do that and
converts current code to use it.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 68 +++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6f9fedad4a5e..844cb2a78be0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -778,6 +778,26 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
 	return (unsigned long)mrg_ctx & ((1 << MRG_CTX_HEADER_SHIFT) - 1);
 }
 
+static int check_mergeable_len(struct net_device *dev, void *mrg_ctx,
+			       unsigned int len)
+{
+	unsigned int headroom, tailroom, room, truesize;
+
+	truesize = mergeable_ctx_to_truesize(mrg_ctx);
+	headroom = mergeable_ctx_to_headroom(mrg_ctx);
+	tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
+	room = SKB_DATA_ALIGN(headroom + tailroom);
+
+	if (len > truesize - room) {
+		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
+			 dev->name, len, (unsigned long)(truesize - room));
+		DEV_STATS_INC(dev, rx_length_errors);
+		return -1;
+	}
+
+	return 0;
+}
+
 static struct sk_buff *virtnet_build_skb(void *buf, unsigned int buflen,
 					 unsigned int headroom,
 					 unsigned int len)
@@ -1819,8 +1839,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 	page_off += *len;
 
 	while (--*num_buf) {
-		unsigned int headroom, tailroom, room;
-		unsigned int truesize, buflen;
+		unsigned int buflen;
 		void *buf;
 		void *ctx;
 		int off;
@@ -1832,17 +1851,8 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 		p = virt_to_head_page(buf);
 		off = buf - page_address(p);
 
-		truesize = mergeable_ctx_to_truesize(ctx);
-		headroom = mergeable_ctx_to_headroom(ctx);
-		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
-		room = SKB_DATA_ALIGN(headroom + tailroom);
-
-		if (unlikely(buflen > truesize - room)) {
+		if (check_mergeable_len(dev, ctx, buflen)) {
 			put_page(p);
-			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-				 dev->name, buflen,
-				 (unsigned long)(truesize - room));
-			DEV_STATS_INC(dev, rx_length_errors);
 			goto err_buf;
 		}
 
@@ -2143,7 +2153,6 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 				      struct virtnet_rq_stats *stats)
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
-	unsigned int headroom, tailroom, room;
 	struct skb_shared_info *shinfo;
 	unsigned int xdp_frags_truesz = 0;
 	unsigned int truesize;
@@ -2189,20 +2198,14 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 		page = virt_to_head_page(buf);
 		offset = buf - page_address(page);
 
-		truesize = mergeable_ctx_to_truesize(ctx);
-		headroom = mergeable_ctx_to_headroom(ctx);
-		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
-		room = SKB_DATA_ALIGN(headroom + tailroom);
-
-		xdp_frags_truesz += truesize;
-		if (unlikely(len > truesize - room)) {
+		if (check_mergeable_len(dev, ctx, len)) {
 			put_page(page);
-			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-				 dev->name, len, (unsigned long)(truesize - room));
-			DEV_STATS_INC(dev, rx_length_errors);
 			goto err;
 		}
 
+		truesize = mergeable_ctx_to_truesize(ctx);
+		xdp_frags_truesz += truesize;
+
 		frag = &shinfo->frags[shinfo->nr_frags++];
 		skb_frag_fill_page_desc(frag, page, offset, len);
 		if (page_is_pfmemalloc(page))
@@ -2416,18 +2419,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	struct sk_buff *head_skb, *curr_skb;
 	unsigned int truesize = mergeable_ctx_to_truesize(ctx);
 	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
-	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
-	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
 
 	head_skb = NULL;
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 
-	if (unlikely(len > truesize - room)) {
-		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-			 dev->name, len, (unsigned long)(truesize - room));
-		DEV_STATS_INC(dev, rx_length_errors);
+	if (check_mergeable_len(dev, ctx, len))
 		goto err_skb;
-	}
 
 	if (unlikely(vi->xdp_enabled)) {
 		struct bpf_prog *xdp_prog;
@@ -2462,17 +2459,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		u64_stats_add(&stats->bytes, len);
 		page = virt_to_head_page(buf);
 
-		truesize = mergeable_ctx_to_truesize(ctx);
-		headroom = mergeable_ctx_to_headroom(ctx);
-		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
-		room = SKB_DATA_ALIGN(headroom + tailroom);
-		if (unlikely(len > truesize - room)) {
-			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-				 dev->name, len, (unsigned long)(truesize - room));
-			DEV_STATS_INC(dev, rx_length_errors);
+		if (check_mergeable_len(dev, ctx, len))
 			goto err_skb;
-		}
 
+		truesize = mergeable_ctx_to_truesize(ctx);
 		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
 						    buf, len, truesize);
 		if (!curr_skb)
-- 
2.43.0


