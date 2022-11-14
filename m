Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A8A628918
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiKNTQ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbiKNTQm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:42 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9616427CCE
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:40 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p21so10957213plr.7
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+LkDCN+FUAB0DSRYHtbfHGdldxcjkmkvBSRI2uvuvc=;
        b=bFemB5S+ic1oYzhh+Q+TfI2gx3xWiSoTyCaWSb3kNxroH0CK/Cnh5pcq66rVM+YMoF
         QsRQnLxcex0VbM982vjN38UG3WVHKFhyVtV55QRgxZsgMXxStQVm+VUAOFOXIvRQqcBq
         0YyNszmDzOsSupkV92sR4DNJAPvKyX2kw1uVAUJ6/PAQyGGM845cjFs+WQbCB9PEVcFS
         ZYoC6hN/olcrT+uEPgYANUrMTMddohafYe9zi77mmxD0e0XwkkvzM1pGxDVTpEINP3jA
         gGufieItJAcV/m5h1qpuMmQvbdZuuEIJ09zPy8KJsEjxMfCTON1IsS3QghiwhMC+bBtM
         GE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+LkDCN+FUAB0DSRYHtbfHGdldxcjkmkvBSRI2uvuvc=;
        b=2HJEWupnKadRnF5v2nxV7MvC8s9g1aHppAMp+ySQ+bUB2/KxG9qRxUTs025A0eluBB
         T0CS8nssguXlERrFs+6oIV7ouNH/IX3wAiOslsAtSQvxCoM2/XNLvGiIBeJCMcEMBHFI
         jc0DhvYll034bcIIe+bjOGf9x+H4xgAlcM+drOmOehYs8SjxCSYbTlmXe8BHwpBnVoPg
         u3dDT9/UCiZgTIuSjqyV0r046wknXDQqjAidi+X92PZToog/4LzqfkEGscY6zqOB8MFG
         gFFOhZuLrKaG+KoBYdgJXsUxErAe94rMyFqvLu2PgAgrinasoKw3HOCM3Co39fXRd7Hy
         hOVA==
X-Gm-Message-State: ANoB5pmrVgCTIu9rf7ZvnLDiLEs76VghHYnTN3oYkA67uXjKy094hUiY
        nG/stnBCyien+MLxayKii0P4QaCiHZYw/w==
X-Google-Smtp-Source: AA0mqf6M8i2W3ONqvboyKdIefYMovinfbtJ7/z2n+k+lEWBKC4UJE3rKtE/Qg3Sl6YDp6/wFfPRSyw==
X-Received: by 2002:a17:90a:9746:b0:214:2920:4675 with SMTP id i6-20020a17090a974600b0021429204675mr14963695pjw.0.1668453400018;
        Mon, 14 Nov 2022 11:16:40 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id z18-20020a634c12000000b00434760ee36asm6101263pga.16.2022.11.14.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:39 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 16/26] bpf: Support constant scalar arguments for kfuncs
Date:   Tue, 15 Nov 2022 00:45:37 +0530
Message-Id: <20221114191547.1694267-17-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5263; i=memxor@gmail.com; h=from:subject; bh=/CN4/sJC0FjD34jM8x+dKNRs6I02WDF547SBhA3s2dk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPJbc8c8yHaLF7QaapbJouiPlwg2hAJVEbXY9pE W9HKkjSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyQAKCRBM4MiGSL8RykroEA CAdVp2k+LplHBXCb2BCHirfi0vrR4C2eNUR5cPR8avS+BSxzfTv3Uf6+DyhQHoej/C3/+i/gCe64cO kWm2+ZDJ3QxYAcIb/JFON2eN1gwWco4x6d2Ck4LV68YXCvkC60b+7VqxXTj5/h1Ntxni/dbbrCu8of Ix+yYGPTH9jTBRWvBCKe4INxF7VAnjXwsgPWPmADqBzbE3QmS6oGBMixdJ4g7Ovu2SQAQyzWTDul6I JPtaeK78eXmKJFFimIWGIVlk+PWYg8vIzrhj7o+OTGdI/Duop6NnNn98xBGoJqH/cDFJJSLkOalIU6 ai1VfUkPQIp68AWy3FF9U6jaNlaUIAO9hXWZ/Z5+J5vy0MkQm6jW+dq0iVRQ2qI9X0oZKFgImvnW9F IvHOZolrc0YPrBBDqDs/95Bkzjwg5pUY91Cc/ViEU1QmgufFeEfSU+4TU0EoN+PnJEtBYM9ysxd9ns gNhnqfDLFTs24R3yE2fh/0sqbLLwKYssqBv6pLOmdaKHJMRUMJ1lRKGrEZUfrYMQfaCG47QvH6xpec z2YFdRHvBBVY4fWD7Qqu5JA7IV2dzrF14hzqX9+vXLVHItqwZqC/0msgJC257SVnQJj/5XOvuFw9hS /SsIrB4ZYaGxYboHLGKRtjXDtxsaC1wQZi0Jt8qJfRUwdHJMkTZG41IA8XFg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow passing known constant scalars as arguments to kfuncs that do not
represent a size parameter. This makes the search pruning optimization
of verifier more conservative for such kfunc calls, and each
non-distinct argument is considered unequivalent.

