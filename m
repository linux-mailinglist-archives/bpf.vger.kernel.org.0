Return-Path: <bpf+bounces-76287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A6CAD9B4
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 16:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5257D3018BB2
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCCC1E832A;
	Mon,  8 Dec 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiADeDa1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D703218AAF
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208108; cv=none; b=B6/uIg2HUBE7ID9oj4YTowmcgfCIplU6ZhQdcRcHR7lpODCriEfkv1pic6JbNsZ5GO9MC+zdvDDO+vvnlKP6844sCu3bthli4j95+QNM89gHRgN78tpx3G1YOOiS6+5H3sst4+TmKJd5EZRHDRH0vSPZUuV2OWP+KTWjDVas5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208108; c=relaxed/simple;
	bh=+dA/FLXdh91Tj4KvXzdrCX9sD7l/ZFnkWVRU35JvuQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCpw/2RlXWpp5pQRa3WL9+vFMm96U7PG0/Aq3keRrLHU7IX8lY2+0kLZjwgUaKYhOgEDCnF6LgDXZFS5cdsnQQBzKvy+DcbsZcgGH3IsCg28IADI5ZlTqSzTIn8RIHZRj0TpRAejUwD8sBXFCMAp314EEAF1ytBbStjLMOhVuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiADeDa1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so5248312b3a.2
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 07:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765208106; x=1765812906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWpFolnAyO+/LNdlTubeymU5rZAhEOvt75iUUlk8FxM=;
        b=DiADeDa1aZ29xlsEkqIYnezJx/4qPeuEmrN9xnMrSK/rmtc5igjjHJc+t/3wKmXl8V
         hexwZ0VfXSAyCcAe6EyP+gI7K+d4fYh327LFZtuQZD9yBl8kbDyo0EMYAgkeKKI64irw
         sJJO8CCVEZ+J+UWoRFXHansTq91rE/7+lq/7jHpSoNw1RqXLgi0kgNZQfztI4vxx04Dt
         uJX34FKQb6gAJN3IS3fBruvuY0rBsUk0EybBmLM6jhaHpA/kvAz4WfS594+gPl+4A5Zg
         UFv2D6b3h8N6jWdL1Rnsiz9bIaKTenMJs2oTtEq9yrJnizN0hX/GgM1dC7XEh48KE308
         3Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765208106; x=1765812906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWpFolnAyO+/LNdlTubeymU5rZAhEOvt75iUUlk8FxM=;
        b=FRj/xf5e4E8y0MQczcedq4aK2jyD8hPd+AJ/zC1VqKzHUrcoyaoIK+C8sFRq2QstxJ
         +P2wvxZblfJwvmp/kwoheKFYal7LN1Umx1G2zUk8UUx5YTHEDuAbLSETEMnik1WhdHwP
         Qhb16BsFqeFvsIKjAciTWbiqnQgB6ZvmZ3fr8GE8LJILIOV4DpZkxd8UCiIjKP8U0e6r
         EsbdkPo1zeb/zDaZQpjh85s6ZYJ+Td3sfcgpuYEVRHDvsnZhRHfewD6uc9ZNE31CTaE0
         cVu2uehfcu6yX46qxd/Z1cr5MdO3ihR3XbLfTELI1c08PEIqZRSGAsp1xq142PIgad/3
         AgAg==
X-Forwarded-Encrypted: i=1; AJvYcCXNkCwT/5a4nsqV3yeM6sxdznSb2FnVDWUnHMqNeprqrDjjWdg9uMIt3zIJNy7SYPKfGZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEts2BJFugbT5lx86StuRVtQjmmqo/FPylAPxlAkgH55SLs0L
	pxLbfOg/TqVFy5Zkjx82O6MZPdElecpL2qZs+w17W8LUw7zgfz6SS3VM
