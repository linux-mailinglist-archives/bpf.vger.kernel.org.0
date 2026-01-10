Return-Path: <bpf+bounces-78483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4ED0DDBE
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 22:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 763B7305223D
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 21:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0047D2BE05A;
	Sat, 10 Jan 2026 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DqcxWv3r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6FF29A322
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079131; cv=none; b=I61KFXRVBZtATgG8JwlxNCEcG/rYtCSLJCEBC5e8deGkn8JpxjxmOjakrYEtGu1YELxynFH7Az/JH2+bGzzQQT30Ed1tBgWDIoQRSHu2HGE6Ic+Yf5IWnKtdjqNDI3sEqnl1/iUwApitTM1rD0EhAU0qv5eY9EE499ClzrFPxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079131; c=relaxed/simple;
	bh=79nK24opN6uM1iQ+K6OE/uKIwjvXCL9v0B8DauUBPRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8V3A3/ytjOdh+uSRtuSUN/j7mYQAZUrvHKfv7tpatTrlKa8I8/EkBdwoFBo5hYiM8F3d+Tjr3Rftz0aDs1TiSm2E2Du2G1z/vGmPTj+Y/rokqoGL6nJMzGvgGkVAIsb8TMms1IedPyAAjtKfbxsuJ/vbilUtP8ThOFIAgoiqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DqcxWv3r; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso4684040a12.1
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 13:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079127; x=1768683927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOm2Dco79W8CJqhRdT3ov73dnM6p4xH+R1QoW90QGkc=;
        b=DqcxWv3rBrfzUju2khjIjf6PA6ujXHBoZi5nkX6TsMhA9jehbmiMbwVY5R9OjGhy7b
         Q7Fa6pnQz/2HLNEPZSmDIXczYH2Z3k8H/AXAiHIzpgZyIkck4IMds3HzNsDFN/A7uWqc
         P3mg5T6Fg0NZi5zm4d0K161UcZgR6rFjMC8sCr3br35ZsEup2huL3kGU9QcFUyLUITF+
         q00wkIq7QqLdeUmS+5sLuniUWvb4FvUtExp/IaDzm+cXqEkWf4kFsgNsU3fdFArGfEeh
         NsOZscgVGIyeKxtfgoZMwUlwjaWcEILuBn7bel6vQ8JnA1N1LEMk7RYv2pbmuQqBNA4V
         SQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079127; x=1768683927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qOm2Dco79W8CJqhRdT3ov73dnM6p4xH+R1QoW90QGkc=;
        b=tCKTW9PH1grwzdy/1jqO7qF1gDdnFUfI2IkO1MS3dPXhrJTrdW5+BKqejvLcZmzGaJ
         2+rxQjGrSas1t7ML1siPlSGDSQbgu/Sys6O9NRxfN1M7ktIqxnNa7F5p1wEtuP2H4SaE
         qsQliVIya4pFb6R8TpDVJTL+YTJUsjCXmV5HwWv3IDy8QwM4KEF7m8VvpgO9kdP/X/mr
         voNoRHxWA3AX9OuAfpPEhEWVhb+AiR/HJIropgRH4F3wdwcqzOjoncybNFhoW/7upV81
         6hmYajuE5njMzc/w/qxMGq95EcEkdhQDfFOtP6ojoSuSKo5fRoHl7lxSGbjs0R4H8F8T
         XXIA==
X-Forwarded-Encrypted: i=1; AJvYcCWvGbfT2kGMkqbcXilwRxXYLVtHNo5XxfIapkNg17nAoSjN8ibNYFh8UP9q+tr13qsDPHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YysoNm3+zE3uCy41oEw/fH2WeAUrPhgszUx/T/cb62kP57aqIiV
	G8pY90SIwvIxSdyu9zDqR9NDO8nxk/cuY8HeMTQt+N1NQ98mbZ6Sr1dRXR2ai5Y73YqY7Oh7TeL
	XDMsj
X-Gm-Gg: AY/fxX69P63+r28DMl9sMfBnXpaosQrc3Mar7I5nZ3hko2Xi9OiBLO0eG7TGjkNoAqK
	TgCQ4RIbyV1mUl5E4gusTyruw+6b5CPMZSzgEN+lOlhceIhehrwQo+AppsWmna8B8dbbRMjKj9I
	ZnceW7TzcNHAGrFoGn3Lm/8iEB8skpdqeTldeXcSDNhokq9Wy7VzR0HJNyA2/qWOKA9LzElsXAT
	cNK42m2WQOO3a1JkTcrYzuPvAXciqHiE5JLzYTTcO+dzbPFT/A+AhIv4FfvSxTZURNaQGNvKqQi
	03fslk2wFOVov33FBZojN/Ae3mBI3PQ5vDuF3hyXnnElHpwLbi6uZV7KOPqGUePH8qWKrcAEFEw
	q2MhKKAX3Bz9FEbqRievHeyGBLdmmBYelyvv7LTEwexaCbjSiuOTCqs7EJjAYmge2mD8OSA2FWF
	mMIQJ2dJMEsRNxIvQGBGPEFiCKH5+bSf7mquSiJAysrubHBpgwt2VyrI77b5U=
X-Google-Smtp-Source: AGHT+IEEoQmWnDDRGqBo6ow/YqTGmki9h0Hp/wugoaNy4VsuTpMCu3HOef9yqHlTJ1K/zJx1Hlhozw==
X-Received: by 2002:aa7:c845:0:b0:64a:86db:526a with SMTP id 4fb4d7f45d1cf-6507bc3d721mr13850443a12.4.1768079126946;
        Sat, 10 Jan 2026 13:05:26 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4c15sm13415763a12.4.2026.01.10.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:26 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:17 +0100
Subject: [PATCH net-next 03/10] i40e: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-3-1047878ed1b0@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to copy the XDP metadata into an skb extension in skb_metadata_set.

Adjust the driver to pull from skb->data before calling skb_metadata_set.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..11eff5bd840b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -310,8 +310,8 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	if (likely(!xdp_buff_has_frags(xdp)))

-- 
2.43.0


