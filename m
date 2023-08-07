Return-Path: <bpf+bounces-7153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBCF7723C8
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 14:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A039B1C20B5D
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 12:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1D4101ED;
	Mon,  7 Aug 2023 12:22:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE77101DF
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 12:22:57 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB2E74
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 05:22:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc6bfc4b58so4829885ad.1
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691410967; x=1692015767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C7bHaMSd+SY+pPB7Vtx4/6UZIJ72tWmfxoauVOSVx0=;
        b=l4xJiWEEbz2IEuorkINwxBVQ/5PnK9fhGmaLj2DODmbsWX93ppJtAyvJqtF6Ztvco0
         qKs5yAkD9hAZSetvftFm3zxR/knZZ++YSY80dIXgMn379PWrH9U+ANOEFtJ5x6RdTS6y
         XYQRI5TmfzgqmA/jmahEN6XMtndm/UPo/TG3A38K7ZeoLVOpfRYn0RtvpgZ6YhmhUr1J
         CI+kA1hDqOrfZX6Sz9COvQCAz3m1QiMtcNQs5WrsThDatldjRHsjJs4H/HTeQfp2eoCk
         DWewbiMqktZxszv2kbOsjYlz7Zxvm2rJ0/8QkdTvMZdbCRocQG6aL3AflCYjgw6/LhuT
         Q8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410967; x=1692015767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C7bHaMSd+SY+pPB7Vtx4/6UZIJ72tWmfxoauVOSVx0=;
        b=Z40IspDf6nVZ/H6qjRg7pc4dVw0MBjvs9sq2J1EBQCut1J7BPyPTFNlWQB78PYE1td
         GlH1VR2g4O7YsifV0cpGpjOUvMpFvLpETTDVGBnCtuppwyU1hUmYY8YdJ8omIogj3RKb
         pYOEfq+5eHavZvdcPBrdtM+Co7QfvCmnGfbWwdZU0ycvX45WL/JjCP/TXMRMjayK42L3
         g0Iu4v0GoRv/CdU9KdzCNQtkKISsYfeX38rlkPqQWM/tFZCaOwfVMR6jF5A+WoHX5Cx5
         KAQS3Fxcy5oSRiAoClevqGUyROUf3otdTY/Eq+gpWWY235y6mDvyYvwUf5RJkCVK2jcl
         vMRQ==
X-Gm-Message-State: AOJu0YwJQdyDAYu2Bs3XeuciXEkP95GBrwkQ3gzzEqCIWIYD6jLIChat
	gJGO+dBUKyATLVe1oJvZKigfRQ==
X-Google-Smtp-Source: AGHT+IE89np5AUQBiPFRPVGYnS82GPk320IaciVQZYSLKkUoZ+GQA8NGhOsYaOaNrp4N9CL1ZFsYag==
X-Received: by 2002:a17:902:82c5:b0:1b8:6cae:4400 with SMTP id u5-20020a17090282c500b001b86cae4400mr7028201plz.37.1691410966789;
        Mon, 07 Aug 2023 05:22:46 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id jk21-20020a170903331500b001bbfa86ca3bsm6819846plb.78.2023.08.07.05.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:22:46 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: 
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC v2 Optimizing veth xsk performance 3/9] veth: add support for send queue
Date: Mon,  7 Aug 2023 20:22:38 +0800
Message-Id: <20230807122238.85463-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

in order to support native af_xdp for veth. we
need support for send queue for napi tx.
the upcoming patch will make use of it.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 77e12d52ca2b..25faba879505 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -56,6 +56,11 @@ struct veth_rq_stats {
 	struct u64_stats_sync	syncp;
 };
 
+struct veth_sq_stats {
+	struct veth_stats	vs;
+	struct u64_stats_sync	syncp;
+};
+
 struct veth_rq {
 	struct napi_struct	xdp_napi;
 	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
@@ -69,11 +74,25 @@ struct veth_rq {
 	struct page_pool	*page_pool;
 };
 
+struct veth_sq {
+	struct napi_struct	xdp_napi;
+	struct net_device	*dev;
+	struct xdp_mem_info	xdp_mem;
+	struct veth_sq_stats	stats;
+	u32 queue_index;
+	/* for xsk */
+	struct {
+		struct xsk_buff_pool __rcu *pool;
+		u32 last_cpu;
+	} xsk;
+};
+
 struct veth_priv {
 	struct net_device __rcu	*peer;
 	atomic64_t		dropped;
 	struct bpf_prog		*_xdp_prog;
 	struct veth_rq		*rq;
+	struct veth_sq		*sq;
 	unsigned int		requested_headroom;
 };
 
@@ -1495,6 +1514,15 @@ static int veth_alloc_queues(struct net_device *dev)
 		u64_stats_init(&priv->rq[i].stats.syncp);
 	}
 
+	priv->sq = kcalloc(dev->num_tx_queues, sizeof(*priv->sq), GFP_KERNEL);
+	if (!priv->sq)
+		return -ENOMEM;
+
+	for (i = 0; i < dev->num_tx_queues; i++) {
+		priv->sq[i].dev = dev;
+		u64_stats_init(&priv->sq[i].stats.syncp);
+	}
+
 	return 0;
 }
 
@@ -1503,6 +1531,7 @@ static void veth_free_queues(struct net_device *dev)
 	struct veth_priv *priv = netdev_priv(dev);
 
 	kfree(priv->rq);
+	kfree(priv->sq);
 }
 
 static int veth_dev_init(struct net_device *dev)
-- 
2.20.1


