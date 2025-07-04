Return-Path: <bpf+bounces-62456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2673AF9CAC
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 01:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6015870A4
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CF528FFFB;
	Fri,  4 Jul 2025 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duiDqful"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AE28DEE9
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751670252; cv=none; b=WaURGTUIA+MKrZfoOFZy97KOkpkUhPFdtKUVkNBsB22ZrWC/g1NyTnNQWu6YThKIpV9XHFC9jZV5S5aplBcwwsXJB/CZTqzQCGaB4IeejNSjttcxQNIzPqlXcHrxyes/yGeGSy0nhlJwmMlgzsceJcJ7jxXnRoDltoP0G8eZpVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751670252; c=relaxed/simple;
	bh=Y25iwu8U1RSbSLfhD/ARiT3kaslfCBfPPBWIoYHpfWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUzhaj6Z56QTfTR9zM0kZ3oyhHg2RkN3Cp4xa/fq93Ytp4RThx3w7D/xnMMmQIDDfNzfBfDL74SAu+rrMaZVgq1YMlWhrpC/0AS2WvQgSofWDz5N9VxdLtcn2xuVfjuXKrjH9sZJxiKQx3bUymEaKZvZQ3QIu+yWmTeBoLsiMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duiDqful; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748feca4a61so801534b3a.3
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751670250; x=1752275050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6itLchFCe6uud5EjpzTzCgu9Zx1cLruWIuEHnsEER/g=;
        b=duiDqfull/B3f9HCl5W6W+L3OyZOzaEvZVRGpvaPLcUPBhoVuLzC9mIKhmjrPAe7bY
         Ou45a63lIzLHJyLPqlThh2Pqfo4FhG1V5TpoEFm7qwgMibWltlP8sKemBxWmgNGcojJc
         IiA2RnBfWLMDXHsKdu2TTlvgM8ExYqJSQgAHBuSNbR5h82DkQ41nnF8kGJqGHKToPJWK
         NBmXgQ4UG0ZTVS97BvbmsgJaW0clm/HvQg51aeYe+qqXGCrKV7gmI+rPMxU3MAzZjbJb
         vSTmkNW03NXZ2mQY5EaEsIuB04FPiq3E6M5uprsRlAYx6PMy3+lELef7CqbwTSEW+HW6
         uJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751670250; x=1752275050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6itLchFCe6uud5EjpzTzCgu9Zx1cLruWIuEHnsEER/g=;
        b=vDfzWPAJ6zpDDmbN8xSCyMhYFrXXSxyd6FyNZQNc6sFHJV7LUC4TaFYMAe6GV0FC2G
         irkbjxqs8L8UybVHIpsb1MSQqQkMaMzufFhxUd3Z91bsxPYRDi2MrSIQrzFAXG/3MOps
         AUKyZEm2Aps4VxLz4r8fwyEuZnLZrf/2d4VUTcXyv4Nzl/euWu9c/T4fxZjQlTWa0L9G
         ypY897Rk3PUtoaoZbRTV3sCHym4oUxRiPXSiYSc3JbD17kK2Jhl2t9Ptrs3bTJwLITD1
         gEwYSqcOmXi7AT6PL7pdii0OENvAbJ9DaPYFqg7rcMJFSP9M+nq2SYBQVaeyvCofhM3S
         v58Q==
X-Gm-Message-State: AOJu0YxgDrlwXQwufW8hO1nxNrWqNIcPp7jVSm6Jtgva6HbxU9aC+j0B
	0WADcHLXYkW0pb2qypzBy9H0ho32LZO30d7baPfnATEFLozRKIaONhkWi5nVUA==
X-Gm-Gg: ASbGncvZH1tMqDwt706mc23/ZoxIrAJ/gxEa+9Lu3/e8gZ2f31DU0smBrz3wkBe8SV9
	NsCYEpQjfrhCtoMZxCse8W69b1znZgnJNzBBk9nFW8OblxAZ/+F154T7TneZXQIjYlxI3TjQdBH
	sIh7RDvWwHdbRt+xacW/zOF3tF5cvsfNhdjl7z/0VNgoGJxQedxwpb7Fh78zuDiH0gCCSFlBDyB
	Ccuo1uSm43sxaKc2F02pw+x8IoVBEAEZt0qDp/0CWvnlD5b4DZBn+1HlANXBq4cbFLtEjHC3TQo
	9dJ4A1fBs5SdfU1r+SYzQwMP15TAKamD5KK+UIlcqb9zWteuNzry4RWR9Q==
