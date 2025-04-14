Return-Path: <bpf+bounces-55838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B48A87727
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 07:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814E016ECE3
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 05:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301BD1A01CC;
	Mon, 14 Apr 2025 05:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAhHm4Od"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89413E02A;
	Mon, 14 Apr 2025 05:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744607366; cv=none; b=dC/GDnVzZY6PdbE9ymJisSIJ+xn6GncOTjUgg3Mk0/6Bu8UuKX3yzLEqHfFgSLENrhMud+I5z6CQLEiuxgJkQTbmOC9QYjYwiPbG/PFR+Aj2wU/h4kYSH9V5JxWKa6nvFtL+GCDBEkzPPjSr9kww4uBtMVtMaANIVwnOxNcbkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744607366; c=relaxed/simple;
	bh=LAqM7pdFY5uYBhtKsTe5wOlUvRbdtlTtvnMwlz4eVRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3Q9F8WcQ1EAgpOrckbPM2mRzaXWNL9GC0dgm+mtI7wttOqSZsw7cbJYD+ttDT6AZux7rC3pLsAvGF9qDnAacDJoIFE1ZkAtva/4i9IvQzeAOCQezXUE7jXDkrJKSq9cIn1lxa60J06PXieOZtLglVnX2ELo0enmnUSAxHCfhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAhHm4Od; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2295d78b45cso53994405ad.0;
        Sun, 13 Apr 2025 22:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744607364; x=1745212164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTXn7wUxtDAnsVPk+xJ6XC8d5pS18e6iNJS/eIvyuiA=;
        b=hAhHm4OdSfNjMJ3vT+/KuD2xGXMoSHvMzq7+SHu5bew0UNfRwpTonTgfUaIHZA/bVv
         6X4w8iE1FlUFJAYsT2WmtcvKeH83kAkNZ2VSUpnHVchUiy2Nu7DPcA4wQnGQsMa66xlD
         Hsm89utRej4C/c98YN/9dQAnFzGxWnwMYvwTiFkMbKDvPIfvhFMA4U9KKqPsnUVKppbp
         EVRe6+ta9HErl+ZN9lStDw/pje0Bsdps6FY0w973ZH6BpwD1b42um2uKfW4I9JfJWzJA
         Z3Fpg1/AUjJJQdJ8e5OHJbFjIdf8J2vr1ODPtVR3NeAVIm/qQfEbwyM9g4IwDUafVkPU
         8+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744607364; x=1745212164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTXn7wUxtDAnsVPk+xJ6XC8d5pS18e6iNJS/eIvyuiA=;
        b=rEA41UxhQBoO6Iux4w/gmmVL9ExpLm2Au4+Q3XiTq9zBQDm+yHiJR7QYhwksh9V4rc
         hv0XDE14Z0kltg+ce9JINezeNbiNzj5nIBKIx3TznokoT4cxYgiCBWLfpm33JIz1eGUm
         n8Jgw4Zk08Py9OJTahqOzqnVrreUBjo82n5Z8O+w7SMEBCZVTJveJEQfmQUZX/jqvP9a
         SAL9ozWsWWAN7FoiwwkfaZYQdSrsQ3Ez4jhtR0QJojixGakZPPp9LbwlVHhO1g9t8Y+A
         N9YNJSojwhTPTd+l8I4kLbQ3UqdmkDasVdtdFGEVcbaof4VpFF30fc+RK5Yuw/aEZrHj
         XjLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM3hGjwN9OQnXuk3ngExrKwkmS56zfcDLB2j6WWSuON7lbXShEDmjd5/egJo3JuEsWE+U=@vger.kernel.org, AJvYcCVx3wMK+43/t1+sO/ciGkC2gPByxrdXUf52UCoCVqj519dawoDO2tMnhMUEINRgKanUOQYaqUhX7O9BccTE@vger.kernel.org, AJvYcCWdikEH0wxGM96VbvsH7YXkwBqFdUj+0HA+5pv/1PLN4CWnWdO3T2g40hlPRapdIMP33OS5zvxu@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQXh5BkSRIzYEriMLSM0wLhXYWr1NR5+jhUh+x26iyAko2j3Y
	qCxtpuKRr9pwKONiQuaEA2nLlDW5pbAvpPqotgZFkXhoXERzmzy9
