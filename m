Return-Path: <bpf+bounces-61542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97509AE8947
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6513B1F18
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C732BDC10;
	Wed, 25 Jun 2025 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MADrJ5TK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA33288CB7;
	Wed, 25 Jun 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867818; cv=none; b=qgZTpKhA2hbSz+yl9iHAygY6i9zZWMA1mwKHY56inC+ebaKZ9twLuRRiKKEiwlOm/lmyWFRsOCwhNexIfw3FxRujNQG/FylORuGSCYFCKuPQ2CeuBBXc/7tpvsezTVThJ/8LDxlgwCCciTaZu3vQI/bDq1cCVLyO7qVVqBzHUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867818; c=relaxed/simple;
	bh=KdpcS/Uk7isYRVWT/mSpfRP2Itl9wHV6KE4tzwxN1hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWbwHKGZv0/jPCH1WnkYeuGTdDJPfZhEgAcodSXH3DRG82mZEtNSYLPpN21YzZlE+sGJ1LDdByxs3FIKFHJcty84VsEZzrDo2O0+8pz4pVKbLNfjjPuufe3BsjpcBc0ZT2NMKJqq1SBn5p2YxadR9XMeHkNPSUEDMBty/JyMQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MADrJ5TK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237311f5a54so634235ad.2;
        Wed, 25 Jun 2025 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867816; x=1751472616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pc1jNIABXFUjdhg20cszbcmMVWTi+ij66dmyNpShB0A=;
        b=MADrJ5TKTnspnpheGxUHh9n5LX11589OPZSZ01PLyPoxjjC8TTVh7h5naI+CyGlRBq
         7zZG8gjhACmUM2iP2E8iiWOfAGeYkcpuHUedekV+wDrfREiOVqOWqfQ8XhaMaNnsokaU
         MytSdvcn94V6050ERzhfFpo65vkKgYmVaJMTvrE+//0LEG03Bx/Jz4G+QlNp+DZ5AFvZ
         dAgnDpZE65KLsKnym/wJHWHdnBORwVSeScO+3OevJhyM5vxBTPwDe1jbMbPBRjMASymX
         /thy+war+IHDxFbTCnJr1zcyhzuvwrBzkF1/vpprDNVl4eDez3HDiw5RE6UdH97Bh4rn
         tTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867816; x=1751472616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pc1jNIABXFUjdhg20cszbcmMVWTi+ij66dmyNpShB0A=;
        b=i5MSi2fDJT7Ncded6j+vMVoAOHcvmAtbxQl06ruSqrbxBJOn3qUaYoDc0RZp5fpAzF
         N0S9yQQqLCr4to87Gcwp2+tPr0QWPTAcPXa6G5xiLZmkR6FVxUOPNyJCUe1g5x4+PQeL
         T0bCqNGcgmae/D21u7L3ZdlLOdXLydUiP9uSufq2VPzM5IEDdk/YrsTlXkwhWiZaEg2q
         CIrQqTdQo/wOgI5HTnH087RAelhe2Xq9Rz2MqsXzBOIf/jE6Dl5b0P8ycFdZAqSfNP1a
         i5LuvLSbpYZ/zToMbkTcHHdG30DVmCOdR5OsNixugynGqwAYdlzlAhWNtQwCZDF++So6
         xh4w==
X-Forwarded-Encrypted: i=1; AJvYcCUSDMjfEDaOLo0+Jk912f027oCArCZjgQGBggxJf6jthGv/I7jUEXC90F1LLEYR8ltj98amfZegaCBK3a2S@vger.kernel.org, AJvYcCX4knt8JeAvKXSBVeoIeU2xHEHaf+LCFD65KIYqxFpBeRxXVJstVzr2Or91eYPoNVkoHJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/d3Hy1ZsBsa5tD0ssXl2QQdt//4L+3Im4TdinCDtbCOQW9RZ
	DBVEp/nxzxQ6nCf9FMjM5K0sFMfpKYGP/uuW+Xv8V9nb7lD8vAQ0LFeM2t6Ecw==
