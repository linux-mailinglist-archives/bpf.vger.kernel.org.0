Return-Path: <bpf+bounces-74569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A349C5F549
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAD2B35D8CF
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DC630101E;
	Fri, 14 Nov 2025 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nn8j/TDv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703EE34AAFB
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154749; cv=none; b=EEFjRMFjG6hjudgcD8LTU8OaQon1tPuoEBcv/Qc9VPyxYlWD6j3eJ6Std0g6Irgb0HS/wgmW2cTmRhE/I4iRpgYe9zxbac9K1e+4T9+Zo0iSJe6YA/ZqD/xsSFNV367Xmet6Ln+n3hu4q3AL870piexPMp5pWy/PW/pPEPRrNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154749; c=relaxed/simple;
	bh=zVyF4eCmetz8qkPkTMcTx44ahznevhy/p0XTEImdKRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LLkvloEKCgvs5EGVOEWUq5i7yQ4cyikT2u2DUVsUgHZw29nDi0hfqQbl7mG3gDwIv2pjvNUOsHl1kaM/o/rrlprkAmLOaR3tNQnBhCkhN4yWT4NdkFLyR8mTdr61ZdO0eaGJIjlWllcsN4EqO350cNm5JYWMxQQOLg79NUQbSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nn8j/TDv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340bb1bf12aso5850195a91.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 13:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763154747; x=1763759547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y/piwZstoQ4BnBjUX1Vciq6F5LLISS027ouNsEaB94=;
        b=nn8j/TDvGb/931H6AnnnuA/eLPLzpytrDyBKJuQH1sUT48X5oXeQHLqS9lb1TRh7N3
         Aw5KplDLpTtBxy3sFGymgxgniuJ5tHILA5XuZEvoMG9i8x+XG9a6gCfbrJinBt87wE89
         d2rmFDlMIg5t9nmAqF+LY+CdOUSZhSsblt+sqon9GMnKK/NCal1HAAuQdingMFBP5uFm
         PK67i+QreuP1kU671zugAX3LeqVuIeVPueXh7qCWy7JuhdS6xyytoGYO3YceMCFHWRoi
         X5gcVhMbCd4rMUviKen+mRkUjrdk0NSGHBFYSiwUKkWVR0UPdwCgBukLc3mdxPMpl33E
         Yv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763154747; x=1763759547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y/piwZstoQ4BnBjUX1Vciq6F5LLISS027ouNsEaB94=;
        b=hKaU6Kj3JxGE8xLpKlqX+wW259zUCrDH4lIz0dreJPNSZhoJMs6RxDj56fg9SNjX6g
         j3pbFBidCoPvFe7ocsYQ5CaH0IwteMO2893rSxA0JCDropOrQ0NWq25GuxGPxyfXByFz
         xbwxr3ldhts7tz0dFSPmUDgPSawDgqHtorDcumFPxLB/5KkuXgycGHxC63jaxMwJUd8j
         qP63Ls5nrYF3J44FwY1msHLNLu2yTt9kneuErokU6WprK+OocVLblUrBVKG2sTfeNERW
         z1zSEbsIzKzWrzAir76ss5qe6TbdSNA4c8/HU2s2cHgrGgoWc6TTxSFxzuK9c22we0uX
         7whA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Q2SPo37sBmOqNPpL6bK89DysS/7bk7tJdCnOoW/8WA7QS99Jkssr9GYy+ZihGUkdaww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxpsEM9Fi2t4cMqmY+5z0L4EIS1Nl2HofzE7GMSP7cT+y3CmY
	gINM71862HyQ+d2PHhlOwiHfXHvlbIIExj1EhBN9+OhSbM3S0PTJ53fyr8IEwBO7jZiHrEQN/W5
	kmQVxEjkFuYEM/A==
X-Google-Smtp-Source: AGHT+IGZU0N5DqgSQDGu2t1JpZWqiC9MfzdAhqENlzoLqYOPfSiO6nWEDpRKF/5fje3psrOGSncU1GiPoXN8ag==
X-Received: from pjblp4.prod.google.com ([2002:a17:90b:4a84:b0:340:bb32:f5cf])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17cc:b0:340:cb39:74cd with SMTP id 98e67ed59e1d1-343fa74d17amr4615610a91.32.1763154746769;
 Fri, 14 Nov 2025 13:12:26 -0800 (PST)
