Return-Path: <bpf+bounces-75715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A13DFC922C9
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D256A4E4B6A
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D7423C505;
	Fri, 28 Nov 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBvqWl1u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC31E3762
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337581; cv=none; b=pkYcAWClogKQ0cuVC09afdO6DHuOR2FHCPQZB58yqcIQFoD+K/7vBxYSoMb6j+k15WBr1Lc0cbvPbPbV7d2cxVQx2q18EenD7s4fO+Wt3UWZ55oGdyGC8RgCAca2xVau70gRF4FaQdir4fDx6xwjO7/wZQVwfB6rtTZF6RpDqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337581; c=relaxed/simple;
	bh=8Pca9WZtiP7HBlUrjHiwKmprAWD+pRMPdOh4BKMS3/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ApTsEFDdHkd0t4XkDpogIn9OeISoCGL7plq4i830XKCTVbVyKR22I6WObM0Di1hywYESrURacX+I7J1SB+gBToSV7uOhyUapUQ9KV/CexUHvY/4naidLZNzyJpsweEKG63AWn9tsB6V+lijuNOCcsst0s+J08BcHtiw90Qnq4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBvqWl1u; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so2157019b3a.1
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 05:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764337579; x=1764942379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQDNEhv41SZxn4CZSqiXIPfZRRdklxmN+y0WIhNggug=;
        b=aBvqWl1uhni+rLrHc1PwpM2TYfnKFAmNihTjSRZDc1XojD5lGIUjpavzJah+2UfJPg
         YoYfyjXzFMpw3BenBK/bJmumajhGLg47W/lJlquTJ6ZhJVC5H+ToHYZLbbBOj4xDjHyl
         Q006DQBZh+G4siBRME3OV/ZsbKKjCNWxITSS3aWXENpEvZiFWkWUB5eUlxkNMBhr8XIX
         nGxx9dPZuC3UVE1ehoPoHzc0bqzSIolUsJF1xQdtly74h20qHl+wMVTw+KHmJPFDH9f3
         Nq6KbPwcqdRwtNhmIYGeXGzgzmR1P+G2dXXyQkXRkb47q14mrarZzizBH9GH8PrjMbKx
         lIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764337579; x=1764942379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQDNEhv41SZxn4CZSqiXIPfZRRdklxmN+y0WIhNggug=;
        b=KcL/1NDn0cvT9EM3yi+JDyMLxtUeAHXJigYE6GugL+oaDgpPN1/jk3/5I/PlkYTn+5
         LavTdJFq8nW+8fbkV+rUGa664yUOwboy+P/rykq09Ec9nnb3Og5/+Lf5o5RIc0Oo6MMc
         v86g3hQTgpULglPfYQT2r7seJO/Nvme3z1OOWF4KybtwVhSLFVXIOF9zsYZFXXSozD1G
         sjmPZsZe772/xC/teOZEZeJ/LSJbteHYpjY4Z8vXZ4mWHOTkH6J/aJLQIbPgJif5RunS
         h9TtQCqAPnC8kfDo7Pwcf2giYlV1ridPeCDQkDvJC5YSsCFR2xPb5sAxIr04Fobw4DbD
         OZmA==
X-Gm-Message-State: AOJu0YwyQ1zgmMKeepbdPkbTOygAQGkuNK8iypU/IKuDFSdLr0Nma6Pp
	umt9fEtr1ltp/cDVTL095K1N642B+be9ce9k1Oghw+VynRnDDYUNbWOz
