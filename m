Return-Path: <bpf+bounces-78305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE707D08E4C
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 12:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D254E3032CDB
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 11:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD5359F95;
	Fri,  9 Jan 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMeMYpaZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FD35970E
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958149; cv=none; b=KNTSypHwNA47A8oxlluwdTUojoRRVPa2+7jsXBFnUWu/66Er6Zdj54oUwWSUZBXXlQ4qogKCFvrTS4fL6c7DtTfxbAu8fwRMkNXpTG7xMe/T2Q5z+lBdndLwjoCzEKcJ4bHYU691tD06E0thYEo6FoR6inJT08j3EDVl85bVSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958149; c=relaxed/simple;
	bh=8v+hHUhF1CMhZOc8CLqelBf0LDjedL88Pj/OWXk4VqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UclytWiAzEwPi50ZAQKHyBIR2C/e0yaKCL8zxPBYXj0YfOQR9HNrIu47mIoxvoWl7yIBPbk7JminoXsOdXEtgquBuAfOpam/yKFwleY6jNb3kGlsZFu9QBZ1w0t0AcS7Ywo7/R9wigec4EnhtC4p6N8H2ZLdf3KFs1ivjdbMias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMeMYpaZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47774d3536dso26503865e9.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 03:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767958143; x=1768562943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdd1BJ8GnEBdSFCIL/A/+d2iA6KRo+nUubv323kPE0Y=;
        b=IMeMYpaZNNU//ZfeRXmfaPZKwfgILGS6vxfT1MrsWE4HPuqM4AGELGoVPU+RT/STJz
         kvBBJaO490+u8Q+GtHLj6l9ag08jxEwJuQa4YDMNgHyRUdAQTq2vZz9qlBLtXyXGSUCX
         ZyDCqJ2Izfmw7i2A9nAIh5TTtC5PmaOKEH6tYLWqKIA4VmKvyw7wWdGMkfL6L0KpParE
         5dA/J7ZKX64Vxv/OAQjIAt0l5MCn2ErlH+CrCDVryj0XkSmSLoJR7hd6drvo5rCTXa8c
         Jth8tYGj6smsuyWQINEIQ4M6dg7ZZhCXgzxN++ud2LRIZ0+ZW15Sojto3FpQah7Pl/6n
         as+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958143; x=1768562943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kdd1BJ8GnEBdSFCIL/A/+d2iA6KRo+nUubv323kPE0Y=;
        b=EIDqxjKAPfvlsW2nxcqUsINWVwFAdU6xHdZ7BoTA536Mc7Zi/2w91IBj7HplIHyTKD
         C8eJsOewmH6I4kNLDUYVuTUtb7Z8SLq7qj0hUgzHWLcamrKaQWI8tFhRnP2YPKa1DAE0
         Tn7fxBtQ5z8b9Qt4d6Oa18EnMVIrGsUFQoSqBWYfmic87Q/NezX4SPkY7bQiFCXcinTn
         rkP4mOfK42niL3h4lOnd05MRxVxcg/BF6y+n9PlKclKQ73yNaB6bw2QEiRfdaDhnYDGT
         tV0rQYgs8LvlgGI8U6GRK3+LFLSWaRTb7uEa8hxssexJERGpzqRk/bmgaRTOqbhlDTD4
         uDTA==
X-Forwarded-Encrypted: i=1; AJvYcCW9fxBnS5oGmh/1o/nbmt1TLOr1yQGzG0zAYqil25nEmEdalMn9Yu3eEvGGawVQ36E48SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIzAqKxAAkdqSz/Sp8EJCczZ0DSCMuQm/RyfKW2wvSCE0H2kCK
	i3Lr/j5Ra+0ujev2w1Y5xYeVzeDgATcjvVjVOCOYBkYxCQ4NBv2U2Csb
