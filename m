Return-Path: <bpf+bounces-61840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F02AEE197
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B4C188E92E
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035A28D8F5;
	Mon, 30 Jun 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RSwe9nu+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733428D836
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295359; cv=none; b=mKCp8Woeiac5SyqLrNVOYQfXTXq7LIB/SjNEJUTsie8kMN9LfTTC4R+eBEY0VPHFlmZdgIWgchxQ4Tq58aa6kD2uGjLnOHDIjmFfiKXMNAl4kUGc4uuBPZniUUS83omwps/u/LPL3MLSwXaubMjh5rOpHq+MoL8j89LepQWbtCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295359; c=relaxed/simple;
	bh=B6hi8UJdS/91tfUz8NPuk7AP1HsaWN7DpiVgT46qJgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b53CdeBfrYg4uPnFD7cZSE08ydtvd8scJqz9f1WyQzPZbmYxL9GBYbGATgtPO5mCHCYOq5UxQCk8y/yYvG7eQBw0cPY00er56uLknnrxNSYwEknJTJwdDeHBAjGB/JHB+DXadK555DK1abJFjwB72q0ugNRTXwhfZOYNHaZBIY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RSwe9nu+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so3825769a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295355; x=1751900155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlIbe9mz1zIjrLBHTd1sB7RGqdyUqcPSFiaIgYjy3cE=;
        b=RSwe9nu+himGyyN2nE1rfLlC3P/7XDs0AQ5DLJx4nWWQPy53bENq7ardocuLuU14xx
         6HMWKhb1bDxcpMMS/Te0gHt/RPIipaT8DEFoFG1weAPjsb182NFEEraHTzwxTzEsHGyZ
         KVxXGWqYeMhpEhAk1cgYlEE6TmlYcuwed6E+W2MRVc/GYz8cl6m7pEPZsLl/KP3iRO+v
         kCxVIOoSgTUAEFdxLX1JXTJLPN7dlxNy9MC5fhqppQZNk7q77wswNxrAmcgtrNwzRAdb
         eoykRb1OL9Gto/bKMXBX5mspo5vF0Zv1MN89cnQUNEiYGfGzh8JM/pEkIA1Z5uG/dLJI
         +lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295355; x=1751900155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlIbe9mz1zIjrLBHTd1sB7RGqdyUqcPSFiaIgYjy3cE=;
        b=iH398ImlTG/Ys0vaQQ7yQ5Y5JJXMqlSQABFHi8zzY1d1r6QIgAdV3X7X74lX1GkAPE
         W/xtqWxl6fwerIC7OCbQKRYbg6KPoKbGy2y4NotM7xzsRXPViAVumgOO8cbItq+93DzH
         ZnLtFrwuNhhz0HsOKtA8ge8Ys8NwMvQNlKMjxWSjQE0aje/eiw15tcW0ezjAMtC/t+sn
         Nv9W1PrU7FZdjLtZ4NjduEw3CAc3CXWcL6g/bF79/eWHElCI4cJGQq3iZyjcKXQgHO74
         cFdnT1Qinjm9ZcjIYXXSxdwvU1Lxr5eWtSkP5DHPxObTNFUV4fMFXkceJ4NPoqqMGeLf
         248g==
X-Gm-Message-State: AOJu0YwW+1WBXd4JrdL79TSXJj5Sx9Fd/8a7sbkDUJU3CBlD54o2BYQB
	wGtDVQ73CsDeLfZ7qgoLcMq+Bp0e9lton4N9boQq0CKQCJgz1FPqJZdtmzVJVgePSAQ=
X-Gm-Gg: ASbGncuwBBGzZDfc3K50a6qMokWaLiWTEKQGeVb6rfydj0OAf/k+Nx5+EiX+EVRF08P
	fsolbB3iAALeUh3BpFnABsOhdZHTEYT1wI3rKi4YAel/+jSOhqL/hzifVftI+LeIlpqHzfAxykw
	8jJejc7P0mvt1WXCS10eh6Sd1pr01aaVTCctQHIRiVIHOI6xpshXGlZle7Uk//nKIXR8cJnuqfT
	Av9jcHRy/DHgWnqiQDkpSthnyM2CQKjeXppu/vh1uKnTyDP8oO/NJp+AYtkn3DH4ZIUF9uv2tNw
	a7JOhEctlS4Z0k8iMKEQWvMkmd03xI/4aseFGN4r++0zdSsEmiLSaYO8ROghrvEn
