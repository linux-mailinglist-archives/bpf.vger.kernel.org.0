Return-Path: <bpf+bounces-42969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C91A9AD89A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585631C21DF9
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB791E0087;
	Wed, 23 Oct 2024 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g71PZvDv"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5F16F8E5
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727310; cv=none; b=ItS7Bkq40FkaPkk7F7zqFhg12xO2PcxhydN5cmTuG7cV3PcrVrc0JCDt0P4aJ7/kp1I+xQmYrq7i/VcbFHgp656qA4sdQe83uRHq2MR5raECOE1np+y7hmSvuRWpnnBYRKc5593mEySwFS87ZRiKFKbzT/aCb1wQOFeA8hjazN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727310; c=relaxed/simple;
	bh=mE/FQsw7vymRTAgAEGdl5ITZUAsTIVb9ZQSSOEPdkqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfG5h5+SKAq+Fg/N4KKiYOfJCDUNTrqJHeRhdqPSc5CwwA/9C1JbhfmXF+SPAb4z9Pct1E2sAcdhVP4auRR+V+lPnYH5hn+6gc0jGBA9dFYFVcVbooLFVEQrveIWxtC/hWcJhadZZNG8IDU85vflQxPqfBCYBb6iEl9hTPi7VoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g71PZvDv; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729727305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFXm9WwpG4iTbvDlsltoBwLGwMTqlbzQj+A8937FPA0=;
	b=g71PZvDvM9YKCb+22qsSGvNZwX9ovd3cXqsxGai5LLPdX58knse2DESLcK+M5odZ5otBQ4
	/01PRL1YxdlKowYz7+0CGmI2GZHyjksUGdJRu1CLYyDOQVMMubgUxuBU3s5Q2QNLulqbed
	C0jiCS9O8zGddQAfyh8YGBQHxB5IwgA=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v6 bpf-next 01/12] bpf: Support __uptr type tag in BTF
Date: Wed, 23 Oct 2024 16:47:48 -0700
Message-ID: <20241023234759.860539-2-martin.lau@linux.dev>
In-Reply-To: <20241023234759.860539-1-martin.lau@linux.dev>
References: <20241023234759.860539-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kui-Feng Lee <thinker.li@gmail.com>

This patch introduces the "__uptr" type tag to BTF. It is to define
a pointer pointing to the user space memory. This patch adds BTF
logic to pass the "__uptr" type tag.

btf_find_kptr() is reused for the "__uptr" tag. The "__uptr" will only
be supported in the map_value of the task storage map. However,
btf_parse_struct_meta() also uses btf_find_kptr() but it is not
interested in "__uptr". This patch adds a "field_mask" argument
to btf_find_kptr() which will return BTF_FIELD_IGNORE if the
caller is not interested in a “__uptr” field.

btf_parse_kptr() is also reused to parse the uptr.
The btf_check_and_fixup_fields() is changed to do extra
checks on the uptr to ensure that its struct size is not larger
than PAGE_SIZE. It is not clear how a uptr pointing to a CO-RE
supported kernel struct will be used, so it is also not allowed now.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
Changes in v5:
  - A field_mask arg is added to btf_find_kptr
  - Some uptr enforcement is added to btf_check_and_fixup_fields()
  - The "case MAP_UPTR:" addition to bpf_obj_init_field()
    is moved to the later patch together with other bpf_obj_*()
    changes when BPF_UPTR is finally enabled in task storage map.

 include/linux/bpf.h  |  5 +++++
 kernel/bpf/btf.c     | 34 +++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c |  2 ++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0c216e71cec7..bb31bc6d0c4d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -203,6 +203,7 @@ enum btf_field_type {
 	BPF_GRAPH_ROOT = BPF_RB_ROOT | BPF_LIST_HEAD,
 	BPF_REFCOUNT   = (1 << 9),
 	BPF_WORKQUEUE  = (1 << 10),
+	BPF_UPTR       = (1 << 11),
 };
 
 typedef void (*btf_dtor_kfunc_t)(void *);
@@ -322,6 +323,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "kptr";
 	case BPF_KPTR_PERCPU:
 		return "percpu_kptr";
+	case BPF_UPTR:
+		return "uptr";
 	case BPF_LIST_HEAD:
 		return "bpf_list_head";
 	case BPF_LIST_NODE:
@@ -350,6 +353,7 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_UPTR:
 		return sizeof(u64);
 	case BPF_LIST_HEAD:
 		return sizeof(struct bpf_list_head);
