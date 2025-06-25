Return-Path: <bpf+bounces-61543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2710DAE894C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A171BC2E92
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEFD2D1907;
	Wed, 25 Jun 2025 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy+NoLn+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E582BEC2D;
	Wed, 25 Jun 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867829; cv=none; b=sOnsb54RFOM7eZNc0Ra8HZ744fnvz/kbZuwFvDcsKX5zD80fpBG0zh6YxLAzQ6ODFh79d1iHe/C1Q2+iqSfh1zuMtFz+/VNsi0d/kpq9J9aR57r7K9EDWgnE8MqqEjWQlzD/ZkGmGPvMgKb1LyLBFvptsDZSgGII894YY8OVkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867829; c=relaxed/simple;
	bh=0sJ8AeOBtujsSHHSnnt99pZ3s4tdzAw+C4OWiCGVWno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRJjabRDncLRYTxSckqYEIHrxe0Iw2ejVN7Mzy4EThMsjTsMjQFOaoLAQcP+6IzyE18X7MuI6DCVZsgTLLKPaXQ3NoI7UOhAeUlaDbe1hzokyL8bLGo63lV37agLOcnJWDXA1TvWG86MpVrmOlmSBAyaDdAjkpRAUl9MV9dQtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dy+NoLn+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234b440afa7so723185ad.0;
        Wed, 25 Jun 2025 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867827; x=1751472627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmQ7iHayqhhe6CdrM/SyPC+bVPoeFePLL7uHhJ+6594=;
        b=Dy+NoLn+94mErGq7qhcbDA701ALDJa6eM3ZTmMYWTG4Ey4XwlDryYDExbYj2dz//Cr
         XW+dzn1gJ0nyXLr8KOAJNVQ46WZNWPL7kG7qj6lT46jKgs9kzzEjyvgv20932E94XrPR
         BMFSkYj8yyad4CEITtiT9PA+N38Hlp+Nz/sq695j+ETJAtCkeMHX5b/Pre+qZLYSMOA8
         CrWqRk69NRm4ALJtvaOB3F8gGezMNZxn4sJ+NjW9fSphfPeP/lkcfKd5b875py2nOEC7
         ujYFpDoallj89lFj7Hj2Sm2BbwvQkpCvZWkKJTSr1UE4jwQb7rYpLxZpkGvL9d2fkSUY
         xzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867827; x=1751472627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmQ7iHayqhhe6CdrM/SyPC+bVPoeFePLL7uHhJ+6594=;
        b=MlX50jwvUlSOzQsmKZysH3xoicc4GwWJ0Viy2cnLBpolbVjEa7OZ9Isj5W0UZgDiZg
         HvdNBHqdZl+maLATxuwPFxlw+RW4IDm2bH9ETRs295zk8vmivOk2h7Q9ksXGTRCZvI2R
         Y5GxqvgICJMXZ81OZ1q1hrH6LJJUklkZjArTJve84RxNDwanfISwYXdFoAxAA7zkjvJl
         gqAYnlG0Bj483ZWRSIeJWyxY/3c2OjHXanTbavuqG7RG6X3VXMXpEMNnjMUTRSm1wasb
         T87i26Q7TvNZ/l9b/ESB5EClbuH+5UhfZaz+ELninK9Kq+s9+4pRKyhlT7LDXvzFd6gp
         xXaA==
X-Forwarded-Encrypted: i=1; AJvYcCUoKnMTaCOZsmajS+4ZrVOlCVHSZdPD+Uge8AEdk508xG2DWtoxR0xuIctr7gQI0CFg286Y+KQS4M/x8Qdr@vger.kernel.org, AJvYcCVK4UNYNKklrVWxVC1FrXeyKztppQxFnoycPsVT9gIN2DtXX22DKg6QrGzdkucmndb/gHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYu9otGPJZlByOeBSeZDLi7dQ0UTrwXyg40HSFgfKIgvIT6u/
	s+/kWadICUgoktQr/Lf6AmfwjtDoOEE71EL2W14uuphjHQO7e8NI1ahxFxmICA==
X-Gm-Gg: ASbGncsXtnAPRFD3L3SfemdoF+y2Y8GM6hV3zmYrtuNbwt3hDNefv+snffFWw0kQnMC
	f4ZTWF6Khe9pWFZrNipEVvLz/9K34Z/jA+n4R7BXGwJpGMWUdyFgvMM0bnNSej6gMyl0yVvcqYE
	I8FfZlLeYajG+SykhofZAgNsmyYgHWFdyOfGesxekhIJ56Lmwq1R79lT1XCcaNk1M4qonVKcaKc
	fMHm4ZPZXgRkY+9djH9o+kD+IqjFPNy54whV/KUfiXXMuFapcSN9CaS0VseSH/5v1veLJCfKUDq
	fBuYwe5+Z77bmklz8F18kf7cKtksgTAU19dEe/xnqFpGXALb95uPzQwaUe/117KJqVo5uZ3AwwG
	uBQ==
X-Google-Smtp-Source: AGHT+IHZco/gamSdqfqByRJ3U6FIbuRY9/AJtMaXeQeuyElS4WMZmBKDToEdDl1TnVC6imwFD7vuIQ==
X-Received: by 2002:a17:902:d58f:b0:234:cb4a:bc48 with SMTP id d9443c01a7336-23824030cfamr69817065ad.31.1750867826672;
        Wed, 25 Jun 2025 09:10:26 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1cf0:45c2:bdd1:b92d])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-237d873845esm143219175ad.243.2025.06.25.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:10:23 -0700 (PDT)
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
Subject: [PATCH net 2/4] virtio-net: remove redundant truesize check with PAGE_SIZE
Date: Wed, 25 Jun 2025 23:08:47 +0700
Message-ID: <20250625160849.61344-3-minhquangbui99@gmail.com>
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

The truesize is guaranteed not to exceed PAGE_SIZE in
get_mergeable_buf_len(). It is saved in mergeable context, which is not
changeable by the host side, so the check in receive path is quite
redundant.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2a130a3e50ac..6f9fedad4a5e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2144,9 +2144,9 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
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
@@ -2194,9 +2194,8 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
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


