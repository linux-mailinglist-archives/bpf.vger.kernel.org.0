Return-Path: <bpf+bounces-55321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC29A7BA10
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 11:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0174C189CD31
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5A61B041E;
	Fri,  4 Apr 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeywUxrR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9E1A23AD;
	Fri,  4 Apr 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759564; cv=none; b=g3bVUNZvnVkSpAF7ZBrDTC7fEX54jQm+ZUdG2rJ8K2vLeGQOVgaKoiy7vUCutpERTAx1tbG2dUoP7qc9/bdvbOnigw6A1U8U+jLpktWDuxCUzd2HJRJxqB9TfqWdk42nxzZsOOH5eZhOI2SaXSji2GFOmm8nrh/VQuR+5asKEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759564; c=relaxed/simple;
	bh=+dpKkoozxnNaU9u7pO5A4IVxMeZurwq+MVc0D/b9zUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QimfzRWifUmcD6bXP4DZ1O9h+aY+XPkR4H5ZOTtVi4kT84uG8i10/OU7LQzK7N1K8etPX6J4+WvAvj54M69uZNZLakrRX+jhiJzhKT8/cnWyNHKsYeyhcvEkz2E36/O/UUReZVm9PYEX/tY3PHECWHQRXil2UXfNduJbfi3o3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeywUxrR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7376dd56eccso1987240b3a.0;
        Fri, 04 Apr 2025 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743759562; x=1744364362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5i+BIOjdTujePTHxJ/EQhWONPgHHGsVjwziXnIVw+1U=;
        b=BeywUxrRFBjFPHYa8K2c5YSIhIhmQSBkzfIyxU4Fo0g+BNDt87zRIOWjzti43+lnay
         18nUfI+fKLI1Y051tHJq43yyGrNRi7ddY4nJp0YTf1LH3QXwTilvyiV2LbzarCwxq6eA
         w4hU2Im4yaOSlgtKtGBgr8hOYjc5NJ5RAEvnikUFIOsGGzvjjfEo5YAyuxjfSG/5Ryyy
         gS3zWjOXz64hMz7RmK37Azxic4zhdRk+O3mNJHljl2dSToKK0ccMKZ8Ovh0zIZqs7NRI
         I205uDfUE9fIiBj0oXPi2eopr+pCJDVkWeb0F1SXDQgiC4HcPb3upfkcE4nWU4oPhbwS
         nsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743759562; x=1744364362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i+BIOjdTujePTHxJ/EQhWONPgHHGsVjwziXnIVw+1U=;
        b=DBysWi24hRfo2gMj8Dl/+c4ucKJVGYSSDx6fGqLWq/d9t1aawfOlQqCXi1ySOLlsPr
         jsxZn9Vmd0S5Mp+U2xbRHHeBlLMJasluF20aOTpsaZek2aaZSjhPxVPQrOYWyAGwBYAa
         6W7JKhtl5LIEHUayRwvGxfVgu2MTalNsFqK85HErY1PmsV8AVq7dLQMCv/zV8xquYYaZ
         B5RVrrSB9MNkeqfqsAib13lb6T7wV8Wj2v0lA4qD/xKToQ6JtChHClx+0jYnFkNp8Pt9
         KTK7b7EWQC5v3hxEnuKv8QDnCE8olbhIJLEDICOK5ES2dvl4sQ8FQ+E/9NssHWIP1/JN
         hkhA==
X-Forwarded-Encrypted: i=1; AJvYcCUfZLF8dyAa4QFGUW79WJS/0tJ56A41SePpbk/zWn+kbuKAfzORVz38CA4P21ipAj2/HP8=@vger.kernel.org, AJvYcCUo1u7fhw0V3v6Sx/+oMXjYI79vu6TxFiSTIDlYXwuYxfu+ZY9xl+53CSDgl8/axfWiWgMWOt5Y@vger.kernel.org, AJvYcCXPrd68mBj10JZgGmV3d7wpjsi+Al82mCmQUJtZX/axOmwAt6J5Lck5Qxr/k372uQVPeV3OaGUnz0kD/gpB@vger.kernel.org
X-Gm-Message-State: AOJu0YyLx6eksNSzWMnxLTE1D1O3PJ9/wQse2CmlrWWww7ORt3vokAtO
	HBZdKPD4ygnNfSM9hzLlAvqFamNgZ/6ErtniIJiiSaOoAs8mZBVj
X-Gm-Gg: ASbGncuhe5RBbCJcYXlY/dG98NfXBNXMSaAfCdrSmaZx718VedD+xBmusBaOGvvgRcz
	AUSztxRJWEc9D9HSyR4A5viD8lhPPEbiZwobh5k1pqqdv+NfS+E0W9nnSr8ZR21Sy3BwRZoXsej
	luG9awNA+LoCComlgFKIkAf+EbYY8rTF2GGjqEYji4WmYCktyMxGFBIeZjyS0G7gGg8t/lSgmry
	5/Ia/C6b0jCjfEVPRdGoXZBNWiS6ln9D8h64aljAwJzf+YYG64iB4J1VNaSTCuZPQf7E05Z+Njs
	byAj8kSabR9sfOutoHyfKhDvGhGolhd5ycxbwmnx2lcEvyXmeZ32zH06u8XTX+0Vt80E730=
X-Google-Smtp-Source: AGHT+IHa/5L+A3L+9sEjmYyA6HOtMUS6wEI/lZdumO9FTs5UcgTfoCysQRymr5lSNhp1scktPuIOOg==
X-Received: by 2002:a05:6a20:9f8a:b0:1f5:931d:ca6d with SMTP id adf61e73a8af0-20107ea558cmr3208933637.1.1743759561831;
        Fri, 04 Apr 2025 02:39:21 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4e:bd30:f724:d4da:7a88:b9d5])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-af9bc41a665sm2080619a12.67.2025.04.04.02.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 02:39:21 -0700 (PDT)
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
Subject: [PATCH] virtio-net: disable delayed refill when pausing rx
Date: Fri,  4 Apr 2025 16:39:03 +0700
Message-ID: <20250404093903.37416-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
napi_disable() on the receive queue's napi. In delayed refill_work, it
also calls napi_disable() on the receive queue's napi. This can leads to
deadlock when napi_disable() is called on an already disabled napi. This
scenario can be reproducible by binding a XDP socket to virtio-net
interface without setting up the fill ring. As a result, try_fill_recv
will fail until the fill ring is set up and refill_work is scheduled.

This commit adds virtnet_rx_(pause/resume)_all helpers and fixes up the
virtnet_rx_resume to disable future and cancel all inflights delayed
refill_work before calling napi_disable() to pause the rx.

Fixes: 6a4763e26803 ("virtio_net: support rx queue resize")
Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Fixes: 09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")
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


