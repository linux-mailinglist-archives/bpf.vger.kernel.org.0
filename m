Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C4269E8D6
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 21:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjBUUHA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 15:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBUUG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 15:06:59 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AB330E92
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:57 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id o12so22379394edb.9
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r/OJAG6pYjz3uYMx2mH7/j/3RiixHDF+PC6j6HMZ2A=;
        b=LpK5ORRCXb5j85TVScJgOm5+fk9Me1j9guv5NKFzAuaGPUUCU3VufCY5p8YNDVaecT
         vx0OrucmyVoDovBmARMnGT0M88WrAVXE3Mv2mlv3PTScdZBJ2M3eHwdA8o/Cj6kVsd9r
         ngno0fDuVSjxRHyhHEz8ouZJLdrlgR1UJAv+WusLHplt6eqzRYc3P4A1E4ee9yrfj3tn
         sh+1Mh0yFcdlzMuMOXhDqdKbSdwv83h2teti/s/ORQFfDJH5UQbVU3vlw7r5Dkcsazqn
         fAZmAzIbcG8Zkx5WK0rAZeildimZbo+T4oyfdh4ooiMlZqltAtwe/0c20AgI5dAtdiyF
         QCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r/OJAG6pYjz3uYMx2mH7/j/3RiixHDF+PC6j6HMZ2A=;
        b=j6EaKoWSHRX6C33JyFnLrjkfQZYexwDWm53ZzmRBlQmV8oTI9aPm2Lgbck0zJgS3R+
         FXF0lNp+4JGv4prC5symvp9Q17PeillN40KlPZKSDqm+iG2INB9JccFPg3khAqMGIFea
         EPh1LFycmpRBh2/GrgobRb06xqDLYgrp+YHwIuVDP7BcMagZTAbHKsSt0GkKNRrzEU7l
         vqLj9x1fvp8vx61eLkl5QEc0xZojoIDFThDGvTUSSgNu0sJ8iSOMjHuCGJikf4+WUpdx
         /0x9QfXRjUEVDgjCIhdqfGwYPep0vsvf3XofN1oXBvIVtKCKXAyVOV/tjSW+0nzDMJqe
         7nQw==
X-Gm-Message-State: AO0yUKUcya5Qkd5P3f2cJHqBwRbO76kVx00Jr4qe1WQyMYrre4qnicyn
        jlyf8+ab9hx4KhBn7PoTb1R2v+n7m28uKg==
X-Google-Smtp-Source: AK7set8rAhH4YtYvuTZ1eMPmABae6QBWC53epv9HqFnLIOkr/tMzLk0Hv4sGza2H9zwOXtyjIl5rxQ==
X-Received: by 2002:a17:906:9f25:b0:8b1:7569:ad58 with SMTP id fy37-20020a1709069f2500b008b17569ad58mr10251875ejc.2.1677010016063;
        Tue, 21 Feb 2023 12:06:56 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:6d0])
        by smtp.gmail.com with ESMTPSA id q20-20020a170906771400b008e57b5e0ce9sm156879ejm.108.2023.02.21.12.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:06:55 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 6/7] bpf: Wrap register invalidation with a helper