X-Gm-Gg: AY/fxX50RHmjsQ//aTWJT/h180HnmBbz5FI5r3U5Zg35fKE7U+x4uQRjEvI8ybA5QUc
	pwnIrX87EoXCxgblMPyN6FSj/FFZS6NID+0TlsK0HVTti4ctkYBBTlsKxTwqgCuyJs9XpHoQcPT
	RIHUw4PqP3kS0Lq2uE3SlFa2+HXfo5Uio9Z3G7ItYFg5ppQsUdWwHID1+o3gI/wX3mmoLbzq7pD
	geohm785u9PkqLh3oudSL82YCfIxTzmZKY7b2bGEdLZdvVZWsBm8mYIiwJUxmZhVSCC+M/xMBub
	jqKNPQiXeGqeKwSwgNAr3Fsyeiw7wyFGqc6dhrz0za660b7DhVPeqGxZn1rdvBgGX4wD2i1qp7T
	u8x/zw5MAwaKGMQp+lcRk3mvTJm3cgM2Qp+tj+jugRiybAj0bo9oRh0qUhjn6IcWwnYCxiZO4Pk
	njYNRESGBrXOm1n31ZAptaVm+WFut9V/wTpJN7mDfUN7lbTjTljdHB/a4lfRVWqG8Rk67W9A==
X-Google-Smtp-Source: AGHT+IHKuRS0IT/bpC+UJc4vXXX6jRdQbUKXx2O2o/AL3e7ieD8njEmbDbJnzHUsvm+xrORjKVPuZQ==
X-Received: by 2002:a05:600c:8215:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47d8486cd41mr104264645e9.10.1767958142195;
        Fri, 09 Jan 2026 03:29:02 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:29:00 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v8 3/9] net: add bare bone queue configs
Date: Fri,  9 Jan 2026 11:28:42 +0000
Message-ID: <6280519f4d4dcd9500f04fc1a79677a2df9b2fca.1767819709.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767819709.git.asml.silence@gmail.com>
References: <cover.1767819709.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need to pass extra parameters when allocating a queue for memory
providers. Define a new structure for queue configurations, and pass it
to qapi callbacks. It's empty for now, actual parameters will be added
in following patches.

Configurations should persist across resets, and for that they're
default-initialised on device registration and stored in struct
netdev_rx_queue. We also add a new qapi callback for defaulting a given
config. It must be implemented if a driver wants to use queue configs
and is optional otherwise.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       |  8 ++++++--
 drivers/net/ethernet/google/gve/gve_main.c      |  9 ++++++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c   | 10 ++++++----
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c    |  8 ++++++--
 drivers/net/netdevsim/netdev.c                  |  7 +++++--
 include/net/netdev_queues.h                     |  9 +++++++++
 include/net/netdev_rx_queue.h                   |  2 ++
 net/core/dev.c                                  | 17 +++++++++++++++++
 net/core/netdev_rx_queue.c                      | 12 +++++++++---
 9 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d17d0ea89c36..73f954da39b9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15902,7 +15902,9 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
-static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
+static int bnxt_queue_mem_alloc(struct net_device *dev,
+				struct netdev_queue_config *qcfg,
+				void *qmem, int idx)
 {
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt *bp = netdev_priv(dev);
@@ -16068,7 +16070,9 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	dst->rx_agg_bmap = src->rx_agg_bmap;
 }
 
-static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
+static int bnxt_queue_start(struct net_device *dev,
+			    struct netdev_queue_config *qcfg,
+			    void *qmem, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr, *clone;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 7eb64e1e4d85..c42640da15a5 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2616,8 +2616,9 @@ static void gve_rx_queue_mem_free(struct net_device *dev, void *per_q_mem)
 		gve_rx_free_ring_dqo(priv, gve_per_q_mem, &cfg);
 }
 
