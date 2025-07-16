Return-Path: <bpf+bounces-63452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C30B07AEE
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA761888961
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B442F5481;
	Wed, 16 Jul 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PIMAIiyE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A62F433B
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682670; cv=none; b=YK9nknmAdsFW6jMCZBocntwAMVcgO97BIPCeWrSu9+PHp0pKLfve86hWY+ROAxSccD/EPpPWlDDI5Tgnyfvbcj+Hwy4mAj71l08M8B/LMoISXWHg6Xx3NQDMnnbiJLXKNPjk0OOlDcIJtCCEFJxTbTvstr9fE+p7AaXIudCFzh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682670; c=relaxed/simple;
	bh=4ayZF9Xqdedd4BGVKV7Arqt/gteFun7eX3Y9+oAb3no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mb6mu8sdiIcYy0lsliQblZ1G0Ie8jI29IlYgDfmo55aEXRyLHh1itUmPcH9RE9o6pCIP4Jq5t+53Db22Iv0L7Ja7xSZTzSsJgCEvDtnPy0HCuNYgm3KeqY0bofQlmUrS2AIJuX5iyV56anEdUSCJzGiE6gkPwAzQ2rigtdyJ/qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PIMAIiyE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b6a349ccso96106e87.0
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682666; x=1753287466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZCrTmjHYEfkmZskclLE7y8aKZIbTtFD8grO8tMEr9M=;
        b=PIMAIiyEo4Rl0HwHx6ERuuF/peFZ1M2mvNuOP4XPeGNgNk2HNyAE5TN1slb6TAtHAz
         +DzVcy683YpAah48CYi/juU5DJ72+KtDr/tWEVfgVpTX88D6TD86f/vl3w7nBhg6HQQ+
         3TqQiiRKZaVLnB+6uFMAtAFdO1YEqrTEnapdvwXjHd7Paem6sE31OEOcgmgcFXEGsKVt
         6lM4HSlyYxua52VyJDVcpTfFmnI62z7aZBnpqybw+W6qQ3mkwAJTrvqrpVzFiEietm7x
         4o4Q/YeSCwtHm58vy/UqRh3hUe9xjk1LapFTssoxnBgQZIfcX7/4Be26Lx/PUdq1rkLf
         u/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682666; x=1753287466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZCrTmjHYEfkmZskclLE7y8aKZIbTtFD8grO8tMEr9M=;
        b=NssBVLQLOH7j7DmkyNKG97z4jV0ToIeg+qwvesVPZi3bRKzWpEsLJNnCUORRX5wTnq
         ztbyEAZKoJgYuCSkbF5wGISMYT94d639/rHWezLdUJvlVJ/PZfzuaUQ9Z00jOlvg35E+
         AyJq2Rwr9NzPDoy8ciSXlSLAJOq0ye+3wetGrB6suNFyy90yh2vICrJA2dtoIbPQLr4o
         Wg97bYJllgId4JqI9uwbFU/Ckg1u0k1OK7GdBRy5JHpEro9f1o/N9st6V7U9mi/En5GX
         ftoCmPd1KtaYi0ioaJnCLW+S9ZWIqrheHN6T7fUXvmvAyvnUv/qW8wCGi4zltBP7cVpW
         swOg==
X-Gm-Message-State: AOJu0Yzm3bPRK2dHNqvFuI+xHB0HgyCO7KYtE75hzVDMUL3oT1u+SbSI
	iQ1YtuT9ar73RNCmcndBTxLhDNbQm/1EeVthJf3b8ozYjfawePjq82xYVW/5BWST048=
