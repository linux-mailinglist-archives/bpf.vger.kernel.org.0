Return-Path: <bpf+bounces-6858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2E76EBC1
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E1D1C2157E
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA421D49;
	Thu,  3 Aug 2023 14:05:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF23D8E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:05:56 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C293C31
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:05:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb775625e2so7268535ad.1
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071521; x=1691676321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lti4noGvWp81QMD78qgE1vMb8ru0CmeNy8GFo0ds5M=;
        b=ARPb/1sWh5T9p5GWjB03DuP/6QZsEazyqs/OXDGx5lkxhGk5XSHzLq7ODIElIYrFOb
         w6NmJppncUr5m/HHnhC+ubn3OXKSO93n7CunQ91Kqvw7Tf48agwl/sfkzVFunkSBsUwL
         JDSPtcxynczQTY4LUWfzEj8vza7wxX8VrrPUBZDCl9dsKp1h0oShS+rTDk01lxfzOOiw
         y6/9vPodJQo4JciEVHY9A/tNsegQ1GZOZrbkayOHoEORYyBxV7vd9Endd5Bcsumt2EBl
         c0qPe6AsKe7fZ1nTpg/XssSjVOlfsWqyaGzoMubvQPNbG7/icyQChTqyeTV/5C8talsZ
         Co2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071521; x=1691676321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lti4noGvWp81QMD78qgE1vMb8ru0CmeNy8GFo0ds5M=;
        b=dmTgQm8DFKCctwEWkmvnH8PHHSoikjYu4o+6pMPguGTsASSsdQbxilc3wDIYtQnsA3
         wZ85d/GrbnDieCfvDuO+Wv41J2EK2KYRYvRP0x0E8YgWtNOHSfJmRAy66b3T/KlX76Me
         YoLn7ydQGF77T7ELeWegF+BjgvjigN1KFr+oIHtwf/xrOLJdryYgbpCtrxoURVtiuaBL
         MebcK86pGXxCg8BrQr66wFEIWJmMiNrZ40qrZTsKx19fVBlCd3s5IrWXYqkCwfzUgPJr
         KIPb2pQvfFJrUgvfKjtxxXp3tT4CAan6m1BSsDC6K9xvpVnEEDPVDJvMNK/Lz3c7b0fh
         uF/A==
X-Gm-Message-State: ABy/qLY0/ySHd2ZAWhC2drNrxtfCLqruMCtY8dtAGGoQDoV///OzPcy0
	k2i415cLDU0v6FvPOkN+3BvNcw==
X-Google-Smtp-Source: APBJJlFo2cNFMR6i7kmoV21NH6/h1fH77lSujUPrSipJAFbQsyZD+jUKaJqFZK1ENQnjLqiibq8j6w==
X-Received: by 2002:a17:902:6943:b0:1b8:6984:f5e5 with SMTP id k3-20020a170902694300b001b86984f5e5mr18474453plt.12.1691071521455;
        Thu, 03 Aug 2023 07:05:21 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:05:20 -0700 (PDT)
From: "huangjie.albert" <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Menglong Dong <imagedong@tencent.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 01/10] veth: Implement ethtool's get_ringparam() callback
Date: Thu,  3 Aug 2023 22:04:27 +0800
Message-Id: <20230803140441.53596-2-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

some xsk libary calls get_ringparam() API to get the queue length
to init the xsk umem.

Implement that in veth so those scenarios can work properly.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..c2b431a7a017 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -255,6 +255,17 @@ static void veth_get_channels(struct net_device *dev,
 static int veth_set_channels(struct net_device *dev,
 			     struct ethtool_channels *ch);
 
+static void veth_get_ringparam(struct net_device *dev,
+				  struct ethtool_ringparam *ring,
+				  struct kernel_ethtool_ringparam *kernel_ring,
+				  struct netlink_ext_ack *extack)
+{
+	ring->rx_max_pending = VETH_RING_SIZE;
+	ring->tx_max_pending = VETH_RING_SIZE;
+	ring->rx_pending = VETH_RING_SIZE;
+	ring->tx_pending = VETH_RING_SIZE;
+}
+
 static const struct ethtool_ops veth_ethtool_ops = {
 	.get_drvinfo		= veth_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -265,6 +276,7 @@ static const struct ethtool_ops veth_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_channels		= veth_get_channels,
 	.set_channels		= veth_set_channels,
+	.get_ringparam		= veth_get_ringparam,
 };
 
 /* general routines */
-- 
2.20.1


