Return-Path: <bpf+bounces-76334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E24DACAEC90
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 04:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89674303A8D4
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 03:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58835301002;
	Tue,  9 Dec 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQXeLVpQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1C29A1
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 03:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765250200; cv=none; b=JfHG+PJhDx54ouKhkMzTJLEBlmJEmEialcyAK0tXymzMSluIEi8dsKNTcK35PDEWo4kr4GHFXmOy9KbVszUp9HFNNBE8WpaL7TXY04JOz6DmryeZa6vv8H0IQT5kab3RV4xCig4tQn8Nd4AFgVgYPdW3RPsZ0bcoEGUaZRJXrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765250200; c=relaxed/simple;
	bh=hYHXcBJqiE6Yb0MUNgUbnjO75UV/90nph27Fu0HltPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kf4Jb5jigX02cd/zqvy+B3oOCugMc14N/iflNdZmobl+lUQzt+uQhk++HkNhZF+ChpgHpZlUGQ1IuwaQkYdxuezkPhATxE7uB2rxBfgjznxKFVdgR25wqzjGqSlmJm8nRenPuKX9X21p8G+FLDl5PL9a1IaSwJ76J7zcDVL4N3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQXeLVpQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso5607098b3a.3
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 19:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765250198; x=1765854998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xbjh03zP4rMQL9+cf/Iuj90OUUWRY4VOBdkq+sEptSU=;
        b=bQXeLVpQhi/drT694FqJw/Yc78bYM23uTRTHE3/sKf4gBZFqGCBDFYdZkZzNwixZZC
         FIz9BOBcbIEpIUrjglY+ABMD5mNUxrkNM2TACHCI62EXJv0a+F+ccUcnxEnvaxw3oCxz
         UZ9go8oA0edeSBSjOZcZ6XuV8L84lwVyUeKR9PAlDzAD+dYf9xgSi9w9idxCdWxARXuR
         IRq8a9LHc0ucHinYrjqpFmWLej4kr16wppZc9LDH4xIMA5Z5oFp7pfCpuSl1WUFZyX9Y
         KEgNA54GCqoJUoUOliSCHdmBHDEsPOE+/n3oP8tabyFsV9o17zABcIfn77k5qT/B8yOT
         ncxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765250198; x=1765854998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xbjh03zP4rMQL9+cf/Iuj90OUUWRY4VOBdkq+sEptSU=;
        b=tS1zUiiAP1lZnVNQb9AUHHZtwVe6zrgPBHGU9OMM18zpHjzaA1xlNsYWQEZcQngVNU
         V5sSpdJzZtS3rI8ejiv1S3uyuB4G+5A/4xxg7lXfFZoreUiSLEj1zxztacypv+n6IsaG
         aNHU0ENyailsIqolUeMYiSPSLXfyTjMFrgu0wwo77MznD+FnW/l787q/lBFEUaYzKe3K
         Br6FLhj3nSJwyJhW/NyyNgmzziducuIKceTFLJt+KFOe4kHs6Dr36L0+Yj08KjP1SkHF
         Z8Ot4RzMIjB7IC/cxE98V8CgZiL6IYgdIfgwBgcnGvxOsLQIqBZoueE4FUPu3OoaW4Dm
         lzdw==
X-Gm-Message-State: AOJu0YxjMl2thfMG1TGtO2VTC9+/+lVsv04/1B/oYFPGXFMiG0hq9tgJ
	7X6Cczv9qF4uGPYuA5oakK7xGGG+6TwgABHhDL1MdgJS9D/6vscTJAiw
X-Gm-Gg: ASbGnculcmFZFE2hVSUzLRl3AEwo4b2Y02DjVb575A5VKxQra9zuM6V25+Fo704biNo
	FwhKPHbzZtPlQ5k5D3+Jcf68PXftqLxmXpAi1DIYCEuvkM65R7xu0f64CWNZaKyuZX1P2UCnMHE
	I/9qGItMfxEB1TI13Pf/JAIRNfrslOx9wxPf70iSjjImF/sDi8fojwTR/T0UMX93G1lJEtOyxqZ
	SqhOmhZNsEJJSprf6+a3TVJZO/bJuOJ0RjjVSj5Nv5NAfXkIEbKeE8w3LiwWmLXcDKlwCC0KEvd
	TBHAAgxp9JszwcpTUgWexXMh0MHYh4ZV5IZTeJE/EMi0UaI60jQWIAGIrbiY/tqzrIXTNu6pvp6
	nVsNlhYVBN468RywQvbYaDsrIJHnBlljEC4rxieveLWatm2wpyb+4yYEkvFDMQ6TIgtrB+yulG+
	QgorAy0luX4XaR5Hspt/ybTwdQqFZZv9wKA7AWBcEW/k3g/I5JCSSuX9NRvA==
X-Google-Smtp-Source: AGHT+IHQvgWeNtbf6rAOmu4e1CUtIgqvvM7NUPVdJ7LsQIwRvvKXNdF15hsTi3/ADWnNDURlKJZtQw==
X-Received: by 2002:a05:6a00:a13:b0:792:f084:404f with SMTP id d2e1a72fcca58-7e8bb35f842mr8949291b3a.0.1765250197576;
        Mon, 08 Dec 2025 19:16:37 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a07213b6sm14491252b3a.26.2025.12.08.19.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 19:16:37 -0800 (PST)
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
Subject: [PATCH RFC net-next v4] xsk: move cq_cached_prod_lock to avoid touching a cacheline in sending path
Date: Tue,  9 Dec 2025 11:16:28 +0800
Message-Id: <20251209031628.28429-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
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
same effect. But unfortunately I don't have evident performance number to
prove the atomic approach is better than the current patch. The advantage
is to save the contention time among multiple xsks sharing the same pool
while the disadvantage is lose good maintenance. The full discussion can
be found at the following link.

[1]: https://lore.kernel.org/all/20251128134601.54678-1-kerneljasonxing@gmail.com/

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
Q: since net-next will be open next year, I wonder if I should post this
patch targetting bpf-next?

RFC V4
Link: https://lore.kernel.org/all/20251128134601.54678-1-kerneljasonxing@gmail.com/
1. use moving lock method instead (Paolo, Magnus)
2. Add credit to Paolo, thanks!

v3
Link: https://lore.kernel.org/all/20251125085431.4039-1-kerneljasonxing@gmail.com/
1. fix one race issue that cannot be resolved by simple seperated atomic
operations. So this revision only updates patch [2/3] and tries to use
try_cmpxchg method to avoid that problem. (paolo)
2. update commit log accordingly.

V2
Link: https://lore.kernel.org/all/20251124080858.89593-1-kerneljasonxing@gmail.com/
1. use separate functions rather than branches within shared routines. (Maciej)
2. make each patch as simple as possible for easier review
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
index f093c3453f64..7613887b4122 100644
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
index 51526034c42a..127c17e02384 100644
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


