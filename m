Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3E646284
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLGUmD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLGUmA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:42:00 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235F845085
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:41:59 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id jn7so18146199plb.13
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 12:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knaUyolnxJAvd8/eFssmGbs+/xV2LhLuI7H5j6fS97E=;
        b=pGlGqUxvdDYsHCzi+UWu6qYVJ6zELFXkm1GrYqA6EH71qh6AemADUu+v+1minTjDE0
         QeQ8290VUH2OnGURkPOT9NOYTwmWyf8BSRsz4NKpnJF1hFC2G4n1HJnNXZzKSwM1i6XF
         i/xBZvHq1axBXi9l3sFhUfg4WkxQy0b9qUdKZ1RdW0WUuDnzplrtrf8NIyVXVAm3QUOM
         lrdLt2cwpsqp7pXbulB1pUPT7qUYphS/U1RT7v1nqQieAYvNqX6eIMCDt19cHPmGa3Ql
         ONWX9ZXsN9TP5bMo/IGgjn8/Imym+yhvQZbpeNyVr3gtsimfoFCkh+NQsiu5u1GNFT6+
         mJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knaUyolnxJAvd8/eFssmGbs+/xV2LhLuI7H5j6fS97E=;
        b=DfNvLnvPB4J4HtdaG3R0z8zdRLRIauq6oPhiT5PvtMNimB8TidnbBHj5mxf0sW0dUb
         a20eLXGrqdjyVNN7PnTWP+oOPH2yywfenajyLYqZuF0H2guy08YgHGTsS9DOmUFXB9Kr
         LQt3KVoDKKz08sOpRWc7Cc2AwVfnhkzsZBQ5vBfOmwUsfRCZoQ/uVP4Xy3TQUkd/Zl6o
         g+65z1NC2eYL7bhrkj6ncKbN3gB53pvp0jQMr5yVCObPUv1jDTyH0rE+go3sAjTKUEu2
         YF8bajWgEcxEtoaMa+H6AEtLbijmFFvgMn8lwCwNPQ2zhvt750rluYXdP3T4Iint4iOV
         wgJA==
X-Gm-Message-State: ANoB5plY2V3BXqqCLBQjKxcHaU5w3tigBUdZkPJK6DFRLiWQiFD3BkEN
        Ul1VdPLIzAIGUjOqptG06jpAeFvhZ+j61sog
X-Google-Smtp-Source: AA0mqf7dpdLsM86aPmm1GnQHpkMaHA7+DMX0eqMObmxo6xCGWcB3VIaWbZD++2Mu56wzqATmneDG8g==
X-Received: by 2002:a17:903:1341:b0:189:9a36:a5a8 with SMTP id jl1-20020a170903134100b001899a36a5a8mr42572253plb.151.1670445718218;
        Wed, 07 Dec 2022 12:41:58 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b0017f36638010sm14919318pla.276.2022.12.07.12.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:41:57 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 4/7] bpf: Rework check_func_arg_reg_off
Date:   Thu,  8 Dec 2022 02:11:38 +0530
Message-Id: <20221207204141.308952-5-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207204141.308952-1-memxor@gmail.com>
References: <20221207204141.308952-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7324; i=memxor@gmail.com; h=from:subject; bh=vMfVcMCU2fw+LZ7cLmesTLvOwK5XSQr2Rp7hNnX0sp4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjkPOoK9DUOYjXP+91W1OsmBY1XjziCe3bkvWrLg8j /3A6fMeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY5DzqAAKCRBM4MiGSL8RyiffD/ 9Uk4M5/EMJV9O80AD3RSa/yxB50HckKxBXMepji1feZxewqagdGCUL0sdAGPLWrvP2MrlNMCDHYAR6 BQLEYLmh2Y5ISu9kP3CvzNnECTfX/m6ekLPEH/T5hiS855m62CmW+XV80A0CiSkyi8+n1yOy3mqiAt QweuI6YIWu8w1rs3FqW3fdYp93R5AhPVbdH4z9+gFuAdY21SuL5W/TySMkhmzVKY+01RHyXCDTLtgT +tqtJjVyHeOV0UBxC8TjMzhzUPoEtV/loz8TG6nBziDKDXsmJVASew2xzzHJSwaX++4Sj/ABgkPKSY PAJ4VWZ++0FZulHzevNFeRwUX+SR1mEGca4n/zPyQ0ZsMNB4uHA02/kktbiomeZr6aP6Gen53LSOXx /h5IOiAFhLBIvjORUydzlvrft51TNz34n/kO25mCM+ZdgC/7PIhaZvkACSfS5VQqJqFV9Yv+qhogB1 m+yigT4A+Gmtg//cSOLpA7hF8GMu4TVDSr1UBjUA5i7ZINatNw43C6rpjUEmKEoJQn7klGrNLUE3R7 w85b1Ohae0r1KyzlmFqxkHFXsWF/RlGMLhlOnVAddRb2r3oWgwuysj9vnFi5kip3Gikp10e3GxDUF8 /FfpCpwkBCcj6egLsWUPpOq7ISzPPQwvf4BNKkIIhXK/8mLzUjnpnsFCIFUg==
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

While check_func_arg_reg_off is the place which performs generic checks
needed by various candidates of reg->type, there is some handling for
special cases, like ARG_PTR_TO_DYNPTR, OBJ_RELEASE, and
ARG_PTR_TO_ALLOC_MEM.

This commit aims to streamline these special cases and instead leave
other things up to argument type specific code to handle. The function
will be restrictive by default, and cover all possible cases when
OBJ_RELEASE is set, without having to update the function again (and
missing to do that being a bug).

