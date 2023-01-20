Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204E2674DAA
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 08:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjATHEX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 02:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjATHEW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 02:04:22 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C594530D7
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:21 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id g68so3419709pgc.11
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6atmUnu6yUDSAXWR/NCWLDY2ibxR/H8Klr3dPFutJk=;
        b=n+rdGyRfKbjwmU2UsGYd7odVlcBa0/xk7brZ/+PoxV/yYDjf9ipieEPFxiScsBwW8u
         HBPAKhpYIYfvAKT8x07Zjizi2Xly5AHmFH8Vc2Vob1geVZ7UXfxxofUHjnUl7NT9TE3h
         IdZ64gIyGBKQzJmSfDkA/KWloPrjIql4a14/zm7YB5npjUrKobrsn6u9hUqVTFIMr6BP
         e8NVe1PqN9X/Ffo7E49HwZX34NYd5zb9X+7R7yJoKudbSc3cBLLK65pePDM++TgkIC0a
         DYLJsEaO866vtdO8DRPhymRRsk2AM31H5IfdrQ1b1VSc23mD8cQLNLIOfuVuQ2K9q3Nd
         ebew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6atmUnu6yUDSAXWR/NCWLDY2ibxR/H8Klr3dPFutJk=;
        b=lerAevmQRox8tu3/WoOL3xQKlJU2eYutjNCBhsOUm6V1UqmPZfTSLdPn9Ed0YW9JEH
         jHd7ADDzwq2ZCmp8hvhc8vwL84tlpako9mIwD6eF9is3XYcgm5zTMHfSNJRjXg1ZjMxp
         LrO4+PsWOU9U3yia1gR1kSkGiqXm1e2RUL5j9PSmbEkJXC3nJYu3fNw7j9q88PqiFK/C
         dTPjEd9UWWB7cfrwc3yEKOuJFxMbwpmYX2F+pRTiA++WxnFlg8F3+WGWAvRYogcbEHE0
         Jl/b9Q1DsOSGOFQkNTLRiRHUO6o3NpL6JXkgWbh5bcXZ+Qd2XOCbeYusg/iTiMq0QnFf
         Tcvg==
X-Gm-Message-State: AFqh2kojjx/bu4L0SpDfPsJj+BF2NsbG0bV7X/GVOwkSruqWgS9tRPig
        lQ/Lbekx8M5FVRzAfqSzIugP995TDaU=
X-Google-Smtp-Source: AMrXdXsl9VuIzTi1YDP9AOr3n22ZsWJIJjzwbfZ/VtjeaksWjFq/zU0R/aeLalaMsPVqstCi4BjEKQ==
X-Received: by 2002:a05:6a00:4519:b0:58d:f047:53b7 with SMTP id cw25-20020a056a00451900b0058df04753b7mr7736844pfb.3.1674198260616;
        Thu, 19 Jan 2023 23:04:20 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id t25-20020a62d159000000b0056bd1bf4243sm10329149pfl.53.2023.01.19.23.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:04:20 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 06/12] bpf: Combine dynptr_get_spi and is_spi_bounds_valid
Date:   Fri, 20 Jan 2023 12:33:49 +0530
Message-Id: <20230120070355.1983560-7-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120070355.1983560-1-memxor@gmail.com>
References: <20230120070355.1983560-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6180; i=memxor@gmail.com; h=from:subject; bh=Io8R4nMkdTkL0qipRPdCVbaGYoI8/FQxzBNP3ACEZXc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyjzLM4sVtlsxGoBslFWC6lc7p/kxompbmt4+GNFv n46VPXCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8o8ywAKCRBM4MiGSL8RynftEA C5s735WzUfN6oPcAztDYN9ZVxGYUXnwLToTI5XT4WfeVQvZ++gTPTJnjE3Mtf/jk9oOuIKqoZ8qkeE fBHGlyQLXol/XAvk63rh2fkXnH6CgNZpHyWS6avcPehYrWpKV1Kxgi+hiWJ13c5W5BZps58cX/ALPK BNwaJt2IejOFqlBb0KRQ1NH/ekCW75rbx1SWMBtDMPduSvKvC/yJNMVhqBjH4Za+q4/115i/LsfxC2 VZ08yZW0uDnQdsnGhgZJ1DhtkQJPgZTkQ+md+KmovxOHGwKgt0KIkbBUnUKbxKfs5wvKFXU+WmvpOi VWDl+zHs51s23cxCDW0DZa71BBRPmqT+fG9CCsWN/ruO5sxuzf5HQKcTN3oNnhWBzxodWX96xNkwbA WPlsRcBHXHfYSt3WeCJz10oVUEdyO1y5/4jGTN/RwWD6P8qTqUpO/nMF0Ns+7CqkSPG4fX3EXRnwbw G+dd2FXVQKeU2U2l+sKnEQo/HsH7uqyHOwcFvQetYvDzeUgN0qgygtodKftBGPjit1U8puKRK6s5lN uEkrTJIOeQQb4bdU0bqFAh6tMxPltTOmwXESOd3uZ/WH5jMhiMscIbXQYE07dEPt8p4J+L11ORviV7 6aYwZwL7NGaW5nn1TJOUVr6BS9+aSjlvweZA+XDPRQDocQOnyIkK39c3iyTQ==
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

