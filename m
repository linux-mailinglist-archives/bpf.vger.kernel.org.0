Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E88616EB3
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKBU2N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiKBU2E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:28:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4262D4
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:28:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v17so14652548plo.1
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJnoPHX64rw0/tf/j9VRilsEBx86jgsZxr7y9rVgMAY=;
        b=Iz99p2xhfhCOddyFlekhLbcYzbLwfEEKpHIAqK+eZxMNEh/hYPiMBrlGlDJARyfmQS
         20rTLjZ8dHXPSQzpyizC3wwUig2zbsaDmLBCDJER9yyC5ECK6ku/o29TbmkaSLfEBG6z
         ojTIGYtPVLYYXqzqNKwxNYiiOhNFGbW1fc92nM1KVBVB52kVPo/+Rpz8l0cHfxRmGH9V
         3J87wVWFoyb3u6/a06RdlBLXH4uT0ItaoYquHeH6hFKOFxqX51CNP33PuynwOMrHMbN+
         Y7BNADG5c+jH/PUHdrcavtaZo5FTgslDfjLA57YKHdF4fUizMu42vUa3i1rFbRPKj7vx
         FsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJnoPHX64rw0/tf/j9VRilsEBx86jgsZxr7y9rVgMAY=;
        b=sZ5KYLWoSh1EKtR/1UD8xbHyL4nEJExO+JSUh4JDvqYfC6DJT+DhBldI159vrYK2Zf
         JzEIBdfu/gy6bdIJo4pvc50ht9WYU4noLBPNgPiqDjRFoxL4ObNpXUVkMgohv6H7fOgZ
         cNasS5TSyL8HgrIsxK1VJguk6bnnNQTHvkzRe9vxZcKTunQUdB4SET8JK+8/iqpeGW0p
         m2v8iKqHTLMGQVZsxi7Naxz/aT2R65N6yE00M3H6rlswViMlcriVd/dyzc0W64vPVZHq
         otdW5Aqos+hgesdUNPlfwcigv5+xiYP4fK37utAeKD3AKAgolwF06wfjConQU0f2EZij
         rDVw==
X-Gm-Message-State: ACrzQf1ebAmDhLbfoUxiIkKFoXXzmq92FJLqX211pdxXOsSdYbCx+0lX
        HIpZw7FN73hSEm6h6cyWFJthC1AlspNoUQ==
X-Google-Smtp-Source: AMsMyM7t2MaCSdqkm9nzQZeAzr8wPSR+QfgBTN4OE5IIL8MeR9r5su7r2AC9BXy83JWXfD1PBbl5Vw==
X-Received: by 2002:a17:902:e88d:b0:186:c544:8b04 with SMTP id w13-20020a170902e88d00b00186c5448b04mr26989048plg.51.1667420883582;
        Wed, 02 Nov 2022 13:28:03 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id z24-20020a63e558000000b004351358f056sm8021606pgj.85.2022.11.02.13.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:28:03 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 17/24] bpf: Support constant scalar arguments for kfuncs
Date:   Thu,  3 Nov 2022 01:56:51 +0530
Message-Id: <20221102202658.963008-18-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6081; i=memxor@gmail.com; h=from:subject; bh=Hq7Qvj/3VSUXIU2nv2xUSwo23cln6IVSdrkcjwvi9o0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtIDlYZqJRHiAh3PkdWDJpmo02tqZY49AkUsC01k HZ4wuS+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSAwAKCRBM4MiGSL8Ryp0fEA CMMCHFQ0rAroIjwGOJuiZsRAEM+P9F5cnSeZEOpIxm08wf1HLN6sXrTVbQD5I7n36jilmIu8W8qM++ euYDm0sDrr3MBHiq9FU3K1aG6p2bgR26hfRD9pbUuHuBo7EzUodvYh4GJBJ0H5FTrlj0iH1N2z1c5H dH7oRQtCpzsCmYAic2MOOo+ZELFLz7W7getRbs42gBQkJEiJ3kGPgTqWj0G1eBVKfCWbc/i+rLeJ5+ gpPOHp7lgz6fH+ZfIF043e6vqOc1X3KzzLFXJz7cJoh+Hj2zH5gNajSlRsnMbQv3YV2Nq76Tpe4CMm iNMAR9dMZvfa6yCy9UUFaPmk6Mjp736sb0fpBS3AXVsDCA40wJJRpcpBtH3RfjkvxuvnkgE0OoQzF+ /nrWLPCAJiQFr/hlTDGvP1rJ4mHTQVpk1KLn2ArakcAr2yWi7Q5hy6Y6K4J/cI1FLgOhZ+uz7tqpB2 Ygsyipryz8iFAu42mDz3g3J8NYNhM4Z3lB321dvp3YaSH6S8sGdDQ8wY/fbMPvw6rjBftrx610cakV GkPlcEJGA8DczWJadMjf8ztapxvu6h2ONfw3iNhMqqIbeMNLep4rFqVdUsl7hAE76lVmdpMG9mAC37 AcKO3uqjL0ctyA8g3pkYwZ+zg2iwXja/0ih1O8YKHL2A94aD/zdLgisdQWaA==
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
index f2a8adf5cf8e..b92725f54496 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7686,6 +7686,10 @@ struct bpf_kfunc_call_arg_meta {
 	u8 release_regno;
 	bool r0_rdonly;
 	u64 r0_size;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7723,30 +7727,40 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
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
@@ -8022,7 +8036,24 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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

