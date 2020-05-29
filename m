Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BCF1E851F
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 19:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgE2Rhs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgE2Rhl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 13:37:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D0C014C28
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 10:29:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so1614786pjd.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0adSVJ8bl6BenihY56Mj258c/1SpdEbkeblRHmbp1E8=;
        b=caMB0wSkUqsBRFifZ9CpDVfif21gBM0jWgfALD3XEHKGOP7c7LzeQzzwHQspRHyODb
         cQCxf6PjV2cklhzF+1yLvZYVAdZm2ygLaYKgEqbx/ZD5TJ2aWpqOMJ8Xf3PJvCsCrWcd
         Q/A2hRKFP0PmvBCQpuiNRhxGEhoLu254vqk2hB0waIu2yxP0bsfYtAa76GbfXxZ+mJTQ
         93ujsgoYR7ZvYnAoHcKVwVXtztFmx14MyH0e0qTpTFf40fEJip+AqI0z3ud2fI973uG6
         iexGo1dUPCppEjOC5bQJK5r00BFb3zHfZ83ohWDrRn0ma974K5RzJdVUY4WsG4Wp6EXa
         pEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0adSVJ8bl6BenihY56Mj258c/1SpdEbkeblRHmbp1E8=;
        b=fOgelzl1TuytuWeQujH9VMMaNuGJ9/yrkuFJSc4F++YN0jtlykyOrITLjchdLlggcx
         QwraxDjiUnlscQMPeG44Vi9STXTomgrrcDGUlEYcW7eO0vIGz5xSDe6zmE7xAyrz2oGK
         MHvhRV6GMD2oVTUblh21pgiXdq0lVmcs7fqLv00JTomm8Wg7zEUO0Cu2lTNetZar6UiS
         tJy+31lTJk+u52MnJWllqBLd87PJAqFcIdxPpTUT8AgXgHhX+gDEp3kUoTg+KDLgDQQm
         Fody20ide670OQq6bx+i7qqsDE92OLhZ5yNoDx4rGztp+679a7KWlsXw3WU9bnyVEU5h
         SUEg==
X-Gm-Message-State: AOAM533Hn5f1EZeWYcYpToCnsb+cfAYwwMt92XE+L4oFFrK6h/lu8OrF
        tQAfcWiAY7goLloxPOw4xd0=
X-Google-Smtp-Source: ABdhPJyJc1sNFLnGPg+AtlrKI3haI2ZL1E6aGNRqQpDX6C2Tr23bI2nLvgw2e0lEQKHskBMBL9aZpA==
X-Received: by 2002:a17:90a:ad92:: with SMTP id s18mr10697272pjq.30.1590773352628;
        Fri, 29 May 2020 10:29:12 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id y4sm7636627pfn.101.2020.05.29.10.29.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 10:29:11 -0700 (PDT)
Subject: [bpf PATCH 2/3] bpf,
 selftests: verifier bounds tests need to be updated
From:   John Fastabend <john.fastabend@gmail.com>
To:     yhs@fb.com, alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, john.fastabend@gmail.com, kernel-team@fb.com
Date:   Fri, 29 May 2020 10:28:59 -0700
Message-ID: <159077333942.6014.14004320043595756079.stgit@john-Precision-5820-Tower>
In-Reply-To: <159077324869.6014.6516130782021506562.stgit@john-Precision-5820-Tower>
References: <159077324869.6014.6516130782021506562.stgit@john-Precision-5820-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After previous fix for zero extension test_verifier tests #65 and #66 now
fail. Before the fix we can see the alu32 mov op at insn 10

10: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
    R1_w=invP(id=0,
              smin_value=4294967168,smax_value=4294967423,
              umin_value=4294967168,umax_value=4294967423,
              var_off=(0x0; 0x1ffffffff),
              s32_min_value=-2147483648,s32_max_value=2147483647,
              u32_min_value=0,u32_max_value=-1)
    R10=fp0 fp-8_w=mmmmmmmm
10: (bc) w1 = w1
11: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
    R1_w=invP(id=0,
              smin_value=0,smax_value=2147483647,
              umin_value=0,umax_value=4294967295,
              var_off=(0x0; 0xffffffff),
              s32_min_value=-2147483648,s32_max_value=2147483647,
              u32_min_value=0,u32_max_value=-1)
    R10=fp0 fp-8_w=mmmmmmmm

After the fix at insn 10 because we have 's32_min_value < 0' the following
step 11 now has 'smax_value=U32_MAX' where before we pulled the s32_max_value
bound into the smax_value as seen above in 11 with smax_value=2147483647.

10: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
    R1_w=inv(id=0,
             smin_value=4294967168,smax_value=4294967423,
             umin_value=4294967168,umax_value=4294967423,
             var_off=(0x0; 0x1ffffffff),
             s32_min_value=-2147483648, s32_max_value=2147483647,
             u32_min_value=0,u32_max_value=-1)
    R10=fp0 fp-8_w=mmmmmmmm
10: (bc) w1 = w1
11: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
    R1_w=inv(id=0,
             smin_value=0,smax_value=4294967295,
             umin_value=0,umax_value=4294967295,
             var_off=(0x0; 0xffffffff),
             s32_min_value=-2147483648, s32_max_value=2147483647,
             u32_min_value=0, u32_max_value=-1)
    R10=fp0 fp-8_w=mmmmmmmm