X-Gm-Gg: ASbGnctyj1KBvBc7vwr0vNKFjmWgpVIv+TnyzsqIyL1M0uTX1fq89zKxjwY91izFaCA
	HK0tm6dqYDViSB7vpxHeg2gnQHt2QTzn6zTI3yJOSH7B25ta1m1EqDF+odKfvLNtfKUsedK/1yu
	pJd4XK9LdhH3QoUPHHb+I9I4gQygb9J6Rc++hKdBtfnCSpA54uTwq+p1Wja3aSemzXJxkO/ilhK
	2kNOIeyF5v+z5rRAPmJt8JxVWM8Oxabc9NcuoEIwqfkipwYvlTcpgGpPJCWifgmPjgX8575ijVg
	gknpCS1DA6eBM0RLHZ2ILBCK1viszUbFHsXuWi3NWnXvWArVGvJEApo6kcMn1GFmdVNpqcFcRlx
	XUQN1wG97F7m1un0uL89iWeRrTfVKRGCwxjWXIN1byJEh5HDYP+ZjOo0g9NRdV8nWfaeR+O++cm
	s7K8RhE/d72XXgVC/H3124ntEv
X-Google-Smtp-Source: AGHT+IHbKnsyQgrUfLKGFjvZ3WkKGG8QW0enhqd/Ng7kJy9ybz2AnhuklB93e/amB8t20kVBAd65NA==
X-Received: by 2002:a05:6a20:914c:b0:366:14ac:e1e4 with SMTP id adf61e73a8af0-3661814c501mr7552324637.74.1765208106236;
        Mon, 08 Dec 2025 07:35:06 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:2998:e0cd:90d5:9648])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-bf6a14f40f5sm13106127a12.21.2025.12.08.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:35:00 -0800 (PST)
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
Subject: [PATCH net] virtio-net: enable all napis before scheduling refill work
Date: Mon,  8 Dec 2025 22:34:19 +0700
Message-ID: <20251208153419.18196-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling napi_disable() on an already disabled napi can cause the
deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
when pausing rx"), to avoid the deadlock, when pausing the RX in
virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
However, in the virtnet_rx_resume_all(), we enable the delayed refill
work too early before enabling all the receive queue napis.

The deadlock can be reproduced by running
selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
device and inserting a cond_resched() inside the for loop in
virtnet_rx_resume_all() to increase the success rate. Because the worker
processing the delayed refilled work runs on the same CPU as
virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
In real scenario, the contention on netdev_lock can cause the
reschedule.

This fixes the deadlock by ensuring all receive queue's napis are
enabled before we enable the delayed refill work in
virtnet_rx_resume_all() and virtnet_open().

Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e04adb57f52..f2b1ea65767d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 	return err != -ENOMEM;
 }
 
+static void virtnet_rx_refill_all(struct virtnet_info *vi)
+{
+	bool schedule_refill = false;
+	int i;
+
+	enable_delayed_refill(vi);
+	for (i = 0; i < vi->curr_queue_pairs; i++)
+		if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+			schedule_refill = true;
+
+	if (schedule_refill)
+		schedule_delayed_work(&vi->refill, 0);
+}
+
 static void skb_recv_done(struct virtqueue *rvq)
 {
 	struct virtnet_info *vi = rvq->vdev->priv;
@@ -3216,19 +3230,14 @@ static int virtnet_open(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
-	enable_delayed_refill(vi);
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
-			/* Make sure we have some buffers: if oom use wq. */
-			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
-
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
 			goto err_enable_qp;
 	}
 
+	virtnet_rx_refill_all(vi);
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
 		if (vi->status & VIRTIO_NET_S_LINK_UP)
 			netif_carrier_on(vi->dev);
@@ -3463,39 +3472,27 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	__virtnet_rx_pause(vi, rq);
 }
 
-static void __virtnet_rx_resume(struct virtnet_info *vi,
-				struct receive_queue *rq,
-				bool refill)
-{
-	bool running = netif_running(vi->dev);
-	bool schedule_refill = false;
-
-	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_refill = true;
-	if (running)
-		virtnet_napi_enable(rq);
-
-	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
-}
-
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
 	int i;
 
-	enable_delayed_refill(vi);
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
-			__virtnet_rx_resume(vi, &vi->rq[i], true);
-		else
-			__virtnet_rx_resume(vi, &vi->rq[i], false);
+	if (netif_running(vi->dev)) {
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			virtnet_napi_enable(&vi->rq[i]);
+
+		virtnet_rx_refill_all(vi);
 	}
 }
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
-	__virtnet_rx_resume(vi, rq, true);
+	if (netif_running(vi->dev)) {
+		virtnet_napi_enable(rq);
+
+		enable_delayed_refill(vi);
+		if (!try_fill_recv(vi, rq, GFP_KERNEL))
+			schedule_delayed_work(&vi->refill, 0);
+	}
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
-- 
2.43.0


