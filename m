Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862C362EB6D
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbiKRB5B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbiKRB5A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:57:00 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9608F786DA
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:59 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id s196so3775125pgs.3
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5I6eG5hjgciNIVJ7w3PdGRUS0/VDW9TOrEC14dAJ3g=;
        b=Plmp50GgGooHq32dx3orfnLS09hDxsaOCHNWQPBxTP+k+KGOnBjMjPYOifZSpEyuO1
         BI7Z0+8PeVipaoaWwc4hppW9Pon8T5GzYSX9lR5rawIPFGNHUi/DJuJ6avoJ5nLe/KGf
         JL8AphhCjYsoQ0vXMAeNyVy1+5KoQDuijwUm8Yl/UP8wrMXc1JbsybZDZanuZp7z3kbA
         zoEE6PKMJasOnmjuQDcY5ddIHPhdm26OKlLCQ2y8wKQ+opgrecNK5HMTvuzIEUDFG7tw
         4iTfK1a5owXqvHhDwHVEqFek6MmMSvzFEI4JPwfYaptFR+al96HZ9nE67Apaegopbj6X
         nqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5I6eG5hjgciNIVJ7w3PdGRUS0/VDW9TOrEC14dAJ3g=;
        b=ZQiBo9JQ6T0ifZ+B2DnGDrHKZZaru66pUXskTH1cYslCfPA+FHKtm46AgbjxE+lCrH
         gctl5/sG3i22qOobmuNe+mxDA+AVHN9D5ybRuAQ3WVlzc4Xwa5mHmXsuJcz6xii/gECB
         JGM94JRiJ0umS5zwSsZmX+1WiKmIvQH1R8gY2FBPL31Ql3wbOlfcx9aXM9zoMt9t24pV
         sxmP7XGYtzTBBWhm7YIjWdcsk0Do8zI0tyAbpSfsGFyRELZZGxHMAzNED9xkAbr6q7V1
         5I71onL3vVktDfgDkmtG0zL6yGA7SeCfzcTC0KoxjAS8JVnaXzD7VTdwiEpcMRq6qX+k
         08eA==
X-Gm-Message-State: ANoB5pnXV6OS2GR0GdYwrut0Hb6drq4c3GsVYIcF5Xa2aWt+RVdnKVP6
        PNhpLKFTM6rv/J3l/unqzdwSb27ddtc=
X-Google-Smtp-Source: AA0mqf4frL7e35NdceTpTgB4myF+nO1j+h2uWyAQ92GpzB5uGdyZseJUDODIgGuZRPu1ENbQ5eKJsg==
X-Received: by 2002:a63:f1d:0:b0:475:a06:50ae with SMTP id e29-20020a630f1d000000b004750a0650aemr4658833pgl.67.1668736618972;
        Thu, 17 Nov 2022 17:56:58 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b0016c5306917fsm2177916plh.53.2022.11.17.17.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:58 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 12/24] bpf: Support constant scalar arguments for kfuncs
Date:   Fri, 18 Nov 2022 07:26:02 +0530
Message-Id: <20221118015614.2013203-13-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5687; i=memxor@gmail.com; h=from:subject; bh=dpGMp6irNNkoPnlw2c6Jfien8u/vDsbbzE2UokAJ72E=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXPX4h//5Gdr6N8wZoCs82xY0NNe7J8mo9ZjeXg BQS4+n+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzwAKCRBM4MiGSL8RyrYEEA CGcuEOHu+Xk0WYtLTAaLGyG/Y4tN6iH9PPAvE6eDbNSBpS5B+laqOV5pC6o2cfblUmJUpxXrOZcEew /7/9qhTT/mSMrwomA/4bVUgQ736LoJA3fSG++jzHs4k3/rN7id5iuNPUZ9d89JNB5+G7IcTZrVsFUM WTwRl6XkhrC0WWk4rkFHHGfvcmqLlqlOqW0vAn9jFmqI16Kev7nv79g8G+UZZiPUIJingPjmkUykrz 4+61IDm9wnT7Up6eHpy2fn6PfK98vNSGfgn3QaTHMqdcDeUsXxQqDm0sOU4gxjAVCPZumcGyRgU/0t 30GTbdckKrcRHd4U5sxFELp4k4cJWbITqyMQ2pdvebskw9LaowPwh0EcWrhsp1X5fqkH/biwTpSNcu nq+SkPZzWYI2nY1RRvNJdAyP9pHJhK1sCAJzO+mRmLD3lzbNEfd67f1EBM4UH5ocaIlS3DLdkmbGBk KtQunBnGO2N2wAO0IBzKVHQh5FE0HETXDszGzabQO1kmBpPSRGx0sDgJbf+RnL9QXIG4LI+uMp6zTT 7hrqIjd6xcuoAr4PFvL/LYWbja/S2Jx2vGp76vv8rD553bdGn6Bu6140RiFnOwPPjX6B2ERUQvdN5U Ku5mRIDRSEiT1ZdN8OPeaxWFw+7so+iPWAAGxM3WP7s5xSm3+N7qzxSPN1pQ==
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
represent a size parameter. We use mark_chain_precision for the constant
scalar argument to mark it precise. This makes the search pruning
optimization of verifier more conservative for such kfunc calls, and
each non-distinct argument is considered unequivalent.

We will use this support to then expose a bpf_obj_new function where it
takes the local type ID of a type in program BTF, and returns a
PTR_TO_BTF_ID | MEM_ALLOC to the local type, and allows programs to
allocate their own objects.

Each type ID resolves to a distinct type with a possibly distinct size,
hence the type ID constant matters in terms of program safety and its
precision needs to be checked between old and cur states inside regsafe.
The use of mark_chain_precision enables this.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 24 +++++++++++++++
 kernel/bpf/verifier.c        | 57 +++++++++++++++++++++++++++---------
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0f858156371d..3b1501c3b6cd 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -72,6 +72,30 @@ argument as its size. By default, without __sz annotation, the size of the type
 of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
 pointer.
 
+2.2.2 __k Annotation
+--------------------
+
+This annotation is only understood for scalar arguments, where it indicates that
+the verifier must check the scalar argument to be a known constant, which does
+not indicate a size parameter, and the value of the constant is relevant to the
+safety of the program.
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
+values don't match during verifier state pruning checks.
+
+Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
+size parameter, and the value of the constant matters for program safety, __k
+suffix should be used.
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ac6476104983..29a0cfa62d14 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7875,6 +7875,10 @@ struct bpf_kfunc_call_arg_meta {
 	u8 release_regno;
 	bool r0_rdonly;
 	u64 r0_size;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7912,30 +7916,40 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
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
+static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__k");
 }
 
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
@@ -8205,7 +8219,22 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "R%d is not a scalar\n", regno);
 				return -EINVAL;
 			}
-			if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size")) {
+
+			if (is_kfunc_arg_constant(meta->btf, &args[i])) {
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
+			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size")) {
 				meta->r0_rdonly = true;
 				is_ret_buf_sz = true;
 			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdwr_buf_size")) {
-- 
2.38.1