Currently, a check on spi resides in dynptr_get_spi, while others
checking its validity for being within the allocated stack slots happens
in is_spi_bounds_valid. Almost always barring a couple of cases (where
being beyond allocated stack slots is not an error as stack slots need
to be populated), both are used together to make checks. Hence, subsume
the is_spi_bounds_valid check in dynptr_get_spi, and return -ERANGE to
specially distinguish the case where spi is valid but not within
allocated slots in the stack state.

The is_spi_bounds_valid function is still kept around as it is a generic
helper that will be useful for other objects on stack similar to dynptr
in the future.

Suggested-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 75 +++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e5745b696bfe..29cbb3ef35e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -644,6 +644,28 @@ static int __get_spi(s32 off)
 	return (-off - 1) / BPF_REG_SIZE;
 }
 
+static struct bpf_func_state *func(struct bpf_verifier_env *env,
+				   const struct bpf_reg_state *reg)
+{
+	struct bpf_verifier_state *cur = env->cur_state;
+
+	return cur->frame[reg->frameno];
+}
+
+static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
+{
+       int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
+
+       /* We need to check that slots between [spi - nr_slots + 1, spi] are
+	* within [0, allocated_stack).
+	*
+	* Please note that the spi grows downwards. For example, a dynptr
+	* takes the size of two stack slots; the first slot will be at
+	* spi and the second slot will be at spi - 1.
+	*/
+       return spi - nr_slots + 1 >= 0 && spi < allocated_slots;
+}
+
 static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	int off, spi;
@@ -664,29 +686,10 @@ static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
 		return -EINVAL;
 	}
-	return spi;
-}
-
-static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
-{
-	int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
 
-	/* We need to check that slots between [spi - nr_slots + 1, spi] are
-	 * within [0, allocated_stack).
-	 *
-	 * Please note that the spi grows downwards. For example, a dynptr
-	 * takes the size of two stack slots; the first slot will be at
-	 * spi and the second slot will be at spi - 1.
-	 */
-	return spi - nr_slots + 1 >= 0 && spi < allocated_slots;
-}
-
-static struct bpf_func_state *func(struct bpf_verifier_env *env,
-				   const struct bpf_reg_state *reg)
-{
-	struct bpf_verifier_state *cur = env->cur_state;
-
-	return cur->frame[reg->frameno];
+	if (!is_spi_bounds_valid(func(env, reg), spi, BPF_DYNPTR_NR_SLOTS))
+		return -ERANGE;
+	return spi;
 }
 
 static const char *kernel_type_name(const struct btf* btf, u32 id)
@@ -788,9 +791,6 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	if (spi < 0)
 		return spi;
 
-	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
-		return -EINVAL;
-
 	/* We cannot assume both spi and spi - 1 belong to the same dynptr,
 	 * hence we need to call destroy_if_dynptr_stack_slot twice for both,
 	 * to ensure that for the following example:
@@ -844,9 +844,6 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	if (spi < 0)
 		return spi;
 
-	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
-		return -EINVAL;
-
 	for (i = 0; i < BPF_REG_SIZE; i++) {
 		state->stack[spi].slot_type[i] = STACK_INVALID;
 		state->stack[spi - 1].slot_type[i] = STACK_INVALID;
@@ -951,20 +948,18 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 
 static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
-	struct bpf_func_state *state = func(env, reg);
 	int spi;
 
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return false;
 
 	spi = dynptr_get_spi(env, reg);
+	/* For -ERANGE (i.e. spi not falling into allocated stack slots), we
+	 * will do check_mem_access to check and update stack bounds later, so
+	 * return true for that case.
+	 */
 	if (spi < 0)
-		return false;
-
-	/* We will do check_mem_access to check and update stack bounds later */
-	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
-		return true;
-
+		return spi == -ERANGE;
 	/* We allow overwriting existing unreferenced STACK_DYNPTR slots, see
 	 * mark_stack_slots_dynptr which calls destroy_if_dynptr_stack_slot to
 	 * ensure dynptr objects at the slots we are touching are completely
@@ -988,8 +983,7 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_re
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
 		return false;
-	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
-	    !state->stack[spi].spilled_ptr.dynptr.first_slot)
+	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
 		return false;
 
 	for (i = 0; i < BPF_REG_SIZE; i++) {
@@ -6160,7 +6154,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	if (reg->type == PTR_TO_STACK) {
 		int err = dynptr_get_spi(env, reg);
 
-		if (err < 0)
+		if (err < 0 && err != -ERANGE)
 			return err;
 	}
 
@@ -6668,10 +6662,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 */
 			if (reg->type == PTR_TO_STACK) {
 				spi = dynptr_get_spi(env, reg);
-				if (spi < 0)
-					return spi;
-				if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
-				    !state->stack[spi].spilled_ptr.ref_obj_id) {
+				if (spi < 0 || !state->stack[spi].spilled_ptr.ref_obj_id) {
 					verbose(env, "arg %d is an unacquired reference\n", regno);
 					return -EINVAL;
 				}
-- 
2.39.1

