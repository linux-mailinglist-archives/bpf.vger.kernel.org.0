Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513C14CCA7A
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 01:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiCDAGY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 19:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiCDAGX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 19:06:23 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A00ED945
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 16:05:37 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id n15so6250856plf.4
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 16:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AbTUUShylVFqv8PNASQ39yGb4t87bnK0wBdV7ZmZl0k=;
        b=AgC4gv0xEGPpvNODLe7/Yu0cSvh5zfO050laF+QwEMJ3j/3gFCIDE+VXiHQGvxJWcA
         WxMMm6XjzM2xKlNn6ie940IICeRHAQuRBua5IAANu1HduuFL7ra/IP8nLQpiKVILrqeP
         75EhxcD9XrcKy5hbfCWKdAb8/KUxEvDAISnXv+SgFrB1IAQS90ZOkPS3EqAT2RM8Z7zo
         z1unoW4Htnkk5njBX4p2B1356e3G1wZgTjbESMsbT08PX0S91/W+Yt+XbQ0T6Tj+bbCR
         gCg7tUmA1yjeboWBwG3SAnBQOYB0QxeEjKqzXlwT3RU9guG2/uwv6FXlikn7hgm3zyDa
         1daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AbTUUShylVFqv8PNASQ39yGb4t87bnK0wBdV7ZmZl0k=;
        b=1T/Z5VyS58Qu63vy9yJJYYsHey4AskU0+rFj324qunFhkemQdj0WxTMM1tt4T/8RvY
         zFUJ1dY+vuWdN98Y0mt0BI1w9KLAhR/l5VbWNZcjCFqamM7ZmPOfchOBxaLkTPaaJdJO
         7IyP9y+F7mk83FHUb8Hd2UfVG2UoS6FG51XrULDqYJOLICVt1QNA0DnWxEspDVJJvB4q
         3aBZZWcEuUTFNUhn/LW3I+MHwYB1seK1FI+J6gbssm2oTgg4U0pyIDiGOQrRZBoC9Rg+
         s398llAVtbX4y12fzsWZeK8i/eSzAe/VS4kgcMDbm3GxTm6RtpOPx1yBZkSz1ciZD5dS
         UrWw==
X-Gm-Message-State: AOAM530mXRoXi3XKy3iGwGlk6/X3gaoSJRtgHd18bd87x4Ql7TLr0Ssm
        QZMvhefDSu+EoetIMyD9pcHOUe6PlYk=
X-Google-Smtp-Source: ABdhPJx7d17TlYWVHpYNZZm7Lv4jPPtBwMAoySr+xvR8TmHECEr06G47AOe61gpj+6KSg3sAlhZA1w==
X-Received: by 2002:a17:902:b94b:b0:14e:f1a8:9b99 with SMTP id h11-20020a170902b94b00b0014ef1a89b99mr39324476pls.28.1646352336888;
        Thu, 03 Mar 2022 16:05:36 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm9174028pjn.14.2022.03.03.16.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:05:36 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3 8/8] selftests/bpf: Add tests for kfunc register offset checks
Date:   Fri,  4 Mar 2022 05:35:08 +0530
Message-Id: <20220304000508.2904128-9-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304000508.2904128-1-memxor@gmail.com>
References: <20220304000508.2904128-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5152; h=from:subject; bh=Go2z7nmgszJ3T+xxLLZpmMr9ueSJmegUYyYAIfn4Ai4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIVd/VZ4uA2UiHesiISA1E3cpHw/PDGGq/DiUEJmM pFBabWOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiFXfwAKCRBM4MiGSL8RyuAAD/ 44GFPkpDEDnYcMLmVzjiPCPNd/iYAY0mDXiSBsnLwKxu1z929N69MOo0dlg2zuFldYxq4WC0aBQb3o XH4PoyUJoZNaAhlW+E6O4fx+HvQXDVOm6cPv2NNTNuFjYbwz0mfAnTKHjK4udChzBFN8GmeoCpBHP4 vhWdrRbP7aRK+F47jO740QJ9gNaqAvVsE7eyvTTJ2OyZdTXe4cHFTx1qrcUlW+SBeT201dBzjdRDmS mC++isS9/kqAVhur2Nz7ntG4DxAGoZYje5aeLmMRzbXlZIIVopQtO0pAsyGtwM40Tl62mCZ9W1tACN DxdX2K0hotghWUHukanfiV1yuKvtkwmuXD09X/KKeDVJqd3ioeB6eu8JXC2JCAdw5Z1N0v5qkNXnsH /SsjsY84DZgCoKip7xivBb99bX8qFbD4IYfzSEFacoVGo69QmdcyPngqRkwQIjogBaYVV+M4rIXL2L aosKFoqbFe3D8he6rrSj5L5kbzdH7WLO6qS4JTvdBInkOHgGvqxxxe13gv9Ct1rMOEhT3SckSxSUS5 F2SdBrKfFVaHgSMS/dgp3aiXaBLQixwWyTYrdAW1Ivq15IfkBQvStc+ahw9MJ7dGwJ1N29P1UvDoF+ au6YZd//T+a8aRr6hg1C+0HwI1ZDRxlny0cMssHBEsYL7evLptgjS4dDb8Yw==
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

