Return-Path: <bpf+bounces-63898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0A5B0C1BC
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 12:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0152518C219A
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF39A290BCC;
	Mon, 21 Jul 2025 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ROvAK7v0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9BB28C5A4
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095207; cv=none; b=ENFrnq8E3p1P0IN9hG0Z7ZH6bh4TgpApw9+YpWEhl5waVzqxFNfYlhGAbTod+KdA8rXSzy6pL0XhTai/vb344Z5WenEBIVvnYCa8vITRehgeJymQJd6Sqp8n9A4KzU7VBkBKkfl37N8bMjzb2c/EgezSJR0JRfBbu9eCedxW41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095207; c=relaxed/simple;
	bh=Oo4kMVsx7ZooTDymDMAK7H9tMt11YTiAvZEf/x+DgYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShlIOaw3utS6ZqE3cCty6bM8Iw+dYMlD6guMXXy0uSVq45YjD8UqMWsLzx+GbkPTun/K8xhsqm9CYnvxLczXhUinEYVCddlyzTcTlWamse247ZoQV3zsndEOcU72S5lkhDK8aZq0WypCf+HbwbNEVFVD29DCjusCZIgHWGV/gEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ROvAK7v0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-612b34ef0c2so6998791a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095203; x=1753700003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owUJ8Gv9MIW5ZRdzl0DYdWGTFOtwpeoBmnLH2OxedCk=;
        b=ROvAK7v0atTTk1m6KdEzSwwiSZ0eZewnwIqGZUynNiiBJRdzchiD/AVV+TfqoSLZf5
         OJpcVaIHT3fZuC4hJ1JzHslL6VM3om5Jg36SHMd2pJmi6EThfb4L2apbStKObkG/cxnf
         ub3Uf1GZG8YIf5la88NA96+D32s54wC6aQqajilzMEFLH05BBY2HopXkTwQYKwyBnPH4
         adeZENqYG+ALD8JhzAb6G00N7pGpu+krdbE4NTZoPmHEkoNS9+s17KxIHpgzl0RRl5Q/
         REgqCJ/ark1Z9CghhyOmecthHwvfKmlUcwTzi2c9McPQ9VNI5ApnI6bpteUjlX9RqQuz
         f32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095203; x=1753700003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owUJ8Gv9MIW5ZRdzl0DYdWGTFOtwpeoBmnLH2OxedCk=;
        b=lldYwFSEaLVjz7SmS1G01+W0ubca4DqKLqhbjY+LQ0FdXLXDBsHg972ijKnnLIZkZf
         tK2ITB4R/2WNWf/ubHaiqVH6UKwjX54/KuM/U4EL6yOlHUFjAyae6fay5+DIb6W4xda7
         lFWgOtOJNJE7LYta3X6B17QTb5Hrv8412D1adysW185s6ejOgjzXtncgpQlnkyUhGg6Q
         8qVtOpAOhPLBGoqhp+USILUzS7R7Ijo1Ot7mfFDkwVyv6tCLhZ0mQipul02fFFbbpCEi
         4XcqtPm1f+/H6FAu/vdYxlfwZGVkR0R8F/UHUmkfx7dJb9JgJHg0lcxDIdVJlLseBwvW
         XcCA==
X-Gm-Message-State: AOJu0YyteHKhCkGQLVc38gGpP1M3TUURRdCfwtOrxI7i8wSqq/JVtNU3
	accyrIoOb0ujeJDjsu1U93bnvpwryaK9tpfc1BFh9igLawUTw3AuVaCwTQpkNbA0LA4=
X-Gm-Gg: ASbGncs5v/u0jlifZ8PPXT8gDTFEKlIwIeYW9q8qyaTRlEIkYHjA36Mu/8PgiXrihIO
	9ozQCt9yYmbryqPaD9vIlKPI0ATF7Hl5C0XPIbdDs2t6uosURBDtWVEk7NZwKHMoCmnLOdyk9fg
	vnvBowuhOm5rh0rUdOyjD2dIiwsG2QJnnH2YMbykU5YuKiv/hBpFCcJQNv9ogUqVKHr4kATaPpl
	wmvj+B8UVu1DtNFTLklmRNh59s5q3qMNbc34X3ZmPhJGq9ArmOkS0+xo6xFxvcgpuL14fjni65Y
	AUfBFcJxTWUDsX3mZoItWElmhfcE1206VKE90yCf/GZ6BvOqM8Fowq7jTPoPLzKrEw9Eh7O68oD
	3TpI0WlPpJbjsTg==
