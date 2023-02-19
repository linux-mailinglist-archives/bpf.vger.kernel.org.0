Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15A569C149
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 16:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjBSPxD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 10:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBSPxC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 10:53:02 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4FF7EF8
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:53:01 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id er22so2963419edb.4
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r/OJAG6pYjz3uYMx2mH7/j/3RiixHDF+PC6j6HMZ2A=;
        b=R3/tLS/aK7t15/GR6+5/J9WhzGFbhNEPBo2sSnXNzZhKT26EHcLhw5MaYa6jsz23Pp
         J8+FMCvV/yWE5AaPTfCoLpuOa1hwLwuZkR/L6mT+WuR3B3UxJAzu5t/Bv5X34IbOuuZ0
         ZIhflgcTZbUwEvHS0jhC56nq+KXQw55esCZCAIRQyY89r5Tn5hN+AJ29TC6D7uewwoGL
         OhCxknTLQzscXL1aa4Jysnj6kWjYT3TCjpmlYCQMapp5TrWGErKFn9iz8Nrf6MizxFvI
         r0Wscf/R4pDNQjZqhCoGlTs7pp8diu7P+jK5g+aQUXO6QtbneHiu08FIN5TLFqQbbsZ6
         BETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r/OJAG6pYjz3uYMx2mH7/j/3RiixHDF+PC6j6HMZ2A=;
        b=T2x6cJBO/q3/l5fB7vgjIOiiLE/mO7dcyKpeRUz0NXYBvabQo+j++xSvLmy/nBXhsG
         iWviDhOvlhVxv+DSAT+fUTcBLPF96yGo8w3/a9xl/dFgJFI9FFkyNygcPmlkWOSuxhnt
         dAC10aikYYzEJJCEtpX+Tldrn/XeqbIS72DnmlYRy2X+7m61vyhDJ3tZ9ot0+dqr4sdA
         Z0QcKRnDLa1KjljbBKD/j/Zp04IWy7iCb/l4k6TBMkPrVwbVMUBTqhLIPLQKd0KU51vp
         M7zgqU4Wc+y34DtDvM4OEZGtyBTRfx+VRTOCz19HNoSDILoU+/SWiGe+PEKcBRbTy/CX
         ksIA==
X-Gm-Message-State: AO0yUKWoFYY1zPKmD/j8a2PKOeFP85lAuaUHyGhYAYRLi6nchAuv8p2y
        D/xW4ZOSnOwP1s+8xz8wNeoU7t8sDOMEBQ==
X-Google-Smtp-Source: AK7set8zslRMvvKZM5/a8MZmshgqZe4YD+UwW9OMT8kb0UVn9zTpAAsP2AfiqkcpCe+5r4/YJME9GA==
X-Received: by 2002:a17:906:3c2:b0:8b1:38a0:215c with SMTP id c2-20020a17090603c200b008b138a0215cmr8368578eja.76.1676821978962;
        Sun, 19 Feb 2023 07:52:58 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:8d0])
        by smtp.gmail.com with ESMTPSA id z7-20020a170906714700b008b17b0f5d07sm3734080ejj.217.2023.02.19.07.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 07:52:58 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 6/7] bpf: Wrap register invalidation with a helper
Date:   Sun, 19 Feb 2023 16:52:48 +0100
Message-Id: <20230219155249.1755998-7-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230219155249.1755998-1-memxor@gmail.com>
References: <20230219155249.1755998-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3186; i=memxor@gmail.com; h=from:subject; bh=nH2wX2lbjSnpaunG5MSM50qcXyLVo8LAtKNm1jgtDWo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj8kUeq+lsdIPAVzWlfBe5DxeOpg2l+MjZPHhrixuj esKP2luJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/JFHgAKCRBM4MiGSL8RyqPwD/ 45P2EoBKjf+bYNCAK9FlUuT8wMRpAiVJhzyj4RjxCHdh8u8lUQIzL5tvyxLvAnSQEZCKRetFRvusT2 kSI9fzWNFV/f2M3AMFkFCwEU5pGheCfj0eSNp2gSVoXjZCO8yy2E5YrtXspboEmZqLfcv+qUoGf1TE Vv0bPiihJ0VwoONFp8CdqACL+VavtZikP/zee4Vr9aFJVBF+xXy3EfKMzCFivvux/FSKGgG17NYOxr dIG66FLuhiLdziyCYwaZ+OiyXxTMAVKoAKEdW3vNmmmkX+OydGkMqBbq8Cmd6GMo6+Uo4JQ0f6ca55 Rcy/lNSmJfMNba667rIe8EhkUPY0t77cOFj25jpdpt2NoijG0+gqLM9ewAgUtC5bmt9tkUAbGgkiq7 EAZmPPkkgs1bsLegg1mHY/SuOYh7FaTMKD2UABbcUbJ6l8Ksr0ahVnVyZ3pzqqw6qiYOPrVNepQ4Dv eivyZF4nxi9s+tuOJTywwZrXxodgCIXj8GzzEzzF+jqdYXhlMkLU3DmUvXhze9AQeoJsCrgj9F9OYR 5ZdrHkNNqBCgj5URuPn9ml52phFwLrxRkvCsDigNbdobVUg9UBzCrnCoP2ENvQ9QYUA1JmeZzddUZM Us2YDYJh1bBW0pcsOx3WceYuGmMFPZCzR6eC88UQ4Fv6/fqrbe66pWlFr2Gg==
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

