Return-Path: <bpf+bounces-61545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9041BAE8954
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36707189653C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E48817A318;
	Wed, 25 Jun 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EstgvQjE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5052BDC3F;
	Wed, 25 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867842; cv=none; b=G+vAKdZtFDWqiqe4TqmbsnFsd/avVqIcWB8fOOyrekf4HUEVpXRxZ67O9julRB/evw+PL38w0SW4RTgm3KgOE3HsTSjYoDB1cKjffDVENmYKucsQ+oyrJkja+vsikYFBJMKnjavOmbtoyABFFlJ7ueB3oLge1PBgTn3kZUBSg5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867842; c=relaxed/simple;
	bh=ZvqfaDM3961shpPhB0QWB5bEV3krPacm7GyvkiFlYMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ifg1xk0Z6iiI+fu0MTt32V6WnuFj7nfcpAJjs+aBXTpn6zStnUjapqXD1NSnB/XMENHqJQIEj3F0oRJhxRf8t9JynsnNadKMtQrRkrM+ohlE2LLUSX2bLCpD3SMIdYkpXPykukYDUie9fbUfrrlq04KBo5aWu5jYd12dyEpRx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EstgvQjE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23636167afeso765105ad.3;
        Wed, 25 Jun 2025 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867839; x=1751472639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MTOim0bI+o2eKzB/GRE0kdcUWqcDv8nQxQv5pqAodc=;
        b=EstgvQjE+EYSv4jC3myCZLpHWtozN1OKMwnmCDEAsc5OlAn+tBzpeJ84EgWn1sQDNo
         v1x4ZsOk5Okfuy323T0TFAXT43gAy3wFsFLZ5iuKT6kWiGdfDU0acae5xi9P1+/P5/HF
         Lslg96maOu4x7FskQorbfq3O1ZrB8wHMWCe25VIQDXMzgGIYjdJtXcjSdeqSYghHwBgW
         yD/4UtagdTKC6r3qkrc3Fhz3qlYEojyaVMnx0loI3LxvEoyhkumfvFloOlHi7WHfHz8+
         S7oSWE+bN5IghlDdfUxEgN18NgyiUiR1eARZcz13o1lj1e3oiNQ5ePOjW+HCqOWxGBko
         8ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867839; x=1751472639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MTOim0bI+o2eKzB/GRE0kdcUWqcDv8nQxQv5pqAodc=;
        b=hjMC9VkXlPRNNFCVKWY4YIuC5Zer/WXFxdValIA07TjZNG4HVTgmo6i9R38u0mZMBx
         yc1c1alE8jNUxSWGuVBgfHLbgGZIOuXrFh9IHYAW2UrDzGUPkIs21udK1XmJkFWwgqLa
         u4HSIvqL9BZOyKlhD4DUhx8n185z7nrEXok2qLfqkAvPr5u6p61vVDnFNC9MyX2L4evG
         4u0yJakXQ+mJ7nfFLjYIH3aPma+W3zdPj6uNG9dBmL6v/pBMqH/Dtvo/OcT+xxkdQIvi
         tqoPlgsx8oKP8XN5VfAD/o2fdEOEraYxV/TwVtIOAfNIkOovuyMgPazUiJNQ5xuLcqqf
         WDxw==
X-Forwarded-Encrypted: i=1; AJvYcCU38cDg746nscnmoYcwhnMpAUsGQJ9Bpr6bYfOhl2N3v8cbkxHjZ45kgfO5Egs9ZAAh6npkqacN4kCPeyMa@vger.kernel.org, AJvYcCWJVwdEHPr1sxK5o6cUeryGsfufivg+4ST1WO8Gu4a39fY9rF6bmrzfvZ/vAzehqAwFg98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pahVLjvt2OFrFCnp1sNOpmDt1zYNg0jqWtLCoKPkf+Q00ByZ
	iztTcoYuVlRL3bICkDaRx4KS9c6UVS8zthkxPCd81vogzi3UulPdeOUUFADSvQ==
