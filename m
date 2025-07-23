Return-Path: <bpf+bounces-64195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC38B0F96D
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 19:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867D2179177
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9271423BCF1;
	Wed, 23 Jul 2025 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ys+4YOLq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9A23814C
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292218; cv=none; b=pbP4z/5GgLxMi3zhv7j7sIDzg1z/hDK0uuZVxrXrvyWDpYf4/aDRtLfgv0btZ0CdJCuDsM8ZpOzs1T0yysxVRjXpiAnv626q5YskDcfBfo2kZo6rVCS2MhVOi29AyiIJaLcDyH4T/EE6R+J50UzSxnjWHiwG4thzsywVsShN7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292218; c=relaxed/simple;
	bh=UrcEjAg7GAkkGyQDzwig33nkBHzaiJ8mDJM9SnuShQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwCVLDjpCpwlCBxw+HfYOsa3rh1TLYe991z4DXvUQ9Ow6I2q2laWIYs5Cj673oyOBqmQn3V6R95GOWFzfXgG2oayQVss0tnQ49oBrbcIo+6M/L9kngiT7hwehEEXHciR+xLQVtXxN0vzCn7AzXYDViZ/06F2dmuP8LNHWt+uw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ys+4YOLq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so13936366b.2
        for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753292213; x=1753897013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLwPvI2GvffjhdIVFmDYNGuO77u+LYC11J3gQUdVDAE=;
        b=Ys+4YOLqd1qswoeSDDIpvRdWMWmFM/C0sNMryFEiacpXlFONyFfishqKrj89HQPtEG
         UeDAcn/Vs248SLjBibsHtjj+aD7wr9q/gBECBsxG+tnYIEuhQVznaieAsPzZGeU6XK5w
         aF0+eoeOhY77cluoZJNmVYF3eVbsE79duJm3DvAKHmCCKs5/FjnxyY1x7YV8u1APkIzv
         KSif+vx9pIC3+dUJhOTKxM02mUNkl6EhKjj9RaiuWUQpbQb3y8mXxnAWQICDT9gX6imH
         xxiZTbHiaL7G0Hyjk8wz351oV4c6PMtrUOH/m7rZOPui0yccakFD1+Pm14Y+TUELqkeq
         xDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292213; x=1753897013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLwPvI2GvffjhdIVFmDYNGuO77u+LYC11J3gQUdVDAE=;
        b=T9ZuMt5u7ICyhVvhwWk7xrXRY91x0yAms2Ay+I/OlsncB2wecvF/Ft8AFjihGm4oHK
         AlaHcysPiXlniEikgH6NszRTCS7Tzl8+g6Kg5QH9EMkOqTEJbe7DaFLM9noZKXFbqSRN
         otxtbuQ+Pb2lUiLNJzwyFH9lYKq40dSbKKlfKnjmTzh/t3VIee1DO/xDbIhf46tFRtrN
         hMJE3OI1PEO18d/HgjLCL9VHjTebuHiZwIDWTRHf5sm/JZlueLA25KkogFNrbsmqa4oo
         WbIUnemmz51qjd+QzeEcg7jtYSkfOQNUqBzc0s1XWX+Hd5veJaFBX4Ex7xsciqgEcY5K
         JRBQ==
X-Gm-Message-State: AOJu0YxpIZ+5hmFMENV0w5UhxHz53gftnaFO9hroTJLqyyGZ2+n7fTG+
	xB2jlzKU7e4d83UfhHyrWXwMiZkRamNs2j84sar0XqqDjzHqTMazPKY6esb5yRPH3g0=
X-Gm-Gg: ASbGnctU4InOq/h7Z9SseCxKilCJugQmAw9yVE9bpwDMezYca71lS2vTfDdlbJv7YVU
	OIXDzRTu4+XWTSz9jA4zAt7XAfT/qCocR4cjoVkSjIQDnukjBc0iuKWmHn4eBpyBmlZIidV73UG
	/HPmOyMUEtIEasUHSO9qfBb2fEu3tuupg+G0VWaiIipQRP+tx8fEy822DV/wC+gKTOjheBHLu0/
	sNR6i6YJBByV9RCWqKS5wit2zPW32ghI3ttZYLSpOqbG5SbhlB1u+0QKUNvGcLT8f1FfCzpixCn
	4cRD+bO51puKL9vW+bJvlHOoMMUShVQJn8IWFz2faXhBI3pbfwOPrc2qidAOlqTleoYm+Ys5XaT
	wYZFXQlmmJ9RlSeJfmVfbcCm7H+jCtIRsgmKcHhLhwgY/KufvkLE0AlcOCVrvofs71VgBIlM=
X-Google-Smtp-Source: AGHT+IEKt1szq1AgthAoyHz3xsCLWcLUsOd2yTZiQRB78er7+8JcTBfOEed/FITXGWgXbiSpPnnW0Q==
X-Received: by 2002:a17:907:6e8e:b0:ae8:476c:3b85 with SMTP id a640c23a62f3a-af2f66d4e72mr369058166b.8.1753292212965;
        Wed, 23 Jul 2025 10:36:52 -0700 (PDT)
Received: from cloudflare.com (79.184.149.187.ipv4.supernova.orange.pl. [79.184.149.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af23e1288f2sm266167866b.65.2025.07.23.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:36:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 23 Jul 2025 19:36:47 +0200
Subject: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
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

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h | 18 ++++++++++++++++++
 kernel/bpf/helpers.c   |  6 +++---
 net/core/filter.c      | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index eca229752cbe..d0f39bf6828c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1772,6 +1772,9 @@ int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
+int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 off, void *dst, u32 len);
+int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 off, const void *src, u32 len);
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 off, u32 len);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1806,6 +1809,21 @@ static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, voi
 				    unsigned long len, bool flush)
 {
 }
+
+static inline int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 off, void *dst, u32 len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 off, const void *src, u32 len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 off, u32 len)
+{
+	return NULL;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9552b32208c5..237fb5f9d625 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1781,7 +1781,7 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		return bpf_skb_meta_load_bytes(src->data, src->offset + offset, dst, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1839,7 +1839,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		return bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
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
index 0755dfc0fc2f..cf095897d4c1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11978,6 +11978,45 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return func;
 }
 
+static void *skb_metadata_pointer(const struct sk_buff *skb, u32 off, u32 len)
+{
+	u32 meta_len = skb_metadata_len(skb);
+
+	if (len > meta_len || off > meta_len - len)
+		return ERR_PTR(-E2BIG); /* out of bounds */
+
+	return skb_metadata_end(skb) - meta_len + off;
+}
+
+int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 off, void *dst, u32 len)
+{
+	const void *p = skb_metadata_pointer(src, off, len);
+
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+
+	memmove(dst, p, len);
+	return 0;
+}
+
+int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 off, const void *src, u32 len)
+{
+	void *p = skb_metadata_pointer(dst, off, len);
+
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+
+	memmove(p, src, len);
+	return 0;
+}
+
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 off, u32 len)
+{
+	void *p = skb_metadata_pointer(skb, off, len);
+
+	return IS_ERR(p) ? NULL : p;
+}
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)

-- 
2.43.0


