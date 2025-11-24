Return-Path: <bpf+bounces-75327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C55C7F5CE
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 09:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA8B74E4033
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B25E2ECD14;
	Mon, 24 Nov 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDTedkom"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495242EB85B
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971766; cv=none; b=QJu3HRZaZjKQoyg73Pw//CcP06ywZ4SGVI8FDlvhY485VYLxu4Nqw2ITi2eJeB2cjK7ujLyCaizXFicBq3UVoWGg86MBxFN3kvnZw9KlKFNrnucGU1/yN2qbjlZoGKs4XYfhhFe5pqI8xv6NPmKbRcDXTszyDmFWvbWRViT8zkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971766; c=relaxed/simple;
	bh=7QccW803eL7f/iyJXIZNWKuDIOUar+MdvsM5WTQbMTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjQGi6kA5h6Do37KOxnUWLg/LRi1XeO8cC8wtQqQaOBXFwdLWKnxO04REPWRlKJBpoQlKhjfr8jMu+ADYo6/KIv4j8rch1rqzq2yhmHHGgfz9x3u+HAmsRG4AHmiHkXIYa47ryboIK+c5Ui4fERcYUlNaX8vnDp9HGtqFSAuYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDTedkom; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso6300881b3a.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 00:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971765; x=1764576565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sai63keII1uujc2HiRryylYk6S+BDob0/yjLuIN+/Ws=;
        b=RDTedkomj5At36PC3F+BXYKpkbO9mdFgx/eJ8E3DRBxONvqkNzqjS6qlmDHr/1W+N+
         ca35/4g4sMwBRVC0/z42WK1RjAtjVs6M9tSYVBzBn8qJ75HzdaxcIyS0TbIs0jPZRp4V
         uqEUD8tHeYUeQGtPKBtaaK4iz7GcGDeABXJ8cS0SsK1thkV64x4m4h5IxCW52wq22qoM
         2/X9pfOh38p4f7QUMZcThlrDq0Fpplpvc/YnDLI+5+lNtn++aysX7rI9qllrJQWZeIkU
         j9Vn4v/ARASDVcdOFwU27rnKSWz5wTJZsOgzWBgtpVcD1OsK0AthYoNbG4sCxaZe6svT
         HpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971765; x=1764576565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sai63keII1uujc2HiRryylYk6S+BDob0/yjLuIN+/Ws=;
        b=tEqISUhK2G0LcBgG6KQ7bKrvikRiWEJFxvTe7FhLgiWeYnILSMQZ/AzzYixDV5GnCa
         SdxJo5b3oECA8eoZqYYOWX+30SCR+W4Ma9AR7jHIHxgIkQNUTfr5ELHEQl/Z2GrFlBZ8
         Grovag68GnvGAmN9tYzZrLtC0/9idhKPp1p7acDLneRAtbnErKsoU1UtIjWo9/EyCkuc
         dmWyIHw3/scwyahCuL5CFd1wHFxQvoXA8qUmqa6V2P0PsEWSLZDxgULkN/LRXsDEP+hB
         hVAk0rLldH4gkX6q5FTueCoRkQZmmuKT4Kd37meb3rKTeqcq0+qAp7BoJ/1QxYLpeKPS
         gHSQ==
X-Gm-Message-State: AOJu0YzuOs0VtWqcXTJv0AS/UD+UCzy2lMJc7GR74T37HZs9IBkLkugk
	5bTR1iWVtk2gwzH7gor1gQyrvLajVxkOXOl5zvGy7I0w2vCgf5VrICvi
X-Gm-Gg: ASbGncu2Mx7N3Bsfs7I8tMlCB+Go/vhbo1hxH4yP/zvwrZsw/r5KUAJlNxJOUoLRSXO
	W5uPUTtvl0PE8/crWeNITu+6R+4ddyNjzdwpLiEtNEFJB8Sh54Ten8l+GYmnjOX5UzmaKl3/NQi
	lydKORvI6CmAPfi+KhVrykSxglN1j52E1O4WWh0PWYc9tLXRm2KjNKdyXxVAFU4CfY/XvGcqtFC
	qVywagG/YZIdxWY5f2mdsjMgTmoXPhWUNjvOStiOJZquOJlJRbe/YZUYSdAG8rfvkyje1s5lH/j
	hsDipPkYdhngL7hOKlrB4WB+QKsBB8dqwy1HJa3cH892bafQQPlsdnl1pkRKJ/PWwUjh41A/rWs
	o0K4ttxmXChWY7ncZcbgVGGunVH/pfrfMh/swt5GNgMUpqTLjHO4TtMrRZl9v3e8ez90etni64j
	u33mGD1PLdQvmc2oY87Nooe/tBDP3l0H8p9DVfXdgxuR8wK6meoMAFt1oUiYbyDVvH4QXx/Q9p
X-Google-Smtp-Source: AGHT+IGEe6v25Drb1fpnPFTvO5rkcFw3F3TYJ5gGtIRf4auhQqn70IkpH+Mqko7T567f1Rqxqnd7mw==
X-Received: by 2002:a05:6a20:7483:b0:361:3bda:e197 with SMTP id adf61e73a8af0-3614eb3a735mr12462300637.4.1763971764597;
        Mon, 24 Nov 2025 00:09:24 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75b61c29dsm12343837a12.0.2025.11.24.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:09:24 -0800 (PST)
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
Subject: [PATCH net-next 3/3] xsk: convert cq from spin lock protection into atomic operations
Date: Mon, 24 Nov 2025 16:08:58 +0800
Message-Id: <20251124080858.89593-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251124080858.89593-1-kerneljasonxing@gmail.com>
References: <20251124080858.89593-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Now it's time to convert cq in generic path into atomic operations
to achieve a higher performance number. I managed to see it improve
around 5% over different platforms.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 12 ++----------
 net/xdp/xsk_buff_pool.c     |  1 -
 3 files changed, 2 insertions(+), 16 deletions(-)

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
index 4e95b894f218..6b99a7eeb952 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -548,13 +548,7 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 
 static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
-	int ret;
-
-	spin_lock(&pool->cq_cached_prod_lock);
-	ret = xskq_prod_reserve(pool->cq, false);
-	spin_unlock(&pool->cq_cached_prod_lock);
-
-	return ret;
+	return xskq_prod_reserve(pool->cq, true);
 }
 
 static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
@@ -587,9 +581,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
-	spin_lock(&pool->cq_cached_prod_lock);
-	xskq_prod_cancel_n(pool->cq, n, false);
-	spin_unlock(&pool->cq_cached_prod_lock);
+	xskq_prod_cancel_n(pool->cq, n, true);
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 51526034c42a..9539f121b290 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -91,7 +91,6 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
 	spin_lock_init(&pool->xsk_tx_list_lock);
 	spin_lock_init(&pool->cq_prod_lock);
-	spin_lock_init(&pool->cq_cached_prod_lock);
 	refcount_set(&pool->users, 1);
 
 	pool->fq = xs->fq_tmp;
-- 
2.41.3


