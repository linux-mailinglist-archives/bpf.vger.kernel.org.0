Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5DC4DB5C1
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 17:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiCPQQY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 12:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350102AbiCPQQW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 12:16:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF9FDF38
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 09:15:06 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KJZyV5rmdz9slb;
        Thu, 17 Mar 2022 00:11:14 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 00:15:03 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hou Tao <houtao1@huawei.com>, Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH -next v3 3/4] bpf/tests: Add tests for BPF_LDX/BPF_STX with different offsets
Date:   Wed, 16 Mar 2022 12:26:20 -0400
Message-ID: <20220316162621.3842604-4-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316162621.3842604-1-xukuohai@huawei.com>
References: <20220316162621.3842604-1-xukuohai@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds tests to verify the behavior of BPF_LDX/BPF_STX +
BPF_B/BPF_H/BPF_W/BPF_DW with negative offset, small positive offset,
large positive offset, and misaligned offset.

Tested on both big-endian and little-endian arm64 qemu, result:

 test_bpf: Summary: 1026 PASSED, 0 FAILED, [1014/1014 JIT'ed]
 test_bpf: test_tail_calls: Summary: 8 PASSED, 0 FAILED, [8/8 JIT'ed]
 test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 lib/test_bpf.c | 285 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 281 insertions(+), 4 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 0c5cb2d6436a..e6d862294f23 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -53,6 +53,7 @@
 #define FLAG_EXPECTED_FAIL	BIT(1)
 #define FLAG_SKB_FRAG		BIT(2)
 #define FLAG_VERIFIER_ZEXT	BIT(3)
+#define FLAG_LARGE_MEM		BIT(4)
 
 enum {
 	CLASSIC  = BIT(6),	/* Old BPF instructions only. */
@@ -7838,7 +7839,7 @@ static struct bpf_test tests[] = {
 	},
 	/* BPF_LDX_MEM B/H/W/DW */
 	{
-		"BPF_LDX_MEM | BPF_B",
+		"BPF_LDX_MEM | BPF_B, base",
 		.u.insns_int = {
 			BPF_LD_IMM64(R1, 0x0102030405060708ULL),
 			BPF_LD_IMM64(R2, 0x0000000000000008ULL),
@@ -7878,7 +7879,56 @@ static struct bpf_test tests[] = {
 		.stack_depth = 8,
 	},
 	{
-		"BPF_LDX_MEM | BPF_H",
+		"BPF_LDX_MEM | BPF_B, negative offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_LD_IMM64(R3, 0x0000000000000088ULL),
+			BPF_ALU64_IMM(BPF_ADD, R1, 512),
+			BPF_STX_MEM(BPF_B, R1, R2, -256),
+			BPF_LDX_MEM(BPF_B, R0, R1, -256),
+			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 512, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_B, small positive offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_LD_IMM64(R3, 0x0000000000000088ULL),
+			BPF_STX_MEM(BPF_B, R1, R2, 256),
+			BPF_LDX_MEM(BPF_B, R0, R1, 256),
+			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 512, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_B, large positive offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_LD_IMM64(R3, 0x0000000000000088ULL),
+			BPF_STX_MEM(BPF_B, R1, R2, 4096),
+			BPF_LDX_MEM(BPF_B, R0, R1, 4096),
+			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 4096 + 16, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_H, base",
 		.u.insns_int = {
 			BPF_LD_IMM64(R1, 0x0102030405060708ULL),
 			BPF_LD_IMM64(R2, 0x0000000000000708ULL),
@@ -7918,7 +7968,72 @@ static struct bpf_test tests[] = {
 		.stack_depth = 8,
 	},
 	{
-		"BPF_LDX_MEM | BPF_W",
+		"BPF_LDX_MEM | BPF_H, negative offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_LD_IMM64(R3, 0x0000000000008788ULL),
+			BPF_ALU64_IMM(BPF_ADD, R1, 512),
+			BPF_STX_MEM(BPF_H, R1, R2, -256),
+			BPF_LDX_MEM(BPF_H, R0, R1, -256),
+			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 512, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_H, small positive offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_LD_IMM64(R3, 0x0000000000008788ULL),
+			BPF_STX_MEM(BPF_H, R1, R2, 256),
+			BPF_LDX_MEM(BPF_H, R0, R1, 256),
+			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 512, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_H, large positive offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_LD_IMM64(R3, 0x0000000000008788ULL),
+			BPF_STX_MEM(BPF_H, R1, R2, 8192),
+			BPF_LDX_MEM(BPF_H, R0, R1, 8192),
+			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 8192 + 16, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_H, misaligned offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_LD_IMM64(R3, 0x0000000000008788ULL),
+			BPF_STX_MEM(BPF_H, R1, R2, 13),
+			BPF_LDX_MEM(BPF_H, R0, R1, 13),
+			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 32, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_W, base",
 		.u.insns_int = {
 			BPF_LD_IMM64(R1, 0x0102030405060708ULL),
 			BPF_LD_IMM64(R2, 0x0000000005060708ULL),
@@ -7957,6 +8072,162 @@ static struct bpf_test tests[] = {
 		{ { 0, 0 } },
 		.stack_depth = 8,
 	},
+	{
+		"BPF_LDX_MEM | BPF_W, negative offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_LD_IMM64(R3, 0x0000000085868788ULL),
+			BPF_ALU64_IMM(BPF_ADD, R1, 512),
+			BPF_STX_MEM(BPF_W, R1, R2, -256),
+			BPF_LDX_MEM(BPF_W, R0, R1, -256),
+			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 512, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_W, small positive offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_LD_IMM64(R3, 0x0000000085868788ULL),
+			BPF_STX_MEM(BPF_W, R1, R2, 256),
+			BPF_LDX_MEM(BPF_W, R0, R1, 256),
+			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 512, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_W, large positive offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_LD_IMM64(R3, 0x0000000085868788ULL),
+			BPF_STX_MEM(BPF_W, R1, R2, 16384),
+			BPF_LDX_MEM(BPF_W, R0, R1, 16384),
+			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 16384 + 16, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_W, misaligned positive offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_LD_IMM64(R3, 0x0000000085868788ULL),
+			BPF_STX_MEM(BPF_W, R1, R2, 13),
+			BPF_LDX_MEM(BPF_W, R0, R1, 13),
+			BPF_JMP_REG(BPF_JNE, R0, R3, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 32, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_DW, base",
+		.u.insns_int = {
+			BPF_LD_IMM64(R1, 0x0102030405060708ULL),
+			BPF_STX_MEM(BPF_DW, R10, R1, -8),
+			BPF_LDX_MEM(BPF_DW, R0, R10, -8),
+			BPF_JMP_REG(BPF_JNE, R0, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } },
+		.stack_depth = 8,
+	},
+	{
+		"BPF_LDX_MEM | BPF_DW, MSB set",
+		.u.insns_int = {
+			BPF_LD_IMM64(R1, 0x8182838485868788ULL),
+			BPF_STX_MEM(BPF_DW, R10, R1, -8),
+			BPF_LDX_MEM(BPF_DW, R0, R10, -8),
+			BPF_JMP_REG(BPF_JNE, R0, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL,
+		{ },
+		{ { 0, 0 } },
+		.stack_depth = 8,
+	},
+	{
+		"BPF_LDX_MEM | BPF_DW, negative offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_ALU64_IMM(BPF_ADD, R1, 512),
+			BPF_STX_MEM(BPF_DW, R1, R2, -256),
+			BPF_LDX_MEM(BPF_DW, R0, R1, -256),
+			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 512, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_DW, small positive offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_STX_MEM(BPF_DW, R1, R2, 256),
+			BPF_LDX_MEM(BPF_DW, R0, R1, 256),
+			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 512, 0 } },
+		.stack_depth = 8,
+	},
+	{
+		"BPF_LDX_MEM | BPF_DW, large positive offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_STX_MEM(BPF_DW, R1, R2, 32768),
+			BPF_LDX_MEM(BPF_DW, R0, R1, 32768),
+			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 32768 + 16, 0 } },
+		.stack_depth = 0,
+	},
+	{
+		"BPF_LDX_MEM | BPF_DW, misaligned positive offset",
+		.u.insns_int = {
+			BPF_LD_IMM64(R2, 0x8182838485868788ULL),
+			BPF_STX_MEM(BPF_DW, R1, R2, 13),
+			BPF_LDX_MEM(BPF_DW, R0, R1, 13),
+			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		INTERNAL | FLAG_LARGE_MEM,
+		{ },
+		{ { 32, 0 } },
+		.stack_depth = 0,
+	},
 	/* BPF_STX_MEM B/H/W/DW */
 	{
 		"BPF_STX_MEM | BPF_B",
@@ -14094,6 +14365,9 @@ static void *generate_test_data(struct bpf_test *test, int sub)
 	if (test->aux & FLAG_NO_DATA)
 		return NULL;
 
+	if (test->aux & FLAG_LARGE_MEM)
+		return kmalloc(test->test[sub].data_size, GFP_KERNEL);
+
 	/* Test case expects an skb, so populate one. Various
 	 * subtests generate skbs of different sizes based on
 	 * the same data.
@@ -14137,7 +14411,10 @@ static void release_test_data(const struct bpf_test *test, void *data)
 	if (test->aux & FLAG_NO_DATA)
 		return;
 
-	kfree_skb(data);
+	if (test->aux & FLAG_LARGE_MEM)
+		kfree(data);
+	else
+		kfree_skb(data);
 }
 
 static int filter_length(int which)
-- 
2.30.2

