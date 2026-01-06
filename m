Return-Path: <bpf+bounces-77963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5859ACF8FC2
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 16:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B8BB3038998
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73A338934;
	Tue,  6 Jan 2026 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBcDHY3g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EBB3385B9
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711909; cv=none; b=f4K8jboxcM+1q6ziD5zVCFYmnYWzIbViGE+Hih8olfgFigmzcOuRf2+UOk3PRGPjNw4iZj/jLuKA6vjOzXkioCrvaiV5w0Ovm9msG/RkOZFwF1mySCt4oS4Kz7C99wv/TV0h3G7ikELE6Rpg9dXK2Ep/wwTOp+h+a6ABge74Gp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711909; c=relaxed/simple;
	bh=8+XWm0MkuACUvng7Kj4q22bZFUfjvp4RMxeN/ue62pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhsicIg/dCTtPO1Mnl5AAZ35/y65EQof5qVN3c3/palPAu/8iymQLPXgdjhgmNqrYIkbQncS5/tAhn+IGihoqx5H7D/RmXhEkAJD6EsI1QERGuecfPGQwlR7lqJyCn/aSVX9j1qPScxjqukDgfFxAksSHftsYqHwE7osICWSVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBcDHY3g; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso549405a12.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 07:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711907; x=1768316707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dx88BuQonAnFzYSa3hWDepRze012ELPUSAZLctBXB8=;
        b=ZBcDHY3grU+OaiYHyJwwC5Dwol29KGgZw3W/XHDUtxaeYZ/WhkJ+cpbGJzK0/yaWOa
         e5BpobvGHn/beIO3S+rXqP63cnvvN2KtpqV5jYlPUj//Z5H1cmK+zKeixGQNGaInXDx5
         lljR9Xop2JdBOM1V4RFl74xcrP5mKWek+xHYNPbmHda8qLEnc62abAxdlCdouqRwglqx
         Ac0B7cEkBj1Ojo8QhkiGXsr/r/xRhvO5ZABv9D/NRKfEIISp7ThdepSm0pE9sr0Xaf0q
         Dl0U4rZ77AwTOJjikSim/Xx2NlQnV8FalzulFdd30T6aPGBeCSrYin6oH+NjR5JRiPBS
         POQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711907; x=1768316707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3dx88BuQonAnFzYSa3hWDepRze012ELPUSAZLctBXB8=;
        b=GEWBtAdblrr4uemULYp3b/Ukr/PNklTauoj+fbX+7+9QZdnUnnG83NYtnpxOvwizXx
         NnfCTe1wXnGee//tEYUf9qFdfDxneeu51XGJ0ISR5tEdOXEA3cjHc2yQc2d1D2dMcMv4
         WEcELpzFozQsC/q7ZhBUW5owFFfwU1zijcHLea4l7W8uwZqGnUO8Lrecht24lku24Kq3
         +VQ2sB7vOiVcD+ApGlTMOQhSbzQ5zH/NJZ/O/1uSjPJmXGuG2pIr83VzaqAY73Dstqlb
         8/XqGkbjdlJMZ7HI8ctcq7vTz2Av5vmyAM02TmQfizdmhH4acOIO0Tc9S1VW9Od6zfR4
         zGEg==
X-Forwarded-Encrypted: i=1; AJvYcCXusp7hVWBgmFEeU8DlMnXTf6UkWiPmc4YHmBMucFpM/2xrsKAgmiK8KKwRahIHK+9Kg1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5ixWy1fisCFS44oyym8zZZObiPuJb9R5bwo9WJhTB0S+/8RT
	etXoES7d3ClYz8IIrn43EaR0ZdWdMu/d4XZLuSp/03oJmRd5WpazRtli
X-Gm-Gg: AY/fxX40rO1sY0CqxDveQQusBKYAmtxAuWSuHAxsSa1jZVuNR5ynCifaiQAxHdWkmKB
	SrK31rBlSbrnMXTB7s+zjYxUA7iSs3D7tDyTITHL998NZoegKQWu0zJC8oqbZW8af2fTUZgHrlI
	ukQZ+GQ6hP6cKu5YG99OHKyBels6stTN609y2sDUifnnbKScYDP+ONNVPrWvwdLTcazpfmNQ7FO
	taXXCIyxdz7yHeUPINLoAAN2+iXn40f5Ri0zhAgtzDy5k6ZA3FSp7biUHBK0qml+5RUEZMDcByM
	Q6LOVEWiO2H+vxrvaYHgW76l8SIUwZA6d6hTlNJxH8oUfxvLwszHfVop0KlQnGY2lyX8W3lHnNi
	ylSVXZlhNjve6m5f6ni/FnjCJp9IOnv635HGBGQ8P2hbLZPGLyjA5X8LCviKRFdlHwS4cG6BiSn
	jIKKV4gxgaFDkQcbLSb+0=
