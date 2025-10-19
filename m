Return-Path: <bpf+bounces-71295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E00BEE52D
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2FE189CD8D
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB40A2E8B81;
	Sun, 19 Oct 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XrcvctAp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD92E7F38
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877943; cv=none; b=tNHejUZImCtdhCVAYQLXc1XHQhiiRVSzleBLtTYhAUKWkSkuP5mu5UL7LHhL0dVZBLJUQI9B/5E/IdGume5674Q8hDKms7US2QXA3Utg4Gl6nLWy5dC0D8CHj0nRIc8eheTEYGMPkgwh/FYDKLNFtXce1J1uxHUMOtGOIth6wmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877943; c=relaxed/simple;
	bh=KhuYxnJEHq5CFYCn+pyNoEbpe8HKuPYNzX4WAR/9efA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjG+Xsg9S6mbJP/aPooYRVkyJAy/u1oaUUeHubZxyEuHr2RB0uCLRrRuHPUCd77Mg0xQaPzkkzAu5Kr7VenAwe5JwrLsmG0h8+EtI24s7W4xfhDb6UIGaj8aSsdgF+Ut0aQV1RZX6Ioi432owO1IgKw0BcVtC74oEDIgK+PbjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XrcvctAp; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c1006fdcfso6501200a12.2
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877940; x=1761482740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wf9aBWGoVu9eQPsO6dCihEsriv6AslJ/nwpVUK+i0LE=;
        b=XrcvctApcbCaOmMWbNYV4FkZEzDBzjDS3TWs3L90eE/dW7HTjc1KHR5egXxfM98UHB
         EDld65jnTPC5LzlCl60MMbHZx+X1Fd4cct7gBLZLxVgmIEDbU1brHDb+xCSBsVF//1wB
         uGw13FbxjoXUMTKhb6dB46cvvgFV2biPC04nFHiDMZFzdAn/DeC49NnZzBDdtF/IibV6
         picdwQwzOXJvDxIUe0q5d2TAuTvcdXd16UxouCUOk0N4PoQj2xRAFWMKnjSxRSWEKl1X
         XOl3lL7WRypabuDVm8NtveikClY3ECkA/WS4V8xf3Fs1uvquSNpoXIPSHnF1RuCmII2Y
         UwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877940; x=1761482740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wf9aBWGoVu9eQPsO6dCihEsriv6AslJ/nwpVUK+i0LE=;
        b=ZNZg0IhyEXbg2/IzWvADVAgmMEdzXjbWXtmUnp2pKujhcQV7tg9JcQz9vQmfi3iw7A
         RDliDaqLyR4D0AneMOL0jLnrZoOM3siWE7nwj7vYla8VQ8zxaTlpTq3uSaCL9KwIDcGN
         xFMfQ9MYM1M1CEosR+Qa7PCgUFEIxBIua3uE3EWZ9m65xajDdbHAgyqRynEOGLov5XWx
         W1bcWilrRQ9c95OTijGk46FP4tYmueh8elzwfX8vUyVXHcqW26A407ngTRc9lXXxMu0y
         uM+16RoeAqmkHjauL6C0trzJl6/0VkCo2KZ+Ir87/KqhZ0/rz+fW4ZeCM4QCezDTI91U
         PO2w==
X-Gm-Message-State: AOJu0YwPrle53HJBmee+ODa1tDr1qtv1kmCnRI8izIWj7SdzrlTjnDD8
	NrQDYuzDUiI8RL2ugd2msa2nxiYx0QsezWnbCMn7+k03U5kHB9q3BJTpDT1K3OMnoJdmm8NQjOF
	41Ck9
X-Gm-Gg: ASbGncuZz8GLzyE+iVfwiQmRxeuQ3+XfKDABosr7w7L41lsXX8hhW1ThwPvIkpRfn8X
	nU0rrPetOgnxOIfheM6S3jW9ND4cslpAmDbU63Ywy0haIE4uMHUXKr+GN654NkYuLjmaqPqHGT5
	bF0kok2YYQqJ0CS1dkRLRq+S1W+jh3axNPAwwsqdALvJlvM5VChSjCOr9vBMteWERCnDBaZuGRC
	2dhsHC6MAR0hvzcoIn40pMHPVLqD2AOedL56B2cEwuwXDux33gzOPQeQkikPXyxEUpQaCermbdk
	emPBwhFRSVZXFUuUNzfScnJ3dUgMlf8SUXIJpI+p9cZfOzWJsPcwLL/EWPyXdpjai7GO61rED7i
	H0I5V1vXwMDdxHMqtTl1Lst/YPA9Il5LLD0hCH8KLuazmYh3AXffVbWyRB1zjWZfegXV+vPk4mS
	xe9mz0IqcIT1cpXKFe7r7godnD9eRVCX6reoJzMhOzaSoi3AaZ
X-Google-Smtp-Source: AGHT+IFNMqon6T6uuaSPtPWzeC6hvMBM21Bgd3h3q8kWyLROPmC5WUKidH8PCwxmeMXxs3ib6zKAZA==
X-Received: by 2002:a05:6402:f11:b0:63c:25fb:19ea with SMTP id 4fb4d7f45d1cf-63c25fb1c51mr6038774a12.18.1760877939999;
        Sun, 19 Oct 2025 05:45:39 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949bfd3sm4102549a12.41.2025.10.19.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:25 +0200
Subject: [PATCH bpf-next v2 01/15] net: Preserve metadata on
 pskb_expand_head
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-1-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
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
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

pskb_expand_head() copies headroom, including skb metadata, into the newly
allocated head, but then clears the metadata. As a result, metadata is lost
when BPF helpers trigger an skb head reallocation.

Let the skb metadata remain in the newly created copy of head.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/skbuff.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6be01454f262..6e45a40e5966 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2289,8 +2289,6 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	skb->nohdr    = 0;
 	atomic_set(&skb_shinfo(skb)->dataref, 1);
 
-	skb_metadata_clear(skb);
-
 	/* It is not generally safe to change skb->truesize.
 	 * For the moment, we really care of rx path, or
 	 * when skb is orphaned (not attached to a socket).

-- 
2.43.0


