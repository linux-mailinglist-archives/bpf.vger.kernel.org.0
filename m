Return-Path: <bpf+bounces-78103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2ECFE522
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C575B309EE11
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23034D4C0;
	Wed,  7 Jan 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TMSK+xP8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDA34C802
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796101; cv=none; b=Bi/5Gxd59VSulEDFT1WJV+tEwykyjUBMMGTPtBcFqiM7guB4F1QOUfN4smxHdocJPFktX5SN6eYso8piO0GFG5ikM/CzMdLns0j8ES8vEYwlinH2phXKHBYUKeZGDISixbdktzodx0zNgEsEU3o+Nn+YtQEuBKxLXJYkE2bswGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796101; c=relaxed/simple;
	bh=vTSKYdEKalEEC0tYawisXPYcDqtHT/RCHD4qS7kEMbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rzO1yvreSd6CFUQuJH9GLPZluvbIUhxtdZ7QV7d70T6FUeXCc3yjkdInc9THXC5X/3moDjnCcTFUp1F1rgCY15NIAcz8F4oQPUCoZHA7mLXFzesgQWN9MCpvNQYso7+Q4TrteLMHG16PGsUsL4ktsBdjEXV9faNt5fVJvD17wEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TMSK+xP8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so2948779a12.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796097; x=1768400897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=TMSK+xP8RG3Y5lcmk/W4YIuTbj69Za3gF42TfXntt1XS+yrbdL2Bl+NCJqmjBzB422
         IVbWPfK6WR5qAB0/xeunba8SGCPEy9yCv+pXZCxsjM/MRhGdFaJXVJmvfXPI8oo87Miw
         +Cat794SJKVPGRSloO5WLbGOCNWSGiKbRO70eFEGUbafiSrD61IKoy/76Taa0hU2xSFS
         GxPMGPfWfFrTFc5EXotxj7yuYwpJ6O3Hvwp/XBKhZAnVlpdIObjLw3yh00pp3mVoPPHj
         wPpwfX/KRrmB1sII6TUMqYL2bkWeQF3wQyPAGXb0grzDoP0W2iUfynOkILuQinphN+cY
         THJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796097; x=1768400897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=UYvNl8i5B5J2v+aDSymecWWb7xoi+pTJDmpcvz2a9Ga1PMCEvUvoWTW1lkVvFTgzKP
         K61B97DSZ4IZs0W9EvKmJj0pyMwi8H4RRz5MnMsUPzXkyLYgUcSoBZdaBifdGrkqxTvR
         6G/97yGsKqn7sL7na55tpS9F9553sRTFY70DmJLMx/be8w/mAHNonOTITMuvppajhJ+y
         eKNDxrkpYWgaA+JVD2xQh90zYc5GHtGdfkq/ukTWe+ksVC3MGNfwQpswc8FY00wk0T9e
         lje+FTcUXm1VcrASLQxmOeWR48thHqW+s0o33mBRWEnRd9wTRfF8L8/Q6uBR9sa7a3OJ
         neRw==
X-Gm-Message-State: AOJu0YxqrJ3KmoBxN7wMmPstrxkkxYOFbX4jZpOiNEKwfkqQZ57nuDTn
	nlH3euX6mBFYDubNizrBiIr3Ew7jymUqBgCjyzCHUdsQVKWweCiBduKvSgPfRBLz6Qs=
X-Gm-Gg: AY/fxX6nKTD2kVcXkY4AJSpf8WgqzJVZrViBr+V+7H1cXd8tphjJozpRPlj6xwQN/sD
	JJiThJMTbdNguKIcpTUSEVUc0mWhZ5D1CVlXNkF7NIMRb1QU5Sb2f9uiCBRRPHN7/J9UX1iMHXI
	Dc/EFxHXGAs/5HOUcvL5R4t1HNlstgcObmgu8VdThpRISYKuQ5m2Z/d8NOsAeys/FhnUyQkE1rB
	7VcyV1W6eBQ9XMXVNUF//c2BR3z+QkjKRlCvJ+lCfokf6/RH+EtBEF05mTwyo1iZdDwLgCXpOcn
	Eq3OE4xl5T23sk93aacZ8BwGJXSU/iKGt2SEk6ZRK7cM4jORx6cygVrKyB9gqqUQ5zyhZUKJCsp
	mlS3990CEt7UMI7VGT8dD3xMdRiDeO7TPF4sgWHluNoZ8+3VZIAa8AGFMZjVW+Bvg9zrrQCMtJm
	z2z1HEdEaVvvYzc97/v8ghUaxUPP92j0UeXUzd3VpSBcE29k70XINr+GrKcwwfXi3LxPB3Iw==
X-Google-Smtp-Source: AGHT+IGM4L/5As1969KPTHQE48piWNYmGjpJT96e/8YSp6CD8TX1LSs5ocFakSsAK4mY6THqjPNpdg==
X-Received: by 2002:a05:6402:2347:b0:650:891f:1c07 with SMTP id 4fb4d7f45d1cf-65097dfa98amr2467937a12.14.1767796097014;
        Wed, 07 Jan 2026 06:28:17 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm4716873a12.29.2026.01.07.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:16 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:06 +0100
Subject: [PATCH bpf-next v3 06/17] net/mlx5e: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-6-0d461c5e4764@cloudflare.com>
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
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 2b05536d564a..20c983c3ce62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -237,8 +237,8 @@ static struct sk_buff *mlx5e_xsk_construct_skb(struct mlx5e_rq *rq, struct xdp_b
 	skb_put_data(skb, xdp->data_meta, totallen);
 
 	if (metalen) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	return skb;

-- 
2.43.0


