Return-Path: <bpf+bounces-77823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF47CF376F
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83192300B898
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDDF3370EB;
	Mon,  5 Jan 2026 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Fdv8Fmsq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312FB336EC0
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615294; cv=none; b=W0dVVJuQE4J1MEe7eox1U54BQ0030FA8kZFs0tTb4HgyK2/udBGlvZdJ+7HT8zD0ECD8KMfzR3KWwDMmC3sxJp1Fn9alWrp1XXPJBGstjm3yL18i+MWO7XNdYwbFpBBdkfJx1gJEE5uyyJxBJUaGG/+pG/mSXDCLbofZrAO6G0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615294; c=relaxed/simple;
	bh=NaLr3kuYmZoB45GFF481B9GG1CmkcJsN17rUBCCL3X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y82GwTodqvfHRsA9w6BBoEtDT1ASslkJLoIpJOkKuMC6G9q5bmPKGXqVFZHkdrGzI9mApDabCCLhaJt0asQOcJHHr/2XBq7kpqeWJeN/CRs0VFTNLuf5E12DwIVgJ6WswMSHvkMSV/aexHCkyRLJbpOiKvUZ3IOI2z8p2ua05JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Fdv8Fmsq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6505cbe47d8so577820a12.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615290; x=1768220090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BAkb07UvD2AJKDS63sluZRYEIGpz2hmyS1/vul3M/g=;
        b=Fdv8FmsqIP9oEyJgiz7/cRZsgcOEtDxBOpqXEvo0Dx7Ekqf341/ELQ0LpRJxXuF7WB
         8iER8irfxoqjUw4WsaboAzXJpsKwxTRnbnJsec7DLA01TzZe4ff0BVoP6UL7rq/hQ9qq
         eb6ctCce99ESX9D1ird0AJGpC2KgV8EUUWgxlTMm6KlYHKncQYEkd63F9GuvkKvVpnWk
         qfYAxoZwLCSPjiOx4Rp7FPz9UETSeaz9yWH+yjxSVxbZvZ/s4QRJn9+yhlosLwwp+rIu
         cW1MKE0fBpV6BVIx7+SmGy7jddVglLP6kueDZdtDs+3B0x0W3iXoqjCSXeiybL0Q4Vci
         fONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615290; x=1768220090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2BAkb07UvD2AJKDS63sluZRYEIGpz2hmyS1/vul3M/g=;
        b=vd6tg6Wu9Mg5PdWG7dwYOaHGC8Q/bXzoOMBkpkZYtiLsK8FiGEFdiS8RHCTmTvo8cZ
         rRvYyaX/Qv2Y6l+XEbJYMOx6vl5hniPXNeHpJa6Vi2A/xeDVZFAJ+QGTaKz0ZKPm+6b/
         FUWu88UIqJN62gB4ZiP35fPPih9ZZvzjoUiBoif/b6MxO5nyMCFxtZjvAjr+xRzpukSn
         x/4FuKmEx8Hj9T5qZk2fAQ7m9gidMiJ5aQPGPqNSJe86/YLBHwBSN6ETWy1Qhb5dicKk
         5KXmImf/xMC9kx76twIyc0o4bY/iZj6CyRmf9bvfJ7eOISpwKhKQ1Q+e7W9DMFuqaZW6
         wsZA==
X-Gm-Message-State: AOJu0Yw/+f3tQodcjMREA+3mjPDb65HL+JS6ruZQ29U/naL9CsmZicG+
	/LkINDlx/GS2AYh9Lc2s/turiujpCphyWLj8G5BoSPzvBMj+JbShFKPDnAfHlQ2Bf1c=
X-Gm-Gg: AY/fxX4Ky8DuUAdW31hAk/ixC8eE/4cLsbXl4T1vDh/C1G7NYCfla7LEIz3tb8+2aiH
	oK0TgbjIwk3kUdz0HXwzwaQFAtgeRBBhKFgU77ktc2TnIbSNMhQXSS7Ed2gptRAchoSWKNcJbki
	6gt+aTLqSS5WKm+sV8uiYDeYCjoEtGCHjQgSE8pm/Jutx9uS8q2zHicBTEmRd714f+FDZNO+0wB
	39OpIrqf0nPlbd2XTq5cH5kfVBlthwzz9/qUOpKd0j3W1Hmp4zXc+wCEd2hlEYbYhX8HZ4NErnI
	LNCJTvYNJDSuPJURfhWhDhJGDenh6RVdkNcZGhEhjC7YxqAj3rMkDXV/jW/fmXwL5X3PLrvdUi2
	sSzif4NLZ4n0NCK3ojVhU44zXD0zdPT42z3fJee1O+RfU8XTcjZuNAdSZ0yDWfwzFTWDrghYSwi
	LZQvJQtRafimMnav75GYl1AV0iiybzZdK2IDl/GojSi7+W+DMXK+MkpbeBdbU=
X-Google-Smtp-Source: AGHT+IFZbTDVGR2JrAuiEMqmDHBbbvEX92cxXAfcOOxKTm/GmwV3C8zNEedPki8j4tnnxUYBhiRLlQ==
X-Received: by 2002:a05:6402:4311:b0:64b:6e20:c92e with SMTP id 4fb4d7f45d1cf-64b8ea4b945mr46593884a12.10.1767615290543;
        Mon, 05 Jan 2026 04:14:50 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494c0esm53415488a12.20.2026.01.05.04.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:50 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:34 +0100
Subject: [PATCH bpf-next v2 09/16] xdp: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-9-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
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
points just past the metadata area.

Tweak XDP generic mode accordingly.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9094c0fb8c68..7f984d86dfe9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5467,8 +5467,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 		break;
 	case XDP_PASS:
 		metalen = xdp->data - xdp->data_meta;
-		if (metalen)
+		if (metalen) {
+			__skb_push(skb, mac_len);
 			skb_metadata_set(skb, metalen);
+			__skb_pull(skb, mac_len);
+		}
 		break;
 	}
 

-- 
2.43.0


