Return-Path: <bpf+bounces-49029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 195D0A132D1
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 06:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477A0168854
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 05:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C22A1953A2;
	Thu, 16 Jan 2025 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="oprsE6mQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284A194C75
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006811; cv=none; b=AjbHotc8Gnk/L0gx3FHtI5NmRw8q+oBELXn2AJWBtHRpbMpikn1uy9hZYdLh3Dgc09EO0ByTBbsHBgYqLhWmXyEw5q9eYGdzXWDs7tFEUq+hGD4lbutIJVZ35Bzz2ifoZNZsKGZZMYob0agwPSu1n54kLLQI6hhl2LBkmkU0Vgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006811; c=relaxed/simple;
	bh=yJvHEqdHpoC28W6nXw4OZ31j2d6z3msHRmx43NIpiUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pmkUUbCq03RhDxkFhAnUtbKN2zs0Bmo6yzGR91th1foRVy0umHH5g1NhjFrtT4dEkZJBB4/IU/lWqy2Xru0kf91wm1pxGhv88DQooeGRWsifGlRCUBIUwvV8rjNDJGiepBJaT26p91FKes+DZUOK4BdOraqF1mmdQXFMMxM7s+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=oprsE6mQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21649a7bcdcso7840125ad.1
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 21:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737006809; x=1737611609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcY+kSjeMMu9asV4FI3bEFO3nH1Uxd3geQomjlGuQlg=;
        b=oprsE6mQGDWzDzFGb8J8iaeQOzuEOBAKNbiT03ljfZE2+dx8+0teuzBfJBKoTB5rmh
         klN+6yP3MYjQS04WbpzT1K6dAGxnxhjB+QYuXluV/812rzHR4ACN5AIOp53eJ04feIrW
         qjVIhxGWfTXnMsXxGTAe7aiPTCaD76FU6GJZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737006809; x=1737611609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcY+kSjeMMu9asV4FI3bEFO3nH1Uxd3geQomjlGuQlg=;
        b=s6dDmrAtxZcdiElprh21HWktbhvypxmWGTXtL9Q830hH7FXnZgdGEirba8AWfk7Ng/
         1HL8QSdNbtnBzZ2HiI08nBu6B4iwgLlQTW43UvDsB7YASjjnFtHVgLt9UWa+Bd2KVayk
         IlgrRgDbT5KsFyrsNt0mVEH0rhCLDhvT2MlQZNVeQYVDhBRtgIl+47Bq+WWF7WrIYKb4
         aLG/8Tt+KVob5XQRCuLuL9Pu/OxTsZsIJBXKR/VCo+RG5pQ52Bp0DspUZJrDTXk8s8Rv
         iOGmPeF1tTnZaiomu+IxMmZFoFfnB45oBn7dWMlF8Pq1WkhrzPEL0U2FphTTNMEJhrZu
         XEcg==
X-Forwarded-Encrypted: i=1; AJvYcCV2L71DRuAf8QItTuLMSqES8c4zEeqG1fvsrrN5H4V+Its7xHAcwwWwDT+I2IwBUKGWlr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Er++xFBTsZ9JlCjS3bqVRDCVntkxsXxgIDbLvVUj67VNB9wL
	nf7GSRod0Pi6TbSGGK3XYS+zcGFlmFCs3QEdXOQ9zm/B+zF0BP4VMR/J7QhkI40=
X-Gm-Gg: ASbGncuAG9IImYwbrwljsJkzDpNinOSkaMn225fbjR45BNS9rD0dgWsUz5QA7uWx+Fr
	eCMay99gSDvWG4wjKO0r00XBGZcJs0W3WNvMeuDSuTwv42JIQcJIMh4ptiX2g9n0ZKQhF54Fv2W
	wt4SMUkCLm3FWFZJ3JwxRLTpBqWNFDthdtU9HOidPBLkqhQP7cfYaPalXsVoD9Y6fefNVeVYTgd
	dNciY6yxZMGWBx55K1jcxnG+HjptwlL+uU3iBtPvZTkwqc5mySG2N6mOsgLQJky
X-Google-Smtp-Source: AGHT+IFGBkkanzsZABlx+kwVbhQWzWrd9fcJLyyqg9XrcMim/tp4HH707mqDKYrn2ErGZPkhsWUDLA==
X-Received: by 2002:a17:903:2311:b0:210:fce4:11ec with SMTP id d9443c01a7336-21a83f42687mr507328185ad.1.1737006809538;
        Wed, 15 Jan 2025 21:53:29 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c991sm91249655ad.168.2025.01.15.21.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:53:29 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
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
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
Date: Thu, 16 Jan 2025 05:52:58 +0000
Message-Id: <20250116055302.14308-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116055302.14308-1-jdamato@fastly.com>
References: <20250116055302.14308-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
can be accessed by user apps.

$ ethtool -i ens4 | grep driver
driver: virtio_net

$ sudo ethtool -L ens4 combined 4

$ ./tools/net/ynl/pyynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'type': 'tx'}]

Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
the lack of 'napi-id' in the above output is expected.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Eliminate RTNL code paths using the API Jakub introduced in patch 1
     of this v2.
   - Added virtnet_napi_disable to reduce code duplication as
     suggested by Jason Wang.

 drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cff18c66b54a..c6fda756dd07 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 	local_bh_enable();
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_enable(struct virtqueue *vq,
+				struct napi_struct *napi)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+	int q = vq2rxq(vq);
+	u16 curr_qs;
+
 	virtnet_napi_do_enable(vq, napi);
+
+	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
+	if (!vi->xdp_enabled || q < curr_qs)
+		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
 }
 
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
@@ -2826,6 +2835,20 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 	virtnet_napi_do_enable(vq, napi);
 }
 
+static void virtnet_napi_disable(struct virtqueue *vq,
+				 struct napi_struct *napi)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	int q = vq2rxq(vq);
+	u16 curr_qs;
+
+	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
+	if (!vi->xdp_enabled || q < curr_qs)
+		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NULL);
+
+	napi_disable(napi);
+}
+
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
 {
 	if (napi->weight)
@@ -2842,7 +2865,8 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq->vq, &rq->napi);
+
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
 		virtnet_napi_enable(rq->vq, &rq->napi);
 
@@ -3042,7 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
 	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
-	napi_disable(&vi->rq[qp_index].napi);
+	virtnet_napi_disable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
 
@@ -3313,7 +3337,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	bool running = netif_running(vi->dev);
 
 	if (running) {
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq->vq, &rq->napi);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
 }
@@ -5932,7 +5956,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			napi_disable(&vi->rq[i].napi);
+			virtnet_napi_disable(vi->rq[i].vq, &vi->rq[i].napi);
 			virtnet_napi_tx_disable(&vi->sq[i].napi);
 		}
 	}
-- 
2.25.1


