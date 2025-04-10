Return-Path: <bpf+bounces-55635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEF9A83A53
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 09:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E353A3B1B4D
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69A6205E0A;
	Thu, 10 Apr 2025 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ6ygRtj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97D205ACB;
	Thu, 10 Apr 2025 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268768; cv=none; b=UUgp3dfFwx1Jhf1dFU9eQqnuG3uvWOaof/Am6S+BTK66OLzpubx+G8tnu8M5AriP2luPeeC+D+U702lMgWKJr9GpE/xtNb14JpUcH2d+lqDt9KeRB2USjj1obgPCcGxJHZGBJlpkZv6GDQCTt7xEg2kzaR1b1hlIeRaLbLIKhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268768; c=relaxed/simple;
	bh=H29HGz5dCVdWsyu4NNvoXXnk11dPJ6OVdf1MoeVHmj0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WvPgYxdI/A4BezWbRb5AIqiVpBoS+QHj5j7dVzQ+NFnz2Sq5bgkCEmDmZnChMJgROFdaBGT1hpNi0ebNIqyS2bNAdyI8RJdCpaJpKxSusxOYxT61/HUnXr0YXZVgqj7KyWsROwlWwA7yrDMqYZO/Qpe7RwNCUtk1QTVqppRKJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ6ygRtj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af51596da56so473427a12.0;
        Thu, 10 Apr 2025 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268765; x=1744873565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtO4Cd3eyEjzyUiq+HOYkzpvu70Qjvaf96k0H5Kwoi8=;
        b=dZ6ygRtjrth67PYYLgtH/Ze4Bil0q+t4JMMVKJWV8szGEI8pBLKoag0vRgwTjlkRxJ
         uydXLOmr8CCKwIvbudmhBljV3C+1JpmTykTZMGHjZK0H/7M5OAaCah2FKH0V2lcaDlYL
         NY6wSQNSjGgE6zvN7Ej71AP8LtxbpMyC9cc1pJwauhfFEATVEy6pL3cZVgZ7UTtHG1tt
         0GoZsyCuPCAaNyHfH0qblV/lbAePzFS+A8yOv6FSaH8447um9JvKSTAR+LmEk1RdsihI
         4QTzuTHXDOO+W9tS19A6ihsPrDiCiEEp5yGvuX4YVV5+koER5M5l1rFcV2TxNsZxZWSV
         Y8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268765; x=1744873565;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtO4Cd3eyEjzyUiq+HOYkzpvu70Qjvaf96k0H5Kwoi8=;
        b=ZnVaVaR9MEWSVRT1wBRZHxVqDWcQCbCDHkYlBru+nJPZRGzpVANN9/B3gM7LRlBY+7
         T7yipq16KreUPXMoZr0Yyi0rU/8Rv4YFJDgXAauSnTfTl3pATi+X7V4NeepyMPsbvxxt
         opbHbXtb+ovcjqXznHaYaFjauIrKupDC2kmVIrY0Mmbuf8XxcfnczqmV+kxX3BXQDVre
         9G/nI6pdRg+aQY9jI51BjaVUhnRSJYpickXmqZMAnSXp/9Xmg5L3US0yAZ5EpBsMD7O/
         K3hVZFc06lm9ZgYwfFK3xyXd4rvINAJCLnDsRoCiECtKGwHp++UGvi6FRkFtQa3t4Z+u
         WrYg==
X-Forwarded-Encrypted: i=1; AJvYcCVRcWVskZ4Z4PbBPG1nm1AUCW6wa6/3uoOxuD6biFE0eyiDdISW/SeDS1WNGwVHpJTlmXHN2MU8qgRYa658@vger.kernel.org, AJvYcCWI10Nm9jGK5MkGeghItihOTQw7TqdwajqhKUGApIA0ve9HQAWs7txCy1uWe0ympUMf/03t20dp@vger.kernel.org, AJvYcCXSSysX5vcBjWJHPVUMYJm00lv/HcKPcq12xJhUmhFVRLN53u7DMNPXEiF8vPT+Iy6M2Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOig1cn1H2UYW0nBCs7uPxBZBc//lbPtrQblOiY2DCtICAdK7B
	NVvzk92TXWzgzIKm8/bwtAdTeiWxTn55s88uNq+lF+FuOe0IoGN2
X-Gm-Gg: ASbGncvsBRmK5z2Wj4Tcy6Yok36yWUP3G+ymMaNjXjlG/3uwknWxbkgTvLqDZNjpc0U
	Rzk+VUnbqrByS5fJx2I5nvRiaiMIikU2k97vCKIjqKSEZUnL6MrJ/Zs9KYCIzMv7V/wv4smjDYl
	z8qrXSkZH4Ljt912bjVaTX533IiXQsiS+G0N2KiYxyO8z5cvwFObrryyECvUhVXxmCYBP6AIHMg
	3LCvw/o0d2nx7GcJ8S/oAAvy/4uioyt9Vpo7ceCrDU4XOxeHNzHAMUar/X3wHFKJsbMxNMt0r3v
	Sllmm52+wST/bjBloK1TzY7tYuLxnMFACVvnlDCIXz+6D8TiLSJsyBhKsOv75zmlF38g4NDW2tR
	tABpgh/BTE0kcXjRdHY0=