X-Gm-Gg: ASbGncvnUc8bl6tGEhlnS0mCA+9Mn+cCjWSBV1g2K/5yTQR8cCrCXQJqgX5FIlFU3Uf
	o9HeXHNSGMdGsyrdmqgHMRYC193/Km1/kGfZllfuvpXEi7JxwCcNp2xGgFEqp+dYa0zTWe06cUL
	/xCP0R7EspDikuTDk6Wj/hS3+hgjxA2t9//V7IraeWHchF14XwhPTDjnArx1SKmqrCjo+Bnm7CU
	hPNWWbdHVJj8JpvBXpL+kagcUi99BFfkQnSQHz3U2Uofn1wSGtxX8obKbSTGEHgbVFvt7+esKQv
	nPsWUBh9/Fnnqg1tj3CntAs/MPzdMhwvKFYIRo0+O/pk8Nye7X7AZxZYkrc6KlRKvA==
X-Google-Smtp-Source: AGHT+IH7f0CknUb+6MEjVojl4lI4iFs1kPGlPHbcWFIW45FscoSes5CP7bnZxlO1IqjFQUpKfftBEA==
X-Received: by 2002:a17:902:d2d1:b0:223:f928:4553 with SMTP id d9443c01a7336-22bea50bb7dmr157537155ad.44.1744607364148;
        Sun, 13 Apr 2025 22:09:24 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:b80:9edb:557f:f8a7])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7cb5047sm90778665ad.170.2025.04.13.22.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:09:23 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
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
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v2 1/3] virtio-net: disable delayed refill when pausing rx
Date: Mon, 14 Apr 2025 12:08:35 +0700
Message-ID: <20250414050837.31213-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414050837.31213-1-minhquangbui99@gmail.com>
References: <20250414050837.31213-1-minhquangbui99@gmail.com>
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
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 60 ++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e4617216a4b..4361b91ccc64 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3342,10 +3342,53 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static void virtnet_rx_pause_all(struct virtnet_info *vi)
+{
+	bool running = netif_running(vi->dev);
+
+	/*
+	 * Make sure refill_work does not run concurrently to
+	 * avoid napi_disable race which leads to deadlock.
+	 */
+	disable_delayed_refill(vi);
+	cancel_delayed_work_sync(&vi->refill);
+	if (running) {
+		int i;
+
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			virtnet_napi_disable(&vi->rq[i]);
+			virtnet_cancel_dim(vi, &vi->rq[i].dim);
+		}
+	}
+}
+
+static void virtnet_rx_resume_all(struct virtnet_info *vi)
+{
+	bool running = netif_running(vi->dev);
+	int i;
+
+	enable_delayed_refill(vi);
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		if (i < vi->curr_queue_pairs) {
+			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+				schedule_delayed_work(&vi->refill, 0);
+		}
+
+		if (running)
+			virtnet_napi_enable(&vi->rq[i]);
+	}
+}
+
 static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
 
+	/*
+	 * Make sure refill_work does not run concurrently to
+	 * avoid napi_disable race which leads to deadlock.
+	 */
+	disable_delayed_refill(vi);
+	cancel_delayed_work_sync(&vi->refill);
 	if (running) {
 		virtnet_napi_disable(rq);
 		virtnet_cancel_dim(vi, &rq->dim);
@@ -3356,6 +3399,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
 
+	enable_delayed_refill(vi);
 	if (!try_fill_recv(vi, rq, GFP_KERNEL))
 		schedule_delayed_work(&vi->refill, 0);
 
@@ -5959,12 +6003,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
@@ -5996,13 +6040,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
@@ -6014,11 +6057,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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


