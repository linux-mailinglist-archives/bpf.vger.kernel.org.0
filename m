Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B135C676256
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjAUAZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjAUAYy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:24:54 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915979373B
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:16 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w2so5148574pfc.11
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6atmUnu6yUDSAXWR/NCWLDY2ibxR/H8Klr3dPFutJk=;
        b=mppG7qRHwXcbgEO9HZYzPz3TqiEeu/eyo+nHrzzExuiNX77a4s6QkcjaXOFxXlYHUB
         tI7MMJRVNc1Ymg33kdbjPdRboAAfuIzIWjmg1arbBRRQ706iSdcbO6SNoCTyngWgYxd2
         J9OzZj2lvbPOnENMBJkdmHfsN7MAhXtLrglyN5SRRnpyDSU3+YkKgXQ6VLS/s5PlaGRx
         +t31qVpyLBbmzfnDPVn7a6o7Xq6L1CjPHEkVeCpvzjLO8G6B44H7lnUh3c4LZtD6JzNk
         Bs3fSl2pNpTm/5tT5caZAe3HgeKubJCc703CiTQAHYm+D45e0Qzq7n43X7d/Xe/vtUFf
         LcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6atmUnu6yUDSAXWR/NCWLDY2ibxR/H8Klr3dPFutJk=;
        b=e1kbe7dcJto7J5NHwa0FVyQ9rCG2rapIIwcen+No1R36pvl9Tjx0PqcC0CVm2Y+Yig
         o3WWkVBV3LwsikPQ4Q/BxauSCDU6qPdZyE57FsAYDg5HTmPes6peQlqXL2XYt+KUVXwq
         mBah4LmKEaP+IJrDupbC4pgeWkn8VobQOhPfLPuDb9NaRwPXlpvYmoq0YjEaV0nNnG1C
         VDqR5N2smzH1C4XwhC+0gdTArCeY2MnvoJ3exPDfvbHjugkwpLo1d8aYAVeSZrc8Wllz
         PfDjqrID33w2/nwyvqeFKSzpiYHoIMNAvaFAeRYBcLoQc9BWrG6NQ5M+QKWBQwOi7U4s
         khtg==
X-Gm-Message-State: AFqh2koIxSaPEsgwLmFGsWt4mmmeVP2aIY+DNUYHmwYxJEbRezjHTV2h
        mVJGCi8hAfYkBbSH2a40q+Ki29TmzDg=
X-Google-Smtp-Source: AMrXdXtjywqiPAAgKck58Utr7SACMU/tB29Su4eDlqPKuIz2yE2RHiWaehsG8XVHTMFX8zkCO0gCRA==
X-Received: by 2002:aa7:9467:0:b0:58b:aaaa:82a9 with SMTP id t7-20020aa79467000000b0058baaaa82a9mr16714152pfq.25.1674260586482;
        Fri, 20 Jan 2023 16:23:06 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id 63-20020a621942000000b0056d98e359a5sm26522078pfz.165.2023.01.20.16.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:23:06 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 06/12] bpf: Combine dynptr_get_spi and is_spi_bounds_valid
Date:   Sat, 21 Jan 2023 05:52:35 +0530
Message-Id: <20230121002241.2113993-7-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121002241.2113993-1-memxor@gmail.com>
References: <20230121002241.2113993-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6180; i=memxor@gmail.com; h=from:subject; bh=Io8R4nMkdTkL0qipRPdCVbaGYoI8/FQxzBNP3ACEZXc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyzAkM4sVtlsxGoBslFWC6lc7p/kxompbmt4+GNFv n46VPXCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8swJAAKCRBM4MiGSL8RykgDD/ wNGibpAHbQQqTl3PU87VMDnPDf2AyPgF+8cFYvp4KjB2NAizyGFpTGoGWNeFdthv6Az+F4k4Z+Yi0u t9bFdPDwtq6c+d9O/SLM4Y/DyhKYDu06YTAu0TkvZ5MWn//Fz0SEX8C0dKq/NRz1fJRhGA/vlSKCRo ViLOvqjZ53BQEVVX1BY4bpRRQYbC/KhisbYbf4Qb4dK5+SjhEXsknV9PF93yTuJ7tvnP7TD4G9grfI 9Y9VK6pvqdR6d0N0Mn9tdr0G3mITRKv+qXweFzP+kQfh1N+0AlNbMKzDk14IlWVKo3K9IWylcEJ1g7 fxGgvj42h7XDsHJVY8T7pYu1kMlPG4dDx5Ra2YD8yoWEwKFyk9+d/5p5nsVwziRD9b6ANT6OjJfUCV rUDMLTeHAuL7+fhHErDUZ4ZZ/y9j8MxT76S7YKZeH2o2+sfgif68hJfrRRr/nvC8mFYs5mvQVCGkK3 wj9ev4ksz6TZmYJW4Cj7SfXgpzGW+vmqOPU3dA5B7CadCK/RTxFyr2FkJiDOaqTBA15+CmIS/Aj8Px mV7gFtK5U4+gsIvruUbVhcu3lgP3c8cKJi1tNcXuw/RHGhP7x98nWjrJ2FdQZ7TNBkb1bETSKBIeBJ YPbjBNwKUaYIi1jt7Xo/2PiFTvg4I/f1ig2M1o38eg6pdCCdgqHVt+C3vtBQ==
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

