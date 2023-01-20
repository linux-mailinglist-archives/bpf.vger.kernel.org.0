Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781CD674DAB
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 08:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjATHE0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 02:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjATHE0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 02:04:26 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274D530D7
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:25 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id lp10so1324287pjb.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmo0le0cUJOBzWSdrlYEJJL3gLctaWM5TmJR0sXVqHw=;
        b=XtOhahdlROSujGFdGp0pfY38UYK0Ces0ozOf6MIHPQlYxxhQsNvOEfl0q9LStn9uA+
         UqEH7P+ooAZBrcNYwcwbeYkY0H8ZiUVmvpTui2dw2BCpgkC/yg0vKQn5xSqyr7nK4dg8
         lX4riTEI3ILk4bIw2nRIOMUgPynBHaXJ26Qa5TY/goHrgz+Phq69tCVg+0lqFEsHoNEd
         jwc767t6jEMVDsOYDoNetUIXucfAR7xzwEAV+LiryWgSVwh0fAQxd8pmrAxKqsfGxrdv
         Lds9Fg2/lX+1BcToa6KTh6kXEk4PLX69fRU8ejk5sg8UPzJQZMJ94xeWi5Zi85kG4ttE
         +/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmo0le0cUJOBzWSdrlYEJJL3gLctaWM5TmJR0sXVqHw=;
        b=VmB66OWr7MKEECKqb6zqTxBcAvaW0j97SqGTB1XWynRKQFDlD5JZavJ1r4UKKvl14y
         Xb8QUPh9uK+0lFpxQbFO3/XnfHKRC4AAwPEt6nHBa9jR7oSzRHoDg+V8l4h4izz6rz+I
         BpTKYZzIP+aTBUVbHKNxs9pBTLpZNiyQY0XbuT1tmeGVHwVw7a+62J+uGTGsysIhz+ke
         7eHCvpkJFmpX06MajZeA8b7A0SsyZHM9outMUvpC9eOA4kH/uMJcppRa3ZqtUlFnj+h4
         NVN9Dt9azOGIm8T0/Bx+nuENya+i2HVYYiQXqjyZPoBSvNeNSdypJdTUVZWIbq/Xw4aH
         gKuQ==
X-Gm-Message-State: AFqh2kqJs6vR3ubQ3d048k/uqxpGbbhhvMcJleUJxvEYURu+ldUaW1P8
        LS0Af6yyyAEtBJIDHNKoTiITj2mMhH0=
X-Google-Smtp-Source: AMrXdXt2sJOY8RzHuwr6xg7oL4JMSi8NrlwdHfOcrzXhPdhbxk8qpX5vGQoCkM6QjTaMM2vTGY6Mjg==
X-Received: by 2002:a05:6a20:2d12:b0:b8:5a85:6332 with SMTP id g18-20020a056a202d1200b000b85a856332mr16555131pzl.7.1674198264504;
        Thu, 19 Jan 2023 23:04:24 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id d21-20020a630e15000000b0047781f8ac17sm21676070pgl.77.2023.01.19.23.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:04:24 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 07/12] bpf: Avoid recomputing spi in process_dynptr_func
Date:   Fri, 20 Jan 2023 12:33:50 +0530
Message-Id: <20230120070355.1983560-8-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120070355.1983560-1-memxor@gmail.com>
References: <20230120070355.1983560-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3698; i=memxor@gmail.com; h=from:subject; bh=n4U1dXvfeNH1zRNe/co4rVPmlxHdSUzypJJY0IRJzjw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyjzL1RvlX6RfReOLAFbMWC9wK/gvWsxIfRy4IvoV dOq3G5OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8o8ywAKCRBM4MiGSL8Ryq0oD/ 9mkzu6cCVgXiBlhPGOymPfo9EFP7yJcdupRfv4YRBiYK3xFAo9QXGdvYdMXkVFb+yXmAI3xnk1eYFx xHICWScpikgh7ILscN526bbXW4o7WIQwr9dfuLVwV2eT1RBqJefF5GZe7YDm+NSlYcL9LJf6qFMJM/ aDpKKC+Cpd8v0pwbWg0UebUWwXd/IzVuSYYt58xF6+ZYHaRBcOUgj+20guOp41PdlvJv7doawhVv3d JN2sb/soYUnIStDQ2Y3JMPJAbOCCbS6KtKn5w2A7i4eqL9gyq71GD6gZb79NUQN/pFIMehh4tvWUpn WU5YV+dSxJdc8E9sVLC/RpSoveF7qN5h/6pWln5l0UF/e7zwkZmYWzXzGWUmQvUo1Ldx2IvtY/ubYQ Q7dm9dzf8cL7JnJ1e39ClYU3p5g4+UNeYvMyuqSuzStvB8kwpN4notqv6CN9lLYX/Zp+5DRxjGZSv+ DvXlb2wURChhZ9K8E1SYIA1uDIQemkx7bo7acPNPRmvsE/gwqE3RqxJmmNnK5IPxSBmCutQlc0614w Y+JeN8uRp3nD46AKFn1W8hamDl/C9pSfHHtG9FLf/DO2maizwxPhXQNMHGOORNa8n5N0IPBm9+McM7 EziQncQ+6pt8CdDWpt7qvriXWZDuJPYLTVsqca4L4tz4jST+wWUf437n03qQ==
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
Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 29cbb3ef35e2..ecf7fed7881c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -946,14 +946,12 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
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
@@ -971,16 +969,16 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
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
@@ -6139,6 +6137,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	int spi = 0;
 
 	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
 	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
@@ -6152,10 +6151,9 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 * and its alignment for PTR_TO_STACK.
 	 */
 	if (reg->type == PTR_TO_STACK) {
-		int err = dynptr_get_spi(env, reg);
-
-		if (err < 0 && err != -ERANGE)
-			return err;
+		spi = dynptr_get_spi(env, reg);
+		if (spi < 0 && spi != -ERANGE)
+			return spi;
 	}
 
 	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
@@ -6174,7 +6172,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 *		 to.
 	 */
 	if (arg_type & MEM_UNINIT) {
-		if (!is_dynptr_reg_valid_uninit(env, reg)) {
+		if (!is_dynptr_reg_valid_uninit(env, reg, spi)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
 			return -EINVAL;
 		}
@@ -6197,7 +6195,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			return -EINVAL;
 		}
 
-		if (!is_dynptr_reg_valid_init(env, reg)) {
+		if (!is_dynptr_reg_valid_init(env, reg, spi)) {
 			verbose(env,
 				"Expected an initialized dynptr as arg #%d\n",
 				regno);
-- 
2.39.1