X-Google-Smtp-Source: AGHT+IGb/fa1WaHzo7cAnun0Ah7pdwWSpOYpISNRLWZukJJRzWm7hWnHLE4Xc81NGkVkfkP9FNYbHA==
X-Received: by 2002:a17:90b:2dc3:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-34f5f26df41mr2777359a91.6.1767711907045;
        Tue, 06 Jan 2026 07:05:07 -0800 (PST)
Received: from minh.. ([14.187.47.150])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2674231a12.10.2026.01.06.07.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:05:06 -0800 (PST)
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
Subject: [PATCH net v3 2/3] virtio-net: remove unused delayed refill worker
Date: Tue,  6 Jan 2026 22:04:37 +0700
Message-ID: <20260106150438.7425-3-minhquangbui99@gmail.com>
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

Since we switched to retry refilling receive buffer in NAPI poll instead
of delayed worker, remove all now unused delayed refill worker code.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 86 ----------------------------------------
 1 file changed, 86 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f986abf0c236..a4dbc958689b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -441,9 +441,6 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
-	/* Work struct for delayed refilling if we run low on memory. */
-	struct delayed_work refill;
-
 	/* UDP tunnel support */
 	bool tx_tnl;
 
@@ -451,12 +448,6 @@ struct virtnet_info {
 
 	bool rx_tnl_csum;
 
-	/* Is delayed refill enabled? */
-	bool refill_enabled;
-
-	/* The lock to synchronize the access to refill_enabled */
-	spinlock_t refill_lock;
-
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
@@ -720,20 +711,6 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_delayed_refill(struct virtnet_info *vi)
-{
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = true;
-	spin_unlock_bh(&vi->refill_lock);
-}
-
-static void disable_delayed_refill(struct virtnet_info *vi)
-{
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = false;
-	spin_unlock_bh(&vi->refill_lock);
-}
-
 static void enable_rx_mode_work(struct virtnet_info *vi)
 {
 	rtnl_lock();
@@ -2948,42 +2925,6 @@ static void virtnet_napi_disable(struct receive_queue *rq)
 	napi_disable(napi);
 }
 
-static void refill_work(struct work_struct *work)
-{
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, refill.work);
-	bool still_empty;
-	int i;
-
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
-
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
-
-		/* In theory, this can happen: if we don't get any buffers in
-		 * we will *never* try to fill again.
-		 */
-		if (still_empty)
-			schedule_delayed_work(&vi->refill, HZ/2);
-	}
-}
-
 static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
 				    struct receive_queue *rq,
 				    int budget,
@@ -3226,8 +3167,6 @@ static int virtnet_open(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
-	enable_delayed_refill(vi);
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			/* Pre-fill rq agressively, to make sure we are ready to
@@ -3252,9 +3191,6 @@ static int virtnet_open(struct net_device *dev)
 	return 0;
 
 err_enable_qp:
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
-
 	for (i--; i >= 0; i--) {
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
@@ -3448,24 +3384,12 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
 {
 	int i;
 
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		__virtnet_rx_pause(vi, &vi->rq[i]);
 }
 
 static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
 	__virtnet_rx_pause(vi, rq);
 }
 
@@ -3488,7 +3412,6 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
 	int i;
 
-	enable_delayed_refill(vi);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			__virtnet_rx_resume(vi, &vi->rq[i], true);
@@ -3499,7 +3422,6 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
 	__virtnet_rx_resume(vi, rq, true);
 }
 
@@ -3845,10 +3767,6 @@ static int virtnet_close(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
-	/* Make sure NAPI doesn't schedule refill work */
-	disable_delayed_refill(vi);
-	/* Make sure refill_work doesn't re-enable napi! */
-	cancel_delayed_work_sync(&vi->refill);
 	/* Prevent the config change callback from changing carrier
 	 * after close
 	 */
@@ -5804,7 +5722,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_delayed_refill(vi);
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
@@ -6561,7 +6478,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	if (!vi->rq)
 		goto err_rq;
 
-	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
 		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
@@ -6903,7 +6819,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
-	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -7167,7 +7082,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	net_failover_destroy(vi->failover);
 free_vqs:
 	virtio_reset_device(vdev);
-	cancel_delayed_work_sync(&vi->refill);
 	free_receive_page_frags(vi);
 	virtnet_del_vqs(vi);
 free:
-- 
2.43.0


