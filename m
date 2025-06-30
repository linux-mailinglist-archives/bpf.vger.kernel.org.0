Return-Path: <bpf+bounces-61836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FCDAEE164
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259B13B9727
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAA02918D5;
	Mon, 30 Jun 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3wsnbxQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15B28C868;
	Mon, 30 Jun 2025 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294585; cv=none; b=D3wwmdacUwSSFsfnnwlghDnowiI5aTxs8SOpTyiFnJlKtIe+hEZzV30kwkZwwh5oatuMwY7a0JaAKG5QFuv7omZ7dOnafLaZKm1xJ2TCF9NFkG39dy//Phl6dyBAQmNjQaFpzqGKdv/E4rVSoKMkMWAU6T/X6c8i3JQxiKICcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294585; c=relaxed/simple;
	bh=aJBZLRK2AtKTR7exY7C4jH9FsFz8pTE7CY5s0ADk6xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgyggPLmCgZxaK84EGD1Ld3Uro8bun3DozZNN9x6MOCpucBrlmEFI9CsSPynLZMYBA2Fs1JDldqjQh+oekbq3NmONFqFsNmTZKPkZB6n54mXNvOJdAUi7KxXW+5VBnq+nn0quJSej2aGdgD4hx1jnTM/w/cxeQIfRZoJ+emU9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3wsnbxQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313a188174fso4480921a91.1;
        Mon, 30 Jun 2025 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751294582; x=1751899382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n69gDXxPGfgIU+wPEIeigImTRma77DzYZ7Ve67R5PNg=;
        b=k3wsnbxQhfH147uPEQ4IpjPytY2Twf66KS3rigfbaodTHKorJ5J55DPj0e+ekgQt+A
         K7WPClQBMuafpx0PxNHFHGxFT+HmYyhDE5Qd8893VGsDhJKYLNULIWDcNBTAnOndyBSj
         9g6g8YMFUYs7Nz98FcYW0CdwMFQeGGzPmpQiwfCNk6ZWb9gSd9dIiBVKdzPckHX6a9dT
         Bxdk7eG+fI9CznJaY0m1NhLUaMeXSW/SThgipnNo9mphh/92Mva/E10ln7d3Zc+Xoo95
         zGrVuZPLrr3JPNJDaPW+T1YIngr+DxxwcBPufQp5f9jbggqT9fPOsJ3lGeBTTmIj+mCC
         i9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294582; x=1751899382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n69gDXxPGfgIU+wPEIeigImTRma77DzYZ7Ve67R5PNg=;
        b=o41L/BiUteQueazmlXqUlPoAoKZ6hgg45OJtMa/irf+9g6D7r5PZL3ZGtr3Oi8Yh+0
         oPQn7Wexj1xv8O03x1T1pdohCqTwVlgUE3ikzHlsU3l98lxNeg3aJozBl4jL6e5kJ3+F
         IbqzODWCP8Jm09+Iz1faGvzvgir4+AfZOljfB6z7/ZDAU6DQlUP23x85ttjO96+LlX5f
         YwGcImDDtnVkBTD99549qqwMUkBPpnQtFLXyxkdJI/KLzXUm+9m63T1obpnsaHi0oKqv
         jRaCB7KpcV+SV8oDsltzqCVPx0WNuaYPlb8v5BVhMqiNaZ5mYASxHL2GgOjyB6u8oxsS
         aIFg==
X-Forwarded-Encrypted: i=1; AJvYcCUMgmlUee0G+nmk51qaudyim6FoDHNPT75t8m3uZ9UTLxdOPu5XAt2d9l8qfaE7vj+Ai3Y=@vger.kernel.org, AJvYcCVHWkbGr8p6wl5Ut8CXMXDUXx2/1Ajft23PYcV9Hdcm97qBiUnrzS6PFM2VJd0YwGkaTUixQ/IT2TMHvkDr@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHXdJj4IshmJ9Ri2AXqNVwGBha8uxG+t0ksRlSHRYajeEmC3j
	T2yjAd1iKyzY4A+sQ5PTf4wtME3VrZ5M1OAwTaGsurwUQuekfd9ObOm8tTe/8Q==
X-Gm-Gg: ASbGncuK53lCazCxAo6wrS7Zb5xEzK7Nb4GG2XuyZutKgcfIs1MjAH7fsd+KSlTCl4P
	syrW0k/2JbcjWyfSRpeyb0cdZWLJi64nwNBKH/H5qvt0wTt7wFgPIMaQ6SO2cHDWdSw6oj2zGiv
	yPOwcLpRYGhUy/JDKRWiiyvww1L7w0d4w2kec6+Ts4Evp25R3mvQTwn+T1c4oBHo2o9RUECif5O
	opuwxBaRpnWSqmhBoVzOah6W6tbRObN4cVgve6D08AWtz3x838lymikNczs00AsBceBdbjp/CHE
	yh97N+C2+4p7GQwqzyk920VmWHL3bQFU/4zdoK9DkJhRTdS5s8ZbRtIjUP7c1J5ted2vzcwX1hv
	V
X-Google-Smtp-Source: AGHT+IEBKjYr3kuohCQjY0CglzvBmQzIq01EIwspNpePjbfFFbP1AgODBoDwnck1jrdGsXqUo51EbA==
X-Received: by 2002:a17:90b:1b0c:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-318c91117a0mr17987244a91.5.1751294582368;
        Mon, 30 Jun 2025 07:43:02 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-318c13a270csm9170017a91.16.2025.06.30.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:43:01 -0700 (PDT)
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
Subject: [PATCH net v2 3/3] virtio-net: use the check_mergeable_len helper
Date: Mon, 30 Jun 2025 21:42:12 +0700
Message-ID: <20250630144212.48471-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630144212.48471-1-minhquangbui99@gmail.com>
References: <20250630144212.48471-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the current repeated code to check received length in mergeable
mode with the new check_mergeable_len helper.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 535a4534c27f..ecd3f46deb5d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2156,7 +2156,6 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 				      struct virtnet_rq_stats *stats)
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
-	unsigned int headroom, tailroom, room;
 	struct skb_shared_info *shinfo;
 	unsigned int xdp_frags_truesz = 0;
 	unsigned int truesize;
@@ -2202,20 +2201,14 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
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
@@ -2429,18 +2422,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
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
@@ -2475,17 +2462,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
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


