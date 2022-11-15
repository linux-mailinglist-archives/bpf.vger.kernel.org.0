Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4357628DDD
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 01:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiKOABk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 19:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKOABi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 19:01:38 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93C4F3F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:36 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w23so5175453ply.12
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpg5Qz+6fWOX2DvxSu0D8LB5VPcvtrAWoVCahsyCIi8=;
        b=XK9ZG1XO2+KITQqwyxZlfpC0xpPekKzVgOBP4OVxFja1dSZPfwBKE9S8eVtVLt1pbg
         mI4se1u3d4s22yeuAD+R71k8V2g7kgOLmPkOm1D6A2Ix3fu9e4FVibEBrOGq1MaKDUv+
         dbuBsB00Gd1RFdcqe9v3MiPejY0cqEAHMWSXiI2SYs0jf0ETpwwUytA0ablB1LsD9u7s
         Co6t5iG29SDsXJe9WDsIZ+18UxP4UI3VohpQh5YfyEHq6TR0yasVlYtOEh/p12BzrMK9
         4UxPt8PfYBIpRNKNxX8/pDHipfl9bt2YCf7NZpKU4/JzCY7q7EqhA5op5V2da2IcbjoX
         45DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpg5Qz+6fWOX2DvxSu0D8LB5VPcvtrAWoVCahsyCIi8=;
        b=6L2EWTD78D7x4GJivdjWte/7QABtV0yt2gNjX/OaYK7pfbRVR03HSQ4DfRkjaleOOE
         BOTWnzzovn4ajZX/Y+dIfAWtieiWfNDnFilc6tmpD5IZg+OoAABUnHUzdcVxebDBlS1w
         qoT0x51kfzs+tyHLZRct9f80KkJA/o7WRQTN6a29FVD/OJXDfGCp8euNZylcKLDhx3x5
         +L+xgX8ICnLxkU2atOlgZEM/z1/50eiPc4sLl638uQKPi1VtRaXRgnEjdGy1C3QhaXgj
         Uf4605JPljkb4Mc4yZxxeDzmxlZRjuvB9CfIhV5MVjXuoJblVprSEAV7FyaxzHRsExOg
         gc9w==
X-Gm-Message-State: ANoB5pnESCrfFVXDs7UL5sTj25dW/Sxjl1NNYtCT1jJZNy6KYLG8QN5L
        ZHcuTOGkXl894qKMZ0xby453yybCGZ3vFA==
X-Google-Smtp-Source: AA0mqf4T95fp0TCT7/7qkPKynmPcK/XOeekuH2LZsVtZ0eOnBT/lx47kYwWNvgJbo0H3IrqdCWBr3A==
X-Received: by 2002:a17:90a:55c5:b0:213:4f59:9646 with SMTP id o5-20020a17090a55c500b002134f599646mr16105895pjm.116.1668470496073;
        Mon, 14 Nov 2022 16:01:36 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id b129-20020a62cf87000000b0056bad6ff1b8sm7292624pfg.101.2022.11.14.16.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:01:35 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     David Vernet <void@manifault.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 1/7] bpf: Refactor ARG_PTR_TO_DYNPTR checks into process_dynptr_func
Date:   Tue, 15 Nov 2022 05:31:24 +0530
Message-Id: <20221115000130.1967465-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115000130.1967465-1-memxor@gmail.com>
References: <20221115000130.1967465-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9457; i=memxor@gmail.com; h=from:subject; bh=5P0Dxb9qxhITlYE11NEHLrjKbsu1NP1KfSCZ54b+Fz8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjctaC8TbYxYNI/U6La7PdXe/Py873iQSsOoyNBk25 ohjAKkKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3LWggAKCRBM4MiGSL8RyrjbD/ 9cZa7Q1ACXMafgVANipfJnHf62udr//8K7diWbey8F9U0TcaCMuVtwUWa2BnmA16qi+D06YBEF6EXQ CJ9uEo9PrloDqwICgWYvidlANH3Ev9YBxqz7/oGPr7zOGfBgRH83fHUoPRJg+8b9PvufRYNbSCeEG4 u7vq0BzMnHZQyAl3cZX0b5q3Mj72v28PCAPCaqTRSg3mshKyMGFA4nrjfXy2g2YgUMswtbY/U8UEFp gk9jhzSviBegnjO/XTgegg1wgRs9XfJpKbiRq75daSsHFmUJ3h7GEqK8ym5CAZC1UlraY2LwbLMC9h +rlSj3GZ0rUOkP4njNqNzgEEnxt+xkZiztYh+aK7Icxwz7jRFHEsNlWuX6ghKmFJQYNXV+FxFUuApH E6vkaKTC7PJDy8+3SUyHlg0Axf7lq6BX+YEcKt3ySZwOVnFdHtI9smFJYUq9OGWlsy2SU3+1j0sOS7 AtwqJIBoi0pvtIp6u7Dsve9Lk1LQNDj6TYmVK4/E4a7xG4hLq+asRbdTRdaDlke4InfnXfVckaSLIU 0D14k5+X8GS3fduPzQx9OddLNz/u1uAaQR2TY7YPDS+gnK6JEEc7d9w0Jdrnr7ehET0+Xp25muvs6t rj5UYT6JXKGOZlwU+Z2s6uGclnNpLDewp1c74aMtmBHa+9VycKqmrvpUGpAA==
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

