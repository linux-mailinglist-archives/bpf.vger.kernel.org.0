Return-Path: <bpf+bounces-71297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF744BEE536
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D78B189D1AA
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0542E8E14;
	Sun, 19 Oct 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HSifWoG8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93A2D3EEA
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877947; cv=none; b=mP7n4oUgH4K7dPG9LxSXSuOGvriZdQ5RdfX3H33XD4oxQCNtAXTO/dfdp8V7LhM18mkjhdxJcO7miN/Q1r3UTDbm7yZBk8EMfz7wHH4cq8REsJdNv3A/VetsWdJ/SFKkta3Gb0IVRmy4qSBSAE2UhoYGgXCrFO9RvJ1eEZ419h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877947; c=relaxed/simple;
	bh=jphV3hLYyJpq5wHhzxxIdaldllEhemXAkq3l8pQxo6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzi6J7QOM3Y+TWUKTSgoASLHw1dJBGOP9a9UOVtngPryjBTUreSOHR2YS348wunycK2LFaAcHDk8I8h8I3swcuLOOoOOonUiioeYtB/wU16PpxAPY0NKXJe7rifGe6/F0Kmcnt4sFY5lQV5KTxqb7eKos+/I4wZugG8IFULY/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HSifWoG8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b5a8184144dso560136266b.1
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877944; x=1761482744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=HSifWoG87oYzSQPt2+pXg+u5vyI+8Gd7ohQIkKMzV5RqarNMQRpIaQjPsaib1ASG7E
         cffFffENi5yYcmkcMWZ/tjVaVT5TLqJ8bPQqe0zhDSgh1KgyMBnB8rF2fBJfcrbG2ThR
         s8Z9bTbXikk7aJvOZJ64elTgQu6wiqk3u9KkOru7+w0TRj0q9phQ+6fOc5MnF+SVASIr
         x0xweUtYnx+Lad0D1yFasJqq9XMIJr5MOU7DDuqRUrSsvZ4D8GeYHmc3r9BzO25ii8J5
         hM13AJAVLhMYDwV9nee+LCSGYFIVm2UyzhEPVG8sRV6VCGVaV0i898zDsDnroNzaQBeG
         pkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877944; x=1761482744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=dPJeAiz3y6yci7TjIx0QY56EjxsRV+unBqUw+17I0JH5C58EMVgRu69T0SbYBdW6XB
         TSLkQu2IoeSESPFLnfud4dntAyRBVxwvmeS0n5g1sSlvAcyRPsQ3ACyG6gfnjz51G2o3
         GuVtaQDt/LgjzYW7cn/qjVN4YZaZpRF8GlA/H3liRsw0FdnWSHKdEBZPS2Rh7VW4TEyC
         rbPLehjgAdaCFaDIpAnGAo4HczcZTWPczlzKbsgxrHZosVaqleYjQQjIE6nBRyFo2JTR
         g9CGELHvMAc6SNzpEL8CHg+7749hgIP5c7BE+iZEw+0CSgJEA94S4vSg47SD7OuR9ejg
         p3mw==
X-Gm-Message-State: AOJu0YwrLpozIPPGRa0eTpSh6Zk7iJSj8pez2s6dqg4c/PFj7w2woECQ
	fIfr1iDgpM6H2zvjN5I0S2tc8dgaE6OI4INJJkHLqVEt1tT+pHQtc7k/B2IailD0Ubk=
X-Gm-Gg: ASbGnctW1ixgKOibD1VGgOpXKgL8eiu9jDGeFdDArl50em1I96rieQZftqvOhW3BOnD
	/N5lpSl7x+wqjwLLyx28imtwW9thCbRbNSxImALbYwk2/BBBgCv9b3fzEewLWfxEZdpJYkeCzfJ
	g6tCjZABD7iDNey3LYodHKEJdMrVNyDI990nkOalKYhtFeifT7yY2Nvc8uuPBpMZfM4NIPRg+Gu
	SgJFUjEQmRAevVwqg7YHX4Uq7vE5oBxTNelhv1cvH5eBRFFzSLEX1v7EbUAPezjBNAjxjD0fOgd
	/+DaLK4qExAeSucgj0x5//9TRFYp2gUkl/ekWynb3GyhT1xC9J5AtTDjTrcdcrYCmViVSSVLT1c
	kZMhtrH7K2p1FKKLNx4WZzJLNlNjqvVOdSZTDzDaGQ2YSB7j6hp/nqp5E3g+LoHZe70ktxUuFdF
	vhxoIfgU9CudJUzAPjFhTedm9TR/d2ydI7gqfcS8OKa+zxORtj86l4Vo+q2J0=
X-Google-Smtp-Source: AGHT+IHDHDKD/znwzM4+iLDwiLkJjDAADYiTwF+sD9fBdMI4F7B5OeZOPbxgdItweF+UzOxae/2P2A==
X-Received: by 2002:a17:906:f849:b0:b49:86ac:9004 with SMTP id a640c23a62f3a-b64764e33d6mr951788166b.48.1760877943744;
        Sun, 19 Oct 2025 05:45:43 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da33c6sm482809066b.2.2025.10.19.05.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:42 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:27 +0200
Subject: [PATCH bpf-next v2 03/15] vlan: Make vlan_remove_tag return
 nothing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-3-f9a58f3eb6d6@cloudflare.com>
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

All callers ignore the return value.

Prepare to reorder memmove() after skb_pull() which is a common pattern.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 15e01935d3fa..afa5cc61a0fa 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -731,10 +731,8 @@ static inline void vlan_set_encap_proto(struct sk_buff *skb,
  *
  * Expects the skb to contain a VLAN tag in the payload, and to have skb->data
  * pointing at the MAC header.
- *
- * Returns: a new pointer to skb->data, or NULL on failure to pull.
  */
-static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
+static inline void vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 {
 	struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data + ETH_HLEN);
 
@@ -742,7 +740,7 @@ static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 
 	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
 	vlan_set_encap_proto(skb, vhdr);
-	return __skb_pull(skb, VLAN_HLEN);
+	__skb_pull(skb, VLAN_HLEN);
 }
 
 /**

-- 
2.43.0