X-Gm-Gg: ASbGncs5LHSeoRDL2dpM5TQL2qvly1HEiBOwOi9Bb/3+C2ZmMcDoWSXRgb/gGz4I5qW
	5cGL2Aq2WPYUGwjkzk1OIW96r1JgXezS1NIvzC+dbbYUbR9RKwP7GtuskTBxThvRxHl6kl72mbz
	WqfNFeYmp4ACBs5rf/7mvrGlZJlLgYsGKMwtaD4tNGfIZHuazskaJPi3CP7ggNHWSazIjftbr6O
	+TS6u6NHUnzb3FbS3cl8QwFLcrM0g4SD8XUoaZgw6B/uJssllEt6rpbSYzGm8CxeK6D2C3mrQKb
	HrykicEucxs7Bak6TOlZBVxo8O52byjvWbwFzqq1GR41GaFIbmBXRpRLIQed8IshLZaYzyi0OMV
	xSA==
X-Google-Smtp-Source: AGHT+IFpH0ZhFM1LT/le3DUpl/1q/Q6WJthAozRqmYPKj6YzBEcv9GZLE7JYOv+loHFwm0tdUStuWw==
X-Received: by 2002:a17:903:1a4e:b0:234:c549:d9f1 with SMTP id d9443c01a7336-23824086ea1mr55865985ad.47.1750867839525;
        Wed, 25 Jun 2025 09:10:39 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1cf0:45c2:bdd1:b92d])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-237d873845esm143219175ad.243.2025.06.25.09.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:10:38 -0700 (PDT)
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
Subject: [PATCH net 4/4] virtio-net: allow more allocated space for mergeable XDP
Date: Wed, 25 Jun 2025 23:08:49 +0700
Message-ID: <20250625160849.61344-5-minhquangbui99@gmail.com>
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

When the mergeable receive buffer is prefilled before XDP is set, it
does not reserve the space for XDP_PACKET_HEADROOM and skb_shared_info.
So when XDP is set and this buffer is used to receive frame, we need to
create a new buffer with reserved headroom, tailroom and copy the frame
data over. Currently, the new buffer's size is restricted to PAGE_SIZE
only. If the frame data's length + headroom + tailroom exceeds
PAGE_SIZE, the frame is dropped.

However, it seems like there is no restriction on the total size in XDP.
So we can just increase the size of new buffer to 2 * PAGE_SIZE in that
case and continue to process the frame.

In my opinion, the current drop behavior is fine and expected so this
commit is just an improvement not a bug fix.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 844cb2a78be0..663cec686045 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2277,13 +2277,26 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 					      len);
 		if (!xdp_page)
 			return NULL;
+
+		*frame_sz = PAGE_SIZE;
 	} else {
+		unsigned int total_len;
+
 		xdp_room = SKB_DATA_ALIGN(XDP_PACKET_HEADROOM +
 					  sizeof(struct skb_shared_info));
-		if (*len + xdp_room > PAGE_SIZE)
+		total_len = *len + xdp_room;
+
+		/* This must never happen because len cannot exceed PAGE_SIZE */
+		if (unlikely(total_len > 2 * PAGE_SIZE))
 			return NULL;
 
-		xdp_page = alloc_page(GFP_ATOMIC);
+		if (total_len > PAGE_SIZE) {
+			xdp_page = alloc_pages(GFP_ATOMIC, 1);
+			*frame_sz = 2 * PAGE_SIZE;
+		} else {
+			xdp_page = alloc_page(GFP_ATOMIC);
+			*frame_sz = PAGE_SIZE;
+		}
 		if (!xdp_page)
 			return NULL;
 
@@ -2291,8 +2304,6 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 		       page_address(*page) + offset, *len);
 	}
 
-	*frame_sz = PAGE_SIZE;
-
 	put_page(*page);
 
 	*page = xdp_page;
-- 
2.43.0


