Return-Path: <bpf+bounces-37110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B412D950F22
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 23:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13712B21A02
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5C51AAE24;
	Tue, 13 Aug 2024 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dYaFL/to"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6DD43155
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584276; cv=none; b=KyMWLd+DVF068rpclaYWapKZ8Nk7Lx425Ci5cnx7P8g/Sogh6CKPuNmTkdUmvydVffZxNepVtQOCGYWJ3kAN7k8unUIWUlSh+zhZjFwWqxoc+R/ND6udoPqei8fH4IlBrDrrHI3pMT1T1khl0FoJqBrX3iAqbKLOiSmWQ5hByEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584276; c=relaxed/simple;
	bh=9bVt2RqQHMBiLL+bNtCoVf9m2FTiqTamJTbmrLYY5Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAv1AM9xA7HQyEepWMeBJsypRlR67F+t5LGFJIXo/t3SRm+LiOE/uuAyFCwVckf6tCp6G8Q/W9FExeoWOUF88sedGSgkRz3v45SNAUM7ogTQAS1Jo9Okm1L4E7ZGSpirqfZuiZ/wYINj4kEX+DXE/52rv3lWk2TbRbKPQuY2gTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dYaFL/to; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so32999356d6.0
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723584273; x=1724189073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSdXUIc8I8ipGRJ21IkX+BG97y/uudEncK49JhUrZvI=;
        b=dYaFL/toHjoBhetM5GF7I5MBkYFc85Otg3hmz3spgWCw1QrJ49tw6Ca+4+JJFuQ1wg
         FO0/XlN46lqLaU+46fbHThpDBmO92emAOPCQr0yaUsM93V3s5Kjk3sd5wX9bvqUprTfL
         aT8r52bltaz5fsfqy1HC4DGkVrjmBUbHpAs0W44HEwLpHZL9jk+IljoXSTdZQiJ4qUWS
         4P/dJHxt0HKwo4GwLzrrySqZLHyvo8MHeAwCyeDcMtwBY7nfHTQGtwIafy2jlTX9XC8r
         BtBeNVxQ2gFCmsiHkkjhxtTDpp+dy+bZcLJ/y5rMHR6NIpHn42WvJ6tDDe9UDNPF7Qy1
         Lktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723584273; x=1724189073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSdXUIc8I8ipGRJ21IkX+BG97y/uudEncK49JhUrZvI=;
        b=VWXy8YjRGLnbJx/sgjCN85ykdzew8tqr13U8A1EVueFKSNA3D3WoLUJJRHLNJtjV1j
         XriRHfWUR2PvQUhEIpA0X8mi+NpW4XGJXHwPuDLhXnwZygy48v13gKKP3+KFXCZ3yVhE
         1o3DXg03rJISKnlYPmlo4iTMfdb4shtXSZsGxjcsQChquh5Ytn5nEkMfzcBoASW4j6ws
         sC7Ri2EzHgZwZ9aC0zSSIsAQEpWk0c4DLFSizhpqVeIDUbYJAgHLdQ2YA1etkLREvBVV
         qMaXFPDrpDszuPcohetUz9E6LvxjCJ724RnupMlW+R74c7devm937UOt6mPcG38JuRrr
         EMZw==
X-Gm-Message-State: AOJu0YxJbs+gdvSdPRD/BDP/qK21FNiq2XK8zJ9Uiqr25ZRg2inC/s+g
	10dP1KnnM37UV4I4FNPth6Dujp2LcEX5fpX76cgW1zL9QTfNnIt9/tqcocDE7/B77/eM5NAIPeI
	mh1Y=
X-Google-Smtp-Source: AGHT+IHzZYqKxQdetXbSVaqyg1P1QFqpicvfxJoEByjWY3ztNbUASprpU4oVq2mBS1UhQVXLsnEfeQ==
X-Received: by 2002:a05:6214:4413:b0:6b7:ab54:3b90 with SMTP id 6a1803df08f44-6bf5d22db83mr8767996d6.35.1723584273466;
        Tue, 13 Aug 2024 14:24:33 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf432fb61dsm21390786d6.52.2024.08.13.14.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 14:24:33 -0700 (PDT)
From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	houtao@huaweicloud.com,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v4 bpf-next 4/5] bpf: Support bpf_kptr_xchg into local kptr
Date: Tue, 13 Aug 2024 21:24:23 +0000
Message-Id: <20240813212424.2871455-5-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240813212424.2871455-1-amery.hung@bytedance.com>
References: <20240813212424.2871455-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

Currently, users can only stash kptr into map values with bpf_kptr_xchg().
This patch further supports stashing kptr into local kptr by adding local
kptr as a valid destination type.

When stashing into local kptr, btf_record in program BTF is used instead
of btf_record in map to search for the btf_field of the local kptr.

