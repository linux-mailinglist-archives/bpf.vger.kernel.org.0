Return-Path: <bpf+bounces-61839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA89AAEE195
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C0D188E823
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936E228C013;
	Mon, 30 Jun 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ff9BT+ER"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4428B7F8
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295357; cv=none; b=PHJZRL/urcQon9dIQsnkVbPuYywl8hGYcAjnn7unjDPpMOnzAMg3GxKb0SB7cya52v0JdqY8bMyCT9/wpgafWekTwtIEyWf7merbkUimK0CFa4YCF7CBuJ5QHKoGNbJNbTeGCc/fwW/LlZsrp4Boqsu9hH3ZL6NE2fbX/eRXzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295357; c=relaxed/simple;
	bh=DG74tz99+RNpWARxwp3ttOL/CZmpYWPW2sRCH6lQ1wA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSthxw/+jbTdu7efwCkHjITMHSZpRtb/rDdBEDrTqhBb477f+h2sgyYAiLDmwtcedTie07QWgcmYSo9O9glRAlEUyD8o/TKulq+BJB4WVsjzfqpBYtHZ5HOzgGJfFcI5fgvXo2k/U6rVSHNDqVH3PK60k/tlVZlc+OvS2g0L2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ff9BT+ER; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ade5b8aab41so459599966b.0
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295353; x=1751900153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5F1doR37PVkKduT8JVZzI17nbFGqVxF8ogmtMY/QPI=;
        b=ff9BT+ERH8j66ApFoRRJ0oTvNn2cRZWRUIzq2iIOh0HuTwEUDYTmIaR6foaYd9318x
         hOLoUfdXt7wZRjokYyF73bkmoZdlwaNtzER6UjqWjigZbM3mNWG6JG9bEIKz26zu51FO
         HR4wCJrsNzmv0jX8BN3ypAs5EYA35WnVwb1BcmZZaMuJLOr+aVhzANF31O8eH/qAF+4o
         /TDELAdNaWJ4k3qRKJ/zvV5ZNAWvR8oCVZevVogt7+q4oubQUzt088BsaNvzjLfB6P+E
         kTE67SygPKQ6dg9LHnkQ3P8YLIHzs3oZ7xNc6DCM615jD3f4h46K1fw68a4hRa4l0N5r
         F2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295353; x=1751900153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5F1doR37PVkKduT8JVZzI17nbFGqVxF8ogmtMY/QPI=;
        b=W06UrGfLPzof1fROhEpZK3cARvMMxVdpc8DU4X9syhu9EUXzbSfbCDo6pVud6Mh/yl
         A/fFfBnNbYbT4tAKTPIjO6MTRsDmGbfQXvDiv8of3Tp3M/5joe2gswl5ZIK4rC/CpHLV
         X+uIuN0sxs2a2HDMtKiW/xjW9k3tW3y4IzPi0c4c3NouQAEeZ/BYSUyIbYyvdFV3fC5S
         OwGhQgWKX6A+gP3P+bFo7o676itYbUV1cHBR8iB4sV8OJI2XoCvT+88k4Ksajg0qjKP0
         CeaM9qif35bYxymIX1nYLbgVn7hAUsEMZTeK7Jht23jbkwGLslGq+seeYmFErPnb4I4X
         A53A==
X-Gm-Message-State: AOJu0YyJPbVc1aBGrATdrxiPNHPPagXt9AcYQpiGtXxCVDcMe0zoR26I
	1WSZ4Pa5SN1CnatkR6MKU7IgqcoZqIizXQN3G6YuL9eHO85QHX3H0GGmcnwwTgKERmU=
X-Gm-Gg: ASbGncsWH6Akvx9Z5X0XfnIv5Va37TRm4YDtnhMMzz6KDi87AymqBOixOu10IKfwW5h
	czlNpJL+4PnxBarxIMVHF0P3ppogaVWyUEB65arkrN4Yse24Wi5m98IVp7Ykcsjz2uAJIGrJWrK
	GbkpG6D7OJovf1jwhj51SI900s1s3ZOMYNafILSNeR0KOh3fIn+wdtvTzuIhb1G1ZvmtDLVRvL6
	RyyXDBM3q4EM6m8ey7vR2DN/+YMG8hChAX0kB5DZ1/2wM8j2DBD4bgF1u7DWcAQEwvGuWSW6nXq
	AdE2B8EO6wS2o1jEuRT7oVGXJlOgNvwiAcJ9lhjePR6CHRVNd9ErWg==
X-Google-Smtp-Source: AGHT+IGCigiIKnYH1w3IAINizyWPEiDkdM3+rLAOpzIK1wcnKeVCE1XLcSb+89hDFm8KRjB/TeKo+w==
X-Received: by 2002:a17:907:3d8c:b0:adf:f82f:fe0a with SMTP id a640c23a62f3a-ae34fd729f7mr1423832266b.16.1751295353437;
        Mon, 30 Jun 2025 07:55:53 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659ff5sm693860866b.61.2025.06.30.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:55:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:35 +0200
