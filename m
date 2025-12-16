Return-Path: <bpf+bounces-76671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5C1CC0A36
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C0C2301F3F4
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB52EDD40;
	Tue, 16 Dec 2025 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdI0k9Ep"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8BD2F0C5B
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765853466; cv=none; b=Qp35iRKZ82d+2ZDhPTREGBMLrxTC99yVwtiGkV9+jg19rwB+XnNl8y3m/OsKShQ9tNr4wH/oe/zofFUB84lqoVfiNIpiVe6Zep0Tuu7Vv2giX+Itf2FyMU3oDh7Z4eSbvtde8Zg64GiIOpKq9vsxsrlJnampuV4ZfLKumTgddzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765853466; c=relaxed/simple;
	bh=8wGPoBC17Pvs5ona0WtPiKM0dyyrKxFlOWQ78mY4B7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPJ70CFilL1qhlyvs9Ux2+6ys3Ixu/C+mYKwzEZEpzCCP0sjfubG2qdy+FlzCpinW4U5qEQkeZng7kwMoPU6h87d029L5OSnCrAr3HBMIzvdTrkiSn6HgIp9rLsnj/VJvT0iI4ZQCivS+dod1eEyV3wl3ojYJRpLtlDPN6JK7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdI0k9Ep; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a09757004cso30189955ad.3
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 18:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765853463; x=1766458263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8Jkr4gptnr43lfvojhWFIhKYNObRq5vr1EGbHYpgkk=;
        b=YdI0k9EpUQxhf8edWeH19g2fc2iKNf3DzYvAeG0NypnHt2eRTbJWnEXUSDWlzPgnph
         yUZrlsvI7Au0A3CxchULaLnz/ASyZbA8H8anZX73g08ckWyOgVUjiQZJroqTQJlrORTu
         XvpfAk/x7CrXh5DUKSsSThzldgi6+dpZ9DbtMAy3uhLYTG+K1HkQ/M8EFFZBydYdKiTe
         HAulJu1chN6j8qWblcvbMvUfU8uw3SCSlHtjLj4KYCUMzL1ttnnpqX2LNsfCru8t6JOo
         DYU6KweF+4ZmvjST9V+CMQNzyPB9fE5nYCXTN0p78Ro1FG6g3c26PGujSeEFMko5lM87
         Oteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765853463; x=1766458263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z8Jkr4gptnr43lfvojhWFIhKYNObRq5vr1EGbHYpgkk=;
        b=N4r04VCOkA6XfJ7lEuHub8pffjRR3+zx6YvdX4XplD+ARTIvN7FIAAGhaeypb9/aWk
         h1fkfJktaD//7uz5ugg3c5EiC6ZZ1wE1VUMn/67ElLU93gZE2o6ns9HDzd4YQbaAGiag
         tbeyzjlrNIWfv52Nmv+VfQ8L3PUmh//jabYgZ4X6nH1ycO6oMtL1FB5hYkg9x1MVdNdl
         2uP7IIyc9iIFTEGyJE4OM28BqchK2fGiVepnaijbt2Sif+s/TkvAW0QxahjGEBip+Wdl
         PWThLQ61fi0ChmsLbwVfqMn75JhRDqXwwSbZ9tNvq9tOsMBKD0SiNnf3Qhamt3Qzlf23
         DTbQ==
X-Gm-Message-State: AOJu0YxX+Lk67MYr8jutr3DLBQ0TEG5c1TEaNgZ5bnbXXKq54UAKZ+Zr
	0CYfJjLbW4ZWeZo2UfIdI5jMCk3FoojYOdSRnxkceQjQMKGK7KHSYLFS
X-Gm-Gg: AY/fxX7BikS/cyBFSILfhMzuGY7kk3tAlAv4loTHZ73yQ/qRjFJqyL4hBIbwc/+zRaa
	Uy0t9p1AMdAnNPJbNZtU/EuMKzoboPFcXhYDSjkLDKe3SsZV1xVhUBvuGZjRF09QC7cFZHUnQVS
	OMZzYPKJ++dkCaDxMy+jKcmV1rdeRHV/ZrYjwY69tAsqG46ojfyjKxEuXc7xUgihIVxtR4x/Kje
	MrsbfrQlZEPq2b9QUtPY6z4mpf02PPBxyAGL3xBJRmpvHziei9pcpQQtM2VYW+p50KrP/pb40dr
	lajK/2BiXGrcFsWKfqvFSaa06iIK6qvw/4MZkmMCof1NxuWB8aG5WTlA91yG29WE49hrRp3Gc9t
	3aWXB2q7XP8T6LBFWNbUGN9c5MJnAuQubvN89Raqp/o/bZyUjQflba2F0kdPiKJ/BtI4eQc/pZi
	dkQtUm8HdGul4zKX+Mo3l1S+v7X8AOV+h0KS+DRtAC7VtThnSAdiz9mD/IsQ==
