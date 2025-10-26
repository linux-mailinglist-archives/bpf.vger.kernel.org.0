Return-Path: <bpf+bounces-72233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B147CC0A951
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13943B0B54
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45249267B9B;
	Sun, 26 Oct 2025 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UhcTDHGC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649424EA9D
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488322; cv=none; b=aJaj0dKDJqO/MgMBChUsP94zWLqHHr6xe/6oxHZS/PBAiPeMHOd9pprBgcZrCZZt64uR0CTI2EjJMKGrBgNtduyMonjtFwfvOQBTY4wSM4SSSwm/lpLvbcM7U6pxaD+p/3p0Wk548xsSjTncitPylmNH2q7An99v2Fw0If+LpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488322; c=relaxed/simple;
	bh=dg/CQiJ9SH+N8WLjJ8P6Yi5KMCvTXCf9lbKxGs0ohNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKjMaZSh1M/Jy4bMbdz31NJiYDMm/VyzNGFrFnFA9jpl95SkYRhC2v8ubVzT9zU7VmcLE4St6fXDZfl+ctFt25oARZVN4Ved1oz7iXv58SlV2PWcvmE7F9jxN/A05E41+wOe9qhtJPYEaiyCVmOmcK2iQnNdUzL5wKCMTdaN5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UhcTDHGC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d402422c2so883419366b.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488319; x=1762093119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXk2q4ALXb4iHS81FjGOoDSTFyJQhG/HclBi/7HNWrs=;
        b=UhcTDHGCHBtU22Y2SlwQz1QVUphuAnTjNAgoaXTlprgEMgv02s9QzMXJX9cMHT6i9u
         /KuyU1sV5QynrBRSaspQVXXBFAZJwMqfWOW0jksA3msoTb6KEDBaeO6/bMqUpPJteXPW
         P7aSfsfaztNowzwKLDbGixMekOR7QzS0z+UTPxAuFdQvkVsvQRP2Cls/hDn14UNbrT6c
         KYxV4zdE31cttfxOlhvTMre/3H0Ym+W8E6kzvyEALQh4Zzaq7JuCKwnOyzoLlzBkGN0j
         FNJi0X5wTqADPoHyk/Z1Am7Mi+Jhm5Y94IO+hfoDD5uYC09YovIv0iNZOdopDQkCRbct
         hZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488319; x=1762093119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXk2q4ALXb4iHS81FjGOoDSTFyJQhG/HclBi/7HNWrs=;
        b=EzcF919ppWnJ6Dh9makcZTN2FiKQ7MS7pMPgVCYagkX8nPnx3GrcZdYWr/3yKPsdQ1
         hF87ijMqysfRVo+BytHy1eHSBHA7dJP1hj9fXj91yhfOxBlujVK/WALNdLI+uegRLoEA
         NJL24amY/3H6lN/1yCdmax391uCXPm6dLt9+L7pYBpC4TFZFJBMQQw6poJhGhBT9XdlI
         x0Q+OPLEVXcfWamiVPIfL3FB137T+zwmfYfBL9GNEYiMVhzGqvZ6D1QS2Z9GG5Uwte00
         DLMhpNIBYWeNbi3dsUslYZaoa5teaYwdTtQ+2ngWarIcDpsaAWshU+QFuJq+w0VdFsZC
         OjXA==
X-Gm-Message-State: AOJu0YxCgukdoYQunLS4wTjRFD8jkyG6KSc/gE0jrUPxPSujeXenVyF3
	EtQD5S6hnmHO/Ibrc2ZomXtYBaY/wgZmnL92tg/KCy73GrezSdec04gV4icwyltRsdk=
X-Gm-Gg: ASbGnctXIypSW7Mi5CL+xDTmm8MevlyU7J919I3Rq09zX8JzZiMIta14EBg8qSqDvrG
	WzhgeHQCR4wxFP1V23xg4RjeHXFt/KwJ7f/G+NW+2I5Cj7FQJLx4qrWBquk61TuwEqF5StLqxuu
	jo8g2FLC+dr+kHyTMGUQyRnjJ6eC6UcCmLbOYva9F32j7+4eGuP54n36vob37bqpap86CiqBdsn
	0PZQWdOE3rwrhhsCQMFlFrJKASkxqfEMF5Ni9i1/unc1IMQZluiFD+FBd9h90fCouQU0Q9vigVc
	vSq5hVhjEl3Yr0pVFVYy+9Eopdtf1oPza/x4Mlojh1sGsRbFuD68mXqdB+2+FmB78KFBatiR9WS
	thNDJA9XvWsKrTDHFFzdR9X7xdO6NhMIct4KV3u1dAbqc/2/ZCG7+Mpdx8x6j5RfUS7DVEJfdDv
	PtYque0afanJh6QX8XOixyW3ANRtAE6sO02zCiY+iq7HHhNg==
X-Google-Smtp-Source: AGHT+IHsg2UYIBjTMv00llWKSnCWyz7iHgjt1py2DwYGsX2VBRlcMH1w9sckI9tXRwYDIwGh1mKrnQ==
X-Received: by 2002:a17:907:7e8e:b0:b40:cfe9:ed41 with SMTP id a640c23a62f3a-b6473b530f0mr4016640966b.34.1761488319403;
        Sun, 26 Oct 2025 07:18:39 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm469815766b.39.2025.10.26.07.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:39 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:22 +0100
Subject: [PATCH bpf-next v3 02/16] net: Preserve metadata on
 pskb_expand_head
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-2-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

pskb_expand_head() copies headroom, including skb metadata, into the newly
allocated head, but then clears the metadata. As a result, metadata is lost
when BPF helpers trigger an skb head reallocation.

Let the skb metadata remain in the newly created copy of head.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/skbuff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6be01454f262..b4fa9aa2df22 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2218,6 +2218,10 @@ EXPORT_SYMBOL(__pskb_copy_fclone);
  *
  *	All the pointers pointing into skb header may change and must be
  *	reloaded after call to this function.
+ *
+ *	Note: If you skb_push() the start of the buffer after reallocating the
+ *	header, call skb_postpush_data_move() first to move the metadata out of
+ *	the way before writing to &sk_buff->data.
  */
 
 int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
@@ -2289,8 +2293,6 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	skb->nohdr    = 0;
 	atomic_set(&skb_shinfo(skb)->dataref, 1);
 
-	skb_metadata_clear(skb);
-
 	/* It is not generally safe to change skb->truesize.
 	 * For the moment, we really care of rx path, or
 	 * when skb is orphaned (not attached to a socket).

-- 
2.43.0


