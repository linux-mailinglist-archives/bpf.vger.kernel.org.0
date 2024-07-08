Return-Path: <bpf+bounces-34083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA2792A4BB
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 16:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E7FB22CBB
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 14:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2C313DB8A;
	Mon,  8 Jul 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNuHDxCT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2921E49D;
	Mon,  8 Jul 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449102; cv=none; b=grpA3ywCiHn5PkDdECkCUFFY4kl10ePq8pP++vt9PvKicAPiLqBk8KDDH+Fu989m4hNV96hxdnsbIlEo0Ia1suhfYC1djtSBuvNQCiTyigKS0A8BhCsIS6OBEHtQiquSuxk41xgD/L+T0bFzJTKoexs+2B1X4O6TFZ/uzs7hBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449102; c=relaxed/simple;
	bh=kMrshSTmecURhMbKKK8nqMHHvXdCCxbmVjYBrZd92/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fyq1ijAjJ3SsanHq8OJn1evcJkT+N94GliLoT8R3eMitLEHUpaPPLAxCUwhCviqfxhRRjhh/y/UEyaBm3iuil86OGG9Vmjk6XzSG22zbBPOtrrWe7+paSFxHMFcimEe3x9T/y71qMbZNTC+eSxDJyWQjgvV/Hgyq0pqS/FQ5dhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNuHDxCT; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1fafc9e07f8so28371125ad.0;
        Mon, 08 Jul 2024 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720449100; x=1721053900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z5ePQJB5dOQGJQCphJ1+uf0wfSAbQJ0SNQqkQJeuxI=;
        b=NNuHDxCTkraHPrUVcg9bKhpjF2Nf+3ZnTb8oWxb66nkIoU+o8WqiHEN6ywp92XfuRt
         RcCvZg6FCPZSk0Oij6QyQShm9S+257XAv79GXC293gW1uFzLaCoLq3lio78MHAt20pyE
         pKoJI5RttPE9Ig4GZWjbCf15QZMpdCNp7lmyoN+1oXSaHrFbd5+cAc8PwXuIfpqr7iNu
         VGRUB9UvARe2W/5+2AIVI5N9GhzG37GmQ25JFY2rWc1ar1UzRGnQ1JPpWwkPwy9N8uj5
         rUuQO8uRqgSFWaRr4T6tXLuOjLeTAuQUZx4r/6Zoh3FIpy2G1ViyUgM7pl0q8Xis6khc
         0IiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449100; x=1721053900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z5ePQJB5dOQGJQCphJ1+uf0wfSAbQJ0SNQqkQJeuxI=;
        b=gRyu+mYwwjH2BF6u/IEvjq1IZDrdn+2izKl43ZWWrXnj+o74dmu4cz3+bV6s0PdcSg
         GtRMv6SvS74Ib2/S/NJcJJCkCuk1R9KIAd9ADgXm70T72+PNtGHL55hF/PwJVuFQ/FUM
         5fJH4/WB5PJLh+7dGKErLvJQ9eOh5Q1HEXroWTClbiojCzA4zuDJRkhEYbbsEapdhAQq
         7v/nvvGLgpJNp1cORjmSG6GU1ooIj6Iua6xfHfr4z8c0ToHA5/ip6bh+SKWXJwsCmqFF
         KrOeX9gV1pkf+1T5zft+Kp/BGs2dsr8wuv5RCenY2PU+3oCOyHdKeTKDPr282Ir38e/3
         8E3g==
X-Forwarded-Encrypted: i=1; AJvYcCVLDXZyS9AVenD4VxAXw6ebYikVfHTfDDObOK528qKli/rqFDLpoqOPLdFgwgG91dQ6V/9UcN7MJbku3lCEI6DturUcEoRn8l6weJPPdczVTbse+bdkxqkJOZ02XoWauqxYm79lFJteZM6oV/kXR1VisDrdKZPmWNGz
X-Gm-Message-State: AOJu0Yy6LE/ZCrSKtNxrvxJk5isKVpKtsxEOWBWS2HQq1abx9hq6/JtM
	YHyg6vMxj1TWJhJUYE9iP78nwx6JVrWIWBsQpYPISj5i/qV2tW4h
