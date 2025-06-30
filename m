Return-Path: <bpf+bounces-61835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD90AEE153
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B4B188692B
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87765290BA2;
	Mon, 30 Jun 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqsTFAst"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616928E5F3;
	Mon, 30 Jun 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294578; cv=none; b=FyDUqEW8IGTmix0Z1XZJW/3B1y8n0OqnXjlz6RT+pPUQ/ftwPHzW73m3W4diRWiX3/hD2uAy+kzQ4173SC+LA+X19XZpGbCYuO/9kRRHDvk55TCCLjp+xNg6OXpumAmnOdECpNjrdSGScTnV5/wZHazgVAqSaLOKAzgIGdH7Bv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294578; c=relaxed/simple;
	bh=BSZ5vT3FSMrvM5IrsoJDnsX7sNGVr+Y34WTBiYQdwUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGDJU+W7zE9c2d1prUft3QW6cr/VsOFfFHOETWdRvXZRu0Gm93KsOyTwr1r0Ou8p5YsKP//U1+oPejwY1mjfXNKq77cEZXbQ66WOgNejh2iBvL7QRhhuYoripWHjKqnA2AiNy42nQjPhYcn9dPz3IXtTFqj/fh9GJVBSGR+zKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqsTFAst; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167b30so17800465ad.1;
        Mon, 30 Jun 2025 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751294575; x=1751899375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLmL/hbSV60WQ5txcK/zp8yoe+ubCK5iYtglAmsrLSE=;
        b=VqsTFAstirc2FUxDnAUxU2kJksb1QqFkTMO0L8XXINGfUkVukIWXE0i/4Z5I6Y+jM6
         52O6o5KktskoczysvnFOXHpOAuPmK2u1RZ9ZxHdZr7SVL+kBLPZZauXEl31Pzl8xEuNc
         CKJLlO+paztSs0MNlEV9RV9ykoyMfXMOooGOag43K7a2g/Eleg64Oc7kp4wJBQtgceZN
         QGNSvP8u1MMJoz0WlTg/su/SCDwNPmmhFkv8ps/CXSCDKJRj4L48GZVlUDKGmB3m5ASn
         wfvs7IBe0yLimlrzDhvd3/EaAJhMQUVEb0T9odOadHQiYTPJeAcjGaCfEI80HiBCYEVm
         B3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294575; x=1751899375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLmL/hbSV60WQ5txcK/zp8yoe+ubCK5iYtglAmsrLSE=;
        b=mfWe3FBOHmQI4+HbsRWZDyunvIGHTeMkL5OZa9buUtpNQVlM1ZapkkrHGBCzpvI1uS
         mTcKmn/XQOxDhc9mE4IWpNhsqRxaFRrhU+KBmiL3Z0oNpDh9+cXGLyEc6HI0G/CiyhgD
         k/1zUGal1htlZj9h6TQpk3AmpJqDqSx0AfEz2+DRy+Kt0SLjhlZTj+dqzDoHPSyO1Ix3
         jfxpxCVc9W2bKzbdmMey0xpa8CHwn06ktQB8KaZA6Aid7/iO+mfGE2g/edEabexRj0TO
         X0OCWTfqxVUApu1RK+iJ17+Jf8S4j1zLJhlCUIB56JYu7vIOBouZakO3EvhuS1CHS9mt
         jxbA==
X-Forwarded-Encrypted: i=1; AJvYcCUCETNfcV0s2f8JQ2Z4VJ1QfTacmwZ3fGE8JkcPk0AQaTul247JX7VxBEVapehmvhgeLIObwgT+0UiTFl1d@vger.kernel.org, AJvYcCVMakvbs6uC7mD6FpTKwNWdzmmK3BU9soqA3Yo4W0ulri/F7yowsRoYC5+u06FidvmIdcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaCCY5UEus1GK4WHhiOaop7WXtnXBet3F00alXJodcYS5qXSb
	Z1xdpzLQ/l8LCML9Mbvly7zJvCYK7+iZJp8UrdFNooAjpcnJ3i5JJP3NmMDHGw==
X-Gm-Gg: ASbGncudoob+xWZGXqNmr9eMh2p/HaEBf2A8ty6fRtNyLCr8mxLfDmYYB6yBd4dMOKK
	/cNI1Zafl7PPfaNoOh0qjUYnc1zIrjFz7W72iHKqSgZ+CJ37MQPfkuB07fHoihg7MOVTWgfCzB/
	GU+qX3woAk9cQrpILGpXGFjJ9EVyERN8PZxeFZIu9PrVc97+9n0CZQGZMseTps36276yp4jerHU
	6V5z3Q/x8pffxmvrq1kD63OeVEwZ1T8YUVkv/8XTjpS0ItL9tfW3Q57JINzRWexyxf8iBoPElSZ
	BjYo4MtSC65Dwq05TxjloSJbsWej5m93bcPUy5EGzLWM16DlDhBx3N0i+DY6+PlvowG90JyB3W1
	E
X-Google-Smtp-Source: AGHT+IFYuZr8i/s3T0h77aKO3ys5BfKYJLS5aKf0P+CB6IP+gtk0942n8ugs4IGHLFscQ/B6DDNpGw==
X-Received: by 2002:a17:90b:3b82:b0:315:c77b:37d6 with SMTP id 98e67ed59e1d1-318c92ef8e1mr17269051a91.23.1751294575415;
        Mon, 30 Jun 2025 07:42:55 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-318c13a270csm9170017a91.16.2025.06.30.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:42:55 -0700 (PDT)
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
Subject: [PATCH net v2 2/3] virtio-net: remove redundant truesize check with PAGE_SIZE
Date: Mon, 30 Jun 2025 21:42:11 +0700
Message-ID: <20250630144212.48471-3-minhquangbui99@gmail.com>
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

The truesize is guaranteed not to exceed PAGE_SIZE in
get_mergeable_buf_len(). It is saved in mergeable context, which is not
changeable by the host side, so the check in receive path is quite
redundant.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 31661bcb3932..535a4534c27f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2157,9 +2157,9 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
 	unsigned int headroom, tailroom, room;
-	unsigned int truesize, cur_frag_size;
 	struct skb_shared_info *shinfo;
 	unsigned int xdp_frags_truesz = 0;
+	unsigned int truesize;
 	struct page *page;
 	skb_frag_t *frag;
 	int offset;
@@ -2207,9 +2207,8 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
 		room = SKB_DATA_ALIGN(headroom + tailroom);
 
-		cur_frag_size = truesize;
-		xdp_frags_truesz += cur_frag_size;
-		if (unlikely(len > truesize - room || cur_frag_size > PAGE_SIZE)) {
+		xdp_frags_truesz += truesize;
+		if (unlikely(len > truesize - room)) {
 			put_page(page);
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
-- 
2.43.0


