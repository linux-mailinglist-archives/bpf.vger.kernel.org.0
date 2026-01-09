Return-Path: <bpf+bounces-78309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6C4D08E3D
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 12:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD2DD300B9ED
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 11:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626A35C191;
	Fri,  9 Jan 2026 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXe9VPz5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C735B13E
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958158; cv=none; b=cVck1p8Z4NoqCnvzomaILQJySFl+s1+WK/fIoUGRpm7l2r1u6QG3Z9xS1dqOWNM1RLHSpotY1qlIvliOrpM5ORyUasUnLBgxg8Q69r9/T+KIhD66hRfAhcj2zH1Xo5WN4gDrLyODQhWCSyPeAvPNgbnisqmi8Pd4TjaY/yBwarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958158; c=relaxed/simple;
	bh=F6waAxUTN0XHkxjyQT+jUXiZnFRXTIpv+p7I9hYKiIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+Rh0ThFstrHlg5Brckc4EytiYnLVH3P35jtK6MDIM5XI0m2MMzRZBkmWjd5RFsdFobgNNHquROhPBi7Vw6ug6Y4J1gCZyz1UGesJJQRBVD5ipFntjKOFAonhLUXpFbHFkYCSAa1SY9lVbfZ70MJWqorY0NfCVrGPyjJXir4lZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXe9VPz5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47a8195e515so30228215e9.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 03:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767958153; x=1768562953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkGYuXz+QxHGRROmceDvRDL3xnFuc5UQrONsfTFdwcU=;
        b=hXe9VPz5zpwUdxHdQiNA7nI7D89AQSveggNCgVpkqkyCGsukQrI2unq7opkC9S70QQ
         Ma3zfkPfDUchjPMEWupLTGaO52psc0mwkWd9sHH0rVDMpJ/s47PPp/C/qQYRoWs5cWOw
         p0zwWsuRel4KPLiXU1oykrX0YVN3ZClfZLk69wJYfhTz2dgqJjX5InV/gzoij6MTQFzj
         ZZcTi2drf7HmcEjpmvWNx1GOynGzLktFNmg/od6VyS2UB7nPosKJXOSHbHPMZufx9OxL
         CuzbUvqb6Ugpd5rIAnXpo+GMO05CiFtWBfNlTCgqkedlFa8dFNmiVxO9h0hHzAqwFhRW
         NJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958153; x=1768562953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkGYuXz+QxHGRROmceDvRDL3xnFuc5UQrONsfTFdwcU=;
        b=Dw4Q+4mHAV5+Wty6FqTfotlyj1BzoLmim/uIJwNjv57bSTP334zLfHYvQWYfmQbQCx
         vekMKguOsmxQczaAEkiBqy9YNCn5K1wIGNcL5QYIf/xmXLmnICiEWt5NmxJbhqPlYTyC
         gUo6tcQp2ksb/RWfiYWr1dLPGzdC5s0OPniYxB/cMVyuRS8ICVyo6iHtB6D+dHf+jEr6
         36HKtDKWW/+Azw6t82XlEDvcKcENJi+zXurhTEqOaMfpb/AL27CSPh0QA5HFADARhh++
         iOfHjnjvbRbRsvuP2sNj8mU/J4LtrRA48Tp/sKUkmXZUWem2Dr3JMVpMFu/AHVLSUDXW
         ySdg==
X-Forwarded-Encrypted: i=1; AJvYcCWiPWU0/bjHi7VQAIXNWRuv0ywunwPiKbRbhQn0adg7luQXzs1hskKRXFOi17V9a9K47Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4k7Z+/gdCMERPfYXMhzZzXPS2FfiLk835KBJNiQLjE84VQko
	dsiEmIgkFjR+ob6+c8YtZI9s9GkQoALO/wSR8Yi5Rj4nXxJuxsM5xt8g
