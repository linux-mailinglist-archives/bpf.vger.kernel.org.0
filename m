Return-Path: <bpf+bounces-74570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A68C5F546
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14B164E1C67
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C4434D4C4;
	Fri, 14 Nov 2025 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XpOAjiZU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DEE30146D
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154751; cv=none; b=JbWaDlKH1XDheLMjSogm/tu9ID+Ou9y+ejjeJN60aOHuJizSkxArwBMG9564t47Z3HOC12ngWbLDLgIzCcvOeEOByUZBQXW8qWe7kgw14YKk+j152GgG/iy67v/lViLmPw3IEd6+L/DOooET3vlNIQO1H4ecHz9SDkrGMqLngYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154751; c=relaxed/simple;
	bh=7GRJ/PW+ZjlS5rbC6oxTHSZTvFvMwaOAeCHQcMlMJBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hXHAMGBZd0pmXbFVAfocGEpLcz/zcPM3sWWen+PA8Nfmxf/XJb6n5QeeFx6xDABGjguvYR9UfE57sT4fdO0aRBAGikoKAvbN3tvMwQy3AzbEEjMrD341BlH0TUA/WFUpQnOrWwJTkPZrxHP76ll91n4wazOPsPNzAiLEhuIIT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XpOAjiZU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2980ef53fc5so6738785ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 13:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763154749; x=1763759549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOJK9SLutt+EQ44/gH840hpx3Hfd04ffDRZ9ZBYAKSk=;
        b=XpOAjiZUWDC1ddcQzvuMJVUh+hQURnMXSQIlBL+XTJlRIaP/wL+2LxQ7uA8OSNCpPb
         r+owBvGITtTP1+ROtMdrGyvsMaK6e79vgjJuOGvB62FobpJ8UMLTv09ofgsqficPObgX
         3ZA9wAvZ63NDwVKcvrdgFQw7TF0uXIZ7Fim6FXrqL4ptDsP4JGXWc+3Xd3xjKDQDdNMy
         7CKmYAQEF0yBggaFvgwSXryg2eBQZ9trMIww17biBkGU934ltfl4i+IEgW/iRPOvCFD/
         O30LgeRpDh6Tu7csgTYSRsDa8+VBuKt0yRhtdFmEP1I5mgRz00khuXWkCZjZVLsupnEq
         sAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763154749; x=1763759549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOJK9SLutt+EQ44/gH840hpx3Hfd04ffDRZ9ZBYAKSk=;
        b=JLHMLn0hJrzgQlXnM9IcSNHgigqO8A4frB59tqueR4nkz0R2eFRvKt2Sh9r4YzkMOv
         0G+cHNT5aAw/7ikqma0OEHBJK2sLluUpVTYw7w6DrFusc3gZQpX//qC5nDDf6i96h+JE
         lEDW18p1HYLzCg6uvYVaKx0ba7X8t+wFF2cHVP1kFjcpn5fVdOuQ41v5eLLvN8CemEdD
         tHclr45VUzdDlsfRIp+Zaj9Q4l8WSSK9BQEnYMsTSQbM9FbkC1h/5tRye9Ca4d7ezYfo
         CTqgiAsDzRz6F3QwXpfZPTpCadkWo9QFU81v0oprdrsrQfwNpw9EWUPdzagL95FK8eWA
         VKcg==
X-Forwarded-Encrypted: i=1; AJvYcCWZEk5SO/UhhWDZrW3vVYmAdp00nWZWuH2ETDz01gy/L1Y3GjtLlQujG9rZic4/8GAyMyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqMz2VqvEGMe/zVa+/JPBHXw05IneeDk64/7CTUq76rOsx78I
	VuXAnF9a1SnLN61ns8IUGe/oPn9Qkb6IRBUf8Re1jO92cu97d+vfs4/erjwqH8qJqHR6drKasoO
	h1av6pSJgEe5HDQ==
X-Google-Smtp-Source: AGHT+IFf3b5Wf2YCfgkcxyT3Kw1rGGftpj95wXeEiTy69JDVmj4KrlWGzwkN/sJtEE5hwtMzu+MXWWjiREPT0A==
X-Received: from plhz15.prod.google.com ([2002:a17:902:d9cf:b0:298:3e35:3e78])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef06:b0:298:595d:3d3a with SMTP id d9443c01a7336-2986a7566edmr43023395ad.50.1763154748557;
 Fri, 14 Nov 2025 13:12:28 -0800 (PST)
