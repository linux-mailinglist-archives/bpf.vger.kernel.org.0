Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD781672EB3
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjASCPC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjASCPB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:15:01 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A43C46089
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:00 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id a184so400733pfa.9
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id88U8b5DhWAUq+b2vG3/F9nyL2akCy+zDRYHvXeozM=;
        b=fjcExwTk/tcA3tlIZr8co6n6zrWssVcppOLsUErLczCGSfvK2U15AsvmqXWCveiSHH
         JhebhmaSBeDmSJvj0UY6JczKS4kCf9qu0cgjemn8vCdoJikn79eTyf9/CRPJ2/rgnQDT
         fVjby8+egBa92GaEVb+fxfxv3Hm6sw99TcFBHQRGlRf/D0Im3Ii8SmLXDce1OABaguaZ
         IGXF+IMd1ygyh4TEcMPozvavJ4kGydIJWg6QFEf6qO9FtzgeId1P76YczVWQXcbDu0W6
         ndm+iIZScoHAHbY8UKa16ubnVNToI7+uxfUDrLz3CQkZKWQFNxB3guBPJLbaQXe4KNig
         mqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=id88U8b5DhWAUq+b2vG3/F9nyL2akCy+zDRYHvXeozM=;
        b=TpXcVaySJf/JhKd/HPDXMhGd98BIUtFaa3lgG7uVlvOiowmaNJdBoHD0Ff9lerYHDm
         iXU+UbwCpw75U5JpSSG85qFdjK8taCbXWYHSnplSgWFOCCHXhjz8S0nY+5Ffmm4ciSog
         gufW8L2q1jtjqpURLCy90CWG2QD6Hr3M7a+LrI9Hh3hQoqisoL6Nq1+d22Vxc6/whbCO
         C6J/Ar5fdLTZFqNIzX2p4bo35ClBd8eKs+QCRC17Caoqhliqm0Tj7yliX5dbLKp+Bwuu
         CQFwYV3b2tQIAuYxEBqV3Zkd/tHS6oj6KnA4oAGc7gtqQMOnVAAwv1CRbaRoxxz0ChAv
         sm5A==
X-Gm-Message-State: AFqh2kpuesCrsorucue2uZbFR98Q/Tidtj1hB0BhLvVyXp9GilTfz1I3
        WT0SOFndu9+2Q0dxBA1z6+fe7z96qQE=
X-Google-Smtp-Source: AMrXdXsZvL+HfJAWx3uqVVv4fs4w3E7RUqY95nPJ4UjLDXa3y1HOtSqNeW3erHaM+75IijM4KesdgQ==
X-Received: by 2002:aa7:854f:0:b0:58b:b9ce:cda1 with SMTP id y15-20020aa7854f000000b0058bb9cecda1mr9468684pfn.28.1674094499441;
        Wed, 18 Jan 2023 18:14:59 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id a20-20020aa79714000000b0058d9a5bac88sm7092575pfg.203.2023.01.18.18.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:14:59 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 04/11] bpf: Allow reinitializing unreferenced dynptr stack slots
