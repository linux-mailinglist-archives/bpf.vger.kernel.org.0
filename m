Return-Path: <bpf+bounces-68940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D914BB8A8D5
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903825A7B79
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292031E884;
	Fri, 19 Sep 2025 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiN+HSrj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5C242D70
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298985; cv=none; b=YqHTHmz7G2deoscIur/Kl/FJgv9kAtEGzYbp5MLpK1pnbWLKo/edtthTlJdE5QkeBUEd81rJ5f17NW4KrvRPZkTLiZp0xLyE8cjtPAUr+jZxdST1cg3L+UlUKYjtAxH5UJfHWw20rKMhmaLYQOhwJTraSoItK3HKLBtB6E/Q/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298985; c=relaxed/simple;
	bh=IGg2Tr9tm8J1botmqgGNbSNnb5CEBcr1VH+Clze+iSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9Ey0Xl03o7LbIA5iY4U4rm9AhbHups5F3QmsEvBJcoz8oP29uhkb65z+hcdhLqlFF5SRYpNh+b7JmrDLHTINwf31U/l4iXFjnlwSQtCYlrPJcYqUDn1INBFRZ8nBW8tw+aSaDlN6LbUl3vHjnNOjWtYXNp02Y6pvwnsvkS2LDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiN+HSrj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b2350899a40so295831866b.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758298982; x=1758903782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gYx6D8XRGSbpf6jamkQ28NsnsyX8t6UkjbNT/jnoNEA=;
        b=OiN+HSrjoafYMgWXYbfJBdhxS/eeH0vP3n8ceLrFQ4XWcSUR2PF3Rwf+NN4qUPy9lB
         59Dliki3jmMEnna7ibF1FYtu0nB4hrECly0rE5c1ADbnCWyvFbV/4qHyTUU4LqW0lmOG
         5P5DARr3HnlscSLNwv1DASPAR7Fc5uexWvNIVKwORXF6GOMWhEdBzp88wD3BSvjSsBA6
         3q93elg3ZQJ9Rpwgicc/nSwogSyJTe+hRdpladPuJNFZyHlowIOOo+HNDfz3OJm7FL7B
         Re37zs5scVNH4oPfI9dgufuXBvFRT5kcu1+ma4XVembZK3sqW4cqX5VQTvvmmgfXwhUR
         CdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758298982; x=1758903782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYx6D8XRGSbpf6jamkQ28NsnsyX8t6UkjbNT/jnoNEA=;
        b=LVoptpts/bJ8SG+M8Q82U56ZbjeM/pFKECvW4IuwMBEuR3IY95CSjE7XlpZ2zkLiQK
         NKIvHeHdu3Z+1XKk1OS5i0hbQSY9OXv04b0DnoPHcq+6pikzsL41pvMGSoIh1xkYZrJY
         R5wTYpqPi14vRYyrwGdQlgieo4igNUA/WqfH2R5gOb6QHjz6oeZhSOYiPs8WPMR7o1oW
         N0PQAu3eZMUosEH5A93ERA2NjQL8FHIkwQ1h4reVZcyLbdVo5CaeceJ43E8NsyWabwsR
         v6zm3Ox2RslfWLU3/ooAzZhGnYGFEvMe07mym6NqXenGcRNn3CXbKe8Ot+46TARiyryh
         qpYA==
X-Gm-Message-State: AOJu0YxH3O7qnm24WMIrPPcv5UqKNr4fYZIOkrSITwcrswB3xg8IU4Kh
	K5v5XEfAF9iNIQvjYUv1hWC/60fE5sNWbyq8msed+AXNeEyMYMT0VPiyvUp0mz0W
X-Gm-Gg: ASbGncvoK/Aqz7yL44/56aGOYjOKEKe3kQHx/cWQMBD6LmBE9Yk7tMejfI/HLdjA+Id
	V/EzVcjoxEFr0F/9octi2GlhCEY22tvomiWAjWMbab2Q5kruGz4CvHKb6nXz174F9daXoXE0KsC
	OQprG0gV4lk2NkWBoJPfEYIN8DrL820Us9fNseCIccfXOx1JcyJsxWAhb6PAD+yKE6pDLPXS/uf
	QOVyt+wj5QRqqUeObL6GkmImpskrAPkYf8V39rKISqpiKBuPNWpnu700kRt08UWAf6R+eue1KyA
	aQtvRGmttM6TydNVasznTG6q0MF9sdCZMA3i5uPDEZMCj1ITEOWChhKGaK2iSZisvwsCSKIKVM9
	hrXNCSPtGOxECu2dSbhVK+Szft7j6Z4/g
