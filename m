Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A076C5AC66D
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiIDUmL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiIDUmI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:08 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB6D2CDDC
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lx1so13401002ejb.12
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=41On7zAWMObT98mfuBVFWUrcvFl4FzQhwpNLE6tE/mQ=;
        b=PA26FrYRJwLtdcCm+jisKEsYhW2qw+eDtXpJyZsd4dAVn/w95SZIUxnl0kV9Jigh9l
         7fRPKmMQyoiupkYSfpxfMmsAzFND+EOrpxr/4cljTdrPyxa+6dE5R/bxdJQ5uvCBmP0B
         5fWkEtAwG6g1iFuDpO7Z/ZWWxzysgGxMsPhUlCLGM3JJH6D122NZZ7QmLVpTFEgwQ+oN
         HvjIcSBYXZ3sSWKm6EPXNWYr7KltXqI6AuFf0T9JxBHGbENO5fhjWjwG/RThf+o58lyA
         /DQaNSvlmt2ahq4Qj0Axap5X5op8b0zYG12kpK7+7cC/HxxTTKA2IDECVTSvCgrY7ydv
         13KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=41On7zAWMObT98mfuBVFWUrcvFl4FzQhwpNLE6tE/mQ=;
        b=KCxao66P/1P2LApLOgwHLq7a1qWwiDDfWQLxxjRccwuGIzpIm2a8X9F71Gwas4K2dX
         WG74Q3+Eqo8Wcy0StRMXP+v+1mb5oUa7bQZumRM6sAOpTWj85QwbsTtzr+btc/SuvcmK
         cBNTa58mVD1OudUsptpqL2MiPhfkiaiWegi3YcFViX9WkHaHRnG2ELtjhyjskMYWvNOv
         I5Ijb0ZBp1k0L9H3uyPCopgTcg1SD6BNnWPxMfbK+URCGYuoesBFREPsyXQjB2mp4co0
         nIEn2xwEC0It/JKYCMa+r9dnpXnWRIWxfs/WEd+QU3K/x7yIW1SsrigAxheUyKfD4nLp
         ROuA==
X-Gm-Message-State: ACgBeo0cXDueDPVi3WezlDRtKJb66pkmoY9itgG/degeYsaVqtrEZCyw
        vAK3wQmDREA8Q+rXvZFVqDDD6d9O77qMuA==
X-Google-Smtp-Source: AA6agR6IU1hhsP8F7IXjScDx2Bqk3/wBgxyt8O0zIhLDIqUjwMKQdrdYuNauNOpHKhYXz3cjgE666Q==
X-Received: by 2002:a17:907:3e0a:b0:741:4b9b:8d08 with SMTP id hp10-20020a1709073e0a00b007414b9b8d08mr27382634ejc.113.1662324120922;
        Sun, 04 Sep 2022 13:42:00 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id v25-20020aa7dbd9000000b0043bea0a48d0sm5172358edt.22.2022.09.04.13.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:00 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 11/32] bpf: Support constant scalar arguments for kfuncs
