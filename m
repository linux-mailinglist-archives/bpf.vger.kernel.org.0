Return-Path: <bpf+bounces-61234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384EAAE299D
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FB33B8775
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA432185B1;
	Sat, 21 Jun 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4qBwOgA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790FA182D0;
	Sat, 21 Jun 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517498; cv=none; b=Z2aBvun6ZY5ihUfbswZwHvg/dqAPckQoFw0RpX6QFoTeUpenUznPF8Eh6CWg/9j1oswsNIF9Fm7PjjZKZ27gBZ63PDUXICg8gohXj/7M1YTO3o0ypoxQ4R4J5EFr+0TIVaCmHOFzv2Jm3lTeQHGRvuNFNMQ7dR7Gq8M8Z/ElJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517498; c=relaxed/simple;
	bh=VDC/H4qxrgNISEN09Sz7jFYSr9ya7/eF+9EuVS1vC2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvlzTdLj2k/YW8klvws794kqR1FQ/rb0jpQXoBw7H0H6XZmJSSNM8RZs4hCb8Wlk3J0NAoYrxa+2uePtrbP47EzJ/j93NjxJKgwfjbEaw2K3GWEu0L8AjGUnKBjId2aLJZyX7mkFoHbvVp9Q4uokYGeVXBOfQS6jQf53qD04YIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4qBwOgA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-749248d06faso429045b3a.2;
        Sat, 21 Jun 2025 07:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750517496; x=1751122296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsT1ZEXEOUtY1kEret+DIBmKa+OK0aPjmFKUZJqZ22A=;
        b=l4qBwOgAAHeneMx+QxfHef+t9FYq4nM6PlxzYBcO7SVL+BRmmnc0SNdu77h/phNw33
         I9DHxwmNaTWaOsuSKaaOg2jVH1//tOBPd90bcidSFOX0ARI9baWwBZ7TD0Gn/m8e1xbE
         ZwgucNmISj6ZFgLC9KjYRadD4vg/XQ91eONuksl5l3uFQgIti1TBK4GobqkfdAuRMsW3
         Pmq8kW50ZFD1PXqgX6N7M5eefnTZ5TdiHsi2qGxMk4JsL0wm5XkxkGl7SUErmJcp8TTL
         0zoPkiqd2ZkmfkXKsmge3VJXJJLkVbJH+rDv+UWodY0vs2xcXsgtig8xM+lrRVJoBDbh
         WBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750517496; x=1751122296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsT1ZEXEOUtY1kEret+DIBmKa+OK0aPjmFKUZJqZ22A=;
        b=Zxbx/Ec+Y+yXexQqgenTaTRaj8WwACJmNSERf3fFwuqc0KIR7OOnxn3mlJdpwDsAoA
         SqPdZOkMsqYpQX5Vrx/k9/jh3r/2G5r9ywcmjQcqHJvIQbpxTrYo+YFJ8BBMKx1u22+m
         bJ5xdYrAx6UUSzqvow2kaEvNNHJWxz2r2qwKwjc72Rsz3f2Vr9nigKXUuvwTplwA3t7a
         vqLQIrTSni6Op6vPZxDMR3MdZsUr6L78bvM2LEsIat6e8ayJFKSlW2b0SVJZHuGX1ZQ9
         snQg/MZl8BCE9Q07RqWkkQhXqLDjy4Y+O02C2xTQORylIdTJTcJhhrIVBdIsx3zA96nD
         i2Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUqJ+sEHCS7g1VybNkRGtb5gl2rQCRV5hIdDiyj3xNzNQxlASLXJBErmMiJhvAnZATJVJ1xYqa2p9jD2U+2@vger.kernel.org, AJvYcCV78C3R9ovXZiEK2p1a7HwBGBJCemoWXlIpvLZjYzAOdzkmPno1slqgPvFDOT/va2UdDSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EDfCxRx/INrOMeThKn3ZW+Q/f+jUMSdmnSQhvWumm9HsJYXm
	SbNzL4gsffPnvHXNaLYLtYVZ58de9IE1QPDgfem3UtyuDClTvCDUDJBnowdi2+mr
X-Gm-Gg: ASbGncvKoQLc09/dCXV8APZ/s012Rby1JenKLv6AOWthsgmD/NbcE7ikp9YDQMDHaWB
	c6g49uqlwWhOWpCsHOyXMKs2QPyD3w8b/QG6RGAAcM7LG4INefFLpg+PF8rrSjijcOfWuvI1+iz
	Kx+Rgh9VzGeYuGqYabo3apdAU0FJBIIA5C2YQ/umRXJifyGl5bV/zDLFRqrqExlXgb1aty1GnLl
	DFHZThi1S9caudxa9JpZX7sA97r89YTKRIN+XAK9+YC7GuEE7UNjZS7czL9G1btjtrPZwhUwp3C
	VaGuH3+g+sTjxTt3Qvp4ZN0502VvlWfnUdWQJzXrKpl0qOkyIP/4jlu2FYuQwMhm4Dy5DjVYFrM
	VJw==
X-Google-Smtp-Source: AGHT+IGDRfF/7GW0dG2asaXRVeS7I9SgZa3EowVkxZsXFjdDSpZWb6U65gMCd7WwyOg7LN/dQrCCAg==
X-Received: by 2002:a05:6a00:4612:b0:746:3040:4da2 with SMTP id d2e1a72fcca58-7490d51ba3emr10478119b3a.8.1750517496374;
        Sat, 21 Jun 2025 07:51:36 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:fea9:d2f2:6451:ed3b])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7490a46acf4sm4493490b3a.11.2025.06.21.07.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 07:51:35 -0700 (PDT)
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
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2 2/2] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
Date: Sat, 21 Jun 2025 21:49:52 +0700
Message-ID: <20250621144952.32469-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621144952.32469-1-minhquangbui99@gmail.com>
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit does not do any functional changes. It moves xdp->data
adjustment for buffer other than first buffer to buf_to_xdp() helper so
that the xdp_buff adjustment does not scatter over different functions.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1eb237cd5d0b..4e942ea1bfa3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1159,7 +1159,19 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
 		return NULL;
 	}
 
-	xsk_buff_set_size(xdp, len);
+	if (first_buf) {
+		xsk_buff_set_size(xdp, len);
+	} else {
+		/* This is the same as xsk_buff_set_size but with the adjusted
+		 * xdp->data.
+		 */
+		xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
+		xdp->data -= vi->hdr_len;
+		xdp->data_meta = xdp->data;
+		xdp->data_end = xdp->data + len;
+		xdp->flags = 0;
+	}
+
 	xsk_buff_dma_sync_for_cpu(xdp);
 
 	return xdp;
@@ -1284,7 +1296,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 			goto err;
 		}
 
-		memcpy(buf, xdp->data - vi->hdr_len, len);
+		memcpy(buf, xdp->data, len);
 
 		xsk_buff_free(xdp);
 
-- 
2.43.0


