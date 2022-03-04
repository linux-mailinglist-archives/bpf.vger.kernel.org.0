Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113D14CCA6E
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 01:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiCDAGF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 19:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiCDAGF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 19:06:05 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB635ECB2E
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 16:05:18 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id z16so6151319pfh.3
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 16:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcePxdVil0j2Y0EYMcgPWL10sT920XMS2ub3RyNr3OY=;
        b=WvjECKX1b+qXDBPmVeYMETZnTb2pBxUbek0xXJCyBvnsCa3tPaeSNJPxwdIA5LBxwl
         iHVm8NGGFot/5WznZwcZLnw5OaLCVWMGdH7mOqzpIdrqTMwyomZxd4IPActCNTJ0c9LW
         RL4+jqkSVhJKQxfFGBFqSCSpyPQhAyUZpri3/OBnE55Uqyfrd6wndqj5q+MfGvW4A08n
         wPQTUqHpe8VfqTa/vmUvKNm/+xlUySvvFbGuXPTYHNNlgCeZebJUP6SUNTQI5h2T/LGB
         XwnbPHPEjvn2ktHkRoRcFNK8LmPRuvYiPk3d3/qYTnh65UGbtZFFHtdbPq/6nGWBAo2e
         HliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcePxdVil0j2Y0EYMcgPWL10sT920XMS2ub3RyNr3OY=;
        b=I+7J0uBOtsBpqyREpGOoHYkr0gWx0UPgInUZsWzh8dIPm6+MPUSncBC5o35CADX+wS
         J5oz1tFA9JOGEzMF6wovCV0IsyOexL9xuvGL5YXwu3CNQfjIlS5YObGmfqxXR7m5d050
         5YpLL2n/ddfC5+AVR0yV6qSab3g1/XKERXUgkNABdR/J6gR3+4BGO2sgirAoljt1kkFn
         v4b39YKBpWsdVAaHlQhoIR44fHNot6wvGYh5GukWeCC8i1KxKB6oinbqJHm6CVC8WGJv
         Rc6La9VP34caqVpJ1wqnkb2qI5sZhT7lWPhNb5OjYX9suiSGdO/F9WvTrpYMq34zD3i9
         68Vg==
X-Gm-Message-State: AOAM530jLcDfzB7zLVEz/CVX3fgh38KfaMuIpYvH9qcVzLCeWX+WH3Tr
        osgbBHIXzzggNBj5OcTMi3ckWzr3LpY=
X-Google-Smtp-Source: ABdhPJyvxplWy1i3pXQNMdxLHKICGXoFn0jxV2FNfJX3cXwXb+gC3stuCgHVFRMH6zFqjYzCWxayoA==
X-Received: by 2002:a65:6210:0:b0:374:ba5:aacc with SMTP id d16-20020a656210000000b003740ba5aaccmr31805860pgv.8.1646352318249;
        Thu, 03 Mar 2022 16:05:18 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id y39-20020a056a00182700b004e19980d6cbsm3604523pfa.210.2022.03.03.16.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:05:18 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 2/8] bpf: Fix PTR_TO_BTF_ID var_off check
Date:   Fri,  4 Mar 2022 05:35:02 +0530
Message-Id: <20220304000508.2904128-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304000508.2904128-1-memxor@gmail.com>
References: <20220304000508.2904128-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3141; h=from:subject; bh=6O/7bE9Cyl1Q+aBejwnyFc0HIYcck0DgiMjjeMgU0Ns=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIVd//KGjWYQoDvpihEw7sVUZ14iQ8LRSclbsQ3t2 Ew6pM82JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiFXfwAKCRBM4MiGSL8RygXKD/ wLRmfyqjcP5X85AYsY9aLK6OZ8hmXllD9+JZeoi0rKJQzpWzcWPYBtxhm0hg+t7zf9MUKA1kJorBor UGtagw7J/Ay7qiPu0K8WHocpEKFM9PvyB6fstJS3FNBdn7w+s/VRXZH5pYTddHRQ/VSb6WLHBYWMtU KqTk/gzN/WHs51nyIFERukBgoA14k2UpOBXk2s/E1DTMaxrcHnDlcwFaZAZ/RAXsbYZEBMNx1wYmau 1ByiwhfNV2u7fPCDFnmN9bMSXO20SnpLTGk+Qi4n+Cbsg1LYxtrxdsd1ApvUhtuBheIdHupjU6YeWL 9SBug6gCCXGHKz0P1N8YG6ArpTr1mrd/Iyog+TSsYzgylBK0U4sjhxOEhWdm/GRf67PsDo4HOQbRiZ 4Oc8BCNvl7bL4y82Ggw3T5YNnGEQVTxY5V1hpa5YkN38sLdDjobvCk6ciP5xDIgyifTe4TGvidVSf5 xt+rV3n5ufBpdB4OuZceYEdVJNUpKjgUDJkhnHn2odyM2PC490xkThnNpvlMfPx0LiE3FWe4H46HPB jfh630xxCHey/6JrBhuQzHqOwArgkd6h2aMzUZQskaSbFG4LQq2kubCkccnUXBZHToYJsC+rN+hrpv gVosroJDO33vy2gOKYfAjwnWOIIBq09JMCMN49OmWQ02bPhKDO3SN/dc568A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When kfunc support was added, check_ctx_reg was called for PTR_TO_CTX
register, but no offset checks were made for PTR_TO_BTF_ID. Only
reg->off was taken into account by btf_struct_ids_match, which protected
against type mismatch due to non-zero reg->off, but when reg->off was
zero, a user could set the variable offset of the register and allow it
to be passed to kfunc, leading to bad pointer being passed into the
kernel.

Fix this by reusing the extracted helper check_func_arg_reg_off from
previous commit, and make one call before checking all supported
register types. Since the list is maintained, any future changes will be
taken into account by updating check_func_arg_reg_off. This function
prevents non-zero var_off to be set for PTR_TO_BTF_ID, but still allows
a fixed non-zero reg->off, which is needed for type matching to work
correctly when using pointer arithmetic.

ARG_DONTCARE is passed as arg_type, since kfunc doesn't support
accepting a ARG_PTR_TO_ALLOC_MEM without relying on size of parameter
type from BTF (in case of pointer), or using a mem, len pair. The
forcing of offset check for ARG_PTR_TO_ALLOC_MEM is done because ringbuf
helpers obtain the size from the header located at the beginning of the
memory region, hence any changes to the original pointer shouldn't be
allowed. In case of kfunc, size is always known, either at verification
time, or using the length parameter, hence this forcing is not required.

Since this check will happen once already for PTR_TO_CTX, remove the
check_ptr_off_reg call inside its block.

Cc: Martin KaFai Lau <kafai@fb.com>
Fixes: e6ac2450d6de ("bpf: Support bpf program calling kernel function")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b472cf0c8fdb..7f6a0ae5028b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5726,7 +5726,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
-	int ref_regno = 0;
+	int ref_regno = 0, ret;
 	bool rel = false;
 
 	t = btf_type_by_id(btf, func_id);
@@ -5776,6 +5776,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+
+		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
+		if (ret < 0)
+			return ret;
+
 		if (btf_get_prog_ctx_type(log, btf, t,
 					  env->prog->type, i)) {
 			/* If function expects ctx type in BTF check that caller
@@ -5787,8 +5792,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					i, btf_type_str(t));
 				return -EINVAL;
 			}
-			if (check_ptr_off_reg(env, reg, regno))
-				return -EINVAL;
 		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
 			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
 			const struct btf_type *reg_ref_t;
-- 
2.35.1