ARG_PTR_TO_DYNPTR is akin to ARG_PTR_TO_TIMER, ARG_PTR_TO_KPTR, where
the underlying register type is subjected to more special checks to
determine the type of object represented by the pointer and its state
consistency.

Move dynptr checks to their own 'process_dynptr_func' function so that
is consistent and in-line with existing code. This also makes it easier
to reuse this code for kfunc handling.

Then, reuse this consolidated function in kfunc dynptr handling too.
Note that for kfuncs, the arg_type constraint of DYNPTR_TYPE_LOCAL has
been lifted.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  |   8 +-
 kernel/bpf/btf.c                              |  17 +--
 kernel/bpf/verifier.c                         | 116 ++++++++++--------
 .../bpf/prog_tests/kfunc_dynptr_param.c       |   5 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |  12 --
 5 files changed, 70 insertions(+), 88 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1a32baa78ce2..a69b6d49d40c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -593,11 +593,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
 			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
-bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
-			      struct bpf_reg_state *reg);
-bool is_dynptr_type_expected(struct bpf_verifier_env *env,
-			     struct bpf_reg_state *reg,
-			     enum bpf_arg_type arg_type);
+struct bpf_call_arg_meta;
+int process_dynptr_func(struct bpf_verifier_env *env, int regno,
+			enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta);
 
 /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
 static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5579ff3a5b54..d02ae2f4249b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6575,23 +6575,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 						return -EINVAL;
 					}
 
-					if (!is_dynptr_reg_valid_init(env, reg)) {
-						bpf_log(log,
-							"arg#%d pointer type %s %s must be valid and initialized\n",
-							i, btf_type_str(ref_t),
-							ref_tname);
+					if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, NULL))
 						return -EINVAL;
-					}
-
-					if (!is_dynptr_type_expected(env, reg,
-							ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
-						bpf_log(log,
-							"arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
-							i, btf_type_str(ref_t),
-							ref_tname);
-						return -EINVAL;
-					}
-
 					continue;
 				}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 07c0259dfc1a..56f48ab9827f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -784,8 +784,7 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	return true;
 }
 
-bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
-			      struct bpf_reg_state *reg)
+static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
 	int spi = get_spi(reg->off);
@@ -804,9 +803,8 @@ bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
 	return true;
 }
 
