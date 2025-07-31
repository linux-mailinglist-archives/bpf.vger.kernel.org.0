Return-Path: <bpf+bounces-64793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B60B16F80
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B123B2D37
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C12BE646;
	Thu, 31 Jul 2025 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KelEmCSq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FD2BE048
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957717; cv=none; b=Y1Kozi+sVZFyOyabllqhn+icqnlEZV9SepXrggNAzr98zUE5Q1pawcQqOpIs0j3AbK4W9Fe/D+5SsAo8025mh7CXHbF4JTrTjmdN7vw5sXN+abgIphIm6jgYHB+AqzeZVPnD0+oDAkaHi1nW4WEDD39WOkcLekNsBPzwr848K9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957717; c=relaxed/simple;
	bh=C0nWPBcyVyyoxirr17JlAIET/vgQM8uG1TRh8EzFXRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Psmi3PuD8M4WkX91nGGSdFMpy96ItYiBkJlAVK8VCkZ+hVIBtELCYDjRHqMBdFauhfhX6Se2Ia3slMrUyGCItfdG1rCj/QuRZYifOuk7AzHgLwYfgIpjmRx3AFK1ypk76xx58Forp+9kAZdacuQQ9Go9GBbd5GmXv7tpDzj2x10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KelEmCSq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae9c2754a00so175534766b.2
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753957712; x=1754562512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0zqkfLoX7capkZEw15TKQWc3rViwjD6/4Ouiadei+c=;
        b=KelEmCSq74S/U6RGlMWkz9YjLmdhDTjQwieuPyxthAgAfBBBjP/gz2pQtt2qrJCSL/
         Z35skLcQFT9z+4qwrI2UfgeOSQR3CaKu958GWWg5GYFFoFTp3bXm4uHcuIYvwCFCLwBI
         8ugR6AV29rxhzJKwPwkt9MI5K8HuEm3ewWRHHmpmYb37sI4P6Y2rQ/XocehMn4DrZ8HZ
         yl372vOCjJckOSqhULTap3Pa5TcWiXIRHaQkW5ociDI44biq9mk/BA1jXQG19bcTAdDX
         XPDuGtcfjt/0HY09NGhL/j4D4QnZlGSxWyFIOry+GzT8WFPQS27ENpa1ul9FXSBOcJxg
         ZV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957712; x=1754562512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0zqkfLoX7capkZEw15TKQWc3rViwjD6/4Ouiadei+c=;
        b=YuU+Dssadb7RLOK/pODfiNJiQCocRL6UusSz2gPzUkkEEwU4aKLPZhO64xc9/96fuH
         K8XxeYRsr8UCc7gmmSBoKRCx26iKuybkFiBpldtxcD2Z1HYL9iccDVfiNKi/rah7pQI5
         En8qmI5XxNd11XQDqF/zU2vD2pgO1rSlUfLO50cinxA9qEucho9mRvVK9k8tnUyjoUCu
         LPn2YWYBdQT7J0z8raDxDE7/RMP3JEYLQmkkKSupE5bUv5GcJoP7+GMwHhm5MrbD/b8X
         BBR5j/z5Q8HZXGmXBrCCWMCq3kEGxwBzHE6NSbl5dZ0mmBKLgwwh66QQ8MpYKf5IZFNb
         AxBw==
X-Gm-Message-State: AOJu0YxMPTL0BUVTfOSFsF3pmyEJiQTvXsVjJpKmAqMl9eVJD8ARwsfE
	DpgILwjkaTh9xMa88ih+DXzKEPgBM3hIBHu5CwEkzzQzgL6fOA2zesvIV04kEUzL3no=
X-Gm-Gg: ASbGncsz8pFjnp13jyfNEaFEzCMDHeiNTazKBYNQ9tIi8OnVnHYv0JJcVhUDRwX5NTO
	C7gumreF7Rc/9UUbEUGIoF6KU5VLoAwfF0hCsUZN9y6dCXaZ2aUeskuizSIIA9iq1kBUuPIkj7p
	A7yw/acbRUr7gfjcagQzbkPHKAyWP6eNuhW8rOU9wgSY61bUVbAku7GWMY1Qpm/NHBUoIRnNsRB
	I4tqaaSjFEgBgVyC5Kii6Zq0TsO28X1LPXT4xjrZMiHlyNS8CcCIJHowuNdEQTTuSR6X2ijhrIL
	7BBvJru2BFe6lzk8/eyKMknrfO2Ge6JwQh6r7Rdg2pSquZsCWGm79s4+hKCEAhmIXkRmkAhY/v9
	e7pUqNHW5ddufZho=
