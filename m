Return-Path: <bpf+bounces-54514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE8A6B24C
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A55C19C5B56
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0671C174A;
	Fri, 21 Mar 2025 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNk4cfGh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31901CA9C
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516977; cv=none; b=T1/SWW8MAnbvSgOBDLBJM4U9Qa+mla45bY3Hzpj2TEZ761SjqmHevpy5IOvvUCbXHNltyorbDC+W238rq7SI21qZ1gSQOFCrfz7ZhCDDM10pNQ8I7MV7LFbo0Kmq/YnyknrzQ6ArgmiLmqw+J+ET12lHbyAWaF8K/bJ7hgiZgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516977; c=relaxed/simple;
	bh=KN2cOTG2wekaPP9DYryqEoiqxe6ajNRoChUByzrJO40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UJnbcG51gXYWxHSLAAn5K/e3Q/qtbNqYqaljQEvr2kBMpGVvmCdogOFHNs9IEItLB9GnN/maSFkpylmuompv0R6VHmTWzg3ea4mwLGfcnFXR4Brl0+HLBo1bQ7TP62M8sBqJOrcj/nImoCkXsf7ZiUd0tyMmfJnmImZH05Ht40E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNk4cfGh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso2335687a91.0
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742516975; x=1743121775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GwU0iMBTSa3xceKKuHeiAKpYBS7s6JNs8UBvNjnbHA=;
        b=RNk4cfGhu8DvK3yNj6uHVIRFJTP83fbWHOvTnk4YzdrxjyCw9GaHjLW3Le3SNOJv5f
         KJHaU4lOdnMw9M5WGfOxC01ClTLoOYFGWgxyNRXNd2oEFv6qFwUkHgyuaooePnWtBER5
         T+127BStnkgRMCIlJ2G20hLpTYafpzQ2YyOvAVYMENMUaQJaSm10ca5Xpq+luFmeq77A
         qopnUYj8Jn7X1W8PryThZk6vRIFVAOww082J3/Y1HxT/NuJha+ku8l6rfs+Mwz1mEUrx
         aMjGAIfCECeM30An/g3F8ER99l48ajb4VzWobELWBHlzm+mS1MYmsYDWye4kowasX4dF
         7pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516975; x=1743121775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GwU0iMBTSa3xceKKuHeiAKpYBS7s6JNs8UBvNjnbHA=;
        b=A2M4ungWLJHA2KE8uXvUxSeJTgkzy8xPecY5NPphR59cvstXf8dQU2Bi2UhHyHiOkl
         gdL247Yx0fUo7lufAaXsBvT/NV6q7q5ASgxQ2OLiHsgH6FhE9oaxO1ApktCUVgMQwMlQ
         O5MfHIw2nuEJXxFqGwT2R99XOXXZ1dDC9rRK+rmyYkqBZHwmj10GOPL/GpebCj1sIqfZ
         H1FyG4722aQ0TZ8Tuoj99FgrCBmI9VmwZAU8DcnCWcGCaJt0D5qJB/FRoMiOhm/6XgY4
         VWaqNuDzpcwGA8uecesiUkEQ5XgKGOFzyOZeSmWEQLGbZoQ8SV50mMplXvWDAtuZoomG
         alQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZPKXBfLRTFPfbZ5Hmits6AteSpXXARRU9shvLZj3TPNBLObJBlUXc0syEo+GPkal1JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgq9JHaCepbpQzpeDaPuWoat8r+2N1dVo4FOxL4roVTfBhpEB
	CBKUnbm3nXvDrIMf22Kuf4kEHah++yFBTyIjgb3SvudiObRAUD2REyoZkaPGiPv6fvTA90ykwsr
	rHA+G6uyvc62CTOMtIfysug==