X-Gm-Gg: ASbGncv/IlFUYdwtY+rzjAN0/2uxzlqxZT9B+7mIJqUKcBiPX+1AwGbbyS00GD/0Huv
	O+HzknWEmE4UmEKeltoly+rtymEWBTaUFUcJqgXqxJXr28jXrpL09Bi7bzsKAVxJHx5juBWBunu
	IsaVPwQRvwtORvECHtD3n/CnFjKlV0zub0tFuKa7IwZ3yfEvaam35wTCN48vtqxeWBy1hIvnPJ4
	R88f9xohYsMVpwTpK72SEMQxA1E4E8NH/K7myw4HsZqIYe6mLKSM/7MhEi4jUhb9Foh5n6/XmoK
	SbUmFDGuvMZrSaXgPzjGXjJz3du431U7y3iOAw9ZPnLBXFsHvDyqww7Eaijn/4ZdyFqSqm1orIW
	7BtABCxWzj/5M
X-Google-Smtp-Source: AGHT+IG/+p4FHGoe27JAVTRBEQ4H98Gv/PlWKAyUxkOvHplkB2K8gJQfwSJufTq2+AlYaxWELoKFHg==
X-Received: by 2002:a17:902:da8b:b0:235:efbb:9539 with SMTP id d9443c01a7336-23823fd7640mr75866245ad.17.1750867815986;
        Wed, 25 Jun 2025 09:10:15 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1cf0:45c2:bdd1:b92d])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-237d873845esm143219175ad.243.2025.06.25.09.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:10:14 -0700 (PDT)
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
Subject: [PATCH net 1/4] virtio-net: ensure the received length does not exceed allocated size
Date: Wed, 25 Jun 2025 23:08:46 +0700
Message-ID: <20250625160849.61344-2-minhquangbui99@gmail.com>
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

In xdp_linearize_page, when reading the following buffers from the ring,
we forget to check the received length with the true allocate size. This
can lead to an out-of-bound read. This commit adds that missing check.

Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..2a130a3e50ac 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1797,7 +1797,8 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
  * across multiple buffers (num_buf > 1), and we make sure buffers
  * have enough headroom.
  */
-static struct page *xdp_linearize_page(struct receive_queue *rq,
+static struct page *xdp_linearize_page(struct net_device *dev,
+				       struct receive_queue *rq,
 				       int *num_buf,
 				       struct page *p,
 				       int offset,
@@ -1818,17 +1819,33 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
 	page_off += *len;
 
 	while (--*num_buf) {
-		unsigned int buflen;
+		unsigned int headroom, tailroom, room;
+		unsigned int truesize, buflen;
 		void *buf;
+		void *ctx;
 		int off;
 
-		buf = virtnet_rq_get_buf(rq, &buflen, NULL);
+		buf = virtnet_rq_get_buf(rq, &buflen, &ctx);
 		if (unlikely(!buf))
 			goto err_buf;
 
 		p = virt_to_head_page(buf);
 		off = buf - page_address(p);
 
+		truesize = mergeable_ctx_to_truesize(ctx);
+		headroom = mergeable_ctx_to_headroom(ctx);
+		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
+		room = SKB_DATA_ALIGN(headroom + tailroom);
+
+		if (unlikely(buflen > truesize - room)) {
+			put_page(p);
+			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
+				 dev->name, buflen,
+				 (unsigned long)(truesize - room));
+			DEV_STATS_INC(dev, rx_length_errors);
+			goto err_buf;
+		}
+
 		/* guard against a misconfigured or uncooperative backend that
 		 * is sending packet larger than the MTU.
 		 */
@@ -1917,7 +1934,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		headroom = vi->hdr_len + header_offset;
 		buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-		xdp_page = xdp_linearize_page(rq, &num_buf, page,
+		xdp_page = xdp_linearize_page(dev, rq, &num_buf, page,
 					      offset, header_offset,
 					      &tlen);
 		if (!xdp_page)
@@ -2252,7 +2269,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
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


