Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 933C25FE24
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2019 23:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfGDV1L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Jul 2019 17:27:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53644 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfGDV1K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jul 2019 17:27:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so6880569wmj.3
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2019 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AEpLeUcqpXcmqEfGdxSPrd+Gg6FGmwajQfvh3haODCk=;
        b=XD7yk87yfC8JqRxuOmleCt7Wh/t5KbVQ2put/snTNJoWSCXfBP3wAiP5gcztHGZVoK
         rtYOrBezSWkS8tc64qIidUwFxW+1akizueuMhZxttnA6Rfq0ycUXC9lvUgNzIpP4GbCa
         NiQjDUGysmMWnjTyVCf9pEAHhB5Jh9NXiDqp7ZgkSCpGczHn4il4HM+XgLn0b51IBrNC
         MowTqxcNRlqfOjLAR1dpr/DoP7IW9dXEXx2nldj4jdojl3J9yNi83/1EyurA8XrotZ1D
         9VkcTPqV5ozTEU2uegfo0FaNARMWYsdi6xU0guLCoSrCQkHlfj3q4tOONswYsu/uxaV3
         p1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AEpLeUcqpXcmqEfGdxSPrd+Gg6FGmwajQfvh3haODCk=;
        b=fxy4Qq73EOwMsplngO5PO33mbRJ0MnyMoCSjJzTVO9bPBlLtDI43JWjrYDkd1lHwbU
         U88TczChnBhvRosOchMcH3BrkflsSc4BgQVYqpPg7g3tdgCSwH05h3C+NiAoMrptOWlz
         Y0QvWNbXL7ZCwufoGf8QRA4q3kX57Q90oay6bFpbehf6lYZDek8yUcjUI4LZhelYIUH4
         qQufTaFTjaKDuKmbWT1eTM1dB1cij2DhmAmpA4OB67ae/qYPznjuTJ54QbXNvGyJMmm7
         3gACgUtzsp/fOnpl2PzwO5jiQphG6R8mcxRYPbl/p29DfN/mzketmMtzhTwUufZKG49n
         VY/g==
X-Gm-Message-State: APjAAAWXljzeHxqMkPT8EHaks6HnROrHgE1OwYQEBXH8kCuXT3pFEmwf
        miKrPUt/Tg3FPdtkAF/Z/KzoWw==
X-Google-Smtp-Source: APXvYqz4bmp3a8Ge8slGSUbk+fYwTcOvlfWuF73F+IUlOG5U8DuqqgQk42OMQX7w2rmI+VI3rGS1CQ==
X-Received: by 2002:a1c:cfc3:: with SMTP id f186mr75965wmg.134.1562275628774;
        Thu, 04 Jul 2019 14:27:08 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id t17sm9716654wrs.45.2019.07.04.14.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 14:27:08 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     ecree@solarflare.com, naveen.n.rao@linux.vnet.ibm.com,
        andriin@fb.com, jakub.kicinski@netronome.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [RFC bpf-next 5/8] bpf: migrate fixup_bpf_calls to list patching infra
Date:   Thu,  4 Jul 2019 22:26:48 +0100
Message-Id: <1562275611-31790-6-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562275611-31790-1-git-send-email-jiong.wang@netronome.com>
References: <1562275611-31790-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch migrate fixup_bpf_calls to new list patching
infrastructure.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 94 +++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2d16e85..30ed28e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9033,16 +9033,19 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
 	struct bpf_insn *insn = prog->insnsi;
+	struct bpf_list_insn *list, *elem;
 	const struct bpf_func_proto *fn;
-	const int insn_cnt = prog->len;
 	const struct bpf_map_ops *ops;
 	struct bpf_insn_aux_data *aux;
 	struct bpf_insn insn_buf[16];
-	struct bpf_prog *new_prog;
 	struct bpf_map *map_ptr;
-	int i, cnt, delta = 0;
+	int cnt, ret = 0;
 
