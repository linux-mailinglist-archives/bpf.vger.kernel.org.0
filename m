Return-Path: <bpf+bounces-63127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1C3B02E81
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 04:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92A3189CBFC
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 02:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6E415442A;
	Sun, 13 Jul 2025 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFN8kfvR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9AB6FC3;
	Sun, 13 Jul 2025 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752375487; cv=none; b=aJuRMMP3iKfWXcGvNDE+YAmtDAOfIe/SiY115bxF1WK5K0zqrx+wh+NMGQaIjlGZMB9oEI6ScZbKBzaqm4Pbpxv3tp4CUsSgZxhI0UAknFrmfV7zEud7LM8+L6QkI/SEqr6woid3xkwLmzFr8VRKH1FANLyNECsbYW4tF2i/sFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752375487; c=relaxed/simple;
	bh=YbiwQ0BPem0uY7/gAcm5tumD2P83B6P8H0dvB7mPfCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b1faCbvPFqEL6F0MjOc5vM4EX6oLb1K3XqCazPvHknSekbQY3fjRutaN68OuryIm/+I+IvJWhIXsp9C0EYxpClHCKOuHegHPrVvgCfzrP1lNILEtuGp45sj3GSCNMFi3GJAgwIXj4NYNGrMQ6tsNk31FLwRi2bVUVGhRzjBFWwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFN8kfvR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23c703c471dso36373015ad.0;
        Sat, 12 Jul 2025 19:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752375485; x=1752980285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+sWVWcGnnf7yCkkObLlXnTN0/9/+b0sxPxFGLz/OpuU=;
        b=AFN8kfvRDEz08HmFWcn6lJAsma+rIopzvbxzdgrcRjyq5Yd6irlyiNu8r4LQRWSeb4
         B0WrXNp10H3dLL9QllrewWJpC6zqst1XBec0dnnyKh29YIWL/YuPWtG6X+rWiQvdkqN0
         tk2b8Lb48VxpDhc3CF1sQNJyWdtB5IlXl82ZGABThPIK2xBWY1M94NFjecbYIhAfjQ4v
         fs5z7GVfBjPBplhsmv8XHJnnRqIR4w/6QxSkzDJBC+fdTL5Ap8Lo+Z1Y48yI6zXHUHXi
         hZ2FkpUHCAXZ4uUF9NadB9Q3RN7MIJH00zyPJ5EG4kewDuFzXEKQ+erkFlbqIT9H/KnQ
         XkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752375485; x=1752980285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sWVWcGnnf7yCkkObLlXnTN0/9/+b0sxPxFGLz/OpuU=;
        b=M05cwjQ7g1VSI3WQGeEr4SETF9Eb/TqS+LGs8FgRNeGY49LWzi1Gl4nWuli5huDrW2
         /QG/o827abxRjqL9Ug7HvzfS2tkzDBgSY/kZjUHrhzGjaD8YShvpv3eFgDFBZr0oMxIl
         0hA4u0Ae4TGyfLJjjgv164E14n1dHbAOJYEx10iWs4bFH9kgh+QNPls2i3eQosM7UmH9
         d2WZig3HYUdQMaBNtybEvRJ0XiyRAE0gXktwF+FtbJwqHl8bTUWqHRd0XB+eqRQhdg3D
         n6sKky3R+P0H8/AqnD8ym3RE+Nl11F4S0jNfipy2pdtm3X00KWS2zf/NnvIIWw+O1Qnt
         VTTg==
X-Forwarded-Encrypted: i=1; AJvYcCW00kJkUEe3aSA9BcFL4TjyP5QqBwhK3vni1X08XxYOoSLj0V8q4lILfemcuLIsg+8KgOuJsmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdTWmJQZAMK5mmUa1QhZdEJpqXt3Ny7hy8TiBWsodah8LItCA
	pNzaTf+z5w1G2SCdIRObndYvzv/bFy6iWvnmoaz5DM8l7AAZFfEZoqpT