X-Google-Smtp-Source: AGHT+IHQM5S0LVHfzZv95YQxNCt1B2LqFcUe95RV/s8iyNLJt83oeWzaOZ4JBjtlX2t/z/9IlQg9Pw==
X-Received: by 2002:a17:907:60c8:b0:ae0:e065:ddfb with SMTP id a640c23a62f3a-af8fd72967dmr857294566b.18.1753957712338;
        Thu, 31 Jul 2025 03:28:32 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c044sm88168266b.105.2025.07.31.03.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:28:31 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 31 Jul 2025 12:28:15 +0200
Subject: [PATCH bpf-next v5 1/9] bpf: Add dynptr type for skb metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-skb-metadata-thru-dynptr-v5-1-f02f6b5688dc@cloudflare.com>
References: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
In-Reply-To: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
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

Add a dynptr type, similar to skb dynptr, but for the skb metadata access.

The dynptr provides an alternative to __sk_buff->data_meta for accessing
the custom metadata area allocated using the bpf_xdp_adjust_meta() helper.

More importantly, it abstracts away the fact where the storage for the
custom metadata lives, which opens up the way to persist the metadata by
relocating it as the skb travels through the network stack layers.

Writes to skb metadata invalidate any existing skb payload and metadata
slices. While this is more restrictive that needed at the moment, it leaves
the door open to reallocating the metadata on writes, and should be only a
minor inconvenience to the users.

Only the program types which can access __sk_buff->data_meta today are
allowed to create a dynptr for skb metadata at the moment. We need to
modify the network stack to persist the metadata across layers before
opening up access to other BPF hooks.

Once more BPF hooks gain access to skb_meta dynptr, we will also need to
add a read-only variant of the helper similar to
bpf_dynptr_from_skb_rdonly.

skb_meta dynptr ops are stubbed out and implemented by subsequent changes.

Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h   |  7 ++++++-
 kernel/bpf/helpers.c  |  7 +++++++
 kernel/bpf/log.c      |  2 ++
 kernel/bpf/verifier.c | 15 +++++++++++++--
 net/core/filter.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f9cd2164ed23..49ddcf17fb4c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -749,12 +749,15 @@ enum bpf_type_flag {
 	 */
 	MEM_WRITE		= BIT(18 + BPF_BASE_TYPE_BITS),
 
+	/* DYNPTR points to skb_metadata_end()-skb_metadata_len() */
+	DYNPTR_TYPE_SKB_META	= BIT(19 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
 
 #define DYNPTR_TYPE_FLAG_MASK	(DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF | DYNPTR_TYPE_SKB \
-				 | DYNPTR_TYPE_XDP)
+				 | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META)
 
 /* Max number of base types. */
 #define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
@@ -1348,6 +1351,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_SKB,
 	/* Underlying data is a xdp_buff */
 	BPF_DYNPTR_TYPE_XDP,
+	/* Points to skb_metadata_end()-skb_metadata_len() */
+	BPF_DYNPTR_TYPE_SKB_META,
 };
 
 int bpf_dynptr_check_size(u32 size);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b4877e85a68..9552b32208c5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1780,6 +1780,8 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 		return __bpf_skb_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return -EOPNOTSUPP; /* not implemented */
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1836,6 +1838,8 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 		if (flags)
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return -EOPNOTSUPP; /* not implemented */
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1882,6 +1886,7 @@ BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u32, offset, u3
 		return (unsigned long)(ptr->data + ptr->offset + offset);
 	case BPF_DYNPTR_TYPE_SKB:
 	case BPF_DYNPTR_TYPE_XDP:
+	case BPF_DYNPTR_TYPE_SKB_META:
 		/* skb and xdp dynptrs should use bpf_dynptr_slice / bpf_dynptr_slice_rdwr */
 		return 0;
 	default:
