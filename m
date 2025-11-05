Return-Path: <bpf+bounces-73704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F66C37AFC
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E95A94EAE9B
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9515E34B420;
	Wed,  5 Nov 2025 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TmQ2OmUU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5734A783
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373999; cv=none; b=RuYNy9gyWRSX191mccYdMBXErSFycfTklcbEe2egbn1D++v/9tCLv6EY2zy0hcpa4FTOM7i74y9p0ZPkdzjt8iv/4Ii7pqFb5O6/2XaIWNCEa5COU5KgquZiHteL/z59p7JbQsWKb+uZqf153frXNFMsgYOsXARPLZg8a7VEsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373999; c=relaxed/simple;
	bh=jphV3hLYyJpq5wHhzxxIdaldllEhemXAkq3l8pQxo6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IkcG4zRQM69mjg9ahaTDEVqgFVYWk5Bjl4VZq3uR4a5md/wH0gHYFz5h+qpUavTRm4ct3qMSpWdgymwki4xXLviwtmGXljiPV8M9sNfzUWEoBA222rKOCZgeK4pRbKeZNSgL2O1BFg9Ct9jxBz9DjrOlqhG4pqwbDd1ol1tQ2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TmQ2OmUU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7260fc0f1aso48449066b.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762373996; x=1762978796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=TmQ2OmUUQcbgAtLleqsWKrPvpJARe2KvDz7PKAOiSngv378eiPZpBf3oYGZ54HR4vP
         xxpi6ef5qM77bafrJma0I9hk3itg9Bbx3cVpWF7GwFb1iuxgNrYM10zTydJVRuBgtTzF
         wXB6s4I9jk+qookJr03mBFSGFwOig/5P1aR9c22fvjpoMCKd1a9l8BR8v0gQ+Dd17/Hq
         O3LO/BZ1omMROKsUVyMJSWUNJAxarVa51UZ1tL771QHAC4o2i1BxoZ+RSjAVgvCEihD1
         JgAB3Zws7LvqYWM3AhWEVaPL5K0h9cw+gotmgrsLiiDTepCYRPVcjeMDsJPR3NJjqeuZ
         JA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373996; x=1762978796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=oNYuylggbjDX/ARL2dp7w90+qNzriMnuoed3pBl6aE8jKeZrTj7r5wzmYqDHeEBIyV
         FoSk/eoE2QHNJA6xlUrCesOTEyKYWhNmfIKMx9jyKitOy86gvEZfnPGP6p7l6O9Kugl8
         rbexP1Ko7N3MmCTGdG5AvmmLPn9SQqBy4sarIpgAEGoXyN9SvxGHkfgfdIHLwQktaZg4
         erGjkO3mR37h96W6vgj38ymNiDSxNzrQyLV5TLSoLbsP3elkoDhlD4hSZ6qi7znIkHau
         IfAOjwFMKkJt2eln3BgzGxeuaTOT3IonI39KJM/5D5jBdSjG6Z213GkCPMK8Q6sSWJXY
         wQ6A==
X-Gm-Message-State: AOJu0YxhGpxmuEl0c0ynVy68WhjFGrsdNiW4XkKvPDQeJ9qgfLZ+kY7Q
	vvmC8IXvKfMnaQHLzrQFmcDS0rvtWv8pI9oo47RTUwbui4uJrLUfw6sbct3FDXw2L3o=
X-Gm-Gg: ASbGncsKcU+I/HmBTc9z1OSSmvqNyCrIcbJrb91QJosv0HDcI5XLoFjt0LDnY4RWVIL
	rAndbA5/oRuC/tmAASAmhFPWeLvFdFscGpY35pHi3uS3IfbaOmECivAi8Pgo0pVi+f5LKFPcrHb
	8YmvxlmS5blRmiu4tJYfIP7tLqgqoW2X2f4JyK1E+3blgfCXjGnIxJ/ycjnPzQli/u+mgWRMjIE
	WUS2Fccc57OHBsYvIFsQQt8g3cFMSYroJ1va3mi8ghMzeyU9Dp4ZAw5f7gPV9l9vZFh4OUdc5wY
	8z+HrD7249y2IcMtpJefbzyK/uBS16rv0RB8O0X1N8B7USNIES8ZZs+vNXuW3JPp2zqHDoHdZgC
	8ETI7dvOwOHWT9FfTLz0Gx/2DYDEvt4dpTeHXMMxvNGK0K8ZEQYXX37bdnORapbna9tigH9MN8A
	evG9yARTXR5KxLRg6C0wREkW+KI/niXcDDS1GszqHmZeW9VA==
X-Google-Smtp-Source: AGHT+IFm9pf1vsVOIIHhPivCTPoKVlXmRUuAQTrkB71LUzQ59fpA8pCc7dnsNTcgjtp5Xl/+1npLuA==
X-Received: by 2002:a17:907:7e9b:b0:b6d:2c75:3c57 with SMTP id a640c23a62f3a-b72654f55afmr421981466b.39.1762373995677;
        Wed, 05 Nov 2025 12:19:55 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a7esm57006a12.7.2025.11.05.12.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:19:55 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:41 +0100
Subject: [PATCH bpf-next v4 04/16] vlan: Make vlan_remove_tag return
 nothing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-4-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
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


