Return-Path: <bpf+bounces-78486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A61D0DDD6
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 22:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E0FC303640F
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 21:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D8325771;
	Sat, 10 Jan 2026 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="K/XIFzhk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE272C08BC
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079135; cv=none; b=KwscLDNdfK0dJWgJNuPE2cYMgNCxkKC6SMjCUgFgF0RuGqQojZaa3zcReDuHYUDq891CrQu7gdJarf9kucnlY6GH5B/hMcqDUQAAXrQwkTyQRXWp4eHG4r228ZcOV1CbTQ1EaItnWxJIXW1WZiazCemv1HKSeRmlb8CV9vNwZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079135; c=relaxed/simple;
	bh=Ghap+Uyv9EG02fN/gnmF6GE+EbcYHA//0AOkobhpB5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxhjs2cEPTfhPI6GPUL3ltfqnqswvzveiPLr46d4n5koLgYYGr6kTD5zTukRD5/I7FLHRDHQ5qFBL05Xhn1YTSKGGdsEox6yhxb0h6091+2ljXcu5ztyVqhLssd8Xr077L2RNEdTnePkh2JngrlqABngq5aLxoFY68WdGk9xAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=K/XIFzhk; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7cee045187so725598266b.0
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 13:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079131; x=1768683931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrS/fiDVSpNqpnGbLktJGFsAvmbG4oFl4B9ZbG+ylX8=;
        b=K/XIFzhkDz3I/91Oj3cNjwR2MQqSipg0686W5vrGHcxAW1loty2U5Fw4fYjTcqfphD
         Luk4XykAPhgdn1IBOvxFNBg70wm9PBfMeRWupa84Q5oqARe/r6YwU8GsxcCuJNDUKY1E
         etTK/gsWG8Hjhj5HJpYEN1rv6JRSZGa4rYakWeIWM2XeAHCWWwsZr0Y6hqQFR7d2OGct
         P8C3km21syv48Fi3m/uRj1EYxspLWnL6GvwphoK5n9qR9LJetCyXM54XBAw3vt4cajV0
         WWKaNytR5KcFzBNPpk4XlLZN6o3AMGG4IyhabX301hdZlWsFJieIPUhB3b2X+s/dAYJ2
         n9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079131; x=1768683931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZrS/fiDVSpNqpnGbLktJGFsAvmbG4oFl4B9ZbG+ylX8=;
        b=NEWpuNGa1dIJvOayiwGnrz51jH2LT9c1PDbo1KmDPBuasJpqFaHBRzpCcN+Ue3jk+e
         SbijkMCTcHmg06BsMCW3mTtwQo1GEhhYOcPTQ+O/b1DpH9r5ZsTnwrXREQZYygpgASa6
         bbLn99qQ5UrLoYqK1jhaBnjNJQpGeleEYEatzGRauuKpdDeAqyXdRu2F5jCxAZim+p3t
         awotqb2rz8u4PTFZGoz/jTDgi0Qy1kltnvQB01MFoXmfuxC8zDv+PXDpDzAB7meOyAdl
         R5tJJWgudnXs2hRSCLjPYWVXeFPWBOmJeB4ofsT4PENy6eGpASwClf74yHQwAQF5PsJs
         6I/g==
X-Forwarded-Encrypted: i=1; AJvYcCV15skCx98beA0y8+Gz97OspoByrXLhrvUBVynvHh14e49fum9Hav4oGCcmfwWghczHX5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL93t3+hU6w8a2y//+O9PvP+Q+ny+skm3RQVWr+rSfcPb0twpq
	syxSjfyDhUDWF3YIKHeGSswtTk3MWZbjY7IA1gkTYiepzJ3zfOEHWm9TaOrU/+xuauTyBnyZzyr
	TVR0Z
X-Gm-Gg: AY/fxX5uSJ1swNxFh+BNt9DfI95bbT3DazmX17ouMIEX1yvSGcs2zPlu24EdYbNCAXm
	WGTUd/Oc0/MQZJBrdmPoroi79prYsmvCSH8cMCZo/hplAniDUClQkqAmesv59hJQl5LwQ3P78Ru
	O+kxXvTAjnKC5/Nuivzosrewbd8+vU6U2F80W6W08a2LzNKBxF6xnDICotl6G6/3cDVWaNQ4ZcF
	nDW/lIv6jx3CjQTHUij0IRkFMNj6StJ9oMxRfFnN8TEWuLGdH5e0Iv2jOarq26n8ZOLETCGP6YW
	EisU7tuhJ+H/plFKGemjdERRh5Rkp0oqGaz5NOqE5eQCjalMbm3U76WAgqSAYMmEUPyoqZ7rfTl
	rOigW11Z6ifU0ZXX/E68p7B55VdAYmOEjtJapux+vmPDXvneIwql+EXcsQyQY58Bjx265wmXngU
	KLusNRP+j5XRT3ByayOF6rKcpRgD/huOmk0Vg57W056bvC0MGMNaXQ1zTa+wQ=
X-Google-Smtp-Source: AGHT+IEXzU4wEefDLk0fDfjXgkYuzrme5GrsRIy+MsiA/VGuWxBA6XjNbLVOftqt0DT0rpqevpx7vw==
X-Received: by 2002:a17:907:a08:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b8444f488f0mr1563600766b.16.1768079130751;
        Sat, 10 Jan 2026 13:05:30 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d3113sm1479232866b.43.2026.01.10.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:30 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:20 +0100
Subject: [PATCH net-next 06/10] ixgbe: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-6-1047878ed1b0@cloudflare.com>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 7b941505a9d0..69104f432f8d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -228,8 +228,8 @@ static struct sk_buff *ixgbe_construct_skb_zc(struct ixgbe_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


