Return-Path: <bpf+bounces-48321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71017A069F6
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 01:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C883A6C67
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 00:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B8FC0B;
	Thu,  9 Jan 2025 00:34:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C41F4C7D;
	Thu,  9 Jan 2025 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736382882; cv=none; b=VukZc2+BM5i6Vx15mod3/PaB8fAdK2tzssHhc8yQUMScsjRZ5hNiIQDOsUK8aFonQSUReCce7uSelxnFRVc9e+QfPSbp2XHOb9Pngugo+6wE8FGnswQTjdkwZNseiwXQrUkncVbwcvEdz9xpeTnCLKE3oVbDStYNXP+8kbSleg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736382882; c=relaxed/simple;
	bh=N7uQgpwx5Tq20EZGgLEyaaZiYgkGeHmiOXDE0pRQiDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MX/CxZ5HV1EK85TaddQbM/qaRItI79/8H+/Q4daZ9y0dF89fvOidFVnRJSeQ2zBOzbrKbzqeXEst1kyehi10ymIseyg7LlhsbQOJ9c5An2atXOxU15gJmR2y4e4a28mVMzoJ6ywtqrBlpR65COcAIj2UMnl6HVx+14LrQPpDd+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so530270a91.3;
        Wed, 08 Jan 2025 16:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736382877; x=1736987677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sO/Jlo3f11ieMelu59pnl/lMnd2Xx5XpvanT5x9CNZc=;
        b=YtA7tI4YgAtNRNIpyvQLu7GqH2S/UBgEtamn/0Llk5fjEcQyz5jY9Cl3PuriNwG6Jh
         jNTjBDPuk51h64U+ESdscn3FEdSQm5UqP44y5KBn0ciEy6xH4HC56h6F9YC/FsZAGldz
         x268SMVKH5wl1INH9cvf8BAWg8Ixg0GKC+4d+TjHX+VAoXD3AtOK43cEQHr8zbQ/SqeF
         m3IH0wTO4vkUH6SOIWp/j4x4MHfHQXtOWUE3GV4R7nKIMDVinHFyCtSYwa2C8CgS2jJM
         DUpzQAlcHBrWtxSMKOLrC+9dzmVuA9GeXATIangc0XWAPAQRMMKgwblO0VBAFatzSS5M
         MApQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+48CysCLyEaYF6l4erzKkWRxPQULyHRjzImjxIGP3jsftkr5V/bdaRS/DDUHf3C4wxHuUPxLpfT5qGDph@vger.kernel.org, AJvYcCX+E3UwRuxBvxCVTojUVJBaxrK0mTYAsCfIp9hT7Yo2SKp1E2NV/szooJEkvgqdgPD7RIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3ijfxh9Xu7x+OfPpxD4OHR+14DIA5yUakp/nnmmTao5rirHn
	L/U7/u/ULXDT72LYPzQJDkwUrp/wh4cnAGmDbufAN/Pu3pbfkb3WwzM8
X-Gm-Gg: ASbGncs83bDDs8DaidHHuB3i+/3biaWME+7eoqE2jIBPQbtspDXv85RV4ycgG/vVIdd
	QAeFvkB63GySDnWJ9ZvHcRylHVlgp/UKfSHWzWjTh+homjwrInRiRpvfBu3b3iN4cVDjZt2TdjO
	7d8Z52N+FPAwE+94bwHfGA2HhfC6ewO3BXXhtErWjnvGpw+cl5sosLVTuxYbg588jR/88/ZkNai
	oLWIIUYo+SAhofa2+saGrUAdVTP3oCsxKWWgnR2YElDr3fcl6lS9pAx
X-Google-Smtp-Source: AGHT+IHH4t+ec42lHtHvK1TJkh4muj48bt8siRClPaMBrPs58wC6Q8ZCT+hLAnCeabS52vgTCVD3Qw==
X-Received: by 2002:a05:6a00:170a:b0:725:1de3:1c4a with SMTP id d2e1a72fcca58-72d21f167b0mr6752408b3a.3.1736382877187;
        Wed, 08 Jan 2025 16:34:37 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816312sm35992090b3a.1.2025.01.08.16.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 16:34:36 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	jdamato@fastly.com,
	mkarsten@uwaterloo.ca
Subject: [PATCH net] xsk: Bring back busy polling support
Date: Wed,  8 Jan 2025 16:34:36 -0800
Message-ID: <20250109003436.2829560-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 86e25f40aa1e ("net: napi: Add napi_config") moved napi->napi_id
assignment to a later point in time (napi_hash_add_with_id). This breaks
__xdp_rxq_info_reg which copies napi_id at an earlier time and now
stores 0 napi_id. It also makes sk_mark_napi_id_once_xdp and
__sk_mark_napi_id_once useless because they now work against 0 napi_id.
Since sk_busy_loop requires valid napi_id to busy-poll on, there is no way
to busy-poll AF_XDP sockets anymore.

