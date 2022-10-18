Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024EF602DAF
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiJRN7i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 09:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiJRN7g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 09:59:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAC7BF4A
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so17428919pjq.3
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCy36PN3wJ1LB153aSf6Ng+oi283CCJUdsT0Es6SCzo=;
        b=ZrFsTvRd5SwJFEjV0t0qMx0eI303YJmwcFcR3NisDqm3MlJ9xXSB2+x4OIW4pT+TuV
         Ukv6kbCJmptBcEm1sZd0otZYBapAYNqhMOfoNnmaAxbNi/DjZ73nuRCaguSLEoH/SvwX
         6n3UCQ4JGzBMBS5J2BnmLFTfnTTjXmQ8C9dtQebD6WsTjRlAs890Rhp9/nChKhp6OBJ3
         fmMKXGgk7cfebi9FQIvS/c4pa7F0VLB0cOQtBAoE3P+xi26mmv+CIamohGPlFkqOyYnr
         g3tNA7rSvXD8eh/MvQlbAnSiTHEur/7M/2Dq1qgxe31+P0UnURnhmBE9miT7jR0+h4wJ
         DdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCy36PN3wJ1LB153aSf6Ng+oi283CCJUdsT0Es6SCzo=;
        b=jf4gTTLJdcQ67nH1OjauyKPb6/Clf8Kbz+OrX6MpA1Er9IHyGT5rNtfWbx9rUjMaRJ
         x6BldxiGbUXC2oVNJEbeOiDQ9UQ+Ve+cC0f5E4oQ3GFV8JfS4ncyTkmv9WVLtV25zail
         IxQbVa4IrPoSDtoiToGiLqPC5rtYn2L7fEJn5/eaiqDV4B0ZhLwgLzyfGIN9jXfuCVv7
         mFfu+2GcOhOpcxLhLVuisV69LK0PE0p6MOXbCuyfXvzhGmqYtT9dIVaUcDidY5XDJi5U
         bd4RN5XrSETSgOWDUcJ0cX7BWJvEiyTwsaBXaJU+2ot4NCIk6RPzeWLPPcwjWJS4jVEP
         m1QQ==
X-Gm-Message-State: ACrzQf3Sb3ly52X7g//GZ7R5IA86r4qb77WsEpdn+6rKXWH5C6H+pdGB
        NEbPMB5uJus+YqpY+OpL0/vIzAC4sesUqw==
X-Google-Smtp-Source: AMsMyM5mIggOs5YGzln41VTc6IIse0SwzpY60ofFsbZ73zqjBteJu24zvgPEc2hjXAnDViEWfBArKg==
X-Received: by 2002:a17:90a:c258:b0:20b:23d5:8eb2 with SMTP id d24-20020a17090ac25800b0020b23d58eb2mr3666601pjx.85.1666101572705;
        Tue, 18 Oct 2022 06:59:32 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090a678300b001f94d25bfabsm11694076pjj.28.2022.10.18.06.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:59:32 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 01/13] bpf: Refactor ARG_PTR_TO_DYNPTR checks into process_dynptr_func
Date:   Tue, 18 Oct 2022 19:29:08 +0530
Message-Id: <20221018135920.726360-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9595; i=memxor@gmail.com; h=from:subject; bh=BHwXyoAI/Z+OBPhsYJkkO3GcDz+jXjL23gceoL8/+D0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEig35tYAR1x2XKHvJuVSQjh+eu5P+WzupQPP03 JnNeWP6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8RymZ9EA CiyH+fjeAz3S+zNA8x/zOUxWqlbffHQy+60VFJQbB6usoueBnPwu1AOzd3mHU/U9jF3TNUUGEILDQ9 oYhph7ZrRN2WGdBQLbOb8zmibqk35XaTO3muDlMMPLVFDVpIKkE+dxdYEZMjSp7ems81XNsJCiu4+W fpXovKCjblUTdcXu4fX9zxvJ2dXVFSMDp8VTDeRN3Dy9hhYRtWn5DBePCT/Iv/7OQbNFeEGThqgE71 tJPHBnw2mZmTbzBIBVrC+t07/fj8O4GWYWps8j9MsSwAXIq3oCw126179WtTNnUS6HaZEM+U3Xki1P jJBwcO1+ZzM9UVPiHpxK0wuqWwKoq+h/KThTuCuVbyD+t8KFDdBFl3DDa0AgoAbKKGH6oOR7YG5jEt eKR6pox3zEmL/8MZo32xxSAeoXsMwrtRgkoqLKmWqxOygHBiSmAKaj0naLV57Pvhf/m5bITCxGmlar pZJHZ7+3k4rccNJL6k5FpuSnewLo22NKZFNKff8ldg1XmqT2JHoT+WeAsPvKFdTG4sSxWK2Ubhx3rV qr1UxgvVAtSjLMUjDPRlPOGK7NrQFMjwnUX6T0g/n+pfRaeqJKdnTXZpE4vmpOq5DRCBXcDRD4iUXs AajT9y0xwo+Ld7Q63VVTVQNsJ3Q2xZPiqKqP6tcI1BM47QSLX8hYOYIoNsew==
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

To this end, remove the dependency on bpf_call_arg_meta parameter by
instead taking the uninit_dynptr_regno by pointer. This is only needed
to be set to a valid pointer when arg_type has MEM_UNINIT.

Then, reuse this consolidated function in kfunc dynptr handling too.
Note that for kfuncs, the arg_type constraint of DYNPTR_TYPE_LOCAL has
been lifted.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h                  |   8 +-
 kernel/bpf/btf.c                              |  17 +--
 kernel/bpf/verifier.c                         | 115 ++++++++++--------
 .../bpf/prog_tests/kfunc_dynptr_param.c       |   5 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |  12 --
 5 files changed, 69 insertions(+), 88 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9e1e6965f407..a33683e0618b 100644
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
+int process_dynptr_func(struct bpf_verifier_env *env, int regno,
+			enum bpf_arg_type arg_type, int argno,
+			u8 *uninit_dynptr_regno);
 
 /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
 static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eba603cec2c5..1827d889e08a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6486,23 +6486,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 						return -EINVAL;
 					}
 
-					if (!is_dynptr_reg_valid_init(env, reg)) {
-						bpf_log(log,
-							"arg#%d pointer type %s %s must be valid and initialized\n",
-							i, btf_type_str(ref_t),
-							ref_tname);
+					if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, i, NULL))
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
index 6f6d2d511c06..31c0c999448e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -782,8 +782,7 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	return true;
 }
 
-bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
-			      struct bpf_reg_state *reg)
+static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
 	int spi = get_spi(reg->off);
@@ -802,9 +801,8 @@ bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
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
@@ -5573,6 +5571,65 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+int process_dynptr_func(struct bpf_verifier_env *env, int regno,
+			enum bpf_arg_type arg_type, int argno,
+			u8 *uninit_dynptr_regno)
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
+		if (*uninit_dynptr_regno) {
+			verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
+			return -EFAULT;
+		}
+
+		*uninit_dynptr_regno = regno;
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
@@ -6086,52 +6143,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
+		if (process_dynptr_func(env, regno, arg_type, arg, &meta->uninit_dynptr_regno))
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
2.38.0