Include a few verifier selftests that test against the problems being
fixed by previous commits, i.e. release kfunc always require
PTR_TO_BTF_ID fixed and var_off to be 0, and negative offset is not
permitted and returns a helpful error message.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/bpf/test_run.c                           | 11 +++
 tools/testing/selftests/bpf/verifier/calls.c | 83 ++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index fcc83017cd03..ba410b069824 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -270,9 +270,14 @@ struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
 	return sk;
 }
 
+struct prog_test_member {
+	u64 c;
+};
+
 struct prog_test_ref_kfunc {
 	int a;
 	int b;
+	struct prog_test_member memb;
 	struct prog_test_ref_kfunc *next;
 };
 
@@ -295,6 +300,10 @@ noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 {
 }
 
+noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
+{
+}
+
 struct prog_test_pass1 {
 	int x0;
 	struct {
@@ -379,6 +388,7 @@ BTF_ID(func, bpf_kfunc_call_test2)
 BTF_ID(func, bpf_kfunc_call_test3)
 BTF_ID(func, bpf_kfunc_call_test_acquire)
 BTF_ID(func, bpf_kfunc_call_test_release)
+BTF_ID(func, bpf_kfunc_call_memb_release)
 BTF_ID(func, bpf_kfunc_call_test_pass_ctx)
 BTF_ID(func, bpf_kfunc_call_test_pass1)
 BTF_ID(func, bpf_kfunc_call_test_pass2)
@@ -396,6 +406,7 @@ BTF_SET_END(test_sk_acquire_kfunc_ids)
 
 BTF_SET_START(test_sk_release_kfunc_ids)
 BTF_ID(func, bpf_kfunc_call_test_release)
+BTF_ID(func, bpf_kfunc_call_memb_release)
 BTF_SET_END(test_sk_release_kfunc_ids)
 
 BTF_SET_START(test_sk_ret_null_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index f890333259ad..2e03decb11b6 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -115,6 +115,89 @@
 		{ "bpf_kfunc_call_test_release", 5 },
 	},
 },
+{
+	"calls: invalid kfunc call: reg->off must be zero when passed to release kfunc",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = REJECT,
+	.errstr = "R1 must have zero offset when passed to release func",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_test_acquire", 3 },
+		{ "bpf_kfunc_call_memb_release", 8 },
+	},
+},
+{
+	"calls: invalid kfunc call: PTR_TO_BTF_ID with negative offset",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 16),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -4),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_test_acquire", 3 },
+		{ "bpf_kfunc_call_test_release", 9 },
+	},
+	.result_unpriv = REJECT,
+	.result = REJECT,
+	.errstr = "negative offset ptr_ ptr R1 off=-4 disallowed",
+},
+{
+	"calls: invalid kfunc call: PTR_TO_BTF_ID with variable offset",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_0, 4),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_2, 4, 3),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 3),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_test_acquire", 3 },
+		{ "bpf_kfunc_call_test_release", 9 },
+		{ "bpf_kfunc_call_test_release", 13 },
+		{ "bpf_kfunc_call_test_release", 17 },
+	},
+	.result_unpriv = REJECT,
+	.result = REJECT,
+	.errstr = "variable ptr_ access var_off=(0x0; 0x7) disallowed",
+},
 {
 	"calls: basic sanity",
 	.insns = {
-- 
2.35.1

