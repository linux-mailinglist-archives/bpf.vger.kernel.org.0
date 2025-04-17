Return-Path: <bpf+bounces-56106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7983EA91531
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 09:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43B31908448
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C81221F1A;
	Thu, 17 Apr 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMmtmZtY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8698521D3D2;
	Thu, 17 Apr 2025 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874969; cv=none; b=ahgieUe9Jb4FHjesjG6TIEeenMHYN67fvglehx3SoerAos5iogjwS12zsojFf08rAbPRlpqPJUWdG745TgVIZGC6BkqIAfgNtyAxkX3+vcLxuar0p10v6NIhaGTFrVKq3s20T0wuFOdZq1ztfEewUmJee+ZqQGvl1b7krSLCUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874969; c=relaxed/simple;
	bh=KiR5G6Fufw0SgHFVKQy2aPbgCtBtp88qoVVLIiw5sm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3iJqjB4l4OP+smX7B+2uJOkFYOqLb3+STMhdtHOvYw1xIcPCSGuG12e4bGsiVO4qIDr6TK1g24RWdmpIorGkb9TXmjv+MfkAKr2Fa24X5CBxvHWfRcwtq39nFijA3dsmhZnwx1knMOGc5/CRMVfds0cCotB+TxCTn+Q27X/Qmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMmtmZtY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227d6b530d8so4971015ad.3;
        Thu, 17 Apr 2025 00:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744874967; x=1745479767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3MstdJ91xUeyQ36419gRDtbusN2ivJYwyYBaexXaX8=;
        b=gMmtmZtYuqzs/X6MhGYT3nwBrCZ/GiPagROJbC1tjkS4dPJzQM3/lFZxoDyEW+xyQz
         Iv3wly3lblNXC8sHmMqm4V5Q9iKIcSMDQ4u+4NVZVIXKi5D7ixJSZEu2xRRAhno0cxug
         rno0TuRSrkV3LO5bIN4eZkdnSufxc7WbKaE75xA1S1OHVaSwrkOM7tfIBRy2J2DhT0Fc
         gllrC7yVryQen7wFJUCToCfi2eH7sb0O3V1p04r2qCJ36mWe0QHgVR3yDWFw7p8xFYNo
         BPGNCuFx+PDI+dhE5q4dGqaRlPBOCuEJdgS32CyvryWbwM1DgzcijXY6mpCj+avBFt9Z
         zNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874967; x=1745479767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3MstdJ91xUeyQ36419gRDtbusN2ivJYwyYBaexXaX8=;
        b=ZrVW6hsfkg96fdxArZdRkEqoc7nmzXO92Icx6CJNs8ox9KNc4LNVgBv3uGy2eqULSn
         BkT40sAx+b92ra/FYOse/DSzErvCl6Hru6vSO59Spewrd2QThU2STLDrow5M7u78+gQi
         xczmgikCbYD+jXm7bxZ/bTzSx1Tl32GveECfgZnBTmPtHufNLptt6Zw4W8snNsP8aQO5
         Vs+0VSoLqsrwjkO+PGlyuA2BN8FAiSMrHhUi5PRW123J5b3Y9exkD5xS6VX4slvjcH/O
         3WXYQ8Frk+nkEMti2P1CD28sMotmNqSqgX3exTIDH9mgvwXvXPCwpcLW8r+kQyqB3YcP
         oyng==
X-Forwarded-Encrypted: i=1; AJvYcCUAyMtri+7imPx7DsvPAzoyLCD8D+dCODsUY/SmuzztyH+7/M0Yce0bofCozuZtEZRKGpcO+nDpQ1AO34Uq@vger.kernel.org, AJvYcCUytND7jZuHtyf18IKo41X1VGYpNt5cHM2qUapNBbcEgH3xy21tNnJhDk3pr9BNl81HHxKBnNOe@vger.kernel.org, AJvYcCWQgbzmCijdQ70BBzfT4qajN7iguIqerm8bueNFQi0hUiUrWcfjAbLE82ioK0QzzmaPm/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzspI9X+9pG35/qzFoW0bwCRYsW6OAYQTY1A8G7BMtLn9fsHGzc
	tvsz8h9wFMB+Vvc/s16GKakz4LuBtEmuV53OUrr/NtjHLVK+L7zc
X-Gm-Gg: ASbGncvFokwvXKFsFTqIIEnBd/ovBvrE8SWKFtnBnlGCiQfvL/GiDdoR0See+jW59yx
	S78cCYgxrhXBr13LrTb5+xqZWTu0SPCGbU3zz6/XXX6UJavpQy2hSFxZ+5ZTjOpOHhZSIxHP7/z
	zmHqOJWHUgyOVuw3tR21TPATwDCWXFEeG6YeJMcM5GCvsqZkaIdL3EfWsp0n3UWzWaljsAolAW6
	nMdrHYY4Sa9I2uDmxYnBXOKr5oIozui5l9i5aGnKTb8SaCwvDE6jdtDvdEr+3N5TKcLLvKS9Xvl
	rJcWO2wrq729ew1Hd+zeVWIVW+qB4OS6vM2plEIPLKZq7DOrKbnrVY5h