-bool is_dynptr_type_expected(struct bpf_verifier_env *env,
-			     struct bpf_reg_state *reg,
-			     enum bpf_arg_type arg_type)
+static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				    enum bpf_arg_type arg_type)
 {
 	struct bpf_func_state *state = func(env, reg);
 	enum bpf_dynptr_type dynptr_type;
@@ -5694,6 +5692,66 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+int process_dynptr_func(struct bpf_verifier_env *env, int regno,
+			enum bpf_arg_type arg_type,
+			struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	int argno = regno - 1;
+
+	/* We only need to check for initialized / uninitialized helper
+	 * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
+	 * assumption is that if it is, that a helper function
+	 * initialized the dynptr on behalf of the BPF program.
+	 */
+	if (base_type(reg->type) == PTR_TO_DYNPTR)
+		return 0;
+	if (arg_type & MEM_UNINIT) {
+		if (!is_dynptr_reg_valid_uninit(env, reg)) {
+			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
+			return -EINVAL;
+		}
+
+		/* We only support one dynptr being uninitialized at the moment,
+		 * which is sufficient for the helper functions we have right now.
+		 */
+		if (meta->uninit_dynptr_regno) {
+			verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
+			return -EFAULT;
+		}
+
+		meta->uninit_dynptr_regno = regno;
+	} else {
+		if (!is_dynptr_reg_valid_init(env, reg)) {
+			verbose(env,
+				"Expected an initialized dynptr as arg #%d\n",
+				argno + 1);
+			return -EINVAL;
+		}
+
+		if (!is_dynptr_type_expected(env, reg, arg_type)) {
+			const char *err_extra = "";
+
+			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
+			case DYNPTR_TYPE_LOCAL:
+				err_extra = "local";
+				break;
+			case DYNPTR_TYPE_RINGBUF:
+				err_extra = "ringbuf";
+				break;
+			default:
+				err_extra = "<unknown>";
+				break;
+			}
+			verbose(env,
+				"Expected a dynptr of type %s as arg #%d\n",
+				err_extra, argno + 1);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
 {
 	return type == ARG_CONST_SIZE ||
@@ -6197,52 +6255,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_mem_size_reg(env, reg, regno, true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		/* We only need to check for initialized / uninitialized helper
-		 * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
-		 * assumption is that if it is, that a helper function
-		 * initialized the dynptr on behalf of the BPF program.
-		 */
-		if (base_type(reg->type) == PTR_TO_DYNPTR)
-			break;
-		if (arg_type & MEM_UNINIT) {
-			if (!is_dynptr_reg_valid_uninit(env, reg)) {
-				verbose(env, "Dynptr has to be an uninitialized dynptr\n");
-				return -EINVAL;
-			}
-
-			/* We only support one dynptr being uninitialized at the moment,
-			 * which is sufficient for the helper functions we have right now.
-			 */
-			if (meta->uninit_dynptr_regno) {
-				verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
-				return -EFAULT;
-			}
-
-			meta->uninit_dynptr_regno = regno;
-		} else if (!is_dynptr_reg_valid_init(env, reg)) {
-			verbose(env,
-				"Expected an initialized dynptr as arg #%d\n",
-				arg + 1);
-			return -EINVAL;
-		} else if (!is_dynptr_type_expected(env, reg, arg_type)) {
-			const char *err_extra = "";
-
-			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
-			case DYNPTR_TYPE_LOCAL:
-				err_extra = "local";
-				break;
-			case DYNPTR_TYPE_RINGBUF:
-				err_extra = "ringbuf";
-				break;
-			default:
-				err_extra = "<unknown>";
-				break;
-			}
-			verbose(env,
-				"Expected a dynptr of type %s as arg #%d\n",
-				err_extra, arg + 1);
-			return -EINVAL;
-		}
+		if (process_dynptr_func(env, regno, arg_type, meta))
+			return -EACCES;
 		break;
 	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
 		if (!tnum_is_const(reg->var_off)) {
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
index c210657d4d0a..fc562e863e79 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
@@ -18,10 +18,7 @@ static struct {
 	const char *expected_verifier_err_msg;
 	int expected_runtime_err;
 } kfunc_dynptr_tests[] = {
-	{"dynptr_type_not_supp",
-	 "arg#0 pointer type STRUCT bpf_dynptr_kern points to unsupported dynamic pointer type", 0},
-	{"not_valid_dynptr",
-	 "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid and initialized", 0},
+	{"not_valid_dynptr", "Expected an initialized dynptr as arg #1", 0},
 	{"not_ptr_to_stack", "arg#0 pointer type STRUCT bpf_dynptr_kern not to stack", 0},
 	{"dynptr_data_null", NULL, -EBADMSG},
 };
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index ce39d096bba3..f4a8250329b2 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -32,18 +32,6 @@ int err, pid;
 
 char _license[] SEC("license") = "GPL";
 
-SEC("?lsm.s/bpf")
-int BPF_PROG(dynptr_type_not_supp, int cmd, union bpf_attr *attr,
-	     unsigned int size)
-{
-	char write_data[64] = "hello there, world!!";
-	struct bpf_dynptr ptr;
-
-	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0, &ptr);
-
-	return bpf_verify_pkcs7_signature(&ptr, &ptr, NULL);
-}
-
 SEC("?lsm.s/bpf")
 int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
 {
-- 
2.38.1

