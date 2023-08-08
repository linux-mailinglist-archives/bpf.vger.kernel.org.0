Return-Path: <bpf+bounces-7212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADBD773792
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 05:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA21C20E12
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 03:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DEC17F0;
	Tue,  8 Aug 2023 03:20:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FA1FD6
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 03:20:30 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F5710E7
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 20:20:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bbc06f830aso35113285ad.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 20:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464828; x=1692069628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLQYdihKrZnqzA8pyJFR0KmRfev22Y9Nk5IK1CsNWSQ=;
        b=Kl4mmZ6wC30QI0KYvWfqwsTsY4ihiWC63YfNOwTtHsCTiPRlVcI029sp+MJOROKfoo
         2ZSjwgqwyuqMHwmhreAo6j9KGFeqiP4JTgT+5eIfWSoSekMcFAsja8NYdATAxJRAzZha
         LgHGf3BWqBvWvn5Ibdk2tZLiEfEVgU7EokhG1/IOeN7a4Al8TjQt7K1s0XC5mN196l4D
         ObsT7B1ydnVq2hD/R+PJ3GIdyMv70DAsQoTfRJJk0ZiyITCwrdg2BpYb2NUERKzwD37q
         7WVSfkeOaG8pIqpShLoRNDtTBASpWi86pCdSd4Sb5itRrV6POLS4x2CKUFvjHQ28tKtd
         jk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464828; x=1692069628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLQYdihKrZnqzA8pyJFR0KmRfev22Y9Nk5IK1CsNWSQ=;
        b=htrye+LsW0ASAQjrAPx0iEnLb3sao8aAoDLC2oyYUZr6pHbVjnEyoz9JRDeAPJuj3O
         HvPF2BvuS/JSAK3H/i4SecXYkEOBwY3C3sQgN6/PJnM7xrk6G/ZqLZWxgU92CH8gsEAI
         Kz2FNXwB2qUPbUFYo9jebY0Ex9C2EQEZTVJo1qpm8l14q6n7YlaTpi05Yn9BOeEgMkog
         Xbcg+J9kzW/VBp+jOn3UPb76g8zX2lYvbDrc7uFW4anuCJbv2Oh4KiuNho2yfcu+90yw
         JcZlyEsaanvND/VcbxXJ6mPq75oqnQbxxYkn30OmtBCe8SDqkVTsuKZcRVbxTT6/27jZ
         RL0g==
X-Gm-Message-State: AOJu0Yw15duGL68HlroPaWVkL5LBk88OY7+VQTFEBC7S8y9mrz5bEO43
	1NBEXm7OAvbUs+MtZ9tbGWdqvw==
X-Google-Smtp-Source: AGHT+IGLpz+58KIOin27q8snOr3n0kQTemVujLRn7G1yFjy5FFK/EozRt3B6Cq5rzwpxMgPHKWxaaw==
X-Received: by 2002:a17:902:d4c8:b0:1bc:1e17:6d70 with SMTP id o8-20020a170902d4c800b001bc1e176d70mr11761596plg.24.1691464827688;
        Mon, 07 Aug 2023 20:20:27 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:20:27 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 1/9] veth: Implement ethtool's get_ringparam() callback
Date: Tue,  8 Aug 2023 11:19:05 +0800
Message-Id: <20230808031913.46965-2-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

some xsk library calls get_ringparam() API to get the queue length
to init the xsk umem.

Implement that in veth so those scenarios can work properly.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..77e12d52ca2b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -255,6 +255,17 @@ static void veth_get_channels(struct net_device *dev,
 static int veth_set_channels(struct net_device *dev,
 			     struct ethtool_channels *ch);
 
+static void veth_get_ringparam(struct net_device *dev,
+			       struct ethtool_ringparam *ring,
+			     struct kernel_ethtool_ringparam *kernel_ring,
+			     struct netlink_ext_ack *extack)
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