X-Gm-Gg: ASbGncukzqv/ddkePWuy2CfcUKNyawQLsH1rWhQn5X4UU1w4iULixmxr18KPpbm0IyN
	kdAhr8bu/1dgIhGD1BxnA4LNASfETGKY5iQvJe+S/CC2aO7xNA41eg9walzf1VS97xtXlgASlHd
	VMB4gutJDng81OgHXMCZbqRqcRzRaU5NwxhN+FDTOYKaO9ICJvZAHpm8em6/rHVr+WB6xPcS911
	m2Ss/hyOZNVtOUxZ/+xc2+XbUe9NbVwVBzfqmVx2ZegOdcdaY9ngZJJ23ei7V5PtJqkq3egTgw5
	atkS9O5NVo1BaDNSyj2ZCc2S936g+hZ0cHpuJoyXyjRil3tfaqUZd3lt0DBeYQzgIYy06oVtWxW
	lkn+Viu50MOYWHGGthp2nD9Glnu5JmeISaqneknvkq3F4AZQyb+KNn3e5jYkO20FYbTvH6NKwBo
	Bv6PnILyhnkyexxfqdGrWGXrENX0nQRB/kNa/0C9LSuXKbBs/m
X-Google-Smtp-Source: AGHT+IGPpk69AHln8lXw/rw3UXGAEU8DPLMGKvQIO/OtV98mEWYurcZQVG99Fqvskfqef8UN8NfbFw==
X-Received: by 2002:a05:6a21:339a:b0:35d:3bcf:e518 with SMTP id adf61e73a8af0-3614e96095bmr30935286637.0.1764337579276;
        Fri, 28 Nov 2025 05:46:19 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([114.253.35.215])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbde37d7sm4792674a12.13.2025.11.28.05.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:46:18 -0800 (PST)
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
Subject: [PATCH net-next v3 2/3] xsk: use atomic operations around cached_prod for copy mode
Date: Fri, 28 Nov 2025 21:46:00 +0800
Message-Id: <20251128134601.54678-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251128134601.54678-1-kerneljasonxing@gmail.com>
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Use atomic_try_cmpxchg operations to replace spin lock. Technically
CAS (Compare And Swap) is better than a coarse way like spin-lock
especially when we only need to perform a few simple operations.
Similar idea can also be found in the recent commit 100dfa74cad9
("net: dev_queue_xmit() llist adoption") that implements the lockless
logic with the help of try_cmpxchg.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
Paolo, sorry that I didn't try to move the lock to struct xsk_queue
because after investigation I reckon try_cmpxchg can add less overhead
when multiple xsks contend at this point. So I hope this approach
can be adopted.
---
 net/xdp/xsk.c       |  4 ++--
 net/xdp/xsk_queue.h | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index bcfd400e9cf8..b63409b1422e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -551,7 +551,7 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 	int ret;
 
 	spin_lock(&pool->cq_cached_prod_lock);
-	ret = xskq_prod_reserve(pool->cq);
+	ret = xsk_cq_cached_prod_reserve(pool->cq);
 	spin_unlock(&pool->cq_cached_prod_lock);
 
 	return ret;
@@ -588,7 +588,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	spin_lock(&pool->cq_cached_prod_lock);
-	xskq_prod_cancel_n(pool->cq, n);
+	atomic_sub(n, &pool->cq->cached_prod_atomic);
 	spin_unlock(&pool->cq_cached_prod_lock);
 }
 
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 44cc01555c0b..7fdc80e624d6 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -402,13 +402,20 @@ static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
 	q->cached_prod -= cnt;
 }
 
-static inline int xskq_prod_reserve(struct xsk_queue *q)
+static inline int xsk_cq_cached_prod_reserve(struct xsk_queue *q)
 {
-	if (xskq_prod_is_full(q))
-		return -ENOSPC;
+	int free_entries;
+	u32 cached_prod;
+
+	do {
+		q->cached_cons = READ_ONCE(q->ring->consumer);
+		cached_prod = atomic_read(&q->cached_prod_atomic);
+		free_entries = q->nentries - (cached_prod - q->cached_cons);
+		if (free_entries <= 0)
+			return -ENOSPC;
+	} while (!atomic_try_cmpxchg(&q->cached_prod_atomic, &cached_prod,
+				     cached_prod + 1));
 
-	/* A, matches D */
-	q->cached_prod++;
 	return 0;
 }
 
-- 
2.41.3


