Return-Path: <bpf+bounces-55926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AF7A8957A
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5378A178AFE
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2D027EC83;
	Tue, 15 Apr 2025 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLinOZqG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567DA27A926;
	Tue, 15 Apr 2025 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703096; cv=none; b=r+Y/hURmanQeK2o+Bp/dt15DFwJQ8bAreVgHw7Kk+iO3KjCEs4xx8a+Clar96ow5DjfLC3J2JXR396O/CvqhkO9D3Lfp5w1LTPOs7OnnG1p0EqjWGYj+8jR2WByOf9lhR0WRdsxSJ9qzGrkHxaXC7fvFvTrtAiLxOlF+vSto1JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703096; c=relaxed/simple;
	bh=TQNugo0K71UvLT1P/YjiGCL+NFPk7lPg6uFlzx2wBLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMpFKdgFoRRoQbuqVbnPAmMkm2vCmn9R3P0drIoQzrAhHVwTfJtmDnT2gk4spdoLCVTCPI03pqsWjnW0Vp3iC6aFFIwb8fltMFi67GGziLAqJq5r3Nh6rt+toAh5crj91k/BdNc/+CrZM25T+sfXtb7yWyQa1S4lI7glWWM/Zo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLinOZqG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30820167b47so4366055a91.0;
        Tue, 15 Apr 2025 00:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744703094; x=1745307894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0BuxBO6iaPS0ZXIsdpeH3MOTczu0p1v62QqIcPv2fQ=;
        b=KLinOZqG/JvbNzZjMzxu8fIEwI/Lvi8fvQdiUtZKniWlroky8f63CUCuYYOfXGfbe9
         qt7uelyLGrT88F5GtkshrFtq4m9LZX03Orkp+tnNbqCNUlnINyesIYQN5SaYPN55bIf4
         zrvXIirYXIpxfZI48LKhmO3XyzKl4HZJbdTt0iKaF6uUFyMb/vtlicFlCqqlF9TnZtVz
         sIHj6AJjXzTOZm8tLQI+fD2uuy9ZNPPYnmyh5oymT3MIWO+n0lQD+BYepjhhy9y57gl4
         DaKu+/tfN98yDLO/ImaV7xq+X7gdJXQ0y9ANn8giVnRq2umBCbJLHKLVP2MGxR9MPM/H
         mvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744703094; x=1745307894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0BuxBO6iaPS0ZXIsdpeH3MOTczu0p1v62QqIcPv2fQ=;
        b=IZkT/KkgvYb+PnT8OJ+ZQxF6HzQnB9sdFvlr0hMXv/mn7DnS8/RyXu9NKbc+ninsbF
         jL6vNa7Ee6LIXF4nz3KPCxwzk6PqOhqQfQktkiu3CuAgmw0FtLoTprlAne/dNUUT5Tqi
         aYuKMrxGvXXPsw4jqINNNj7GgqotvVuf3WX9sAhr0gZrvEBihd5pIZvx1nLPSXYrzNJQ
         ZGy8p9Nf1QEqjriAxK+43FOHKmwl0PSq9RdmHsPz3bLu9BGyKfRIuYXLLG7/o22bu4Fk
         u0Em9vzRLf5a7Lko8/Z0zdyHEqPbcMgex9LsO6NCxRYMhpJPTqYKMAva7E4GM7w04t7A
         MjDw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0px5aNODTLk/TzYY4x+foD+9ebIgQo6SNrBNbe7o8/MRbyzQupRGPANw3t+0YrcWCC/9T5yWyJkKgJ/m@vger.kernel.org, AJvYcCWaVSiQCgzgqpcFqo3sIsxuPRZxWx4j9MGlrEWLbd/66yiKjZ3rVTWY+Pt8ILptXyhpN/jfIWd4@vger.kernel.org, AJvYcCWfkLGTurXQ1ofjsCgtYyXt3E8XuIao9j9vRYbFq/LcQARmx0GOeYJUfA84W1w5AYPxhHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnTL/aIdp9VyTtddDMKs/Hg63yAUiOivP06lMn/zpgATQ4Imn
	c+7C6aLZ60EUkr5mp9BCtOnFqG3axXKuMqxYz98Iflgek61NqVWF
X-Gm-Gg: ASbGncuCwHw/jwSwquiHOik92i0vEN59Rvv4Wtec2D71P8r8MCgsSoMYwaxfo+CYSwd
	kIjjoy1cgad7sq22+256PeZ2pXU6NekHHlMfFouVkKVNI98ulU+++aaYs75Q4LpwvysN0+uUV6O
	c9OkXUs+dTff5i5IV007vaIESAvhahhFwsskkVmvPTa4xa8ux5vjpDj2zNFVsMeUkoy6cyGzqBj
	YYdsSK9lIpo7yBEkvxu9tthA0DlHhfsrMiinMu6vhDz3tDkNZXo4lPJs1LQk35GQFBd5BUqo6fV
	gf0JtL/2pPgTSPISpkYvRIqF4uTc5UaStDn/xieOBjsw9/rs51uz1R4D
X-Google-Smtp-Source: AGHT+IG+Rq4oA4NHax9MoQL4s8ibl0K0uceDso9aOf4QFKgwlgevfFSrAYI79zgALh+QoTOylI+6ow==
X-Received: by 2002:a17:90b:2708:b0:2fe:b907:5e5a with SMTP id 98e67ed59e1d1-3084f33a421mr3512890a91.10.1744703094422;
        Tue, 15 Apr 2025 00:44:54 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2e0b:88f9:a491:c18a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306df401ac8sm12299767a91.45.2025.04.15.00.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:44:54 -0700 (PDT)
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
Subject: [PATCH v3 1/3] virtio-net: disable delayed refill when pausing rx
Date: Tue, 15 Apr 2025 14:43:39 +0700
Message-ID: <20250415074341.12461-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415074341.12461-1-minhquangbui99@gmail.com>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
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