X-Google-Smtp-Source: AGHT+IHP4QzAFCeP/vVvj4DDRWwEV4DH0pf8dJlcvV4O7jZzKiPKQ52DkeI7YSmRUpt5sE8ZqXgQWw==
X-Received: by 2002:a17:902:ea02:b0:1fb:5c54:36c8 with SMTP id d9443c01a7336-1fb5c543ac1mr85586715ad.50.1720449100327;
        Mon, 08 Jul 2024 07:31:40 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:ecac:5335:e70e:6fe7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb77e9f378sm33597645ad.271.2024.07.08.07.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:31:39 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: willemdebruijn.kernel@gmail.com
Cc: aleksander.lobakin@intel.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	dracodingfly@gmail.com,
	edumazet@google.com,
	haoluo@google.com,
	hawk@kernel.org,
	herbert@gondor.apana.org.au,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net,
	martin.lau@linux.dev,
	mkhalfella@purestorage.com,
	nbd@nbd.name,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashal@kernel.org,
	sdf@google.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH] net: linearizing skb when downgrade gso_size
Date: Mon,  8 Jul 2024 22:31:28 +0800
Message-Id: <20240708143128.49949-1-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
References: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a patch that linearizing skb when downgrade
gso_size and sg should disabled, If there are no issues,
I will submit a formal patch shortly.

Signed-off-by: Fred Li <dracodingfly@gmail.com>
---
 include/linux/skbuff.h | 22 ++++++++++++++++++++++
 net/core/filter.c      | 16 ++++++++++++----
 net/core/skbuff.c      | 19 ++-----------------
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5f11f9873341..99b7fc1e826a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2400,6 +2400,28 @@ static inline unsigned int skb_headlen(const struct sk_buff *skb)
 	return skb->len - skb->data_len;
 }
 
+static inline bool skb_is_nonsg(const struct sk_buff *skb)
+{
+	struct sk_buff *list_skb = skb_shinfo(skb)->frag_list;
+	struct sk_buff *check_skb;
+	for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
+		if (skb_headlen(check_skb) && !check_skb->head_frag) {
+			/* gso_size is untrusted, and we have a frag_list with
+                         * a linear non head_frag item.
+                         *
+                         * If head_skb's headlen does not fit requested gso_size,
+                         * it means that the frag_list members do NOT terminate
+                         * on exact gso_size boundaries. Hence we cannot perform
+                         * skb_frag_t page sharing. Therefore we must fallback to
+                         * copying the frag_list skbs; we do so by disabling SG.
+                         */
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static inline unsigned int __skb_pagelen(const struct sk_buff *skb)
 {
 	unsigned int i, len = 0;
diff --git a/net/core/filter.c b/net/core/filter.c
index df4578219e82..c0e6e7f28635 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3525,13 +3525,21 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		/* Due to header grow, MSS needs to be downgraded. */
-		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
-			skb_decrease_gso_size(shinfo, len_diff);
-
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |= gso_type;
 		shinfo->gso_segs = 0;
+
+		/* Due to header grow, MSS needs to be downgraded.
+		 * There is BUG_ON When segment the frag_list with
+		 * head_frag true so linearize skb after downgrade
+		 * the MSS.
+		 */
+		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
+			skb_decrease_gso_size(shinfo, len_diff);
+			if (skb_is_nonsg(skb))
+				return skb_linearize(skb) ? : 0;
+		}
+
 	}
 
 	return 0;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b1dab1b071fc..81e018185527 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4458,23 +4458,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
 	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
-		struct sk_buff *check_skb;
-
-		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
-			if (skb_headlen(check_skb) && !check_skb->head_frag) {
-				/* gso_size is untrusted, and we have a frag_list with
-				 * a linear non head_frag item.
-				 *
-				 * If head_skb's headlen does not fit requested gso_size,
-				 * it means that the frag_list members do NOT terminate
-				 * on exact gso_size boundaries. Hence we cannot perform
-				 * skb_frag_t page sharing. Therefore we must fallback to
-				 * copying the frag_list skbs; we do so by disabling SG.
-				 */
-				features &= ~NETIF_F_SG;
-				break;
-			}
-		}
+		if (skb_is_nonsg(head_skb))
+			features &= ~NETIF_F_SG;
 	}
 
 	__skb_push(head_skb, doffset);
-- 
2.33.0


