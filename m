Return-Path: <bpf+bounces-68792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4461EB84D6F
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C802A7B8B71
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF2B30C36A;
	Thu, 18 Sep 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7KDqHcd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0D30BF78
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202087; cv=none; b=GAqynzGzMVxtqavUYmmUB0ryvPW3gWSzs4XY/xe+ImVf7i0TE5dpOhnz3GMfvIagk6UUnlMDPJcjk/ajqdTuT45Ge41022doqp2u6O339yMpBmV9cQVEVcVv2Z5Z38QJDOJERtbAdgcMBXCbCvpYZWXYsW6WUI1KHLqDYp3Hthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202087; c=relaxed/simple;
	bh=QXcwwvMdN7fAfpPKS5ODdp7XRuBb1B+ZTJ7V5hS8ah4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krE99dwOycqySBkvLVfqFKvv/+/WlQeXtab4hseV8c0iaW0OF/u69ByL3bmSwX8GiSnYAKEgLLYBGaADzgfOdc/f4qCvykDUDvBUiLhzQRJhkLyctLeQjE5/Dlm36RNQE+kq3fF2WBYOJiRkZzC53C8eriHnE2AzED7BbdsvIyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7KDqHcd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4619eb182c8so9624385e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758202084; x=1758806884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk+POebBs9/+mGTn0DN7PwmeaN7lQamLGdd0lNN4BLI=;
        b=a7KDqHcdb3gwvT/G7J3jJayNFSCeoTr6uYgOTgJ5x2E+CjLI+tauszpS7zXH9PXVNb
         oe7g6A6bcTDKjmheP7bxOinYQHYt5AK0e9oAA5muipJ/I53kltcHY91lmDmRvY8dosti
         gQe3KB+R6W5a5ubxy+813pqTkUluOHZ8JqtGijLNyNFi5MwBOkPFzu7od/uxtN5WtMeZ
         OMUSuKi60XnLtL2i5Oi/sFdwnnspa2mnaWpraE3EZXKujSFybmv1RkydA4jokcYQ+VXl
         PFRUv+LSe9mNLhManxaLOxv9SmuGy1SpjftV58x7Nl2leDIK3OMvmCEVGtd0vVUfmYw8
         0A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202084; x=1758806884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yk+POebBs9/+mGTn0DN7PwmeaN7lQamLGdd0lNN4BLI=;
        b=KaBcKyJMWtmtXGhehD0Ub+0nG6Kyhgk5QH+rwsbAARwrOtzSNRQEB7Rg8cCULZ1LGw
         x3PqhSf/DYtB8oFi5jXYDa5p3ewxnWZZN3ms/jHuiwsjzxBHUJJ8+3zMALeBSKDTqWiD
         gbooXsgwirO6tYEyBuGm81+w45nLh1ELmgfizPLEnFwiPqjuA6YiAfiyg9fvVP6ip0lT
         ovOlporOGZQs7qgS2oP/bkjWslPoth6RCoW3PoqYc6rktr9Rh+rTt2dqnne2Y7dnnQ2r
         agdup5ktciOJ7r+iyx0WkIkIQRxNNNT2MHHqTsi+ReRVQHdSY/GRfDPkriJelkl0rtq1
         tvyw==
X-Gm-Message-State: AOJu0YxKm2bkzFmObirFmjmrS3+oTp8em3sNQeGveo21Jx4Q9paCD9nT
	WuylhSyGlw4wwqL6mAw6S6IAw2pJ7Kwk6k++IC4EfzoMKVXV+NkGnGI2y+S+zDYj
X-Gm-Gg: ASbGncuDD5sfUIvEfmoIfGydUrOWxCJH862YhMgvradKrEuDcl4rGtdfxH9pSFytXsU
	DKPwb3P9ISrtrf/BtptF5i4jHZCUQ0j8QdUn4viQQWmglCE+QysQbWaiWLVIy9xp5Q8oJBF+E6P
	vJFNWH0b/2iF7BKEKclyTUQYPBL48uexEthNhbS968T0bRhw/LMB5BtrKgZg5cWjcS5jKxkVtPM
	lhCfbL3A7mco7SKrZY2QqSsfQ8D+dm84TC1cAHQrcuKN3+ujfcdEz/v92yZyZN+1O22jLMgSpgg
	lZ9aALMDIHZ479jJXRPhxYsObaFTmqenJZwfvL0g1DMrhtWaOnoBOuM1C5F6nv8IaYWFuQGDnxC
	GttVw5fDH26cK+2lueSPl
X-Google-Smtp-Source: AGHT+IFk8s5aZNer8L+fTqhjtcDnsRyJyAvCbERJ27ROcVi8l5h6aD/uy/j/3b16BMz7YyXt7fQM4w==
X-Received: by 2002:a05:600c:314c:b0:45c:b549:2241 with SMTP id 5b1f17b1804b1-46206842a9amr50439855e9.27.1758202083967;
        Thu, 18 Sep 2025 06:28:03 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:ce66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613186e5c7sm93184175e9.0.2025.09.18.06.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:28:03 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] bpf: introduce kfunc flags for dynptr types
Date: Thu, 18 Sep 2025 14:27:56 +0100
Message-ID: <20250918132756.194301-1-mykyta.yatsenko5@gmail.com>
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
declarations, with no user-visible behavior change.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/btf.h   |  3 +++
 kernel/bpf/verifier.c | 31 +++++++++++++++++++++++--------
 net/core/filter.c     |  6 +++---
 3 files changed, 29 insertions(+), 11 deletions(-)

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
index b9394f8fac0e..9aa2f00ede49 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2282,6 +2282,25 @@ static bool reg_is_dynptr_slice_pkt(const struct bpf_reg_state *reg)
 		(DYNPTR_TYPE_SKB | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META));
 }
 
+static u64 dynptr_type_from_kfunc_flags(const struct bpf_kfunc_call_arg_meta *meta)
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
@@ -13258,14 +13277,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
+			dynptr_arg_type |= dynptr_type_from_kfunc_flags(meta);
+
+			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
+			    (dynptr_arg_type & MEM_UNINIT)) {
 				enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
 
 				if (parent_type == BPF_DYNPTR_TYPE_INVALID) {
diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..9f58bb757bea 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12224,15 +12224,15 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
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


