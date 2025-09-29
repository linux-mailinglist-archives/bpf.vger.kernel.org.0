Return-Path: <bpf+bounces-69956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABCFBA97E4
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAAB1881F49
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF5C3090F7;
	Mon, 29 Sep 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aLHTSwgO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E0309F1D
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154970; cv=none; b=i0GefZFDgry3jkXELPVQv8KXnlx0MciTdWcHqxoWlyzeHLEDab2pG6H7s046nQUqXs6hpyFAuZqLyoJTmma6HixDbeV8+NAuuuLo8Mg6MvriK330iGkdNqktpKVOfPm+2bZ9D+6z6h7Z60587/hg5K/QVmkz9ZXGgwF7DEYhUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154970; c=relaxed/simple;
	bh=Mk6474eT/XN2ckgVBZ8mvHsLuwRmfJnx35ZyL6p+1S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kChAP9nQc+ZxaYFUyZ9DIuYF29JO4kzaNRPwBGV95sYbu3F4dRzZnIlg0vnSoOQLiNWeXIoWxRIPAiq0Vgjx0f65QeCsmDlxAnriwolYvKv2z/dnCqa11cr+B8T0KZKZrWvnP//XSusjo5udq5G+642KSmt/vpXmgVFhREt8f7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aLHTSwgO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7322da8so919297966b.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154967; x=1759759767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtxYAP6+wBT1VKxXkpyRLfEBYbOA5bWokqZy0K6rLg4=;
        b=aLHTSwgOp4SXcQIKKO9w6s7ExK3MFZT04S1RPJqZlNGkM7SIVCWU5LTqnl5+UifXCV
         XQUb7gTqy2tfpzkO9dsgPZMZ8M0WOv2poeN0XJ9MmCUy+4UNW+O5kOEUZBDDS1p3OJau
         C0ykDawZ0iniKsVv40mfmw+tveH0BRRpJmY7XY5GniluWKSX05CdYTQ/ijVdWygnX2L6
         1wRw1hmWwl6JKOOXrFHmW55fZeweKwATA78vyx9daNwauxLTCXCfiIk7DKuRUWnhJ9Fb
         CSJg0LVc8Ac2OO/Fa/2p/RKVA7Eu1KKBp9dCChaHO7oIcw6qCbh+EXRbwjPvz66fUfen
         3c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154967; x=1759759767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtxYAP6+wBT1VKxXkpyRLfEBYbOA5bWokqZy0K6rLg4=;
        b=SnoZ/LfAFYdFncFRJi1vTxZRo4gecBzzvWsATQwrDaRSxCC+NG5+PdSxIHS5Y4J9/1
         G2NeKdy2WjwCDbao6QtdQ+rW3IMM4GaZbRHuOqh7fuUJPKKTNltQ5iWGxY45pn9lrveR
         ONCrGpiEIG6KOEmooWAWt/I4NcY92rTw8h6ZnSpg7nQ3Ix82uzMKUZIc1RossP6MCJud
         GtXYtDZgg6e++yTd0IbPWM5CULwOSuDWu2KMJrSEOBdQXDadsW3uD1qzU+GdUAJSsZ/5
         VLSIWl1qOTungiEUyyeiy5suEoWqxDy8PtqjfEONsb7l/255XMaw/Babm0fnoXvNjn9X
         Ttvw==
X-Gm-Message-State: AOJu0YxnQQNsaC6A571EJJ5eAbhOP2L2SlZJZeikHvRzugugDfIAWTqU
	hWw+IFzmr44vBKfkVMKgzOExrmANnKFZv0TW9V1n1qq3XJRm4rBcz18nVGdNoHEX2Zw=
X-Gm-Gg: ASbGnctgYoEwZRuQvUXXZWUb9hLHIIP51pFD98Crru7yKRiDkeC0KxXq7QWAqF6qybd
	5ye7wPZwB8KhmFjtbr7itwEZm9eZK7ekSt3MtTRTl+qqAmigylVYD0pTL42tWWUa8EryZ+vzZBb
	o/jBNhdyVFY916mHQMZcIfCIizpbE/wNbueh9MBXMKr3I5k92Ljr5yy3Zwm5UZo4tmXMAFzXt2w
	L3Q7YiXeYze/JaaUVUZg4s/xgvBo0pd5fa3JQBpCPl2rV4U9nmrr9xEHNd/psYpR/8R1EgeNU6+
	EsQqYBHtaQHFkxg1J0rwp//kIYnQl25dwdqurWsdjKsUYBb2WoDzuUR5QcgAdEtDMHGPlguj17r
	DekW4TElAqO70RkWNF38mAwKWitMSncP+sbfU6ZVbAexWgt/NgbPaERyz4Zi1mDg7/oRBWeCm1E
	vFIVntx1z5YcierE+H
X-Google-Smtp-Source: AGHT+IHVMciMJCns8Rhue44SEU9UNWUGgFfjyQ2O/TgY45Bd9sI80gLncixYnsWQhOgKkRXT5o4ffA==
X-Received: by 2002:a17:907:9803:b0:b18:63b8:c508 with SMTP id a640c23a62f3a-b34be0fd02cmr1572432166b.44.1759154967065;
        Mon, 29 Sep 2025 07:09:27 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e3940168fsm249214266b.73.2025.09.29.07.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:26 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:10 +0200
Subject: [PATCH RFC bpf-next 5/9] bpf: Make bpf_skb_vlan_push helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-5-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Use the metadata-aware helper to move packet bytes after skb_push(),
ensuring metadata remains valid after calling the BPF helper.

Also, take care to reserve sufficient headroom for metadata to fit.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 4ecc2509b0d4..b0e1f57d51aa 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -355,16 +355,17 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 					  __be16 vlan_proto, u16 vlan_tci,
 					  unsigned int mac_len)
 {
+	const u8 meta_len = mac_len > ETH_HLEN ? skb_metadata_len(skb) : 0;
 	struct vlan_ethhdr *veth;
 
-	if (skb_cow_head(skb, VLAN_HLEN) < 0)
+	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
 		return -ENOMEM;
 
 	skb_push(skb, VLAN_HLEN);
 
 	/* Move the mac header sans proto to the beginning of the new header. */
 	if (likely(mac_len > ETH_TLEN))
-		memmove(skb->data, skb->data + VLAN_HLEN, mac_len - ETH_TLEN);
+		skb_postpush_data_move(skb, VLAN_HLEN, mac_len - ETH_TLEN);
 	if (skb_mac_header_was_set(skb))
 		skb->mac_header -= VLAN_HLEN;
 

-- 
2.43.0