Date:   Tue, 21 Feb 2023 21:06:45 +0100
Message-Id: <20230221200646.2500777-7-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221200646.2500777-1-memxor@gmail.com>
References: <20230221200646.2500777-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3186; i=memxor@gmail.com; h=from:subject; bh=nH2wX2lbjSnpaunG5MSM50qcXyLVo8LAtKNm1jgtDWo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj9SRMq+lsdIPAVzWlfBe5DxeOpg2l+MjZPHhrixuj esKP2luJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/UkTAAKCRBM4MiGSL8RyqfcEA ClMMgCHwOxkufwpEQBIgXoFjrFrCAOOsiMbyOxEYuTLZpLmXSkxW4v/RO/BCMdESnKruDWVUmnVIWd H6agHu0toDF3QnDainxTYPKMFUwNPye6NNN33k3m3piiEP183J2Fbz7De9Hf5YnKnMrnrMBSPQSv/2 o6YwL4flzOVVooBJPcychnGB/y0/tDb+3WqfYJBV8r/YssaRwA28+jwFAdUHUfqlDCXYEeFpCUczoE YJOLQ0gG8jP6jmAE2DHVA4gLL4nXYcuFH4xsT7g+/+RUQ1mW3YHv7cZuTho/hSQjpze0KsgHkAXdwm Mtd6JmTDVeW5/ugCkg2XlFo/0eXLIvdk5xnP45bcUvi5RhFo6nQTQW0A76IYhfXvej4FHpBgy4N7GW fb3ZrxR/ler3k+Wz4VG88zp1s1sbCh68prELXugxexTDYnXu6bQ1/ZkdUW7dBILhImN+YJvw9Ut0yI 4o6DgUxAkjJab3DrMZguJ8luzcaQ4JDWLl7U/mZM6iTSVrPhrK4T/gYPQOpvWzDwjWS7kCngOxrvg5 0QhKL2fOmrVClag/RjVBpGo6ccXTYRatSX/TsM6cilzAg+DW2iv60YGoRGu6KgbodL1F2hlasMXxTQ rs9/glH3bRsQYFqrHgEX6S9gh6783y+yHfQcgXXa36qv9oEjUHCf4jqRxwQg==
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

Typically, verifier should use env->allow_ptr_leaks when invaliding
registers for users that don't have CAP_PERFMON or CAP_SYS_ADMIN to
avoid leaking the pointer value. This is similar in spirit to
c67cae551f0d ("bpf: Tighten ptr_to_btf_id checks."). In a lot of the
existing checks, we know the capabilities are present, hence we don't do
the check.

Instead of being inconsistent in the application of the check, wrap the
action of invalidating a register into a helper named 'mark_invalid_reg'
and use it in a uniform fashion to replace open coded invalidation
operations, so that the check is always made regardless of the call site
and we don't have to remember whether it needs to be done or not for
each case.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8dbd20735e92..d856ee74ad63 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -895,6 +895,14 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg);
 
+static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	if (!env->allow_ptr_leaks)
+		__mark_reg_not_init(env, reg);
+	else
+		__mark_reg_unknown(env, reg);
+}
+
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
@@ -934,12 +942,8 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 		/* Dynptr slices are only PTR_TO_MEM_OR_NULL and PTR_TO_MEM */
 		if (dreg->type != (PTR_TO_MEM | PTR_MAYBE_NULL) && dreg->type != PTR_TO_MEM)
 			continue;
-		if (dreg->dynptr_id == dynptr_id) {
-			if (!env->allow_ptr_leaks)
-				__mark_reg_not_init(env, dreg);
-			else
-				__mark_reg_unknown(env, dreg);
-		}
+		if (dreg->dynptr_id == dynptr_id)
+			mark_reg_invalid(env, dreg);
 	}));
 
 	/* Do not release reference state, we are destroying dynptr on stack,
@@ -7383,7 +7387,7 @@ static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 		if (reg_is_pkt_pointer_any(reg))
-			__mark_reg_unknown(env, reg);
+			mark_reg_invalid(env, reg);
 	}));
 }
 
@@ -7428,12 +7432,8 @@ static int release_reference(struct bpf_verifier_env *env,
 		return err;
 
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-		if (reg->ref_obj_id == ref_obj_id) {
-			if (!env->allow_ptr_leaks)
-				__mark_reg_not_init(env, reg);
-			else
-				__mark_reg_unknown(env, reg);
-		}
+		if (reg->ref_obj_id == ref_obj_id)
+			mark_reg_invalid(env, reg);
 	}));
 
 	return 0;
@@ -7446,7 +7446,7 @@ static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 
 	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
 		if (type_is_non_owning_ref(reg->type))
-			__mark_reg_unknown(env, reg);
+			mark_reg_invalid(env, reg);
 	}));
 }
 
-- 
2.39.2

