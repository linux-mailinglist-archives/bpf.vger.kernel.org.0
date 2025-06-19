Return-Path: <bpf+bounces-61054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17417AE0163
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 11:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF3C5A5EE2
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B152686A0;
	Thu, 19 Jun 2025 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1SYpwWa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9D266F00;
	Thu, 19 Jun 2025 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323904; cv=none; b=XMP3ZFe0XoxPHv1JeD/SzXhU5WwaX+a8lzxZzGCpngmWTJQ5M3cIQMklXSWRrTJuL9v1BVmaqzhETaCUBHMCOTRfwSW8neWrI1Cli9c85tWMyFARGNwBvI2fFLC2NveXs/BTzt1kd6mHLgnX3Sr/R9kFi1ocHZz9BmduF2HTIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323904; c=relaxed/simple;
	bh=ix8iYmgTQn6R+tkb0lLnWMcZNkULhPqXa1YeYWKrFkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lq1uxQz5RLnhAm0Veiwnn7rkEZhyTrVq3mLxvd3PmN6gL6Fy1FT1kmg98dMpt2wI1je2Dn6txuoXwxHx67ZUpl6FcmeeO31xq+gkJBpL+dAR/0lK5X51ZOECt4ayPY1E7R8M3J/De2Li5mStczMFC2xmvaxnkXDYoPCPS5VQW7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1SYpwWa; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313a188174fso396960a91.1;
        Thu, 19 Jun 2025 02:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750323902; x=1750928702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0T0/RVTI1R+JSfxKY4c/kK2FPfopMjGZvHoxm2BH6PE=;
        b=h1SYpwWaYBBzCTLgtspVLeugKgwM1TJ61Jm4XseJBSfeQCYc0GP6gv32sKutqW3n4j
         qsqAOeJmPS985JVj2iV4Jy3E7AmrDsBclL+Cmt56wceVM7jvLK2uVbGDx95dLfQXST5+
         5BPDHwNagCWdgmISpgv/VfGlrUKrwVYdalFcjgHA2fdpHBuT2mvyCjf9LtjYdDBSP5f8
         YaM/tBT4dPVRURWgrQf+FzyIl/xYS2o8xHSQ/JN5G83XFByGYj0UY2aRVa9pI+XTBJUn
         C44MhiHg1S5D7B1iuxPW6Zpgzn8/Ltqc5f5pEXF+z81FqKcjQ3MQ0cNVELx3HfX7ak29
         7IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750323902; x=1750928702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0T0/RVTI1R+JSfxKY4c/kK2FPfopMjGZvHoxm2BH6PE=;
        b=vpWeZVZr1a6T0VrSOpMahTDJx/bqmiQjk3BrRY9Oz1zzRcH/eIgJZH4gyEbHmzbYUl
         ao6OzFG0FbBOwuj57btcLED5SkdqWSKuMJFRYOSLeMrNQudiQEGyM6hcefylNkozi92A
         T9Egwlui+L//mc8tGjhsnN8/PU1zDHIem5M1BBwLoNSL/slzb9wSjsGt0qghycUNXjUB
         HYL329pGrJidFyEvkYLQchFmwY0q50kuVSH6gZcWhZMAcWYvyTF4eV0S4ig9/QMsBO56
         rd5crYb/rVwEfLVAlVx+LKBG433sowh+RxppXaGHNryfh0aLxIxm6fkOCwAsicPvx4t5
         BEmg==
X-Forwarded-Encrypted: i=1; AJvYcCXlDR7g2ZLdcR5x/h2nCxeRKedZn4yqJTwGzeZ7hEhIJsCS6B8kTCk8ruQ7m7NMRRG3UmNgVDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37fecoPCkd9LbSGNaNin9qYcJFHKzVVUvIa9ku1Ky5BByFtRU
	Xlt5Xpp+TTyR963Jd7g0AMP0iP/2xnNRjaIgac5mwB3YE26SCJ2WQE+J
X-Gm-Gg: ASbGncvcuEF6IdbHJ0fNvWm3UwMjj7peF5SMyGbhcHQ1W/eox/gV9p1wGBMYzO9EXoS
	pmKjDKcVPvLWL/F7qBCHA1c6mnHNZFA6AwCiZupJJXS4R4QrN4TMFNoYnM6zGsslfkMfKrixMlP
	IfBKSeuQ43mZf3rv0CcVhF/JWp/9reiYE1PTnK7YhxGxV/bkfJbESEkDcCCqfOuyqgqflR3mSWs
	oCoHRmkalcmIEk9TqodAxO1C9tXTwmLJjlKwM1zLkvJQ5ffNf5/0k9EKWH47/WjOtTWDzlx3j3K
	PhSCYnU50N5tpqcS+TwgltSjSXvNeXJq5AGQUs5rSbM6y6p5nU7kYOwi6hBgmZOSEE5E4wfkojw
	SeaSQz30m5YM2r0sO8cz7KA3nUTutTl9c+A==