-	for (i = 0; i < insn_cnt; i++, insn++) {
+	list = bpf_create_list_insn(env->prog);
+	if (IS_ERR(list))
+		return PTR_ERR(list);
+	for (elem = list; elem; elem = elem->next) {
+		insn = &elem->insn;
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
 		    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
@@ -9073,13 +9076,11 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 				cnt = ARRAY_SIZE(mask_and_mod) - (is64 ? 1 : 0);
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			elem = bpf_patch_list_insn(elem, patchlet, cnt);
+			if (IS_ERR(elem)) {
+				ret = PTR_ERR(elem);
+				goto free_list_ret;
+			}
 			continue;
 		}
 
@@ -9089,16 +9090,15 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			cnt = env->ops->gen_ld_abs(insn, insn_buf);
 			if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf)) {
 				verbose(env, "bpf verifier is misconfigured\n");
-				return -EINVAL;
+				ret = -EINVAL;
+				goto free_list_ret;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
+			elem = bpf_patch_list_insn(elem, insn_buf, cnt);
+			if (IS_ERR(elem)) {
+				ret = PTR_ERR(elem);
+				goto free_list_ret;
+			}
 			continue;
 		}
 
@@ -9111,7 +9111,7 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			bool issrc, isneg;
 			u32 off_reg;
 
-			aux = &env->insn_aux_data[i + delta];
+			aux = &env->insn_aux_data[elem->orig_idx - 1];
 			if (!aux->alu_state ||
 			    aux->alu_state == BPF_ALU_NON_POINTER)
 				continue;
@@ -9144,13 +9144,12 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 				*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 			cnt = patch - insn_buf;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
+			elem = bpf_patch_list_insn(elem, insn_buf, cnt);
+			if (IS_ERR(elem)) {
+				ret = PTR_ERR(elem);
+				goto free_list_ret;
+			}
 
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
 			continue;
 		}
 
@@ -9183,7 +9182,7 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			insn->imm = 0;
 			insn->code = BPF_JMP | BPF_TAIL_CALL;
 
-			aux = &env->insn_aux_data[i + delta];
+			aux = &env->insn_aux_data[elem->orig_idx - 1];
 			if (!bpf_map_ptr_unpriv(aux))
 				continue;
 
@@ -9195,7 +9194,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			 */
 			if (bpf_map_ptr_poisoned(aux)) {
 				verbose(env, "tail_call abusing map_ptr\n");
-				return -EINVAL;
+				ret = -EINVAL;
+				goto free_list_ret;
 			}
 
 			map_ptr = BPF_MAP_PTR(aux->map_state);
@@ -9207,13 +9207,12 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 								 map)->index_mask);
 			insn_buf[2] = *insn;
 			cnt = 3;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
+			elem = bpf_patch_list_insn(elem, insn_buf, cnt);
+			if (IS_ERR(elem)) {
+				ret = PTR_ERR(elem);
+				goto free_list_ret;
+			}
 
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
 			continue;
 		}
 
@@ -9228,7 +9227,7 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 		     insn->imm == BPF_FUNC_map_push_elem   ||
 		     insn->imm == BPF_FUNC_map_pop_elem    ||
 		     insn->imm == BPF_FUNC_map_peek_elem)) {
-			aux = &env->insn_aux_data[i + delta];
+			aux = &env->insn_aux_data[elem->orig_idx - 1];
 			if (bpf_map_ptr_poisoned(aux))
 				goto patch_call_imm;
 
@@ -9239,17 +9238,16 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 				cnt = ops->map_gen_lookup(map_ptr, insn_buf);
 				if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf)) {
 					verbose(env, "bpf verifier is misconfigured\n");
-					return -EINVAL;
+					ret = -EINVAL;
+					goto free_list_ret;
 				}
 
-				new_prog = bpf_patch_insn_data(env, i + delta,
-							       insn_buf, cnt);
-				if (!new_prog)
-					return -ENOMEM;
+				elem = bpf_patch_list_insn(elem, insn_buf, cnt);
+				if (IS_ERR(elem)) {
+					ret = PTR_ERR(elem);
+					goto free_list_ret;
+				}
 
-				delta    += cnt - 1;
-				env->prog = prog = new_prog;
-				insn      = new_prog->insnsi + i + delta;
 				continue;
 			}
 
@@ -9307,12 +9305,18 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			verbose(env,
 				"kernel subsystem misconfigured func %s#%d\n",
 				func_id_name(insn->imm), insn->imm);
-			return -EFAULT;
+			ret = -EFAULT;
+			goto free_list_ret;
 		}
 		insn->imm = fn->func - __bpf_call_base;
 	}
 
-	return 0;
+	env = verifier_linearize_list_insn(env, list);
+	if (IS_ERR(env))
+		ret = PTR_ERR(env);
+free_list_ret:
+	bpf_destroy_list_insn(list);
+	return ret;
 }
 
 static void free_states(struct bpf_verifier_env *env)
-- 
2.7.4

