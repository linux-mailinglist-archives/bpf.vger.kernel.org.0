Return-Path: <bpf+bounces-9832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944879DCB0
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37DE1C212B6
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DA514F94;
	Tue, 12 Sep 2023 23:32:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A31429F
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:24 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E02510FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:24 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-52f33659d09so4426740a12.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561542; x=1695166342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEqNKEyyn2bquryM443pcbyNh0rQI9bn3pNb7P20yv0=;
        b=oaOz9eSie9Xm1ywgaVUbg2t2qcY7Jry0fUSl8oWKDbavVvLA3HdvO0xIdFbRXfzaIo
         ti4I3jngnFG7h59XYVgPwRP6TqANLa7/cbUNkr4YTGMs+8R3E1huwP/uXya7SWbkvD9S
         PJivGlPK+cDLNi2BzJMCi2PIIglCb703D4mczNcbBtd1x1TLVIb7WzI/ThKDX0jgfkpm
         RMhcm0cWJ31RyFBmIKvx9BLyPfixf2bPpG81CPJ8XUQ1X5q07RwpNYqW6crVp5EJzMhq
         5lCBCQjbPSEq6TTi/DjmQiS1FwKYjOeRaXd6z+dP0sK777qSdFHd4TkZojXhGyK54kUs
         s+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561542; x=1695166342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEqNKEyyn2bquryM443pcbyNh0rQI9bn3pNb7P20yv0=;
        b=V0RW/7QGOmrGRKqbq5LaRewBjQ+lrXrwpigonS0OwQbK6gK2cvXbfgSPF5GWaxG7RE
         vlEzoebK4ROQzxzb1GvVrLeKqNd8tEIFTv+mfcXMFUT7mrI3z9mVpdvc2YdD8q/y742D
         ykTglRJRpvqK75cdP/KpqfaXnVreImsYSZhHX4pyPZ0d8cJGkeXNmLuwfUY96bSOs4KE
         JSN9PcAS8vELOcSO4I6ap2zDmpfSsqOZAZZB1hJ8KjkkM3/fU1BGR/dE6yafetK10avq
         H3qPQCDu1BedP02GCtNWtxH0yopnGrpTNVuaUo4M3zGjQl2zyqLwu5IBuuYk60+jO1lH
         l+2w==
X-Gm-Message-State: AOJu0Yz0wb2qBYyxZMgcM4PSine9vqieJiIm1NpJ33NJDqvaQEx3lhB6
	Iun9p/VEmEdxn1looYbk3eA7CHEAgAC9nQ==
X-Google-Smtp-Source: AGHT+IEjuI+DgEaQ5vfu0OMk+2aXX3NkLWQ46JOTGJYDiVITOt0CuonVNB/qRFZr3f8nEDYdwTUXbQ==
X-Received: by 2002:a50:fb89:0:b0:52b:daff:f6e9 with SMTP id e9-20020a50fb89000000b0052bdafff6e9mr809317edq.17.1694561542086;
        Tue, 12 Sep 2023 16:32:22 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id eq18-20020a056402299200b0052fe2faf44fsm10411edb.75.2023.09.12.16.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 08/17] bpf: Treat first argument as return value for bpf_throw
Date: Wed, 13 Sep 2023 01:32:05 +0200
Message-ID: <20230912233214.1518551-9-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4675; i=memxor@gmail.com; h=from:subject; bh=NYrdPgP3ltPdMBCETLJI7uiGC1Lo4GXt4r58HXYpCNQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSty5CANEROfhpiVp2x8LTYd+djg+BPI4cGM /Fln6GI34GJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rQAKCRBM4MiGSL8R ygrxEAClHTzrnHzCLB9+1DynctsmmYCg7U0t27lQNc16RbEtYmrI23s0xg2jndvJ+uQ35q8G5W0 cwH1N2I3C59dQIbpWhTYV1WqB2DzUIBQ9k28CqZVA7Zkx+dWDah1NYNOXHgoUfbCCu3qoyVP3rh RdSHMHGp4YsaKdj4pimUtOx3XTgSXxD41YL/j9+B37KJV73wLKARb0pXtoUdJV1Zg2Ntbc6+RR6 et8pi+ywUOaQ80WvF1rtQtQkoTKxaeNVvhn8b61LgHOCXyabzWkYEuLTRr7RHx2cXCUnADArGvg B/OHzE272JRCHDn/O5FiAiMxPPHBKdttGEuDgnuHZ1iEiUoKBBnBGzEt2V+V8CJEsJ2l4/aZQgI WU46IjQMLOxYp5K54sJmTtg5TNO5URNucZeObdSf0pAnAVFHz6XI24j5C1OHQAAx5hWuH77KejZ Ji+huxJ3b1LanwUrM6bXWbhFNqxlYGyzvYVevWUGHQpHzINsEhoWC7WPpfggfTf1rW5XL+NyuaB DdZiW4hgP23ukbgbmJOs6jpfAuNftExBRTeMZaa5jFLmq+SX1fYHJluvQBLaJlCLw3ogT3ODoQ5 EMYbyrDCvQw71l+1lbm79DF/lvplEVnlFJSdWORj0J33BsB0uqaTXF9sds7Qf7eQSCaTN+ViuPg fCLcsEX1wlBbloA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

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
index 863e4e6c4616..0ba32b626320 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11485,6 +11485,8 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int check_return_code(struct bpf_verifier_env *env, int regno);
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -11613,6 +11615,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -14709,7 +14720,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
-static int check_return_code(struct bpf_verifier_env *env)
+static int check_return_code(struct bpf_verifier_env *env, int regno)
 {
 	struct tnum enforce_attach_type_range = tnum_unknown;
 	const struct bpf_prog *prog = env->prog;
@@ -14743,22 +14754,22 @@ static int check_return_code(struct bpf_verifier_env *env)
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
 
@@ -14771,8 +14782,8 @@ static int check_return_code(struct bpf_verifier_env *env)
 
 	if (is_subprog && !frame->in_exception_callback_fn) {
 		if (reg->type != SCALAR_VALUE) {
-			verbose(env, "At subprogram exit the register R0 is not a scalar value (%s)\n",
-				reg_type_str(env, reg->type));
+			verbose(env, "At subprogram exit the register R%d is not a scalar value (%s)\n",
+				regno, reg_type_str(env, reg->type));
 			return -EINVAL;
 		}
 		return 0;
@@ -14854,8 +14865,8 @@ static int check_return_code(struct bpf_verifier_env *env)
 	}
 
 	if (reg->type != SCALAR_VALUE) {
-		verbose(env, "At program exit the register R0 is not a known value (%s)\n",
-			reg_type_str(env, reg->type));
+		verbose(env, "At program exit the register R%d is not a known value (%s)\n",
+			regno, reg_type_str(env, reg->type));
 		return -EINVAL;
 	}
 
@@ -17053,7 +17064,7 @@ static int do_check(struct bpf_verifier_env *env)
 					continue;
 				}
 
-				err = check_return_code(env);
+				err = check_return_code(env, BPF_REG_0);
 				if (err)
 					return err;
 process_bpf_exit:
@@ -18722,7 +18733,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	if (env->seen_exception && !env->exception_callback_subprog) {
 		struct bpf_insn patch[] = {
 			env->prog->insnsi[insn_cnt - 1],
-			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 			BPF_EXIT_INSN(),
 		};
 
-- 
2.41.0