X-Gm-Gg: ASbGnctZiVi9P7k2wuIrJsC6f8BaZSluVr711btkqdWbLqpHnCfyHm3wixfY+S7T1wx
	fMSIpGCARbFOc/2lvcdOhjudcfIIkvcLA5IQuXio8DTRfcpQP7Uf6PZXA/uKUVSDPRYAfImg63M
	MnOO32g7WTD31DbCuyR8z/qFR5vdqJfQM3yrANqQ6kwDlSHfLmC/NUsxwfNfZWAK1gkNOIWdPdu
	wJ4eVtuEZ8M8ILK9P4uxxPwlIupdch3a/tq0EtZoF+Dq/Pg+Bmsgl4Kxidgt6+UvoXXZQb79HHk
	TvDmQcvZuwoNxAIAV4ul0B8eiO84wWwNZpQDBB7BX6zexOpNJjs8dzfvyDo6M9BcZpJICCkyXHp
	sZFliwmgeVZmtZqFfurm8+5i3Xql5NXQ2KCs8RoEm6PZD8tIvYT+JV8P6kA==
X-Google-Smtp-Source: AGHT+IEir2uT9XbvhExkxVbCAED4bP0XmTvw4u85jcTivEC6TMsuWgCSWlg3zIYGQETaeEoGI0QCSQ==
X-Received: by 2002:a17:902:ce81:b0:235:f059:17de with SMTP id d9443c01a7336-23de2fc7a8cmr187265335ad.15.1752375484673;
        Sat, 12 Jul 2025 19:58:04 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.26.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7b652sm8434818a91.43.2025.07.12.19.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 19:58:03 -0700 (PDT)
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
Subject: [PATCH net-next] xsk: skip validating skb list in xmit path
Date: Sun, 13 Jul 2025 10:57:56 +0800
Message-Id: <20250713025756.24601-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

For xsk, it's not needed to validate and check the skb in
validate_xmit_skb_list() in copy mode because xsk_build_skb() doesn't
and doesn't need to prepare those requisites to validate. Xsk is just
responsible for delivering raw data from userspace to the driver.

Skipping numerous checks somehow contributes to the transmission
especially in the extremely hot path.

Performance-wise, I used './xdpsock -i enp2s0f0np0 -t  -S -s 64' to verify
the guess and then measured on the machine with ixgbe driver. It stably
goes up by 5.48%, which can be seen in the shown below:
Before:
 sock0@enp2s0f0np0:0 txonly xdp-skb
                   pps            pkts           1.00
rx                 0              0
tx                 1,187,410      3,513,536
After:
 sock0@enp2s0f0np0:0 txonly xdp-skb
                   pps            pkts           1.00
rx                 0              0
tx                 1,252,590      2,459,456

This patch also removes total ~4% consumption which can be observed
by perf:
|--2.97%--validate_xmit_skb
|          |
|           --1.76%--netif_skb_features
|                     |
|                      --0.65%--skb_network_protocol
|
|--1.06%--validate_xmit_xfrm

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/netdevice.h |  4 ++--
 net/core/dev.c            | 10 ++++++----
 net/xdp/xsk.c             |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a80d21a14612..2df44c22406c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3351,7 +3351,7 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev);
 
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
-int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
+int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id, bool validate);
 
 static inline int dev_queue_xmit(struct sk_buff *skb)
 {
@@ -3368,7 +3368,7 @@ static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 {
 	int ret;
 
-	ret = __dev_direct_xmit(skb, queue_id);
+	ret = __dev_direct_xmit(skb, queue_id, true);
 	if (!dev_xmit_complete(ret))
 		kfree_skb(skb);
 	return ret;
diff --git a/net/core/dev.c b/net/core/dev.c
index e365b099484e..9fa805c26601 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4741,7 +4741,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 }
 EXPORT_SYMBOL(__dev_queue_xmit);
 
-int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
+int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id, bool validate)
 {
 	struct net_device *dev = skb->dev;
 	struct sk_buff *orig_skb = skb;
@@ -4753,9 +4753,11 @@ int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 		     !netif_carrier_ok(dev)))
 		goto drop;
 
-	skb = validate_xmit_skb_list(skb, dev, &again);
-	if (skb != orig_skb)
-		goto drop;
+	if (validate) {
+		skb = validate_xmit_skb_list(skb, dev, &again);
+		if (skb != orig_skb)
+			goto drop;
+	}
 
 	skb_set_queue_mapping(skb, queue_id);
 	txq = skb_get_tx_queue(dev, skb);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9c3acecc14b1..55278ad0a558 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -834,7 +834,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 			continue;
 		}
 
-		err = __dev_direct_xmit(skb, xs->queue_id);
+		err = __dev_direct_xmit(skb, xs->queue_id, false);
 		if  (err == NETDEV_TX_BUSY) {
 			/* Tell user-space to retry the send */
 			xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
-- 
2.41.3