X-Google-Smtp-Source: AGHT+IFC012ePYdg9YU5IJdv9OMsXwY8Yly4PrymASzDBwjSbXzE/FE47Ok1P78B+yqAZ9Z6q4iZ6w==
X-Received: by 2002:a05:6a21:9007:b0:1f5:93b1:6a58 with SMTP id adf61e73a8af0-2016cc5eedbmr2153249637.8.1744268765300;
        Thu, 10 Apr 2025 00:06:05 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1? ([2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a322117bsm1978174a12.64.2025.04.10.00.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 00:06:04 -0700 (PDT)
Message-ID: <4d3a1478-b6fc-47a3-8d77-7eca6a973a06@gmail.com>
Date: Thu, 10 Apr 2025 14:05:57 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] virtio-net: hold netdev_lock when pausing rx
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
 <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
 <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
 <4195db62-db43-4d61-88c3-7a7fbb164726@gmail.com>
 <b7b1f5de-7003-4960-a9d1-883bf2f1aa77@gmail.com>
Content-Language: en-US
In-Reply-To: <b7b1f5de-7003-4960-a9d1-883bf2f1aa77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
napi_disable() on the receive queue's napi. In delayed refill_work, it
also calls napi_disable() on the receive queue's napi. When
napi_disable() is called on an already disabled napi, it will sleep in
napi_disable_locked while still holding the netdev_lock. As a result,
later napi_enable gets stuck too as it cannot acquire the netdev_lock.
This leads to refill_work and the pause-then-resume tx are stuck
altogether.

This scenario can be reproducible by binding a XDP socket to virtio-net
interface without setting up the fill ring. As a result, try_fill_recv
will fail until the fill ring is set up and refill_work is scheduled.

This commit makes the pausing rx path hold the netdev_lock until
resuming, prevent any napi_disable() to be called on a temporarily
disabled napi.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
  drivers/net/virtio_net.c | 74 +++++++++++++++++++++++++---------------
  1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e4617216a4b..74bd1065c586 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2786,9 +2786,13 @@ static void skb_recv_done(struct virtqueue *rvq)
  }

  static void virtnet_napi_do_enable(struct virtqueue *vq,
-                   struct napi_struct *napi)
+                   struct napi_struct *napi,
+                   bool netdev_locked)
  {
-    napi_enable(napi);
+    if (netdev_locked)
+        napi_enable_locked(napi);
+    else
+        napi_enable(napi);

      /* If all buffers were filled by other side before we napi_enabled, we
       * won't get another interrupt, so process any outstanding packets 
now.
@@ -2799,16 +2803,16 @@ static void virtnet_napi_do_enable(struct 
virtqueue *vq,
      local_bh_enable();
  }

-static void virtnet_napi_enable(struct receive_queue *rq)
+static void virtnet_napi_enable(struct receive_queue *rq, bool 
netdev_locked)
  {
      struct virtnet_info *vi = rq->vq->vdev->priv;
      int qidx = vq2rxq(rq->vq);

-    virtnet_napi_do_enable(rq->vq, &rq->napi);
+    virtnet_napi_do_enable(rq->vq, &rq->napi, netdev_locked);
      netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, &rq->napi);
  }

-static void virtnet_napi_tx_enable(struct send_queue *sq)
+static void virtnet_napi_tx_enable(struct send_queue *sq, bool 
netdev_locked)
  {
      struct virtnet_info *vi = sq->vq->vdev->priv;
      struct napi_struct *napi = &sq->napi;
@@ -2825,11 +2829,11 @@ static void virtnet_napi_tx_enable(struct 
send_queue *sq)
          return;
      }

-    virtnet_napi_do_enable(sq->vq, napi);
+    virtnet_napi_do_enable(sq->vq, napi, netdev_locked);
      netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, napi);
  }

-static void virtnet_napi_tx_disable(struct send_queue *sq)
+static void virtnet_napi_tx_disable(struct send_queue *sq, bool 
netdev_locked)
  {
      struct virtnet_info *vi = sq->vq->vdev->priv;
      struct napi_struct *napi = &sq->napi;
@@ -2837,18 +2841,24 @@ static void virtnet_napi_tx_disable(struct 
send_queue *sq)

      if (napi->weight) {
          netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, NULL);
-        napi_disable(napi);
+        if (netdev_locked)
+            napi_disable_locked(napi);
+        else
+            napi_disable(napi);
      }
  }

-static void virtnet_napi_disable(struct receive_queue *rq)
+static void virtnet_napi_disable(struct receive_queue *rq, bool 
netdev_locked)
  {
      struct virtnet_info *vi = rq->vq->vdev->priv;
      struct napi_struct *napi = &rq->napi;
      int qidx = vq2rxq(rq->vq);

      netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, NULL);
-    napi_disable(napi);
+    if (netdev_locked)
+        napi_disable_locked(napi);
+    else
+        napi_disable(napi);
  }

  static void refill_work(struct work_struct *work)
@@ -2875,9 +2885,11 @@ static void refill_work(struct work_struct *work)
           *     instance lock)
           *   - check netif_running() and return early to avoid a race
           */
-        napi_disable(&rq->napi);
+        netdev_lock(vi->dev);
+        napi_disable_locked(&rq->napi);
          still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-        virtnet_napi_do_enable(rq->vq, &rq->napi);
+        virtnet_napi_do_enable(rq->vq, &rq->napi, true);
+        netdev_unlock(vi->dev);

          /* In theory, this can happen: if we don't get any buffers in
           * we will *never* try to fill again.
@@ -3074,8 +3086,8 @@ static int virtnet_poll(struct napi_struct *napi, 
int budget)

  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int 
qp_index)
  {
-    virtnet_napi_tx_disable(&vi->sq[qp_index]);
-    virtnet_napi_disable(&vi->rq[qp_index]);
+    virtnet_napi_tx_disable(&vi->sq[qp_index], false);
+    virtnet_napi_disable(&vi->rq[qp_index], false);
      xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
  }

@@ -3094,8 +3106,8 @@ static int virtnet_enable_queue_pair(struct 
virtnet_info *vi, int qp_index)
      if (err < 0)
          goto err_xdp_reg_mem_model;

-    virtnet_napi_enable(&vi->rq[qp_index]);
-    virtnet_napi_tx_enable(&vi->sq[qp_index]);
+    virtnet_napi_enable(&vi->rq[qp_index], false);
+    virtnet_napi_tx_enable(&vi->sq[qp_index], false);

      return 0;

@@ -3347,7 +3359,8 @@ static void virtnet_rx_pause(struct virtnet_info 
*vi, struct receive_queue *rq)
      bool running = netif_running(vi->dev);

      if (running) {
-        virtnet_napi_disable(rq);
+        netdev_lock(vi->dev);
+        virtnet_napi_disable(rq, true);
          virtnet_cancel_dim(vi, &rq->dim);
      }
  }
@@ -3359,8 +3372,10 @@ static void virtnet_rx_resume(struct virtnet_info 
*vi, struct receive_queue *rq)
      if (!try_fill_recv(vi, rq, GFP_KERNEL))
          schedule_delayed_work(&vi->refill, 0);

-    if (running)
-        virtnet_napi_enable(rq);
+    if (running) {
+        virtnet_napi_enable(rq, true);
+        netdev_unlock(vi->dev);
+    }
  }

  static int virtnet_rx_resize(struct virtnet_info *vi,
@@ -3389,7 +3404,7 @@ static void virtnet_tx_pause(struct virtnet_info 
*vi, struct send_queue *sq)
      qindex = sq - vi->sq;

      if (running)
-        virtnet_napi_tx_disable(sq);
+        virtnet_napi_tx_disable(sq, false);

      txq = netdev_get_tx_queue(vi->dev, qindex);

@@ -3423,7 +3438,7 @@ static void virtnet_tx_resume(struct virtnet_info 
*vi, struct send_queue *sq)
      __netif_tx_unlock_bh(txq);

      if (running)
-        virtnet_napi_tx_enable(sq);
+        virtnet_napi_tx_enable(sq, false);
  }

  static int virtnet_tx_resize(struct virtnet_info *vi, struct 
send_queue *sq,
@@ -5961,9 +5976,10 @@ static int virtnet_xdp_set(struct net_device 
*dev, struct bpf_prog *prog,

      /* Make sure NAPI is not using any XDP TX queues for RX. */
      if (netif_running(dev)) {
+        netdev_lock(dev);
          for (i = 0; i < vi->max_queue_pairs; i++) {
-            virtnet_napi_disable(&vi->rq[i]);
-            virtnet_napi_tx_disable(&vi->sq[i]);
+            virtnet_napi_disable(&vi->rq[i], true);
+            virtnet_napi_tx_disable(&vi->sq[i], true);
          }
      }

@@ -6000,11 +6016,14 @@ static int virtnet_xdp_set(struct net_device 
*dev, struct bpf_prog *prog,
          if (old_prog)
              bpf_prog_put(old_prog);
          if (netif_running(dev)) {
-            virtnet_napi_enable(&vi->rq[i]);
-            virtnet_napi_tx_enable(&vi->sq[i]);
+            virtnet_napi_enable(&vi->rq[i], true);
+            virtnet_napi_tx_enable(&vi->sq[i], true);
          }
      }

+    if (netif_running(dev))
+        netdev_unlock(dev);
+
      return 0;

  err:
@@ -6016,9 +6035,10 @@ static int virtnet_xdp_set(struct net_device 
*dev, struct bpf_prog *prog,

      if (netif_running(dev)) {
          for (i = 0; i < vi->max_queue_pairs; i++) {
-            virtnet_napi_enable(&vi->rq[i]);
-            virtnet_napi_tx_enable(&vi->sq[i]);
+            virtnet_napi_enable(&vi->rq[i], true);
+            virtnet_napi_tx_enable(&vi->sq[i], true);
          }
+        netdev_unlock(dev);
      }
      if (prog)
          bpf_prog_sub(prog, vi->max_queue_pairs - 1);
-- 
2.43.0



