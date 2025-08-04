Return-Path: <bpf+bounces-64992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1B8B1A262
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE351816FF
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F4C26A1AB;
	Mon,  4 Aug 2025 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RNAF+v3J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51202673A5
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311968; cv=none; b=t40VCqc5c9dvdvB1mXoiC/aK6O44og4WDPLvHyprjKQRlQzuXrWGIria1krBZUfzde4I9G2+UtZf5PCEv68N3m6q9jY+vak6kDT1lot9n3m3/yQH4OKPjkcnvCBf+oHAJwG0kwSup9c08T6uD27JWqLC5MpiUCiAOQJD1XQPo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311968; c=relaxed/simple;
	bh=RXk+qk+s6UQY7yvKq/I4XiJoyR3sBQyLwqHlSsOM5mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YssZrA0byEi3VcP8IjM8tOWdsUaZKXlBCEsDczJjMTDVf3BBpwRKYuyqBfW+mJMyUocBXNEPS9xEFYDh6U4AmgMSC+hx7oaHNLQ+S37tQrhgAzwD3KKKWoEyIZAE7PMGYlDi0LpspZ4t/cyMcKU6rH6ZU3L2/3LB5Rrwv1IykWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RNAF+v3J; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so4267612a12.1
        for <bpf@vger.kernel.org>; Mon, 04 Aug 2025 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311965; x=1754916765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8Dy00T6GZIA8aYOf2PXZe1Qcn9nzk9Nw4gH7seFRug=;
        b=RNAF+v3JdsLlnKGmiR8XZQKyYHarRsB9zdQK7dsbnLUsv4142nmzPDGkqjWVSl61YK
         XU4dwa5Fycj+lkV/3Qayv4zSzGufpdkwSoOKg0XSjK4qeJ8/yCyJy9GiBIUitr59SpWM
         U7efRjVcu0DtM54iMH0XPTQyJwU3w9A7eDMAVOWuSOcbVVjGMqnGZjS4x/hL85zSjNpY
         YmxO/THCyinVabZs9TQPPXMN2MXU7kYq81p+A2GVsGhhG01f79m3J9PAmJMdR+1zzkjS
         8I5Fnf+epjoFPQczIOKL9ZO2+iODYH2Kd79rIYtFRTlWRwT1irQPuZQ3oZtEQYaVUK/D
         aTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311965; x=1754916765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8Dy00T6GZIA8aYOf2PXZe1Qcn9nzk9Nw4gH7seFRug=;
        b=QUKAFpRcm0wO8CR22v+rvLgwQ1lC3aIrj914L8jFSVvr2LGIFfnAMjPL3+Hx5gbcJe
         GLMA/m0MGt36e8l8HTWRIZxtqGYguSGXEnDblUaW3jyMm6wODN1i+PxKRI5wFLggyqx6
         +huYOU0rO+SxxWtBo83Fki0D72EJCErMQep/lULikGZS7ota/vIHX1pDM1eHemP9lBNA
         gazMiHVittBuDVTdaHNmhhzBHb9aGq2BEKElO2c9fs5vKWAsnCExM2mOJnsHijlqkECA
         rR7Tt0UKmZDewCB12zl8dJ8GwR1TpH9DWvpTQT65CkFzFlbxc5eb4P/HBXM5kkgJ0c2o
         PdVg==
X-Gm-Message-State: AOJu0Yx+exs87mz3u+7LKdcrQwoQBiIzHjZRqF1sRg6VYs6jZt3rm4gJ
	7OPDp+Fc0hjEcTJoL8Ot3f+A4vA05Q0nkth+qUqA4s6o6m4mQs1DnkoHn+Zi0Oa+3d0=
X-Gm-Gg: ASbGncviW3Ed7WHX49pD9KydSEEkf0KQTYi8QsKyZJHjJKVvhF6diQaCqme4ba30whJ
	bnG5B3DhtAnx0uT0Hd0tPcDSThWlOwKLiiU/4VC6Yb1yUmO6x4ezEFvBIqjKF3aBV5NiQQMrnUe
	dBV2OTB3FuQGeh7RKR+gPtv3PuwfSXQOoJufLGMYTDqAe0ddRAXE8+lKlLbTr+3+RBpp3sn6DSE
	h665fro1wihQKTb6cDlgrfb9wvlCkLrHWyy7quUqaUWc49w45hKvvrk56ix4pne9hepDjSTVyGa
	2JgQhGlwKoGUWu5YjO9M5M268LhAdEriE/8m/QU8k4VMO3szkuZfwemED902S2jOCUbyuqn/1p/
	nzcQbYCqEvlBbUck=
X-Google-Smtp-Source: AGHT+IHRvUJaAsAhLMBd9JIM1XtV25tSZiYS+aO/f/yjHNY2Rh5ORYvYKxPOzheOSHNUsuaitGjhqw==
X-Received: by 2002:a17:906:478c:b0:ae9:c2b9:7eba with SMTP id a640c23a62f3a-af940044e2dmr877265766b.24.1754311964983;
        Mon, 04 Aug 2025 05:52:44 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0761f2sm731738066b.11.2025.08.04.05.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 04 Aug 2025 14:52:25 +0200
Subject: [PATCH bpf-next v6 2/9] bpf: Enable read/write access to skb
 metadata through a dynptr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-2-05da400bfa4b@cloudflare.com>
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
In-Reply-To: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Now that we can create a dynptr to skb metadata, make reads to the metadata
area possible with bpf_dynptr_read() or through a bpf_dynptr_slice(), and
make writes to the metadata area possible with bpf_dynptr_write() or
through a bpf_dynptr_slice_rdwr().

Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  6 ++++++
 kernel/bpf/helpers.c   | 10 +++++++---
 net/core/filter.c      | 10 ++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1e7fd3ee759e..9ed21b65e2e9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1784,6 +1784,7 @@ int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1818,6 +1819,11 @@ static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, voi
 				    unsigned long len, bool flush)
 {
 }
+
+static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
+{
+	return NULL;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9552b32208c5..cdffd74ddbe6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1781,7 +1781,8 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		memmove(dst, bpf_skb_meta_pointer(src->data, src->offset + offset), len);
+		return 0;
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1839,7 +1840,10 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		if (flags)
+			return -EINVAL;
+		memmove(bpf_skb_meta_pointer(dst->data, dst->offset + offset), src, len);
+		return 0;
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -2716,7 +2720,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 		return buffer__opt;
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return NULL; /* not implemented */
+		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset);
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
diff --git a/net/core/filter.c b/net/core/filter.c
index 83df346b474e..6cce89bef456 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11987,6 +11987,16 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return func;
 }
 
+/**
+ * bpf_skb_meta_pointer() - Gets a mutable pointer within the skb metadata area.
+ * @skb: socket buffer carrying the metadata
+ * @offset: offset into the metadata area, must be <= skb_metadata_len()
+ */
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
+{
+	return skb_metadata_end(skb) - skb_metadata_len(skb) + offset;
+}
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)

-- 
2.43.0