Date: Fri, 14 Nov 2025 13:11:45 -0800
In-Reply-To: <20251114211146.292068-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114211146.292068-1-joshwash@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114211146.292068-4-joshwash@google.com>
Subject: [PATCH net-next 3/4] gve: Prepare bpf_xdp_metadata_rx_timestamp support
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

Support populating XDP RX metadata with hardware RX timestamps. This
patch utilizes the same underlying logic to calculate hardware
timestamps as the regular RX path.

xdp_metadata_ops is registered with the net_device in a future patch.

gve_rx_calculate_hwtstamp was pulled out so as to not duplicate logic
between gve_xdp_rx_timestamp and gve_rx_hwtstamp.

Signed-off-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  2 +
 drivers/net/ethernet/google/gve/gve_dqo.h    |  1 +
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 41 +++++++++++++++-----
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index a21e599cf710..970d5ca8cdde 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -208,6 +208,8 @@ struct gve_rx_buf_state_dqo {
 /* Wrapper for XDP Rx metadata */
 struct gve_xdp_buff {
 	struct xdp_buff xdp;
+	struct gve_priv *gve;
+	const struct gve_rx_compl_desc_dqo *compl_desc;
 };
 
 /* `head` and `tail` are indices into an array, or -1 if empty. */
diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
index 6eb442096e02..5871f773f0c7 100644
--- a/drivers/net/ethernet/google/gve/gve_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_dqo.h
@@ -36,6 +36,7 @@ netdev_tx_t gve_tx_dqo(struct sk_buff *skb, struct net_device *dev);
 netdev_features_t gve_features_check_dqo(struct sk_buff *skb,
 					 struct net_device *dev,
 					 netdev_features_t features);
+int gve_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp);
 bool gve_tx_poll_dqo(struct gve_notify_block *block, bool do_clean);
 bool gve_xdp_poll_dqo(struct gve_notify_block *block);
 bool gve_xsk_tx_poll_dqo(struct gve_notify_block *block, int budget);
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 76b26896f572..f20d1b1d06e6 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -456,20 +456,38 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
  * Note that this means if the time delta between packet reception and the last
  * clock read is greater than ~2 seconds, this will provide invalid results.
  */
+static ktime_t gve_rx_get_hwtstamp(struct gve_priv *gve, u32 hwts)
+{
+	u64 last_read = READ_ONCE(gve->last_sync_nic_counter);
+	u32 low = (u32)last_read;
+	s32 diff = hwts - low;
+
+	return ns_to_ktime(last_read + diff);
+}
+
 static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx,
 				const struct gve_rx_compl_desc_dqo *desc)
 {
-	u64 last_read = READ_ONCE(rx->gve->last_sync_nic_counter);
 	struct sk_buff *skb = rx->ctx.skb_head;
-	u32 ts, low;
-	s32 diff;
-
-	if (desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID) {
-		ts = le32_to_cpu(desc->ts);
-		low = (u32)last_read;
-		diff = ts - low;
-		skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(last_read + diff);
-	}
+
+	if (desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID)
+		skb_hwtstamps(skb)->hwtstamp =
+			gve_rx_get_hwtstamp(rx->gve, le32_to_cpu(desc->ts));
+}
+
+int gve_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
+{
+	const struct gve_xdp_buff *ctx = (void *)_ctx;
+
+	if (!ctx->gve->nic_ts_report)
+		return -ENODATA;
+
+	if (!(ctx->compl_desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID))
+		return -ENODATA;
+
+	*timestamp = gve_rx_get_hwtstamp(ctx->gve,
+					 le32_to_cpu(ctx->compl_desc->ts));
+	return 0;
 }
 
 static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring *rx)
@@ -851,6 +869,9 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 				 buf_state->page_info.page_offset,
 				 buf_state->page_info.pad,
 				 buf_len, false);
+		gve_xdp.gve = priv;
+		gve_xdp.compl_desc = compl_desc;
+
 		old_data = gve_xdp.xdp.data;
 		xdp_act = bpf_prog_run_xdp(xprog, &gve_xdp.xdp);
 		buf_state->page_info.pad += gve_xdp.xdp.data - old_data;
-- 
2.51.2.1041.gc1ab5b90ca-goog


