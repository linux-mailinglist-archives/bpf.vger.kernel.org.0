Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C74E2BAC
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 16:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349924AbiCUPTP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 11:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349908AbiCUPTO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:14 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CEF11174C
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 08:17:48 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KMdRz6P69z9sps;
        Mon, 21 Mar 2022 23:13:51 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Mar
 2022 23:17:45 +0800
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
Subject: [PATCH bpf-next v5 5/5] bpf, arm64: add load store test case for tail call
Date:   Mon, 21 Mar 2022 11:28:52 -0400
Message-ID: <20220321152852.2334294-6-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220321152852.2334294-1-xukuohai@huawei.com>
References: <20220321152852.2334294-1-xukuohai@huawei.com>
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

Add test case to enusre that the caller and callee's fp offsets are
correct during tail call.

Tested on both big-endian and little-endian arm64 qemu, result:

 test_bpf: Summary: 1026 PASSED, 0 FAILED, [1014/1014 JIT'ed]
 test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
 test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 lib/test_bpf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index aa0c7c68b2be..2a7836e115b4 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -14950,6 +14950,36 @@ static struct tail_call_test tail_call_tests[] = {
 		},
 		.result = 10,
 	},
+	{
+		"Tail call load/store leaf",
+		.insns = {
+			BPF_ALU64_IMM(BPF_MOV, R1, 1),
+			BPF_ALU64_IMM(BPF_MOV, R2, 2),
+			BPF_ALU64_REG(BPF_MOV, R3, BPF_REG_FP),
+			BPF_STX_MEM(BPF_DW, R3, R1, -8),
+			BPF_STX_MEM(BPF_DW, R3, R2, -16),
+			BPF_LDX_MEM(BPF_DW, R0, BPF_REG_FP, -8),
+			BPF_JMP_REG(BPF_JNE, R0, R1, 3),
+			BPF_LDX_MEM(BPF_DW, R0, BPF_REG_FP, -16),
+			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
+			BPF_ALU64_IMM(BPF_MOV, R0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.result = 0,
+		.stack_depth = 32,
+	},
+	{
+		"Tail call load/store",
+		.insns = {
+			BPF_ALU64_IMM(BPF_MOV, R0, 3),
+			BPF_STX_MEM(BPF_DW, BPF_REG_FP, R0, -8),
+			TAIL_CALL(-1),
+			BPF_ALU64_IMM(BPF_MOV, R0, -1),
+			BPF_EXIT_INSN(),
+		},
+		.result = 0,
+		.stack_depth = 16,
+	},
 	{
 		"Tail call error path, max count reached",
 		.insns = {
-- 
2.30.2