The local kptr specific checks in check_reg_type() only apply when the
source argument of bpf_kptr_xchg() is local kptr. Therefore, we make the
scope of the check explicit as the destination now can also be local kptr.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/uapi/linux/bpf.h |  9 ++++----
 kernel/bpf/helpers.c     |  4 ++--
 kernel/bpf/verifier.c    | 44 +++++++++++++++++++++++++++-------------
 3 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 35bcf52dbc65..e2629457d72d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5519,11 +5519,12 @@ union bpf_attr {
  *		**-EOPNOTSUPP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
  *
- * void *bpf_kptr_xchg(void *map_value, void *ptr)
+ * void *bpf_kptr_xchg(void *dst, void *ptr)
  *	Description
- *		Exchange kptr at pointer *map_value* with *ptr*, and return the
- *		old value. *ptr* can be NULL, otherwise it must be a referenced
- *		pointer which will be released when this helper is called.
+ *		Exchange kptr at pointer *dst* with *ptr*, and return the old value.
+ *		*dst* can be map value or local kptr. *ptr* can be NULL, otherwise
+ *		it must be a referenced pointer which will be released when this helper
+ *		is called.
  *	Return
  *		The old value of kptr (which can be NULL). The returned pointer
  *		if not NULL, is a reference which must be released using its
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8ecd8dc95f16..d1a39734894c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1619,9 +1619,9 @@ void bpf_wq_cancel_and_free(void *val)
 	schedule_work(&work->delete_work);
 }
 
-BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
+BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
 {
-	unsigned long *kptr = map_value;
+	unsigned long *kptr = dst;
 
 	/* This helper may be inlined by verifier. */
 	return xchg(kptr, (unsigned long)ptr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f2964b13b46..5a4ca7e29272 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7803,29 +7803,38 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
-	struct bpf_map *map_ptr = reg->map_ptr;
 	struct btf_field *kptr_field;
+	struct bpf_map *map_ptr;
+	struct btf_record *rec;
 	u32 kptr_off;
 
+	if (type_is_ptr_alloc_obj(reg->type)) {
+		rec = reg_btf_record(reg);
+	} else { /* PTR_TO_MAP_VALUE */
+		map_ptr = reg->map_ptr;
+		if (!map_ptr->btf) {
+			verbose(env, "map '%s' has to have BTF in order to use bpf_kptr_xchg\n",
+				map_ptr->name);
+			return -EINVAL;
+		}
+		rec = map_ptr->record;
+		meta->map_ptr = map_ptr;
+	}
+
 	if (!tnum_is_const(reg->var_off)) {
 		verbose(env,
 			"R%d doesn't have constant offset. kptr has to be at the constant offset\n",
 			regno);
 		return -EINVAL;
 	}
-	if (!map_ptr->btf) {
-		verbose(env, "map '%s' has to have BTF in order to use bpf_kptr_xchg\n",
-			map_ptr->name);
-		return -EINVAL;
-	}
-	if (!btf_record_has_field(map_ptr->record, BPF_KPTR)) {
-		verbose(env, "map '%s' has no valid kptr\n", map_ptr->name);
+
+	if (!btf_record_has_field(rec, BPF_KPTR)) {
+		verbose(env, "R%d has no valid kptr\n", regno);
 		return -EINVAL;
 	}
 
-	meta->map_ptr = map_ptr;
 	kptr_off = reg->off + reg->var_off.value;
-	kptr_field = btf_record_find(map_ptr->record, kptr_off, BPF_KPTR);
+	kptr_field = btf_record_find(rec, kptr_off, BPF_KPTR);
 	if (!kptr_field) {
 		verbose(env, "off=%d doesn't point to kptr\n", kptr_off);
 		return -EACCES;
@@ -8399,7 +8408,12 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
-static const struct bpf_reg_types kptr_xchg_dest_types = { .types = { PTR_TO_MAP_VALUE } };
+static const struct bpf_reg_types kptr_xchg_dest_types = {
+	.types = {
+		PTR_TO_MAP_VALUE,
+		PTR_TO_BTF_ID | MEM_ALLOC
+	}
+};
 static const struct bpf_reg_types dynptr_types = {
 	.types = {
 		PTR_TO_STACK,
@@ -8470,7 +8484,8 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	if (base_type(arg_type) == ARG_PTR_TO_MEM)
 		type &= ~DYNPTR_TYPE_FLAG_MASK;
 
-	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type)) {
+	/* Local kptr types are allowed as the source argument of bpf_kptr_xchg */
+	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type) && regno == BPF_REG_2) {
 		type &= ~MEM_ALLOC;
 		type &= ~MEM_PERCPU;
 	}
@@ -8563,7 +8578,8 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
 			return -EFAULT;
 		}
-		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+		/* Check if local kptr in src arg matches kptr in dst arg */
+		if (meta->func_id == BPF_FUNC_kptr_xchg && regno == BPF_REG_2) {
 			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
 				return -EACCES;
 		}
@@ -8874,7 +8890,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->release_regno = regno;
 	}
 
-	if (reg->ref_obj_id) {
+	if (reg->ref_obj_id && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
 		if (meta->ref_obj_id) {
 			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
 				regno, reg->ref_obj_id,
-- 
2.20.1


