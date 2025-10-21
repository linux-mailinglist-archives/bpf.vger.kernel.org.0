Return-Path: <bpf+bounces-71568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ECABF6B1E
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB424055A7
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1723370EB;
	Tue, 21 Oct 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3StfoX5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD32459F7
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052358; cv=none; b=H3mRoA4R8uSrXBrcdg5eC+LBpszvn7YCN0BIVkpb12hrzdFbun39GJa2eW/QXs1Wc7nuCF+cnK0zrsEQEXKHpiabeV8zdPbp0TOWlgPttLWrSCGeiUei8vpzZtyX/Uu1TzvOX/bFQCh5WmRdKBTI6emnbdDVngLCngCRYSds6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052358; c=relaxed/simple;
	bh=7+jDJzQgtyEPYcVuSgV1uYiiukpFkSoFMl0hFJQNCTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qtvCIlXuAG0jisOH1BIpJVJFXtorTxH7dlP+/ZmYgUouUrCOVJJ9hP0BLdCWklNOH8HlQHnRfJP0st+d3rvxAiL4d2xt0n3kyhykbzZZfFUjf5Q3lXgoeqOQqjDYDt3EFX9aMn+Gggx9NQgGbV7LIR1Qrl7cDWhotIWuIfOW1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3StfoX5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290ab379d48so50809135ad.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052356; x=1761657156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkFgnaC4/fY4vKIhcUTMhNPw5g98lm3qgHiWbbZwuIc=;
        b=W3StfoX5yLEM7B9wF5zRaYxC7WNiCUivQfOUmOzL0IdGjKxF9qdMnBY9rkgft1m0hl
         nTNA/UyoxuT/ndAr/R2oI6kGqAiocw6yMRFtQM80ghTlif7WqD0wc0T+6d6vAkOuXdDA
         5g1X4QE2/6swWauC5VQBHi1BLQN1enBLVG20KG46n872bS+sIYbo0MfzcCoXHZ92YgUI
         SpkhRi1AWS4XM3lM1eAcSCd+ciZBK58gALD9prcV+js9ipGNfdZYEFEexNkzAQqGiKIR
         ZN0sjUQd4FF3FTqEJ82MkBylZFBTRqQHQOebHYvVdkNuVDLsa+9/+D1zdyZ85ni1CflX
         qkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052356; x=1761657156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkFgnaC4/fY4vKIhcUTMhNPw5g98lm3qgHiWbbZwuIc=;
        b=eTEwGRd50SOzZVH88nEydjdYu1JTnQW6VueK4fforHhy0w8pn4jm3PMbrxZLaZdC1U
         MkZqJJsOujrMZeqa3hnK6IPOXH5RJM+qNrHANAjQqeaLirDym42gsIPgDtwujTIfcl4y
         wUMpQW62INb5e225DrOE8mvPyxhrtcBL8GHb8gOkyw/fy2/3jJDMURAl9oKfaD464EvE
         9sKlPkaBNwnU2LhK7mzgiIDBsJfxIiEyV7YycxGVUcaZKldtnJAkBjPfxrXfcnof09gL
         PgaAvdMx4x0s5ff/xQyTwxS1+nkObXO8x03Fk2rYpoDRfzpCyGhyQWrnNjKLxPeGedgj
         HVZg==
X-Gm-Message-State: AOJu0YzRfds/hWkzGO0ZiNodtyFUfWdFMqRNl5mOIhBlfsegjwss1RI1
	OywTmHjNg2kmR8UU1LdbVt1eKxvMxlR85QoAAesCQq4yyxnggHLWgQNC
X-Gm-Gg: ASbGncsqzr4EQLexlq/xP7k7DinpM7NVZUFb/zSBin/m45o0rTefLzNN6Ae4pd0UPkB
	/rWQJfWxPnAchNv5p8Fa7UUPa4mgPFf+bfdeDdf7bjaOCKY03SCcizhRKDH2+qsP6nbAUbiSCUC
	37d7gaS7i89Glrzb24jI3iIidRREw35v3y3qeQUVMwkyP8oaCsEuXRUM5B/ZHtcVyI+EpLixvs2
	FIIJOLffkdSc7MuJoA6t4sCACPmaP3X92EadPucBiEukr09b6+e94MtwXeDu6911XTYTfFOZ43v
	9fTKlODanXBv07sUeLimWE4C+diuNl49/cGOfk1WJwtbnu0npWhuhcuC2cLRHyFP/pD0SbEHQJn
	3DHpPaKtZrBSa12hcfWJicSUhlFpCgAe8VkvnIFCAklNSYFCkB89lIlQkq8FZfKBPt7u1n60Mkw
	/GMP6X74pmdIBy/bw+x0d6GFxTaO3goJyT9v/tABf4wdE4YeFbEsqTXu0IOQ==
X-Google-Smtp-Source: AGHT+IHSE+HSMwEtZuaexxTGBoXkowdxa0+CBkT84r7lRSRwSibKGFd5ahl3BirzVNaC5Sq8Q/eBMw==
X-Received: by 2002:a17:902:cf42:b0:290:a3ba:1a8b with SMTP id d9443c01a7336-290c9cd4ae7mr197316205ad.24.1761052355150;
        Tue, 21 Oct 2025 06:12:35 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:34 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 4/9] xsk: add direct xmit in batch function
Date: Tue, 21 Oct 2025 21:12:04 +0800
Message-Id: <20251021131209.41491-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251021131209.41491-1-kerneljasonxing@gmail.com>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add batch xmit logic.

Only grabbing the lock and disable bottom half once and sent all
the aggregated packets in one loop. Via skb->list, the already built
skbs can be handled one by one.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  1 +
 net/core/dev.c         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index cb5aa8a314fe..5cdb8290f752 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -133,6 +133,7 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			      struct sk_buff *allocated_skb,
 			      struct xdp_desc *desc);
 int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err);
+int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev);
 #ifdef CONFIG_XDP_SOCKETS
 
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
diff --git a/net/core/dev.c b/net/core/dev.c
index a64cef2c537e..32de76c79d29 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -163,6 +163,7 @@
 #include <net/page_pool/memory_provider.h>
 #include <net/rps.h>
 #include <linux/phy_link_topology.h>
+#include <net/xdp_sock.h>
 
 #include "dev.h"
 #include "devmem.h"
@@ -4792,6 +4793,27 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 }
 EXPORT_SYMBOL(__dev_queue_xmit);
 
+int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
+{
+	u16 queue_id = xs->queue_id;
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, queue_id);
+	int ret = NETDEV_TX_BUSY;
+	struct sk_buff *skb;
+
+	local_bh_disable();
+	HARD_TX_LOCK(dev, txq, smp_processor_id());
+	while ((skb = __skb_dequeue(&xs->batch.send_queue)) != NULL) {
+		skb_set_queue_mapping(skb, queue_id);
+		ret = netdev_start_xmit(skb, dev, txq, false);
+		if (ret != NETDEV_TX_OK)
+			break;
+	}
+	HARD_TX_UNLOCK(dev, txq);
+	local_bh_enable();
+
+	return ret;
+}
+
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 {
 	struct net_device *dev = skb->dev;
-- 
2.41.3