X-Google-Smtp-Source: AGHT+IFDEg0PlzUS8mS89n/8PqobtOghWZu1q2l9/w40fhqdjpi35TRElpthS9k4+UXgdM3LhVaxPw==
X-Received: by 2002:a17:902:cecb:b0:2a0:de4f:ca7 with SMTP id d9443c01a7336-2a0de4f122bmr49455405ad.1.1765853462663;
        Mon, 15 Dec 2025 18:51:02 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a13cd7f1ecsm2618865ad.74.2025.12.15.18.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 18:51:02 -0800 (PST)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v5 2/2] xsk: move cq_cached_prod_lock to avoid touching a cacheline in sending path
Date: Tue, 16 Dec 2025 10:50:47 +0800
Message-Id: <20251216025047.67553-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251216025047.67553-1-kerneljasonxing@gmail.com>
References: <20251216025047.67553-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

We (Paolo and I) noticed that in the sending path touching an extra
cacheline due to cq_cached_prod_lock will impact the performance. After
moving the lock from struct xsk_buff_pool to struct xsk_queue, the
performance is increased by ~5% which can be observed by xdpsock.

An alternative approach [1] can be using atomic_try_cmpxchg() to have the
same effect. But unfortunately I don't have evident performance numbers to
prove the atomic approach is better than the current patch. The advantage
is to save the contention time among multiple xsks sharing the same pool
while the disadvantage is losing good maintenance. The full discussion can
be found at the following link.

[1]: https://lore.kernel.org/all/20251128134601.54678-1-kerneljasonxing@gmail.com/

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xsk_buff_pool.h | 5 -----
 net/xdp/xsk.c               | 8 ++++----
 net/xdp/xsk_buff_pool.c     | 2 +-
 net/xdp/xsk_queue.h         | 5 +++++
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 92a2358c6ce3..0b1abdb99c9e 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -90,11 +90,6 @@ struct xsk_buff_pool {
 	 * destructor callback.
 	 */
 	spinlock_t cq_prod_lock;
-	/* Mutual exclusion of the completion ring in the SKB mode.
-	 * Protect: when sockets share a single cq when the same netdev
-	 * and queue id is shared.
-	 */
-	spinlock_t cq_cached_prod_lock;
 	struct xdp_buff_xsk *free_heads[];
 };
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3c52fafae47c..3b46bc635c43 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -543,9 +543,9 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
 	int ret;
 
-	spin_lock(&pool->cq_cached_prod_lock);
+	spin_lock(&pool->cq->cq_cached_prod_lock);
 	ret = xskq_prod_reserve(pool->cq);
-	spin_unlock(&pool->cq_cached_prod_lock);
+	spin_unlock(&pool->cq->cq_cached_prod_lock);
 
 	return ret;
 }
@@ -619,9 +619,9 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
-	spin_lock(&pool->cq_cached_prod_lock);
+	spin_lock(&pool->cq->cq_cached_prod_lock);
 	xskq_prod_cancel_n(pool->cq, n);
-	spin_unlock(&pool->cq_cached_prod_lock);
+	spin_unlock(&pool->cq->cq_cached_prod_lock);
 }
 
 INDIRECT_CALLABLE_SCOPE
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 6bf84316e2ad..cd5125b6af53 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -91,7 +91,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
 	spin_lock_init(&pool->xsk_tx_list_lock);
 	spin_lock_init(&pool->cq_prod_lock);
-	spin_lock_init(&pool->cq_cached_prod_lock);
+	spin_lock_init(&xs->cq_tmp->cq_cached_prod_lock);
 	refcount_set(&pool->users, 1);
 
 	pool->fq = xs->fq_tmp;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1eb8d9f8b104..ec08d9c102b1 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -46,6 +46,11 @@ struct xsk_queue {
 	u64 invalid_descs;
 	u64 queue_empty_descs;
 	size_t ring_vmalloc_size;
+	/* Mutual exclusion of the completion ring in the SKB mode.
+	 * Protect: when sockets share a single cq when the same netdev
+	 * and queue id is shared.
+	 */
+	spinlock_t cq_cached_prod_lock;
 };
 
 struct parsed_desc {
-- 
2.41.3


