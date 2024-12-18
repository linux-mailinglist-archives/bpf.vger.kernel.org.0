Return-Path: <bpf+bounces-47246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8159F675A
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 14:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14915164CC4
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98391BEF9C;
	Wed, 18 Dec 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItRufYRn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116F1B424C
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528869; cv=none; b=MMh2+nbpQgUdNxhUTZUqLyeIKyTtvgx4cPDs3zMSJrIq6Cnmj2kv68zEK63sDW9sCey8BN2cj51VNQV4YJZdrdx42Wir5PKT6h7IslJT+px+Lyt3LBlhHnDySDddu79bal5yTE3Hf/tCTqTc5jwzYEsA+VOnrVgIigNTzvgQDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528869; c=relaxed/simple;
	bh=OriOUj3M1nI27Avpba3wIze2vFUhMiy7qxk7DOa3psI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oWGT86x+KPk1lZztcswFuFEWqPjz6f0RcM4PYl3hAHYhZo4zZJu1A5m4BtJne8RK2r+loEOtGpMK8ZmuSOCxS5LmceZnKgn47z8o4EvB4J12Ur2EjiUOnCA00lzlNoVmln4TnzbUuj7OjYkt2vVIfzsTxrWF5DHC0LdtEYA1YNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ItRufYRn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2163dc0f689so97542335ad.1
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 05:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734528867; x=1735133667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eAFTBo7ivhTuc59SVtnRzpksnEHu505WEYyIklRMIGY=;
        b=ItRufYRn/73cAfP6i7/w4xR+14kfugMij8ku+JWTbkQf+FHOFKda45OGjyvTo5TEhL
         +wB+F5azOSCleL5sHELza2tqeF8gcUObN7PZEWvILq5qKxVhunwm1YqFbIqy704UtMfR
         5MS0FLYK5P8Kv9Bmjt8//yK/RxGOdQObI5AC1cj7Fi5znnLYktJcBIRVdFWH5zxcErpK
         pFHC4EQFXNqjvIX82zmRlW89H4ylAd1KXuvlfnQzEu8HnBAVp2OY+Q4lUp4FAp5i5Tb3
         VJRlWt4MLSqUlKNb46LC4qXBFWXo4EU+6OH/AZxQ46NwJl3gQgfzt6web5aRGNyUDNVG
         Rjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528867; x=1735133667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAFTBo7ivhTuc59SVtnRzpksnEHu505WEYyIklRMIGY=;
        b=Gw/iOi7+4ywv/nBRHlsZ8xiLrryQLUjt1g8zpfBtAGVOpsqNi0kVb/gzzkyn52Vkwa
         nEdTlncskV0ZrIUMtOE3rDbyqCI66bCH8TYPG46oORAmVKk9vP89i8Ld7F/TuCwHiyU9
         2cFheH1F9xU9r2LNVz2ul51LkrSNM3qq7vXA9bEeBwjI19eNTEa9OoEZcyQnJBH39PVL
         epTVZdN503A5RnsnAvkQVVlvr6e+K1WCNJfgRrB+5yHvK/5wXRTpEzRquiHBDcLrLqiy
         1ktc60UOfHxLY5XYzvmMHjrdmlb6lowWdoSbkQvcgXcpwvw9jTgPSzy5ZMYOjlMLycgx
         04tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVZWX5E+CLsTebJNSDuZ3gXneE1o6bkJDJLr6GRO2dfIm3BBHxc1f49O5DjxCStugSwQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/sB9xbpz60xs6vtWZO3I9z8CttuzBTMomCag34P5DBzoduBl
	TPfZw0fdt9yql3qbACgexxnlIQdZCtY8ZCtduw9xF6ZSkh3pD6zllSCS2v9NNgywV5W4d8z309p
	CG7ViGGsXEEvC7y5n6aH43MKEKA==
X-Google-Smtp-Source: AGHT+IFY1SuAyxxaS/Chpz8wp/cqmlqOOaKMj+QKltDNe140ZmyzZdNe/qSR+a8+kqBKh2wehr1iKLZ6ofMLYYyTL+M=
X-Received: from plbmf12.prod.google.com ([2002:a17:902:fc8c:b0:215:3fc5:cd3f])
 (user=pkaligineedi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70a:b0:215:b9a7:526d with SMTP id d9443c01a7336-218d7223339mr44408425ad.32.1734528867093;
 Wed, 18 Dec 2024 05:34:27 -0800 (PST)
Date: Wed, 18 Dec 2024 05:34:11 -0800
In-Reply-To: <20241218133415.3759501-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241218133415.3759501-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218133415.3759501-2-pkaligineedi@google.com>
Subject: [PATCH net 1/5] gve: clean XDP queues in gve_tx_stop_ring_gqi
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, shailend@google.com, willemb@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	hramamurthy@google.com, joshwash@google.com, ziweixiao@google.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

When stopping XDP TX rings, the XDP clean function needs to be called to
clean out the entire queue, similar to what happens in the normal TX
queue case. Otherwise, the FIFO won't be cleared correctly, and
xsk_tx_completed won't be reported.

Fixes: 75eaae158b1b ("gve: Add XDP DROP and TX support for GQI-QPL format")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index e7fb7d6d283d..83ad278ec91f 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -206,7 +206,10 @@ void gve_tx_stop_ring_gqi(struct gve_priv *priv, int idx)
 		return;
 
 	gve_remove_napi(priv, ntfy_idx);
-	gve_clean_tx_done(priv, tx, priv->tx_desc_cnt, false);
+	if (tx->q_num < priv->tx_cfg.num_queues)
+		gve_clean_tx_done(priv, tx, priv->tx_desc_cnt, false);
+	else
+		gve_clean_xdp_done(priv, tx, priv->tx_desc_cnt);
 	netdev_tx_reset_queue(tx->netdev_txq);
 	gve_tx_remove_from_block(priv, idx);
 }
-- 
2.47.1.613.gc27f4b7a9f-goog


