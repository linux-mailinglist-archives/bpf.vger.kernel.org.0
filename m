Return-Path: <bpf+bounces-78100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 350BDCFE4FB
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E1793086E7D
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F0F34CFD9;
	Wed,  7 Jan 2026 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AbZeKMyO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7A34BA46
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796096; cv=none; b=qbe8F9gkZRzjKbMSEH5P/jKLDncBHUdbenVHv+gxfvn7Ckv/TRGPBnE3rycIjBnrRxCgFig5ZAuRZhRjE+7CJrKNukgUxZE31AqesaYXUiRjIGa0a57RPlKvgsL3Y4ovhL5C/AeCc18gDXLPTxztUiAwxFF4ubQA76Vn4DZJvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796096; c=relaxed/simple;
	bh=Jw4sZlwfvlCw9U70oFYHFDt2JUDMKantZkYZjOZFw6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SRnlnVzn/7a0QccOjLue+PMcZBhG/2cWm00pSTM2++yZH6368CdU0O/GHig0sr4LJWUu9zmOFCV41hCVl831CRKpkqm6KyEySwlgULBXUdbwnGpsrBSG2v49XhZOJ9IjK9v/oxbsG7FHS9ApI6QmAIUvjdusEL+VydcL01Rkieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AbZeKMyO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7277324054so375074766b.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796094; x=1768400894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=AbZeKMyOqpvQMiznN6rgqUyVYWJyCMl1fWGB40d+EnG+Mv7fQjG/CSTJeK63i7LpVJ
         TlGH8JG1U7LoY+XdEZp67ROHwYnKv72zMbPjR5899nXsah3qAVPtjySPJH7UaB2p3qnB
         r+VQTqt2zkFnt15zWm8BeApz9NvDEadVjaJgIyJssGwPTCRHcqEwaG5DK/yPe7sz+FDF
         hNzzjJK50aTPuaSfoXugKXRvJq7dX7MuQsmncQHnEYrK0SRVJphVqVJB8LEhadZnxkOZ
         FG4+Rp6F5oTS1g8cEkY9o2UOxqa6rmDHauhVJ13mZZIHNjVXV7blPk4bwt2P7fK20PJd
         KKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796094; x=1768400894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=UqbY9sUpD+IPR0b6yCTeDgRMo257RSuynXX5DCYM4NtvrvtLt65kxT7O8GeJiKm7ka
         EoZbXpsXc+vEtLTw/xH7YgMT6rdCSTJ4mk14uVPIGUFvdRaWoZ0pyKLFzgoGCUK1HHPm
         j5FXDGmXS2s3w0MKtGHOnjZE/Fw/rE8DeSuEP8e82wEo4TTBHisf2Okno6vzH9Mtx7tU
         gwd4eSoBdLUfTVJiCcKTvaThVmNjOO+YtKDn6Rw61psElIbYwA/tUCQCWLJq/AM1u0R9
         X9k9Zzck95ZVDNPvoFeIbAvPviZKDJiWvbamAU3V3ph3Fq57rCtCOw+9voUuHHhaW3zh
         BdMg==
X-Gm-Message-State: AOJu0Yy0+MAG3HNd31LVlGoeWdXhrySP87wx/gtP+2VYya7v0P76Yeh6
	0itcmdgCmXSg4KrBtDJ7ZtPGrSqPyP19xfgbfw17MfVcNZfe/SwKcv6No5HTEtEHKMQ=
X-Gm-Gg: AY/fxX7J+Ubd7AJCgYu/RpBHh9/miadePYKbJpB9NDdCJts2BfKPF/5Bucw4pccBOVx
	ffSq4HfGTvNPc0sNHm65/d9PirarvO+bn908rVuO7Yh7JZLuAkJROCcnOYWXEQAIeQkwvswRZF7
	vj3CqXrlMVMO44B8Yz7y9jd/vUySjzdDuaiT4odSBlG/9PdKRnQOAdhBrZUSjuyLa7UffYqW9d+
	+kPOsH0ed4L6lrH6owS1zDDEAJvsCROvCg1MspBUhfY30ruNfWzNN4Pe8ydymlL6DGBGaEI3n4f
	u/PZ79Fa+MKlvCQfLeARkkCp6PdUvRXebPymDQRQp7YRVCKQmW8DsGPUVh0RC8Y334v7/o6z5oU
	htqbHoXkFQYzrgYG969j0uPhyb4zuzfoLEoB6J/FMCbeIhDadudcX8rn+9zq6hzw7fMLrMO4csk
	gAj6C2pllPSVRU0xn3sTkvZhuL69CtguZjNG+i5JTa9MEmofIpUVc/rLPZuSA=
X-Google-Smtp-Source: AGHT+IEQyUNgEE5LhBCFBn9LcA6fi0sPlJEzbNogQ1M20LW35Y5E+tEoz6NaQqd6J136m44VqzesBg==
X-Received: by 2002:a17:907:6ea4:b0:b84:41c0:950b with SMTP id a640c23a62f3a-b84453e8681mr235912566b.62.1767796093526;
        Wed, 07 Jan 2026 06:28:13 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27c760sm544507666b.24.2026.01.07.06.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:13 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:03 +0100
Subject: [PATCH bpf-next v3 03/17] igb: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-3-0d461c5e4764@cloudflare.com>
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
 drivers/net/ethernet/intel/igb/igb_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 30ce5fbb5b77..9202da66e32c 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -284,8 +284,8 @@ static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


