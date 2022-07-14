Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D525755BD
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 21:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiGNTS2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbiGNTS0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 15:18:26 -0400
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C9F43E5E
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 12:18:24 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.156.208])
        by sinmsgout01.his.huawei.com (SkyGuard) with ESMTP id 4LkPKP4nfNz9xF8b;
        Fri, 15 Jul 2022 03:13:29 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 21:18:18 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v8 10/12] selftests/bpf: Add verifier tests for bpf_lookup_user_key() and bpf_key_put()
Date:   Thu, 14 Jul 2022 21:14:53 +0200
Message-ID: <20220714191455.2101834-11-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714191455.2101834-1-roberto.sassu@huawei.com>
References: <20220714191455.2101834-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add verifier tests for bpf_lookup_user_key() and bpf_key_put(), to ensure
that acquired key references can be released, that a non-NULL pointer is
passed to bpf_key_put(), and that key references are not leaked.

Also, slightly modify test_verifier.c, to find the BTF ID of the attach
point for the LSM program type (currently, it is done only for TRACING).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/testing/selftests/bpf/test_verifier.c   |  3 +-
 .../selftests/bpf/verifier/ref_tracking.c     | 80 +++++++++++++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index f9d553fbf68a..2dbcbf363c18 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1498,7 +1498,8 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		opts.log_level = DEFAULT_LIBBPF_LOG_LEVEL;
 	opts.prog_flags = pflags;
 
-	if (prog_type == BPF_PROG_TYPE_TRACING && test->kfunc) {
+	if ((prog_type == BPF_PROG_TYPE_TRACING ||
+	     prog_type == BPF_PROG_TYPE_LSM) && test->kfunc) {
 		int attach_btf_id;
 
 		attach_btf_id = libbpf_find_vmlinux_btf_id(test->kfunc,
diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index 57a83d763ec1..b351dc62492f 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -84,6 +84,86 @@
 	.errstr = "Unreleased reference",
 	.result = REJECT,
 },
+{
+	"reference tracking: release key reference",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, -3),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_lookup_user_key", 2 },
+		{ "bpf_key_put", 5 },
+	},
+	.result = ACCEPT,
+},
+{
+	"reference tracking: release key reference without check",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, -3),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.errstr = "arg#0 pointer type STRUCT key must point to scalar, or struct with scalar",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_lookup_user_key", 2 },
+		{ "bpf_key_put", 4 },
+	},
+	.result = REJECT,
+},
+{
+	"reference tracking: release reference with NULL key pointer",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.errstr = "arg#0 pointer type STRUCT key must point to scalar, or struct with scalar",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_key_put", 1 },
+	},
+	.result = REJECT,
+},
+{
+	"reference tracking: leak potential reference to key",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, -3),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.errstr = "Unreleased reference",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_lookup_user_key", 2 },
+	},
+	.result = REJECT,
+},
 {
 	"reference tracking: release reference without check",
 	.insns = {
-- 
2.25.1

