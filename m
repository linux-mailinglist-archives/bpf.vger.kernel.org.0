Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5404C8471
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 07:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiCAG6w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 01:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiCAG6r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 01:58:47 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2625BD32
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:58:06 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id n15so10473592plf.4
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eXjcR7Icghp6sotA+/Zx1h+ivXAAlCN24N9oblyqRE0=;
        b=VWTmRsxC0cZfY5CYYta9dt20oa5OF1qVwQcSfBxhS2CVFdehnoJplKie87f++kOGa3
         cgsJQB/h7nb9yQenJX2u/nwK/Lr9H4cO6CveUGnYMN2QoDaf/NhPM0sM/0rvbq2usZCb
         GeTcH/EImk359vmv6H/f8diYIFA/Z3BRaYFLrIKMBq3p1x3qICqwwneTMTFoH+cucncr
         N02XNMsqkxqI2EZhbsx6ZbA8q7DC/WUMtMhxCwetGjttYxyk48kd8W7NrK7Z1zh3VJde
         yiV50vGTdb3GvQQ1HFS7D/o03droRVdoWbhk2eLAJ/OR8NPj8oCCrrPJNLcwUbSS2HdD
         BPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eXjcR7Icghp6sotA+/Zx1h+ivXAAlCN24N9oblyqRE0=;
        b=U4AatON6ZGhrFyrIR7nyDlhlk5zPoJEmORsjgAU2heu32Q2VcTa4ShiPi6J7eVlr6U
         +WsEA3+eYAOrwaw62xme8uvKMQLb4StMoZqbjRKEwsmdn/A++zqZ4x7W2cVn9x2vjxcW
         0HmjB6iBbTHOPwj32Kx1YGDex45eOz310KIxMEgu4/4mTZFZkWvDQEPTND9LkaX3vEpf
         1Y62Il7Y3MLCWDl0ZkwKKV9rtaSkoDA9ANrxvpTtCvPjisYfqzpH4Pkl1gI0sIMEACN+
         CsQDCElIRzirGbOKXbA2VJYCAtYYAjQ5usd7SjMmqi721SF63LjeTlkn2+fO2aGUSZRn
         qNCg==
X-Gm-Message-State: AOAM5334+xlwRRXvVeAUiHMPByLpZ6Mtmyx/wlErIVmTK9VTU+uuRJs2
        NjePvhTq1HEsEqlAxWJr33mENJ9wrMw=
X-Google-Smtp-Source: ABdhPJwZquv4/ji1IsANcose1Lqz4AjLkmv9y0+Fn0k+tgPDsrwUt7oOVDKN1WZBAnnQX1HRGnhJ+A==
X-Received: by 2002:a17:902:a989:b0:14f:969b:f6b6 with SMTP id bh9-20020a170902a98900b0014f969bf6b6mr23427377plb.15.1646117886132;
        Mon, 28 Feb 2022 22:58:06 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id y191-20020a6264c8000000b004e1bf2f580csm15346371pfb.78.2022.02.28.22.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:58:05 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 6/6] selftests/bpf: Add tests for kfunc register offset checks
Date:   Tue,  1 Mar 2022 12:27:45 +0530
Message-Id: <20220301065745.1634848-7-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301065745.1634848-1-memxor@gmail.com>
References: <20220301065745.1634848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5131; h=from:subject; bh=5iozdXUkLcbjPQoFsisOsECXFVjTfjKwcg0XHc5o0Vs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiHcO1y4ypDdZlJ63LXxM6v6AsVA9EMwyX6e3HXrc7 Ubs4wxiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYh3DtQAKCRBM4MiGSL8RysWeEA CJYFh2j9n9jO8vxX2VAgg33qg56lsvxiRTsArS63xLQDrvgNTKXSQCEjJK3yeYTw1pasEIYV57jhOT UrJwB8+t19DWyDz1XU0LUPBwVFrbrm6kKR1pLFh+bh0pB/7hme31NivPH0Rwc2elqSBH0MJwMSzMV/ 9MEtOh3zZAxp6A0lo3XoH3+beJ7YegtkiUow/haT5LqH3WWJz3U11C365fNUsgI5kvdwoHAkJdL8Ru 4VW9+65XEINpyebpbh4/h+LVjI2mmcU6VGZg63hn/8ZBEdF2RL6BHQasD8rim+h2BmCIRmqmXGEAia FWu2wI5eiPngqEe3osKpjFNdGryPwcfB+UUO/NhUnqMCW30fGG6Co8CvRf6mHvP3CNGSf1obsw+O4g SJdS/5RfzZ1zsjrhH+GjpNosplE6SLADqR4T8VYQ1Qqr4WyqzViNIXp98RdDhf5aKs+cIVsN3A+Gqc z5w0VPhOps/mvXKUuP/dYtXreGo5gIXi+uyq7ua1weUNWrQt9XHzJzX5QcI/C114HcCb0clfKwmJUX uv5t+mIMKhwMxSKKf1xDSgiSM5MzniXk4teLkzIbqf04nvjKDKt0jV/lM8hue+QDBvw+PfiadBq12/ iIcAwNtodR6JOu3qAi5kEWLzoXWaOQNgXrRx/vIExQeonp+do3vtwnuT5gQg==
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
 tools/testing/selftests/bpf/verifier/calls.c | 82 ++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f08034500813..21e1c2d64f25 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -265,9 +265,14 @@ struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
 	return sk;
 }
 
+struct prog_test_member {
+	unsigned long c;
+};
+
 struct prog_test_ref_kfunc {
 	int a;
 	int b;
+	struct prog_test_member memb;
 	struct prog_test_ref_kfunc *next;
 };
 
@@ -290,6 +295,10 @@ noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 {
 }
 
+noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
+{
+}
+
 struct prog_test_pass1 {
 	int x0;
 	struct {
@@ -374,6 +383,7 @@ BTF_ID(func, bpf_kfunc_call_test2)
 BTF_ID(func, bpf_kfunc_call_test3)
 BTF_ID(func, bpf_kfunc_call_test_acquire)
 BTF_ID(func, bpf_kfunc_call_test_release)
+BTF_ID(func, bpf_kfunc_call_memb_release)
 BTF_ID(func, bpf_kfunc_call_test_pass_ctx)
 BTF_ID(func, bpf_kfunc_call_test_pass1)
 BTF_ID(func, bpf_kfunc_call_test_pass2)
@@ -391,6 +401,7 @@ BTF_SET_END(test_sk_acquire_kfunc_ids)
 
 BTF_SET_START(test_sk_release_kfunc_ids)
 BTF_ID(func, bpf_kfunc_call_test_release)
+BTF_ID(func, bpf_kfunc_call_memb_release)
 BTF_SET_END(test_sk_release_kfunc_ids)
 
 BTF_SET_START(test_sk_ret_null_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 0a8ea60c2a80..985183d1310a 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -115,6 +115,88 @@
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
+	.errstr = "R1 with ref_obj_id=2 must have zero offset when passed to release kfunc",
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
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -4),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_test_acquire", 3 },
+		{ "bpf_kfunc_call_test_release", 8 },
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