X-Gm-Gg: AY/fxX6Ja8JtV4seeVyPdAULGQw3qJtRqoPJGdJu7oIO4ppiJ+nIDssM0pUGO5PtXyB
	tVB/PBuuigegFUJtI53G7TzlG7Sk5rHL5mOQ80T4MMZ0Y53SytA3UliGaGdJsohmsHW+KQhcgLf
	7S8ljvtn2phbBf1sYsdopaENyxSnw2Vd04X0WjPkpAJGQlVcYsUvXyZoTA/l6RggiMqYOwYcCMY
	puBYbxsmbLtZRle6E43pTldXTaUZCLAPtOd2lbS2NHfHHGiF0c7X4zbYm+VsOfXVHiYQz6X9FoA
	39fyEnVF5w81y0IobIv/MnQrQx7AZmdo6wizNpa4u/rS5lB397U8j/XTQvPeyY+qnYnafO5AWXD
	KK2XBHHDcnfeG+Oeh0R3fcV/JNEfBLkV+F/d6WJOhfNh5WG2tOppzoVBRatr9V0sO6aa0vTSs6E
	9Mqv92l1Rw2w1z1As69BMwqD/e4i1EUTgJl4Wdtl76BGfMIb4tmGe7kGO/LgLN/SJ3Kbe4Glk01
	Mbk9CeY
X-Google-Smtp-Source: AGHT+IFSy1+lFxUURQmqDSNKN0HOOFkFOx1ujyLXJg2nypF43Lq0YrQtt9+vrxTHS0Rrgmo+7XmdqQ==
X-Received: by 2002:a05:600c:1d14:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-47d84b0a7bdmr104836275e9.1.1767958152875;
        Fri, 09 Jan 2026 03:29:12 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:29:12 -0800 (PST)
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
Subject: [PATCH net-next v8 7/9] eth: bnxt: support qcfg provided rx page size
Date: Fri,  9 Jan 2026 11:28:46 +0000
Message-ID: <28028611f572ded416b8ab653f1b9515b0337fba.1767819709.git.asml.silence@gmail.com>
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
index 137e348d2b9c..3ffe4fe159d3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4325,6 +4325,7 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		struct bnxt_rx_ring_info *rxr;
 		struct bnxt_tx_ring_info *txr;
 		struct bnxt_ring_struct *ring;
+		struct netdev_rx_queue *rxq;
 
 		if (!bnapi)
 			continue;
@@ -4342,7 +4343,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
-		rxr->rx_page_size = BNXT_RX_PAGE_SIZE;
+		rxq = __netif_get_rx_queue(bp->dev, i);
+		rxr->rx_page_size = rxq->qcfg.rx_page_size;
 
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
@@ -15932,6 +15934,29 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
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
+	     qcfg->rx_page_size != BNXT_RX_PAGE_SIZE)
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
@@ -15944,6 +15969,10 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	if (!bp->rx_ring)
 		return -ENETDOWN;
 
+	rc = bnxt_validate_qcfg(bp, qcfg);
+	if (rc < 0)
+		return rc;
+
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 	memcpy(clone, rxr, sizeof(*rxr));
@@ -15955,6 +15984,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
 	clone->need_head_pool = false;
+	clone->rx_page_size = qcfg->rx_page_size;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
@@ -16081,6 +16111,8 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	src_ring = &src->rx_agg_ring_struct;
 	src_rmem = &src_ring->ring_mem;
 
+	dst->rx_page_size = src->rx_page_size;
+
 	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
 	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
 	WARN_ON(dst_rmem->flags != src_rmem->flags);
@@ -16235,6 +16267,8 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_mem_free	= bnxt_queue_mem_free,
 	.ndo_queue_start	= bnxt_queue_start,
 	.ndo_queue_stop		= bnxt_queue_stop,
+	.ndo_default_qcfg	= bnxt_queue_default_qcfg,
+	.supported_params	= QCFG_RX_PAGE_SIZE,
 };
 
 static void bnxt_remove_one(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 4c880a9fba92..d245eefbbdda 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -760,6 +760,7 @@ struct nqe_cn {
 #endif
 
 #define BNXT_RX_PAGE_SIZE (1 << BNXT_RX_PAGE_SHIFT)
+#define BNXT_MAX_RX_PAGE_SIZE BIT(15)
 
 #define BNXT_MAX_MTU		9500
 
-- 
2.52.0