We will use this support to then expose a bpf_obj_new function where it
takes the local type ID of a type in program BTF, and returns a
PTR_TO_BTF_ID | MEM_ALLOC to the local type, and allows programs to
allocate their own objects.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 22 ++++++++++++++
 kernel/bpf/verifier.c        | 59 +++++++++++++++++++++++++++---------
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0f858156371d..8fa9c052417f 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -72,6 +72,28 @@ argument as its size. By default, without __sz annotation, the size of the type
 of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
 pointer.
 
+2.2.1 __k Annotation
+--------------------
+
+This annotation is only understood for scalar arguments, where it indicates that
+the verifier must check the scalar argument to be a known constant, which does
+not indicate a size parameter.
+
+An example is given below::
+
+        void *bpf_obj_new(u32 local_type_id__k, ...)
+        {
+        ...
+        }
+
+Here, bpf_obj_new uses local_type_id argument to find out the size of that type
+ID in program's BTF and return a sized pointer to it. Each type ID will have a
+distinct size, hence it is crucial to treat each such call as distinct when
+values don't match.
+
+Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
+size parameter, __k suffix should be used.
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d95b6cc63e38..a4a1424b19a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7871,6 +7871,10 @@ struct bpf_kfunc_call_arg_meta {
 	u8 release_regno;
 	bool r0_rdonly;
 	u64 r0_size;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7908,30 +7912,40 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
 	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
 }
 
-static bool is_kfunc_arg_mem_size(const struct btf *btf,
-				  const struct btf_param *arg,
-				  const struct bpf_reg_state *reg)
+static bool __kfunc_param_match_suffix(const struct btf *btf,
+				       const struct btf_param *arg,
+				       const char *suffix)
 {
-	int len, sfx_len = sizeof("__sz") - 1;
-	const struct btf_type *t;
+	int suffix_len = strlen(suffix), len;
 	const char *param_name;
 
-	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
-		return false;
-
 	/* In the future, this can be ported to use BTF tagging */
 	param_name = btf_name_by_offset(btf, arg->name_off);
 	if (str_is_empty(param_name))
 		return false;
 	len = strlen(param_name);
-	if (len < sfx_len)
+	if (len < suffix_len)
 		return false;
-	param_name += len - sfx_len;
-	if (strncmp(param_name, "__sz", sfx_len))
+	param_name += len - suffix_len;
+	return !strncmp(param_name, suffix, suffix_len);
+}
+
+static bool is_kfunc_arg_mem_size(const struct btf *btf,
+				  const struct btf_param *arg,
+				  const struct bpf_reg_state *reg)
+{
+	const struct btf_type *t;
+
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
 		return false;
 
-	return true;
+	return __kfunc_param_match_suffix(btf, arg, "__sz");
+}
+
+static bool is_kfunc_arg_sfx_constant(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__k");
 }
 
 static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
@@ -8207,7 +8221,24 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "R%d is not a scalar\n", regno);
 				return -EINVAL;
 			}
-			if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdonly_buf_size")) {
+			if (is_kfunc_arg_sfx_constant(meta->btf, &args[i])) {
+				/* kfunc is already bpf_capable() only, no need
+				 * to check it here.
+				 */
+				if (meta->arg_constant.found) {
+					verbose(env, "verifier internal error: only one constant argument permitted\n");
+					return -EFAULT;
+				}
+				if (!tnum_is_const(reg->var_off)) {
+					verbose(env, "R%d must be a known constant\n", regno);
+					return -EINVAL;
+				}
+				ret = mark_chain_precision(env, regno);
+				if (ret < 0)
+					return ret;
+				meta->arg_constant.found = true;
+				meta->arg_constant.value = reg->var_off.value;
+			} else if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdonly_buf_size")) {
 					meta->r0_rdonly = true;
 					is_ret_buf_sz = true;
 			} else if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdwr_buf_size")) {
-- 
2.38.1

