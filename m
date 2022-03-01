Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6E34C846A
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 07:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiCAG6h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 01:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiCAG6f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 01:58:35 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B615050B04
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:57:54 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id g1so13365256pfv.1
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcePxdVil0j2Y0EYMcgPWL10sT920XMS2ub3RyNr3OY=;
        b=XiYkWX3hSmmFcwj7jHkMFGutNPkC3zkcI0IbpG74tiuLrTgowhBROKfreqBN9AgWHs
         Wej+whFZELTgVgcRjNoiZxJlC/SNwaF+egAmtz26d8UVqu0nvSZGfJQrVmRBlEefrleo
         awGJ/sNSiZNQ9Sv9aByIzET/ANBSLiNRTtJQ1TzpepWxBemYcHi4qD4bKFQ7lzyyWXNu
         R6hCSTF/9gNvihwCFFP6og6tptce5BF5Hv7R2hzpY5bSyZP8QjqlQgTEhjfkWX5jrrUR
         DIzC7P/fwsL5OC1K5N5rZ5OjcEZA73p0GJdtf+ZpA4mFH54VMG+8S0Wnr3WI4WvrpMUv
         yb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcePxdVil0j2Y0EYMcgPWL10sT920XMS2ub3RyNr3OY=;
        b=rwXLnMS1BWjO8S37MSZ/UhGuvNO+o0lQPmru6dwuTyvSWaqiyCfsyILdC6pyCdGgm5
         YhtNWZoY0lwcibSpQkqEpgjKFtUTwVhKDsVm+9x3zAzMEGr7CjitHvPEjC8HUSQfHOdC
         hi6dTlG+dcSNb93QfgaUM6pSXDrCyz/bFgVpiNdYwS90E5XASCElbsXVrcuk83kuKChL
         YDj95BSmUq7XjUudrqn1Rz768QZxqMYMt0Q9eX2Z7erDZMopdu98uV6I2b8MAQKqEOnx
         1w8pwtoDi1pjYB5uvCpagNv14SlqIY1bRNHvBlZ47iXPPLYCQdWiwJpD5c64Ha5etyab
         dnAA==
X-Gm-Message-State: AOAM533h7n/W00O7dDEM2z2PU194+kAvD64uwInAhxFHbQlhR7JEp4Wa
        exBQpvrBjTEFon35nDxwhiXul88W0S8=
X-Google-Smtp-Source: ABdhPJyA2/UVKAdFnQfFtC3bv7raJRPMl4vAlf0dMDE4SLtEKA6g1eS2meXTdnfTcMSieD3Xpss8gQ==
X-Received: by 2002:aa7:8d0f:0:b0:4e1:31de:9080 with SMTP id j15-20020aa78d0f000000b004e131de9080mr25890351pfe.1.1646117874068;
        Mon, 28 Feb 2022 22:57:54 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm15750363pfu.40.2022.02.28.22.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:57:53 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v1 2/6] bpf: Fix PTR_TO_BTF_ID var_off check
Date:   Tue,  1 Mar 2022 12:27:41 +0530
Message-Id: <20220301065745.1634848-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301065745.1634848-1-memxor@gmail.com>
References: <20220301065745.1634848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3141; h=from:subject; bh=6O/7bE9Cyl1Q+aBejwnyFc0HIYcck0DgiMjjeMgU0Ns=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiHcO1/KGjWYQoDvpihEw7sVUZ14iQ8LRSclbsQ3t2 Ew6pM82JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYh3DtQAKCRBM4MiGSL8RylwQEA CMffliO3i+dk36iDLdsp2oFF3gdQsaHHtf0vIhiJmUfhUcpra3kyNFlyoHj2Lorxa5hc8/vXPt4S1N RLGVKkoAmRHgB9nuOBQoD9q0NQSL9boACy4ED9iGJYmJ27ZJX2i8UYe4jhJXuGaCrJdagq7jer/d/7 Ha0cil6iD26byCUjhr5NstZu2LvBVz3rHp/He2bfHXy1W+6GAiP4mV8nfFB3bnb2Lk53qKjfaPuLdb k5C3l/xjX1z4cTh2MMf8kw0s5p3pET5bJyPPsUQzHwIpmIml+03TtahVxbKBjd3Zj3/zbjx1Jfncbs V1n0I+IZVJQwkFSPPfBHmLhu4+SNWtPcOWpyJr+l/o8/BQl3oE/Ww83k+qGMgAZSlAsIGP4G+W8h+d XlfG2i3e4esHBy8f2PwQrfMRH3mgkW4iFykFp50rkI52r28U7G/jj5FoJIU7f28grYjpBFuWqiT01i N4PZee0uLtNTiil3dXug0Gr75T4ZVrElaIW68yfEUpk037cFYE5aBenDaFruwp2pR7/DCCC9b2J/IA P1mQj7gI1bg76OqeFtA0h8NVYuuwOD3fw0Qlo40ItVcUpxsQyCmbisNWtQWWOEobaPXbHLfF2tuI+f ibXaSypkderESvLp6ZohTO9I0bkJ6kN1Zg4kjyhmqStgYDQPvQxahyNOgTxQ==
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

