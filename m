Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD7E6D7194
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 02:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbjDEAnC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 20:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbjDEAnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:43:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441CB49C0
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 17:42:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so22438382wmq.2
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 17:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680655369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1lUqsIAEYTJ8ZnNXnHCoXIx40Afuu8M4s/AS5zPZxs=;
        b=n9rKi81dJIEnQxjT+iWnPvvFtEvxNiEYKC3FayDx9fz1+wesBCNiaeHqwiQNkXMElM
         76GdA+qoQbBqQ1VIdJH2yiIQzlw3tfS25Mp1y4qTFi9GX8wp4YQvyIb+y+Tc50rIL0X1
         3crpb5/qCvACAxdEilONrJ4sl53qFKVJIhJi02O50ibk5T/ht62wpJ1s2gpzifeVP4l7
         5IEVnoXIxxsIy0hVEPM7rxf7Wvo+1bWY0ZUPQUntT7asz+UqqdPmeFqJZn0f7Dtq8WCh
         h9BsxjsT1pyVZX08fvjXYhG4efQ/yhvvgeCCPKPLGEDrpgbenk+xQ1A7eKC4Wls497oY
         RMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1lUqsIAEYTJ8ZnNXnHCoXIx40Afuu8M4s/AS5zPZxs=;
        b=zdMLG4O+/t779Vgsss5ZbvdPp/X9NHb62lV+/Za4H/yjCXpHYZPkQhfRZUoPDWA9Rr
         LZEwyTyR/WkZqTC11/ZT1dFQ4LCuJqgZOtJWXB5M3BtRIaWlcHN50jxzPDWJfUYftJhd
         XWbtW4uPFI6CKiLI7IrAaMPgu5I9njicuroopTRA1Fo+fWXec5MLWOe+MsIC1AdWkDBB
         z4IJmM4ONesethA8i09TChUwvndvvqr9dNaH4aUYHJCetGeqmOnPGPDjBTRaLamGqoxZ
         XKLm72eqOmi0NJClwhgVC5PB6yjKQHNe3GG4ST+tA1BChTw/Lu/3rs1wZbf7RwxGRDoq
         /U3w==
X-Gm-Message-State: AAQBX9efrLBCaU6q1GCoumigvB4HcbfcYdyhW3gzXmPd+3PAcHGLy14H
        afRgZgeYUpKDwp6B5zFju9H8fB8xsd15dQ==
X-Google-Smtp-Source: AKy350Y8f9ZegmcAiuEI2Vu1lje7/hVrnIMSR7Tl0rzs6Ut499iFMJH6UuvVxr64V/Ycxsi2U20vJg==
X-Received: by 2002:a05:600c:2312:b0:3ed:2b27:5bcc with SMTP id 18-20020a05600c231200b003ed2b275bccmr3482145wmo.38.1680655369176;
        Tue, 04 Apr 2023 17:42:49 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b003ede3f5c81fsm414809wmq.41.2023.04.04.17.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 17:42:48 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH RFC bpf-next v1 5/9] bpf: Add pass to fixup global function throw information
Date:   Wed,  5 Apr 2023 02:42:35 +0200
Message-Id: <20230405004239.1375399-6-memxor@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405004239.1375399-1-memxor@gmail.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6079; i=memxor@gmail.com; h=from:subject; bh=9fnVPcXRP2rJGjCXRNDjXVXazYSKBKpnCXL81OBR0y4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBkLMPw3oQxJbuK+1n53nZMocqhCaTStWwXZxl1V vGcpgw5GM+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZCzD8AAKCRBM4MiGSL8R ynZRD/9qH0LfWsr8kAmWMKaGXzcHZmnoU35xqakTdgDV26Xxg49K+lRGqY6FtYHIm6h0atLCz9I sDIDKsM7j8DJOHbJJAGHMsyjI+Rv9a3r0PhcsEnM3ttXzt4n5TZrZQrVC97NgyVY3iUuKpVXVod W9G4cJ7bpYSdjkvBex7n5Fjyv1IvGxnatqjsshS9t96rAujEdc2PlGzCfpZjoZAUyO8pU3t0Vyn KWFiZGVENXK4Wu88kmNcaV5kgsBA/gdTNaClva4wNU5L36q8BBycskATKTbtb3vjQdHGY95ZGAx RqXL8LuFmo/ieMzn/xsU2F55r+sYdm7TeJHn4PUiuBYZT6Zbhbs/On6mV3jFx8zDPa4Zx6J4Sas Gaad5B63v2zHcZpX+HaEY7AldYtR4RM23GN17kSA2jAab5l6bfAvbGy3hSJBxbMvQ+0XbYDVP+w 0QM6LYtxzo/JFkoqLM51RuB8JCvL5L1LSscqYyq5cfkoWW4BeQJDI7mvc70HJePfdx64CqcwaKv c55A/vTNY/1Gk9AE9Hpa2wT8Lc1lHyKfOOEsUerrpWUaajAZu2rX59sLl39tQvF8ZOvJ4UcbVvi dYoaRX8agmVTjpWYAkTgnomC1IyFSUIGJOwoYayscAM+4AzynTlxHX13cu5XITLZAcTPROnDU+c +kfDJsrzkHOBKpg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Within the do_check pass, we made a core assumption that we have correct
can_throw info about all global subprogs and simply used
mark_chain_throw without entering them to mark callsites leading up to
their call. However, the do_check_subprogs pass of verifier is iterative
and does not propagate can_throw information across global subprogs
which call into each other. We need an extra pass through all of them to
propagate can_throw information visibility throwing global subprogs into
global subprogs that call into them.

