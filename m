Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578C740AAA8
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 11:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhINJUy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 05:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhINJUi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 05:20:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2A5C0613CF
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q3so18807841edt.5
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cnrIrM7g/uJKhfp+dzP29PUmgqyu/MxCbDo7R/V/lo=;
        b=zILMdvWaZpQbmnu84QnqgwxlGq3MvEn+WV9+Nuk6a3bURVSOhkXaLm7pDYVJhdSVFU
         EGskyxUO6xSjCYjk9n92yhP4hfOmNhNipUwLSVF46EUMcNDCEUWfMcUBFFMYDKu5TOxn
         PcpKAXDLrDPnAo08cyie7bEyV69dIK5euGbrHpGsoaVUiIF0i+/S6cs8bWG7zvLOs4rK
         IdJAao0Zzv2E55SeHcFiZZP4BlpYaXncTJKCvF99TVcMTKkHv3IR3eenUnZRygyh/Qn9
         RHpnzCO0VtfFi7FOMyv/GlSVJQwNfR4ExYLL4/6vjUvTeLT5seZVBHdNQD9kaRZtwfzV
         mSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cnrIrM7g/uJKhfp+dzP29PUmgqyu/MxCbDo7R/V/lo=;
        b=sdcXcL9u0DhAqyYNDXgMNJ5pRJeq0AfY2ijkzDWpzDSMaIJvNr7+U78AqyOF7R4onx
         6ErdJSIBR+V48qARWmUcY6/Kr8XSNyhlegP36jIWJPPu6ISmkSPGXmVohuQMl+ib0uyJ
         t1seHqDBu8RoomYR9UE8kUrTKXwS4SZOLHoUrBbFA9MKEU44wgFNiaTAdcEkjKC5qLbz
         qokUZnhAh35wfowWFtwZH7kcNqTxFMJVYKS/hA68kteVd0NYRxk7KrwCo/2AF2IpIBrQ
         BGoyhH5EySNTTk4Oa22Z6ZjuPNXORRXnHSDtB7UC5cLB5s09+tYSJCR5KbbTjjpAEIR2
         iHpQ==
X-Gm-Message-State: AOAM531kuYAMPGt+CdnxQ5z0kncC4clFdG9sO/1sXXldEMILdEMS8nfi
        5C/+VaG2w5PQUXGVXW29he2xgg==
X-Google-Smtp-Source: ABdhPJxbQJTk1TFZplzKCCUuWHgLiQ4RJ942jUDc6Lf6Yuiex98Who8KPgEfOD3ixlylqpruSUiYBQ==
X-Received: by 2002:a05:6402:646:: with SMTP id u6mr17838621edx.127.1631611158184;
        Tue, 14 Sep 2021 02:19:18 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id h10sm4615915ede.28.2021.09.14.02.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:17 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        paul@cilium.io, yangtiezhu@loongson.cn, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf v4 13/14] bpf/tests: Fix error in tail call limit tests
Date:   Tue, 14 Sep 2021 11:18:41 +0200
Message-Id: <20210914091842.4186267-14-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
References: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch fixes an error in the tail call limit test that caused the
test to fail on for x86-64 JIT. Previously, the register R0 was used to
report the total number of tail calls made. However, after a tail call
fall-through, the value of the R0 register is undefined. Now, all tail
call error path tests instead use context state to store the count.

Fixes: 874be05f525e ("bpf, tests: Add tail call test suite")
Reported-by: Paul Chaignon <paul@cilium.io>
Reported-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 7475abfd2186..ddb9a8089d2e 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -12179,10 +12179,15 @@ static __init int test_bpf(void)
 struct tail_call_test {
 	const char *descr;
 	struct bpf_insn insns[MAX_INSNS];
+	int flags;
 	int result;
 	int stack_depth;
 };
 
+/* Flags that can be passed to tail call test cases */
+#define FLAG_NEED_STATE		BIT(0)
+#define FLAG_RESULT_IN_STATE	BIT(1)
+
 /*
  * Magic marker used in test snippets for tail calls below.
  * BPF_LD/MOV to R2 and R2 with this immediate value is replaced
@@ -12252,32 +12257,38 @@ static struct tail_call_test tail_call_tests[] = {
 	{
 		"Tail call error path, max count reached",
 		.insns = {
-			BPF_ALU64_IMM(BPF_ADD, R1, 1),
-			BPF_ALU64_REG(BPF_MOV, R0, R1),
+			BPF_LDX_MEM(BPF_W, R2, R1, 0),
+			BPF_ALU64_IMM(BPF_ADD, R2, 1),
+			BPF_STX_MEM(BPF_W, R1, R2, 0),
 			TAIL_CALL(0),
 			BPF_EXIT_INSN(),
 		},
-		.result = MAX_TAIL_CALL_CNT + 1,
+		.flags = FLAG_NEED_STATE | FLAG_RESULT_IN_STATE,
+		.result = (MAX_TAIL_CALL_CNT + 1 + 1) * MAX_TESTRUNS,
 	},
 	{
 		"Tail call error path, NULL target",
 		.insns = {
-			BPF_ALU64_IMM(BPF_MOV, R0, -1),
+			BPF_LDX_MEM(BPF_W, R2, R1, 0),
+			BPF_ALU64_IMM(BPF_ADD, R2, 1),
+			BPF_STX_MEM(BPF_W, R1, R2, 0),
 			TAIL_CALL(TAIL_CALL_NULL),
-			BPF_ALU64_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
 		},
-		.result = 1,
+		.flags = FLAG_NEED_STATE | FLAG_RESULT_IN_STATE,
+		.result = MAX_TESTRUNS,
 	},
 	{
 		"Tail call error path, index out of range",
 		.insns = {
-			BPF_ALU64_IMM(BPF_MOV, R0, -1),
+			BPF_LDX_MEM(BPF_W, R2, R1, 0),
+			BPF_ALU64_IMM(BPF_ADD, R2, 1),
+			BPF_STX_MEM(BPF_W, R1, R2, 0),
 			TAIL_CALL(TAIL_CALL_INVALID),
-			BPF_ALU64_IMM(BPF_MOV, R0, 1),
 			BPF_EXIT_INSN(),
 		},
-		.result = 1,
+		.flags = FLAG_NEED_STATE | FLAG_RESULT_IN_STATE,
+		.result = MAX_TESTRUNS,
 	},
 };
 
@@ -12383,6 +12394,8 @@ static __init int test_tail_calls(struct bpf_array *progs)
 	for (i = 0; i < ARRAY_SIZE(tail_call_tests); i++) {
 		struct tail_call_test *test = &tail_call_tests[i];
 		struct bpf_prog *fp = progs->ptrs[i];
+		int *data = NULL;
+		int state = 0;
 		u64 duration;
 		int ret;
 
@@ -12399,7 +12412,11 @@ static __init int test_tail_calls(struct bpf_array *progs)
 		if (fp->jited)
 			jit_cnt++;
 
-		ret = __run_one(fp, NULL, MAX_TESTRUNS, &duration);
+		if (test->flags & FLAG_NEED_STATE)
+			data = &state;
+		ret = __run_one(fp, data, MAX_TESTRUNS, &duration);
+		if (test->flags & FLAG_RESULT_IN_STATE)
+			ret = state;
 		if (ret == test->result) {
 			pr_cont("%lld PASS", duration);
 			pass_cnt++;
-- 
2.30.2

