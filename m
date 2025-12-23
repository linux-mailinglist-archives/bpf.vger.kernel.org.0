Return-Path: <bpf+bounces-77368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF15CD9CE5
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 16:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C53303FE4B
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55B734BA56;
	Tue, 23 Dec 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqFWrY8s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A334BA42
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503630; cv=none; b=Wdt3uXfMDzjKVyfk5Mr//9tLD8YlSZk9LDrg7c8mGFzete54m+GKxylcuUaOJIbO8yIjK7XdDIP5N04pLj5OKWmvcH5R4MHYjuJviLr6p4uwAbhAoRtsLmkjCw+U35pTFw+L1C4PuPGBabtUX1mVvCiVo3EurhxqVkdimiS2CBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503630; c=relaxed/simple;
	bh=KiQ0ZThXMAIWhbfHJPrDxjl8hzo1pgPh+udcXeksnfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZp+U+fW0n/TALgyyo09Q56OQtwuuQK3VrPMWybJS7bfBwi59MZimRtfrml8Gh8UTsAcRFcYPnRVOUJazNjYV9YsmVgCywVU/hfjoRNPmJTM1YFMPqsVf+sFGs4AQ5vChW9rzVanYj9eryTXwNVKtstcR/G77z/QShXpDU7ot8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqFWrY8s; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34b75f7a134so3907079a91.0
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 07:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766503628; x=1767108428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLWPkTU7zzF478AH6f0FqkR0eLCmJiyjEedfPTiBhIU=;
        b=UqFWrY8s/GHzGf1/KHgYwLSt+WnIXOj/DznssKwKQF3xIfZ+DIZ2tf7K/pxyMVHv0G
         ZVZ5VfyEuiJRsm6xblj8RTHheYVRI8jeh15dFfzlES77P0HHjv2KckOhu48fojRIWZPN
         89YSM6hoZLFOckPuBO1RzHvQaFTz70KUqcQz0zImnHLULQ3OQl/p+NBouaSmCwywUUAF
         ICsAMpHOKMWIidaOtRNNMg1EnMc9EysEQYHN+ve4oMgbcHQPqjP7ZzIOSGHEOfA1/Uhu
         3n/2WANNzqhRCzMRlmvIcPTdG7FpL9eYwAD4qGbkT28bx2W8nWC6ldQxhUlbFuMr58eN
         aXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766503628; x=1767108428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLWPkTU7zzF478AH6f0FqkR0eLCmJiyjEedfPTiBhIU=;
        b=qH932S5n1c1eqkMoSqT2ai2OUMlg2aEWFCkMmdztd3+saEz6nBAfunu9yorJgKbffu
         7fC3c3IDw31cblItJH1vY9uemRUpXxmGjbT8KI4aGEWAAht37wT5eZHYTsRT2Z3/9DV2
         nxgkr5VGLouiVS/LHjvzWe9Rtbqsy5Owc0j5MPH06zN9XP+yZmR2K3Q0G4JHVa8vK/TQ
         lRd5XqObeMDYD47/rP02CdGhwiJyMEQSkRxrzuv7lZ92riSYCqse70UhUeaUCweQpEIJ
         S5VAXM0ByTd1nsust16wJJXGebVCkVSl0TqZjNaNYB4yQxBkd5t5wgnHUw0Ze8vjJ5lk
         ZCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBoH0oY9c1U2mG/Eei/VXjyahwBERwolENia2AIp/OvtI8rGj9oybevLvmUVpvncOkssQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU9DFoGdZw3aZsNzIXaBdZ12sYG4oqCDrCdWGq/2jUyso/1r/R
	OqItQQrL7dH0DosAXFGwQ5Pky2iS2kdeyUzLh9nD8DOaPS/yVHCQDl38
X-Gm-Gg: AY/fxX6zFZJfj/5KYhQevd53qd7G1PsrgJHC6d4R9OAc/hPvmJc2TpE4H7d6MkNn8gY
	ujXUn8lnyRAp3ZyDbXjMPrMR1bGejjJ7ZyIrXO+HCxIPM8VXobefGb96MlMqDxPzfbGk8qujz0f
	GZy7mQTTHwlWeq1jA/WboNdi/AdZrfI+O3Wknwi8wq3lRdVE2HKnH7R0CivFl3CG2MOKxDYKC6f
	Bxm6CsOynQLIVzaM0woS0Ldz23CneyjWed22wNNiqEsn8QGVa8b8UP8ypp39yEHfWUIodkiXt9i
	a4ueRRSikEdVJwFJM55rbTBZwRinsFt23QSMqiLvL1qBbum0KEhPHwyHHgxayGfcIcLHq+ygzBr
	/Av1JjyBdEzoW82AEzBdwupz6cd3o/L84JPpwzvWwd/pkQWlmr5/8v1ED+VBvnrDSs81WKGnDYZ
	h3o/rmxQUJ+uwIxF69NXIuQLV7