X-Google-Smtp-Source: AGHT+IE8V3xglLxJYucfOZh+EiJhxjrZ5n4ugZ1w08DwBbL5XiwreVz9v8wMdFSCvvq5wIexhWydKw==
X-Received: by 2002:a17:907:86a1:b0:b07:874e:b988 with SMTP id a640c23a62f3a-b24f3e603a5mr431325266b.31.1758298981650;
        Fri, 19 Sep 2025 09:23:01 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:f2f7:f955:bf36:2db2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd1101e4esm472395966b.84.2025.09.19.09.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:23:01 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] bpf: introduce kfunc flags for dynptr types
Date: Fri, 19 Sep 2025 17:22:51 +0100
Message-ID: <20250919162252.174386-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

The verifier currently special-cases dynptr initialization kfuncs to set
the correct dynptr type for an uninitialized argument. This patch moves
that logic into kfunc metadata.

Introduce KF_DYNPTR_* kfunc flags and a helper,
dynptr_type_from_kfunc_flags(), which translates those flags into the
appropriate DYNPTR_TYPE_* mask. With the type encoded in the kfunc
declaration, the verifier no longer needs explicit checks for
bpf_dynptr_from_xdp(), bpf_dynptr_from_skb(), and
bpf_dynptr_from_skb_meta().

This simplifies the verifier and centralizes dynptr typing in kfunc
declarations, helps with future changes, adding new dynptr types.
No user-visible behavior change.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/btf.h   |  3 +++
 kernel/bpf/verifier.c | 40 ++++++++++++++++++++++++++++++++--------
 net/core/filter.c     |  6 +++---
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 9eda6b113f9b..d41d6a0d1085 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -79,6 +79,9 @@
 #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
+#define KF_DYNPTR_XDP   (1 << 16) /* kfunc takes dynptr to XDP */
+#define KF_DYNPTR_SKB   (1 << 17) /* kfunc takes dynptr to SKB */
+#define KF_DYNPTR_SKB_META   (1 << 18) /* kfunc takes dynptr to SKB metadata */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aef6b266f08d..2f99097f6f51 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2297,6 +2297,33 @@ static bool reg_is_dynptr_slice_pkt(const struct bpf_reg_state *reg)
 		(DYNPTR_TYPE_SKB | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META));
 }
 
+#define ALL_DYNPTR_MASK (KF_DYNPTR_SKB | KF_DYNPTR_XDP | KF_DYNPTR_SKB_META)
+
+static u64 dynptr_type_from_kfunc_flags(struct bpf_verifier_env *env,
+					const struct bpf_kfunc_call_arg_meta *meta)
+{
+	static const struct {
+		u64 mask;
+		enum bpf_type_flag type;
+	} type_flags[] = {
+		{ KF_DYNPTR_SKB, DYNPTR_TYPE_SKB },
+		{ KF_DYNPTR_XDP, DYNPTR_TYPE_XDP },
+		{ KF_DYNPTR_SKB_META, DYNPTR_TYPE_SKB_META },
+	};
+	int i;
+
+	if (hweight32(meta->kfunc_flags & ALL_DYNPTR_MASK) > 1) {
+		verifier_bug(env, "multiple dynptr types declared for kfunc %s", meta->func_name);
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(type_flags); ++i) {
+		if (type_flags[i].mask & meta->kfunc_flags)
+			return type_flags[i].type;
+	}
+	return 0;
+}
+
 /* Unmodified PTR_TO_PACKET[_META,_END] register from ctx access. */
 static bool reg_is_init_pkt_pointer(const struct bpf_reg_state *reg,
 				    enum bpf_reg_type which)
@@ -13277,14 +13304,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (is_kfunc_arg_uninit(btf, &args[i]))
 				dynptr_arg_type |= MEM_UNINIT;
 
-			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
-				dynptr_arg_type |= DYNPTR_TYPE_SKB;
-			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
-				dynptr_arg_type |= DYNPTR_TYPE_XDP;
-			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
-				dynptr_arg_type |= DYNPTR_TYPE_SKB_META;
-			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
-				   (dynptr_arg_type & MEM_UNINIT)) {
+			if (meta->kfunc_flags & ALL_DYNPTR_MASK)
+				dynptr_arg_type |= dynptr_type_from_kfunc_flags(env, meta);
+
+			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
+			    (dynptr_arg_type & MEM_UNINIT)) {
 				enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
 
 				if (parent_type == BPF_DYNPTR_TYPE_INVALID) {
diff --git a/net/core/filter.c b/net/core/filter.c
index 8342f810ad85..7baabff22656 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12228,15 +12228,15 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 }
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
-BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS | KF_DYNPTR_SKB)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
-BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS | KF_DYNPTR_SKB_META)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
-BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
+BTF_ID_FLAGS(func, bpf_dynptr_from_xdp, KF_DYNPTR_XDP)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
-- 
2.51.0


