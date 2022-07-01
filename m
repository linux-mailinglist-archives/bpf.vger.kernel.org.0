Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F015633AA
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 14:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiGAMrq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbiGAMrp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 08:47:45 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D233A3F
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 05:47:44 -0700 (PDT)
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o7G3i-00044b-Fz; Fri, 01 Jul 2022 14:47:42 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     andrii@kernel.org, john.fastabend@gmail.com, liulin063@gmail.com,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 4/4] bpf, selftests: Add verifier test case for jmp32's jeq/jne
Date:   Fri,  1 Jul 2022 14:47:27 +0200
Message-Id: <20220701124727.11153-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220701124727.11153-1-daniel@iogearbox.net>
References: <20220701124727.11153-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26590/Fri Jul  1 09:25:21 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test case to trigger the verifier's incorrect conclusion in the
case of jmp32's jeq/jne. Also here, make use of dead code elimination,
so that we can see the verifier bailing out on unfixed kernels.

Before:

  # ./test_verifier 724
  #724/p jeq32/jne32: bounds checking FAIL
  Failed to load prog 'Permission denied'!
  R4 !read_ok
  verification time 8 usec
  stack depth 0
  processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 0
  Summary: 0 PASSED, 0 SKIPPED, 1 FAILED

After:

  # ./test_verifier 724
  #724/p jeq32/jne32: bounds checking OK
  Summary: 1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/verifier/jmp32.c | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/jmp32.c b/tools/testing/selftests/bpf/verifier/jmp32.c
index 6ddc418fdfaf..1a27a6210554 100644
--- a/tools/testing/selftests/bpf/verifier/jmp32.c
+++ b/tools/testing/selftests/bpf/verifier/jmp32.c
@@ -864,3 +864,24 @@
 	.result = ACCEPT,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
+{
+	"jeq32/jne32: bounds checking",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_6, 563),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
+	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
+	BPF_ALU32_REG(BPF_OR, BPF_REG_2, BPF_REG_6),
+	BPF_JMP32_IMM(BPF_JNE, BPF_REG_2, 8, 5),
+	BPF_JMP_IMM(BPF_JSGE, BPF_REG_2, 500, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_4),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+	.retval = 1,
+},
-- 
2.27.0

