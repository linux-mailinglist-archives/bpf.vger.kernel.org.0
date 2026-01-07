Return-Path: <bpf+bounces-78098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A422CFE4E9
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D50043046747
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5A34CFB5;
	Wed,  7 Jan 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hs1dFJf4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77534C128
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796094; cv=none; b=a45JIo/RDka/ZKjbpCmvE0p9FU/qB2ilfWpyOWS6IP3/Kg/zf3iL+yM5SblNIRiNvyCQBYs5QgzixcdJZv91L/W917CHFzUTUGtdPJj5Lz90Fd1TW5QcVQk0Rf6NWRzb4pcfd/7xg74o4jtbbPjCUjHAFdnPxxLCHFTl6c8kZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796094; c=relaxed/simple;
	bh=1ck6tutHU4Ma4Atw3X74zSh/n05QAkXfc1PVlu4d8xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNy1v9gCDGjCTO5uAlcamdS0+PlAE4/YeQFzrkXhBfx8Pd/BOiWc9fFzAdc+r/qIz1w14NFkyyXChhLAVlGUT8hzMzpUSlD8un393fjCPbtwUFkfL+MLtiRsDEi5QPuZaJ4DCRw/61uBtOEhiWCgn0HIRxquroY8hSWOsC7hEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Hs1dFJf4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8052725de4so303369066b.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796091; x=1768400891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJsFK03V0pNRh3ST65sOF8XcGbv2MZfFShwn+TGVpfQ=;
        b=Hs1dFJf4Tg3BGlWCgMSW8QAWX3p5UWr724grLcREC+jfdSey1d1axiH/CCcrFx+vgG
         LWqL+LEncdnLwDjWRr96N18UggTmpAQWdA6Z/wV5JvSoR/Dhh8AA7JFhnvO6lYQKwIjR
         WXxmg8BJth3cIUicsPX/ktbeVRYfH3DkkzNAjS01o0Y2Bb4Om++pVEeLcTtYYP3d7d8s
         froSH9H45zzrUyd924Mw7MENOpx8pTP0mrCwm6+BIzbf4ouGQI5y747kr8A9CQFwQryF
         XxkaTEb5J+teqPsWMTPh2WyWI2VxTmuoTbGp/fe5gmOngjk/tDOjrXGYznU6L5f7s3gY
         ejcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796091; x=1768400891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TJsFK03V0pNRh3ST65sOF8XcGbv2MZfFShwn+TGVpfQ=;
        b=i01L7m3ZV0nt99wbkFKzeHjrIw3Rguk6sqB3Pm/GvdzqH4IT8HORewrFwHN7sNdWye
         vmwhXlxh3E5PyPk0zy/rWTPga/ru3ZpBHR5U4OW3V0+1C253GF/SWBqP8BYgniCztgSS
         TSXtx123WCD0UWD72dQwS2M1SqgS2eNrSiw/Ts4nAZYZ7zHMVv3W6IWHadF8D/6+sHqK
         GB1avYrovl/alqioY9Olj8d3fyQxbMC9n9gI/05nxV2R19p5OomgzfIZDAETsOCkVl9q
         1+4aiOxmcTZuAgOBY37DtZQZ3wnsqJgMw14eI4W2ypqmn4WeZSsMccACcl3OEQ1jyETH
         +juA==
X-Gm-Message-State: AOJu0Yz3ArshoEWLGrmEHSa/L6HE/AZXmRjgko+rr1f3HVBk9XcP/2OU
	BcNhMT5NNqTvzS1sFfTDr8oFbRka9Hcz+5E+qRduqhh7Gs1lOLxFj4vHUCGPE5RXVxY=
X-Gm-Gg: AY/fxX7BUxF3KylRJRi8fmjli4F026uPcFQUhyRhP+OKXOe27D23FBN4jK7+n+oT+cK
	tcvqTs+nbNlRbUkSR9jPTLQMMibUfuWZ5mJdKwdmlNYeA6yEkst/nJowWlsGXruzhtaJ2eOUvTQ
	GsbZBER0VWeetc/NhycEDivzfCsy1uxuaGeAndp+tjbA7x2GOB/G53aATNYA9vM5R99a/oOXpgl
	+feObBY+YyyjBbOxO4p4rHXA/H9tg+9XhgFIg5CJmcLckpWHA/Ur+6j8gZj0/+8jKTBqM97daKn
	o0pWeGgCpsPspw4mlu19y6U03bluWJ83fsAmu0maeDfrpcFxHCfIxNS400A4vtu+/MKCznQpi6z
	/kCCqRavSvjYVovog2vQ6Jxi1jd8RnKTeXI+auC77PQB01S1+uDGflUiz+OOqlBJXTsk5iZssjr
	enPZnqFhwj6SZ4492ITYzLtywZqRcxsNJgq/7AekPAbgb9WCVTqturQ0YjnLo=
X-Google-Smtp-Source: AGHT+IE+q5X9qXosYEtHOjNIL3TLphMDufwJ7KJssSgQQY8hodUtwxtN4kg1hMoWfCz3BVk7EQ/yKA==
X-Received: by 2002:a17:907:96aa:b0:b76:8074:344b with SMTP id a640c23a62f3a-b8444c5a094mr223930266b.8.1767796091166;
        Wed, 07 Jan 2026 06:28:11 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2cffb3sm528626066b.31.2026.01.07.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:10 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:01 +0100
Subject: [PATCH bpf-next v3 01/17] bnxt_en: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-1-0d461c5e4764@cloudflare.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d17d0ea89c36..cb1aa2895172 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1440,8 +1440,8 @@ static struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,
 		return skb;
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


