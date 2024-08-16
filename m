Return-Path: <bpf+bounces-37393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADAB955140
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD2E4B21A7B
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CEC1C3F3E;
	Fri, 16 Aug 2024 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bag+R0T3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51F1C3F25
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835543; cv=none; b=YloLQwj6OSjY5QDTeaP0CxsoL0V70psGzeNCQmEj4xvaacR73DagTslXdcAi6uOzyoJS6CAfehx6YqlGDuWo4OUFBwORoVrYBUAaGXVcCFmRBkQzOK6ttGZpLhQ0vp+R9Zpt7YQ69e8asgoSwq7f6X3FrZLO2bm5EfUJDS0V4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835543; c=relaxed/simple;
	bh=2kOtRv7qB6Foh6TYAjMuRKyqQS09rtUXbv1HfzFhBpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZO4RxPXjI50D5uuQ3/c3pHH4GphA0nRtb4atv7oiIgxsaP4ib/ki6a+ZakSXV7VoY917/27hc/1JVmrzwZPGag+DeEsCHbNEKPjwYWGDvucmrAnk3LRhx2BUNz+3wSw1AV+JDUfEYBPFVrCYGQULt8WSqV3fX3Mj0nQBrY/kDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bag+R0T3; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso1746657276.1
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723835541; x=1724440341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQuSW7ZjyolAixejdxlo5ouKzCwC+WVNTWhjPrUWT8U=;
        b=bag+R0T3fUtQWsJGqKdjEf5R6mkh29Y0zRbQYD5mMmIDbwf6hvg4HSeyIzhTaIjBc9
         uS0eKw4eMjVMec4to9PaSkXi8NbaGchFTUYHbmHmMFC7CHBpfdvQC9qZO01CPsxFe3cf
         Z5xCeviOGYnqa9p95BPRtOpr5Qp+v/52im/GvXKm55nMeurU2BYRrCce8mOa+E2ubDuX
         8VPj7QPl/rBeO7FVMlxQyyW1nFJ5X5lvJYFMSeOeP7caRBczk1QKdpSv6arx16Dn+2gh
         IpCTpYdllrVMvs6VL7bY8VtQ17UvdH2sbwq7BmOGQJp7RGIxscQ2V6lVJj0kq8CRCrJj
         WVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835541; x=1724440341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQuSW7ZjyolAixejdxlo5ouKzCwC+WVNTWhjPrUWT8U=;
        b=DapNG6rBcw1vtVj8wE974bYmcFuE3VlGyHkkpJLLyB+vkmn3qz/Ym5CthdFO6JvfFT
         OL0Oei1Td2YV0iO0H+yWExeHpdm9+P38eiexS1G7PpjVQeUyxzkavw3ENnoqhSI4OEUe
         /nnfdihx8joMK4XZ+O2yD8xot7teNeiuibvzsScnpm5n4kH450o/5bgH7loYT/CT5NbO
         9qGs88Qr1MMrJZCJIsgbbqrcfMkVihDBWj60kIe0yXxBCi3LjIXiYK6mZbV+pmsinAk5
         R59iVCpQ1LcrnT77ZE+bvrca22bKJL0WGT9KI4cPdSfLwgVRaqbjNcROwVd3QqYkDbKq
         iLfg==
X-Gm-Message-State: AOJu0YwiDzRQvLXn6P8shJnKofnRrZljBZNFpbziLmRQ6z325XtOqSyx
	qPqRfF4m2OMVKZi96PXWDUSr36H3qKEOIgON7YaYsbw6AyomPsW3iREJvkfz
X-Google-Smtp-Source: AGHT+IEkfPIIznB4Ydy8J38+Y8OkTy3lpGHmET5INtt6TQ3VnufN5MXtb1mge7HcLwtBjmvvg6YOYA==
X-Received: by 2002:a05:690c:318d:b0:6ac:3043:168a with SMTP id 00721157ae682-6b1eef8240cmr24740727b3.10.1723835540775;
        Fri, 16 Aug 2024 12:12:20 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ca12:c8db:5571:aa13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a50dsm7233327b3.94.2024.08.16.12.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:12:20 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 3/6] bpf: Handle BPF_UPTR in verifier.
Date: Fri, 16 Aug 2024 12:12:10 -0700
Message-Id: <20240816191213.35573-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816191213.35573-1-thinker.li@gmail.com>
References: <20240816191213.35573-1-thinker.li@gmail.com>
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


