Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2FD5821D9
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 10:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiG0IQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 04:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiG0IQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 04:16:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04A9DEF9
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 01:16:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ez10so30030447ejc.13
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIoDhcGiqhGKojn8eNLi3XhqwqgdeDatr/OetzRQfKc=;
        b=n/jDagweOmhA3l5wZusiKy/fxLBbs/Q0GEo3hn+z9t4LW8zSotlF1ONFNuiT2opX8L
         j7xfjysFkdYoxEoj57bV6ptWSCFERns1gPP1wetpGYbYQ3x6Il7twLqr7o4dplhrlWLP
         kmWtnDitKtJ+aU22WD3G/y6MpJgDGSH14XBZbXhhEPBweqiLgoonl+Cqpv3YBX11jcxc
         BBA+2T/u5j30m0p58rUF7667GEgsXfom0f/WQvqNRA51ibABnffxO2l+WxelgjlIqUwV
         fpA5HcC9510biO8IZsHOaKlIE6z0jEvAJc4LO0bpA8bhqBPcBod2nOOfmrwUu/gQ8D/F
         LGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIoDhcGiqhGKojn8eNLi3XhqwqgdeDatr/OetzRQfKc=;
        b=o+9kwWMRAuMgDjXqxMLpKvfO8PZBEG+u5ESphUAUAg0Z75y/XjicySt6J7u3mrf4jk
         L/ZEwZqkILFBbxJkF3IevOaKTqxOZU+aDd5+RHfA9Q5XmI79qHdLy4OeWjtB97InEk/J
         QCEFiyJ9hXdFc17xnD39IuqK0afYON6E4BqyvNTSNhgQ9NjWEEcGg9tqthwBjMzmkFvw
         /UOaR37TrB5eMOwMa8AYiI5zcawA2a6r5iNUcstYvh8kjJxRog3iZnjSNqEtA+nAkp/H
         r/fVV6yrISA2eGk3PUbH4zQzb1xkrEmPSZZchmB07ld7gPsajkrdKyUgY0RY5rPPc3BS
         +KbQ==
X-Gm-Message-State: AJIora9jGj6w4EomSkTpfQGUk3oFKC6UN1eScPM8kwu5ZhXEKyNfGEzS
        CzTUIeN3nr9yCmRYjPA3bnAHU0c8CLsWvQ==
X-Google-Smtp-Source: AGRyM1uJASd0Yhq5k3ygECaxZ+vZ71IQFDCwcxRPW9IIxGW/PxQPPr0ecZnJqKTbEexvetnjpVvUKA==
X-Received: by 2002:a17:906:5a61:b0:72b:1468:7fac with SMTP id my33-20020a1709065a6100b0072b14687facmr16729188ejc.440.1658909762017;
        Wed, 27 Jul 2022 01:16:02 -0700 (PDT)
Received: from localhost (icdhcp-1-189.epfl.ch. [128.178.116.189])
        by smtp.gmail.com with ESMTPSA id o26-20020a170906769a00b0070e238ff66fsm7300025ejm.96.2022.07.27.01.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 01:16:01 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter trusted args
Date:   Wed, 27 Jul 2022 10:15:58 +0200
Message-Id: <20220727081559.24571-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727081559.24571-1-memxor@gmail.com>
References: <20220727081559.24571-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6540; i=memxor@gmail.com; h=from:subject; bh=jijQE6Ln4stnbqFXIx9nQyvNef9Dcp2T7MyS5u3b/rM=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi4PP/v5+6D+NrkvkBd7YtxouwvrgBg2ZN5twXJ/uI qb6uDDuJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYuDz/wAKCRBM4MiGSL8RyhHlD/ 0W1TpR1SFSdVSSbf7dSNCrWrx2jdsnFSxnLFSZR0+gKJQpwKxdIrJgH7pDYWoDDCgq6pt7I015KCW8 Sh+sQli+aLnU0CPKdKVve/e1klNSYXlTEAWGBk52+FNLJTEkPx42d3lR9LokdhWx4QBsivFvlP6Dyo SNEbMknm/hKFzdMRpdFH6mzS1Scr/KoXCzmB4lj9VyNzDkQZkrCct79wjh8yhwOZMrVUJUOiDfFz6U QS786oW4lPlDBjSHKDmYRjqYn42xe4UzFOOki1FnZojdo2xDrjqDRHm6n1vUvDrvenwiBvuaz4dKor lCE1tSoTVFGpM9wgyqATzD/JuKriidSZpGY91l8YLfHsHuv1hyNjvxDP0YLDVhxJkGjWjVHv+a0ylk 7DS5ItrsuL6v/xVzT1sujDmEX6cRl/8J9YEI1+2SkwQchnT/DeMTPhppeUaeZFzQFGI3h67KichM2s yEY0EPE6Gx8c87CS/p9iKgWZgTPHp+eJQk2WWaBjTx/5DhtbSA7WSSGOS+kUcOrks7BLs2DF+AGIcc 8AWOmUgeozFRNRo2/heV/jx0nhnIoTm1nBZBjcmiR+j7EKi3vBBm9WEKgKx0ETm1vuE8Ukw3wP0jq7 +KYn4b/PrU7dGtHOtb4syyglMjkeRRncLPQPlCoGNbappeX2CQS2jZYq6eJA==
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

