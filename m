Return-Path: <bpf+bounces-47247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79759F675D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 14:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6A116548A
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E311D63D1;
	Wed, 18 Dec 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0/JaCxdu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E341BEF84
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528872; cv=none; b=hUGYl+B6t7ul6BqjWJ3o5v8NcQ9k0nXmE++1IlJIcML6/XyE83w9NhH4O23j+1qJi5s6i/OV9Bzb7Av0ElHBMR0EFsDhnh23gIXA5417HOZDaeSS+ihRWzoKLtbTPDfSRGNqCpQT0hE14ZucVUU81E+jQphELqNUy1c4zy/WHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528872; c=relaxed/simple;
	bh=CvjpZzap2JTZv3aoX0brnCAcyXx3Af2l9Bmavz1WSA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q+qoDrPgZZUDmzYBQFmk7DSuNEtmKoAwHSaYVBTPTihm9oa2qUDRQPAVrE5wloxqTJ47XIbLJhCLcosmp7dGuYFJiBrM1jS79kyIdHGRAPReEtvh/O+OcMf3WDxQlXxjIDmY3wqhdKMWjrXrtFUVSD3vBQyKMcSbLEmT375l8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/JaCxdu; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725cf25d47bso5536418b3a.2
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734528869; x=1735133669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRgIGaGDm4cvXXtjC5u8gCurbHYhRvv9RGqvrTy9ue8=;
        b=0/JaCxduaU21L5RaQx1ihJQkMX1AE95D59KPUyoGVH8hJltOXiXJqNS3vX4009WxH7
         rjpAASdQXLKI/+jO1QdHUfThNL8htyOBJzRrXOoN8z13/4tprvTc1bF+j5iAerBkM/9C
         vDuF04wu1F32nO8QvX/5a6TnWttMCrImbvkysgqaj8VF9dM7SdZVy8EatBls/34C/KTi
         LOCh/CRcBkWUuYrGSuLCdwgT5ImdZYYv3b98OHWzvq6hpkgjZ3vrDkjD0EFDEoC9h+Ov
         f2WchjMngQRtdwc457HC6V/svmX+Vqay5lFNygRpNw4Pg+O9VNyKDEQbx8ODPbox863J
         7SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528869; x=1735133669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRgIGaGDm4cvXXtjC5u8gCurbHYhRvv9RGqvrTy9ue8=;
        b=V8UPWPTtOki+OCTQuoBeXu4g2VWYLnlnD31HiZ8joSahpyTLKOVlsLbwaI3mUK58+b
         3XzzlThYHNGdCKxFAXf5d6cVbidN/tHL5hZualZe9MENYZzE4C+dLOnhk5bx+EPjYT8c
         6Jt3//FMWjOQNUI1YIN1cuuqKoNF4/ojIiGv0Sv2Ic4Nx9CfHFslslcuQFJorDw8NWbA
         TsZ4lu9wR7n8H01Ev8ofMkdQErr9DUIlQDJZ5OXl7F6Rz7UrGkfXsUH4Y29lrmOTqzkA
         GxqepeoQ3P2IpSPbRuifRusl0hbS1HJ+ZGDNNIjBhoRXarLKonRtJ/2llxpcRLfRNWXw
         kzDA==
X-Forwarded-Encrypted: i=1; AJvYcCUbJgPD6Yx+9fsNmhFsJn4FLL02gRpc8cLgj5ZO1pkqux+U9/TtkRUsyznKA9djwojw/ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKc4OqMUZ8Q8EPod14VnII5CsCtOVboZQ8Cy+tO/uKO34vZq/x
	cLaA++erUqt/O08dtecVqM/bdLy7jdm/133L1rKmA97wFPEXOqDk1mJ8+BuiPrMdpsOSYjrm27r
	4RAVxTEGPKrMRzbXrb/0BTONvdg==
X-Google-Smtp-Source: AGHT+IELVRUurFW8tfDDC0iUwFPiFsqYStc2zOYCPV3iXlkA6nU0se344US+p9bexkbh23hUu3k2oyF3UnV/97X3x9c=
X-Received: from pgeu9.prod.google.com ([2002:a63:a909:0:b0:7ff:d6:4f28])
 (user=pkaligineedi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1013:b0:1e1:e2d9:307 with SMTP id adf61e73a8af0-1e5b487e6e8mr4675360637.33.1734528868845;
 Wed, 18 Dec 2024 05:34:28 -0800 (PST)
Date: Wed, 18 Dec 2024 05:34:12 -0800
In-Reply-To: <20241218133415.3759501-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241218133415.3759501-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218133415.3759501-3-pkaligineedi@google.com>
Subject: [PATCH net 2/5] gve: guard XDP xmit NDO on existence of xdp queues
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

In GVE, dedicated XDP queues only exist when an XDP program is installed
and the interface is up. As such, the NDO XDP XMIT callback should
return early if either of these conditions are false.

In the case of no loaded XDP program, priv->num_xdp_queues=0 which can
cause a divide-by-zero error, and in the case of interface down,
num_xdp_queues remains untouched to persist XDP queue count for the next
interface up, but the TX pointer itself would be NULL.

The XDP xmit callback also needs to synchronize with a device
transitioning from open to close. This synchronization will happen via
the GVE_PRIV_FLAGS_NAPI_ENABLED bit along with a synchronize_net() call,
which waits for any RCU critical sections at call-time to complete.

Fixes: 39a7f4aa3e4a ("gve: Add XDP REDIRECT support for GQI-QPL format")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 3 +++
 drivers/net/ethernet/google/gve/gve_tx.c   | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e171ca248f9a..5d7b0cc59959 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1899,6 +1899,9 @@ static void gve_turndown(struct gve_priv *priv)
 
 	gve_clear_napi_enabled(priv);
 	gve_clear_report_stats(priv);
+
+	/* Make sure that all traffic is finished processing. */
+	synchronize_net();
 }
 
 static void gve_turnup(struct gve_priv *priv)
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 83ad278ec91f..852f8c7e39d2 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -837,9 +837,12 @@ int gve_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	struct gve_tx_ring *tx;
 	int i, err = 0, qid;
 
-	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK) || !priv->xdp_prog)
 		return -EINVAL;
 
+	if (!gve_get_napi_enabled(priv))
+		return -ENETDOWN;
+
 	qid = gve_xdp_tx_queue_id(priv,
 				  smp_processor_id() % priv->num_xdp_queues);
 
-- 
2.47.1.613.gc27f4b7a9f-goog


