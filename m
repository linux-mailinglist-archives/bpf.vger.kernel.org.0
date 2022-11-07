Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0380620367
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiKGXKy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiKGXKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:47 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28352A970
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:10:41 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 4so12624048pli.0
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAdcZjcAFhY0+RHLsYzAKGZ84kaa6r7C4S81z37SiLk=;
        b=Lv2B5qNxlHf4lh+FRw8YmKuMjkCIvIIotxSsb/fMFNUROiMfST2MyBynXdty92boNi
         0wwr4b7kieFUWsgcZkWU2yvik7M0mcc7Qb2hbCcie8WRZum/f5dYduYovaKJjexKSJ/Y
         Yp93v0D4TRKPqX32nSYBqKrXnvgmT9n1WAhSMaQUtvfiDgpnYLVJMO2+R5OLRwTaZBtF
         XYPPNwFlVyMWRF2846kqAaJQOQXJIN7x1w93MSKr48lNP8bd2BtIek1UoXMksNVs4vKs
         TussHAKeKtAzpoAeGuxXw55D1rHI+QLtYyR5tRamudzB7DRX6Xlqzj7N2+tLuREmSUF0
         GX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAdcZjcAFhY0+RHLsYzAKGZ84kaa6r7C4S81z37SiLk=;
        b=zuUoXLTlqgzfi5Fvh76AotZLqZVE2Y8qnxNRPo+fT1DH+0WjRBq4R8tDFQAepLEWe/
         q1Au8KdsV5pPx2YCCiUsu8T6rwCxaGKcZiYf6lPfGjTNPcj5JQZ8gKsWsOfChbN9IXYR
         M8GoDhDbKYlZifVvCwHYrhNWglNie3F/vTJzXMiD9HkdcCB+v2MYzgR1x8y6mQsk+uQI
         55qITW2xUj+6EbNwafREPXNH+Nt0zJzFL4y7bhLk2Abla9rzkveZvEh1uDJb/UEEoYWl
         PYQd/Vu8dt1rQEQja3Hg+9dEKEP83HM2288+phcl0Cv3HcXqBub5tw3vBJCseutXX1ms
         W7UA==
X-Gm-Message-State: ACrzQf1zaPgeDqNRjthTJC9Sttb03W/mSeHw+9jGdgQSMLHpYB6zTwdU
        YSSREUgOouqPTioMyVYdqjQgUT0jPkYSAQ==
X-Google-Smtp-Source: AMsMyM7VQUL2wU+pvx9+d47tZnCC9Te6CLZriOvwvay7LSlYDtFmEhu/oB3UtVeuwOEd/iGV7r1CiQ==
X-Received: by 2002:a17:902:8541:b0:17f:6b27:7a75 with SMTP id d1-20020a170902854100b0017f6b277a75mr52763900plo.65.1667862640930;
        Mon, 07 Nov 2022 15:10:40 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id f20-20020aa79694000000b0056c2e497b02sm5198063pfk.173.2022.11.07.15.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:10:40 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 14/25] bpf: Support constant scalar arguments for kfuncs
Date:   Tue,  8 Nov 2022 04:39:39 +0530
Message-Id: <20221107230950.7117-15-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6082; i=memxor@gmail.com; h=from:subject; bh=Yuk9TSTcr8yxRFSmQ6s6zt0wiBKc8WArN47o6Cs77cE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+3joqUNUeCBthIGF+ZEXd3VFGAv04+p8TedOga tO7NI2OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtwAKCRBM4MiGSL8Rys3XD/ 9WjWhL7Q5TRMo9l2F/NZjTglQYHyOjOdw1Wgnc+iHBInwW8STKPUlKu+w4OFoH60G57QTCii2rxV8D YmyJ6uEJ2avz6Wo/CY9jGk1/BEq0xkyJUitK/6ZOIYKIopRVzyDkpn/lIX2YRQI42GgxQr2OUaxYyG GupFiuYyPGiRM2g3zpr8f/Pd5Te0c8oLC/2R+hh78yu9ALP1ESpKNxiW+FvANx1ja5mKCywEm9GFzg e0/bqmAWyawfn3IT98GEjbsKdgZ82z/5JAkqJezLXalpRA2e2HOhXxDL+svrw8LZdBQFj7HaOoqocU PCYDVBKYKxg8hhADWvVx/kqnX8HS025yqRuLW2Pxm69OGamcEF3yfxFRrvjNerAx4Lb2m7XK+iN58b a4EJI7exJqwzbVPbp5fgIdtFEm3Iwsa0imvZoMOF9LXZZLqzBDDbRSAQEwLjgIzfGrNJV0EzDQob2X nO1A34V1DYbnJhssnOKWjaRTlAqqqq2YsJDt3GxoNA1Qldqx1h6KgEPxGxTfIlRXE5+xXMwrbTlV3G PH31WHEJ3wIz7BB2yYLIirfd8yKxE/gwtt1WM8Uqn3M7wx90fe8MdTY1rrrMYgrFfylAiszNRKSl3Z hS3GquAKJ/TCWC9bnFXBWrcp5F/7Sd4autUlmsFiCXFCfdR67tFp5dinMGqw==
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
 Documentation/bpf/kfuncs.rst | 30 ++++++++++++++++++
 kernel/bpf/verifier.c        | 59 +++++++++++++++++++++++++++---------
 2 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0f858156371d..7608b066a8ba 100644
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
+        void *bpf_obj_new(u32 local_type_id__k, ...)
+        {
+        ...
+        }
+
+Here, bpf_obj_new uses local_type_id argument to find out the size of that
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
index c315e8448156..7515b31d2c40 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7862,6 +7862,10 @@ struct bpf_kfunc_call_arg_meta {
 	u8 release_regno;
 	bool r0_rdonly;
 	u64 r0_size;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7899,30 +7903,40 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
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
@@ -8198,7 +8212,24 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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

