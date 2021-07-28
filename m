Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AAD3D93E5
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 19:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhG1RF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 13:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhG1RFs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBA4C06179B
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id v21so5784526ejg.1
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 10:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZCZN43jWD2vq/l1OsMAXPbnAOZR2i3qxBbDBOhKuvZw=;
        b=DuCrJsKBuypqmT6k6/pckBl6VrsGUvttIq1j0LlVRJYUz0UdaLgmaWvCwZEdevSQk/
         tXISoLlq0w+APUt9rSLUjb6bZrgiVayuDwidUaU/gQGm9O+F5E8KAIR7q8d2yC7OamxF
         c2DgRDYFyVrsM3O3ISy46QI/v6PnZGcbcDy4AEzaJWEYBqm/r+xSBUVCUhqsDYREkNWj
         pTk2Cg7GwO+Ak12hDX9Gw7w7DUeSwfLE+nPeHkKLSVNumL9jN/BV+UFTu9NXeg+++w8f
         lLJJIvjZGmxfxDf5c+kBFGdm7CbgtuRAtAt+OvkF5EwwBVgeHw7mXh6r1LoYEkkbNsHu
         7E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCZN43jWD2vq/l1OsMAXPbnAOZR2i3qxBbDBOhKuvZw=;
        b=JUx/XPfexVxbFgaqKwXTM2234mU2/VpsFOtjNfzfDZqfLb++LiYdW/bF4yOfaxFKLh
         iDIQM0GNaHsDGGomTy534KHvd5rC5Vgees+lYzQ3ketlH5TMBwiwY6QQ1FUpHoOf0M1b
         7jkMxS1iTR0xZetReUtlcDDKR4NwW9hqtWxUsyBjTla0KDYhSH15boxAGwNJ2AgmL+6Q
         uzReaG1f4knfPn1jp+W0xGFnmLZIOoAXWM9wl1NYAhiEQCU/n9xh7KAOjnJkdyqOM7SO
         q9f/RUNy1Dejw9AEWAAJ2eqsunQ0Ml4+uXBj8ndVdkWa0Jmw1EG8+rXUewn39S5u7nze
         DuiA==
X-Gm-Message-State: AOAM5313H5jxXuJQbUDqRV0aUd3wGHy9JV8PuwiyPwvaFAmerCGApYni
        3ChMVT7jg0nWnrUR1iwQ3LqzcQ==
X-Google-Smtp-Source: ABdhPJwdczx4mUDshXzCLeIiyhVoeUB3nVSaGH5jtctQva7JWfmKSMpjVChrqDK7BlspnwHAgcte/A==
X-Received: by 2002:a17:906:c087:: with SMTP id f7mr417156ejz.487.1627491945178;
        Wed, 28 Jul 2021 10:05:45 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bd24sm139349edb.56.2021.07.28.10.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:05:44 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 14/14] bpf/tests: Add tail call test suite
Date:   Wed, 28 Jul 2021 19:05:02 +0200
Message-Id: <20210728170502.351010-15-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While BPF_CALL instructions were tested implicitly by the cBPF-to-eBPF
translation, there has not been any tests for BPF_TAIL_CALL instructions.
The new test suite includes tests for tail call chaining, tail call count
tracking and error paths. It is mainly intended for JIT development and
testing.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 lib/test_bpf.c | 249 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index af5758151d0a..222d454b2ed4 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -8981,8 +8981,249 @@ static __init int test_bpf(void)
 	return err_cnt ? -EINVAL : 0;
 }
 
