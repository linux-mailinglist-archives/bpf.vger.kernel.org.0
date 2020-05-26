Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDAA1B2700
	for <lists+bpf@lfdr.de>; Tue, 21 Apr 2020 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgDUNCC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 09:02:02 -0400
Received: from www62.your-server.de ([213.133.104.62]:53172 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbgDUNCC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Apr 2020 09:02:02 -0400
Received: from 98.186.195.178.dynamic.wline.res.cust.swisscom.ch ([178.195.186.98] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jQsXI-0003he-Be; Tue, 21 Apr 2020 15:02:00 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     gregkh@linuxfoundation.org
Cc:     alexei.starovoitov@gmail.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, jannh@google.com, fontanalorenz@gmail.com,
        leodidonato@gmail.com, yhs@fb.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH stable 5.4,5.5,5.6 2/4] bpf: Test_verifier, bpf_get_stack return value add <0
Date:   Tue, 21 Apr 2020 15:01:50 +0200
Message-Id: <20200421130152.14348-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200421130152.14348-1-daniel@iogearbox.net>
References: <20200421130152.14348-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25789/Tue Apr 21 13:55:14 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ upstream commit 9ac26e9973bac5716a2a542e32f380c84db2b88c ]

With current ALU32 subreg handling and retval refine fix from last
patches we see an expected failure in test_verifier. With verbose
verifier state being printed at each step for clarity we have the
following relavent lines [I omit register states that are not
necessarily useful to see failure cause],

101/p bpf_get_stack return R0 within range FAIL
Failed to load prog 'Success'!
[..]
14: (85) call bpf_get_stack#67
 R0_w=map_value(id=0,off=0,ks=8,vs=48,imm=0)
 R3_w=inv48
15:
 R0=inv(id=0,smax_value=48,var32_off=(0x0; 0xffffffff))
15: (b7) r1 = 0
16:
 R0=inv(id=0,smax_value=48,var32_off=(0x0; 0xffffffff))
 R1_w=inv0
16: (bf) r8 = r0
17:
 R0=inv(id=0,smax_value=48,var32_off=(0x0; 0xffffffff))
 R1_w=inv0
 R8_w=inv(id=0,smax_value=48,var32_off=(0x0; 0xffffffff))
17: (67) r8 <<= 32
18:
 R0=inv(id=0,smax_value=48,var32_off=(0x0; 0xffffffff))
 R1_w=inv0
 R8_w=inv(id=0,smax_value=9223372032559808512,
               umax_value=18446744069414584320,
               var_off=(0x0; 0xffffffff00000000),
               s32_min_value=0,
               s32_max_value=0,
               u32_max_value=0,
               var32_off=(0x0; 0x0))
18: (c7) r8 s>>= 32
19
 R0=inv(id=0,smax_value=48,var32_off=(0x0; 0xffffffff))
 R1_w=inv0
 R8_w=inv(id=0,smin_value=-2147483648,
               smax_value=2147483647,
               var32_off=(0x0; 0xffffffff))
19: (cd) if r1 s< r8 goto pc+16
 R0=inv(id=0,smax_value=48,var32_off=(0x0; 0xffffffff))
 R1_w=inv0
 R8_w=inv(id=0,smin_value=-2147483648,
               smax_value=0,
               var32_off=(0x0; 0xffffffff))
20:
 R0=inv(id=0,smax_value=48,var32_off=(0x0; 0xffffffff))
 R1_w=inv0
 R8_w=inv(id=0,smin_value=-2147483648,
               smax_value=0,
 R9=inv48
20: (1f) r9 -= r8
21: (bf) r2 = r7
22:
 R2_w=map_value(id=0,off=0,ks=8,vs=48,imm=0)
22: (0f) r2 += r8
value -2147483648 makes map_value pointer be out of bounds

After call bpf_get_stack() on line 14 and some moves we have at line 16
an r8 bound with max_value 48 but an unknown min value. This is to be
expected bpf_get_stack call can only return a max of the input size but
is free to return any negative error in the 32-bit register space. The
C helper is returning an int so will use lower 32-bits.

Lines 17 and 18 clear the top 32 bits with a left/right shift but use
ARSH so we still have worst case min bound before line 19 of -2147483648.
At this point the signed check 'r1 s< r8' meant to protect the addition
on line 22 where dst reg is a map_value pointer may very well return
true with a large negative number. Then the final line 22 will detect
this as an invalid operation and fail the program. What we want to do
is proceed only if r8 is positive non-error. So change 'r1 s< r8' to
'r1 s> r8' so that we jump if r8 is negative.

Next we will throw an error because we access past the end of the map
value. The map value size is 48 and sizeof(struct test_val) is 48 so
we walk off the end of the map value on the second call to
get bpf_get_stack(). Fix this by changing sizeof(struct test_val) to
24 by using 'sizeof(struct test_val) / 2'. After this everything passes
as expected.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/158560426019.10843.3285429543232025187.stgit@john-Precision-5820-Tower
---
 tools/testing/selftests/bpf/verifier/bpf_get_stack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
index f24d50f09dbe..69b048cf46d9 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
@@ -9,17 +9,17 @@
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 28),
 	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_9, sizeof(struct test_val)),
+	BPF_MOV64_IMM(BPF_REG_9, sizeof(struct test_val)/2),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
-	BPF_MOV64_IMM(BPF_REG_3, sizeof(struct test_val)),
+	BPF_MOV64_IMM(BPF_REG_3, sizeof(struct test_val)/2),
 	BPF_MOV64_IMM(BPF_REG_4, 256),
 	BPF_EMIT_CALL(BPF_FUNC_get_stack),
 	BPF_MOV64_IMM(BPF_REG_1, 0),
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 32),
 	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_8, 32),
-	BPF_JMP_REG(BPF_JSLT, BPF_REG_1, BPF_REG_8, 16),
+	BPF_JMP_REG(BPF_JSGT, BPF_REG_1, BPF_REG_8, 16),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_8),
@@ -29,7 +29,7 @@
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_1),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_MOV64_IMM(BPF_REG_5, sizeof(struct test_val)),
+	BPF_MOV64_IMM(BPF_REG_5, sizeof(struct test_val)/2),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_5),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_1, 4),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-- 
2.20.1

