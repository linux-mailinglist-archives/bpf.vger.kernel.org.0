Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34B478157
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhLQAcS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLQAcS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 19:32:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30422C061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q198-20020a25d9cf000000b005f7a6a84f9fso1522562ybg.6
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nSf2u+v45sBG2A17wapTc+at/ZUabEg1CkvNO1axjSc=;
        b=JNANCOAE3xoAE+bkatxLngG2dxN7fWbGT8TOOjjGWsByyB4LvMTVZ9KQPC4BZLlupT
         tj/Ksg/fHVsOtCwAoqqrVpIPEUrXKWQZddsZTOr5elSt4YDKC4yXq4V+UB8T8zr+LMjF
         9wrMB0aYHIFzNgOfmonJOY7jajdeq1Iix0sg1Kz9kSim2PpHQtdN6AOPdyaQv3LMo41P
         0wISUPRxYeJf/e7zvkA2yzUCOOCijDwfAIVtnGhErg4aUG3ZRTwGNK711YEpwrNl9WsP
         iI5/SS9+U/9OcJP8ULdvpEgsiX1HieT4rf9PsEeiRIpKqmdjMO1iAxyFRbM5f7eH4sRJ
         DtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nSf2u+v45sBG2A17wapTc+at/ZUabEg1CkvNO1axjSc=;
        b=qvsxMHCNJUQRoCjI+10NQOrDm1lHsmFwp8WOl2PJ5Se6FgbBDekZBXADcSQrB0w5x8
         e/CtZXsCmGNFkkQ1Qw56D0Sw4vFgDoX7Jy04RLM4/DX5IvT5UKbsaxWXtmditwBog2kj
         mG+UpFOtJlmHfEj9OnhlflK7VkSa4IwiHrtefr6t2TjS0Z/7tHVdubGOGaeU37hgl3Qz
         vhCKi5cuwhxTNMGHEb77PRgYv1u5bwz9GKB/C52Oa+RdVPPZKBUlIhcZOinVLVEn+MED
         tj/oJ/pZF2O43Wc27lx+cCvuW2MTVh0p3QefdbQETJOBc3pYimqTlCZb5StwuIsUAqWj
         IXAQ==
X-Gm-Message-State: AOAM530+xsiAiK+KAfvJRZ+Bal2Ucje5AeuU1058cRz/ZpEnOdb2HU8p
        83klJN6k67V5X1WryKmBwofwZ9Qo8qA=
X-Google-Smtp-Source: ABdhPJwFuW5KiwDfT9CFQ8B8dHj6PRcgdeTjXTDRHCfOcXGgBBC836Y99GlghhYiC3QaHdxoAm7qF8zS850=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:9064:adcd:ab38:7d29])
 (user=haoluo job=sendgmr) by 2002:a25:504c:: with SMTP id e73mr941593ybb.247.1639701137448;
 Thu, 16 Dec 2021 16:32:17 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:31:50 -0800
In-Reply-To: <20211217003152.48334-1-haoluo@google.com>
Message-Id: <20211217003152.48334-8-haoluo@google.com>
Mime-Version: 1.0
References: <20211217003152.48334-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH bpf-next v2 7/9] bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        bpf@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tag the return type of {per, this}_cpu_ptr with RDONLY_MEM. The
returned value of this pair of helpers is kernel object, which
can not be updated by bpf programs. Previously these two helpers
return PTR_OT_MEM for kernel objects of scalar type, which allows
one to directly modify the memory. Now with RDONLY_MEM tagging,
the verifier will reject programs that write into RDONLY_MEM.

Fixes: 63d9b80dcf2c ("bpf: Introducte bpf_this_cpu_ptr()")
Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/helpers.c  |  4 ++--
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c49dc5cbe0a7..6a65e2a62b01 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -682,7 +682,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
 	.func		= bpf_per_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL,
+	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 	.arg2_type	= ARG_ANYTHING,
 };
@@ -695,7 +695,7 @@ BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
 const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
 	.func		= bpf_this_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID,
+	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | MEM_RDONLY,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 543e729fa3cc..b9453413d1d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4334,15 +4334,30 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				mark_reg_unknown(env, regs, value_regno);
 			}
 		}
-	} else if (reg->type == PTR_TO_MEM) {
+	} else if (base_type(reg->type) == PTR_TO_MEM) {
+		bool rdonly_mem = type_is_rdonly_mem(reg->type);
+
+		if (type_may_be_null(reg->type)) {
+			verbose(env, "R%d invalid mem access '%s'\n", regno,
+				reg_type_str(env, reg->type));
+			return -EACCES;
+		}
+
+		if (t == BPF_WRITE && rdonly_mem) {
+			verbose(env, "R%d cannot write into rdonly %s\n",
+				regno, reg_type_str(env, reg->type));
+			return -EACCES;
+		}
+
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
 			verbose(env, "R%d leaks addr into mem\n", value_regno);
 			return -EACCES;
 		}
+
 		err = check_mem_region_access(env, regno, off, size,
 					      reg->mem_size, false);
-		if (!err && t == BPF_READ && value_regno >= 0)
+		if (!err && value_regno >= 0 && (t == BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
@@ -6589,6 +6604,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
 			regs[BPF_REG_0].mem_size = tsize;
 		} else {
+			/* MEM_RDONLY may be carried from ret_flag, but it
+			 * doesn't apply on PTR_TO_BTF_ID. Fold it, otherwise
+			 * it will confuse the check of PTR_TO_BTF_ID in
+			 * check_mem_access().
+			 */
+			ret_flag &= ~MEM_RDONLY;
+
 			regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
 			regs[BPF_REG_0].btf = meta.ret_btf;
 			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
@@ -9390,7 +9412,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		mark_reg_known_zero(env, regs, insn->dst_reg);
 
 		dst_reg->type = aux->btf_var.reg_type;
-		switch (dst_reg->type) {
+		switch (base_type(dst_reg->type)) {
 		case PTR_TO_MEM:
 			dst_reg->mem_size = aux->btf_var.mem_size;
 			break;
@@ -11610,7 +11632,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			err = -EINVAL;
 			goto err_put;
 		}
-		aux->btf_var.reg_type = PTR_TO_MEM;
+		aux->btf_var.reg_type = PTR_TO_MEM | MEM_RDONLY;
 		aux->btf_var.mem_size = tsize;
 	} else {
 		aux->btf_var.reg_type = PTR_TO_BTF_ID;
-- 
2.34.1.173.g76aa8bc2d0-goog

