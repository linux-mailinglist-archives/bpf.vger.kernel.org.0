Return-Path: <bpf+bounces-37146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA1C951317
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 05:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A01B21717
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26343FB3B;
	Wed, 14 Aug 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR4USPn3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC03BBE9
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606219; cv=none; b=LgeNIRgxgje8xRHkPdtVX/6cWQx8VMxx5odtdsq7SBY4yacqbalGcya96/KrQ7DDG8yLMzqZtl5uapt+k3KlQ5udJdajSXtxmDCwdZ6VZemQIwpA4UJkH+cjU92jyRI13V42QJ/29YLDEi9x9YghkUrhfisZL7wrqXxKkOdtOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606219; c=relaxed/simple;
	bh=2kOtRv7qB6Foh6TYAjMuRKyqQS09rtUXbv1HfzFhBpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVKZ42P9YZYI+F11Tn/1HsOI6HhlWcLMuGeDPwM1P9rOHa5pqL/U5JR3tNUh8k7WmuRSZ7aUMoGPa45cfEx4dU2lrq6itTr08bELCiZyMp/Jw/8b319Jr3NC9YygkeJU62Sne5oV5pIef8Ns0oNoKSdZW8f2UqvSFTe1lb+6pAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR4USPn3; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-66599ca3470so59057477b3.2
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 20:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723606217; x=1724211017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQuSW7ZjyolAixejdxlo5ouKzCwC+WVNTWhjPrUWT8U=;
        b=mR4USPn3vk/DbQ8znFr9tmj+lKqBzAyDIqMeSg1fcRNNNBeS/l4YufJvSmFbEr8hP9
         RzN/3Mxvk1g/XhR394UTRg600VZHkk6NhzWdOtmbSyV7IOH8sDc1l5eugytRhmZEEfMJ
         1973QCI5TDRRIlDhNJ1ju1aH7KG4DIsAuqw56EWsvXIN1YWPMRoZy9DCx7tFCR9RLTK8
         cCLO5C1UbUN4Qg9la9bPzHvTcU4mG9r2wCGSc65IDan9KlB2OHKtxh0CZH+peKU2HY1I
         Y5r9vcbWcyPQHu2qQfN2SCf5mduW4DSWj5DZEUu49UN5rWCIl61/pBwRQsRuXIfgMAWu
         ZiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723606217; x=1724211017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQuSW7ZjyolAixejdxlo5ouKzCwC+WVNTWhjPrUWT8U=;
        b=ItSP+PQ3ASE668GECNGY5c8uKJZYyow0SlqsBUpOLz+AUFvuu3Ru3UfOeSNBnkUY7M
         ZIa+SEhsLInXKqbzQ8APOAcKok09VY41BU+RMRt+XsG9OjM9xRvaxDjBPRr/SsOedRR6
         nuxoTD2h8sqSBCUrei97fTtED9dE314Yc48gMRQNcFIPDFE9ikhvIB2pwuusxbNMTjwE
         I51yDJ0GC80R+7chgnUcKTLRG+iEbIgW7XKvnQsmyaFBY6/sicdJ9Yd5H1Ys7rnJPlcG
         XCm4d+GnzZ6ufHtkjrrn9HVbDDouVPmqTt2oYyYj0kcJavXfWxUC/tc3gdlGoHiMNtPF
         sPQA==
X-Gm-Message-State: AOJu0YwLdYGQStDOccNVKs03bq2uD8Wxh3P1UwHs8aEUqyzMzdntVNcL
	A13nbnnmAXmOcyn5K/U9l4G9JedaQHYmV4Jir8kytDxx1G2IOV9H/eLtiDXC
X-Google-Smtp-Source: AGHT+IFTjt8hdnrdZ3eu+mx20nMdPS4U4+x98qaNTM7mTckQB1RPjlwuEvlmCHNCtyJHrlc8h4oOSQ==
X-Received: by 2002:a05:690c:ecc:b0:64b:69f0:f8f2 with SMTP id 00721157ae682-6ac9621a6fcmr16845777b3.3.1723606216636;
        Tue, 13 Aug 2024 20:30:16 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:3c23:99cc:16a9:8b68])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b597sm15109587b3.117.2024.08.13.20.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:30:16 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v3 3/7] bpf: Handle BPF_UPTR in verifier.
Date: Tue, 13 Aug 2024 20:30:06 -0700
Message-Id: <20240814033010.2980635-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814033010.2980635-1-thinker.li@gmail.com>
References: <20240814033010.2980635-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Give PTR_TO_MEM | PTR_MAYBE_NULL to the memory pointed by an uptr with the
size of the pointed type to make them readable and writable.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/verifier.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3932f8ce10a..5bc5b37b63cc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5340,6 +5340,10 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	int perm_flags;
 	const char *reg_name = "";
 
+	if (kptr_field->type == BPF_UPTR)
+		/* BPF programs should not change any user kptr */
+		return -EACCES;
+
 	if (btf_is_kernel(reg->btf)) {
 		perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
 
@@ -5488,6 +5492,29 @@ static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_field *kptr
 	return ret;
 }
 
+static int mark_uptr_ld_reg(struct bpf_verifier_env *env, u32 regno,
+			    struct btf_field *field)
+{
+	struct bpf_reg_state *val_reg;
+	const struct btf_type *t;
+	u32 type_id, tsz;
+
+	val_reg = reg_state(env, regno);
+	type_id = field->kptr.btf_id;
+	t = btf_type_id_size(field->kptr.btf, &type_id, &tsz);
+	if (!t) {
+		verbose(env, "The type of uptr is invalid");
+		return -EACCES;
+	}
+
+	mark_reg_known_zero(env, cur_regs(env), regno);
+	val_reg->type = PTR_TO_MEM | PTR_MAYBE_NULL;
+	val_reg->mem_size = tsz;
+	val_reg->id = ++env->id_gen;
+
+	return 0;
+}
+
 static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 				 int value_regno, int insn_idx,
 				 struct btf_field *kptr_field)
@@ -5516,9 +5543,16 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		verbose(env, "store to referenced kptr disallowed\n");
 		return -EACCES;
 	}
+	if (class != BPF_LDX && kptr_field->type == BPF_UPTR) {
+		verbose(env, "store to uptr disallowed\n");
+		return -EACCES;
+	}
 
 	if (class == BPF_LDX) {
 		val_reg = reg_state(env, value_regno);
+		if (kptr_field->type == BPF_UPTR)
+			return mark_uptr_ld_reg(env, value_regno, kptr_field);
+
 		/* We can simply mark the value_regno receiving the pointer
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
@@ -5576,6 +5610,7 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 			case BPF_KPTR_UNREF:
 			case BPF_KPTR_REF:
 			case BPF_KPTR_PERCPU:
+			case BPF_UPTR:
 				if (src != ACCESS_DIRECT) {
 					verbose(env, "kptr cannot be accessed indirectly by helper\n");
 					return -EACCES;
@@ -6956,7 +6991,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return err;
 		if (tnum_is_const(reg->var_off))
 			kptr_field = btf_record_find(reg->map_ptr->record,
-						     off + reg->var_off.value, BPF_KPTR);
+						     off + reg->var_off.value, BPF_KPTR | BPF_UPTR);
 		if (kptr_field) {
 			err = check_map_kptr_access(env, regno, value_regno, insn_idx, kptr_field);
 		} else if (t == BPF_READ && value_regno >= 0) {
-- 
2.34.1


