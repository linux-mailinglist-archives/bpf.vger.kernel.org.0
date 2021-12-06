Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5246AE5D
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 00:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356640AbhLFX0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 18:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350577AbhLFX0P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 18:26:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C81C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:22:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v20-20020a25fc14000000b005c2109e5ad1so22312673ybd.9
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 15:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YcoHax9aTzyg0HHx/swthK6qlTzcqVjxc1YLO73Lw+0=;
        b=pNrs9+S1Sc8bOThQNaMB5bkouSyCvQqAsNeS2vQo+RhNbNfM5MtbH0EVUFZOcHOypm
         Sb/tsepGQ9Lm9PZU0JP6FnXPyR2xXtJexxmwG4w+DCLsxVvIMxsS4qDnpEQJ588QMSqn
         B6Rts6FsDPSK4nu7qTDkT3Jb8J2sWSxEsZEUCgaI85JRnOhzxMrr5Qz3NlAvIhNP2zXf
         pT/ScTr2pXwNvQcBl2hF0wu3e27xaAkCbmaf91AUVKprXyPvNymLd8oYcUXTAT/GcBur
         1kEFwkEpgYKoeT5qndq/YeDSO/HEruoBOXsuRf3rPaMqvmTt4IhjBJiAj9JFCAFULPic
         lECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YcoHax9aTzyg0HHx/swthK6qlTzcqVjxc1YLO73Lw+0=;
        b=vxwTmdTKwSpZHWBvrj1tAXCvEZbQuA5Abm2BRWAPtlr3gTFtudLTtAg3B2S2wUFGIm
         tydtsfWVGTZi+ISVeuZomg1HV+jLMsRsBuhiuE3OkHUN2yWA0al78v35l+HeTLE8siAo
         y/l2LmegoN5wAcpWyideyx56uX5lVHjM0Z9GJ2RYHJ/ZT33/gxiiMrZHMjz5pjDeGOqG
         3L+lL9vCZfzilRGhfgnMaWiPASh2lUKuaP6DagCrEPb+PxAHf/YRwnYm3URX91sijj0n
         BGMg55YLNtdQlE9xrCAOJ+RqY72L7441e0B9WEdJlOQtqpyLHAlVMrAu0e+ruSBye/QK
         7rOw==
X-Gm-Message-State: AOAM531ij2/ppmy2ZElctHjTmxo0TsIewIjjgWKhsSGx2/JP2ZpKF49J
        VEe0QU9ZFxOVN0/rxDYf1MieKI44kM4=
X-Google-Smtp-Source: ABdhPJw+JZn6sbXngzM7Z5/Q2I4hXagNXh+wlLkZ927ABMuVPK38zVc6jCwMBmYi/YZpsIsTSnk2dsuAGr8=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:2977:d88c:3c3:c52a])
 (user=haoluo job=sendgmr) by 2002:a25:f818:: with SMTP id u24mr45074414ybd.582.1638832965412;
 Mon, 06 Dec 2021 15:22:45 -0800 (PST)
Date:   Mon,  6 Dec 2021 15:22:25 -0800
In-Reply-To: <20211206232227.3286237-1-haoluo@google.com>
Message-Id: <20211206232227.3286237-8-haoluo@google.com>
Mime-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH bpf-next v1 7/9] bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
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
the verifier will reject programs that writes into RDONLY_MEM.

Fixes: 63d9b80dcf2c ("bpf: Introduce bpf_this_cpu_ptr()")
Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/helpers.c  |  4 ++--
 kernel/bpf/verifier.c | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 293d9314ec7f..a5e349c9d3e3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -667,7 +667,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
 	.func		= bpf_per_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL,
+	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 	.arg2_type	= ARG_ANYTHING,
 };
@@ -680,7 +680,7 @@ BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
 const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
 	.func		= bpf_this_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID,
+	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | MEM_RDONLY,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f8b804918c35..44af65f07a82 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4296,16 +4296,32 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				mark_reg_unknown(env, regs, value_regno);
 			}
 		}
-	} else if (reg->type == PTR_TO_MEM) {
+	} else if (base_type(reg->type) == PTR_TO_MEM) {
+		bool rdonly_mem = type_is_rdonly_mem(reg->type);
+
+		if (type_may_be_null(reg->type)) {
+			verbose(env, "R%d invalid mem access '%s'\n", regno,
+				reg_type_str(reg->type));
+			return -EACCES;
+		}
+
+		if (t == BPF_WRITE && rdonly_mem) {
+			verbose(env, "R%d cannot write into rdonly %s\n",
+				regno, reg_type_str(reg->type));
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
-			mark_reg_unknown(env, regs, value_regno);
+		if (!err && value_regno >= 0)
+			if (t == BPF_READ || rdonly_mem)
+				mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
@@ -6534,6 +6550,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -9335,7 +9358,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		mark_reg_known_zero(env, regs, insn->dst_reg);
 
 		dst_reg->type = aux->btf_var.reg_type;
-		switch (dst_reg->type) {
+		switch (base_type(dst_reg->type)) {
 		case PTR_TO_MEM:
 			dst_reg->mem_size = aux->btf_var.mem_size;
 			break;
@@ -11479,7 +11502,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			err = -EINVAL;
 			goto err_put;
 		}
-		aux->btf_var.reg_type = PTR_TO_MEM;
+		aux->btf_var.reg_type = PTR_TO_MEM | MEM_RDONLY;
 		aux->btf_var.mem_size = tsize;
 	} else {
 		aux->btf_var.reg_type = PTR_TO_BTF_ID;
-- 
2.34.1.400.ga245620fadb-goog

