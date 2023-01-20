Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA44B674A52
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjATDng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjATDnf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:43:35 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E513BB1ECB
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:33 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so7000182pjq.0
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJTE+2IiThjMO3PC0iuCb5HXJeu+oAk3QS1io4LW83g=;
        b=dfMkB521OcQa1f3nrATddiAd+PcvT71EbJLKrimDD35olpG0v+iPcmIT1FPqACzbB/
         5DMSAbv6rOWMtLqkce2S1iihRCL9dtc1eg+HOM3HVqwSci4fhfu6vGlnKyNaOly8HlfD
         vnow+D0KV4O/Vp41EnQcgymgYxlgUJrkslaVgg7Sq6t9USUpGrlp7lgPpqGtIIzE/7Ba
         FSQqDKz162nE5QSfka9Qnv9+bLMI6PxW9kt66eP8cOCe3V7weVdwUMl6418BiS/hf3Ez
         AoGqAnZZFry2QGuggJLpmFDSGeNC4/PhQHQDcsRyPWY/vLVxt6G3a88mEoLYF+y9zLAI
         oJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJTE+2IiThjMO3PC0iuCb5HXJeu+oAk3QS1io4LW83g=;
        b=PUIBiiYbWXPIZLzV2RT1uE6ZupiX9fq60MivTdpyF5ulkB/T6lWKovIhERlzQhb7yI
         MKApIiDewRCmdiHv/uTlUSV2u50tOkxZeqGzMPFBJ+MguD9lG9ca56L7TQoyBo4Xn2y0
         WkOVk1KqCW4h4yeG1yRJlrGSHUl2vd3RkXme9/R/oMvUMu4+CdvxIYmqTJURKiCsBQCR
         MpuBMbchEqngi4Sw9i2uL0bKG+vuC4u00EbsDHN7N8AofrHhYFeafRa6ci1kQAXrMjHG
         /BlNoyHoOYpXKz0DngrykYQo3YCKEkCkmUdG49uDThtZYbpHMeSjYFjg4ZuK4l4/EE58
         moQA==
X-Gm-Message-State: AFqh2kq9+jqy0yhiUsEmgVN6T+3YwSrIFDIU9qsrKSPrHewHr15Hcnlf
        jiLE54rT9MwM2tv8ssG4XonVESa3FDc=
X-Google-Smtp-Source: AMrXdXsMpJt/Jtx9Zdx0e8NGa7hpktpJvKBt17UtFJKAxvRKZh4brTmoxy1jV1WpTCLKpgtTxtvMZg==
X-Received: by 2002:a05:6a20:43a0:b0:b8:f026:754 with SMTP id i32-20020a056a2043a000b000b8f0260754mr10898333pzl.54.1674186213206;
        Thu, 19 Jan 2023 19:43:33 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id y128-20020a623286000000b00576ebde78ffsm24668001pfy.192.2023.01.19.19.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:43:32 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 05/12] bpf: Allow reinitializing unreferenced dynptr stack slots
Date:   Fri, 20 Jan 2023 09:13:07 +0530
Message-Id: <20230120034314.1921848-6-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120034314.1921848-1-memxor@gmail.com>
References: <20230120034314.1921848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3888; i=memxor@gmail.com; h=from:subject; bh=YkhcRHw6M8R1uNyUytIog/IKy6jL6P3mgH0kEKFhQB8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyg28Jqykp549TuD8qfi+l8J7mju9PTDOmDmMoZB7 eluhbseJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8oNvAAKCRBM4MiGSL8RymlTD/ 45xWAJE/Wk0rNdGLz2HSx9OB+y50DL8In0OtbCod3+NSt1ABKEtbfzDitfraUNIQ2JUGj02nagnNu6 t0n7lgK6Y+X6mJkmvfiP0NTKe+jR9y8nk1YQOfKFpQoeb7fn0+MYowc4jgTO1bWSCf5YkaIWwxMHJu 6f2OAPArIWrv0wmNZey14f60zxeTuPqrqnBef4+Z1KTcKy7t+f3PJ6VPndpFnBx6R85ljX+2hN7csC /9aOnzcUr+V4m5gmwyRF7gCtg82VmJpTgx/iNK981T42W0Q05S30GiZeslwQguwoTAtIjZwSvYRTrd +cgpGcSWO8N44msU/u2lg9arKxoeUJohvuG3/Us6vROL0OCNYfYuGjpN+Ekj1rCNBKwh3fZv+zuZMl cmuX28DMQszu3rqYcffb+lwFNav9S8xwvckLSLZkZ+cY0Lm+WGKPOhEsi3m6nSea1EL2vgOC5vKNyV hm86++VAJAg5ZzUPzePfZetEyeDnEi7u03PWkFMzjAMtjakFEZSKzoPkFnXabhEmX5rqizaIKMTDB6 vwrvIlVYMWeA1N4LQ0x3Ejh41HFYDKVEx/awGd9rBSG4pSBlGe0OvHJ4remKHvHJw7dKSAafWoHafD 3gqtXiVRf7gxeJi3l6+ZnGeLjVoht8xTh+8HTwZWSpBg3NX3h2XPG3/ECa+w==
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

