Return-Path: <bpf+bounces-79076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A3BD26845
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A37C730DFC04
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A2D3BF310;
	Thu, 15 Jan 2026 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiqesj0s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149F3C1987
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497161; cv=none; b=n7b9t0/VkjUx7geTeJwllEwDiRV/s4HC89ZpN3L0mjqzotmoqN7AK/YJfH1/+lQTSGpSXv8riyNdYF0RVt2nIoDlnwCv6iue+PdUC7WjJHd982GHXNxaOjL+dhlKERmSMs+U1IJq9SMuYH5mX/Bkpz0TzIs2swbG5P6wRvlRBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497161; c=relaxed/simple;
	bh=w63yj/3XJuKjz144FSyN9g/slARmBLRuU9i9NwK0eJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOUYKhA6LTjNy9RObhjX3GCtG4bcjCkD2DgCs0k3K77m7P7+joFb3Xo2cxrG9qfi2BYqEzdqMeVDxF7FYobO6JV9x/WAJWayllN2iLEeSTDEC5UySVFwOgRwXDGZLZ68n/ACpmyflSNPB2Q+woEA9XgjUo9tUMxg8J/ABgugoIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiqesj0s; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so8728285e9.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 09:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497157; x=1769101957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPBVfrUasjXxxiO4appWlnagZh47/ZZDY5dXmpSB7pw=;
        b=hiqesj0sxvc+us67WpybM7ve5RTeOigkcN84tPQ+/U0teBVX0m7xui94H0JLZGFi4n
         05aUqCF8kiifBwtlSAi1Y14KMaS6m/IhIKN0heY4p7YC/p9PfjxuW7zwK9XFjBVq95Jk
         1Bx8gnpUkW3Y2LwnMfLV88qE6z8z/cvLdW0CEDHnA7K0cl4EINwQ/SVzSyo9vxDJ71fx
         2eDO1p6ELeowzo04obADm80hZNKf+rYUx87oo0JCilwKZbD1tIQnkORMb3413r59oKlb
         y0B4VB04NeXk9IkwEGEQy+FD1IlCqkKqD1KaOl+vVir+B8hfLD3Hrqu5xxCXqJhYdjQo
         2NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497157; x=1769101957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wPBVfrUasjXxxiO4appWlnagZh47/ZZDY5dXmpSB7pw=;
        b=hXsfCG1sx3jCl6Czd5WhnDcAMR/avCZsMQ32nJE4+UriER49MYsH1u9b34mAFxoqND
         agn4rdtarZZao9z6W2l9PTkWHP7xYJduZWFy50TMZ0Sw5PeCa/W/+mudWUjFXUtlrBMa
         fZWhdeitO74Wice98RMB1B1kGYqlhqqtLUAx4DVR2bv/3GClBwPg3XiDg7mCHsmixxNl
         LwufMRUvqYPLgOFP9Fu2bib7H85q8xXJM1rn8p/UAyuF/tdCnr+LrweihBLtpjpVEule
         8wUUQMKvYgr5R+iYrL4pmKoov5giB2t2kUS4NOmeZ59y83EtESD8YJv1WFKfyQjnAPT6
         AEdw==
X-Forwarded-Encrypted: i=1; AJvYcCV2IBHYK2ANvuNyLbYq7/MjHhbRvPq0X5Rz7xl6LdATMmTj3oVIybFrhXNVUpRIisnZsBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnxsq1hYw1+cx3gV3t0Sh30VSRvJ2/w+UigVUlAK6iIf9Aqw0
	fiVMeZPgo0jE/LZ3OrN+S0lqBVtPUi0sHB69j5XMiyEBvElylQtM4vIy
X-Gm-Gg: AY/fxX5vEEAZ/dP14lMtYRy9e0mpzOQD74LSZHp468DmgKfOYSLrUmDLWHqUTmIxuxA
	j/8+LghhCPifHWV9thkSLjBtpluwMrcehSNUFuiOQSo+oPCU1F0btnr3KkggJwrcD9jYmGRIwAG
	+MpOo55H4TPoQj+/yHSXnZv0q8Q3Kg65GD4AAxYspkQiQ0Nh1BbWn1nBLxrLwEtO8rjSXS/XJE5
	ykbWqKlS7QxcKr1Dzu01gzKSaJe6e+Aup9Hnr31tJtRd7iu74289eiIVvrDZr+9lspqhCiFBnpO
	fW5wzXUWB3WMKncWoklQsi+ViS+4sSd+kYlwmkmI0BtRqX/fUcBStuAziFgFMHYjalgGbpFOYp6
	As0v8KyQeM7+nWqx8e7vdDrB2a8VkxZfxQmn1kiB/IJiMsobBzDV7V+gW0Tb/dJ2Rrpi4qe9Cgn
	sQjKKteHmgD8JDWVy2NuPjw4MfYhdLvosC1ttQTsrezLTMY2gc4zaOufxGGH71/ygBH/VpTCogD
	nMjzCLPosfbJvfH6A==