After doing this pass, do_check_main will directly use mark_chain_throw
again and have the correct information about all global subprogs which
are called by it.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 118 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 07d808b05044..acfcaadca3b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13664,6 +13664,12 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			verbose(env, "missing btf func_info\n");
 			return -EINVAL;
 		}
+		/* NOTE: Do not change this directly, as we rely on only
+		 * BPF_FUNC_STATIC allowed as BPF_PSEUDO_FUNC targets in
+		 * do_check_subprogs, see comment about propagating exception
+		 * information across global functions. When changing this, add
+		 * bpf_pseudo_func handling to the propagating loop as well.
+		 */
 		if (aux->func_info_aux[subprogno].linkage != BTF_FUNC_STATIC) {
 			verbose(env, "callback function not static\n");
 			return -EINVAL;
@@ -18491,6 +18497,110 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	return ret;
 }
 
+/* We have gone through all global subprogs, and we know which ones were seen as
+ * throwing exceptions. Since calls to other global functions are not explored
+ * and we simply continue exploration at the next instruction, we may have not
+ * fully propagated can_throw information. E.g. consider the case below, where 1
+ * and 2 are verified in order.
+ *
+ * gfunc 1:
+ *	call gfunc2
+ *	exit
+ * gfunc 2:
+ *	call bpf_throw
+ *
+ * At this point, gfunc1 is not marked as throwing, but it calls gfunc2 which
+ * actually throws. The only thing we need to do is go through every global
+ * function, and propagate the information back to their callers. We only care
+ * about BPF_PSEUDO_CALL, as BPF_PSEUDO_FUNC loads cannot have global functions
+ * as targets
+ *
+ * Logic mostly mimics check_max_stack_depth, but adjusted and simplified for
+ * our use case.
+ */
+static int fixup_global_subprog_throw_info(struct bpf_verifier_env *env)
+{
+	struct bpf_func_info_aux *func_info_aux = env->prog->aux->func_info_aux;
+	struct bpf_subprog_info *subprog = env->subprog_info;
+	int frame = 0, idx = 0, i = 0, subprog_end;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int ret_insn[MAX_CALL_FRAMES];
+	int ret_prog[MAX_CALL_FRAMES];
+	bool can_throw;
+	int j, ret;
+
+	/* Start at first global subprog */
+	for (int s = 1; s < env->subprog_cnt; s++) {
+		if (func_info_aux[s].linkage != BTF_FUNC_GLOBAL)
+			continue;
+		idx = s;
+		break;
+	}
+	if (!idx)
+		return -EFAULT;
+	i = subprog[idx].start;
+continue_func:
+	can_throw = false;
+	subprog_end = subprog[idx + 1].start;
+	for (; i < subprog_end; i++) {
+		int next_insn;
+
+		if (!bpf_pseudo_call(insn + i))
+			continue;
+		/* remember insn and function to return to */
+		ret_insn[frame] = i + 1;
+		ret_prog[frame] = idx;
+
+		/* find the callee */
+		next_insn = i + insn[i].imm + 1;
+		idx = find_subprog(env, next_insn);
+		if (idx < 0) {
+			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n", next_insn);
+			return -EFAULT;
+		}
+
+		/* Only follow global subprog calls */
+		if (func_info_aux[idx].linkage != BTF_FUNC_GLOBAL)
+			continue;
+		/* If this subprog already throws, mark all callers and continue
+		 * with next instruction in current subprog.
+		 */
+		if (subprog[idx].can_throw) {
+			/* Include current frame info when marking */
+			for (j = frame; j >= 0; j--) {
+				func_info_aux[ret_prog[j]].throws_exception = subprog[ret_prog[j]].can_throw = true;
+				/* Exception subprog cannot be set in global
+				 * function context, so set_throw_state_type
+				 * will always mark type as BPF_THROW_INNER
+				 * and subprog as -1.
+				 */
+				ret = set_throw_state_type(env, ret_insn[j] - 1, j, ret_prog[j]);
+				if (ret < 0)
+					return ret;
+			}
+			continue;
+		}
+
+		i = next_insn;
+		frame++;
+		if (frame >= MAX_CALL_FRAMES) {
+			verbose(env, "the call stack of %d frames is too deep !\n",
+				frame);
+			return -E2BIG;
+		}
+		goto continue_func;
+	}
+	/* end of for() loop means the last insn of the 'subprog'
+	 * was reached. Doesn't matter whether it was JA or EXIT
+	 */
+	if (frame == 0)
+		return 0;
+	frame--;
+	i = ret_insn[frame];
+	idx = ret_prog[frame];
+	goto continue_func;
+}
+
 /* Verify all global functions in a BPF program one by one based on their BTF.
  * All global functions must pass verification. Otherwise the whole program is rejected.
  * Consider:
@@ -18511,6 +18621,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 static int do_check_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_prog_aux *aux = env->prog->aux;
+	bool does_anyone_throw = false;
 	int i, ret;
 
 	if (!aux->func_info)
@@ -18535,8 +18646,13 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		 * opposite is fine though.
 		 */
 		aux->func_info_aux[i].throws_exception = env->subprog_info[i].can_throw;
+		if (!does_anyone_throw && env->subprog_info[i].can_throw)
+			does_anyone_throw = true;
 	}
-	return 0;
+
+	if (!does_anyone_throw)
+		return 0;
+	return fixup_global_subprog_throw_info(env);
 }
 
 static int do_check_main(struct bpf_verifier_env *env)
-- 
2.40.0

