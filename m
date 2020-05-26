Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CD31B2702
	for <lists+bpf@lfdr.de>; Tue, 21 Apr 2020 15:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgDUNCD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 09:02:03 -0400
Received: from www62.your-server.de ([213.133.104.62]:53188 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgDUNCD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Apr 2020 09:02:03 -0400
Received: from 98.186.195.178.dynamic.wline.res.cust.swisscom.ch ([178.195.186.98] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jQsXJ-0003j3-QC; Tue, 21 Apr 2020 15:02:01 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     gregkh@linuxfoundation.org
Cc:     alexei.starovoitov@gmail.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, jannh@google.com, fontanalorenz@gmail.com,
        leodidonato@gmail.com, yhs@fb.com, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 5.4,5.5,5.6 4/4] bpf, test_verifier: switch bpf_get_stack's 0 s> r8 test
Date:   Tue, 21 Apr 2020 15:01:52 +0200
Message-Id: <20200421130152.14348-4-daniel@iogearbox.net>
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

[ no upstream commit ]

Switch the comparison, so that is_branch_taken() will recognize that below
branch is never taken:

  [...]
  17: [...] R1_w=inv0 [...] R8_w=inv(id=0,smin_value=-2147483648,smax_value=-1,umin_value=18446744071562067968,var_off=(0xffffffff80000000; 0x7fffffff)) [...]
  17: (67) r8 <<= 32
  18: [...] R8_w=inv(id=0,smax_value=-4294967296,umin_value=9223372036854775808,umax_value=18446744069414584320,var_off=(0x8000000000000000; 0x7fffffff00000000)) [...]
  18: (c7) r8 s>>= 32
  19: [...] R8_w=inv(id=0,smin_value=-2147483648,smax_value=-1,umin_value=18446744071562067968,var_off=(0xffffffff80000000; 0x7fffffff)) [...]
  19: (6d) if r1 s> r8 goto pc+16
  [...] R1_w=inv0 [...] R8_w=inv(id=0,smin_value=-2147483648,smax_value=-1,umin_value=18446744071562067968,var_off=(0xffffffff80000000; 0x7fffffff)) [...]
  [...]

Currently we check for is_branch_taken() only if either K is source, or source
is a scalar value that is const. For upstream it would be good to extend this
properly to check whether dst is const and src not.

For the sake of the test_verifier, it is probably not needed here:

  # ./test_verifier 101
  #101/p bpf_get_stack return R0 within range OK
  Summary: 1 PASSED, 0 SKIPPED, 0 FAILED

I haven't seen this issue in test_progs* though, they are passing fine:

  # ./test_progs-no_alu32 -t get_stack
  Switching to flavor 'no_alu32' subdirectory...
  #20 get_stack_raw_tp:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

  # ./test_progs -t get_stack
  #20 get_stack_raw_tp:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/verifier/bpf_get_stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
index 69b048cf46d9..371926771db5 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
@@ -19,7 +19,7 @@
 	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_8, 32),
 	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_8, 32),
-	BPF_JMP_REG(BPF_JSGT, BPF_REG_1, BPF_REG_8, 16),
+	BPF_JMP_REG(BPF_JSLT, BPF_REG_8, BPF_REG_1, 16),
 	BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_8),
-- 
2.20.1

