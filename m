Return-Path: <bpf+bounces-72942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ECBC1DDB1
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7746E188BAC7
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE6442050;
	Thu, 30 Oct 2025 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqVT48CB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7333FC2
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782827; cv=none; b=LpqYqgIeCQNbzZHcCgBztwNRf8DtpQErVyQ9xv4fdb+oMftAI2dNtEKmNeICdTcJ1lHxfWb+vsFTwmnhgEUwbi1FEBggr1Aj1I2N8bo/qUP59e0TmcOLOPXDc/1IxB1+UV/KEtwsDX/eLU5RIE9OYh+9DgWyhxhbxCUH4QL3b9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782827; c=relaxed/simple;
	bh=08P+o2ElDuyPM5de34iLASYdb5ClLvJ5u4F9pGz1S2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eaw2abZ4C5bfsrtAHcLFrDX1Yr8Q4ZnE1ngTzRB9BcHEW1ms7uAmvM7Ke/ouye4JI/SONk771gN9MkjxVWSY8VFkC/AGYCF7aCx/PVYnEdqTpQWFtJmsTfhezOscQ8x69v3i1YYcr08NLVH5ziv2KsrcRY1m4b2FlpAruBe8pHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqVT48CB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so5446465ad.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782824; x=1762387624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLWmG0WizGL4JsKntkc7ppPoT0ylzIGY2uwKSak8NsI=;
        b=KqVT48CB4AY7P5YyyFfSFqPTqrxpMsNxCIP0DxUf19rcKfffqgMbd/RACKs9N3XjPa
         TqnIU16IDcj4dE1pl6vH+z8OTEiOLPIcewGtYAHka8ERyCU2yD035WumGNB6uAlUv3kq
         S4A6PxfCB2foep7eWtxLbnmFEofMItQwYf3+pKA3J4doatUtskolA0WKIXC8/A4WFm6R
         sAupWjbT3aROIQDYOZ0E6huK9nrGqGH4G69YBGGDZbuPwt2RfRo6K6eJegTnD3LRuPtl
         vfuJJAdjXb+M7rDW//OLqQyOpRHvojBFBqCXgDA9NDwv2bJ5jdz4C/Uzs84QDTCiG2FV
         CcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782824; x=1762387624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLWmG0WizGL4JsKntkc7ppPoT0ylzIGY2uwKSak8NsI=;
        b=p9sFFuGF22ONvRVJQqfS8ktulqHzqczEKNBUksfY4w9n3IfMF5UpkhrvzdneNJ4Ouj
         l28mB1BaaJGHIdpLFH6jKwo+mRYDpqG0N79cgkBcQonQTSUT/KUPil/ynIyOfAgUz/ni
         pey2yQZLrPAF39o5ecdz5QiWKyIDBbP/TRf2ZveVMZbyAnn9IlZMFYwGl8Gqcu/ZkDrA
         TkQmId05gETy6NjD67KFjAZOjJ3lBd5DNLc+UjDEHKKCmOIIqPqi7wxVL6Sh38dPOX5u
         i3U3uCWHk94PNC6P2TQELC+PZKqA7opA5wZxxSAu6y/RFAKmEiJI7cWaI8AV5Lx4LhKI
         xo2A==
X-Gm-Message-State: AOJu0Yz9Y6oTUlri7hA290QSnTFrZ42+2ACdXWUPGL1EsHWQ0xiuyzDO
	GBfLjKxT9ywUt+ZI9TSrAiW0h0vH/D2IKCtNTwepT+29SAz6owt2v21+
X-Gm-Gg: ASbGncuCCq6ypSR2JcQ0YqyfHBo6xepTV6jNRUT3Vbn6z/kiRMb4Bk4EG/Bk1zsGwqr
	Pk0NrhIi6aNZgmvtBhUUEbnbkHz46cc7TIGwdEtmkn23N75fh3ecR2UPpZ4Zdej681OC8/0wTvl
	PkpNTH+/uf+ZfafK5EtVGPkzxZv7zYNe0Poh4RzKqwE+46DPwR+bZQERBh+RPSOwRL8tXZeKWEY
	UKw68TIeOpoB9xGA+q6CJaUKdnVgLQRe61yjTkFtK5wnYeRb7zVsas+OVLdY4xoqmDKzjRxa+58
	f/aegpfdwCMmc1mZgB+/s9w1fHUoYiqUycsPYVNQLwZ8oCogs50ptZH1MjNPlveUnxK1K5DvmBN
	TOsr487gDFTNyeguSqFEPk3JdyUCVzCpo+T/7tcSZ6SI/6K21SHLYgRlGkzFbXBSnziYfcwYmRP
	auawrDMe7EWPhE0mVcHMuGt9kHhnUJaTn3ATllQg==