@@ -2710,6 +2715,8 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__opt, len, false);
 		return buffer__opt;
 	}
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return NULL; /* not implemented */
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 38050f4ee400..e4983c1303e7 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -498,6 +498,8 @@ const char *dynptr_type_str(enum bpf_dynptr_type type)
 		return "skb";
 	case BPF_DYNPTR_TYPE_XDP:
 		return "xdp";
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return "skb_meta";
 	case BPF_DYNPTR_TYPE_INVALID:
 		return "<invalid>";
 	default:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 399f03e62508..7bc62ff63c1c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -674,6 +674,8 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_type)
 		return BPF_DYNPTR_TYPE_SKB;
 	case DYNPTR_TYPE_XDP:
 		return BPF_DYNPTR_TYPE_XDP;
+	case DYNPTR_TYPE_SKB_META:
+		return BPF_DYNPTR_TYPE_SKB_META;
 	default:
 		return BPF_DYNPTR_TYPE_INVALID;
 	}
@@ -690,6 +692,8 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 		return DYNPTR_TYPE_SKB;
 	case BPF_DYNPTR_TYPE_XDP:
 		return DYNPTR_TYPE_XDP;
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return DYNPTR_TYPE_SKB_META;
 	default:
 		return 0;
 	}
@@ -2274,7 +2278,8 @@ static bool reg_is_pkt_pointer_any(const struct bpf_reg_state *reg)
 static bool reg_is_dynptr_slice_pkt(const struct bpf_reg_state *reg)
 {
 	return base_type(reg->type) == PTR_TO_MEM &&
-		(reg->type & DYNPTR_TYPE_SKB || reg->type & DYNPTR_TYPE_XDP);
+	       (reg->type &
+		(DYNPTR_TYPE_SKB | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META));
 }
 
 /* Unmodified PTR_TO_PACKET[_META,_END] register from ctx access. */
@@ -11641,7 +11646,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
 			return -EFAULT;
 
-		if (dynptr_type == BPF_DYNPTR_TYPE_SKB)
+		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
+		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
 			/* this will trigger clear_all_pkt_pointers(), which will
 			 * invalidate all dynptr slices associated with the skb
 			 */
@@ -12228,6 +12234,7 @@ enum special_kfunc_type {
 	KF_bpf_rbtree_right,
 	KF_bpf_dynptr_from_skb,
 	KF_bpf_dynptr_from_xdp,
+	KF_bpf_dynptr_from_skb_meta,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
@@ -12277,9 +12284,11 @@ BTF_ID(func, bpf_rbtree_right)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
+BTF_ID(func, bpf_dynptr_from_skb_meta)
 #else
 BTF_ID_UNUSED
 BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
@@ -13253,6 +13262,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
+				dynptr_arg_type |= DYNPTR_TYPE_SKB_META;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
 				enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
diff --git a/net/core/filter.c b/net/core/filter.c
index c09a85c17496..83df346b474e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12004,6 +12004,36 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 	return 0;
 }
 
+/**
+ * bpf_dynptr_from_skb_meta() - Initialize a dynptr to the skb metadata area.
+ * @skb_: socket buffer carrying the metadata
+ * @flags: future use, must be zero
+ * @ptr__uninit: dynptr to initialize
+ *
+ * Set up a dynptr for access to the metadata area earlier allocated from the
+ * XDP context with bpf_xdp_adjust_meta(). Serves as an alternative to
+ * &__sk_buff->data_meta.
+ *
+ * Return:
+ * * %0         - dynptr ready to use
+ * * %-EINVAL   - invalid flags, dynptr set to null
+ */
+__bpf_kfunc int bpf_dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
+					 struct bpf_dynptr *ptr__uninit)
+{
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
+	struct sk_buff *skb = (struct sk_buff *)skb_;
+
+	if (flags) {
+		bpf_dynptr_set_null(ptr);
+		return -EINVAL;
+	}
+
+	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_META, 0, skb_metadata_len(skb));
+
+	return 0;
+}
+
 __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_md *x, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)
 {
@@ -12178,6 +12208,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
+BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
@@ -12199,6 +12233,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.set = &bpf_kfunc_check_set_skb,
 };
 
+static const struct btf_kfunc_id_set bpf_kfunc_set_skb_meta = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_skb_meta,
+};
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_xdp,
@@ -12234,6 +12273,8 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_meta);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);

-- 
2.43.0