X-Google-Smtp-Source: AGHT+IEVnhKR3V8FNtZi0Ym6mdYKVy9uIOFKC8GdabAruSwJL2IXyye60twQ8EXVcOpM73gSn0aWcg==
X-Received: by 2002:a17:90a:e18e:b0:32e:a8b7:e9c with SMTP id 98e67ed59e1d1-34e921cc9c6mr13306528a91.29.1766503627601;
        Tue, 23 Dec 2025 07:27:07 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:3523:f373:4d1d:e7f0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm8006138a91.1.2025.12.23.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:27:07 -0800 (PST)
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
Subject: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
Date: Tue, 23 Dec 2025 22:25:31 +0700
Message-ID: <20251223152533.24364-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223152533.24364-1-minhquangbui99@gmail.com>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the refill work is a global delayed work for all the receive
queues. This commit makes the refill work a per receive queue so that we
can manage them separately and avoid further mistakes. It also helps the
successfully refilled queue avoid the napi_disable in the global delayed
refill work like before.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 155 ++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 83 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..63126e490bda 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -379,6 +379,15 @@ struct receive_queue {
 	struct xdp_rxq_info xsk_rxq_info;
 
 	struct xdp_buff **xsk_buffs;
+
+	/* Is delayed refill enabled? */
+	bool refill_enabled;
+
+	/* The lock to synchronize the access to refill_enabled */
+	spinlock_t refill_lock;
+
+	/* Work struct for delayed refilling if we run low on memory. */
+	struct delayed_work refill;
 };
 
 #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
@@ -441,9 +450,6 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
-	/* Work struct for delayed refilling if we run low on memory. */
-	struct delayed_work refill;
-
 	/* UDP tunnel support */
 	bool tx_tnl;
 
@@ -451,12 +457,6 @@ struct virtnet_info {
 
 	bool rx_tnl_csum;
 
-	/* Is delayed refill enabled? */
-	bool refill_enabled;
-
-	/* The lock to synchronize the access to refill_enabled */
-	spinlock_t refill_lock;
-
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
@@ -720,18 +720,18 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_delayed_refill(struct virtnet_info *vi)
+static void enable_delayed_refill(struct receive_queue *rq)
 {
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = true;
-	spin_unlock_bh(&vi->refill_lock);
+	spin_lock_bh(&rq->refill_lock);
+	rq->refill_enabled = true;
+	spin_unlock_bh(&rq->refill_lock);
 }
 
-static void disable_delayed_refill(struct virtnet_info *vi)
+static void disable_delayed_refill(struct receive_queue *rq)
 {
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = false;
-	spin_unlock_bh(&vi->refill_lock);
+	spin_lock_bh(&rq->refill_lock);
+	rq->refill_enabled = false;
+	spin_unlock_bh(&rq->refill_lock);
 }
 
 static void enable_rx_mode_work(struct virtnet_info *vi)
@@ -2950,38 +2950,19 @@ static void virtnet_napi_disable(struct receive_queue *rq)
 
 static void refill_work(struct work_struct *work)
 {
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, refill.work);
+	struct receive_queue *rq =
+		container_of(work, struct receive_queue, refill.work);
 	bool still_empty;
-	int i;
-
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
 
-		/*
-		 * When queue API support is added in the future and the call
-		 * below becomes napi_disable_locked, this driver will need to
-		 * be refactored.
-		 *
-		 * One possible solution would be to:
-		 *   - cancel refill_work with cancel_delayed_work (note:
-		 *     non-sync)
-		 *   - cancel refill_work with cancel_delayed_work_sync in
-		 *     virtnet_remove after the netdev is unregistered
-		 *   - wrap all of the work in a lock (perhaps the netdev
-		 *     instance lock)
-		 *   - check netif_running() and return early to avoid a race
-		 */
-		napi_disable(&rq->napi);
-		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_do_enable(rq->vq, &rq->napi);
+	napi_disable(&rq->napi);
+	still_empty = !try_fill_recv(rq->vq->vdev->priv, rq, GFP_KERNEL);
+	virtnet_napi_do_enable(rq->vq, &rq->napi);
 
-		/* In theory, this can happen: if we don't get any buffers in
-		 * we will *never* try to fill again.
-		 */
-		if (still_empty)
-			schedule_delayed_work(&vi->refill, HZ/2);
-	}
+	/* In theory, this can happen: if we don't get any buffers in
+	 * we will *never* try to fill again.
+	 */
+	if (still_empty)
+		schedule_delayed_work(&rq->refill, HZ / 2);
 }
 
 static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
@@ -3048,10 +3029,10 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
 		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-			spin_lock(&vi->refill_lock);
