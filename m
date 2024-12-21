Return-Path: <bpf+bounces-47511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE32D9F9E12
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 04:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1147A27F5
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 03:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA41A83E3;
	Sat, 21 Dec 2024 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7A2HeCO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC861A841A
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734751697; cv=none; b=tNKcH0hfxM8SK3gw/WeZ7+MALAqXjDUG317WWd4VdGoTco/a4LEWs7ZBCL4L4yh7L2F7Vb8/E57DFo+dNgBfjp6U98S5haMYttMc/UKyH0fSg63RmdU+9aLHdN6rBLmC59IWsq27Rh7W0sBByTCh7e3rhh0bwHkHZs4I4ImURzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734751697; c=relaxed/simple;
	bh=0r9RPzLueo071by/j66yGqEyUFdzbXHoDDfi7ICnaRk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rIWdk2GnkpShiaS/t6F+xcZNietAQCTzWhK4b6uG/Sl1XRD99bpdb6CYC/1SYdH+pEYBLngRhJ7vAgoZE1vnPE/WisVHAFeGVM3QGA+ctTOocIgX12Ps6IBlctxP/Q3xkdqtMrojKMwuNRvAlQdQVHimGFnerhSsbQhlDyRHUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7A2HeCO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7eaac1e95ffso1690264a12.2
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 19:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734751695; x=1735356495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tcxNSCs1RfdUrDoDnyiQQzL3U3m813D09LyracgP52g=;
        b=m7A2HeCOW4zfP+RrqV5i19ia/uV4/pn/5ClCKI7yn4hZqrH3LOs6EChdTFMCO65Jwh
         ipffk91FEN0tXgcBd7ShgatYKCkrwc3HkLVdKVCEAHYh+a5fvymbHClKW7h9xdHvvN1r
         v8EkWFeOB5GauAQqzI3OtzxAYGXEoQ7ksktb7We8fw96IF7fWHsmBCvSDXtLEQjbGvjN
         QTuBLgYjqRj2ZNLYcKlTEtOF9fRBz3WhyLyROEqB+TSNAOeUOGYWe3wtGKjtN3fl9Xq5
         2HBGJb+duryoiOW9K4zIJLYFwsNTm+0CcrqCTe/+fFF98fBi+tCu1RX1iNP08a9cSZS3
         ilcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734751695; x=1735356495;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tcxNSCs1RfdUrDoDnyiQQzL3U3m813D09LyracgP52g=;
        b=ZdD7WuClz2u5kOvhfw5j1/iBVutASUg4oIeC3Yaq7G/5Zm3VZv21fgAc6Rd1kcPI1F
         RRC117EMfkXRulkU0wrSPan021uZpR6lUIbumrH9CdM8Hjrq3oc+W5U9en2N7QWm/Ufv
         gpgnce8MalusgUlYQVJZAifjs7KRxk/RHYMuSFN1cx7AZbPiRSbaKDIwo4RQoOHJ63F7
         O6Cr959R38L9lXoq8ev8TRqk64Lz9CqkFG2getfwzsvWMgTR96boTqnlmnIP4envBfIr
         bh06BOtguSQuXzN0MJHFQAiXWuD4f6FLCop83JwrVNRTkAXyfzjJcy2to+LFET+plciR
         bu5g==
X-Forwarded-Encrypted: i=1; AJvYcCVooxhGSsK+53xWswH5OvCCR5CHNYeCMuuWU9yL4/cRSGnAVBq8XPOZLiAsrYyDuZWw+as=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUhKezzl6Rca3TfQfMEwzFS71sz/ybqufKdcp1OH3VSmwMTwve
	iu3LsncfjTpdGKnfQgj+vqf65AH9ZGizl12gka/ZmcrarOcYEZlBGEjxeiLXrWVSFIaqlEG8CmG
	bTDOw2lyVesYf52ok3Zxy+ELmgw==
X-Google-Smtp-Source: AGHT+IGeFqQj5dJOTAyGRmtAIXY2OUqiW0yrJQ0AXC6Y1dhP3iTemr82Ra1Fyo9FOmb1VKzWtqJ5Zjnbt2sbi9XtRN0=
X-Received: from pfxa4.prod.google.com ([2002:a05:6a00:1d04:b0:725:e05b:5150])
 (user=pkaligineedi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2d21:b0:1e0:bf98:42dc with SMTP id adf61e73a8af0-1e5e07f98d0mr9277145637.28.1734751695309;
 Fri, 20 Dec 2024 19:28:15 -0800 (PST)
Date: Fri, 20 Dec 2024 19:28:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241221032807.302244-1-pkaligineedi@google.com>
Subject: [PATCH net] gve: trigger RX NAPI instead of TX NAPI in gve_xsk_wakeup
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, shailend@google.com, willemb@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, hramamurthy@google.com, 
	joshwash@google.com, ziweixiao@google.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

Commit ba0925c34e0f ("gve: process XSK TX descriptors as part of RX NAPI")
moved XSK TX processing to be part of the RX NAPI. However, that commit
did not include triggering the RX NAPI in gve_xsk_wakeup. This is
necessary because the TX NAPI only processes TX completions, meaning
that a TX wakeup would not actually trigger XSK descriptor processing.
Also, the branch on XDP_WAKEUP_TX was supposed to have been removed, as
the NAPI should be scheduled whether the wakeup is for RX or TX.

Fixes: ba0925c34e0f ("gve: process XSK TX descriptors as part of RX NAPI")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 09fb7f16f73e..8a8f6ab12a98 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1714,7 +1714,7 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 static int gve_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 {
 	struct gve_priv *priv = netdev_priv(dev);
-	int tx_queue_id = gve_xdp_tx_queue_id(priv, queue_id);
+	struct napi_struct *napi;
 
 	if (!gve_get_napi_enabled(priv))
 		return -ENETDOWN;
@@ -1722,19 +1722,12 @@ static int gve_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 	if (queue_id >= priv->rx_cfg.num_queues || !priv->xdp_prog)
 		return -EINVAL;
 
-	if (flags & XDP_WAKEUP_TX) {
-		struct gve_tx_ring *tx = &priv->tx[tx_queue_id];
-		struct napi_struct *napi =
-			&priv->ntfy_blocks[tx->ntfy_id].napi;
-
-		if (!napi_if_scheduled_mark_missed(napi)) {
-			/* Call local_bh_enable to trigger SoftIRQ processing */
-			local_bh_disable();
-			napi_schedule(napi);
-			local_bh_enable();
-		}
-
-		tx->xdp_xsk_wakeup++;
+	napi = &priv->ntfy_blocks[gve_rx_idx_to_ntfy(priv, queue_id)].napi;
+	if (!napi_if_scheduled_mark_missed(napi)) {
+		/* Call local_bh_enable to trigger SoftIRQ processing */
+		local_bh_disable();
+		napi_schedule(napi);
+		local_bh_enable();
 	}
 
 	return 0;
-- 
2.47.1.613.gc27f4b7a9f-goog


