Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7022F646281
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiLGUlv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLGUlt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:41:49 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BA130558
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:41:48 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id s7so18147770plk.5
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 12:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzOn02ziw3M/3qoRJvJlC9A7pu6zScfFExcm584kBBo=;
        b=OvHI43Y2NEsjZn/3j+t0fWzuvivG6uawoMC5wv1HbgYw9y6enyhqcT/pBAFpr+HHP+
         68qcRcr8XuzzR1/vOt4EQSbZU8Ro++9OZBCTxTOuMmyrvU6XqBZWcjk2awMzls5fJlKA
         4oOZgvaEdvxE9unEr4FxqernIzbRoMKOIQalkWra3yPaX1sL4ip6P883w18n61c8GJ8+
         PGoHyN+1w51u71QCyMQbC613OLbgmbjgsOX6s/67EKVTxvdc+M85lsvJdiFlQ6CpRtAt
         IwAR2snpbAx+VgSSSCraC1sgGxIrYWKCbV9bSPxqvrhkex4fEXSyKztFg+FRW8ecTZFA
         yi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzOn02ziw3M/3qoRJvJlC9A7pu6zScfFExcm584kBBo=;
        b=PbLZ4eJuRdVvNfgCc7oNdeQlw3NyQr7pJY0Fl+I/psVNLpT0uoG5VfwvNuEXeORSbt
         0w01y+/jDdNPOlDiTvXWp734ii2yXm4RUwOWz608kMpZp5j3o2fH2FY9n27r4xHU9unt
         vx4oiWT8JJjkoqPbHinh8hDbBBNN4gJL6DgIA4c372IqmPD5m4/7DBbolosBZuKI0Dcf
         Mtf395EQcY+qrA9iaSoDzgYu7tTpE/qCzCMCn4qoj9yFqTPMCrKYZIh9TT3lcyqJpZea
         qCd4pjh8qkcnPoMOuGtdETPfFFH/tRlcFLsyjo9qIPYBcbHy6Fv5cB5wegRZVYLKol1A
         fD0A==
X-Gm-Message-State: ANoB5pmlbTsc/mOPi5XB4N98n7YxkfZDmgBUNoKCuyjc2fmmjB/rKgXU
        fj6FHQ+n+s2uzeCBNvUrkkFWWQUnSQfKpYCJ
X-Google-Smtp-Source: AA0mqf43RsdNiCe5YTfUT4TOtpJ8IoQYKEkykaD0Sk0zUnSPb1BcH+Ce876131W/UCQHDRKYKRKxdQ==
X-Received: by 2002:a17:902:e5c6:b0:189:a2d4:7ee with SMTP id u6-20020a170902e5c600b00189a2d407eemr39202665plf.18.1670445707551;
        Wed, 07 Dec 2022 12:41:47 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090332ce00b001892af9472esm8829073plr.261.2022.12.07.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:41:47 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/7] bpf: Refactor ARG_PTR_TO_DYNPTR checks into process_dynptr_func