X-Google-Smtp-Source: AGHT+IGeTBkUosZLoytxs0Tfq8MMSuUcoZgSqN31sdajHJBhMa7RSu3whCiHKouayHo91pdYvwA7+g==
X-Received: by 2002:a05:6402:26d2:b0:609:9115:60f8 with SMTP id 4fb4d7f45d1cf-60c88e72fd3mr10798142a12.21.1751295355384;
        Mon, 30 Jun 2025 07:55:55 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828bbd29sm6038576a12.16.2025.06.30.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:55:54 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:36 +0200
Subject: [PATCH bpf-next 03/13] bpf: Add new variant of skb dynptr for the
 metadata area
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-3-f17da13625d8@cloudflare.com>
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

Add a new flag for the bpf_dynptr_from_skb helper to let users to create
dynptrs to skb metadata area. Access paths are stubbed out. Implemented by
the following changes.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/uapi/linux/bpf.h |  9 ++++++++
 net/core/filter.c        | 60 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 719ba230032f..ab5730d2fb29 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7591,4 +7591,13 @@ enum bpf_kfunc_flags {
 	BPF_F_PAD_ZEROS = (1ULL << 0),
 };
 
+/**
+ * enum bpf_dynptr_from_skb_flags - Flags for bpf_dynptr_from_skb()
+ *
+ * @BPF_DYNPTR_F_SKB_METADATA: Create dynptr to the SKB metadata area
+ */
+enum bpf_dynptr_from_skb_flags {
+	BPF_DYNPTR_F_SKB_METADATA = (1ULL << 0),
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/net/core/filter.c b/net/core/filter.c
index 1fee51b72220..3c2948517838 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11967,12 +11967,27 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return func;
 }
 
+enum skb_dynptr_offset {
+	SKB_DYNPTR_METADATA	= -1,
+	SKB_DYNPTR_PAYLOAD	= 0,
+};
+
 int bpf_dynptr_skb_read(const struct bpf_dynptr_kern *src, u32 offset,
 			void *dst, u32 len)
 {
 	const struct sk_buff *skb = src->data;
 
-	return ____bpf_skb_load_bytes(skb, offset, dst, len);
+	switch (src->offset) {
+	case SKB_DYNPTR_PAYLOAD:
+		return ____bpf_skb_load_bytes(skb, offset, dst, len);
+
+	case SKB_DYNPTR_METADATA:
+		return -EOPNOTSUPP; /* not implemented */
+
+	default:
+		WARN_ONCE(true, "%s: unknown skb dynptr offset %d\n", __func__, src->offset);
+		return -EFAULT;
+	}
 }
 
 int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst, u32 offset,
@@ -11980,7 +11995,17 @@ int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst, u32 offset,
 {
 	struct sk_buff *skb = dst->data;
 
-	return ____bpf_skb_store_bytes(skb, offset, src, len, flags);
+	switch (dst->offset) {
+	case SKB_DYNPTR_PAYLOAD:
+		return ____bpf_skb_store_bytes(skb, offset, src, len, flags);
+
+	case SKB_DYNPTR_METADATA:
+		return -EOPNOTSUPP; /* not implemented */
+
+	default:
+		WARN_ONCE(true, "%s: unknown skb dynptr offset %d\n", __func__, dst->offset);
+		return -EFAULT;
+	}
 }
 
 void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
@@ -11988,10 +12013,20 @@ void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
 {
 	const struct sk_buff *skb = ptr->data;
 
-	if (buf)
-		return skb_header_pointer(skb, offset, len, buf);
-	else
-		return skb_pointer_if_linear(skb, offset, len);
+	switch (ptr->offset) {
+	case SKB_DYNPTR_PAYLOAD:
+		if (buf)
+			return skb_header_pointer(skb, offset, len, buf);
+		else
+			return skb_pointer_if_linear(skb, offset, len);
+
+	case SKB_DYNPTR_METADATA:
+		return NULL;	/* not implemented */
+
+	default:
+		WARN_ONCE(true, "%s: unknown skb dynptr offset %d\n", __func__, ptr->offset);
+		return NULL;
+	}
 }
 
 __bpf_kfunc_start_defs();
@@ -12000,13 +12035,22 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
 	struct sk_buff *skb = (struct sk_buff *)s;
+	u32 offset, size;
 
-	if (flags) {
+	if (unlikely(flags & ~BPF_DYNPTR_F_SKB_METADATA)) {
 		bpf_dynptr_set_null(ptr);
 		return -EINVAL;
 	}
 
-	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB, 0, skb->len);
+	if (flags & BPF_DYNPTR_F_SKB_METADATA) {
+		offset = SKB_DYNPTR_METADATA;
+		size = skb_metadata_len(skb);
+	} else {
+		offset = SKB_DYNPTR_PAYLOAD;
+		size = skb->len;
+	}
+
+	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB, offset, size);
 
 	return 0;
 }

-- 
2.43.0


