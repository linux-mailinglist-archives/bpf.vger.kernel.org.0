Return-Path: <bpf+bounces-77753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D5ECF0798
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 02:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A5AF3021746
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 01:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE5E85C4A;
	Sun,  4 Jan 2026 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myvRqccz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692157C9F
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767489700; cv=none; b=C6ulU2f5XJ0fu+xy9TL4vJOmJU/OVPTM6w3VrbCyiRizP8VClnCgGC1zkdeeP+yzc+pCKmhq9QX9kVXg8cegeB0+Zj/X6TGlMkV7wJ74Omxcs0Tl8Ybi52dee8wqHqorTyUv7ND/83VA4+m92oa5kiEDmyOnwKGwG/h+RE5shII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767489700; c=relaxed/simple;
	bh=687vFU+Ac3ElVt5OfIK9YxqFBQwJpgACGGszq/z+ks0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVK9g2jNoyrvnCkpEBphFbfgrb9oLVSdHGRManOJbiO0V9yyLanyPbvF6CZHfizGEjAwZyqtYU6Zio+eC4CwlH2zPABijAaVuNyJ6LCfxo6DBK6/UwzAHTIPI16kHuJjUc804xT4Ahn8TFe042KPZurtMHqtRZ3vvj2GJhPyjtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myvRqccz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso10326404b3a.0
        for <bpf@vger.kernel.org>; Sat, 03 Jan 2026 17:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767489698; x=1768094498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw/KQU3zYxL/kw3hU57BvEqlVos5RIoPuX74COM6oHw=;
        b=myvRqcczVWERbnCl80RejvdYLzJviPI7D/RNVEb8Gmp9jCH0EqUng7WGTPAl+bliGI
         MK+xr9u3Sb5oJCfjc9Z9Ah9BOE12p+X/7QabaUPNatNKSkDxCJwOM/9cJXr/z74zNukN
         LjxoaBSe86HBR6jRlvbBnFef8CJ7vSx22qlbqtUTCTGgy9m/4xTVQPfPVZ4fWoEbdOfw
         J1FpP1Qaxu4o+LGK5yGCdNxcZ6f8M/UchPnjc+XLz+SGtKa5qcpv762Kpuuj0F4JOPEg
         2UqrFVPib1h6rl8HP3XRkf8pZeoihrUfLjlaU3+ozBTT5pqMYlXydWsK4dY6HFsicbsT
         +2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767489698; x=1768094498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qw/KQU3zYxL/kw3hU57BvEqlVos5RIoPuX74COM6oHw=;
        b=QTbIqvn1JBfx8+yYn4PHt31v0yNMoTEj4723joLnUKLYexQbT8XiomCXLemG1Oj8l6
         LkxpZV0XUxPEILvW7GfR08CTmI1ozw8g6ryb+7MKVLRdYY+eAXV6QDi4cy3lVDd/orgW
         zrlVuextvZgFZ4w5J3vDkp1fyij1OqW1xT/NwOyGbUrfqjKxv1FVk7A3KpcsocQmHQsv
         0RO9w+5M7m+6rtl+zcP4tz0oB21pFaXT6/3p6tkRL44j+gPoatEwEs6DANMDY6yxCsd2
         q2i/ZeaQzQd9nFV+AqQHIVfO6W/3yXsapisGAzbF+wpcbqrKmkfbPFHAoPKb4penjDV8
         eAjA==
X-Gm-Message-State: AOJu0Yx3/NerP4JAcTRL4nWw45b/D2Z/yImN9+17Rk9AKy2EDLRZwek7
	gf4OI+SBzp11V0Zgt8RYM0YqagVNfpEGeZ0bB21JmKU3ZLP33ofei2Qu
X-Gm-Gg: AY/fxX6DMWzQRDq5I1U+HqTYqoBn8Kc9my+E17SCSRTRfK5WJzAZd+x4Ab1+bru6g+L
	0W531wqLY9i81w53VHzPR2UaraNOSm1vKLRbKcaH22My7nm6r+5Yf1ZXpWlJFaA7coyVAPQ+HC3
	EAxUlYe4R2knsvhLWmx2L5j0HF56ZMV6S/N6MQafD9yO5VLInQeaTN/Dtf4kIhCHflrDg12HkeK
	zKOb09XEOsbAWksug4e1yRac0niA+5IXpNKtUB6TpGqa4OeLhEVq/p6Wgdts0LHYKoj35nenqVz
	bH1tOoZ7OFPvU3S9OyxJkYZI/FMEUYnEyJMuzE5htRGJ39Kc5tkw0u5RpB0UlkbaxurFdfXWWGT
	IfQkjVRXzgeH+R2WTSp6wrzDZ0QklJitmBETLUW7VgRrM5xLCvVvcCJ6vDVyxD4gh/UVfc1xjTm
	C4InsxCRMwtAWYR4YRz2pxKSD1u6w373Rv96bMgRO7cngy4efVLO9OocBMVA==
X-Google-Smtp-Source: AGHT+IEKWnD4epXXeTEC3lbcdS2+1wBtn4kSsifXIKD0EXqGLXf5GqvVdXiwWJ3KHtMCs9pUQoNyAA==
X-Received: by 2002:a05:6a00:4509:b0:7e8:4587:e8c1 with SMTP id d2e1a72fcca58-7ff6647983bmr37764640b3a.52.1767489697811;
        Sat, 03 Jan 2026 17:21:37 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f3d7sm44484500b3a.51.2026.01.03.17.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 17:21:37 -0800 (PST)
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
Subject: [PATCH net-next v6 1/2] xsk: advance cq/fq check when shared umem is used
Date: Sun,  4 Jan 2026 09:21:24 +0800
Message-Id: <20260104012125.44003-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260104012125.44003-1-kerneljasonxing@gmail.com>
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In the shared umem mode with different queues or devices, either
uninitialized cq or fq is not allowed which was previously done in
xp_assign_dev_shared(). The patch advances the check at the beginning
so that 1) we can avoid a few memory allocation and stuff if cq or fq
is NULL, 2) it can be regarded as preparation for the next patch in
the series.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c           | 7 +++++++
 net/xdp/xsk_buff_pool.c | 4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..3c52fafae47c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1349,6 +1349,13 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 		}
 
 		if (umem_xs->queue_id != qid || umem_xs->dev != dev) {
+			/* One fill and completion ring required for each queue id. */
+			if (!xsk_validate_queues(xs)) {
+				err = -EINVAL;
+				sockfd_put(sock);
+				goto out_unlock;
+			}
+
 			/* Share the umem with another socket on another qid
 			 * and/or device.
 			 */
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 51526034c42a..6bf84316e2ad 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -247,10 +247,6 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 	u16 flags;
 	struct xdp_umem *umem = umem_xs->umem;
 
-	/* One fill and completion ring required for each queue id. */
-	if (!pool->fq || !pool->cq)
-		return -EINVAL;
-
 	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
 	if (umem_xs->pool->uses_need_wakeup)
 		flags |= XDP_USE_NEED_WAKEUP;
-- 
2.41.3