Date:   Thu,  8 Dec 2022 02:11:35 +0530
Message-Id: <20221207204141.308952-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207204141.308952-1-memxor@gmail.com>
References: <20221207204141.308952-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9676; i=memxor@gmail.com; h=from:subject; bh=YTL37cfGNuxkKC6reZyo4bQbzGQOb6/1EE30AXlrgdM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjkPOoLL+B1X26N3Ql+5/u48SxpCxiE8mzeSKwYt4x UBw2/ZaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY5DzqAAKCRBM4MiGSL8RyueZD/ sHS7Mtf/Gstq5M24aOfo7V6oP1rCwm3yW9msZ8SQkEZtGmijqikJtcVF97L4xnuEBkOI3kbcPCpKKH V/lOJSQTLqSe0RBGvu5JgGH4Fi+ioGCSKy5S+dRjGwYgr9v2ocamPzrNVgv5MVqRyqfGHFwV1yqP8T vSJFEyGZtVH2bUXlmXqbuZApzGY2s7vNrGULnCMfsozBtmeOQv5XVaONqkPl2/wO5O8HeyWVJqmpzk VYY9SkJZ9Y8sVJaF3Da+qPnxXcJ0XCt35sgghZraLU+rnvvmn0VfmMoWt+NOf0BK6FMdkR9rmzaidb AM+SoXQ0/pPoCqPrL3CFysXUfku4++FgGnw7rB6GZowdv9XKa2Vx+sPJtpwzZ78leeSYxgeOkJYp1R bPYCmqYLgFlmE728qJgNSfk35xSzctWqME4h9tm+/Gs+og4/mDOA/Y8GTHX1MxZd1l8nXiVjV1jh58 vK3Z27Jb3vVjwxMNUgS4CFhledOGMLr8WzXw1aKZIch+9Rkm5I5pFSoQ7/J/918LnU7MCYgjvXJcil NcXjrYUclbnRC3QbeDGz6Ceys3fwyf+IQyG7XQmh2yKCmCybchH7iuoeIReyu5OiVrW9y3E+oePJTQ 79ozncPrNFlCuu7ZrnTm+1FWcsX5qFgIzPW2O8qLrL53eneEJtStJxFSigzw==
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
Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  |   8 +-
 kernel/bpf/verifier.c                         | 134 +++++++++---------
 .../bpf/prog_tests/kfunc_dynptr_param.c       |   7 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |  12 --
 4 files changed, 75 insertions(+), 86 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 70d06a99f0b8..df0cb825e0e3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -615,11 +615,9 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   enum bpf_arg_type arg_type);
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c5f0adbbde3..882181b14cf1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -810,8 +810,7 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	return true;
 }
 
-bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
-			      struct bpf_reg_state *reg)
+static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
 	int spi = get_spi(reg->off);
@@ -830,9 +829,8 @@ bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
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
@@ -5859,6 +5857,65 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+int process_dynptr_func(struct bpf_verifier_env *env, int regno,
+			enum bpf_arg_type arg_type,
+			struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
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
+				regno);
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
+				err_extra, regno);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
 {
 	return type == ARG_CONST_SIZE ||
@@ -6390,52 +6447,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -8829,22 +8842,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_DYNPTR:
-			if (reg->type != PTR_TO_STACK) {
-				verbose(env, "arg#%d expected pointer to stack\n", i);
-				return -EINVAL;
-			}
-
-			if (!is_dynptr_reg_valid_init(env, reg)) {
-				verbose(env, "arg#%d pointer type %s %s must be valid and initialized\n",
-					i, btf_type_str(ref_t), ref_tname);
+			if (reg->type != PTR_TO_STACK &&
+			    reg->type != PTR_TO_DYNPTR) {
+				verbose(env, "arg#%d expected pointer to stack or dynptr_ptr\n", i);
 				return -EINVAL;
 			}
 
-			if (!is_dynptr_type_expected(env, reg, ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
-				verbose(env, "arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
-					i, btf_type_str(ref_t), ref_tname);
-				return -EINVAL;
-			}
+			ret = process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, NULL);
+			if (ret < 0)
+				return ret;
 			break;
 		case KF_ARG_PTR_TO_LIST_HEAD:
 			if (reg->type != PTR_TO_MAP_VALUE &&
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
index 55d641c1f126..a9229260a6ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
@@ -18,11 +18,8 @@ static struct {
 	const char *expected_verifier_err_msg;
 	int expected_runtime_err;
 } kfunc_dynptr_tests[] = {
-	{"dynptr_type_not_supp",
-	 "arg#0 pointer type STRUCT bpf_dynptr_kern points to unsupported dynamic pointer type", 0},
-	{"not_valid_dynptr",
-	 "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid and initialized", 0},
-	{"not_ptr_to_stack", "arg#0 expected pointer to stack", 0},
+	{"not_valid_dynptr", "Expected an initialized dynptr as arg #1", 0},
+	{"not_ptr_to_stack", "arg#0 expected pointer to stack or dynptr_ptr", 0},
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