X-Google-Smtp-Source: AGHT+IGts1HCvY+V+2WiwZJvRbt+XQUAmRZOArm02Mf4wMf5EzwXitkgTCUAXQi3tKTOaeeoOM+Wpg==
X-Received: by 2002:a17:902:d2cf:b0:290:bfb7:376f with SMTP id d9443c01a7336-294ee468c6dmr12643345ad.51.1761782823683;
        Wed, 29 Oct 2025 17:07:03 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4117esm162900155ad.93.2025.10.29.17.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:07:03 -0700 (PDT)
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
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 2/2] xsk: use a smaller new lock for shared pool case
Date: Thu, 30 Oct 2025 08:06:46 +0800
Message-Id: <20251030000646.18859-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251030000646.18859-1-kerneljasonxing@gmail.com>
References: <20251030000646.18859-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

- Split cq_lock into two smaller locks: cq_prod_lock and
  cq_cached_prod_lock
- Avoid disabling/enabling interrupts in the hot xmit path

In either xsk_cq_cancel_locked() or xsk_cq_reserve_locked() function,
the race condition is only between multiple xsks sharing the same
pool. They are all in the process context rather than interrupt context,
so now the small lock named cq_cached_prod_lock can be used without
handling interrupts.

While cq_cached_prod_lock ensures the exclusive modification of
@cached_prod, cq_prod_lock in xsk_cq_submit_addr_locked() only cares
about @producer and corresponding @desc. Both of them don't necessarily
be consistent with @cached_prod protected by cq_cached_prod_lock.
That's the reason why the previous big lock can be split into two
smaller ones. Please note that SPSC rule is all about the global state
of producer and consumer that can affect both layers instead of local
or cached ones.

Frequently disabling and enabling interrupt are very time consuming
in some cases, especially in a per-descriptor granularity, which now
can be avoided after this optimization, even when the pool is shared by
multiple xsks.

With this patch, the performance number[1] could go from 1,872,565 pps
to 1,961,009 pps. It's a minor rise of around 5%.

[1]: taskset -c 1 ./xdpsock -i enp2s0f1 -q 0 -t -S -s 64

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xsk_buff_pool.h | 13 +++++++++----
 net/xdp/xsk.c               | 15 ++++++---------
 net/xdp/xsk_buff_pool.c     |  3 ++-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index cac56e6b0869..92a2358c6ce3 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -85,11 +85,16 @@ struct xsk_buff_pool {
 	bool unaligned;
 	bool tx_sw_csum;
 	void *addrs;
-	/* Mutual exclusion of the completion ring in the SKB mode. Two cases to protect:
-	 * NAPI TX thread and sendmsg error paths in the SKB destructor callback and when
-	 * sockets share a single cq when the same netdev and queue id is shared.
+	/* Mutual exclusion of the completion ring in the SKB mode.
+	 * Protect: NAPI TX thread and sendmsg error paths in the SKB
+	 * destructor callback.
 	 */
-	spinlock_t cq_lock;
+	spinlock_t cq_prod_lock;
+	/* Mutual exclusion of the completion ring in the SKB mode.
+	 * Protect: when sockets share a single cq when the same netdev
+	 * and queue id is shared.
+	 */
+	spinlock_t cq_cached_prod_lock;
 	struct xdp_buff_xsk *free_heads[];
 };
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..2f26c918d448 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -548,12 +548,11 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 
 static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&pool->cq_lock, flags);
+	spin_lock(&pool->cq_cached_prod_lock);
 	ret = xskq_prod_reserve(pool->cq);
-	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	spin_unlock(&pool->cq_cached_prod_lock);
 
 	return ret;
 }
@@ -566,7 +565,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 	unsigned long flags;
 	u32 idx;
 
-	spin_lock_irqsave(&pool->cq_lock, flags);
+	spin_lock_irqsave(&pool->cq_prod_lock, flags);
 	idx = xskq_get_prod(pool->cq);
 
 	xskq_prod_write_addr(pool->cq, idx,
@@ -583,16 +582,14 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 		}
 	}
 	xskq_prod_submit_n(pool->cq, descs_processed);
-	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
 }
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&pool->cq_lock, flags);
+	spin_lock(&pool->cq_cached_prod_lock);
 	xskq_prod_cancel_n(pool->cq, n);
-	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	spin_unlock(&pool->cq_cached_prod_lock);
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 309075050b2a..00a4eddaa0cd 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -90,7 +90,8 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	INIT_LIST_HEAD(&pool->xskb_list);
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
 	spin_lock_init(&pool->xsk_tx_list_lock);
-	spin_lock_init(&pool->cq_lock);
+	spin_lock_init(&pool->cq_prod_lock);
+	spin_lock_init(&pool->cq_cached_prod_lock);
 	refcount_set(&pool->users, 1);
 
 	pool->fq = xs->fq_tmp;
-- 
2.41.3


