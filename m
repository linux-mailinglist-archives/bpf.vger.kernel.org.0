Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9DB6D5C5A
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjDDJwQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 05:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjDDJwQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 05:52:16 -0400
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289611FF6
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 02:52:08 -0700 (PDT)
X-QQ-mid: bizesmtp71t1680601923twvpnkb4
Received: from localhost.localdomain ( [110.191.179.216])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 04 Apr 2023 17:52:02 +0800 (CST)
X-QQ-SSF: 01400000002000H0W000B00A0000000
X-QQ-FEAT: CR3LFp2JE4kWq2tSbErzX1tlnfIyRbai3jSZCB/wT/04uRgoi+9FY+mZwDAwJ
        Yj+pEKiLJDQlZmbrq5INxE23rtXQf122BjUxppK/yR4IHmihS3kSRoAeWjGNzDLqEGqFhuI
        BOZ238jo/CboqiMyo4XG0e/MdHaQoo0YAnvID4pG5eQVE5H6r4XLmCXP/1Lol4rKNVzEKjz
        CyKhJZKalhk7zSUw2PjWmP4zqK9VbTnSWs20Fg9S1KjwTP2i70KIqu3rGTac3w1zrVXldmT
        tzoXHGuJmoNpCplDCD7MG36u1V8nrKfeeGbNv9FOInMxVHs4Lleov0JOn9P+iBLsuDXEQ22
        PUbB6A2mMpT8qhv09ynh3+5BGPLR+lp6nJh3JadHwDOEbg9SnEGTVu69ZNj+jfE8UEPjqap
        qnumi8WhCE4=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9185986044343273289
From:   zhongjun@uniontech.com
To:     bpf@vger.kernel.org
Cc:     zhongjun <zhongjun@uniontech.com>
Subject: [PATCH] BPF: make verifier 'misconfigured' errors more meaningful
Date:   Tue,  4 Apr 2023 17:52:02 +0800
Message-Id: <20230404095202.30408-1-zhongjun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: zhongjun <zhongjun@uniontech.com>

There are too many so-called 'misconfigured' errors potentially
feed back to user-space, that make it very hard to judge on
a glance the reason a verification failure occurred.
This patch make those similar error outputs more sensitive and readible.

base-commit: 738a96c4a8c36950803fdd27e7c30aca92dccefd
---
 kernel/bpf/verifier.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d517d13878cf..f19534f919c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12684,7 +12684,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			dst_reg->btf_id = aux->btf_var.btf_id;
 			break;
 		default:
-			verbose(env, "bpf verifier is misconfigured\n");
+			verbose(env, "bpf verifier is misconfigured: dst_reg->type = %d\n",
+					dst_reg->type);
 			return -EFAULT;
 		}
 		return 0;
@@ -12722,7 +12723,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
 		dst_reg->type = CONST_PTR_TO_MAP;
 	} else {
-		verbose(env, "bpf verifier is misconfigured\n");
+		verbose(env, "bpf verifier is misconfigured: insn->src_reg = %d\n",
+				(int)insn->src_reg);
 		return -EINVAL;
 	}
 
@@ -12769,7 +12771,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	}
 
 	if (!env->ops->gen_ld_abs) {
-		verbose(env, "bpf verifier is misconfigured\n");
+		verbose(env, "bpf verifier is misconfigured: gen_ld_abs is NULL\n");
 		return -EINVAL;
 	}
 
@@ -15814,13 +15816,14 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 	if (ops->gen_prologue || env->seen_direct_write) {
 		if (!ops->gen_prologue) {
-			verbose(env, "bpf verifier is misconfigured\n");
+			verbose(env, "bpf verifier is misconfigured: gen_prologue is NULL\n");
 			return -EINVAL;
 		}
 		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
 					env->prog);
 		if (cnt >= ARRAY_SIZE(insn_buf)) {
-			verbose(env, "bpf verifier is misconfigured\n");
+			verbose(env, "bpf verifier is misconfigured: cnt=%d exceeds limit@%lu\n",
+					cnt, ARRAY_SIZE(insn_buf));
 			return -EINVAL;
 		} else if (cnt) {
 			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
@@ -15951,7 +15954,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 					 &target_size);
 		if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf) ||
 		    (ctx_field_size && !target_size)) {
-			verbose(env, "bpf verifier is misconfigured\n");
+			verbose(env, "bpf verifier is misconfigured: ins[%d] cnt=%d ctx_s=%u tg_s=%u\n",
+					i, cnt, ctx_field_size, target_size);
 			return -EINVAL;
 		}
 
@@ -16400,7 +16404,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		     BPF_MODE(insn->code) == BPF_IND)) {
 			cnt = env->ops->gen_ld_abs(insn, insn_buf);
 			if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf)) {
-				verbose(env, "bpf verifier is misconfigured\n");
+				verbose(env, "bpf verifier is misconfigured: cnt=%d exceeds limit@%lu\n",
+						cnt, ARRAY_SIZE(insn_buf));
 				return -EINVAL;
 			}
 
@@ -16647,7 +16652,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				if (cnt == -EOPNOTSUPP)
 					goto patch_map_ops_generic;
 				if (cnt <= 0 || cnt >= ARRAY_SIZE(insn_buf)) {
-					verbose(env, "bpf verifier is misconfigured\n");
+					verbose(env, "bpf verifier is misconfigured: cnt=%d exceeds limit@%lu\n",
+							cnt, ARRAY_SIZE(insn_buf));
 					return -EINVAL;
 				}
 
@@ -16848,7 +16854,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (!map_ptr->ops->map_poke_track ||
 		    !map_ptr->ops->map_poke_untrack ||
 		    !map_ptr->ops->map_poke_run) {
-			verbose(env, "bpf verifier is misconfigured\n");
+			verbose(env, "bpf verifier is misconfigured: map_poke_xxx is NULL\n");
 			return -EINVAL;
 		}
 
-- 
2.20.1