Similar to how we detect mem, size pairs in kfunc, teach verifier to
treat __ref suffix on argument name to imply that it must be a trusted
arg when passed to kfunc, similar to the effect of KF_TRUSTED_ARGS flag
but limited to the specific parameter. This is required to ensure that
kfunc that operate on some object only work on acquired pointers and not
normal PTR_TO_BTF_ID with same type which can be obtained by pointer
walking. Release functions need not specify such suffix on release
arguments as they are already expected to receive one referenced
argument.

Cc: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 18 +++++++++++++++++
 kernel/bpf/btf.c             | 39 ++++++++++++++++++++++++------------
 net/bpf/test_run.c           |  9 +++++++--
 3 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index c0b7dae6dbf5..41dff6337446 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -72,6 +72,24 @@ argument as its size. By default, without __sz annotation, the size of the type
 of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
 pointer.
 
+2.2.2 __ref Annotation
+----------------------
+
+This annotation is used to indicate that the argument is trusted, i.e. it will
+be a pointer from an acquire function (defined later), and its offset will be
+zero. This annotation has the same effect as the KF_TRUSTED_ARGS kfunc flag but
+only on the parameter it is applied to. An example is shown below::
+
+        void bpf_task_send_signal(struct task_struct *task__ref, int signal)
+        {
+        ...
+        }
+
+Here, bpf_task_send_signal will only act on trusted task_struct pointers, and
+cannot be used on pointers obtained using pointer walking. This ensures that
+caller always calls this kfunc on a task whose lifetime is guaranteed for the
+duration of the call.
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7ac971ea98d1..3ce9b2deef9c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6141,18 +6141,13 @@ static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
 	return true;
 }
 
-static bool is_kfunc_arg_mem_size(const struct btf *btf,
-				  const struct btf_param *arg,
-				  const struct bpf_reg_state *reg)
+static bool btf_param_match_suffix(const struct btf *btf,
+				   const struct btf_param *arg,
+				   const char *suffix)
 {
-	int len, sfx_len = sizeof("__sz") - 1;
-	const struct btf_type *t;
+	int len, sfx_len = strlen(suffix);
 	const char *param_name;
 
-	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
-		return false;
-
 	/* In the future, this can be ported to use BTF tagging */
 	param_name = btf_name_by_offset(btf, arg->name_off);
 	if (str_is_empty(param_name))
@@ -6161,10 +6156,26 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
 	if (len < sfx_len)
 		return false;
 	param_name += len - sfx_len;
-	if (strncmp(param_name, "__sz", sfx_len))
+	return !strncmp(param_name, suffix, sfx_len);
+}
+
+static bool is_kfunc_arg_ref(const struct btf *btf,
+			     const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__ref");
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
+	return btf_param_match_suffix(btf, arg, "__sz");
 }
 
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
@@ -6174,7 +6185,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    u32 kfunc_flags)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
-	bool rel = false, kptr_get = false, trusted_arg = false;
+	bool rel = false, kptr_get = false, kf_trusted_args = false;
 	struct bpf_verifier_log *log = &env->log;
 	u32 i, nargs, ref_id, ref_obj_id = 0;
 	bool is_kfunc = btf_is_kernel(btf);
@@ -6211,7 +6222,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		/* Only kfunc can be release func */
 		rel = kfunc_flags & KF_RELEASE;
 		kptr_get = kfunc_flags & KF_KPTR_GET;
-		trusted_arg = kfunc_flags & KF_TRUSTED_ARGS;
+		kf_trusted_args = kfunc_flags & KF_TRUSTED_ARGS;
 	}
 
 	/* check that BTF function arguments match actual types that the
@@ -6221,6 +6232,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		enum bpf_arg_type arg_type = ARG_DONTCARE;
 		u32 regno = i + 1;
 		struct bpf_reg_state *reg = &regs[regno];
+		bool trusted_arg = false;
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 		if (btf_type_is_scalar(t)) {
@@ -6239,6 +6251,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		/* Check if argument must be a referenced pointer, args + i has
 		 * been verified to be a pointer (after skipping modifiers).
 		 */
+		trusted_arg = kf_trusted_args || is_kfunc_arg_ref(btf, args + i);
 		if (is_kfunc && trusted_arg && !reg->ref_obj_id) {
 			bpf_log(log, "R%d must be referenced\n", regno);
 			return -EINVAL;
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index cbc9cd5058cb..247bfe52e585 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -691,7 +691,11 @@ noinline void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
 {
 }
 
-noinline void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p)
+noinline void bpf_kfunc_call_test_trusted(struct prog_test_ref_kfunc *p)
+{
+}
+
+noinline void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p__ref)
 {
 }
 
@@ -718,7 +722,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_trusted, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref)
 BTF_SET8_END(test_sk_check_kfunc_ids)
 
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
-- 
2.34.1

