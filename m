Return-Path: <bpf+bounces-77964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE16CF8FD1
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 16:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1A72304421F
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D823339856;
	Tue,  6 Jan 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ+6srUx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60E339844
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711916; cv=none; b=JRfOLdDjqCga4vqiOcCaaxA+fT/NZILYoGDsOXLw26R5YeCiFo44faZzT2mIw8a4BUDgDvWCpismzuMFPAQ3aQgbFyBFoLCqKbNt5+d8H8HJKXoqk0jOKfKapvGofmfNGOQDRGj2p0gRW/DEZgj1MCmBm7gMvJSSLtRtaKfoyvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711916; c=relaxed/simple;
	bh=iakYf4ocTYJ7pB+W5zvpfHG5k1a398Tzn3uAlEF7lF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwTbwR2HGYAzAZcatVzgS7TfnHZjyhvnk/C/2XEuIbaKx/eER5w0xJaYMotqIHmkWhyjhn63KIwkoRfSa+qhA3oVIXfXXSNfYJyjEs/vW4EIZL0Ol/RJxjM3pRe9PLvs2fS5FmW4Dm7H3aguB/8DE3kFD4MMIdh83s7x0ex8Xok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ+6srUx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so771268b3a.2
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711914; x=1768316714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC197L1plDdByX5sXGNPm444DjHNEfSXtphhEaSIChs=;
        b=HJ+6srUxc0B6lbhk29dbeB8itqsVzV+e3e6No4yk10VYagLjPzoDqErPYENPTVqg8W
         2jVE7mNl3vWxpvDjexCocIbXtqOsJuzsZwDsJ/0VzkmvENFKqTZBI7Bv9pQi4J0cIKJn
         HiOeTn49McPHCBHUuf5Yyy4FBtqz3i+dOlghUEoJbjW/cXZ8jJingCrbUC0cwZSob7bY
         5ezwDP35mDWaZs8b9tcH0l2ZoOC0scwNRPL7+WiLo4vS7tfVsMFCd8CUaxsWTYVggdr/
         UwGw6UGsBKsr6ClSevAdi7hk/KBTWZLVwng6YpI/oyNTskEXERCQx5ZPlgYZzvLnCjxg
         27Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711914; x=1768316714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tC197L1plDdByX5sXGNPm444DjHNEfSXtphhEaSIChs=;
        b=fGfylcHCf3XmMHyPeix/LAjQgE+phRjGIZ92hAffYapK8Vn25FZGDM6TZAQ3NiTJhB
         DlNLfXKInODcCIW/DnuU28LUgHvbcJ+kXQf8fHX+JSkCNV9rsQFq1x2djxxfKbOO1Cb6
         fy1laO821Vdj7xDAG1DYgh+ONk9/24l6RbDsRJYM88EzW+sL0i8AOFslUdU+P6bADDau
         FmLQeFmPtJgPYC3hfrprhbYhjJYF6nki2UiZ33N26OVZ8LU1ijrFcv41NsiBHp/eWQlH
         ZywZanNktp5t7iXHX6sh8OkUgOgzoluB15Wp6t70NMqquWaQcFtY/foNn7VGQ25EYXsO
         4gPg==
X-Forwarded-Encrypted: i=1; AJvYcCWQR6tG9Pz+zVuxTV6OvXuDmSgduFt8iFlHOJ5XuTa+90P4s7maPUhfwlW/GlhiJrSIASc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykeSKKo7D8D70QLS5tmcc/pDuAz+VcWMZpsKtFOBWtg/z9CKSi
	yXgQ9xN1UHmrkpz+ntxOx4zAfu2tozWMMVXouSaKMUTxedzPfsOKPnP4
