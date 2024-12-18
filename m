Return-Path: <bpf+bounces-47250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBFE9F676B
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 14:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2341630BD
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DB01F37C6;
	Wed, 18 Dec 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xfz5QjC+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58E1E9B39
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528875; cv=none; b=FmCDrm4DKuac8JSUP93vmuVX9M2hqtAB73FjxzoMc8Ah5308rYlMYgAYI14at9o3iw/hSg4nfSkonfycOpmVdBRl7dxoxeQzqpIq33MHDTUN/KA8Ks/PuLQY14UBY5Xp6np7dFoWFBj4ZWBIlTl+67ktNC9cqKluapB7eyHgp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528875; c=relaxed/simple;
	bh=5nW61vOKeFgt2Ca3diR0gPzoG2D8KLy0Ubznq3j8i3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pxFIm17VAhl4aoUZX+u7tsL+PLphrCBV2w7V76rFyCZ58NUb45sdcJWvTIEEPHPL88zUD4UHheHZ+fclLFntg2r1iMaAtC3b9fXCe/erpG+qknw7FfxVXVzJPcW1F2CbSqdbsL9nbsPAxJ268GpKR7hAgeG3kjzdcX/6lBVbit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xfz5QjC+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fcd2430636so4424428a12.2
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 05:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734528873; x=1735133673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5p6vlUBAsmQyOt8BuyoWsG+1hipC/LRRSVT0CsAjCw=;
        b=xfz5QjC+/jESiv2uFvLF7rUuOSlvdU5UBtL8Zkt4O0ZXCoAZdgPaXDdijcxVsWITru
         HcmSIsWy80R71wgIMCGdjrJeeDRX++FLMrlmeZLjS4oHGnjYypKkni4/blLGJxCEInth
         eip0fZuoxqh/nDopdSQzPsdp6RGkqFaFCbft0UsNrXDW2rUIlNhg+a93nXNc22tB0WcE
         9UGJI/u/6mLWyg61qAA0Zv256zRIRNQtCTVHbg7/A6Gh0mtZ0KikFiDRi5++rsZC1SfX
         hsF4gs0h/yhycSJtQEg/bIWRs/ljOomEIPdn+IAuNv7FMUwJyP37DFdSwcBRpyd0FkU+
         LgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528873; x=1735133673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5p6vlUBAsmQyOt8BuyoWsG+1hipC/LRRSVT0CsAjCw=;
        b=jY0WdKhOBQ4BPHxxgjJURg93dS6MFVq8Jeli4YAiQuHIwxOPqp9SPbXYhgm2u8F+3G
         +eA9tLA2MZR6J/soeISKQSnOgozrRfpuWngFttiXzFjP7+yU5qZNhe20Epu5wWBIsSPP
         B6FXqOEykwMP7XktKuC+lie5Jlz7wPnfztiHzraYeoSd6Qp4Zvmjsin7vR6aqvUkACzg
         Jl7EVIUkj0Wa/BNHB+nFwX+lUmy5WVuZ9jud/txjyRbF5B28IOV3oVGpMRKdH/plJLTO
         1CJGO9hoK158oB0EaJhaFHA/I8LXmGLLSdS2iL8fbQh4YTAIHya+vOIOrw7U/CWep7bD
         Sikg==
X-Forwarded-Encrypted: i=1; AJvYcCWEfsdINyjwF6Ayv2yFNd2+LJaE2OxecmJxAsEcRTPNJsM3alKP6cyov5ElMqtYob99v2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZDfZUu/wfVW52uMdo4mgOqnOgDDA9nhkmoh3tFdEIbAE25E6
	JcF50vAAhba3AVGBdtXWcM4a5h+PCVs4dgPYo4MZd+XnCszs252RhfTCrd8XnM5iDiKMujI8Oy/
	y1JUbEbYFC48gc1fQ3JGQowaT0A==
