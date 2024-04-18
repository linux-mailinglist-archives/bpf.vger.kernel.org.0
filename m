Return-Path: <bpf+bounces-27095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561838A9048
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 03:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0612D281FB2
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 01:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB577374D1;
	Thu, 18 Apr 2024 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePNiZwSd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9E1E48B
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402452; cv=none; b=lyYQI0bC6n3RhwtwHUGeWYxSmY948tCaJLu5/SZG6a2LBAHhNXpR9PwDxzYKwN1E4F9yAxo9L+/4VyeYq31ffV2XLlaXU51ey0v8i8tIVLNQiReQgu/pJKFji6rPeK3Ux1EFWRlcynrTNbIKMhfaH7MOFD4aGudK1pa5EO77dOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402452; c=relaxed/simple;
	bh=d167ZLj6rlIcq7zB/ehHfuDbNcPrOcrdXiROJHMaMDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DWGT91op20iwnthqJzos6ojAUw+fsU7ii7+3rndqG5UC3AESGxpPeXr376gBIN7+gOEOcO1m6QU4Ys57M+NSFCPnbbe/bKz74Mc98w2RUbatPq8n/0beWF6VmjN0L72XTC/SD8U0BtVfVanwtVBqptvnjXETwi7St/ZuVQrWh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePNiZwSd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b13ce3daaso6884737b3.0
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 18:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713402450; x=1714007250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Rwr3eeaVXhAcle1iJOgXmRS8H6PJaYqRipuqiAZK/g=;
        b=ePNiZwSdJHiBAAiDjdprVRScVDMZjWEwdgOCCm85HNP66RDaOdnDMUnz9qwLmLynLm
         r0+SqpEJeyC05XYn3UHRXNlnkR98GUsox7vwbUBNiRHUuDNrvEOTZSBRIPrmpUjVQp+E
         JG5baIwdAW7Qz5RrspSzJEMNAGU4uXdJvs5kdmhM7rHmlollmE2DOqmYlnJOY2m5jMix
         v/8kPoh1WALoXSHmgq5H0yIQcM07NChZOPDLH23jlXCE5RXZU37tk+Cb6khLDCBDiV2k
         /4AJaQi6af7m+ee4QKDmP/0XLsvZ0a76I5tETuGM1n+VNzTLe+ZzltZEB2ghx70Sze7T
         mehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713402450; x=1714007250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Rwr3eeaVXhAcle1iJOgXmRS8H6PJaYqRipuqiAZK/g=;
        b=VP3gH8nb/pws55qw07C/wBiN7brMyoIgectEdW8koAFYHpHRoodTfUJHNq5dfKYzEb
         lQML6DwAZwtR3KHDOczOesjE9fKIvIepDQ/XiMRkvAMpG/2s4pxrLO7wimMoRJG58DsM
         ol59FG+xA1z/B1esO9rTJx1xIPJO0rSQWhISlKU82BzSvqkH1MssvhLOxZuqEYmiwEra
         /SjLW++hKyp/nnij0A/aUQx2Mo50Kvs/gG4fc2b1Pbwbo76YW4p3+F08Gts0dzNDUgzZ
         /6jWED1QHRDAQbYFVm/wLuRa3+SodLvAVNF4aGM7vqZUQe+pJhGLeXuRyHVNcqO3ZUsm
         bQcA==
X-Gm-Message-State: AOJu0YxDwRyl4UBXNcZjM2fOl4TZSThN1Xp6Aj6uew+B4SfLdMx4dLZ/
	AnjGKoLSEnENYRU/AKv5ABR9qZbqPFsxslWMc6ZjThUXwZZ2WB9xB1/smJCIWvAnfZbv7W/jGUL
	7bg==
X-Google-Smtp-Source: AGHT+IF9WBHbd9T4P13S7pdp2zs/9YNStoaW1IUA6VdkLQOax1644i3CK82PeDUvQ1iwjkyj4mDd7BQC2QM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:f801:0:b0:61b:a3:d445 with SMTP id
 i1-20020a0df801000000b0061b00a3d445mr201303ywf.7.1713402449959; Wed, 17 Apr
 2024 18:07:29 -0700 (PDT)
Date: Thu, 18 Apr 2024 01:07:10 +0000
In-Reply-To: <20240418010723.3069001-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418010723.3069001-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418010723.3069001-2-edliaw@google.com>
Subject: [PATCH 5.15.y v2 1/5] bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM
 argument support
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Allow passing PTR_TO_CTX, if the kfunc expects a matching struct type,
and punt to PTR_TO_MEM block if reg->type does not fall in one of
PTR_TO_BTF_ID or PTR_TO_SOCK* types. This will be used by future commits
to get access to XDP and TC PTR_TO_CTX, and pass various data (flags,
l4proto, netns_id, etc.) encoded in opts struct passed as pointer to
kfunc.

For PTR_TO_MEM support, arguments are currently limited to pointer to
scalar, or pointer to struct composed of scalars. This is done so that
unsafe scenarios (like passing PTR_TO_MEM where PTR_TO_BTF_ID of
in-kernel valid structure is expected, which may have pointers) are
avoided. Since the argument checking happens basd on argument register
type, it is not easy to ascertain what the expected type is. In the
future, support for PTR_TO_MEM for kfunc can be extended to serve other
usecases. The struct type whose pointer is passed in may have maximum
nesting depth of 4, all recursively composed of scalars or struct with
scalars.