-static int gve_rx_queue_mem_alloc(struct net_device *dev, void *per_q_mem,
-				  int idx)
+static int gve_rx_queue_mem_alloc(struct net_device *dev,
+				  struct netdev_queue_config *qcfg,
+				  void *per_q_mem, int idx)
 {
 	struct gve_priv *priv = netdev_priv(dev);
 	struct gve_rx_alloc_rings_cfg cfg = {0};
@@ -2638,7 +2639,9 @@ static int gve_rx_queue_mem_alloc(struct net_device *dev, void *per_q_mem,
 	return err;
 }
 
-static int gve_rx_queue_start(struct net_device *dev, void *per_q_mem, int idx)
+static int gve_rx_queue_start(struct net_device *dev,
+			      struct netdev_queue_config *qcfg,
+			      void *per_q_mem, int idx)
 {
 	struct gve_priv *priv = netdev_priv(dev);
 	struct gve_rx_ring *gve_per_q_mem;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 07fc4d2c8fad..0e2132b58257 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5596,8 +5596,9 @@ struct mlx5_qmgmt_data {
 	struct mlx5e_channel_param cparam;
 };
 
-static int mlx5e_queue_mem_alloc(struct net_device *dev, void *newq,
-				 int queue_index)
+static int mlx5e_queue_mem_alloc(struct net_device *dev,
+				 struct netdev_queue_config *qcfg,
+				 void *newq, int queue_index)
 {
 	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
 	struct mlx5e_priv *priv = netdev_priv(dev);
@@ -5658,8 +5659,9 @@ static int mlx5e_queue_stop(struct net_device *dev, void *oldq, int queue_index)
 	return 0;
 }
 
-static int mlx5e_queue_start(struct net_device *dev, void *newq,
-			     int queue_index)
+static int mlx5e_queue_start(struct net_device *dev,
+			     struct netdev_queue_config *qcfg,
+			     void *newq, int queue_index)
 {
 	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
 	struct mlx5e_priv *priv = netdev_priv(dev);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 13d508ce637f..e36ed25462b4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2809,7 +2809,9 @@ void fbnic_napi_depletion_check(struct net_device *netdev)
 	fbnic_wrfl(fbd);
 }
 
-static int fbnic_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
+static int fbnic_queue_mem_alloc(struct net_device *dev,
+				 struct netdev_queue_config *qcfg,
+				 void *qmem, int idx)
 {
 	struct fbnic_net *fbn = netdev_priv(dev);
 	const struct fbnic_q_triad *real;
@@ -2861,7 +2863,9 @@ static void __fbnic_nv_restart(struct fbnic_net *fbn,
 		netif_wake_subqueue(fbn->netdev, nv->qt[i].sub0.q_idx);
 }
 
-static int fbnic_queue_start(struct net_device *dev, void *qmem, int idx)
+static int fbnic_queue_start(struct net_device *dev,
+			     struct netdev_queue_config *qcfg,
+			     void *qmem, int idx)
 {
 	struct fbnic_net *fbn = netdev_priv(dev);
 	struct fbnic_napi_vector *nv;
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 6927c1962277..6285fbefe38a 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -758,7 +758,9 @@ struct nsim_queue_mem {
 };
 
 static int
-nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
+nsim_queue_mem_alloc(struct net_device *dev,
+		     struct netdev_queue_config *qcfg,
+		     void *per_queue_mem, int idx)
 {
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
@@ -807,7 +809,8 @@ static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
 }
 
 static int
-nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
+nsim_queue_start(struct net_device *dev, struct netdev_queue_config *qcfg,
+		 void *per_queue_mem, int idx)
 {
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 541e7d9853b1..f6f1f71a24e1 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -14,6 +14,9 @@ struct netdev_config {
 	u8	hds_config;
 };
 
+struct netdev_queue_config {
+};
+
 /* See the netdev.yaml spec for definition of each statistic */
 struct netdev_queue_stats_rx {
 	u64 bytes;
@@ -130,6 +133,8 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
  *			   for this queue. Return NULL on error.
  *
+ * @ndo_default_qcfg:	Populate queue config struct with defaults. Optional.
+ *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
  * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
  * be called for an interface which is open.
@@ -137,16 +142,20 @@ void netdev_stat_queue_sum(struct net_device *netdev,
 struct netdev_queue_mgmt_ops {
 	size_t	ndo_queue_mem_size;
 	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
+				       struct netdev_queue_config *qcfg,
 				       void *per_queue_mem,
 				       int idx);
 	void	(*ndo_queue_mem_free)(struct net_device *dev,
 				      void *per_queue_mem);
 	int	(*ndo_queue_start)(struct net_device *dev,
+				   struct netdev_queue_config *qcfg,
 				   void *per_queue_mem,
 				   int idx);
 	int	(*ndo_queue_stop)(struct net_device *dev,
 				  void *per_queue_mem,
 				  int idx);
+	void	(*ndo_default_qcfg)(struct net_device *dev,
+				    struct netdev_queue_config *qcfg);
 	struct device *	(*ndo_queue_get_dma_dev)(struct net_device *dev,
 						 int idx);
 };
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 8cdcd138b33f..cfa72c485387 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -7,6 +7,7 @@
 #include <linux/sysfs.h>
 #include <net/xdp.h>
 #include <net/page_pool/types.h>
+#include <net/netdev_queues.h>
 
 /* This structure contains an instance of an RX queue. */
 struct netdev_rx_queue {
@@ -27,6 +28,7 @@ struct netdev_rx_queue {
 	struct xsk_buff_pool            *pool;
 #endif
 	struct napi_struct		*napi;
+	struct netdev_queue_config	qcfg;
 	struct pp_memory_provider_params mp_params;
 } ____cacheline_aligned_in_smp;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 36dc5199037e..a1d394addaef 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11270,6 +11270,21 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
 	}
 }
 
+static void init_rx_queue_cfgs(struct net_device *dev)
+{
+	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	struct netdev_rx_queue *rxq;
+	int i;
+
+	if (!qops || !qops->ndo_default_qcfg)
+		return;
+
+	for (i = 0; i < dev->num_rx_queues; i++) {
+		rxq = __netif_get_rx_queue(dev, i);
+		qops->ndo_default_qcfg(dev, &rxq->qcfg);
+	}
+}
+
 /**
  * register_netdevice() - register a network device
  * @dev: device to register
@@ -11315,6 +11330,8 @@ int register_netdevice(struct net_device *dev)
 	if (!dev->name_node)
 		goto out;
 
+	init_rx_queue_cfgs(dev);
+
 	/* Init, if this function is available */
 	if (dev->netdev_ops->ndo_init) {
 		ret = dev->netdev_ops->ndo_init(dev);
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index a0083f176a9c..86d1c0a925e3 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -22,6 +22,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	struct netdev_queue_config qcfg;
 	void *new_mem, *old_mem;
 	int err;
 
@@ -31,6 +32,10 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 
 	netdev_assert_locked(dev);
 
+	memset(&qcfg, 0, sizeof(qcfg));
+	if (qops->ndo_default_qcfg)
+		qops->ndo_default_qcfg(dev, &qcfg);
+
 	new_mem = kvzalloc(qops->ndo_queue_mem_size, GFP_KERNEL);
 	if (!new_mem)
 		return -ENOMEM;
@@ -41,7 +46,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		goto err_free_new_mem;
 	}
 
-	err = qops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
+	err = qops->ndo_queue_mem_alloc(dev, &qcfg, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
 
@@ -54,7 +59,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		if (err)
 			goto err_free_new_queue_mem;
 
-		err = qops->ndo_queue_start(dev, new_mem, rxq_idx);
+		err = qops->ndo_queue_start(dev, &qcfg, new_mem, rxq_idx);
 		if (err)
 			goto err_start_queue;
 	} else {
@@ -66,6 +71,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	kvfree(old_mem);
 	kvfree(new_mem);
 
+	rxq->qcfg = qcfg;
 	return 0;
 
 err_start_queue:
@@ -76,7 +82,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	 * WARN if we fail to recover the old rx queue, and at least free
 	 * old_mem so we don't also leak that.
 	 */
-	if (qops->ndo_queue_start(dev, old_mem, rxq_idx)) {
+	if (qops->ndo_queue_start(dev, &rxq->qcfg, old_mem, rxq_idx)) {
 		WARN(1,
 		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
 		     rxq_idx);
-- 
2.52.0