X-Google-Smtp-Source: AGHT+IGD5szJoWREOu6a0QdchzHBvcQnxinXmcoUurIv/Tes/c8ceLECekn1mij0Ce5a1zIY1qnxC2UQ6yiY5tmtXA==
X-Received: from pjbqd16.prod.google.com ([2002:a17:90b:3cd0:b0:2ef:8055:93d9])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f86:b0:2f6:dcc9:38e0 with SMTP id 98e67ed59e1d1-3030fc3a833mr2492622a91.0.1742516975299;
 Thu, 20 Mar 2025 17:29:35 -0700 (PDT)
Date: Fri, 21 Mar 2025 00:29:10 +0000
In-Reply-To: <20250321002910.1343422-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321002910.1343422-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321002910.1343422-7-hramamurthy@google.com>
Subject: [PATCH net-next 6/6] gve: add XDP DROP and PASS support for DQ
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, pkaligineedi@google.com, willemb@google.com, 
	ziweixiao@google.com, joshwash@google.com, horms@kernel.org, 
	shailend@google.com, bcf@google.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

This patch adds support for running XDP programs on DQ, along with
rudimentary processing for XDP_DROP and XDP_PASS. These actions require
very limited driver functionality when it comes to processing an XDP
buffer, so currently if the XDP action is not XDP_PASS, the packet is
dropped and stats are updated.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Praveen Kaliginedi <pkaligineedi@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy<hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 52 ++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 2edf3c632cbd..deb869eb38e0 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -546,6 +546,29 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 	return 0;
 }
 
+static void gve_xdp_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
+			     struct xdp_buff *xdp, struct bpf_prog *xprog,
+			     int xdp_act,
+			     struct gve_rx_buf_state_dqo *buf_state)
+{
+	u64_stats_update_begin(&rx->statss);
+	switch (xdp_act) {
+	case XDP_ABORTED:
+	case XDP_DROP:
+	default:
+		rx->xdp_actions[xdp_act]++;
+		break;
+	case XDP_TX:
+		rx->xdp_tx_errors++;
+		break;
+	case XDP_REDIRECT:
+		rx->xdp_redirect_errors++;
+		break;
+	}
+	u64_stats_update_end(&rx->statss);
+	gve_free_buffer(rx, buf_state);
+}
+
 /* Returns 0 if descriptor is completed successfully.
  * Returns -EINVAL if descriptor is invalid.
  * Returns -ENOMEM if data cannot be copied to skb.
@@ -560,6 +583,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	const bool hsplit = compl_desc->split_header;
 	struct gve_rx_buf_state_dqo *buf_state;
 	struct gve_priv *priv = rx->gve;
+	struct bpf_prog *xprog;
 	u16 buf_len;
 	u16 hdr_len;
 
@@ -633,6 +657,34 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		return 0;
 	}
 
+	xprog = READ_ONCE(priv->xdp_prog);
+	if (xprog) {
+		struct xdp_buff xdp;
+		void *old_data;
+		int xdp_act;
+
+		xdp_init_buff(&xdp, buf_state->page_info.buf_size,
+			      &rx->xdp_rxq);
+		xdp_prepare_buff(&xdp,
+				 buf_state->page_info.page_address +
+				 buf_state->page_info.page_offset,
+				 buf_state->page_info.pad,
+				 buf_len, false);
+		old_data = xdp.data;
+		xdp_act = bpf_prog_run_xdp(xprog, &xdp);
+		buf_state->page_info.pad += xdp.data - old_data;
+		buf_len = xdp.data_end - xdp.data;
+		if (xdp_act != XDP_PASS) {
+			gve_xdp_done_dqo(priv, rx, &xdp, xprog, xdp_act,
+					 buf_state);
+			return 0;
+		}
+
+		u64_stats_update_begin(&rx->statss);
+		rx->xdp_actions[XDP_PASS]++;
+		u64_stats_update_end(&rx->statss);
+	}
+
 	if (eop && buf_len <= priv->rx_copybreak) {
 		rx->ctx.skb_head = gve_rx_copy(priv->dev, napi,
 					       &buf_state->page_info, buf_len);
-- 
2.49.0.rc1.451.g8f38331e32-goog