X-Google-Smtp-Source: AGHT+IFMIkCTr72RzIwyDT9cZ45PR33J0SF9uyq46ep6L05JNw8tXxsfLuxAlSCQpR1zoX5ap4ibjw==
X-Received: by 2002:a17:90b:52c5:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-3158abd64e7mr3855491a91.5.1750323901724;
        Thu, 19 Jun 2025 02:05:01 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2f0987sm1780020a91.25.2025.06.19.02.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 02:05:01 -0700 (PDT)
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
Subject: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
Date: Thu, 19 Jun 2025 17:04:40 +0800
Message-Id: <20250619090440.65509-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The patch does the following things:
- Add XDP_MAX_TX_BUDGET socket option.
- Unify TX_BATCH_SIZE and MAX_PER_SOCKET_BUDGET into single one
  tx_budget_spent.
- tx_budget_spent is set to 32 by default in the initialization phase.
  It's a per-socket granular control.

The idea behind this comes out of real workloads in production. We use a
user-level stack with xsk support to accelerate sending packets and
minimize triggering syscall. When the packets are aggregated, it's not
hard to hit the upper bound (namely, 32). The moment user-space stack
fetches the -EAGAIN error number passed from sendto(), it will loop to try
again until all the expected descs from tx ring are sent out to the driver.
Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequencies of
sendto(). Besides, applications leveraging this setsockopt can adjust
its proper value in time after noticing the upper bound issue happening.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
V3
Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonxing@gmail.com/
1. use a per-socket control (suggested by Stanislav)
2. unify both definitions into one
3. support setsockopt and getsockopt
4. add more description in commit message

V2
Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxing@gmail.com/
1. use a per-netns sysctl knob
2. use sysctl_xsk_max_tx_budget to unify both definitions.
---
 include/net/xdp_sock.h            |  3 ++-
 include/uapi/linux/if_xdp.h       |  1 +
 net/xdp/xsk.c                     | 36 +++++++++++++++++++++++++------
 tools/include/uapi/linux/if_xdp.h |  1 +
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index e8bd6ddb7b12..8eecafad92c0 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -65,11 +65,12 @@ struct xdp_sock {
 	struct xsk_queue *tx ____cacheline_aligned_in_smp;
 	struct list_head tx_list;
 	/* record the number of tx descriptors sent by this xsk and
-	 * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity needs
+	 * when it exceeds max_tx_budget, an opportunity needs
 	 * to be given to other xsks for sending tx descriptors, thereby
 	 * preventing other XSKs from being starved.
 	 */
 	u32 tx_budget_spent;
+	u32 max_tx_budget;
 
 	/* Statistics */
 	u64 rx_dropped;
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 44f2bb93e7e6..07c6d21c2f1c 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
 #define XDP_UMEM_COMPLETION_RING	6
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
+#define XDP_MAX_TX_BUDGET		9
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..7c47f665e9d1 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -33,9 +33,6 @@
 #include "xdp_umem.h"
 #include "xsk.h"
 
-#define TX_BATCH_SIZE 32
-#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
-
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 	rcu_read_lock();
 again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
-		if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
+		int max_budget = READ_ONCE(xs->max_tx_budget);
+
+		if (xs->tx_budget_spent >= max_budget) {
 			budget_exhausted = true;
 			continue;
 		}
@@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 static int __xsk_generic_xmit(struct sock *sk)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
-	u32 max_batch = TX_BATCH_SIZE;
+	u32 max_budget = READ_ONCE(xs->max_tx_budget);
 	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
@@ -797,7 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		goto out;
 
 	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
-		if (max_batch-- == 0) {
+		if (max_budget-- == 0) {
 			err = -EAGAIN;
 			goto out;
 		}
@@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		mutex_unlock(&xs->mutex);
 		return err;
 	}
+	case XDP_MAX_TX_BUDGET:
+	{
+		unsigned int budget;
+
+		if (optlen < sizeof(budget))
+			return -EINVAL;
+		if (copy_from_sockptr(&budget, optval, sizeof(budget)))
+			return -EFAULT;
+
+		WRITE_ONCE(xs->max_tx_budget, budget);
+		return 0;
+	}
 	default:
 		break;
 	}
@@ -1588,6 +1599,18 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
 
 		return 0;
 	}
+	case XDP_MAX_TX_BUDGET:
+	{
+		unsigned int budget = READ_ONCE(xs->max_tx_budget);
+
+		if (copy_to_user(optval, &budget, sizeof(budget)))
+			return -EFAULT;
+		if (put_user(sizeof(budget), optlen))
+			return -EFAULT;
+
+		return 0;
+	}
+
 	default:
 		break;
 	}
@@ -1734,6 +1757,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	xs = xdp_sk(sk);
 	xs->state = XSK_READY;
+	xs->max_tx_budget = 32;
 	mutex_init(&xs->mutex);
 
 	INIT_LIST_HEAD(&xs->map_list);
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 44f2bb93e7e6..07c6d21c2f1c 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
 #define XDP_UMEM_COMPLETION_RING	6
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
+#define XDP_MAX_TX_BUDGET		9
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
-- 
2.43.5


