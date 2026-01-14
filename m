Return-Path: <bpf+bounces-78889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B149D1EBAC
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76A1B300D41E
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A24397AA3;
	Wed, 14 Jan 2026 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1i75yib"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA901397ACC
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393588; cv=none; b=tE/397NrBwD0aVIe5Vhn3xuHjhivkI3ccVc6jemfJW98SNzu/3g7Bwh5pQwOQujt3x28zp4TtqEdNNas4Lk6voVmgDhUOVdOJhbwzJ2FF1LPefAB9UkiGM6lUqWUAw0VeaDguiBclNizjpY3S8SW4ptntMlu/k1G1Lh4Z8wt9hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393588; c=relaxed/simple;
	bh=JEDnlZYXIHilnOnTePLHzYAZD0ZmBByyDO4WzTOYCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXn+Y9VuUe1BvNEPXkPK3lUTAow2IrL3oQqY8rCxXwSSZsLrCxVeaqOcv3FPQVgtIWEWoJ7doewjHrdOrRkr4zOiNUFk57ajCyD61Co1xVO2TWxx1rZ72LzbFPzEKrFT9CLMQPaQjfyhOmo30/R9mh0R1bwRKzaKbKA96h/K+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1i75yib; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29f0f875bc5so67940155ad.3
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 04:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768393584; x=1768998384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AbzNlyftwKRg9xsu0MFnIl7dchtZzqwBBSHtb8zwf2M=;
        b=b1i75yibxVgOr/Wjjc2QVYZnW3+jOTNz6BFEGAG0QuwV6TL7zfwc22aNfLk3bcD56o
         NYZ9Gop1frF7BfSHJnfDOf4NwWmYpMqbppapjspV4Zc2fYa0lPtlZJrXfE8W964peLnj
         mTiomx4X7nHZFwNFMwyz6REat4rCwtlnqhTCRKeD3OXumaxEHD0rMZED3xnu9VzYku2m
         Z3PpUFVzZ4YNYJZfIlsVdCA4+Y/G4fWGxsVj9EUB2H2OskVHbQGyjH1yatTkPWndV2Q+
         ZwvYKgRZQP1B9CUhhzr3PCz7aV9NsjYdW5dyomLar7sp8Bqkip+p890a0DvNf/s8lI03
         3jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768393584; x=1768998384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbzNlyftwKRg9xsu0MFnIl7dchtZzqwBBSHtb8zwf2M=;
        b=sgbTcgmXwLa43TijbO29DcgxFrGtY+4CHlz7e/9jFBd6zqhzLQL8jfcTyh4mFBCeen
         WNtS5Hs/AAjG9yTo02gFJtjWdGzQkxOjLmquZ7zugFrK4kL5wL3PLJoX8qC2hz67gP9P
         6Kd16SPdf20sxh+tI75ipO8HTBNHfwoGccjEko32xNuw539nEenyd8DlHfhbtgakFKa9
         1jzdv50zDtWpwkG79LqWtLYHyOBj8uffHZm2FSyt+AukT9DwiUhuHoFdSj1sr9GvL8j9
         5FxYLqc9GlXtr3fZyx3d6vCFVTBU1VkaicQI7GSrBSSkCEeJrxEo5nZPTQ3gxvcNx0GM
         P/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUueKmWuX4tEgR6lmG/uprZ8qnNNGwwFBzXqtFhwSNpWJjijfwmN+K/8v6654BurPn+wZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Xh234WGMRC/wJCgXM1T6onTv4iZWoZFeSa/B7aKtli/Sjomn
	faSmTkH/5eJp9sLJQz7TsT0J9+PPLwfD7YsU5bPGmRHwqsRrK1cbBBZ3
X-Gm-Gg: AY/fxX4kksPCbKGg94k+IlVmV7fa0BoU40CaZJTUJjbF0am4/ee0X1+AsQ9mmZtrUd1
	ErcFWkgORB8dWLs8gN485rvwlx+7fVaAUn0SXTkGpbX7aQsAosVq32Wm9+3Nbedlc+ydS2NOHAW
	O0I+wr5LsBLyGxfzHApxOk0CaniZbKspaIXSHStBnLzLvlZhT3ZouRZHQJtJZSt2s9MwhEat2u0
	8jYs1Cm6gPGj4vjPUq2g0yFrWA98siw8jYVqMU/q9ml8YH8jBqJd3hS0XP/XdrCa7JMe8Zhc0Xo
	WOLaIoI9vcfJa2nrQe231XIDweFrQGfo+To+dMPRWfGikj/4BX0eptGWeCq750g7F1YZwEmofeZ
	GLsYEuHE6ajf/VebbI9bpLWncRdKtQbueAmZy8z/JIt2c+6bTWrXafo4r85NXIuq9BPbhdc1h0q
	AqDzC61nRYoXEuSNrldZy46T8UvQfNJRHU2zej78IopOhLFhnH7MkfIg==
X-Received: by 2002:a17:903:40d2:b0:2a0:d34f:aff3 with SMTP id d9443c01a7336-2a59bb36674mr24558905ad.18.1768393584056;
        Wed, 14 Jan 2026 04:26:24 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd4401sm230327115ad.92.2026.01.14.04.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:25:57 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next] veth: fix data race in veth_get_ethtool_stats
Date: Wed, 14 Jan 2026 20:24:45 +0800
Message-ID: <20260114122450.227982-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In veth_get_ethtool_stats(), some statistics protected by
u64_stats_sync, are read and accumulated in ignorance of possible
u64_stats_fetch_retry() events. These statistics, peer_tq_xdp_xmit and
peer_tq_xdp_xmit_err, are already accumulated by veth_xdp_xmit(). Fix
this by reading them into a temporary buffer first.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/veth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 14e6f2a2fb77..9982412fd7f2 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -228,16 +228,20 @@ static void veth_get_ethtool_stats(struct net_device *dev,
 		const struct veth_rq_stats *rq_stats = &rcv_priv->rq[i].stats;
 		const void *base = (void *)&rq_stats->vs;
 		unsigned int start, tx_idx = idx;
+		u64 buf[VETH_TQ_STATS_LEN];
 		size_t offset;
 
-		tx_idx += (i % dev->real_num_tx_queues) * VETH_TQ_STATS_LEN;
 		do {
 			start = u64_stats_fetch_begin(&rq_stats->syncp);
 			for (j = 0; j < VETH_TQ_STATS_LEN; j++) {
 				offset = veth_tq_stats_desc[j].offset;
-				data[tx_idx + j] += *(u64 *)(base + offset);
+				buf[j] = *(u64 *)(base + offset);
 			}
 		} while (u64_stats_fetch_retry(&rq_stats->syncp, start));
+
+		tx_idx += (i % dev->real_num_tx_queues) * VETH_TQ_STATS_LEN;
+		for (j = 0; j < VETH_TQ_STATS_LEN; j++)
+			data[tx_idx + j] += buf[j];
 	}
 	pp_idx = idx + dev->real_num_tx_queues * VETH_TQ_STATS_LEN;
 
-- 
2.51.0


