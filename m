Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1456672EB5
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjASCPL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjASCPK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:15:10 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15C645BE4
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:07 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so3038968pjb.1
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bka/VtbZP54o8yxkzulZT0tqVF3UHzVaYFebUxjS0aM=;
        b=gFrXNp6btbveyZFu022ovIVtsHdGR+evsN6iUlWCPojSWakTfPrjld3xglrechEFk1
         UpTeusm9qnbTb08u/Qhyh1YJXgGSwaUFpHU5Gv0JhP6b/RP9Z27Po0AX/SSG4cnNcH1E
         lFJeEqlNSpKRbsFVcuVhxIh8+cPIDXku8VGJ5dmF+pbjn/uHoTj2YQ7/rvPsvk0m1IfH
         1nenQ3s2dqDvzEI5tsY0TD7r3s6ES5khNXOdfvEk8C/by+Znx1NlHqKPgtCnF8dlYFbg
         8uABgRD+67N+AXhWP60XcwlF8UwGmIZwMHYTfd/neechddAQMHZxkZkn2QSZt5nsJgqU
         PSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bka/VtbZP54o8yxkzulZT0tqVF3UHzVaYFebUxjS0aM=;
        b=nfIk1habqOTIwmU97R7Bnb1iZGyahOkmA3/I9Qyl0m83/yddQXfd18O+fYZGzCmcgy
         oPZiYNePtbHo6px9e3v9acBduVEk2j9rbMGMSRRVWPsmKjOTe88QQQkKiQ690PW/FcYm
         ubErfNIe4xhlzkjaecRqsW9hhx5mzZw7AK+GI65YJ7bfJdOQN+Qy8B5BXWwb5rD0qYu7
         lIRjZDaZGbjGFBetQqAg6Y/iMp3UB9NaWecQUWm4X2ey0wdD1Z+C5s8NjNcSfkrt/PNy
         Pwe8Kmfzu9foIIiBmke000wfZ+sBBo63mBz58bZPaGyZ77ENPotKp4mXvKx3vtnUcNU6
         FPVA==
X-Gm-Message-State: AFqh2kporl7EIvh/UgZsrH0ClqVccnDTmSol2Bs/2wKDTsQ5BwampsUL
        BVCROx3EjdUkfor6Y4pFNPUeKHpCdps=
X-Google-Smtp-Source: AMrXdXtciVXSdu4u/MN2TvcC127mekQUzbSRS2G5ECMuwr9KOh3+ta4KGlpbf13QDzg8JK/YsemKUQ==
X-Received: by 2002:a17:90a:8c02:b0:228:d460:9f13 with SMTP id a2-20020a17090a8c0200b00228d4609f13mr8955400pjo.29.1674094506839;
        Wed, 18 Jan 2023 18:15:06 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a474100b002262dd8a39bsm1922687pjg.49.2023.01.18.18.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:15:06 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 06/11] bpf: Avoid recomputing spi in process_dynptr_func
Date:   Thu, 19 Jan 2023 07:44:37 +0530
Message-Id: <20230119021442.1465269-7-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119021442.1465269-1-memxor@gmail.com>
References: <20230119021442.1465269-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3658; i=memxor@gmail.com; h=from:subject; bh=b2/Djii2vJEiM6TboetEFiyTUch5FJ7vRID6r/EpgDc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyKc/8UWIRMQe37XOKFCP6+V8s4pKXSh4aTY/dyiw /a5oLTqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8inPwAKCRBM4MiGSL8RyprvEA C1sCJpjllkkmhETNxaAOYFGV7MikHHthiv0/gT197G6GnBdWFPUbqRUoViEYNK+jn6c/PPsRoh+nXH fD0T9Qj7ZbEOXvGY+d2xhKtPqNiOU6OBJk2Lds8xffM9OlptlLJMSpj11pq9C23mhYAOQHfD4vsNoy Zx/CnIHd3saihm2r9TVnklqitxhyvwGZXB2kqD963dq597FhmkmPUEfUlZrMBDdrhaXnZ5Om/JJaPx 8og04VWaS+iNi0sY2Xkch/YpQy2ypAPDT2m1L5rrm3H1UBxebkh9oryMjOjvbPv+6S5XkbzUnP3zGB vuryqcyQL+FE4QF7MzUaAcVxgAieuCL3xgmC5Ocm399Xvm+0IQhy0uHBrLRNmErhEogGeKuBKtNAIM EPjeFUs7KRLGPQsXDc/Z8a+2BWVRjIWQv4dSFahwHOt+Bv3gv5P4lWYQKl9Z2/6NUocl1wAo8O0pUG CFtMUcLKWaUyy3atNO/rAC0CRqGYRb6Iq+Ohkub02u+/3lJuTQFLljoynmzoftRWPrZU6RJBdK7DVJ 9QlDRn8CX9GmGaaCn6lfb0ejMxdP/GuC0PVIN3eHZVujAy8xjsfnGF60ciqN2xXn+b5CXRi8vjSz+k cNJn2CxP4N3CMJpDnQA85QXr+gDqLcV5fvzOnEcLHYu70zErw/MI5ZuxExsg==
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

Currently, process_dynptr_func first calls dynptr_get_spi and then
is_dynptr_reg_valid_init and is_dynptr_reg_valid_uninit have to call it
again to obtain the spi value. Instead of doing this twice, reuse the
already obtained value (which is by default 0, and is only set for
PTR_TO_STACK, and only used in that case in aforementioned functions).
The input value for these two functions will either be -ERANGE or >= 1,
and can either be permitted or rejected based on the respective check.

Suggested-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 18b54b219fac..7b8de84568a3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -941,14 +941,12 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				       int spi)
 {
-	int spi;
-
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return false;
 
-	spi = dynptr_get_spi(env, reg);
 	/* For -ERANGE (i.e. spi not falling into allocated stack slots), we
 	 * will do check_mem_access to check and update stack bounds later, so
 	 * return true for that case.
@@ -966,16 +964,16 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	return true;
 }
 
-static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				     int spi)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, i;
+	int i;
 
 	/* This already represents first slot of initialized bpf_dynptr */
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return true;
 
-	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
 		return false;
 	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
@@ -6132,7 +6130,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
-	int err;
+	int err, spi = 0;
 
 	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
 	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
@@ -6146,9 +6144,9 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 * and its alignment for PTR_TO_STACK.
 	 */
 	if (reg->type == PTR_TO_STACK) {
-		err = dynptr_get_spi(env, reg);
-		if (err < 0 && err != -ERANGE)
-			return err;
+		spi = dynptr_get_spi(env, reg);
+		if (spi < 0 && spi != -ERANGE)
+			return spi;
 	}
 
 	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
@@ -6167,7 +6165,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 *		 to.
 	 */
 	if (arg_type & MEM_UNINIT) {
-		if (!is_dynptr_reg_valid_uninit(env, reg)) {
+		if (!is_dynptr_reg_valid_uninit(env, reg, spi)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
 			return -EINVAL;
 		}
@@ -6188,7 +6186,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			return -EINVAL;
 		}
 
-		if (!is_dynptr_reg_valid_init(env, reg)) {
+		if (!is_dynptr_reg_valid_init(env, reg, spi)) {
 			verbose(env,
 				"Expected an initialized dynptr as arg #%d\n",
 				regno);
-- 
2.39.1

