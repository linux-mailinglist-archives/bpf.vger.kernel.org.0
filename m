Return-Path: <bpf+bounces-77685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB82CEEDA9
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 16:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E602230222FA
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F29625D1E9;
	Fri,  2 Jan 2026 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHgspHF9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C625B1DA
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367250; cv=none; b=s6t5HtR0yES9ZtcPvJYqeVFyhgdFV4LllLgGB1TADxA0VcavX0uXV6R0kxdrDxLCDmjAPjnDfOO9Sneywy4BdBLajTfRIWW+v+F4++SW0y8UBo0Xr5xq/+ZBN7UuwfRRpYRG4KM/Z8yoJ7FeBPf8Pt8HGmMbSCdB2rqFDvnwmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367250; c=relaxed/simple;
	bh=AVmbCTua2itYQSdqi67Rg2DvQJpSs9Fw5lo+ym0KgKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkNprmWRDbs1LWoDrtvmFhBYYvTB9eZZ9XYbpwfwZdVr9q3J9WlaBBEYrzX++XX6JeeuQxch0Z2kdSLVzXmVYKeOyJEEjUSAAvEFIJ1E8A4hFRWm49TyBWsfLBKun+CQStg9MQW0v5NjITUJU2A5KxQZG+oX0p6o3ErJ2D0jKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHgspHF9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so10233018b3a.3
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 07:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767367248; x=1767972048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viiMT0mJ8A1eQE5ko81RyEvaps1qhf8umuQOghYhhoM=;
        b=nHgspHF9T7yoCA4K1d8XVNuDBmDhdYM8YBktwCnxbjG95MFCE3M6fF3bHqEqvr/Ua9
         QQ5wnuUPwC9xSFF3hAfdVB71LSCEnGXQSCIeHtjW9qq1M122ZlRICcp9TthWlVeBzYou
         uHyf8/0lVgs0XbekgewKVfWyosQ8hzxllxkDRNBlUbUVSTyND+GC2rO91Pc+8xQCFSq0
         X3qIAVgYFXSHbbKqJECsa6xVx1/LZadsYdPq8cDDSUVmRgk4GnSERuvYADTbTngFyxso
         a33gsqa/fbN7DfuehjP01pSRcofhDcjH3FRidSRUKe4URcj/rVRBq0DnjxUWPs5OvqwF
         pmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367248; x=1767972048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=viiMT0mJ8A1eQE5ko81RyEvaps1qhf8umuQOghYhhoM=;
        b=jxHfSEN6trtA35ZdPtclDoA8qrSILuPGLXrO2i9em9o1/cGybyUQV2Ttkr6Hq5HNV3
         2KvRfuP/u4mgJvQDAYfofHqB1obA7zP+ct0pWhaqH8h/XGTYesCWXINs3lOohdDcQifv
         AT51xbnGxDWhAmxN5eLuDHgxDj60oIm4+RNXTUtkuCkus5WgTuMaLGsuh2dNAgXcL1mH
         o9AE3FmLJUhaUGYYJcB4mI2vrz9l65+W60bcUfgMG4UlRYYzoAcC+hLBGvijovbvPKxG
         KxRyCGg2YsjRgTTA5iqm00FdWzRbaVBdMdJkKoaFsiCgN5MbTiLU9oYt7NtwjxMFlke9
         C2rA==
X-Forwarded-Encrypted: i=1; AJvYcCVs7jEmLGnh2DkfgNkE4buGDjEtjD9o5+WV6NRwXYhLSLRkF7qxnX5xBvWtsDrjLrPrGE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxR3IXiAWq4jhQgqoVtNeEovkvJCFOCHqjisvE4w7U7DzRfnqN
	jP1pTiW5IH9Rzw3HfioLwjqWtQB4P3uJyGsvzxX3MFuvqcICuGeF0qLQ
X-Gm-Gg: AY/fxX7gByVN7uljXQW6uA08YC83q2I1iBvt6VOMDioKAprB3+8ExUgaSSY6ASf3ndI
	LSIz4RQmGOI0Mqt2vm5Sn5xPAKqaIWiqZ9vpJvQmCPMfDSFAIfVu+o0OLB1JqSGkJ/NVU3EHEdw
	bHhAvc7QQWjssQlvuWL4YzS2RxOrF8PU4TJhGkwrJtkRnE9QO9ZWWT3NYhTOcbAL0X9QJB2ZTQv
	wKM32qUHqTs4cWPSWiL1+Fj3neKytTOw5JRwE9UkZw8HUQ2uh/NqLFYjlasWpCYDWEo4CuaP7DO
	XrJtXyfbQo1DtBEZnA9pbG4gNBdEUvb5szIS12w6MJSBFkk7q/+gReU441CvpdDJORv5yuZ29jb
	nIwFWkH78uxniAmMc+K/WA1PH+6zMeoTJ7QpC54XGkMG4Hn6VGwXRLXLULXBxDANjs5mGGRyLWc
	YMikXzpAJlQbQCVl0ErVEu15o6zDru6eCdMg==