X-Gm-Gg: ASbGncuUFj1S/JoBWY+CgUu6PNsxc7PhZqlNVnvaE948U5oNGpMoKR2xmVy4ilgrRjk
	4LDRxo2DQ4JIY/rsQTWY2ExmXnGkub1mT2x1d0CypoP3O09WUSAgiXqRRE4Fm2qamlfWyEvJJMo
	Y/Cf2L4JdYQXcpx6U7nteXx2PEDJghaBvK1brICbPxF+FmXlAg86kueX86gVWZ4SCO2BSydD5TW
	YKIRzYi/PjiGtcyRoYFV+HfUod0wpaT9qL2MmrIPTPonjocVW6usDI4+Z50Kcgiagx4LJnGSypL
	rU89Ko2gl5fWktgzmtYFa1kiEvLrEMT3kyTF/FYAK6KUC3r62MUQZfwjGHRqJBz6ZwvR1BClpjv
	aSzfETZ28rZZaJnlEZfkI04xUG8Z0TZD4YRsUFid8IS6wWq6JyTKphIVcitHifaUjXdJr
X-Google-Smtp-Source: AGHT+IEoJ8rRzpbG49IZFfVJoYmRhCnnNz30F1N9p4nJPF08eNZmnabZfFnUs93sd9EUrBl70zgZkA==
X-Received: by 2002:a05:6512:3e26:b0:553:35c2:c77f with SMTP id 2adb3069b0e04-55a23ef3a6amr1302785e87.16.1752682666155;
        Wed, 16 Jul 2025 09:17:46 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab8f5db1sm21126771fa.96.2025.07.16.09.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:17:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:45 +0200
Subject: [PATCH bpf-next v2 01/13] bpf: Add dynptr type for skb metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-1-5f580447e1df@cloudflare.com>
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
In-Reply-To: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Add a dynptr type, similar to skb dynptr, but for the skb metadata.

The dynptr provides an alternative to __sk_buff->data_meta for accessing
the custom metadata area allocated using the bpf_xdp_adjust_meta() helper.

More importantly, it abstracts away the fact where the storage for the
custom metadata lives, which opens up the way to persist the metadata by
relocating it as the skb travels through the network stack layers.

A notable difference between the skb and the skb_meta dynptr is that writes
to the skb_meta dynptr don't invalidate either skb or skb_meta dynptr
slices, since they cannot lead to a skb->head reallocation.

skb_meta dynptr ops are stubbed out and implemented by subsequent changes.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h   | 14 +++++++++++++-
 kernel/bpf/helpers.c  |  7 +++++++
 kernel/bpf/log.c      |  2 ++
 kernel/bpf/verifier.c | 23 +++++++++++++++++++----
 net/core/filter.c     | 32 ++++++++++++++++++++++++++++++++
 net/sched/bpf_qdisc.c |  1 +
 6 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bc887831eaa5..993860e8d66a 100644
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
@@ -3480,6 +3485,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 				u32 *target_size);
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 			       struct bpf_dynptr *ptr);
+int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
+				    struct bpf_dynptr *ptr);
 #else
 static inline bool bpf_sock_common_is_valid_access(int off, int size,
 						   enum bpf_access_type type,
@@ -3506,6 +3513,11 @@ static inline int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
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
index 3d33181d5e67..e25a6d44efd6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1775,6 +1775,8 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 		return __bpf_skb_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return -EOPNOTSUPP; /* not implemented */
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1831,6 +1833,8 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 		if (flags)
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
+	case BPF_DYNPTR_TYPE_SKB_META:
+		return -EOPNOTSUPP; /* not implemented */
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1877,6 +1881,7 @@ BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u32, offset, u3
 		return (unsigned long)(ptr->data + ptr->offset + offset);
 	case BPF_DYNPTR_TYPE_SKB:
 	case BPF_DYNPTR_TYPE_XDP:
+	case BPF_DYNPTR_TYPE_SKB_META:
 		/* skb and xdp dynptrs should use bpf_dynptr_slice / bpf_dynptr_slice_rdwr */
 		return 0;
 	default:
@@ -2705,6 +2710,8 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
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
index 7a72f766aacf..e4a1f50904db 100644
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
@@ -12165,8 +12190,15 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
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
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 7ea8b54b2ab1..946c62d552cc 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -277,6 +277,7 @@ BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_init_prologue, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue, KF_TRUSTED_ARGS)

-- 
2.43.0


