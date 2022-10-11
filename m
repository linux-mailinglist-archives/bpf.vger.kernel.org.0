Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2937C5FAA12
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJKB1s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJKB0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:26:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A071707A
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:26:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 70so11173125pjo.4
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6p+7W6yhSg3f3oapnhzYVY5mUUrACfY49Gki6+mDTU=;
        b=AzPPgQYF4oJu7cht0zCli+B9ZzTgYWCkXzhXC5Yp7G3u0YBLuaNBESkTpkmU6j7H6k
         XDSiswSbDHDTivr/cy2Rnb9EjwbY7alQaTiYyXKBDyS9L7pv8WU+3httoO1Ok1lFmvwE
         RozO2NiGc4Pz0ctUknvlZp0i/DeJGCRkkkB9Y+A11w99uGtbUo2m8/xhDcekypQwUF5q
         kW34T1qME8FtLG/q6dfh4tnwOYngmoF73rUMPT0jLWhDqNuswnO7V/391+aV9g532gDG
         fNeUmraqyOtv0KsGlW6mEq4qLo6Bia//1P+HQf/HVCBdJKl2zJoai4Ac97HF5x+shBb0
         qXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6p+7W6yhSg3f3oapnhzYVY5mUUrACfY49Gki6+mDTU=;
        b=PRU06CAG6eoeZkMzAPLBKF093p4BeiEfbiItnLHxvWVSvVXB4vxB9SqVgmp111NlCf
         C9w8VkYnOBF7ba09F1t3n8NNPE2W7JQOMpASknMZTgNx+iInIOeNKPFVJwLwhDZorRzQ
         TWPmFQTs3L0jT2YQh+AARthis94L+HlYXe3nPg0l4HBlo5WK4AaOhNzam2n3OffBJylA
         xc0ouQYR1Xrv1uVGPBZuduVhB4FKccqAHe2bT6f/VH9sq0wSqNkKGDzBTNffrP/UrZcF
         aNo3BBGh5IaVlegaTn8SMQKWQusJw6g8bJ9brb79daQA1IBeiogk8421sxAJp4sjI+/v
         0bbw==
X-Gm-Message-State: ACrzQf32Jy2X61VdU1cFjOHXrG61ivL6smKV2uc2YtI46byRv2G1OZ6T
        w3p/l/X3At9D/BbNWcd2Ahnl7bWgi9G04g==
X-Google-Smtp-Source: AMsMyM6Mnzu+yteDd6Tjz05VJdmOZohgG+IuXSdHFt9Ic/Ecgr3fmd0R+sQ1nndlksytsk+asQ2FNQ==
X-Received: by 2002:a17:902:b907:b0:178:9d11:c978 with SMTP id bf7-20020a170902b90700b001789d11c978mr22182819plb.90.1665451611763;
        Mon, 10 Oct 2022 18:26:51 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id q24-20020aa78438000000b0053e199aa99bsm7528204pfn.220.2022.10.10.18.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:26:51 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 17/25] bpf: Support constant scalar arguments for kfuncs
Date:   Tue, 11 Oct 2022 06:52:32 +0530
Message-Id: <20221011012240.3149-18-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6081; i=memxor@gmail.com; h=from:subject; bh=2Q5tEqzHdCK9bWCQ2y1FKdSKHRXK/0DD187bi/+fHC0=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUbp3yClOn/XV3B29DENujcDdApYxnJqd1FPiFE 7D8qVN2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGwAKCRBM4MiGSL8Rypt4D/ 9epuPDh+Oemyur8OtA87N+HBFY/k6X2+YN9rWTrDRxtok6TyKVo1uDTwzcJffGQL+DMt0eR2XmYOlW n/pMUYuhSNfQ8lIFG/Qvx04PuwHP/igrs4s5EK3rLBfl2yQ2+G8f5rMzZZJbnyBb3JEu4t7mwP2Qkf jcyfGUagRQ2JYiXbxA8mais6fwA5QyZVY6B/PBLUi+WV44wa//UKLLRmV9BnTrTF45eBaYaO0KYItQ DGWqbO+IHxV0Bzwsd6hdHXyWZy0BWp7ZWVovqzmhWHJAYRztJntLYIKIwf0TV5pTkJ4RDAjBKAChnv PeRjM4c4gl5qFCpO8LB6XRJmMSsErzZYugT5D4Rr7O1yrgyDHcoBYEW5BENfAeNus0sXR1IAKeUuDj /ZBy5JMP8fmECmGHvaLZkSxX0UcDWvqiIyLwVdmIwto6pBysVDEjzSfYp+eW43OGsFvni/jsfSBRLa IbWHBNe4/R4I6scuKI5TROeBw8J26vjvtyUoFci4XzRVVthSTFIgPqIdMLFi1KLm/UVPXAQ67VNU0C 03Uovcy9xjar2g17CDx2qjkRbGGMSeIDRRRNGEzfJuA8kp9tbKlO1YvRuY4tSE6qXzgzlclnrE7v0d DueGq1hQ+UEJ/p5K3parZWW49qJVZk4zAW1ZiIvznD+KwQtC1NYFFREgO+cA==
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
index 0f858156371d..08f9a968d06d 100644
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
index a69ce6e29f40..4583a22777fe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7676,6 +7676,10 @@ struct bpf_kfunc_call_arg_meta {
 	u8 release_regno;
 	bool r0_rdonly;
 	u64 r0_size;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7713,30 +7717,40 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
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
@@ -8013,7 +8027,24 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
2.34.1