Date:   Sun,  4 Sep 2022 22:41:24 +0200
Message-Id: <20220904204145.3089-12-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6108; i=memxor@gmail.com; h=from:subject; bh=ski8B2ax2X87yqPbN0rmgZ9zzLz5NF+EL9T8u9n1+DM=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1wxaAZ0UkzYp550SBhiSExuruMShd9MovZhIVN YNZ5ECaJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcAAKCRBM4MiGSL8Ryni/D/ wPXka6a/2T3WIEIxv2HV+SkIYAswLvksr8eZ/JHOmgpyEg8f7hhrD0XOea1/DikMYeOvw/NLm73L7E h4P7emWwgmqEPa+3nGKuR01DvFyKpkdmy4x0vusp0jfaXYGIUARZtyYi1ueB7/isPKDNDMoGwWSvAD sNTYolOZoNy9KXnc4/TP/2quMEwyy5ncJwJaIbolK7GrYVsn9FrHhQ8+XXs54YAqXvs9U8OqbJ0LkI 0KCdXkxa39D3SGLEQ9Kg2xFo/ffXsl8/oemEV/Cl1qNYae7UtEcEkvB0MZ4yG9uDjhk5q+65LEIfRi xAE/c9z3eBzbark4KkuUhuwbE0X7TgUuAD1zi696wIG5yBszw1GO3/VR8LPv80zOBAdADKFs6xgUxh CTOhCGOb6naaDm+eVSx1ufqpp9YwvK+ILGBkmHZulPgwwU/J58avz0Q8ZdiAamf28hYhBuUS95OSPS YcDrAIzxDjRFnl6wpsrja0hUpvtbqFsDpfzp4FpDdOmaZIYH2rvHS+OxEpQ3wJBpop/0yiH7jlbaie /d6v6F5Y9ddiYaw2ydRJn4ap78h5iEELSYXCTGlqTxR1T5kCenxYqqL0+RXc7OPfYaPYwy2b5Vsym8 t+aBKIWAbqGSGj/ZX6AVPh/xxE8UjBHXz+J30iASsjQ49+gkcglnEzUtx93w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow passing known constant scalars as arguments to kfuncs that do not
represent a size parameter. This makes the search pruning optimization
of verifier more conservative for such kfunc calls, and each
non-distinct argument is considered unequivalent.

We will use this support to then expose a global bpf_kptr_alloc function
where it takes the local type ID in program BTF, and returns a
PTR_TO_BTF_ID to the local type. These will be called local kptrs, and
allows programs to allocate their own objects.

However, this is still not completely safe, as mark_chain_precision
logic is buggy without more work when the constant argument is not a
size, but still needs precise marker propagation for pruning checks.
Next patch will fix this problem.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 30 ++++++++++++++++
 kernel/bpf/verifier.c        | 67 +++++++++++++++++++++++++++---------
 2 files changed, 80 insertions(+), 17 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 781731749e55..31625393204a 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -72,6 +72,36 @@ argument as its size. By default, without __sz annotation, the size of the type
 of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
 pointer.
 
+2.2.1 __k Annotation
+--------------------
+
+This annotation is only understood for scalar arguments, where it indicates that
+the verifier must check the scalar argument to be a known constant, which does
+not indicate a size parameter. This distinction is important, as when the scalar
+argument does not represent a size parameter, verifier is more conservative in
+state search pruning and does not consider two arguments equivalent for safety
+purposes if the already verified value was within range of the new one.
+
+This assumption holds well for sizes (as memory accessed within smaller bounds
+in old verified state will also work for bigger bounds in current to be explored
+state), but not for other constant arguments where each carries a distinct
+semantic effect.
+
+An example is given below::
+
+        void *bpf_mem_alloc(u32 local_type_id__k)
+        {
+        ...
+        }
+
+Here, bpf_mem_alloc uses local_type_id argument to find out the size of that
+type ID in program's BTF and return a sized pointer to it. Each type ID will
+have a distinct size, hence it is crucial to treat each such call as distinct
+when values don't match.
+
+Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
+size parameter, __k suffix must be used.
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 96fab14eb94e..b28e88d6fabd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7588,6 +7588,10 @@ struct bpf_kfunc_arg_meta {
 	/* Out parameters */
 	u32 ref_obj_id;
 	u8 release_regno;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_arg_meta *meta)
@@ -7625,30 +7629,40 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_arg_meta *meta, int arg)
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
 
 /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
@@ -7873,10 +7887,29 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_arg_m
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 		if (btf_type_is_scalar(t)) {
-			if (reg->type == SCALAR_VALUE)
-				continue;
-			verbose(env, "R%d is not a scalar\n", regno);
-			return -EINVAL;
+			if (reg->type != SCALAR_VALUE) {
+				verbose(env, "R%d is not a scalar\n", regno);
+				return -EINVAL;
+			}
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
+			}
+			continue;
 		}
 
 		if (!btf_type_is_ptr(t)) {
-- 
2.34.1