-			if (vi->refill_enabled)
-				schedule_delayed_work(&vi->refill, 0);
-			spin_unlock(&vi->refill_lock);
+			spin_lock(&rq->refill_lock);
+			if (rq->refill_enabled)
+				schedule_delayed_work(&rq->refill, 0);
+			spin_unlock(&rq->refill_lock);
 		}
 	}
 
@@ -3226,13 +3207,13 @@ static int virtnet_open(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
-	enable_delayed_refill(vi);
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
+		if (i < vi->curr_queue_pairs) {
+			enable_delayed_refill(&vi->rq[i]);
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+				schedule_delayed_work(&vi->rq[i].refill, 0);
+		}
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
@@ -3251,10 +3232,9 @@ static int virtnet_open(struct net_device *dev)
 	return 0;
 
 err_enable_qp:
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
-
 	for (i--; i >= 0; i--) {
+		disable_delayed_refill(&vi->rq[i]);
+		cancel_delayed_work_sync(&vi->rq[i].refill);
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
@@ -3447,14 +3427,15 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
 {
 	int i;
 
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
-	for (i = 0; i < vi->max_queue_pairs; i++)
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		/*
+		 * Make sure refill_work does not run concurrently to
+		 * avoid napi_disable race which leads to deadlock.
+		 */
+		disable_delayed_refill(&vi->rq[i]);
+		cancel_delayed_work_sync(&vi->rq[i].refill);
 		__virtnet_rx_pause(vi, &vi->rq[i]);
+	}
 }
 
 static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
@@ -3463,8 +3444,8 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	 * Make sure refill_work does not run concurrently to
 	 * avoid napi_disable race which leads to deadlock.
 	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
+	disable_delayed_refill(rq);
+	cancel_delayed_work_sync(&rq->refill);
 	__virtnet_rx_pause(vi, rq);
 }
 
@@ -3481,25 +3462,26 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 		virtnet_napi_enable(rq);
 
 	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
+		schedule_delayed_work(&rq->refill, 0);
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
 	int i;
 
-	enable_delayed_refill(vi);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
+		if (i < vi->curr_queue_pairs) {
+			enable_delayed_refill(&vi->rq[i]);
 			__virtnet_rx_resume(vi, &vi->rq[i], true);
-		else
+		} else {
 			__virtnet_rx_resume(vi, &vi->rq[i], false);
+		}
 	}
 }
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
+	enable_delayed_refill(rq);
 	__virtnet_rx_resume(vi, rq, true);
 }
 
@@ -3830,10 +3812,16 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 succ:
 	vi->curr_queue_pairs = queue_pairs;
 	/* virtnet_open() will refill when device is going to up. */
-	spin_lock_bh(&vi->refill_lock);
-	if (dev->flags & IFF_UP && vi->refill_enabled)
-		schedule_delayed_work(&vi->refill, 0);
-	spin_unlock_bh(&vi->refill_lock);
+	if (dev->flags & IFF_UP) {
+		int i;
+
+		for (i = 0; i < vi->curr_queue_pairs; i++) {
+			spin_lock_bh(&vi->rq[i].refill_lock);
+			if (vi->rq[i].refill_enabled)
+				schedule_delayed_work(&vi->rq[i].refill, 0);
+			spin_unlock_bh(&vi->rq[i].refill_lock);
+		}
+	}
 
 	return 0;
 }
@@ -3843,10 +3831,6 @@ static int virtnet_close(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
-	/* Make sure NAPI doesn't schedule refill work */
-	disable_delayed_refill(vi);
-	/* Make sure refill_work doesn't re-enable napi! */
-	cancel_delayed_work_sync(&vi->refill);
 	/* Prevent the config change callback from changing carrier
 	 * after close
 	 */
@@ -3857,6 +3841,10 @@ static int virtnet_close(struct net_device *dev)
 	cancel_work_sync(&vi->config_work);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		/* Make sure NAPI doesn't schedule refill work */
+		disable_delayed_refill(&vi->rq[i]);
+		/* Make sure refill_work doesn't re-enable napi! */
+		cancel_delayed_work_sync(&vi->rq[i].refill);
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
 	}
@@ -5802,7 +5790,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_delayed_refill(vi);
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
@@ -6559,8 +6546,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	if (!vi->rq)
 		goto err_rq;
 
-	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		INIT_DELAYED_WORK(&vi->rq[i].refill, refill_work);
+		spin_lock_init(&vi->rq[i].refill_lock);
 		vi->rq[i].pages = NULL;
 		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
 				      i);
@@ -6901,7 +6889,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
-	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -7165,7 +7152,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	net_failover_destroy(vi->failover);
 free_vqs:
 	virtio_reset_device(vdev);
-	cancel_delayed_work_sync(&vi->refill);
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		cancel_delayed_work_sync(&vi->rq[i].refill);
+
 	free_receive_page_frags(vi);
 	virtnet_del_vqs(vi);
 free:
-- 
2.43.0