Bring back the ability to busy-poll on XSK by resolving socket's napi_id
at bind time. This relies on relatively recent netif_queue_set_napi,
but (assume) at this point most popular drivers should have been converted.
This also removes per-tx/rx cycles which used to check and/or set
the napi_id value.

Confirmed by running a busy-polling AF_XDP socket
(github.com/fomichev/xskrtt) on mlx5 and looking at BusyPollRxPackets
from /proc/net/netstat.

Fixes: 86e25f40aa1e ("net: napi: Add napi_config")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/busy_poll.h    |  8 --------
 include/net/xdp.h          |  1 -
 include/net/xdp_sock_drv.h | 14 --------------
 net/core/xdp.c             |  1 -
 net/xdp/xsk.c              | 14 +++++++++-----
 5 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index c858270141bc..c39a426ebf52 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -174,12 +174,4 @@ static inline void sk_mark_napi_id_once(struct sock *sk,
 #endif
 }
 
-static inline void sk_mark_napi_id_once_xdp(struct sock *sk,
-					    const struct xdp_buff *xdp)
-{
-#ifdef CONFIG_NET_RX_BUSY_POLL
-	__sk_mark_napi_id_once(sk, xdp->rxq->napi_id);
-#endif
-}
-
 #endif /* _LINUX_NET_BUSY_POLL_H */
diff --git a/include/net/xdp.h b/include/net/xdp.h
index e6770dd40c91..b5b10f2b88e5 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -62,7 +62,6 @@ struct xdp_rxq_info {
 	u32 queue_index;
 	u32 reg_state;
 	struct xdp_mem_info mem;
-	unsigned int napi_id;
 	u32 frag_size;
 } ____cacheline_aligned; /* perf critical, avoid false-sharing */
 
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 40085afd9160..7a7316d9c0da 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -59,15 +59,6 @@ static inline void xsk_pool_fill_cb(struct xsk_buff_pool *pool,
 	xp_fill_cb(pool, desc);
 }
 
-static inline unsigned int xsk_pool_get_napi_id(struct xsk_buff_pool *pool)
-{
-#ifdef CONFIG_NET_RX_BUSY_POLL
-	return pool->heads[0].xdp.rxq->napi_id;
-#else
-	return 0;
-#endif
-}
-
 static inline void xsk_pool_dma_unmap(struct xsk_buff_pool *pool,
 				      unsigned long attrs)
 {
@@ -306,11 +297,6 @@ static inline void xsk_pool_fill_cb(struct xsk_buff_pool *pool,
 {
 }
 
-static inline unsigned int xsk_pool_get_napi_id(struct xsk_buff_pool *pool)
-{
-	return 0;
-}
-
 static inline void xsk_pool_dma_unmap(struct xsk_buff_pool *pool,
 				      unsigned long attrs)
 {
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bcc5551c6424..2315feed94ef 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -186,7 +186,6 @@ int __xdp_rxq_info_reg(struct xdp_rxq_info *xdp_rxq,
 	xdp_rxq_info_init(xdp_rxq);
 	xdp_rxq->dev = dev;
 	xdp_rxq->queue_index = queue_index;
-	xdp_rxq->napi_id = napi_id;
 	xdp_rxq->frag_size = frag_size;
 
 	xdp_rxq->reg_state = REG_STATE_REGISTERED;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3fa70286c846..89d2bef96469 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -322,7 +322,6 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		return -ENOSPC;
 	}
 
-	sk_mark_napi_id_once_xdp(&xs->sk, xdp);
 	return 0;
 }
 
@@ -908,11 +907,8 @@ static int __xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len
 	if (unlikely(!xs->tx))
 		return -ENOBUFS;
 
-	if (sk_can_busy_loop(sk)) {
-		if (xs->zc)
-			__sk_mark_napi_id_once(sk, xsk_pool_get_napi_id(xs->pool));
+	if (sk_can_busy_loop(sk))
 		sk_busy_loop(sk, 1); /* only support non-blocking sockets */
-	}
 
 	if (xs->zc && xsk_no_wakeup(sk))
 		return 0;
@@ -1298,6 +1294,14 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	xs->queue_id = qid;
 	xp_add_xsk(xs->pool, xs);
 
+	if (xs->zc && qid < dev->real_num_rx_queues) {
+		struct netdev_rx_queue *rxq;
+
+		rxq = __netif_get_rx_queue(dev, qid);
+		if (rxq->napi)
+			__sk_mark_napi_id_once(sk, rxq->napi->napi_id);
+	}
+
 out_unlock:
 	if (err) {
 		dev_put(dev);
-- 
2.47.1


