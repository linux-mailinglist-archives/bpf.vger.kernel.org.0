Return-Path: <bpf+bounces-61834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4725FAEE14E
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF377188588D
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098F228FAB5;
	Mon, 30 Jun 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/KgzVaY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAA28E5F3;
	Mon, 30 Jun 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294572; cv=none; b=A9pEiYj4MzcSEZfObiCQUh/uSujNQ4gnyk93Tmeg563DmV+4fzoP4KoVFb7CEJqKUIzaYl8sp8hp9QKl3eBBUfk29oYBNphH07wv6CJGUSqb+Kvfl6wzAZacOqr4UgOgnJQO6PKuR+QGMstonS2QkdqDu7GMQgubVewr6N1lxtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294572; c=relaxed/simple;
	bh=yXGAI8fsp9QAmSJK3IamseOR28dXJb3MxGrhuL4c8hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDE7j1pxrFQpeBh9dNeLqK5aUGCcgEIXB0ta3pLwgEwO8r54NjuoXyNQ6EKW5AI2Ag1F85jXkK2EyeBSYBS3w+tAaJ6+YKG/YWGUdXJqMnrhgBVd5Lsiic2ZhaEJ7YC9JVr7lw3u9Qym7lruhPizPFgYd5A0DqgJvVKIO0V1pIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/KgzVaY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313154270bbso2129675a91.2;
        Mon, 30 Jun 2025 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751294570; x=1751899370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TatuTvD/KRI25aZVKetSkdRBKo49t17GGxSNN77vHt4=;
        b=k/KgzVaYC5/wDF7IKDPIk2ygBCdaqI8o+f9izu0GcP7E5UKi13a8GBNfILMUfYGbQO
         2iCb3i0JbcNcodQ8WynF6f1CKHT8gTY49XvON2A8tqMilqr0fubAi10jZNJCbDM+pv9M
         vBflnmfdusiDjez1oEsO8kXHc/5Ul+5qkOvQdLLv7alL0AhYGLMSJ5+Tz1Blns8OblE6
         ueO+kfpqakKGbIa8E+lsdVboglV0gNne6/vCR3n2EHSodz7Kx9nLrwARvU9Q0Xqz+y5d
         soP31ThEGD36AMawpA7BR+69vCW2YSL4sE2qH+jAbNs2/4/hIKQZObSIWJanpQreQSZX
         wiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294570; x=1751899370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TatuTvD/KRI25aZVKetSkdRBKo49t17GGxSNN77vHt4=;
        b=DGJd7rQX7MJEAdBgYxj+ne/kKhDDUlSU62nHHhhLahL8CDQ+PcyiEy/+ZrlV/PxAz8
         X2+FCg2esiw4RSAOmSQKlMew6V+ywTvSnOyn9ct0idHu8CrZ+1KL0aqBV/VP0j2NWqJL
         1kHA2ZAAb4+aGj79mY1Nmr6Ymur4hLf8pvbbaCt0keNUF+E1WGuhoq221KC5NV0MQ8Bi
         eNDrBnrXsKEX2eN8Zs3YY7afYY4hGTgrdzujBa00aJPuXZIsX067JWkJXMjJsMOxfJzW
         r9GTuPVMAO4QefUP9T+UseM5BH79YaLbtvWTDd8ulf8L8HjpOVynC8Jeeo2452b/UQTx
         yDcw==
X-Forwarded-Encrypted: i=1; AJvYcCUuJ5KU6A18JY+Op6rwBzVkyVsd2+uF4c/MQ6DAZ+dg0KqgfAMOaALpG2XFrjDuKJTClk3w7Me0Y8X8bbQq@vger.kernel.org, AJvYcCW7DxVmHQmIh9dqvAP+XkSIHS78WxYrLNXD/GQPq3CFE+y/7Jpx/xixeqtOTNiTvmTVa34=@vger.kernel.org, AJvYcCWLlJbREvyyOQI5xbGPuMvKA1Tmw691PbR/yZXumL7cMqC8rWgTgbQxmkV56VDMDqkEXwTqbBEp@vger.kernel.org
X-Gm-Message-State: AOJu0YxNesvRxNxaBiHCHO2LCLFkN0CTBwpJcliEzv7EbqN2JPMqtTuR
	bQLSYG6Lu1DlWR+gJT08DgbJHIYf7lr9qExtRVzuz+Pz7cn2We/0mvp0jLsQCw==