The fall out of this is by the time we get to the failing instruction at
step 14 where previously we had the following:

14: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
    R1_w=inv(id=0,
             smin_value=72057594021150720,smax_value=72057594029539328,
             umin_value=72057594021150720,umax_value=72057594029539328,
             var_off=(0xffffffff000000; 0xffffff),
             s32_min_value=-16777216,s32_max_value=-1,
             u32_min_value=-16777216,u32_max_value=-1)
    R10=fp0 fp-8_w=mmmmmmmm
14: (0f) r0 += r1

We now have,

14: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
    R1_w=inv(id=0,
             smin_value=0,smax_value=72057594037927935,
             umin_value=0,umax_value=72057594037927935,
             var_off=(0x0; 0xffffffffffffff),
             s32_min_value=-2147483648,s32_max_value=2147483647,
             u32_min_value=0,u32_max_value=-1)
    R10=fp0 fp-8_w=mmmmmmmm
14: (0f) r0 += r1

In the original step 14 'smin_value=72057594021150720' this trips the logic
in the verifier function check_reg_sane_offset(),

 if (smin >= BPF_MAX_VAR_OFF || smin <= -BPF_MAX_VAR_OFF) {
	verbose(env, "value %lld makes %s pointer be out of bounds\n",
		smin, reg_type_str[type]);
	return false;
 }

Specifically, the 'smin <= -BPF_MAX_VAR_OFF' check. But with the fix
at step 14 we have bounds 'smin_value=0' so the above check is not tripped
because BPF_MAX_VAR_OFF=1<<29.

We have a smin_value=0 here because at step 10 the smaller smin_value=0 means
the subtractions at steps 11 and 12 bring the smin_value negative.

11: (17) r1 -= 2147483584
12: (17) r1 -= 2147483584
13: (77) r1 >>= 8

Then the shift clears the top bit and smin_value is set to 0. Note we still
have the smax_value in the fixed code so any reads will fail. An alternative
would be to have reg_sane_check() do both smin and smax value tests.

To fix the test we can omit the 'r1 >>=8' at line 13. This will change the
err string, but keeps the intention of the test as suggseted by the title,
"check after truncation of boundary-crossing range". If the verifier logic
changes a different value is likely to be thrown in the error or the error
will no longer be thrown forcing this test to be examined. With this change
we see the new state at step 13.

13: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0)
    R1_w=invP(id=0,
              smin_value=-4294967168,smax_value=127,
              umin_value=0,umax_value=18446744073709551615,
              s32_min_value=-2147483648,s32_max_value=2147483647,
              u32_min_value=0,u32_max_value=-1)
    R10=fp0 fp-8_w=mmmmmmmm

Giving the expected out of bounds error, "value -4294967168 makes map_value
pointer be out of bounds" However, for unpriv case we see a different error
now because of the mixed signed bounds pointer arithmatic. This seems OK so
I've only added the unpriv_errstr for this. Another optino may have been to
do addition on r1 instead of subtraction but I favor the approach above
slightly.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/verifier/bounds.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
index a253a06..fafa540 100644
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ b/tools/testing/selftests/bpf/verifier/bounds.c
@@ -238,7 +238,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	/* r1 = [0x00, 0xff] */
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0xffffff80 >> 1),
@@ -253,10 +253,6 @@
 	 *      [0xffff'ffff'0000'0080, 0xffff'ffff'ffff'ffff]
 	 */
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 0xffffff80 >> 1),
-	/* r1 = 0 or
-	 *      [0x00ff'ffff'ff00'0000, 0x00ff'ffff'ffff'ffff]
-	 */
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 8),
 	/* error on OOB pointer computation */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	/* exit */
@@ -265,8 +261,10 @@
 	},
 	.fixup_map_hash_8b = { 3 },
 	/* not actually fully unbounded, but the bound is very high */
-	.errstr = "value 72057594021150720 makes map_value pointer be out of bounds",
-	.result = REJECT
+	.errstr_unpriv = "R1 has unknown scalar with mixed signed bounds, pointer arithmetic with it prohibited for !root",
+	.result_unpriv = REJECT,
+	.errstr = "value -4294967168 makes map_value pointer be out of bounds",
+	.result = REJECT,
 },
 {
 	"bounds check after truncation of boundary-crossing range (2)",
@@ -276,7 +274,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	/* r1 = [0x00, 0xff] */
 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 0xffffff80 >> 1),
@@ -293,10 +291,6 @@
 	 *      [0xffff'ffff'0000'0080, 0xffff'ffff'ffff'ffff]
 	 */
 	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 0xffffff80 >> 1),
-	/* r1 = 0 or
-	 *      [0x00ff'ffff'ff00'0000, 0x00ff'ffff'ffff'ffff]
-	 */
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 8),
 	/* error on OOB pointer computation */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	/* exit */
@@ -305,8 +299,10 @@
 	},
 	.fixup_map_hash_8b = { 3 },
 	/* not actually fully unbounded, but the bound is very high */
-	.errstr = "value 72057594021150720 makes map_value pointer be out of bounds",
-	.result = REJECT
+	.errstr_unpriv = "R1 has unknown scalar with mixed signed bounds, pointer arithmetic with it prohibited for !root",
+	.result_unpriv = REJECT,
+	.errstr = "value -4294967168 makes map_value pointer be out of bounds",
+	.result = REJECT,
 },
 {
 	"bounds check after wrapping 32-bit addition",

