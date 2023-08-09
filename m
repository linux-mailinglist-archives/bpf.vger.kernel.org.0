Return-Path: <bpf+bounces-7340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D72A5775E08
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F7D1C2111C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C581017FFB;
	Wed,  9 Aug 2023 11:43:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1717744
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:43:10 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6930518E
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:43:09 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-52364e9daceso795634a12.2
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581387; x=1692186187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RQCLZLUwoM8WdFwA8DnuZn0TAGNZQI5hb8I+mfQGA4=;
        b=Ncxyacyly6uz0VU1hJK7dtSeHjhaCQdT3B8yvgzhRNcmeWzv7/E/xTos0WT/KxSOaW
         ZwgMOywsYg2swEYw/YhwF6qjwQYnLsfoE41jimpUsvEdfT+ysdXUGCjWLvosJ4MrfK+B
         sL4mwGA6psSfbDhbO2ovcfEqDoXMeZmaLWXRDIgRZk/wIP+vTiW8rW4wiNyWz2eOE6sK
         HjWZI+/GumhD09CKXBKS23w0e4WcUGRNvICVo/bvmmDpNDAsFanZWq+6h29GxBH0DkTq
         wBIFdrOw3z1vBXzamIM3kdc7xMW6V1FuKAgFfMZPQQigVhLPYTTJ1sOYH3u5BHcWpgx9
         x61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581387; x=1692186187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RQCLZLUwoM8WdFwA8DnuZn0TAGNZQI5hb8I+mfQGA4=;
        b=LjpV8CpZK+yTyNb8XnXxiqxdauxQvmR9KD6l+NkBMRzTWcWJTIi9nmVcKUGAcuJGu/
         nVIytOxfJFxsj+do+g+QVzhKD0uqKxNm1zjWCw+Q9axuompqPuXwW1r4lZ+YjzzApJEl
         z6lI/RPKubWm+Q67qmD0gv1LzMDEPNF4JvND0ks+DFXXkEwmkOhaKPpZLM10C1bDtR33
         NpL/kQ3lfQ5tWZKku5WFXEtFf2GsAVyqZNoWGIKMvsTDrGOtce/GYTwj3SKpzxnD/FOn
         Kr4DnlIkKuR0xmehUK5RnutW9dIACD6Sczr2AOcgysMC7AgKcQxTkE0crPP4Do4Uh4cn
         C1KA==
X-Gm-Message-State: AOJu0Ywmz5Oid8QXe+iz1ZfpIWosMtBJKZ2hTEVGZzrqYF2fMF6HZOV4
	K2KzMxRjq8p1BXrVsRfk5NwFQLfu3V0fM5ErKYs=
X-Google-Smtp-Source: AGHT+IF7MrE8lKvGeGtZg6/sefQWO+Iwz2U2XJVu/Zj73XsDRjGKeXPBGOjJ9qu6x0JtQK3tXKUQtA==
X-Received: by 2002:a17:906:1c7:b0:997:c377:b41f with SMTP id 7-20020a17090601c700b00997c377b41fmr2121702ejj.64.1691581386728;
        Wed, 09 Aug 2023 04:43:06 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id a14-20020a17090682ce00b0099d0c0bb92bsm809631ejy.80.2023.08.09.04.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:43:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 07/14] bpf: Treat first argument as return value for bpf_throw
Date: Wed,  9 Aug 2023 17:11:09 +0530
Message-ID: <20230809114116.3216687-8-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4675; i=memxor@gmail.com; h=from:subject; bh=12P3B/yYYq41xWHnsCoi5CZR1+UBgMaPfc02X/5Pb7w=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rJ+OTSgB1Qy1gGKT963T+b6XCHwbs4qjqkO Abjzv0wR4KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yQAKCRBM4MiGSL8R ypVGD/4lsgY2+/M2+LTKK0k3axTZ63/CBVh+1nJ5VmPCY47sP3McMVGekxN9HBnw3f6j+fOA6w7 2wrjEgVB8osIQfEYIgDJUrgfRFwyi6WnbOLkG2VkvFngTOlpqfnHMSXvyuAFepI0Bjb7S8DzeoW 7GNoiXUHs8NDqsz0OrWPO9iK3WOTdPCvwlbkbZ1RgqLu2aefcagKOADUbwpKKxwTewQ3UwPPtMD KhuQ+a++ed+dljbdiIWpn1P+VcUWYtvZonYrldVL0V4Do52e5cs27Oc/0YwkJzifeZuBE1M7OYH 8DqCJoYkRQmNZDv/7LWJHIgZtUUGZ7BiMNf8g7BExU5LYs4W2nzzlljhkclqFh8GhNf7gGjEXhA Ts8Z8K2D11cxd+07VbRBiu70A1BPD7GzdnGjMgDbY/jTi/v3IdPKRwGIqIH2/RxdLiCw33lcjVj mIOMT96tulT8ZceyRnkxRj/bhKQruolntkLhF0AAtQqV+uCKx0WFOoKXACKlNNVCrBsgsBes3BB HwTvh925q9i5h4HB5J/MegeVolZUQo7HwvBCc/CvW3iuw4EhcIgbZ2Fvc7dbRAck2fZIf9xO8cC 7vqx7lnWhKb5hNdavL2TI6uvYbZNb1QfHTStdarOmq8DjK6KRYxl+4YwRjNE3WJI3n6lq0bRIev 49cEwZkvG/fbH7g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In case of the default exception callback, change the behavior of
bpf_throw, where the passed cookie value is no longer ignored, but
is instead the return value of the default exception callback. As
such, we need to place restrictions on the value being passed into
bpf_throw in such a case, only allowing those permitted by the
check_return_code function.