X-Gm-Gg: ASbGnctQjqKBWDC7QeT5f1aS0/gCD02nmMt6fRqyew91c5xrs/QKmdWmscNTCO2lT0+
	kCpln1Z21sLcI6W5bpW27UGJ5+BMmFWNvqnNM8pjnv6xL2sIjmivNaSaTB986aCXToJZyLutD9p
	5vamjBckb4xNxV/tolqeI1WdVhXd263jTduVY1mPrN+r6kJyFhPSMo1U+yNEyVWQXoJJ1ulW4MA
	BQCMuT3bUlUmPvvKZ6zE8EHEDsarz6n1JGtBpEPXk/N/sZO815HdA0AI6Y0g5szKK9BgcnP3TKk
	gXe8XEcy4O3g43T4XfpS7yxigU5J9gbCa5z2lWMTpv2r9HYp76KczGj9mprElMAOhRMpA6wC1DB
	6
X-Google-Smtp-Source: AGHT+IETLZuBDgN03KgQWXJ9JG6CGzKwn4TSRbQqf09y4q790qyn1wuwU+dXImOnss1ZphjmrXsFHQ==
X-Received: by 2002:a17:90b:5445:b0:311:c970:c9c0 with SMTP id 98e67ed59e1d1-318c9243c49mr16601470a91.22.1751294569638;
        Mon, 30 Jun 2025 07:42:49 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-318c13a270csm9170017a91.16.2025.06.30.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:42:49 -0700 (PDT)
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
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/3] virtio-net: ensure the received length does not exceed allocated size
Date: Mon, 30 Jun 2025 21:42:10 +0700
Message-ID: <20250630144212.48471-2-minhquangbui99@gmail.com>
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

In xdp_linearize_page, when reading the following buffers from the ring,
we forget to check the received length with the true allocate size. This
can lead to an out-of-bound read. This commit adds that missing check.

Cc: <stable@vger.kernel.org>
Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..31661bcb3932 100644
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
@@ -1797,7 +1817,8 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
  * across multiple buffers (num_buf > 1), and we make sure buffers
  * have enough headroom.
  */
-static struct page *xdp_linearize_page(struct receive_queue *rq,
+static struct page *xdp_linearize_page(struct net_device *dev,
+				       struct receive_queue *rq,
 				       int *num_buf,
 				       struct page *p,
 				       int offset,
@@ -1817,18 +1838,27 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
 	memcpy(page_address(page) + page_off, page_address(p) + offset, *len);
 	page_off += *len;
 
+	/* Only mergeable mode can go inside this while loop. In small mode,
+	 * *num_buf == 1, so it cannot go inside.
+	 */
 	while (--*num_buf) {
 		unsigned int buflen;
 		void *buf;
+		void *ctx;
 		int off;
 
-		buf = virtnet_rq_get_buf(rq, &buflen, NULL);
+		buf = virtnet_rq_get_buf(rq, &buflen, &ctx);
 		if (unlikely(!buf))
 			goto err_buf;
 
 		p = virt_to_head_page(buf);
 		off = buf - page_address(p);
 
+		if (check_mergeable_len(dev, ctx, buflen)) {
+			put_page(p);
+			goto err_buf;
+		}
+
 		/* guard against a misconfigured or uncooperative backend that
 		 * is sending packet larger than the MTU.
 		 */
@@ -1917,7 +1947,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		headroom = vi->hdr_len + header_offset;
 		buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-		xdp_page = xdp_linearize_page(rq, &num_buf, page,
+		xdp_page = xdp_linearize_page(dev, rq, &num_buf, page,
 					      offset, header_offset,
 					      &tlen);
 		if (!xdp_page)
@@ -2252,7 +2282,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 	 */
 	if (!xdp_prog->aux->xdp_has_frags) {
 		/* linearize data for XDP */
-		xdp_page = xdp_linearize_page(rq, num_buf,
+		xdp_page = xdp_linearize_page(vi->dev, rq, num_buf,
 					      *page, offset,
 					      XDP_PACKET_HEADROOM,
 					      len);
-- 
2.43.0


