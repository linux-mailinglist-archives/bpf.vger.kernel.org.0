Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BC24CE061
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 23:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiCDWro (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 17:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiCDWrn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 17:47:43 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966575FF35
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 14:46:55 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id s11so8757850pfu.13
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcePxdVil0j2Y0EYMcgPWL10sT920XMS2ub3RyNr3OY=;
        b=Niho66qpXCHXBysu79m46rK/5PN4Vs4wg5T6Jdtmea67cxAMNUcf5hygcJKvYYE2P1
         WWrkWpafSTnFkGZbZMXZdmTx5rkrw8OgVOLD04Xr7VJ0dakwrIsZw2D60KzdbiR3GZ5R
         0hwpIuyCx6LRXBi9ajTMip7P71XdatKxAS7ekC9vpHTN4rO7pqObJSM58sZCxgC7zG6F
         qM0LnMgl/PMOww+BpIJ7y5G22hiLhXefvw+HwUE0lmij1NRBAx/rqC9osEiu1xsI+xWO
         yAx63SpvD/yYzXeOZJhZc7f4YTmzHqx4y5veCbEhPBVBk6r8qfDZqfC5IIcSxsuccqJU
         d+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcePxdVil0j2Y0EYMcgPWL10sT920XMS2ub3RyNr3OY=;
        b=ZdFmMOUlA/76Shr9I9PFt8aBnpoQ8XLMwaVbWArjDvxgmxdrzWBLFJ+9RdJlC7I009
         Cl4us9K7VU6rdjpP9IUMRgneTIBvpqsynvHsXXHdQGL0rDyqJVVzOAsP4B6+lbQiqQdc
         KoieAlezuUnr061MmIPVqed+gCSkOckkuKFOnHUSVxYp4z13Gy/6b1b9H+5XRgvWzMWY
         /fYjVSX4E95PTExZ6T0VghVDdwCU80qByD292Kjc7SYf+dXbAc/jDAHp6WmnE1IxWhiW
         Umz+m346HXcrYNjXGKNmZ2vlAy8doPHVKkisFf9zBcWFz7ClXxn2bmXBzwdy2bGIkObv
         FYug==
X-Gm-Message-State: AOAM532zenH1HFOn8wNxzs1Y0zYvUCgUc6H8yj+QTtzaEM2JcEd8wja7
        +TczWynDjUsEf+GDsROF/uH0RSFA8ks=
X-Google-Smtp-Source: ABdhPJx193uyftJ7DHuzAHhcH4Syxz2Lpd3BC9OO7aJgcyeO/dgL9X4Cyi0tKUwu7Gn+FCdNGYYN5Q==
X-Received: by 2002:a05:6a00:22cc:b0:4e0:58dc:e489 with SMTP id f12-20020a056a0022cc00b004e058dce489mr963066pfj.58.1646434014969;
        Fri, 04 Mar 2022 14:46:54 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id n22-20020a056a0007d600b004f3ba7c23e2sm6941818pfu.37.2022.03.04.14.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:46:54 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 2/8] bpf: Fix PTR_TO_BTF_ID var_off check
Date:   Sat,  5 Mar 2022 04:16:39 +0530
Message-Id: <20220304224645.3677453-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304224645.3677453-1-memxor@gmail.com>
References: <20220304224645.3677453-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3141; h=from:subject; bh=6O/7bE9Cyl1Q+aBejwnyFc0HIYcck0DgiMjjeMgU0Ns=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIpas/KGjWYQoDvpihEw7sVUZ14iQ8LRSclbsQ3t2 Ew6pM82JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiKWrAAKCRBM4MiGSL8RymS1D/ 0VVGKOOzWk7Gn2+zi5IvY1stjuHZ4HcGnsncT/1+9D5zM1GB7Xqs1wtzlrL1iFtgyYvQJ12RdfxcXW Mglv9Uv6llDYxjjdU5bUcnhxWEIYEVb4O7arN6LJFCY0Zz4xcku2NQM+TxbX/g/7vIqkZ0MB5R4/Fu FrykVxD051J18Goa6ECh8EsQADbJ1NeMMAkS0e/vs6F41zKuGsq8IQRQBzqHEiGztUq/HdFM04uJFa mxpiMDiVJC+J6Haic0iOKxlm6cRX+SBC6AEp6cr8sh/gyF/0it9XFIS92hHyCwQUoUkB58IqmPAdRw hRK4278ggkyElnppCp0wWwHrKcw7MohZAzq24h3MLbx5128ppOVqzoxAH2TmEHp2i4zW3zvzAqD7u3 WIF4DwxEioqdKvGSueLAOfbubN0mMV3LKat8fOh2sQTZgUw/w62lBzsAbVYcnF+YHRrx08uqAeR50E +XCneuAU43Dkl60+GJVwJk9/FF9EcvYQM74Ta1RW3ZPgUrICOYjTZz07qyLvuredkYvLg/iimWupQz rKjgqhsF0pd4b83O7vcoDBHCCdFccj0NexVBLQblOakfzzkXD2f0pt48qGBXDEgg333NAgBgYSXAHS nyjDHMiyZHK5U8HIWkxh12ztyDqBFLxrbuvE/umv7Ml2ySedpsnTY8Q7aA/A==
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