Future commits will add negative tests that check whether these
restrictions imposed for kfunc arguments are duly rejected by BPF
verifier or not.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20211217015031.1278167-4-memxor@gmail.com
(cherry picked from commit 3363bd0cfbb80dfcd25003cd3815b0ad8b68d0ff)
[edliaw: fixed up with changes from 45ce4b4f90091 ("bpf: Fix crash due to out of bounds access into reg2btf_ids.")]
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 kernel/bpf/btf.c | 93 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0c2fa93bd8d2..9a0db26a3bfa 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5441,6 +5441,46 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 #endif
 };
 
+/* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
+static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
+					const struct btf *btf,
+					const struct btf_type *t, int rec)
+{
+	const struct btf_type *member_type;
+	const struct btf_member *member;
+	u32 i;
+
+	if (!btf_type_is_struct(t))
+		return false;
+
+	for_each_member(i, t, member) {
+		const struct btf_array *array;
+
+		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
+		if (btf_type_is_struct(member_type)) {
+			if (rec >= 3) {
+				bpf_log(log, "max struct nesting depth exceeded\n");
+				return false;
+			}
+			if (!__btf_type_is_scalar_struct(log, btf, member_type, rec + 1))
+				return false;
+			continue;
+		}
+		if (btf_type_is_array(member_type)) {
+			array = btf_type_array(member_type);
+			if (!array->nelems)
+				return false;
+			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
+			if (!btf_type_is_scalar(member_type))
+				return false;
+			continue;
+		}
+		if (!btf_type_is_scalar(member_type))
+			return false;
+	}
+	return true;
+}
+
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
@@ -5449,6 +5489,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	enum bpf_prog_type prog_type = env->prog->type == BPF_PROG_TYPE_EXT ?
 		env->prog->aux->dst_prog->type : env->prog->type;
 	struct bpf_verifier_log *log = &env->log;
+	bool is_kfunc = btf_is_kernel(btf);
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
@@ -5501,7 +5542,20 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-		if (btf_is_kernel(btf)) {
+		if (btf_get_prog_ctx_type(log, btf, t,
+					  env->prog->type, i)) {
+			/* If function expects ctx type in BTF check that caller
+			 * is passing PTR_TO_CTX.
+			 */
+			if (reg->type != PTR_TO_CTX) {
+				bpf_log(log,
+					"arg#%d expected pointer to ctx, but got %s\n",
+					i, btf_type_str(t));
+				return -EINVAL;
+			}
+			if (check_ctx_reg(env, reg, regno))
+				return -EINVAL;
+		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 			const struct btf_type *reg_ref_t;
 			const struct btf *reg_btf;
 			const char *reg_ref_tname;
@@ -5517,14 +5571,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			if (reg->type == PTR_TO_BTF_ID) {
 				reg_btf = reg->btf;
 				reg_ref_id = reg->btf_id;
-			} else if (reg2btf_ids[base_type(reg->type)]) {
+			} else {
 				reg_btf = btf_vmlinux;
 				reg_ref_id = *reg2btf_ids[base_type(reg->type)];
-			} else {
-				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s but R%d is not a pointer to btf_id\n",
-					func_name, i,
-					btf_type_str(ref_t), ref_tname, regno);
-				return -EINVAL;
 			}
 
 			reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id,
@@ -5540,22 +5589,24 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					reg_ref_tname);
 				return -EINVAL;
 			}
-		} else if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
-			/* If function expects ctx type in BTF check that caller
-			 * is passing PTR_TO_CTX.
-			 */
-			if (reg->type != PTR_TO_CTX) {
-				bpf_log(log,
-					"arg#%d expected pointer to ctx, but got %s\n",
-					i, btf_type_str(t));
-				return -EINVAL;
-			}
-			if (check_ctx_reg(env, reg, regno))
-				return -EINVAL;
 		} else if (ptr_to_mem_ok) {
 			const struct btf_type *resolve_ret;
 			u32 type_size;
 
+			if (is_kfunc) {
+				/* Permit pointer to mem, but only when argument
+				 * type is pointer to scalar, or struct composed
+				 * (recursively) of scalars.
+				 */
+				if (!btf_type_is_scalar(ref_t) &&
+				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0)) {
+					bpf_log(log,
+						"arg#%d pointer type %s %s must point to scalar or struct with scalar\n",
+						i, btf_type_str(ref_t), ref_tname);
+					return -EINVAL;
+				}
+			}
+
 			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
 			if (IS_ERR(resolve_ret)) {
 				bpf_log(log,
@@ -5568,6 +5619,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			if (check_mem_reg(env, reg, regno, type_size))
 				return -EINVAL;
 		} else {
+			bpf_log(log, "reg type unsupported for arg#%d %sfunction %s#%d\n", i,
+				is_kfunc ? "kernel " : "", func_name, func_id);
 			return -EINVAL;
 		}
 	}
@@ -5617,7 +5670,7 @@ int btf_check_kfunc_arg_match(struct bpf_verifier_env *env,
 			      const struct btf *btf, u32 func_id,
 			      struct bpf_reg_state *regs)
 {
-	return btf_check_func_arg_match(env, btf, func_id, regs, false);
+	return btf_check_func_arg_match(env, btf, func_id, regs, true);
 }
 
 /* Convert BTF of a function into bpf_reg_state if possible
-- 
2.44.0.769.g3c40516874-goog


