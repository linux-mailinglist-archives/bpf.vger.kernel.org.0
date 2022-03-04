Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F2D4CE069
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 23:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiCDWsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 17:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiCDWsD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 17:48:03 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2661390EE
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 14:47:14 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id k1so8811707pfu.2
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 14:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AbTUUShylVFqv8PNASQ39yGb4t87bnK0wBdV7ZmZl0k=;
        b=pwPWMk98KuFcXw67ZDclJ6TEs7vPcpd/xqVqeAm8Y4GaD09RaS1pBaI7dx1Oo6N1RG
         3IGqYCVvn5Oh4+2HqzpgAkHo3uYNtKVmZna/V7BVQPUfDIMfS17iibYBQ7j+inpxrJEa
         xNaASOCvjApHVQut54GECzvcojIV3z2WoEaZ+cUw/iC7bgMDENwBF+AybXy+rh166lOY
         7P27l44SejRt+z4QB6N3HG7hwFTpqvDr559CZGHTNQ7Wi73bcSIzuuNWCwu1jIKafhz1
         aZoP35SF+3MbvZqDxOEkN3GrariZeAukLfS3rZKZxSEBU+z/W47dLVAK6AZeZvb1qN7F
         w8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AbTUUShylVFqv8PNASQ39yGb4t87bnK0wBdV7ZmZl0k=;
        b=2HW1CNf3CDvymZg17J1aLtGPZy6Y9BhsoXrPEZMoeJjf/MRirTDHlYH10oLkCe8Co6
         U2iM3PvjwslHEl7s3pbziqB7CoLBvyIwdf8COtRYgRRl9AZxuWucyaIf0Wi1xNWS91M6
         oncDeOmGHWqwPsf3Vj16k9EV4Y1zBjVrH40ZlRv9eBud8FuSD7XjNxxOKWlBiPYrDD3P
         DOnxnphLYGHp4M/hl28eAXqybSmAh2nkbde9vV0ZUQWoLm3y56h/hw86K6mH3QAvIJe0
         yHwsMapJBuSv8U9+eQiORlaUbTREZDd/uIWtTwelEs1M9Q7XuS/JswDIiaRuQxaISy2e
         fgMQ==
X-Gm-Message-State: AOAM532ucAKb+fivynri3Swxot8bXlR9L5V7s0iPQytTdnxg/9E8IDQJ
        YjyXqPiR4eAx+3d4FMdKaQh0tJtMx0U=
X-Google-Smtp-Source: ABdhPJzibqE+4kQgBn2eiyggt0czp1D9omrgAhvEbrjRUfRhF2IJGbL7iRPojjujDAXGyimbCX6JVg==
X-Received: by 2002:a63:904a:0:b0:340:87e0:f640 with SMTP id a71-20020a63904a000000b0034087e0f640mr483679pge.171.1646434034141;
        Fri, 04 Mar 2022 14:47:14 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id f13-20020a056a001acd00b004f0f9a967basm6864079pfv.100.2022.03.04.14.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:47:13 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: Add tests for kfunc register offset checks
Date:   Sat,  5 Mar 2022 04:16:45 +0530
Message-Id: <20220304224645.3677453-9-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304224645.3677453-1-memxor@gmail.com>
References: <20220304224645.3677453-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5152; h=from:subject; bh=Go2z7nmgszJ3T+xxLLZpmMr9ueSJmegUYyYAIfn4Ai4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIpasVZ4uA2UiHesiISA1E3cpHw/PDGGq/DiUEJmM pFBabWOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiKWrAAKCRBM4MiGSL8Ryq/4D/ 92ag5qnfeneyV8CT9U6SeJgWttGr539CKSOmyHrXSLCIbWgN8blwo3TYMddP5moP5l1TXqsnXn82gV N8fsZNrbmyreHpRYpC66raWh96ctN76nZzgQOMfB21yHd3SjSXLECl2MU4n8a70sa3Q60EGZJyB0hR vpB0xnwXyTI6Qew/qaCBZyCWttySCzvM16YU9BkKwD6se2mmF3RpW2+3VsqE0+Th9gjLKekpReZhdt pwRmu8GcN0lxNrCQtqMrWAQeZdZj6UVFYg/CQj/VDpNhaawMZZWAuGPWD6Z6w+iIBEUziSlMK6ddgO OvJq3vELsagSq9DG63apG+kGiVl7GeBpG6S5pXQo0xqGtW82NUHJNM1wopZ2i5HrUuewjVw2wLgABS dr1hK23V83Y116DnvfDu2ZuoJSNJohjmQrlzYVZy8vnvLX9pcRFKsF+0u0HeZkdp30sJufsLdyoVoW 8wtRZ06Mxy7R2Ysf3CBxvaWDgbU0YUhfdJ23Vfy0vupqMw3Yx7HKUQHQLwi0Ordk5ngJ4KJfkLB8dS ME7foyceCbB4w1bF8rcrcVZTEbg+mRjIBQJR/gLVhFR3I8zHMGvQF+EOFSwSMKk4xpgFRYkDUgX+/1 YCla1llm77xXJjPbFMjo6wB5DR2OKW9ifJvbCC9Axi/J9guB6nhQDN9BxfAw==
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

