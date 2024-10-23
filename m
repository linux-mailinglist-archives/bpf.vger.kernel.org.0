Return-Path: <bpf+bounces-42970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3109AD89B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251421C2141F
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0531FAC51;
	Wed, 23 Oct 2024 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wb678N5H"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49041AA79C
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727312; cv=none; b=SYypzb6HXyatv2MxB64QzWBlqHrVmwMLmAHwg33hEkMTsdcHK1uhRRktbnU6p/jVspd7oSK6+ObVusK6Jj4b+hHkcqkVz++3IfGw5Uu7aTMBQCitbj7t0EZDd94fFfUB+Y2mhKYr8lWyQLv/C0oF+AVYFjHMaPmV8cXeDUTspeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727312; c=relaxed/simple;
	bh=4GXC9NW2t24Dco01DPONxqvynBFkWOkCKFqvUwdCNC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sha4LWCoatG8ayGwMxPoU64LxV1NYz8Ae8EkWuG3kvtoyTx4HwJ3WI3DqZTFpGkBUz5kp73EzpJVcDtP1C+lqNTACRKWoW7vH1sVDQp+fSvn2uyEaxUfpxdVNrWC1bmRLMC3Byui9Zil/bWow77FfJnXkWv3eIZAr3fg7vG0Uk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wb678N5H; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729727308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogTBv8RyiGd2S7Nup6y6N6ykiJDTc7QUyu84Tn1uQeI=;
	b=wb678N5Hf7hObZp8hYjcPRivkb35uj5azCafP+mbpqvfcU9/O397e5StsnVaB9TD724kxu
	N+GfWOxQ3CUe8K/uVJtWwIVgUEXE0jMLUSBLius5+ABKXp/yet1O2xi7xqOrgiN0ZHbkyX
	ycFNRTjQzD1DK6l9VCvdw5v1a0tcrus=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v6 bpf-next 02/12] bpf: Handle BPF_UPTR in verifier
Date: Wed, 23 Oct 2024 16:47:49 -0700
Message-ID: <20241023234759.860539-3-martin.lau@linux.dev>
In-Reply-To: <20241023234759.860539-1-martin.lau@linux.dev>
References: <20241023234759.860539-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kui-Feng Lee <thinker.li@gmail.com>

This patch adds BPF_UPTR support to the verifier. Not that only the
map_value will support the "__uptr" type tag.

This patch enforces only BPF_LDX is allowed to the value of an uptr.
After BPF_LDX, it will mark the dst_reg as PTR_TO_MEM | PTR_MAYBE_NULL
with size deduced from the field.kptr.btf_id. This will make the
dst_reg pointed memory to be readable and writable as scalar.

There is a redundant "val_reg = reg_state(env, value_regno);" statement
in the check_map_kptr_access(). This patch takes this chance to remove
it also.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
Changes in v5:
  - The "if (kptr_field->type == BPF_UPTR)" addition in v4 in 
    map_kptr_match_type() is removed. It will not be reached.
    meta->kptr_field is for kptr only.
  - Use btf_field_type_name() for the verbose() log in check_map_access().
  - Directly use t->size in mark_uptr_ld_reg. "t" must be a struct.

 kernel/bpf/verifier.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f514247ba8ba..1bd0c3f41f2f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5485,6 +5485,22 @@ static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_field *kptr
 	return ret;
 }
 
+static int mark_uptr_ld_reg(struct bpf_verifier_env *env, u32 regno,
+			    struct btf_field *field)
+{
+	struct bpf_reg_state *reg;
+	const struct btf_type *t;
+
+	t = btf_type_by_id(field->kptr.btf, field->kptr.btf_id);
+	mark_reg_known_zero(env, cur_regs(env), regno);
+	reg = reg_state(env, regno);
+	reg->type = PTR_TO_MEM | PTR_MAYBE_NULL;
+	reg->mem_size = t->size;
+	reg->id = ++env->id_gen;
+
+	return 0;
+}
+
 static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 				 int value_regno, int insn_idx,
 				 struct btf_field *kptr_field)
@@ -5513,9 +5529,15 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		verbose(env, "store to referenced kptr disallowed\n");
 		return -EACCES;
 	}
+	if (class != BPF_LDX && kptr_field->type == BPF_UPTR) {
+		verbose(env, "store to uptr disallowed\n");
+		return -EACCES;
+	}
 
 	if (class == BPF_LDX) {
-		val_reg = reg_state(env, value_regno);
+		if (kptr_field->type == BPF_UPTR)
+			return mark_uptr_ld_reg(env, value_regno, kptr_field);
+
 		/* We can simply mark the value_regno receiving the pointer
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
@@ -5573,21 +5595,26 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 			case BPF_KPTR_UNREF:
 			case BPF_KPTR_REF:
 			case BPF_KPTR_PERCPU:
+			case BPF_UPTR:
 				if (src != ACCESS_DIRECT) {
-					verbose(env, "kptr cannot be accessed indirectly by helper\n");
+					verbose(env, "%s cannot be accessed indirectly by helper\n",
+						btf_field_type_name(field->type));
 					return -EACCES;
 				}
 				if (!tnum_is_const(reg->var_off)) {
-					verbose(env, "kptr access cannot have variable offset\n");
+					verbose(env, "%s access cannot have variable offset\n",
+						btf_field_type_name(field->type));
 					return -EACCES;
 				}
 				if (p != off + reg->var_off.value) {
-					verbose(env, "kptr access misaligned expected=%u off=%llu\n",
+					verbose(env, "%s access misaligned expected=%u off=%llu\n",
+						btf_field_type_name(field->type),
 						p, off + reg->var_off.value);
 					return -EACCES;
 				}
 				if (size != bpf_size_to_bytes(BPF_DW)) {
-					verbose(env, "kptr access size must be BPF_DW\n");
+					verbose(env, "%s access size must be BPF_DW\n",
+						btf_field_type_name(field->type));
 					return -EACCES;
 				}
 				break;
@@ -6953,7 +6980,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return err;
 		if (tnum_is_const(reg->var_off))
 			kptr_field = btf_record_find(reg->map_ptr->record,
-						     off + reg->var_off.value, BPF_KPTR);
+						     off + reg->var_off.value, BPF_KPTR | BPF_UPTR);
 		if (kptr_field) {
 			err = check_map_kptr_access(env, regno, value_regno, insn_idx, kptr_field);
 		} else if (t == BPF_READ && value_regno >= 0) {
-- 
2.43.5