X-Google-Smtp-Source: AGHT+IEG3twVr2FVrbGszNz2bkrRyuojsWDPBXA5A1xxFEahOf61WBWfZNLbVIoZcE1XOFZR85fDtw==
X-Received: by 2002:a05:6300:6c16:b0:226:c204:3c40 with SMTP id adf61e73a8af0-226c2043dcemr1459583637.5.1751670250511;
        Fri, 04 Jul 2025 16:04:10 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38f879d040sm1764447a12.44.2025.07.04.16.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:04:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 7/8] bpf: support for void/primitive __arg_untrusted global func params
Date: Fri,  4 Jul 2025 16:03:53 -0700
Message-ID: <20250704230354.1323244-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704230354.1323244-1-eddyz87@gmail.com>
References: <20250704230354.1323244-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow specifying __arg_untrusted for void */char */int */long *
parameters. Treat such parameters as
PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED of size zero.
Intended usage is as follows:

  int memcmp(char *a __arg_untrusted, char *b __arg_untrusted, size_t n) {
    bpf_for(i, 0, n) {
      if (a[i] - b[i])      // load at any offset is allowed
        return a[i] - b[i];
    }
    return 0;
  }

Allocate register id for ARG_PTR_TO_MEM parameters only when
PTR_MAYBE_NULL is set. Register id for PTR_TO_MEM is used only to
propagate non-null status after conditionals.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/btf.c      | 15 ++++++++++++++-
 kernel/bpf/verifier.c |  7 ++++---
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index a40beb9cf160..9eda6b113f9b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -223,6 +223,7 @@ u32 btf_nr_types(const struct btf *btf);
 struct btf *btf_base_btf(const struct btf *btf);
 bool btf_type_is_i32(const struct btf_type *t);
 bool btf_type_is_i64(const struct btf_type *t);
+bool btf_type_is_primitive(const struct btf_type *t);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e0414d9f5e29..2dd13eea7b0e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -891,6 +891,12 @@ bool btf_type_is_i64(const struct btf_type *t)
 	return btf_type_is_int(t) && __btf_type_int_is_regular(t, 8);
 }
 
+bool btf_type_is_primitive(const struct btf_type *t)
+{
+	return (btf_type_is_int(t) && btf_type_int_is_regular(t)) ||
+	       btf_is_any_enum(t);
+}
+
 /*
  * Check that given struct member is a regular int with expected
  * offset and size.
@@ -7830,6 +7836,13 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				return -EINVAL;
 			}
 
+			ref_t = btf_type_skip_modifiers(btf, t->type, NULL);
+			if (btf_type_is_void(ref_t) || btf_type_is_primitive(ref_t)) {
+				sub->args[i].arg_type = ARG_PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED;
+				sub->args[i].mem_size = 0;
+				continue;
+			}
+
 			kern_type_id = btf_get_ptr_to_btf_id(log, i, btf, t);
 			if (kern_type_id < 0)
 				return kern_type_id;
@@ -7838,7 +7851,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			ref_t = btf_type_by_id(vmlinux_btf, kern_type_id);
 			if (!btf_type_is_struct(ref_t)) {
 				tname = __btf_name_by_offset(vmlinux_btf, t->name_off);
-				bpf_log(log, "arg#%d has type %s '%s', but only struct types are allowed\n",
+				bpf_log(log, "arg#%d has type %s '%s', but only struct or primitive types are allowed\n",
 					i, btf_type_str(ref_t), tname);
 				return -EINVAL;
 			}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7af902c3ecc3..1e567fff6f23 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23152,11 +23152,12 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
 				reg->type = PTR_TO_MEM;
-				if (arg->arg_type & PTR_MAYBE_NULL)
-					reg->type |= PTR_MAYBE_NULL;
+				reg->type |= arg->arg_type &
+					     (PTR_MAYBE_NULL | PTR_UNTRUSTED | MEM_RDONLY);
 				mark_reg_known_zero(env, regs, i);
 				reg->mem_size = arg->mem_size;
-				reg->id = ++env->id_gen;
+				if (arg->arg_type & PTR_MAYBE_NULL)
+					reg->id = ++env->id_gen;
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
 				reg->type = PTR_TO_BTF_ID;
 				if (arg->arg_type & PTR_MAYBE_NULL)
-- 
2.49.0


