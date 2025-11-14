Return-Path: <bpf+bounces-74568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD48C5F537
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2D6735D49D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4A34B1AF;
	Fri, 14 Nov 2025 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TS/F4Vcp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA1321448
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154747; cv=none; b=ZYpbOSWi7og/FyYydwtVy7HPW/X5Fy4wfmkmoHQOGE53Xl5RidRBkkOtSTiz4NcaXQQ/fcBmV/caJ+l+s2BhdfKIA6IxL5bnj8+RRjiMzeoy0phrWmuQFFm2TkMT4LXD56n71gP/27ZzYMzvBmKkipCprZIN7IMWPNRDVxWSLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154747; c=relaxed/simple;
	bh=T6+d668CY7Ck7eZvXYmqIoDhdMFjjZNlShKvRnyo6yo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XXNR0/+wknDrRpF5El0dNHZKHe0GaxBWzaZYdlf3AGu0toyFghyl4nRiXbyqwfe0v9uQ+QF+Ht2py4Xmktdc9GoY4T/HWZ/t9KhHnQ1sjDzP5t0bJumsygKxCh4KBsMMC+8O9Bjnfu6R/b33RpGiVxuJdeCT/evpG2Ayzp74DoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TS/F4Vcp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a440d38452so4334755b3a.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 13:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763154745; x=1763759545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmEQOsW5fdEOM8rVgZL0f19iMNBD1EWCqYTBFjDAENI=;
        b=TS/F4VcpBpz/a1IwruQkobF8bHMNHN3xMyG1bp23AaBj8yEhnvw4uKyCRMr6cB1oNM
         jz7Fuxi1QGH9ASHszpZONDRd62MpmrqUYhaeWf3aWaf4sIhIukcVUecwNKv3zZ+TxvYv
         2lUXddRzw4WqKfzW/NQa99AvP8xnsoJVYVEPfgmurtMPDmRkZT40rtgU7Tp4SQa23Nq4
         ltfVTLuqDbDHmkqqUxTY61kiSeL6icu9usCnx4d7SeIE7TsHfvqhRYOCNgTk+oLHsd/S
         kd2WahI8yygF8eqEFxBFXVreqtRhsscmA1AkPtZfe/1KP6m0G8I/5Ruf2c4TMXrBTn6z
         7nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763154745; x=1763759545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmEQOsW5fdEOM8rVgZL0f19iMNBD1EWCqYTBFjDAENI=;
        b=tY4F8ChtRcKHsHgRPWJLxdkPQecSGY+IxSoMiZdwzz+1864QxkUlHNCeMs5esLKHWA
         uyOx0qQpnFq/rGPx5FLdHNvuzlP/ZQp/mOPXyToeFFIvDKfiOLR2llL0jknOU9CXU9Oj
         VfaRj9Q5S9j8yhTGZVxvPv2uUcwHZsnAty2Ypt+WiiaUajvBRI+x4DdCkyiIcRbKCLjC
         iA9OpyikHMQ+wgKoFatKtXVh9mbR9Sfkw6Z6YBzkMJn9rNy+U3MGG902duGEGhCMd4Eu
         AGyqMz/smAD4/bRqqMaM/yplBBcyW7XuhUbZwY7rYZWTkCXrhLMS78CI5iu5MtzupOZP
         vPLA==
X-Forwarded-Encrypted: i=1; AJvYcCV1eimJNNNDw9CyhCc/iYywZ0brnl0nrAvzrkfcENJCs2uZiZwTUUPBpalaY7Jmqh6SkLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZtDuS5SUHlsfdfrEg1+VCEUt5b2Pv6zGkG35+U86ei68+Avn
	CFzZOsvg4HXmlUMnlXmRlL30ot8QozWLjWzofkET9Gdr05wF/3ngG9NGAWwDVKaAnszsh6TOIKW
	DW5w6/HyiyJJmTA==
X-Google-Smtp-Source: AGHT+IFZzfB2L/hPLfcxvKwlFateyylLJARdQKfDv09tdbnT7hsReWajdQtkS8JbmkPJUWMTInKqnF2TjKYjTQ==
X-Received: from pgag19.prod.google.com ([2002:a05:6a02:2f13:b0:bc7:bb77:3836])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7484:b0:34f:28f7:ed79 with SMTP id adf61e73a8af0-35b9fd7be60mr5841238637.19.1763154744982;
 Fri, 14 Nov 2025 13:12:24 -0800 (PST)
Date: Fri, 14 Nov 2025 13:11:44 -0800
In-Reply-To: <20251114211146.292068-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114211146.292068-1-joshwash@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114211146.292068-3-joshwash@google.com>
Subject: [PATCH net-next 2/4] gve: Wrap struct xdp_buff
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

RX timestamping will need to keep track of extra temporary information
per-packet. In preparation for this, introduce gve_xdp_buff to wrap the
xdp_buff. This is similar in function to stmmac_xdp_buff and
ice_xdp_buff.

Signed-off-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  5 +++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 16 ++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index a33b44c1eb86..a21e599cf710 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -205,6 +205,11 @@ struct gve_rx_buf_state_dqo {
 	s16 next;
 };
 
+/* Wrapper for XDP Rx metadata */
+struct gve_xdp_buff {
+	struct xdp_buff xdp;
+};
+
 /* `head` and `tail` are indices into an array, or -1 if empty. */
 struct gve_index_list {
 	s16 head;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 1aff3bbb8cfc..76b26896f572 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -840,23 +840,23 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	if (xprog) {
-		struct xdp_buff xdp;
+		struct gve_xdp_buff gve_xdp;
 		void *old_data;
 		int xdp_act;
 
-		xdp_init_buff(&xdp, buf_state->page_info.buf_size,
+		xdp_init_buff(&gve_xdp.xdp, buf_state->page_info.buf_size,
 			      &rx->xdp_rxq);
-		xdp_prepare_buff(&xdp,
+		xdp_prepare_buff(&gve_xdp.xdp,
 				 buf_state->page_info.page_address +
 				 buf_state->page_info.page_offset,
 				 buf_state->page_info.pad,
 				 buf_len, false);
-		old_data = xdp.data;
-		xdp_act = bpf_prog_run_xdp(xprog, &xdp);
-		buf_state->page_info.pad += xdp.data - old_data;
-		buf_len = xdp.data_end - xdp.data;
+		old_data = gve_xdp.xdp.data;
+		xdp_act = bpf_prog_run_xdp(xprog, &gve_xdp.xdp);
+		buf_state->page_info.pad += gve_xdp.xdp.data - old_data;
+		buf_len = gve_xdp.xdp.data_end - gve_xdp.xdp.data;
 		if (xdp_act != XDP_PASS) {
-			gve_xdp_done_dqo(priv, rx, &xdp, xprog, xdp_act,
+			gve_xdp_done_dqo(priv, rx, &gve_xdp.xdp, xprog, xdp_act,
 					 buf_state);
 			return 0;
 		}
-- 
2.51.2.1041.gc1ab5b90ca-goog