Thus, bpf_throw can now control the return value of the program from
each call site without having the user install a custom exception
callback just to override the return value when an exception is thrown.

We also modify the hidden subprog instructions to now move BPF_REG_1 to
BPF_REG_0, so as to set the return value before exit in the default
callback.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c22ba0423d27..a0e1a1d1f5d3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11415,6 +11415,8 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int check_return_code(struct bpf_verifier_env *env, int regno);
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -11538,6 +11540,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -ENOTSUPP;
 		}
 		env->seen_exception = true;
+
+		/* In the case of the default callback, the cookie value passed
+		 * to bpf_throw becomes the return value of the program.
+		 */
+		if (!env->exception_callback_subprog) {
+			err = check_return_code(env, BPF_REG_1);
+			if (err < 0)
+				return err;
+		}
 	}
 
 	for (i = 0; i < CALLER_SAVED_REGS; i++)
@@ -14612,7 +14623,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
-static int check_return_code(struct bpf_verifier_env *env)
+static int check_return_code(struct bpf_verifier_env *env, int regno)
 {
 	struct tnum enforce_attach_type_range = tnum_unknown;
 	const struct bpf_prog *prog = env->prog;
@@ -14646,22 +14657,22 @@ static int check_return_code(struct bpf_verifier_env *env)
 	 * of bpf_exit, which means that program wrote
 	 * something into it earlier
 	 */
-	err = check_reg_arg(env, BPF_REG_0, SRC_OP);
+	err = check_reg_arg(env, regno, SRC_OP);
 	if (err)
 		return err;
 
-	if (is_pointer_value(env, BPF_REG_0)) {
-		verbose(env, "R0 leaks addr as return value\n");
+	if (is_pointer_value(env, regno)) {
+		verbose(env, "R%d leaks addr as return value\n", regno);
 		return -EACCES;
 	}
 
-	reg = cur_regs(env) + BPF_REG_0;
+	reg = cur_regs(env) + regno;
 
 	if (frame->in_async_callback_fn) {
 		/* enforce return zero from async callbacks like timer */
 		if (reg->type != SCALAR_VALUE) {
-			verbose(env, "In async callback the register R0 is not a known value (%s)\n",
-				reg_type_str(env, reg->type));
+			verbose(env, "In async callback the register R%d is not a known value (%s)\n",
+				regno, reg_type_str(env, reg->type));
 			return -EINVAL;
 		}
 
@@ -14674,8 +14685,8 @@ static int check_return_code(struct bpf_verifier_env *env)
 
 	if (is_subprog && !frame->in_exception_callback_fn) {
 		if (reg->type != SCALAR_VALUE) {
-			verbose(env, "At subprogram exit the register R0 is not a scalar value (%s)\n",
-				reg_type_str(env, reg->type));
+			verbose(env, "At subprogram exit the register R%d is not a scalar value (%s)\n",
+				regno, reg_type_str(env, reg->type));
 			return -EINVAL;
 		}
 		return 0;
@@ -14757,8 +14768,8 @@ static int check_return_code(struct bpf_verifier_env *env)
 	}
 
 	if (reg->type != SCALAR_VALUE) {
-		verbose(env, "At program exit the register R0 is not a known value (%s)\n",
-			reg_type_str(env, reg->type));
+		verbose(env, "At program exit the register R%d is not a known value (%s)\n",
+			regno, reg_type_str(env, reg->type));
 		return -EINVAL;
 	}
 
@@ -16955,7 +16966,7 @@ static int do_check(struct bpf_verifier_env *env)
 					continue;
 				}
 
-				err = check_return_code(env);
+				err = check_return_code(env, BPF_REG_0);
 				if (err)
 					return err;
 process_bpf_exit:
@@ -18601,7 +18612,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	if (env->seen_exception && !env->exception_callback_subprog) {
 		struct bpf_insn patch[] = {
 			env->prog->insnsi[insn_cnt - 1],
-			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 			BPF_EXIT_INSN(),
 		};
 
-- 
2.41.0


