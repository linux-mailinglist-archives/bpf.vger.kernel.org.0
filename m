Return-Path: <bpf+bounces-78485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D0D0DDCA
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 22:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9195305FFE6
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E052C15A2;
	Sat, 10 Jan 2026 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZOphFmmZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227725771
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079133; cv=none; b=cfTlaIxuRNTMHG9VY4SmfhJHDe1p1l/ovF9c+76vOb6QWapZsOMmcTThHTnhwIZpcwy71SoLRr8K2ZCZiQmyScPRHEncwG5cbFmKeMAyZlEP45FIguUYAYwsLkhpQJ7g//2VkWXBdGs7q/1mDFkEwo2lAXzeGfd7GHxQcwiGlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079133; c=relaxed/simple;
	bh=ghj/Rz9kW6fv2FQC40zwayq6ljXNfVu3AXwF5ut0cFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsbLbW7tf5g0GP97zp3DfPL0qBWR8l7k3EKz/z+oy2UYf1P5NdusU8SRxqh2FKPs4rxtRPMWlxOByIReOXJX81rSbUP+YzOslXKoIRQQ7oxpY22ds1UpgPfSMj+08P6O1AWrYfa2Eep6gC+WE4gCQ6feIiQuBmgyMdM4GeZt1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZOphFmmZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso750716466b.3
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 13:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079129; x=1768683929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUu+7PHs26UFdRHqzYfDQSourHFpoo8C5CEANCSZKUM=;
        b=ZOphFmmZ/6Rak0F2pGk5/oEvCq07/K3C062GIlJjTPtpEGhPob6wNv+CfRb+Ey4dk+
         GfoakI2aIzZvIk5/HB81oMwH1TVk78YzWlwJHnLwW0K4ikC7M2MRKYPjaJUjpOM4w0F1
         0aMf2imhEGlWrf9aqnEZ3iDOBkGW/y4UU/rXfmrlthSxfezu4dtFq7Y1Z/GeARNRP0HW
         67LtQzNtn0GzEf85Uo23ObpXZryCjNdX+zCLsmIjOaQaY6QLIsqDqwgVv3rXzX6fhpjr
         y7Usgp/A3gpILSpiqvljIhQyh+oypUzX/dEGND70ExCDpqLfHzl/X4xOZavSoGMUfzbb
         GBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079129; x=1768683929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZUu+7PHs26UFdRHqzYfDQSourHFpoo8C5CEANCSZKUM=;
        b=QSg2bYlLERkpUqHTfWh4GHwt9aYLB2rFvYK1J5H8Gm6Z9l4UouM+xRS9XJZWjOIxmc
         x6sG0tYdLke01EPYb04Qx3bIUwmWDkRg4niJdeyv7aUviAflTw4KjKxG6ByO8u9tt8/J
         JRanj1xGPowMwJfMnstaOr7Lo7UJGwURxRuOswMzgcnfiR/0Z4d8r29vy6tDWj51UIqG
         0wrpLe17JqkuVPPvoOOiV7GYEhbJ0emjiu/nnv4KLImVq7lJd+V3ChuQ4FAh32f6SyLF
         FmaD6xshFiTVrsK3CP81jnDOmKlO5/A1kWOEkqHuIG82BvrLFBZnzV0T+1EYkGK+IJqu
         O3ew==
X-Forwarded-Encrypted: i=1; AJvYcCWABrRB8paNPx2xUKcF37Ty1MxCcHnWuH++t3tL44ca+nQ/3todn6PEt2pl+TnFiMxQL6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuM32CxxPUVn4qGk8DH4gZ6omQW/dJxG2Z/xbJsva1g12Wsy9G
	wSL9txO9v2BaIEPE8gjpxk9jL+xFGpoJU3RbVOUB3UDkeNaCRBfmyibEWweqraL/RsC1D6Kf5Ra
	yKk8O
X-Gm-Gg: AY/fxX73QPAumUJey596vIS2mPKwMrmK9vdEWCMYvvvF7TFdw1vs+2mVEgHHrVpHILe
	sygJPof1bSA+vN+Dx2Fu6BM6agxN0MiXhkortHuw3MH4N/4+4ycFeZkvJdq+NbIgD9COACqg4vD
	I+X28OsoeUx+3XTN9Ner8r6Y5g/ZW6ukO0qoH+m+87G9Gr0SerCkSdMswLVBrv2Bkq1UNFD+Sgb
	4W3+6S3unaY716izTgnik+NaxZcAyMvVICQIw+NMApc9j5BCEPRTS4ymYQcX0glbMbQJghxzJyx
	PTOD2puuYO1TCNN2Ar5/VMVRMkYxnobxecJPaXaKIZHHO6vTIaTnJ76KXsaReJe8qM/z/iy06Qv
	XwMvGG/vPU1aDUGxGlX9IGAOJ7lq6FR0XysY5QD+n2i8sG0N0n4Oc+jVUK1KAameDnlyTMhBbt7
	jQQJ07FmentAOVezm4Jg9iNZjJXMGRpAaaCyv5uoZuIkh7VTrNeOzkjHCoxmI=
X-Google-Smtp-Source: AGHT+IHZ1MkiW0BAlwdN9FIWmp/bE434W0FOzATRuz84uWEpbwM/KqLENQwYsINhv7tL4dP/p+Cb3A==
X-Received: by 2002:a17:907:3e9e:b0:b87:751:6f21 with SMTP id a640c23a62f3a-b87075187c4mr49897366b.36.1768079129480;
        Sat, 10 Jan 2026 13:05:29 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a235c0fsm1479807766b.9.2026.01.10.13.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:29 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:19 +0100
Subject: [PATCH net-next 05/10] igc: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-5-1047878ed1b0@cloudflare.com>
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
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7aafa60ba0c8..ba758399615b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2024,8 +2024,8 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	       ALIGN(headlen + metasize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	/* update all of the pointers */
@@ -2752,8 +2752,8 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	if (ctx->rx_ts) {

-- 
2.43.0


