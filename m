Return-Path: <bpf+bounces-63901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C46B0C1C1
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 12:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29424179B23
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183529291F;
	Mon, 21 Jul 2025 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T7EPI8K2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9B21A457
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095211; cv=none; b=JYn6WtUP5Wa1cmiVPzUnJnSJnOYWn5fcbjdagXr34oCIRL4ihDlmdNKzhjZUaQklUON+Sl2CBd9oFtO8u/y+Hz4rDOgIHoNP3UFKB8S3i/EuGyJe2piOONfBr7eqowW4sJCSSzwk1l9rBxpQ84lSzMwEh2MXC5E8cYvAUO7BQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095211; c=relaxed/simple;
	bh=EKVi1B3hsRotODsWoGkxDTX90Rkv3IWwN+P0v/vZVnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLmHLFxLCBafSX8DFy3PRxhox8s8tGLHpdjveW3EldfHFyQTGp8GEYkeuZn+R0yvCM+5zm4K2BFqzdSyLrOXfoPycCVkGYVMP9nrRs5YITm2JI4/McHKK1kEN9KFafI87wFo+aNJLEeuvUrjsvtttWjG0OLYy+X8wb4mK4H8Z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T7EPI8K2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aef575ad59eso124438366b.2
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095208; x=1753700008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Mcg0TVj8ngK79VTI2Bs4Da/ye+s62cZ/CuyUgnB6vM=;
        b=T7EPI8K2uYRtjNphog1stCv0NOeu/qgxjuiIyQP7B20cUEh+j1sF9UruU37cgQCBGB
         eCjVRnecWOZV8vcXip5qTsC5l9wstVtFlj3M9Gbwyv3c6VcBHkf0qwUJ8vgVN7QQV0+c
         yKqHm7ByGmgDwkPGffJlwDeyWXwJLv0TG3qpU2NeJS3nRO5pKR0NYVJhvu8owCofvBov
         4jo0cUY1yIfaPl0dIysUPnU1Tsj/48pFzHXK8vR+MOYO2eSJIOzeIj0OurH299/3D3fi
         hFvm17E223gEgEr634Yw9zX0YqGhJkn6dzHRoFZq5RaF45ah/RgBjR/6JXzgaR5IPqni
         orCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095208; x=1753700008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Mcg0TVj8ngK79VTI2Bs4Da/ye+s62cZ/CuyUgnB6vM=;
        b=e08rsF5x7YlfOCFrRHPXIVnLeZh0KB2ukPCe+5b+fhXGp1nSnxDmZYPwRlL+KU6qWo
         kOsobgajHAty0u+9Koih8PEjhw/8KRiPXvHRI2f/MeRXnbya8HTpNV9dRBWrZrWAi+3/
         ux9pDfZIozfEYK5368XoRBEGA6tmyEqMzD8158JHfx3lrh6pkjfpuWJlv1C5t0SPyqVB
         0UrkcPesfrdiA5gvJOPwsM1d+FinjCWI9ut32L8D5Ra9BBjBSZBoMdZ5Mlj1v5b5VOez
         UL4V5KfI2RmUgzmCQi1yTTnUoAxy866vpePHiME3Z3GbaIYfaMM99hxCPiZKxJ8bedNp
         1s+g==
X-Gm-Message-State: AOJu0Yyvr+o/JrAnW5Wt7rEdZKT5lUFMMpl52pdGLwCeVRNGTIBM2GiF
	hlSTcbWWYYIepMc7rEkLAOoN9Fgpv9oLlwJeA88P8CWMyumwUeNoBu68GNFDmNfiGCU=
X-Gm-Gg: ASbGncvSxxlCVSHu7/6eeDRbcksPqf3kHXR59A65yPT7uL/q0GopRPltkoJeT48ztWi
	jNlkqvDlc1+S0PP+hwby3LKMzIi8B82fOAQIo1efh5sVS1rTEXcJnusxsR6YiifgKQ8MsB7RFm+
	A7SQqU6XA4w4TnfoBqIZBJay6EVoOiETiQIjq5ZvYBa9J4emPRdiskCRK6knVURb/BqflBmQZbG
	v9OJ/xuHkofDzcJtFdfeICdTDLD8UYJlg8kGTOj2NsR1t4LPcLCwc44WWKcdM5i/d7T+azReTM4
	WqVasyvS9n0yzh3cypOk+QoL4xcVvviab0XFbg+w3DSFsh51WUdv2qmjFI2SXSDTWOqGMCz0P6I
	Ani5rl+fKeexfbA==
X-Google-Smtp-Source: AGHT+IHU8cbhUbH372jlIjFTbW3xDwcMnrAOKgillcYTDe0KbOG1cWXGC2TNwN1bSrLAt3Woa5wdRA==
X-Received: by 2002:a17:907:7286:b0:ae3:74be:49ab with SMTP id a640c23a62f3a-ae9cddb3a1fmr2121032166b.10.1753095208522;
        Mon, 21 Jul 2025 03:53:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d9941sm657741566b.56.2025.07.21.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:27 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:42 +0200
Subject: [PATCH bpf-next v3 04/10] bpf: Enable read-write access to skb
 metadata with dynptr slice
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-4-e92be5534174@cloudflare.com>
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Make it possible to read from or write to skb metadata area using the
dynptr slices creates with bpf_dynptr_slice() or bpf_dynptr_slice_rdwr().

This prepares ground for access to skb metadata from all BPF hooks
which operate on __sk_buff context.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  6 ++++++
 kernel/bpf/helpers.c   |  2 +-
 net/core/filter.c      | 10 ++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7709e30ce2bb..a28c3a1593c9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1776,6 +1776,7 @@ int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 offset,
 			    void *dst, u32 len);
 int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
 			     const void *src, u32 len);
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset, u32 len);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1822,6 +1823,11 @@ static inline int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset, u32 len)
+{
+	return NULL;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ee057051db94..237fb5f9d625 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2716,7 +2716,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 		return buffer__opt;
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return NULL; /* not implemented */
+		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset, len);
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
diff --git a/net/core/filter.c b/net/core/filter.c
index 3cbadee77492..6d9a462a0042 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12002,6 +12002,16 @@ int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
 	return 0;
 }
 
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset, u32 len)
+{
+	u32 meta_len = skb_metadata_len(skb);
+
+	if (len > meta_len || offset > meta_len - len)
+		return NULL; /* out of bounds */
+
+	return skb_metadata_end(skb) - meta_len + offset;
+}
+
 static int dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
 				struct bpf_dynptr *ptr_, bool rdonly)
 {

-- 
2.43.0