X-Google-Smtp-Source: AGHT+IH5uYTC/cGu4Dc/9NlFeecZ6WGePFx+PPCoX4AhrVa3ZlbIOZm4LGGHrLfJG5dI1m1/e/4FAw==
X-Received: by 2002:a17:902:db10:b0:22c:3609:97ed with SMTP id d9443c01a7336-22c36099969mr63425985ad.30.1744874966710;
        Thu, 17 Apr 2025 00:29:26 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:ab45:ee9c:5719:f829])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd22f0f3fsm11625344b3a.115.2025.04.17.00.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:29:26 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v4 1/4] virtio-net: disable delayed refill when pausing rx
Date: Thu, 17 Apr 2025 14:28:03 +0700
Message-ID: <20250417072806.18660-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417072806.18660-1-minhquangbui99@gmail.com>
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
napi_disable() on the receive queue's napi. In delayed refill_work, it
also calls napi_disable() on the receive queue's napi.  When
napi_disable() is called on an already disabled napi, it will sleep in
napi_disable_locked while still holding the netdev_lock. As a result,
later napi_enable gets stuck too as it cannot acquire the netdev_lock.
This leads to refill_work and the pause-then-resume tx are stuck
altogether.

This scenario can be reproducible by binding a XDP socket to virtio-net
interface without setting up the fill ring. As a result, try_fill_recv
will fail until the fill ring is set up and refill_work is scheduled.

This commit adds virtnet_rx_(pause/resume)_all helpers and fixes up the
virtnet_rx_resume to disable future and cancel all inflights delayed
refill_work before calling napi_disable() to pause the rx.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 69 +++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e4617216a4b..848fab51dfa1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3342,7 +3342,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
+static void __virtnet_rx_pause(struct virtnet_info *vi,
+			       struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
 
@@ -3352,17 +3353,63 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	}
 }
 
-static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
+static void virtnet_rx_pause_all(struct virtnet_info *vi)
+{
+	int i;
+
+	/*
+	 * Make sure refill_work does not run concurrently to
+	 * avoid napi_disable race which leads to deadlock.
+	 */
+	disable_delayed_refill(vi);
+	cancel_delayed_work_sync(&vi->refill);
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		__virtnet_rx_pause(vi, &vi->rq[i]);
+}
+
+static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
+{
+	/*
+	 * Make sure refill_work does not run concurrently to
+	 * avoid napi_disable race which leads to deadlock.
+	 */
+	disable_delayed_refill(vi);
+	cancel_delayed_work_sync(&vi->refill);
+	__virtnet_rx_pause(vi, rq);
+}
+
+static void __virtnet_rx_resume(struct virtnet_info *vi,
+				struct receive_queue *rq,
+				bool refill)
 {
 	bool running = netif_running(vi->dev);
 
-	if (!try_fill_recv(vi, rq, GFP_KERNEL))
+	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
 		virtnet_napi_enable(rq);
 }
 
+static void virtnet_rx_resume_all(struct virtnet_info *vi)
+{
+	int i;
+
+	enable_delayed_refill(vi);
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		if (i < vi->curr_queue_pairs)
+			__virtnet_rx_resume(vi, &vi->rq[i], true);
+		else
+			__virtnet_rx_resume(vi, &vi->rq[i], false);
+	}
+}
+
+static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
+{
+	enable_delayed_refill(vi);
+	__virtnet_rx_resume(vi, rq, true);
+}
+
 static int virtnet_rx_resize(struct virtnet_info *vi,
 			     struct receive_queue *rq, u32 ring_num)
 {
@@ -5959,12 +6006,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	if (prog)
 		bpf_prog_add(prog, vi->max_queue_pairs - 1);
 
+	virtnet_rx_pause_all(vi);
+
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
-		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_disable(&vi->rq[i]);
+		for (i = 0; i < vi->max_queue_pairs; i++)
 			virtnet_napi_tx_disable(&vi->sq[i]);
-		}
 	}
 
 	if (!prog) {
@@ -5996,13 +6043,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		vi->xdp_enabled = false;
 	}
 
+	virtnet_rx_resume_all(vi);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (old_prog)
 			bpf_prog_put(old_prog);
-		if (netif_running(dev)) {
-			virtnet_napi_enable(&vi->rq[i]);
+		if (netif_running(dev))
 			virtnet_napi_tx_enable(&vi->sq[i]);
-		}
 	}
 
 	return 0;
@@ -6014,11 +6060,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			rcu_assign_pointer(vi->rq[i].xdp_prog, old_prog);
 	}
 
+	virtnet_rx_resume_all(vi);
 	if (netif_running(dev)) {
-		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_enable(&vi->rq[i]);
+		for (i = 0; i < vi->max_queue_pairs; i++)
 			virtnet_napi_tx_enable(&vi->sq[i]);
-		}
 	}
 	if (prog)
 		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
-- 
2.43.0


