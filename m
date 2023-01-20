Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E477A674A53
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjATDnj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjATDni (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:43:38 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C49B1ECB
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:37 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so467066pjq.1
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6atmUnu6yUDSAXWR/NCWLDY2ibxR/H8Klr3dPFutJk=;
        b=JY6L7tawJZ8OMcye/IcKmpTSG5/bQDnH4/oklrNqb6W/YzQlLQvXAaSBM6A+aRNpzD
         vWEGFqFucw5zAMVrcs7srfOnyzrnkqKiDr3ojWYpi2/c6rBIND4mL0ml62Q7SIqVZAwg
         OMV4AltsZjXW9LHVLXvQ3rfeHhJSAlNsgKhvkPYtiluwQHioEoR/eeQ7S/DTk4WeVnRu
         RFc6JWwad2XH+9HjuweGYnrCct60FNgLEx3Xy/DSua9i435Bv4yYSYfmLJbUkm+EiMMy
         98sluY1AFs89ocm+2bM4Z5AF3M2gnBojRcgwhKEhtjzkBXjYjVbRx5lGvTgJm2dH0UcW
         RnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6atmUnu6yUDSAXWR/NCWLDY2ibxR/H8Klr3dPFutJk=;
        b=mm7vkmZP2YEN/tdq9M8yFTGCe9c7rK4lCWV1GbgYTFGGLQ+wZOSY4lAJ2pLqFb+O4r
         NBR16p0nCdALIFmGstYRMHHPdiauhLNKK3C9RZj4o1XMt0rh7yYPFxm4zc9GXVkzSJZ2
         EjyDrpfPFdDwmILSB1E4Pwz5/y+0UA5PixU8BnqYvY4vF3XNwSKUXLvq8AtE7bBYEzWi
         N7QozUvLlhe0SAHBKzFP7lml2sc0LnK7vb0Ia5Kk0FKsHA0zqSgn6PZjt/M/oY43H/U4
         omlnSsAm4XycoAlvD7ph//7YVj8etA7XfGW4rL0OLoMu1wKC6+dpF0Eh5eE2c8WIPuM3
         PPrg==
X-Gm-Message-State: AFqh2krGhj8oH/+T/BDsK6otiDXyCIzGlfuGnyD92rPEVjvSL2J0P/C3
        KXgF5HGX37S68KyrRNb7FOMbg2B65dQ=
X-Google-Smtp-Source: AMrXdXskqZc1Hc6Jr3b0pmYJGLkogK4nE7pfNM8yhbYAFLwtNtuRwkTSNnNvH76ETq28PvCPspRFTw==
X-Received: by 2002:a05:6a20:3558:b0:b8:8d2a:d37d with SMTP id f24-20020a056a20355800b000b88d2ad37dmr13333453pze.10.1674186216641;
        Thu, 19 Jan 2023 19:43:36 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id d12-20020aa797ac000000b0058da3f2eba8sm8716235pfq.40.2023.01.19.19.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:43:36 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 06/12] bpf: Combine dynptr_get_spi and is_spi_bounds_valid
Date:   Fri, 20 Jan 2023 09:13:08 +0530
Message-Id: <20230120034314.1921848-7-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120034314.1921848-1-memxor@gmail.com>
References: <20230120034314.1921848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6180; i=memxor@gmail.com; h=from:subject; bh=Io8R4nMkdTkL0qipRPdCVbaGYoI8/FQxzBNP3ACEZXc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyg28M4sVtlsxGoBslFWC6lc7p/kxompbmt4+GNFv n46VPXCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8oNvAAKCRBM4MiGSL8RykH/D/ 4tgG1TmwJvmGv4tAdrlrR2mQIRaUIrxeP1I6tMTM0JuC8jrOJTYUT7iUK4LCXDDEgf+FdOCzeNhCE6 P3s4OiEHpdbnFhEWVZfQ8zadm71upEkXzebTDPKRHd9rqQcOIJfNljNtds6j0FUNMfBNobgJDPJ1bO 7SjrGSmXFbG+jI8dmskcm0pi9NEfhIydm5KUpY+TiZMClyKCMINLc8gmYAq1FFLKqx24rZ9+F0tO8T /tUj7qPkbltViUXLTTqhz7cKu63Z+NsRH0xG8GACVMcHde8q2DpBp0EpduEJmnFoyxXk0DLD5nLoVT 6KKGgJmt5pS62d//A3CaVRXgYp5Ixw0QtPWr8fSz1RcpAyE3Vb5+BBexoidYTpXQK0DyA2TixUZ/6W NwKvLi1mjWkcyu9M+EmzUiDiX5hPGRhTHI1HxVK3XJq59aq6HUTW9JVh0LvVBF3Q9kObPALjqF4lQd YLMzZnWxlxfwcrhktkiNR94BT2mpO7uuq6xzF5phTdnRrZqm0OM1u4GHdDUgEUicMMlgJrHWVLqO1X kLxK+cce99N03X6Cjzpol5CpYyjx6KTeTvsotx6fj6Tw8ASSfumOOE7Ds2P6GcEo+VMAu0cBtpjIVC DbRYQ0H5J1KXyGsrBoEZ9CJ/ROe3h1PpHT2iFzrwogXOURr7lii5Jm4G3YQQ==
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