Subject: [PATCH bpf-next 02/13] bpf: Helpers for skb dynptr
 read/write/slice
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8@cloudflare.com>
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Prepare to handle skb dynptrs for accessing the metadata area.

Code move. No observable changes.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h | 25 ++++++++++++++++++-------
 kernel/bpf/helpers.c   |  9 +++------
 net/core/filter.c      | 38 +++++++++++++++++++++++++++-----------
 3 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index eca229752cbe..468d83604241 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1764,27 +1764,38 @@ static __always_inline long __bpf_xdp_redirect_map(struct bpf_map *map, u64 inde
 }
 
 #ifdef CONFIG_NET
-int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to, u32 len);
-int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from,
-			  u32 len, u64 flags);
+int bpf_dynptr_skb_read(const struct bpf_dynptr_kern *src, u32 offset,
+			void *dst, u32 len);
+int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst, u32 offset,
+			 const void *src, u32 len, u64 flags);
+void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
+			   void *buf, u32 len);
 int __bpf_xdp_load_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
 #else /* CONFIG_NET */
-static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
-				       void *to, u32 len)
+static inline int bpf_dynptr_skb_read(const struct bpf_dynptr_kern *src,
+				      u32 offset, void *dst, u32 len)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset,
-					const void *from, u32 len, u64 flags)
+static inline int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst,
+				       u32 offset, const void *src, u32 len,
+				       u64 flags);
 {
 	return -EOPNOTSUPP;
 }
 
+static inline void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr,
+					 u32 offset, void *buf, u32 len);
+
+{
+	return NULL;
+}
+
 static inline int __bpf_xdp_load_bytes(struct xdp_buff *xdp, u32 offset,
 				       void *buf, u32 len)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 40c18b37ab05..da9c6ccd7cd7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1776,7 +1776,7 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 		memmove(dst, src->data + src->offset + offset, len);
 		return 0;
 	case BPF_DYNPTR_TYPE_SKB:
-		return __bpf_skb_load_bytes(src->data, offset, dst, len);
+		return bpf_dynptr_skb_read(src, offset, dst, len);
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
 	default:
@@ -1829,7 +1829,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 		memmove(dst->data + dst->offset + offset, src, len);
 		return 0;
 	case BPF_DYNPTR_TYPE_SKB:
-		return __bpf_skb_store_bytes(dst->data, offset, src, len, flags);
+		return bpf_dynptr_skb_write(dst, offset, src, len, flags);
 	case BPF_DYNPTR_TYPE_XDP:
 		if (flags)
 			return -EINVAL;
@@ -2693,10 +2693,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 	case BPF_DYNPTR_TYPE_RINGBUF:
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
-		if (buffer__opt)
-			return skb_header_pointer(ptr->data, offset, len, buffer__opt);
-		else
-			return skb_pointer_if_linear(ptr->data, offset, len);
+		return bpf_dynptr_skb_slice(ptr, offset, buffer__opt, len);
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
diff --git a/net/core/filter.c b/net/core/filter.c
index 7a72f766aacf..1fee51b72220 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1736,12 +1736,6 @@ static const struct bpf_func_proto bpf_skb_store_bytes_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from,
-			  u32 len, u64 flags)
-{
-	return ____bpf_skb_store_bytes(skb, offset, from, len, flags);
-}
-
 BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buff *, skb, u32, offset,
 	   void *, to, u32, len)
 {
@@ -1772,11 +1766,6 @@ static const struct bpf_func_proto bpf_skb_load_bytes_proto = {
 	.arg4_type	= ARG_CONST_SIZE,
 };
 
-int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to, u32 len)
-{
-	return ____bpf_skb_load_bytes(skb, offset, to, len);
-}
-
 BPF_CALL_4(bpf_flow_dissector_load_bytes,
 	   const struct bpf_flow_dissector *, ctx, u32, offset,
 	   void *, to, u32, len)
@@ -11978,6 +11967,33 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return func;
 }
 
+int bpf_dynptr_skb_read(const struct bpf_dynptr_kern *src, u32 offset,
+			void *dst, u32 len)
+{
+	const struct sk_buff *skb = src->data;
+
+	return ____bpf_skb_load_bytes(skb, offset, dst, len);
+}
+
+int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst, u32 offset,
+			 const void *src, u32 len, u64 flags)
+{
+	struct sk_buff *skb = dst->data;
+
+	return ____bpf_skb_store_bytes(skb, offset, src, len, flags);
+}
+
+void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
+			   void *buf, u32 len)
+{
+	const struct sk_buff *skb = ptr->data;
+
+	if (buf)
+		return skb_header_pointer(skb, offset, len, buf);
+	else
+		return skb_pointer_if_linear(skb, offset, len);
+}
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)

-- 
2.43.0