@@ -379,6 +383,7 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_UPTR:
 		return __alignof__(u64);
 	case BPF_LIST_HEAD:
 		return __alignof__(struct bpf_list_head);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 13dd1fa1d1b9..76cafff2d99c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3334,7 +3334,7 @@ static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
 }
 
 static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
-			 u32 off, int sz, struct btf_field_info *info)
+			 u32 off, int sz, struct btf_field_info *info, u32 field_mask)
 {
 	enum btf_field_type type;
 	u32 res_id;
@@ -3358,9 +3358,14 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 		type = BPF_KPTR_REF;
 	else if (!strcmp("percpu_kptr", __btf_name_by_offset(btf, t->name_off)))
 		type = BPF_KPTR_PERCPU;
+	else if (!strcmp("uptr", __btf_name_by_offset(btf, t->name_off)))
+		type = BPF_UPTR;
 	else
 		return -EINVAL;
 
+	if (!(type & field_mask))
+		return BTF_FIELD_IGNORE;
+
 	/* Get the base type */
 	t = btf_type_skip_modifiers(btf, t->type, &res_id);
 	/* Only pointer to struct is allowed */
@@ -3502,7 +3507,7 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 	field_mask_test_name(BPF_REFCOUNT,  "bpf_refcount");
 
 	/* Only return BPF_KPTR when all other types with matchable names fail */
-	if (field_mask & BPF_KPTR && !__btf_type_is_struct(var_type)) {
+	if (field_mask & (BPF_KPTR | BPF_UPTR) && !__btf_type_is_struct(var_type)) {
 		type = BPF_KPTR_REF;
 		goto end;
 	}
@@ -3535,6 +3540,7 @@ static int btf_repeat_fields(struct btf_field_info *info,
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 		case BPF_LIST_HEAD:
 		case BPF_RB_ROOT:
 			break;
@@ -3661,8 +3667,9 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_UPTR:
 		ret = btf_find_kptr(btf, var_type, off, sz,
-				    info_cnt ? &info[0] : &tmp);
+				    info_cnt ? &info[0] : &tmp, field_mask);
 		if (ret < 0)
 			return ret;
 		break;
@@ -3985,6 +3992,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 			ret = btf_parse_kptr(btf, &rec->fields[i], &info_arr[i]);
 			if (ret < 0)
 				goto end;
@@ -4044,12 +4052,28 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
 	 * Hence we only need to ensure that bpf_{list_head,rb_root} ownership
 	 * does not form cycles.
 	 */
-	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & BPF_GRAPH_ROOT))
+	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & (BPF_GRAPH_ROOT | BPF_UPTR)))
 		return 0;
 	for (i = 0; i < rec->cnt; i++) {
 		struct btf_struct_meta *meta;
+		const struct btf_type *t;
 		u32 btf_id;
 
+		if (rec->fields[i].type == BPF_UPTR) {
+			/* The uptr only supports pinning one page and cannot
+			 * point to a kernel struct
+			 */
+			if (btf_is_kernel(rec->fields[i].kptr.btf))
+				return -EINVAL;
+			t = btf_type_by_id(rec->fields[i].kptr.btf,
+					   rec->fields[i].kptr.btf_id);
+			if (!t->size)
+				return -EINVAL;
+			if (t->size > PAGE_SIZE)
+				return -E2BIG;
+			continue;
+		}
+
 		if (!(rec->fields[i].type & BPF_GRAPH_ROOT))
 			continue;
 		btf_id = rec->fields[i].graph_root.value_btf_id;
@@ -5560,7 +5584,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 			goto free_aof;
 		}
 
-		ret = btf_find_kptr(btf, t, 0, 0, &tmp);
+		ret = btf_find_kptr(btf, t, 0, 0, &tmp, BPF_KPTR);
 		if (ret != BTF_FIELD_FOUND)
 			continue;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4d04d4d9c1f3..2d2935d9c096 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -548,6 +548,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 			if (rec->fields[i].kptr.module)
 				module_put(rec->fields[i].kptr.module);
 			if (btf_is_kernel(rec->fields[i].kptr.btf))
@@ -597,6 +598,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 			if (btf_is_kernel(fields[i].kptr.btf))
 				btf_get(fields[i].kptr.btf);
 			if (fields[i].kptr.module && !try_module_get(fields[i].kptr.module)) {
-- 
2.43.5


