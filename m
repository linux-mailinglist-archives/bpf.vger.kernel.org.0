Return-Path: <bpf+bounces-47990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96791A02F6C
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 19:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2121C3A1457
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B2E1DF97F;
	Mon,  6 Jan 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/bfSPn7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AD19CC2A;
	Mon,  6 Jan 2025 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186533; cv=none; b=bIKh8q7yPRztFItTP6S/MlE3SXUQU6EnYBHPEg/ampWgPtj4Qqn76kS8K6hj8BnArIh0R/JX7fDHEn5FJXOFbgEmit9nSFQIhnMTfQEkihrlJle4fzHyrbmYaCooTyMgfFvWpXpRvcrPIcLAlcbu57lYr1sySxSLNzeOzLrHEKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186533; c=relaxed/simple;
	bh=EKx8mGh4pzmtlwfchOsFoEQke59Ll1f8oRSb788RmEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8S9aaXs1Lkn0bZEpdLs2sC2f156UQZW/DwBw+3gWY/FS5+UyZIfL4hA7tNYOhjBuLXVKU6fHTULZho3Vrgoowm/4disuTqXr8douU3PjZrvW8EpZvMF8liKHLIr+MZDtmc0vgATidQ4XKjDnUVCCeWTLCDfBNwYojC/y7+txIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/bfSPn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE346C4CED2;
	Mon,  6 Jan 2025 18:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736186533;
	bh=EKx8mGh4pzmtlwfchOsFoEQke59Ll1f8oRSb788RmEU=;
	h=From:To:Cc:Subject:Date:From;
	b=N/bfSPn7oJewj55KyLfLw9XEBdORQ0lV5WGTQwBrN1/wfPtirKI8VC13TVWTHVwBF
	 zB/MA2k3mXFyGkfbFaZwovnJ5Kct1v5Q740MOdVbrJvJ5JNSaopeddwYW6PGjVWrmk
	 2jStwaMfBnt87V298z7hroxiiHaUNaqfJu+1KWD5ynEDguNNg5we7KuNyg6Vsy49CJ
	 QI47QpqLrSwy4UHBHq5FpWGLuIrAkpVtNEpn1/mg9pMP7/fXM7DBFyIQwduwymlkYz
	 LHiMNAaiu4b6dwydSo/3lG5xPl2JBLS1FIRhpx4IUm+ijicw9lGfPher1tUAyUA4rh
	 B+wc97mcQQ5Fg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jeroendb@google.com,
	pkaligineedi@google.com,
	shailend@google.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	willemb@google.com,
	bpf@vger.kernel.org
Subject: [PATCH net] eth: gve: use appropriate helper to set xdp_features
Date: Mon,  6 Jan 2025 10:02:10 -0800
Message-ID: <20250106180210.1861784-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f85949f98206 ("xdp: add xdp_set_features_flag utility routine")
added routines to inform the core about XDP flag changes.
GVE support was added around the same time and missed using them.

GVE only changes the flags on error recover or resume.
Presumably the flags may change during resume if VM migrated.
User would not get the notification and upper devices would
not get a chance to recalculate their flags.

Fixes: 75eaae158b1b ("gve: Add XDP DROP and TX support for GQI-QPL format")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jeroendb@google.com
CC: pkaligineedi@google.com
CC: shailend@google.com
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: willemb@google.com
CC: bpf@vger.kernel.org
---
 drivers/net/ethernet/google/gve/gve_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8a8f6ab12a98..533e659b15b3 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2241,14 +2241,18 @@ static void gve_service_task(struct work_struct *work)
 
 static void gve_set_netdev_xdp_features(struct gve_priv *priv)
 {
+	xdp_features_t xdp_features;
+
 	if (priv->queue_format == GVE_GQI_QPL_FORMAT) {
-		priv->dev->xdp_features = NETDEV_XDP_ACT_BASIC;
-		priv->dev->xdp_features |= NETDEV_XDP_ACT_REDIRECT;
-		priv->dev->xdp_features |= NETDEV_XDP_ACT_NDO_XMIT;
-		priv->dev->xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
+		xdp_features = NETDEV_XDP_ACT_BASIC;
+		xdp_features |= NETDEV_XDP_ACT_REDIRECT;
+		xdp_features |= NETDEV_XDP_ACT_NDO_XMIT;
+		xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
 	} else {
-		priv->dev->xdp_features = 0;
+		xdp_features = 0;
 	}
+
+	xdp_set_features_flag(priv->dev, xdp_features);
 }
 
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
-- 
2.47.1