+struct tail_call_test {
+	const char *descr;
+	struct bpf_insn insns[MAX_INSNS];
+	int result;
+	int stack_depth;
+};
+
+/*
+ * Magic marker used in test snippets for tail calls below.
+ * BPF_LD/MOV to R2 and R2 with this immediate value is replaced
+ * with the proper values by the test runner.
+ */
+#define TAIL_CALL_MARKER 0x7a11ca11
+
+/* Special offset to indicate a NULL call target */
+#define TAIL_CALL_NULL 0x7fff
+
+#define TAIL_CALL(offset)			       \
+	BPF_LD_IMM64(R2, TAIL_CALL_MARKER),	       \
+	BPF_RAW_INSN(BPF_ALU | BPF_MOV | BPF_K, R3, 0, \
+		     offset, TAIL_CALL_MARKER),	       \
+	BPF_JMP_IMM(BPF_TAIL_CALL, 0, 0, 0)
+
+/*
+ * Tail call tests. Each test case may call any other test in the table,
+ * including itself, specified as a relative index offset from the calling
+ * test. The index TAIL_CALL_NULL can be used to specify a NULL target
+ * function to test the JIT error path.
+ */
+static struct tail_call_test tail_call_tests[] = {
+	{
+		"Tail call leaf",
+		.insns = {
+			BPF_ALU64_REG(BPF_MOV, R0, R1),
+			BPF_ALU64_IMM(BPF_ADD, R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.result = 1,
+	},
+	{
+		"Tail call 2",
+		.insns = {
+			BPF_ALU64_IMM(BPF_ADD, R1, 2),
+			TAIL_CALL(-1),
+			BPF_ALU64_IMM(BPF_MOV, R0, -1),
+			BPF_EXIT_INSN(),
+		},
+		.result = 3,
+	},
+	{
+		"Tail call 3",
+		.insns = {
+			BPF_ALU64_IMM(BPF_ADD, R1, 3),
+			TAIL_CALL(-1),
+			BPF_ALU64_IMM(BPF_MOV, R0, -1),
+			BPF_EXIT_INSN(),
+		},
+		.result = 6,
+	},
+	{
+		"Tail call 4",
+		.insns = {
+			BPF_ALU64_IMM(BPF_ADD, R1, 4),
+			TAIL_CALL(-1),
+			BPF_ALU64_IMM(BPF_MOV, R0, -1),
+			BPF_EXIT_INSN(),
+		},
+		.result = 10,
+	},
+	{
+		"Tail call error path, max count reached",
+		.insns = {
+			BPF_ALU64_IMM(BPF_ADD, R1, 1),
+			BPF_ALU64_REG(BPF_MOV, R0, R1),
+			TAIL_CALL(0),
+			BPF_EXIT_INSN(),
+		},
+		.result = MAX_TAIL_CALL_CNT + 1,
+	},
+	{
+		"Tail call error path, NULL target",
+		.insns = {
+			BPF_ALU64_IMM(BPF_MOV, R0, -1),
+			TAIL_CALL(TAIL_CALL_NULL),
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.result = 1,
+	},
+	{
+		/* Must be the last test */
+		"Tail call error path, index out of range",
+		.insns = {
+			BPF_ALU64_IMM(BPF_MOV, R0, -1),
+			TAIL_CALL(1),    /* Index out of range */
+			BPF_ALU64_IMM(BPF_MOV, R0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.result = 1,
+	},
+};
+
+static void __init destroy_tail_call_tests(struct bpf_array *progs)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tail_call_tests); i++)
+		if (progs->ptrs[i])
+			bpf_prog_free(progs->ptrs[i]);
+	kfree(progs);
+}
+
+static __init int prepare_tail_call_tests(struct bpf_array **pprogs)
+{
+	struct bpf_array *progs;
+	int ntests = ARRAY_SIZE(tail_call_tests);
+	int which, err;
+
+	/* Allocate the table of programs to be used for tall calls */
+	progs = kzalloc(sizeof(*progs) + (ntests + 1) * sizeof(progs->ptrs[0]),
+			GFP_KERNEL);
+	if (!progs)
+		goto out_nomem;
+
+	/* Create all eBPF programs and populate the table */
+	for (which = 0; which < ntests; which++) {
+		struct tail_call_test *test = &tail_call_tests[which];
+		struct bpf_prog *fp;
+		int len, i;
+
+		/* Compute the number of program instructions */
+		for (len = 0; len < MAX_INSNS; len++) {
+			struct bpf_insn *insn = &test->insns[len];
+
+			if (len < MAX_INSNS - 1 &&
+			    insn->code == (BPF_LD | BPF_DW | BPF_IMM))
+				len++;
+			if (insn->code == 0)
+				break;
+		}
+
+		/* Allocate and initialize the program */
+		fp = bpf_prog_alloc(bpf_prog_size(len), 0);
+		if (!fp)
+			goto out_nomem;
+
+		fp->len = len;
+		fp->type = BPF_PROG_TYPE_SOCKET_FILTER;
+		fp->aux->stack_depth = test->stack_depth;
+		memcpy(fp->insnsi, test->insns, len * sizeof(struct bpf_insn));
+
+		/* Relocate runtime tail call offsets and addresses */
+		for (i = 0; i < len; i++) {
+			struct bpf_insn *insn = &fp->insnsi[i];
+			int target;
+
+			if (insn->imm != TAIL_CALL_MARKER)
+				continue;
+
+			switch (insn->code) {
+			case BPF_LD | BPF_DW | BPF_IMM:
+				if (insn->dst_reg == R2) {
+					insn[0].imm = (u32)(long)progs;
+					insn[1].imm = ((u64)(long)progs) >> 32;
+				}
+				break;
+
+			case BPF_ALU | BPF_MOV | BPF_K:
+			case BPF_ALU64 | BPF_MOV | BPF_K:
+				if (insn->off == TAIL_CALL_NULL)
+					target = ntests;
+				else
+					target = which + insn->off;
+				if (insn->dst_reg == R3)
+					insn->imm = target;
+				break;
+			}
+		}
+
+		fp = bpf_prog_select_runtime(fp, &err);
+		if (err)
+			goto out_err;
+
+		progs->ptrs[which] = fp;
+	}
+
+	/* The last entry contains a NULL program pointer */
+	progs->map.max_entries = ntests + 1;
+	*pprogs = progs;
+	return 0;
+
+out_nomem:
+	err = -ENOMEM;
+
+out_err:
+	if (progs)
+		destroy_tail_call_tests(progs);
+	return err;
+}
+
+static __init int test_tail_calls(struct bpf_array *progs)
+{
+	int i, err_cnt = 0, pass_cnt = 0;
+	int jit_cnt = 0, run_cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(tail_call_tests); i++) {
+		struct tail_call_test *test = &tail_call_tests[i];
+		struct bpf_prog *fp = progs->ptrs[i];
+		u64 duration;
+		int ret;
+
+		cond_resched();
+
+		pr_info("#%d %s ", i, test->descr);
+		if (!fp) {
+			err_cnt++;
+			continue;
+		}
+		pr_cont("jited:%u ", fp->jited);
+
+		run_cnt++;
+		if (fp->jited)
+			jit_cnt++;
+
+		ret = __run_one(fp, NULL, MAX_TESTRUNS, &duration);
+		if (ret == test->result) {
+			pr_cont("%lld PASS", duration);
+			pass_cnt++;
+		} else {
+			pr_cont("ret %d != %d FAIL", ret, test->result);
+			err_cnt++;
+		}
+	}
+
+	pr_info("%s: Summary: %d PASSED, %d FAILED, [%d/%d JIT'ed]\n",
+		__func__, pass_cnt, err_cnt, jit_cnt, run_cnt);
+
+	return err_cnt ? -EINVAL : 0;
+}
+
 static int __init test_bpf_init(void)
 {
+	struct bpf_array *progs = NULL;
 	int ret;
 
 	ret = prepare_bpf_tests();
@@ -8994,6 +9235,14 @@ static int __init test_bpf_init(void)
 	if (ret)
 		return ret;
 
+	ret = prepare_tail_call_tests(&progs);
+	if (ret)
+		return ret;
+	ret = test_tail_calls(progs);
+	destroy_tail_call_tests(progs);
+	if (ret)
+		return ret;
+
 	return test_skb_segment();
 }
 
-- 
2.25.1