X-Gm-Gg: AY/fxX6M/75HvNfP4KQtsUrc/Tl78nEkhGbCo+rclnZ81O9txyEoudEcoNIIPh0XnhP
	Frq2j9lgbz2iYolvnY2FqOfiw8vM3JeEI5PHsaVAjwg64ONapGomXQPTpYLxZ95b1qwDjcjU3ms
	KMJPlaVjIPFntNHUg24jRglyLTmEx1JWr06x8e/EHbz0fO9noIyy3oOCbMD3bOqlMFDefnXKBHP
	B21ZnB3BO4Ox3W3lf2sJo23ru6qFL2F7aMIyResEqCPdp398oEO+Iwina0Y1GN3ng3cUYxG3JYV
	n6SD2D51kbnSaKXr5wvab2ds807ZY20Fox848w1COQITJhOvKzoAQElFrMhFWmRJe8aE+4Hib8W
	Dvy2w/mAKYvKCvOtQo+Qyk5rm+EmDj/ZcmuxsaE6/ALIbi5bXhYusuk72Mx1fpM5G7RF/QC8bJl
	UaCd05CxMp
X-Google-Smtp-Source: AGHT+IGhJ2thPSuMeCWJuvxELL17nB4aCL3Ngpi+wjeWS3G5XiZYgyewYqUsGwlAYN2kTVU2XU2ttQ==
X-Received: by 2002:a05:6a21:3290:b0:366:14b2:313 with SMTP id adf61e73a8af0-389823cbca6mr3147694637.70.1767711913785;
        Tue, 06 Jan 2026 07:05:13 -0800 (PST)
Received: from minh.. ([14.187.47.150])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2674231a12.10.2026.01.06.07.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:05:13 -0800 (PST)
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
Subject: [PATCH net v3 3/3] virtio-net: clean up __virtnet_rx_pause/resume
Date: Tue,  6 Jan 2026 22:04:38 +0700
Message-ID: <20260106150438.7425-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106150438.7425-1-minhquangbui99@gmail.com>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The delayed refill worker is removed which makes virtnet_rx_pause/resume
quite the same as __virtnet_rx_pause/resume. So remove
__virtnet_rx_pause/resume and move the code to virtnet_rx_pause/resume.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a4dbc958689b..745bae756920 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3369,8 +3369,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void __virtnet_rx_pause(struct virtnet_info *vi,
-			       struct receive_queue *rq)
+static void virtnet_rx_pause(struct virtnet_info *vi,
+			     struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
 
@@ -3385,17 +3385,12 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
 	int i;
 
 	for (i = 0; i < vi->max_queue_pairs; i++)
-		__virtnet_rx_pause(vi, &vi->rq[i]);
+		virtnet_rx_pause(vi, &vi->rq[i]);
 }
 
-static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
-{
-	__virtnet_rx_pause(vi, rq);
-}
-
-static void __virtnet_rx_resume(struct virtnet_info *vi,
-				struct receive_queue *rq,
-				bool refill)
+static void virtnet_rx_resume(struct virtnet_info *vi,
+			      struct receive_queue *rq,
+			      bool refill)
 {
 	if (netif_running(vi->dev)) {
 		/* Pre-fill rq agressively, to make sure we are ready to get
@@ -3414,17 +3409,12 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
-			__virtnet_rx_resume(vi, &vi->rq[i], true);
+			virtnet_rx_resume(vi, &vi->rq[i], true);
 		else
-			__virtnet_rx_resume(vi, &vi->rq[i], false);
+			virtnet_rx_resume(vi, &vi->rq[i], false);
 	}
 }
 
-static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
-{
-	__virtnet_rx_resume(vi, rq, true);
-}
-
 static int virtnet_rx_resize(struct virtnet_info *vi,
 			     struct receive_queue *rq, u32 ring_num)
 {
@@ -3438,7 +3428,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
-	virtnet_rx_resume(vi, rq);
+	virtnet_rx_resume(vi, rq, true);
 	return err;
 }
 
@@ -5811,7 +5801,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 
 	rq->xsk_pool = pool;
 
-	virtnet_rx_resume(vi, rq);
+	virtnet_rx_resume(vi, rq, true);
 
 	if (pool)
 		return 0;
-- 
2.43.0