X-Google-Smtp-Source: AGHT+IESNBKLCTm0uqLX+DRFxTtWjk+95d5i9mTaDJzn1eicqwfkpRcGBjtCrRCjQo4wMO7Q8jBDvY0A+fhe0GGi+qI=
X-Received: from pjbqx3.prod.google.com ([2002:a17:90b:3e43:b0:2ee:4b69:50e1])
 (user=pkaligineedi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b8f:b0:2ee:df57:b194 with SMTP id 98e67ed59e1d1-2f2e91fef48mr3520473a91.21.1734528873500;
 Wed, 18 Dec 2024 05:34:33 -0800 (PST)
Date: Wed, 18 Dec 2024 05:34:15 -0800
In-Reply-To: <20241218133415.3759501-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241218133415.3759501-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218133415.3759501-6-pkaligineedi@google.com>
Subject: [PATCH net 5/5] gve: fix XDP allocation path in edge cases
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

This patch fixes a number of consistency issues in the queue allocation
path related to XDP.

As it stands, the number of allocated XDP queues changes in three
different scenarios.
1) Adding an XDP program while the interface is up via
   gve_add_xdp_queues
2) Removing an XDP program while the interface is up via
   gve_remove_xdp_queues
3) After queues have been allocated and the old queue memory has been
   removed in gve_queues_start.

However, the requirement for the interface to be up for
gve_(add|remove)_xdp_queues to be called, in conjunction with the fact
that the number of queues stored in priv isn't updated until _after_ XDP
queues have been allocated in the normal queue allocation path means
that if an XDP program is added while the interface is down, XDP queues
won't be added until the _second_ if_up, not the first.

Given the expectation that the number of XDP queues is equal to the
number of RX queues, scenario (3) has another problematic implication.
When changing the number of queues while an XDP program is loaded, the
number of XDP queues must be updated as well, as there is logic in the
driver (gve_xdp_tx_queue_id()) which relies on every RX queue having a
corresponding XDP TX queue. However, the number of XDP queues stored in
priv would not be updated until _after_ a close/open leading to a
mismatch in the number of XDP queues reported vs the number of XDP
queues which actually exist after the queue count update completes.

This patch remedies these issues by doing the following:
1) The allocation config getter function is set up to retrieve the
   _expected_ number of XDP queues to allocate instead of relying
   on the value stored in `priv` which is only updated once the queues
   have been allocated.
2) When adjusting queues, XDP queues are adjusted to match the number of
   RX queues when XDP is enabled. This only works in the case when
   queues are live, so part (1) of the fix must still be available in
   the case that queues are adjusted when there is an XDP program and
   the interface is down.

Fixes: 5f08cd3d6423 ("gve: Alloc before freeing when adjusting queues")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5cab7b88610f..09fb7f16f73e 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -930,11 +930,13 @@ static void gve_init_sync_stats(struct gve_priv *priv)
 static void gve_tx_get_curr_alloc_cfg(struct gve_priv *priv,
 				      struct gve_tx_alloc_rings_cfg *cfg)
 {
+	int num_xdp_queues = priv->xdp_prog ? priv->rx_cfg.num_queues : 0;
+
 	cfg->qcfg = &priv->tx_cfg;
 	cfg->raw_addressing = !gve_is_qpl(priv);
 	cfg->ring_size = priv->tx_desc_cnt;
 	cfg->start_idx = 0;
-	cfg->num_rings = gve_num_tx_queues(priv);
+	cfg->num_rings = priv->tx_cfg.num_queues + num_xdp_queues;
 	cfg->tx = priv->tx;
 }
 
@@ -1843,6 +1845,7 @@ int gve_adjust_queues(struct gve_priv *priv,
 {
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
+	int num_xdp_queues;
 	int err;
 
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
@@ -1853,6 +1856,10 @@ int gve_adjust_queues(struct gve_priv *priv,
 	rx_alloc_cfg.qcfg = &new_rx_config;
 	tx_alloc_cfg.num_rings = new_tx_config.num_queues;
 
+	/* Add dedicated XDP TX queues if enabled. */
+	num_xdp_queues = priv->xdp_prog ? new_rx_config.num_queues : 0;
+	tx_alloc_cfg.num_rings += num_xdp_queues;
+
 	if (netif_running(priv->dev)) {
 		err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 		return err;
-- 
2.47.1.613.gc27f4b7a9f-goog


