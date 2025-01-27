Return-Path: <bpf+bounces-49907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79EA201CC
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EC2165FE4
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1130C1DE2B9;
	Mon, 27 Jan 2025 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MVSUNq5e"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E41DE2AD
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021214; cv=none; b=JLDYn7q1cW41E205q/KC6MKLzfUI9r/VjgYOM0p6d9cwJAwpWIQTpzNlsdeaFCKvL1BDM2Wa4B3tlc4U/HFrJPmO+t8D2qqZpyw8+63Ocv7fHpF5dc5GiXl6JsPZAmwvRwM8XywZAtLCutHYj/KUvngw8Lw/zRBmBhgOzUilDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021214; c=relaxed/simple;
	bh=FsP9T4F5kDsFu1q41DqM6c/7AHasopa2Usg7+Iy/qCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGOelACGsuwpBtjLS0I4boye6Clhj15y1F0amOFaEp6xzvSNWRlwNneg0id+oC3aTMFes7Qk4P9jQhG3lDLH23yg2Z2WVXZ5iGFaUVEasmgFlSMOGxpBTk0YhA0wDKjk8W9NtCROcqO+nV3cfV+fbEsGQUnXF0G3927joaMKPmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MVSUNq5e; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738021211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXCgDwz11jFQTl+vBsVmWkn/uJEuFA/IFlsVQi7HN5A=;
	b=MVSUNq5eyrSUP6rpxqsyEYa5p0LzhfmjVWXGPQwBdN09jzshzYJNZhwZvYX7TtrGejjvCR
	6AK7ue+EpSWrKx13a0juQpi1LPd/nChfSUXVZAKFnTABXyedMFcghqDWxPGiQljVCb5LHi
	Jmt2DxZBCM0//uf2tV5ulhB+jfEMots=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	jose.marchesi@oracle.com
Subject: [PATCH bpf-next v2 5/6] bpf: allow kind_flag for BTF type and decl tags
Date: Mon, 27 Jan 2025 15:39:54 -0800
Message-ID: <20250127233955.2275804-6-ihor.solodrai@linux.dev>
In-Reply-To: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
References: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

BTF type tags and decl tags now may have info->kflag set to 1,
changing the semantics of the tag.

Change BTF verification to permit BTF that makes use of this feature:
  * remove kflag check in btf_decl_tag_check_meta(), as both values
    are valid
  * allow kflag to be set for BTF_KIND_TYPE_TAG type in
    btf_ref_type_check_meta()

Make sure kind_flag is NOT set when checking for specific BTF tags,
such as "kptr", "user" etc.

Modify a selftest checking for kflag in decl_tag accordingly.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/btf.c                             | 26 +++++++++-----------
 tools/testing/selftests/bpf/prog_tests/btf.c |  4 +--
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8396ce1d0fba..98919c6b6b87 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2575,7 +2575,7 @@ static int btf_ref_type_check_meta(struct btf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (btf_type_kflag(t)) {
+	if (btf_type_kflag(t) && BTF_INFO_KIND(t->info) != BTF_KIND_TYPE_TAG) {
 		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
 		return -EINVAL;
 	}
@@ -3332,6 +3332,8 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 			 u32 off, int sz, struct btf_field_info *info, u32 field_mask)
 {
 	enum btf_field_type type;
+	const char *tag_value;
+	bool is_type_tag;
 	u32 res_id;
 
 	/* Permit modifiers on the pointer itself */
@@ -3341,19 +3343,20 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	if (!btf_type_is_ptr(t))
 		return BTF_FIELD_IGNORE;
 	t = btf_type_by_id(btf, t->type);
-
-	if (!btf_type_is_type_tag(t))
+	is_type_tag = btf_type_is_type_tag(t) && !btf_type_kflag(t);
+	if (!is_type_tag)
 		return BTF_FIELD_IGNORE;
 	/* Reject extra tags */
 	if (btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
 		return -EINVAL;
-	if (!strcmp("kptr_untrusted", __btf_name_by_offset(btf, t->name_off)))
+	tag_value = __btf_name_by_offset(btf, t->name_off);
+	if (!strcmp("kptr_untrusted", tag_value))
 		type = BPF_KPTR_UNREF;
-	else if (!strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
+	else if (!strcmp("kptr", tag_value))
 		type = BPF_KPTR_REF;
-	else if (!strcmp("percpu_kptr", __btf_name_by_offset(btf, t->name_off)))
+	else if (!strcmp("percpu_kptr", tag_value))
 		type = BPF_KPTR_PERCPU;
-	else if (!strcmp("uptr", __btf_name_by_offset(btf, t->name_off)))
+	else if (!strcmp("uptr", tag_value))
 		type = BPF_UPTR;
 	else
 		return -EINVAL;
@@ -4944,11 +4947,6 @@ static s32 btf_decl_tag_check_meta(struct btf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (btf_type_kflag(t)) {
-		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
-		return -EINVAL;
-	}
-
 	component_idx = btf_type_decl_tag(t)->component_idx;
 	if (component_idx < -1) {
 		btf_verifier_log_type(env, t, "Invalid component_idx");
@@ -6743,7 +6741,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	info->btf_id = t->type;
 	t = btf_type_by_id(btf, t->type);
 
-	if (btf_type_is_type_tag(t)) {
+	if (btf_type_is_type_tag(t) && !btf_type_kflag(t)) {
 		tag_value = __btf_name_by_offset(btf, t->name_off);
 		if (strcmp(tag_value, "user") == 0)
 			info->reg_type |= MEM_USER;
@@ -7002,7 +7000,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 
 			/* check type tag */
 			t = btf_type_by_id(btf, mtype->type);
-			if (btf_type_is_type_tag(t)) {
+			if (btf_type_is_type_tag(t) && !btf_type_kflag(t)) {
 				tag_value = __btf_name_by_offset(btf, t->name_off);
 				/* check __user tag */
 				if (strcmp(tag_value, "user") == 0)
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index e63d74ce046f..aab9ad88c845 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3866,7 +3866,7 @@ static struct btf_raw_test raw_tests[] = {
 	.err_str = "vlen != 0",
 },
 {
-	.descr = "decl_tag test #8, invalid kflag",
+	.descr = "decl_tag test #8, tag with kflag",
 	.raw_types = {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
@@ -3881,8 +3881,6 @@ static struct btf_raw_test raw_tests[] = {
 	.key_type_id = 1,
 	.value_type_id = 1,
 	.max_entries = 1,
-	.btf_load_err = true,
-	.err_str = "Invalid btf_info kind_flag",
 },
 {
 	.descr = "decl_tag test #9, var, invalid component_idx",
-- 
2.48.1