This is done primarily for two reasons: associating back reg->type to
its argument leaves room for the list getting out of sync when a new
reg->type is supported by an arg_type.

The other case is ARG_PTR_TO_ALLOC_MEM. The problem there is something
we already handle, whenever a release argument is expected, it should
be passed as the pointer that was received from the acquire function.
Hence zero fixed and variable offset.

There is nothing special about ARG_PTR_TO_ALLOC_MEM, where technically
its target register type PTR_TO_MEM | MEM_ALLOC can already be passed
with non-zero offset to other helper functions, which makes sense.

Hence, lift the arg_type_is_release check for reg->off and cover all
possible register types, instead of duplicating the same kind of check
twice for current OBJ_RELEASE arg_types (alloc_mem and ptr_to_btf_id).

For the release argument, arg_type_is_dynptr is the special case, where
we go to actual object being freed through the dynptr, so the offset of
the pointer still needs to allow fixed and variable offset and
process_dynptr_func will verify them later for the release argument case
as well.

This is not specific to ARG_PTR_TO_DYNPTR though, we will need to make
this exception for any future object on the stack that needs to be
released. In this sense, PTR_TO_STACK as a candidate for object on stack
argument is a special case for release offset checks, and they need to
be done by the helper releasing the object on stack.

Since the check has been lifted above all register type checks, remove
the duplicated check that is being done for PTR_TO_BTF_ID.

Acked-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 64 +++++++++++--------
 tools/testing/selftests/bpf/verifier/calls.c  |  2 +-
 .../testing/selftests/bpf/verifier/ringbuf.c  |  2 +-
 3 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fdbaf22cdaf2..cadcf0233326 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6269,11 +6269,38 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
 			   enum bpf_arg_type arg_type)
 {
-	enum bpf_reg_type type = reg->type;
-	bool fixed_off_ok = false;
+	u32 type = reg->type;
 
-	switch ((u32)type) {
-	/* Pointer types where reg offset is explicitly allowed: */
+	/* When referenced register is passed to release function, its fixed
+	 * offset must be 0.
+	 *
+	 * We will check arg_type_is_release reg has ref_obj_id when storing
+	 * meta->release_regno.
+	 */
+	if (arg_type_is_release(arg_type)) {
+		/* ARG_PTR_TO_DYNPTR with OBJ_RELEASE is a bit special, as it
+		 * may not directly point to the object being released, but to
+		 * dynptr pointing to such object, which might be at some offset
+		 * on the stack. In that case, we simply to fallback to the
+		 * default handling.
+		 */
+		if (!arg_type_is_dynptr(arg_type) || type != PTR_TO_STACK) {
+			/* Doing check_ptr_off_reg check for the offset will
+			 * catch this because fixed_off_ok is false, but
+			 * checking here allows us to give the user a better
+			 * error message.
+			 */
+			if (reg->off) {
+				verbose(env, "R%d must have zero offset when passed to release func or trusted arg to kfunc\n",
+					regno);
+				return -EINVAL;
+			}
+			return __check_ptr_off_reg(env, reg, regno, false);
+		}
+		/* Fallback to default handling */
+	}
+	switch (type) {
+	/* Pointer types where both fixed and variable offset is explicitly allowed: */
 	case PTR_TO_STACK:
 		if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
 			verbose(env, "cannot pass in dynptr at an offset\n");
@@ -6290,12 +6317,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case SCALAR_VALUE:
-		/* Some of the argument types nevertheless require a
-		 * zero register offset.
-		 */
-		if (base_type(arg_type) != ARG_PTR_TO_RINGBUF_MEM)
-			return 0;
-		break;
+		return 0;
 	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
 	 * fixed offset.
 	 */
@@ -6305,24 +6327,16 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
-		 * it's fixed offset must be 0.	In the other cases, fixed offset
-		 * can be non-zero.
+		 * its fixed offset must be 0. In the other cases, fixed offset
+		 * can be non-zero. This was already checked above. So pass
+		 * fixed_off_ok as true to allow fixed offset for all other
+		 * cases. var_off always must be 0 for PTR_TO_BTF_ID, hence we
+		 * still need to do checks instead of returning.
 		 */
-		if (arg_type_is_release(arg_type) && reg->off) {
-			verbose(env, "R%d must have zero offset when passed to release func\n",
-				regno);
-			return -EINVAL;
-		}
-		/* For arg is release pointer, fixed_off_ok must be false, but
-		 * we already checked and rejected reg->off != 0 above, so set
-		 * to true to allow fixed offset for all other cases.
-		 */
-		fixed_off_ok = true;
-		break;
+		return __check_ptr_off_reg(env, reg, regno, true);
 	default:
-		break;
+		return __check_ptr_off_reg(env, reg, regno, false);
 	}
-	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 }
 
 static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 3193915c5ee6..babcec123251 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -76,7 +76,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "arg#0 expected pointer to ctx, but got PTR",
+	.errstr = "R1 must have zero offset when passed to release func or trusted arg to kfunc",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_pass_ctx", 2 },
 	},
diff --git a/tools/testing/selftests/bpf/verifier/ringbuf.c b/tools/testing/selftests/bpf/verifier/ringbuf.c
index 84838feba47f..92e3f6a61a79 100644
--- a/tools/testing/selftests/bpf/verifier/ringbuf.c
+++ b/tools/testing/selftests/bpf/verifier/ringbuf.c
@@ -28,7 +28,7 @@
 	},
 	.fixup_map_ringbuf = { 1 },
 	.result = REJECT,
-	.errstr = "dereference of modified ringbuf_mem ptr R1",
+	.errstr = "R1 must have zero offset when passed to release func",
 },
 {
 	"ringbuf: invalid reservation offset 2",
-- 
2.38.1