X-Received: by 2002:a05:600c:c08e:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-4801e4a38c8mr2774705e9.35.1768497156723;
        Thu, 15 Jan 2026 09:12:36 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:35 -0800 (PST)
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
	kernel-team@meta.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v9 7/9] eth: bnxt: support qcfg provided rx page size
Date: Thu, 15 Jan 2026 17:12:00 +0000
Message-ID: <f96e1b35779e153be266fd7de50bda0c5553ad21.1768493907.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
References: <cover.1768493907.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for qcfg provided rx page sizes. For that, implement
the ndo_default_qcfg callback and validate the config on restart. Also,
use the current config's value in bnxt_init_ring_struct to retain the
correct size across resets.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f011cf792abe..f4f265a25a4a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4331,6 +4331,7 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		struct bnxt_rx_ring_info *rxr;
 		struct bnxt_tx_ring_info *txr;
 		struct bnxt_ring_struct *ring;
+		struct netdev_rx_queue *rxq;
 
 		if (!bnapi)
 			continue;
@@ -4348,7 +4349,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
-		rxr->rx_page_size = BNXT_RX_PAGE_SIZE;
+		rxq = __netif_get_rx_queue(bp->dev, i);
+		rxr->rx_page_size = rxq->qcfg.rx_page_size;
 
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
@@ -15938,6 +15940,29 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
+static void bnxt_queue_default_qcfg(struct net_device *dev,
+				    struct netdev_queue_config *qcfg)
+{
+	qcfg->rx_page_size = BNXT_RX_PAGE_SIZE;
+}
+
+static int bnxt_validate_qcfg(struct bnxt *bp, struct netdev_queue_config *qcfg)
+{
+	/* Older chips need MSS calc so rx_page_size is not supported */
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
+	    qcfg->rx_page_size != BNXT_RX_PAGE_SIZE)
+		return -EINVAL;
+
+	if (!is_power_of_2(qcfg->rx_page_size))
+		return -ERANGE;
+
+	if (qcfg->rx_page_size < BNXT_RX_PAGE_SIZE ||
+	    qcfg->rx_page_size > BNXT_MAX_RX_PAGE_SIZE)
+		return -ERANGE;
+
+	return 0;
+}
+
 static int bnxt_queue_mem_alloc(struct net_device *dev,
 				struct netdev_queue_config *qcfg,
 				void *qmem, int idx)
@@ -15950,6 +15975,10 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	if (!bp->rx_ring)
 		return -ENETDOWN;
 
+	rc = bnxt_validate_qcfg(bp, qcfg);
+	if (rc < 0)
+		return rc;
+
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 	memcpy(clone, rxr, sizeof(*rxr));
@@ -15961,6 +15990,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
 	clone->need_head_pool = false;
+	clone->rx_page_size = qcfg->rx_page_size;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
@@ -16087,6 +16117,8 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	src_ring = &src->rx_agg_ring_struct;
 	src_rmem = &src_ring->ring_mem;
 
+	dst->rx_page_size = src->rx_page_size;
+
 	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
 	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
 	WARN_ON(dst_rmem->flags != src_rmem->flags);
@@ -16241,6 +16273,8 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_mem_free	= bnxt_queue_mem_free,
 	.ndo_queue_start	= bnxt_queue_start,
 	.ndo_queue_stop		= bnxt_queue_stop,
+	.ndo_default_qcfg	= bnxt_queue_default_qcfg,
+	.supported_params	= QCFG_RX_PAGE_SIZE,
 };
 
 static void bnxt_remove_one(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9eaef6d7c150..dc7227a69b7b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -760,6 +760,7 @@ struct nqe_cn {
 #endif
 
 #define BNXT_RX_PAGE_SIZE (1 << BNXT_RX_PAGE_SHIFT)
+#define BNXT_MAX_RX_PAGE_SIZE BIT(15)
 
 #define BNXT_MAX_MTU		9500
 
-- 
2.52.0


