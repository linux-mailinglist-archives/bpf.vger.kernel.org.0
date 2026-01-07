Return-Path: <bpf+bounces-78099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91663CFE4F8
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1D493058BD3
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AFD34CFCE;
	Wed,  7 Jan 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e4xXmRTV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398AB34BA56
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796095; cv=none; b=fP2eSAimxGh7gGQe7ebRqOIpSYPWaM2H1s2A73x1/IOHC3Ye5oeiY7zOYMvhjYdNiNdwQev0I9BKXxEbVXcSQUD5GNu7xkroZTFOyF1tCmViIGGrGYEIzCK4L2jqcV6qCOGYs78yYq7Kzit/pu0bTGrD+kBMQaP9jYIlYMpNIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796095; c=relaxed/simple;
	bh=oMHmrv504DpK3sDJkcM25UNgfzziW6gjvBfOPGWboAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+dAIglAkpqlXJVCrrf59XH4KuMkzrk3DmXSh4a9ljCCZpR+VPL5OKG7Dh8Amx2hvZ11+Z/FtnQTMPi5QEosGxL74mX+fnJp0AirZvpjhZne4Tq6E6ukH1k0hMztM8sqILFDVBICongaqOaepsPBPD5qEiw3Qz/THbgYYNGFSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e4xXmRTV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b79af62d36bso377627066b.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796092; x=1768400892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhn4HZ+NklBudGUcJpb0YU7dEzH4q1ZmXiPPH0r44sQ=;
        b=e4xXmRTVBjBCc1yn7fDg8uhM7KucDYjoqA+I7DcWU57uinejeVq1Be8iHzdZccLQ+M
         de3VA4WpCexfZ9GgzrSdbncEStAeINWomO/y584ztcOaui66ZkY9o9STsVRpd02RsGr6
         G4QBrM2pnq13X18pimATqMH2TwsnlAe5H0LuFCD8p3UcsE0G6bsNc7LkToV9y+pr6zhn
         MIsYBnFk88KC4HTkC5rxiHSixx0oFLgHxhy5X/ca7pHRrYClnbSTZhZQMYQcrQr9e500
         CyCBjTJ1+CB7oumLnM3A1PEu6IKfi4NOyq5HcyStBfjMvT7mHXRxAZT3yhoj7Sc8hRTz
         rEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796092; x=1768400892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xhn4HZ+NklBudGUcJpb0YU7dEzH4q1ZmXiPPH0r44sQ=;
        b=IOYNkuuxBFlUxLTolpVOGoM2h9vUU4GuNhenrBUmkvOefwjdo8F7VjhgiLMY9tnaoV
         xLkIILdSbacstYPUM9ajxnT/Pt8tyUNgu55jXfAWmBBslq7vICnsyHo8psNqKME9Sv7y
         3AaGdLu4GyaUKSJj3ZhNn06OehBlJTYDWnP1LiPgQoFTh82hVJQY1YmBIQiRw8Aypmc1
         15GbnCmu9ozct7XRh7/KusCrSE1Xg0+SwhpaygpBulczFgZPwTJmWc08twDuYCLsOPh9
         cFSTTgEr66thoIFITXKHbupGP7fRWXziftEq4KWdHBEWEKLyi1azN+/WkEAfQ/DqSOLs
         6pyw==
X-Gm-Message-State: AOJu0Yxr5zkejA5ycfVpw/wkeiAu58VXeb5MjstMq8NexLvG/UBRYRua
	PvBV90wKrORZgo+Xjizt59o52tpv4OLRqm9S2291E4PDR7PjrPMK5GldH7stOiiJsWA=
X-Gm-Gg: AY/fxX4/yfieDGirDrr0TdxVFkLny82el1RAtYCJ/Yn/skSKsOVpDNB+ZrpV+z/5PPw
	+jfL7sATqgKUg268hiVW1gJtD9M8ue5cJoSXFWR3mx5xgaCRqy1Zrj8ar8PMgpSswyJ+iehyqso
	iy8bYRBur/LgFIN0p3TTDWijmdFP8oBNAhexRqZpfFTsLTckSp2QV0bugh9fKiiE7hX96+E9bmw
	T/aQTUiVzwsizRWS/o7yl3CwxSpAPQ4FOSOGqYGhrTP2UcNsM/SU/c7XUCaOAh4zH+rbSHoVfJo
	OxO/AOAFwGmJJvKmTLxwpLjx0zcDfSsgvsUpa7n14Zr/hSpDctag7XzZtBUXlGpKJpscnmF4gWF
	QOKrh5On5wUMIu3EM6n34gqKZAiPHobUHbF64NRwVVQ/NH/l6bfctLvj1OONpupUGEbadQ0qA6W
	U3lnXTOd7RTocRaaF4YwsbVEJqv5BMJoP3geJgnEuj8rsFcLVfnLIz++lGyffZGmfWJuewgg==
X-Google-Smtp-Source: AGHT+IF2QR4ckEkUSpnkgh57EkDu2KmOFFwfQ6RBwO9+Ag6bK2PzBTQQq9f05xpigpBaIT4tIcFuQQ==
X-Received: by 2002:a17:907:9615:b0:b76:23b0:7d89 with SMTP id a640c23a62f3a-b8444c67f86mr295448666b.14.1767796092324;
        Wed, 07 Jan 2026 06:28:12 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d029bsm528159066b.41.2026.01.07.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:11 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:02 +0100
Subject: [PATCH bpf-next v3 02/17] i40e: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-2-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

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