Date: Fri, 14 Nov 2025 13:11:46 -0800
In-Reply-To: <20251114211146.292068-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114211146.292068-1-joshwash@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114211146.292068-5-joshwash@google.com>
Subject: [PATCH net-next 4/4] gve: Add Rx HWTS metadata to AF_XDP ZC mode
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, Kevin Yang <yyd@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

By overlaying the struct gve_xdp_buff on top of the struct xdp_buff_xsk
that AF_XDP utilizes, the driver records the 32 bit timestamp via the
completion descriptor and the cached 64 bit NIC timestamp via gve_priv.

The driver's implementation of xmo_rx_timestamp extends the timestamp to
the full and up to date 64 bit timestamp and returns it to the user.

gve_rx_xsk_dqo is modified to accept a pointer to the completion
descriptor and no longer takes a buf_len explicitly as it can be pulled
out of the descriptor.

With this patch gve now supports bpf_xdp_metadata_rx_timestamp.

Signed-off-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c   |  7 +++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 16 ++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 2b41a42fb516..a5a2b18d309b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2348,6 +2348,10 @@ static void gve_set_netdev_xdp_features(struct gve_priv *priv)
 	xdp_set_features_flag_locked(priv->dev, xdp_features);
 }
 
+static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
+	.xmo_rx_timestamp	= gve_xdp_rx_timestamp,
+};
+
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
 	int num_ntfy;
@@ -2443,6 +2447,9 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	}
 
 	gve_set_netdev_xdp_features(priv);
+	if (!gve_is_gqi(priv))
+		priv->dev->xdp_metadata_ops = &gve_xdp_metadata_ops;
+
 	err = gve_setup_device_resources(priv);
 	if (err)
 		goto err_free_xsk_bitmap;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index f20d1b1d06e6..f1bd8f5d5732 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -240,6 +240,11 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 		rx->rx_headroom = 0;
 	}
 
+	/* struct gve_xdp_buff is overlaid on struct xdp_buff_xsk and utilizes
+	 * the 24 byte field cb to store gve specific data.
+	 */
+	XSK_CHECK_PRIV_TYPE(struct gve_xdp_buff);
+
 	rx->dqo.num_buf_states = cfg->raw_addressing ? buffer_queue_slots :
 		gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
 	rx->dqo.buf_states = kvcalloc_node(rx->dqo.num_buf_states,
@@ -701,16 +706,23 @@ static void gve_xdp_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 }
 
 static int gve_rx_xsk_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
-			  struct gve_rx_buf_state_dqo *buf_state, int buf_len,
+			  const struct gve_rx_compl_desc_dqo *compl_desc,
+			  struct gve_rx_buf_state_dqo *buf_state,
 			  struct bpf_prog *xprog)
 {
 	struct xdp_buff *xdp = buf_state->xsk_buff;
+	int buf_len = compl_desc->packet_len;
 	struct gve_priv *priv = rx->gve;
+	struct gve_xdp_buff *gve_xdp;
 	int xdp_act;
 
 	xdp->data_end = xdp->data + buf_len;
 	xsk_buff_dma_sync_for_cpu(xdp);
 
+	gve_xdp = (void *)xdp;
+	gve_xdp->gve = priv;
+	gve_xdp->compl_desc = compl_desc;
+
 	if (xprog) {
 		xdp_act = bpf_prog_run_xdp(xprog, xdp);
 		buf_len = xdp->data_end - xdp->data;
@@ -800,7 +812,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 
 	xprog = READ_ONCE(priv->xdp_prog);
 	if (buf_state->xsk_buff)
-		return gve_rx_xsk_dqo(napi, rx, buf_state, buf_len, xprog);
+		return gve_rx_xsk_dqo(napi, rx, compl_desc, buf_state, xprog);
 
 	/* Page might have not been used for awhile and was likely last written
 	 * by a different thread.
-- 
2.51.2.1041.gc1ab5b90ca-goog


