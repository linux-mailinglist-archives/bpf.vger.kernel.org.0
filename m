Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF6F672EB4
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjASCPG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjASCPF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:15:05 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F026794B
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:03 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d9so948884pll.9
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhSzY4zEwsqSV94SAMxDpdZWRwNBnCTmanJZGUNqQVo=;
        b=oAwVuP8sM01cciNQDmNQMD942BkcTYLnMS3CdeB/O6HgoyOSCNyTopIH14HVXBToZJ
         KLAWwEf3jgkbzIcqyfskxiLH/QkmyHHSM96PEU4frGlwJS0QSK4OWwrcjzvqoZFcc141
         mbNPztPWI+Jjg7nenz5wapFKsKcEAx5j94FgnRPr5n+GH9UfZ7W2OF4E5oFRIrv2lR5f
         h074R4/CY3lUewV+ap3xWZdNKEVsueFbTeaZVm8E0nApWdyTw0OSCDqZOE0Tp0fkeh5C
         L+4amUGa08SULGKgVeSnVYyUociGJpQMtBNdMF9pTNWWGwRrWH4I4ZD/mHkEbJJ6JjrX
         wPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhSzY4zEwsqSV94SAMxDpdZWRwNBnCTmanJZGUNqQVo=;
        b=NxcywzSDiu2B/1DZ3QB9JLihG8WfUZX/8XK4eFK2AOyud9o/xUBGcmwTSIlT3qFCAE
         sHuJSI4COP0ndu6Im7FlR3LKj7/RVHqOlcYoHBuv5X4yily09MXMe8hlRKy5k4VRD046
         5P70OBWsyn/DlJorG/dDadzVlCqBZvfadyT1NLi7SKy/cPThY1hszeRGe4O9zjqexHLn
         7d4/se8MBQf0RwPQb6gYSCRICBZLHVU1I8ZlKWbuM2LqToeqSQly+9c2rxZL4bAWd56i
         2kTP/f1iDCtLWzOr+nW0e6/xy6obusWQCrCbkzX8fUoiZh/YR7sOj516UGcAj1plSz8s
         CtDA==
X-Gm-Message-State: AFqh2koOwr05cUMAE5POJUylEy0hS6pmq1l1fS78xk3IP12fjtLyUjmu
        5/nDLym5inpd7XPAiHXSdD6DKzBrA9k=
X-Google-Smtp-Source: AMrXdXtd3SY5zWUCSJYmEtekAumvHdt3znutCxQFyvEL8PcloE/8JS0oCH3rcJTyCJaNWMJqqkBMqg==
X-Received: by 2002:a17:90b:2349:b0:226:7fcb:c215 with SMTP id ms9-20020a17090b234900b002267fcbc215mr9833946pjb.17.1674094502902;
        Wed, 18 Jan 2023 18:15:02 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id q35-20020a17090a752600b002265ddfc13esm1946944pjk.29.2023.01.18.18.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:15:02 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 05/11] bpf: Combine dynptr_get_spi and is_spi_bounds_valid
Date:   Thu, 19 Jan 2023 07:44:36 +0530
Message-Id: <20230119021442.1465269-6-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119021442.1465269-1-memxor@gmail.com>
References: <20230119021442.1465269-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6131; i=memxor@gmail.com; h=from:subject; bh=/IAcZvEjbJcxQ0MZfs6LyNWglKcKtdSuhtUfQm35tho=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyKc/ljXnvijVzt4AOizrjml63Zq5zYwqsvbeH/lF jrvvbMuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8inPwAKCRBM4MiGSL8RynH3D/ 9kuz4VGzfZQxlXTsiUtX3fcEnYMn/qkf/ZSgdf/c8Xg4BNKByaH7/RfVeFlGG9wB801wRLCtHK8lHs a+i0UEKf/gM7aiDvOkiIV4eWi2aqjECSXUzXgM8/FQDO09JAcjNOH0BxO9TwNSc4BlTnkMMdbHfpSD SRBvkzR9pSYB6kRikLUcN8UGcccBGVMyZTc1JfJ9nD1LUwXTvrYVFpknOJDQ6MRSQGLSKEYOfb9oA7 /S52YbQVdIrTsSiFo7EuYQM6NPxVlIVE1B7iOHtppE7VVe75miHlX4Z6Dc5ihQiCjeYhgi1EQTheFh 2V+QvJ8r9IvxDPp8XCfeJilxTocdahC5F/UKwmVD/9d6Whi1anYQERyv05SLVMaSjk/dn1AGwwWMPA iEM5eqMhC/wal8Be0bJemKCis7zx4bshU5c5DexT60yDZKr/MwQmA/jWZavjVzQVKGw05zUU+On06N n28G261wmtY4/SdQghHPDGkYw74KFIsLVrTgDjDtBaroGs64CXNcI8fN3lA6X658zsOwLN7PcBx/zb xm7VA78t2in5WrQE6awfl4xJlCOweIwmVdQg5skXZqZrIolm7YG/Rqn3i6bQ54pb4Y0W4NrnicefmC 0EO3LyeFEogmc5l6KoNi7/t7mjkBSoWThxRp0irnZHIzWqGOgpNabbsuGhdQ==
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
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 75 +++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4feaddd5d6dc..18b54b219fac 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -643,6 +643,28 @@ static int __get_spi(s32 off)
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
@@ -663,29 +685,10 @@ static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *re
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
@@ -783,9 +786,6 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	if (spi < 0)
 		return spi;
 
-	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
-		return -EINVAL;
-
 	/* We cannot assume both spi and spi - 1 belong to the same dynptr,
 	 * hence we need to call destroy_if_dynptr_stack_slot twice for both,
 	 * to ensure that for the following example:
@@ -839,9 +839,6 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	if (spi < 0)
 		return spi;
 
-	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
-		return -EINVAL;
-
 	for (i = 0; i < BPF_REG_SIZE; i++) {
 		state->stack[spi].slot_type[i] = STACK_INVALID;
 		state->stack[spi - 1].slot_type[i] = STACK_INVALID;
@@ -946,20 +943,18 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 
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
@@ -983,8 +978,7 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_re
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
 		return false;
-	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
-	    !state->stack[spi].spilled_ptr.dynptr.first_slot)
+	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
 		return false;
 
 	for (i = 0; i < BPF_REG_SIZE; i++) {
@@ -6153,7 +6147,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 */
 	if (reg->type == PTR_TO_STACK) {
 		err = dynptr_get_spi(env, reg);
-		if (err < 0)
+		if (err < 0 && err != -ERANGE)
 			return err;
 	}
 
@@ -6646,10 +6640,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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