X-Google-Smtp-Source: AGHT+IF7jkXG7SrtfFp6JhxYuHr6YVSFPY11fq9qpow2NyuWcl9jYWdnV2c6RPE0rqETAm9r5qWJiQ==
X-Received: by 2002:a17:906:8c2:b0:ae3:f3c1:a5dd with SMTP id a640c23a62f3a-aec4fca259amr1229791066b.61.1753095203038;
        Mon, 21 Jul 2025 03:53:23 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7dcf71sm656576066b.64.2025.07.21.03.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:39 +0200
Subject: [PATCH bpf-next v3 01/10] bpf: Add dynptr type for skb metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-1-e92be5534174@cloudflare.com>
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

Add a dynptr type, similar to skb dynptr, but for the skb metadata access.

The dynptr provides an alternative to __sk_buff->data_meta for accessing
the custom metadata area allocated using the bpf_xdp_adjust_meta() helper.

More importantly, it abstracts away the fact where the storage for the
custom metadata lives, which opens up the way to persist the metadata by
relocating it as the skb travels through the network stack layers.

A notable difference between the skb and the skb_meta dynptr is that writes
to the skb_meta dynptr don't invalidate either skb or skb_meta dynptr
slices, since they cannot lead to a skb->head reallocation.

skb_meta dynptr ops are stubbed out and implemented by subsequent changes.

Only the program types which can access __sk_buff->data_meta today are
allowed to create a dynptr for skb metadata at the moment. We need to
modify the network stack to persist the metadata across layers before
opening up access to other BPF hooks.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h   | 14 +++++++++++++-
 kernel/bpf/helpers.c  |  7 +++++++
 kernel/bpf/log.c      |  2 ++
 kernel/bpf/verifier.c | 23 +++++++++++++++++++----
 net/core/filter.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f9cd2164ed23..1f5e170d19df 100644
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
@@ -3491,6 +3496,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 				u32 *target_size);
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 			       struct bpf_dynptr *ptr);
+int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
+				    struct bpf_dynptr *ptr);
 #else
 static inline bool bpf_sock_common_is_valid_access(int off, int size,
 						   enum bpf_access_type type,
@@ -3517,6 +3524,11 @@ static inline int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 {
 	return -EOPNOTSUPP;
 }
+static inline int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
+						  struct bpf_dynptr *ptr)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #ifdef CONFIG_INET
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
index e2fcea860755..d0a12397d42b 100644
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
@@ -12189,6 +12194,7 @@ enum special_kfunc_type {
 	KF_bpf_rbtree_right,
 	KF_bpf_dynptr_from_skb,
 	KF_bpf_dynptr_from_xdp,
+	KF_bpf_dynptr_from_skb_meta,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
@@ -12238,9 +12244,11 @@ BTF_ID(func, bpf_rbtree_right)
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
@@ -13214,6 +13222,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
+				dynptr_arg_type |= DYNPTR_TYPE_SKB_META;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
 				enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
@@ -21788,12 +21798,17 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 	if (offset)
 		return;
 
-	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
+	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb] ||
+	    func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
 		seen_direct_write = env->seen_direct_write;
 		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
 
-		if (is_rdonly)
-			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
+		if (is_rdonly) {
+			if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb])
+				*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
+			else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta])
+				*addr = (unsigned long)bpf_dynptr_from_skb_meta_rdonly;
+		}
 
 		/* restore env->seen_direct_write to its original value, since
 		 * may_access_direct_pkt_data mutates it
diff --git a/net/core/filter.c b/net/core/filter.c
index 7a72f766aacf..c17b628c08f5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11978,6 +11978,25 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return func;
 }
 
+static int dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
+				struct bpf_dynptr *ptr_, bool rdonly)
+{
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr_;
+	struct sk_buff *skb = (struct sk_buff *)skb_;
+
+	if (flags) {
+		bpf_dynptr_set_null(ptr);
+		return -EINVAL;
+	}
+
+	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_META, 0, skb_metadata_len(skb));
+
+	if (rdonly)
+		bpf_dynptr_set_rdonly(ptr);
+
+	return 0;
+}
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)
@@ -11995,6 +12014,12 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 	return 0;
 }
 
+__bpf_kfunc int bpf_dynptr_from_skb_meta(struct __sk_buff *skb, u64 flags,
+					 struct bpf_dynptr *ptr__uninit)
+{
+	return dynptr_from_skb_meta(skb, flags, ptr__uninit, false);
+}
+
 __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_md *x, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)
 {
@@ -12165,10 +12190,20 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 	return 0;
 }
 
+int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
+				    struct bpf_dynptr *ptr__uninit)
+{
+	return dynptr_from_skb_meta(skb, flags, ptr__uninit, true);
+}
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
+BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
@@ -12190,6 +12225,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
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
@@ -12225,6 +12265,8 @@ static int __init bpf_kfunc_init(void)
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