X-Google-Smtp-Source: AGHT+IGW/oGz/NZjf+BGO8R4q9EUzB2Mdtq7Z2nuodi9vs6ehE50GZWiOZQO50TBdIV5gsvGFMRUSA==
X-Received: by 2002:a05:6a21:99a4:b0:342:9cb7:649d with SMTP id adf61e73a8af0-376a7cec847mr41356285637.26.1767367248120;
        Fri, 02 Jan 2026 07:20:48 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:a612:725:7af0:96ca])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7c146aabsm35041268a12.25.2026.01.02.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:20:47 -0800 (PST)
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
Subject: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill worker
Date: Fri,  2 Jan 2026 22:20:21 +0700
Message-ID: <20260102152023.10773-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102152023.10773-1-minhquangbui99@gmail.com>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we fail to refill the receive buffers, we schedule a delayed worker
to retry later. However, this worker creates some concurrency issues
such as races and deadlocks. To simplify the logic and avoid further
problems, we will instead retry refilling in the next NAPI poll.

Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
Cc: stable@vger.kernel.org
Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..ac514c9383ae 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
 }
 
 static int virtnet_receive(struct receive_queue *rq, int budget,
-			   unsigned int *xdp_xmit)
+			   unsigned int *xdp_xmit, bool *retry_refill)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct virtnet_rq_stats stats = {};
@@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
 
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
-		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-			spin_lock(&vi->refill_lock);
-			if (vi->refill_enabled)
-				schedule_delayed_work(&vi->refill, 0);
-			spin_unlock(&vi->refill_lock);
-		}
+		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
+			*retry_refill = true;
 	}
 
 	u64_stats_set(&stats.packets, packets);
@@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	struct send_queue *sq;
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
-	bool napi_complete;
+	bool napi_complete, retry_refill = false;
 
 	virtnet_poll_cleantx(rq, budget);
 
-	received = virtnet_receive(rq, budget, &xdp_xmit);
+	received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
 	rq->packets_in_napi += received;
 
 	if (xdp_xmit & VIRTIO_XDP_REDIR)
 		xdp_do_flush();
 
 	/* Out of packets? */
-	if (received < budget) {
+	if (received < budget && !retry_refill) {
 		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
 		/* Intentionally not taking dim_lock here. This may result in a
 		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
@@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 		virtnet_xdp_put_sq(vi, sq);
 	}
 
-	return received;
+	return retry_refill ? budget : received;
 }
 
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
@@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
-			/* Make sure we have some buffers: if oom use wq. */
-			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+			/* If this fails, we will retry later in
+			 * NAPI poll, which is scheduled in the below
+			 * virtnet_enable_queue_pair
+			 */
+			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
@@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 				bool refill)
 {
 	bool running = netif_running(vi->dev);
-	bool schedule_refill = false;
 
-	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_refill = true;
+	if (refill)
+		/* If this fails, we will retry later in NAPI poll, which is
+		 * scheduled in the below virtnet_napi_enable
+		 */
+		try_fill_recv(vi, rq, GFP_KERNEL);
+
 	if (running)
 		virtnet_napi_enable(rq);
-
-	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
@@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	struct virtio_net_rss_config_trailer old_rss_trailer;
 	struct net_device *dev = vi->dev;
 	struct scatterlist sg;
+	int i;
 
 	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
 		return 0;
@@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	}
 succ:
 	vi->curr_queue_pairs = queue_pairs;
-	/* virtnet_open() will refill when device is going to up. */
-	spin_lock_bh(&vi->refill_lock);
-	if (dev->flags & IFF_UP && vi->refill_enabled)
-		schedule_delayed_work(&vi->refill, 0);
-	spin_unlock_bh(&vi->refill_lock);
+	if (dev->flags & IFF_UP) {
+		/* Let the NAPI poll refill the receive buffer for us. We can't
+		 * safely call try_fill_recv() here because the NAPI might be
+		 * enabled already.
+		 */
+		local_bh_disable();
+		for (i = 0; i < vi->curr_queue_pairs; i++)
+			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
+
+		local_bh_enable();
+	}
 
 	return 0;
 }
-- 
2.43.0


