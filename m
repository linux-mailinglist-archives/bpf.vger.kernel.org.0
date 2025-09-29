Return-Path: <bpf+bounces-69959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E68BA9808
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5063ABAEA
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A05C3090FF;
	Mon, 29 Sep 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WfqSoM7t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6643093BA
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154975; cv=none; b=oW8jdQY7ABKgiegfIJn7E3ONCLIEjttaRgWXmgCHKsJxyGy3bhqlgEnUgk07L70cXQL40klVrrt1utQdm3afneQ7SvSmGugcL0GC8jhiFdNVOefdbMXWEX3YmFx12SqgXRe1OfU8cN0Urg3Pf2Aw9/xvUDZfR/NaSxTXIrjXjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154975; c=relaxed/simple;
	bh=WtN0LBKA4Q0OXAASaJXgPYZ/nUWDRKNFBvYJoEj3+k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hvnESMQtQXfnhpb9onAyeVPjIZ6YoZWNsDuWDWRNmBobWzYtyd7SrwiWnKN2ODr2mTdqo7xcUqUi9WODDELqiCwW2n5HgZ6qYgOy4vI0ZTriN12ellhtl+VIMKSvS7LugDdau8e0xzEFexphRlwfGuCFIFdvKvB1BOIqSw5EZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WfqSoM7t; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fc14af3fbso6647430a12.3
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 07:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154972; x=1759759772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWICciJCc2GVtLybkgatiELu642Kp+aREm8IDje95mw=;
        b=WfqSoM7tPDxS0vOzMrjxrFY920kToicROrJZaqag1+A9W/TmCcE7KtpaIS6tyKBYH6
         1z3p1IP6xeB+mp4oSLraDifsNRsPjz0Xl2npZjX8IH6LlfXgQ3PBZjl+K26g/hw+ErOI
         6Bd4BAbF27q5dZlLi1VJqSwsW9jSShPhECQQjce+R3xCW8W7neqNJ9c3rDCeWyhlNkdU
         Ou1/vqvHsFtmg+OrYI+SNQZMTiDxgWMrGsrVwssJH2/pJRbKe5dRidjnso71jUA29Cn1
         uKoW63MjD1Z18+0o+Wd/C2B/dNQTUS0sPMW+NzYKevnzIOYlJLe/gXWVb2yvzcvT2P3E
         JcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154972; x=1759759772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWICciJCc2GVtLybkgatiELu642Kp+aREm8IDje95mw=;
        b=DKNAZBdVhK5xK201dpbmf2aIUxRfroJFS4hpeZDDnBFzoJ9leQeOpvHeB/4b/danhT
         GqBwCmfYxOMb1CYB0wWcasf4aHbrCsIWitvticmAL74YLRoKCI4t1bOJwz41TIp9MovF
         JZpw0hSGz2e57vuPDlimFJMqfDa9ZfkayWYS+2eIEOVvptVuiwz/yfIwhgY1yALC290K
         IE5F2+ZXOnZX22mzC6Lunuhy19NfXVANhxn/3EPv/kltD6PyvoAmZdBZhYcX0pRMlPtF
         tj9Sne5PbcfEnwp+/7n+E8TgPb3JM3THE9NzPRQ425fb3g9+B9MjwabbPyCjMPC5Tbbq
         bjVg==
X-Gm-Message-State: AOJu0Yz15S4j1m+zH5aExNHnjO9NBzCO4zM0gn2nue3I8JNCNutkbRua
	U7ZHU5VrV1mp8e2g0bwurYKPPbik0FDrMMn1XhRpVcxBlgDKlKmSZEznLjF8iPwNWWE=
X-Gm-Gg: ASbGncutxLqvZq0hc9Vdf7UrBGcN6lljMtYEqzsfvex3TsDNXS6fds/lsCa+RpHEMWP
	8I4W9RY9C+NeZoTyDypEXPCkXmXIu7ZikmDXOC1j1XWYJPF4/s/DA0AiJjGO+UU5gFKkAZf+h71
	F1osnnK7bjOxrPuCf+7Zb0lFYaveTP1u9Z6Gi9m+gL2djfbaHOsnLrN1BZXy6IHVLUcG/A6lQ7t
	Pyjlds9RDFAHS4BKHn2pZwctBoS029ZifvhoMK7aJUEcsqDKqqaw1oL3g9kDy/0wSpelEV2Dbc3
	9ixsZtu5J699bIUryGJzmOLFdUd3zVDwamPZ+UIrbcD1CmxKMwA6lzHpd5DMpJmzdL5XdP3hIET
	UpDKyXoPRvFSugFWCh/G465EauuZqcEDcaM+noIcvRhrFZnTcVUEJowMV0nO6Z6eywNHU3mVUdC
	lrM/FdPA==
X-Google-Smtp-Source: AGHT+IG/0nem7TlMMXBZgEjvTZSXPTMFOfrgWOH2FBs+3SNRi6CLU7oYRSoBXIqV9xTIw2UZW9XefA==
X-Received: by 2002:a17:907:9447:b0:b2d:28fd:c6bd with SMTP id a640c23a62f3a-b34ba450e21mr1723632266b.36.1759154972455;
        Mon, 29 Sep 2025 07:09:32 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f945d90adsm149317066b.87.2025.09.29.07.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:31 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:13 +0200
Subject: [PATCH RFC bpf-next 8/9] bpf: Make bpf_skb_change_head helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-8-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Although bpf_skb_change_head() doesn't move packet data after skb_push(),
skb metadata still needs to be relocated. Use the dedicated helper to
handle it.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index c4b18b7fa95e..7a5ee02098dc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3873,6 +3873,7 @@ static const struct bpf_func_proto sk_skb_change_tail_proto = {
 static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 					u64 flags)
 {
+	const u8 meta_len = skb_metadata_len(skb);
 	u32 max_len = BPF_SKB_MAX_LEN;
 	u32 new_len = skb->len + head_room;
 	int ret;
@@ -3881,7 +3882,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		     new_len < skb->len))
 		return -EINVAL;
 
-	ret = skb_cow(skb, head_room);
+	ret = skb_cow(skb, meta_len + head_room);
 	if (likely(!ret)) {
 		/* Idea for this helper is that we currently only
 		 * allow to expand on mac header. This means that
@@ -3893,6 +3894,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		 * for redirection into L2 device.
 		 */
 		__skb_push(skb, head_room);
+		skb_postpush_data_move(skb, head_room, 0);
 		memset(skb->data, 0, head_room);
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);

-- 
2.43.0


