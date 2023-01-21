Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BD6676254
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjAUAZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjAUAYx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:24:53 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1400273AFD
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:12 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s3so5150235pfd.12
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJTE+2IiThjMO3PC0iuCb5HXJeu+oAk3QS1io4LW83g=;
        b=ZVD11Jeh7M9TsMIZ5SKV15h4E4KcgvvjMz6S1BHSmBpYDEd1W2EGEgJusO/6z28DWC
         pSQE51jt48s0/LVTrve9kPxtnK2Ru25yrviBkbYxFNvPqPYdWzapmeDSmTNLzM5/rqI3
         U/aIybjDQYtJjNT65Azi9eN9T/PXIo6WkHe8vgOn2iknNqBnYrXA4RpwANYQ/B0ulFun
         wThoXa5oSRCjb+SqwyGt1CahstkiZdWS2/qffV/Ai0tVxUBYtMiyLu2BWO3IbAcslnOo
         g5PwdUB3yroUO4UPGArzS0f5WZxyodg7EzKHfsFJuauvb4fLokpz2n7tJ/T+1WglrJ3o
         ExOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJTE+2IiThjMO3PC0iuCb5HXJeu+oAk3QS1io4LW83g=;
        b=DaClNpOKtax7Ir/hpLlQQc3f9L+vlc0SUc7g0z68zdINNqr6gyNvyf2FY4T96UMbIL
         qzHBd/gaqC2hShT3JDTnRjWfBlL3qqkqsSOnxn4UbQQVC00JT/dbsz92KL1WGPa0/ocK
         rxTKuxepGb94O8l7ygSYCeoKoO0dkDsj7XskjBluMloZI6qXo6fiCMhLjm3DkmjF57PC
         z3T9dJQNNU6LS7NfUG3Ckf8UxOKyUMOVP74VtkuI7mYceBgnNUJSWpUet3if+nG0Lg3M
         qGvZD8vw6oaTUiWRsZa2hJPH7eiBpRbZpfwaqoBR7mVhbcgaKXmAMLpKohlpWIHSFNp4
         B3nA==
X-Gm-Message-State: AFqh2kp5CUfIX+PBIFueaUzZnxRGFY4ggtIS9QtZoPM3rRDZrFI0f4ab
        yDSf5k+XatW3MonWtYAgJ0cEimJFCyg=
X-Google-Smtp-Source: AMrXdXuTavOUIAPkv7lRGlVIzLakOY8XDIPsuXfjkUwMrAc87hz9dqIxD91OOal9f2k0udHl1a/+6A==
X-Received: by 2002:aa7:94ac:0:b0:58d:e33b:d562 with SMTP id a12-20020aa794ac000000b0058de33bd562mr12277938pfl.11.1674260581969;
        Fri, 20 Jan 2023 16:23:01 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id d8-20020aa797a8000000b0058837da69edsm22961524pfq.128.2023.01.20.16.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:23:01 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 05/12] bpf: Allow reinitializing unreferenced dynptr stack slots
Date:   Sat, 21 Jan 2023 05:52:34 +0530
Message-Id: <20230121002241.2113993-6-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121002241.2113993-1-memxor@gmail.com>
References: <20230121002241.2113993-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3888; i=memxor@gmail.com; h=from:subject; bh=YkhcRHw6M8R1uNyUytIog/IKy6jL6P3mgH0kEKFhQB8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyzAkJqykp549TuD8qfi+l8J7mju9PTDOmDmMoZB7 eluhbseJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8swJAAKCRBM4MiGSL8RyqU8EA CIk5IXCIee4Z4x6+h/8564qNjbYFlWYLUHY3MA5qYoRHOXS1SCJrZO8wUP9iTtSYUrf8ogaK9bRviy xqVsC6fJVDDp8/l7z0eh+ysPOd9LbiNNE9ZsPmj0fjdQLKPFPuuQo76MnDy2EfAWy1oaV1B32TVGzh vusCOhq7yAC/PH2aFAgEDN/7rLUsYu3X2X0SQLizPODx01OO37vHhdseDoceBbx/jZChab2ZI3Bzpj xqbo6F8pAe34Yxl18zjVHEHrRfO6De2tlKCWr+pqii0LFRzXztp3/SaUm0HrRGJPi+9IfyAagQizsY uLUzcijmLkfjRdosbE+woC9deBVPGfHRjbyRfM8T4cMaVVDDvGJNkf/qHzIjgiu0JTL8+3i3Ds3+Rz rKmOgvFvDAm8kB4tMxSvAeNwVScJ8wqrmIruHUUk3DuTGWzXzoaBDgcmRXFXvs9JZ/H0OYyNAU3wMg csYmxSK56pssDNYSL11B+dF4Oyk2LtjGJOFgj5eD7NVu1c5oFicIC+nILbstvy1OiRkt5BxYvR7ggi l/HfeoOkrd9vmgsN8B/7zgoYbRkQ5Nk8gbDbpn4k9FV/GYkD1VqxAuCouLu8nNDh4aCWCFSB9t/xIs mSMIT93ePYP+mi0tOxVTEMGG8JzpGgmz0ZyB9eSelB7mTzODiUIBrv1FiWIg==
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

Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01cb802776fd..e5745b696bfe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -782,7 +782,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 {
 	struct bpf_func_state *state = func(env, reg);
 	enum bpf_dynptr_type type;
-	int spi, i, id;
+	int spi, i, id, err;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -791,6 +791,22 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
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
@@ -936,7 +952,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, i;
+	int spi;
 
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return false;
@@ -949,12 +965,14 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
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