Date:   Thu, 19 Jan 2023 07:44:35 +0530
Message-Id: <20230119021442.1465269-5-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119021442.1465269-1-memxor@gmail.com>
References: <20230119021442.1465269-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3839; i=memxor@gmail.com; h=from:subject; bh=D4qFbTmmFP8S+m3Q6q6jtE75Nl7+PC5zEX3xx4xQgdY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyKc/WawmUYZLBHTmNaHoctqyIEhThCX9axVuJS4L DoKrY4+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8inPwAKCRBM4MiGSL8RyiRyD/ 9rjDdhYHOGsL/E3/h4z4XZ1Rz5XUMPLgwza8ybBYrLMJoDyPyZWuHqCZPY0mwV1NzQ8b8IvQeEogPk Taq0kR1cb/5SsKzK5KvarxCwAR9tTxTeMPgXkCYLCLKonzDjXP0BqHRug92eS64n9410Ax7aP90Hij B29x0qZzl0HKKYAsYzqJp9DnEc7cs47Ho1zlos5d82cWotuX5jAU2FNoROjjnldtYLTUIoCncq/+qR EthydY64B2hnvWTWfsPiWKvJVllq3v1CG7QuIvtUNfQCyt/a+6lnVx9ghccY4OgVxLHuET49iGzYRQ 5q2slgN803V2haf1LkVm3UtB9H+yqrLE8ey2YnBMLCIDOqRex8lSzRT9YyTYHfbkb5eMYlaqOgCFtb GwoGYQqlQQC4fHSQyIGGLcZ1sO6cUz6vpyHO0ea68TfU7YiZaYkRzgHtHKq5xJ6bL4saTQ/cOExTXt QEMh0RT8xZcW1wpgcMkVzDGRKCUyDRGdOtRJzvZKYkXM+Vw8+DYUNKlb8LWxWz8YRBVBo1JDpNHvt8 lOuFA7KrZNB+swLxD6DTovOLS6G78NoiObriehanRrivP1rTdnMacutjwHFYuJLEa5jIKtxAvHcQV0 DPKh5L2LHTFkT9J2a3ONziqFoIQM8Nj5Ng8x86W3lwpshlsYAozU42PX1Jbw==
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

Consider a program like below:

void prog(void)
{
	{
		struct bpf_dynptr ptr;
		bpf_dynptr_from_mem(...);
	}
	...
	{
		struct bpf_dynptr ptr;
		bpf_dynptr_from_mem(...);
	}
}

Here, the C compiler based on lifetime rules in the C standard would be
well within in its rights to share stack storage for dynptr 'ptr' as
their lifetimes do not overlap in the two distinct scopes. Currently,
such an example would be rejected by the verifier, but this is too
strict. Instead, we should allow reinitializing over dynptr stack slots
and forget information about the old dynptr object.

The destroy_if_dynptr_stack_slot function already makes necessary checks
to avoid overwriting referenced dynptr slots. This is done to present a
better error message instead of forgetting dynptr information on stack
and preserving reference state, leading to an inevitable but
undecipherable error at the end about an unreleased reference which has
to be associated back to its allocating call instruction to make any
sense to the user.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09c09d9bfd89..4feaddd5d6dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -777,7 +777,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 {
 	struct bpf_func_state *state = func(env, reg);
 	enum bpf_dynptr_type type;
-	int spi, i, id;
+	int spi, i, id, err;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -786,6 +786,22 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return -EINVAL;
 
+	/* We cannot assume both spi and spi - 1 belong to the same dynptr,
+	 * hence we need to call destroy_if_dynptr_stack_slot twice for both,
+	 * to ensure that for the following example:
+	 *	[d1][d1][d2][d2]
+	 * spi    3   2   1   0
+	 * So marking spi = 2 should lead to destruction of both d1 and d2. In
+	 * case they do belong to same dynptr, second call won't see slot_type
+	 * as STACK_DYNPTR and will simply skip destruction.
+	 */
+	err = destroy_if_dynptr_stack_slot(env, state, spi);
+	if (err)
+		return err;
+	err = destroy_if_dynptr_stack_slot(env, state, spi - 1);
+	if (err)
+		return err;
+
 	for (i = 0; i < BPF_REG_SIZE; i++) {
 		state->stack[spi].slot_type[i] = STACK_DYNPTR;
 		state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
@@ -931,7 +947,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, i;
+	int spi;
 
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return false;
@@ -944,12 +960,14 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return true;
 
-	for (i = 0; i < BPF_REG_SIZE; i++) {
-		if (state->stack[spi].slot_type[i] == STACK_DYNPTR ||
-		    state->stack[spi - 1].slot_type[i] == STACK_DYNPTR)
-			return false;
-	}
-
+	/* We allow overwriting existing unreferenced STACK_DYNPTR slots, see
+	 * mark_stack_slots_dynptr which calls destroy_if_dynptr_stack_slot to
+	 * ensure dynptr objects at the slots we are touching are completely
+	 * destructed before we reinitialize them for a new one. For referenced
+	 * ones, destroy_if_dynptr_stack_slot returns an error early instead of
+	 * delaying it until the end where the user will get "Unreleased
+	 * reference" error.
+	 */
 	return true;
 }
 
-- 
2.39.1

