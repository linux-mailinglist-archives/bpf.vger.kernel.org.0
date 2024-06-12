Return-Path: <bpf+bounces-31981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EFE905EA1
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 00:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6459B20F98
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6799212C46B;
	Wed, 12 Jun 2024 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lksph6nR"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0321360
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232014; cv=none; b=JFa4MoQ4jeEbQwHoD32/+45O0XY2CS0LCz3mAJWHTL+LFy19Onv8VL2Y3nsbkTcWg7lGOJCzeaVs9VkNvntX/xWrs1M3KJOK8suj1oH0Owemx2X2eEQJptcyGwg1WlA/OlvnY4mKhEA5yEe0IkDs11oajXAo/KGscugrvOAQJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232014; c=relaxed/simple;
	bh=tqUWbqrmJgUvYpam/K60gvcbe1RZWAnP+O64lIT4gY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mcVfAz89/jyeGGnRezU7PkxWrJ4Mjp3+zjFJty5QdyZ27YTsbYbmAIgUNhsKXmG74t0DxGdBwxySY8ahOge8ujxuvLI9WYyKbW/JOmTjRyANaisjGCBKDy56SeIvy/QIg4ltmyJStrnwXwv/rjLo/zcrDU/raHHyDX4hqf35F4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lksph6nR; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=cfexnMi7AjvZYqlKP9yZ2D2t4qrze9qhRsz4mJSnMMM=; b=lksph6nRPSkxNrUxQGCL3JJIHB
	wQZ+1cu34IrQvUHQaLrNBlDkGVevFz/wf7bUtL+RYaR1i+003dbJ5Fup2+VTqjJiK4aBQa4QbmfkN
	dgl5TNic9X50aZLo6qVS+CAhBXKom/pE6Ss9mvBYLGso2hWF1NrGoh1lobQohrujbynGL3TDjM4zH
	2zZtVU2pqxz3m+Ia3lqGsvOf4/D7g8OkvHQ9aQHX+jNJGH2uiTHOBvcALqmVb2vI9AJTPkqFN7/eQ
	RPbmNjE6XDUyUrT5oA3yPdJGhXtCVylAimhMcGg6ch9XOBFcJPyuoqdoGNgiWD1QDcud897V9n/ZD
	a9diuOkQ==;
Received: from 34.249.197.178.dynamic.cust.swisscom.net ([178.197.249.34] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sHWER-000GZN-6O; Thu, 13 Jun 2024 00:14:15 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: jjlopezjaimez@google.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 1/2] bpf: Fix reg_set_min_max corruption of fake_reg
Date: Thu, 13 Jun 2024 00:14:04 +0200
Message-Id: <20240612221405.3378-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27304/Wed Jun 12 10:27:29 2024)

Juan reported that after doing some changes to buzzer [0] and implementing
a new fuzzing strategy guided by coverage, they noticed the following in
one of the probes:

  [...]
  13: (79) r6 = *(u64 *)(r0 +0)         ; R0=map_value(ks=4,vs=8) R6_w=scalar()
  14: (b7) r0 = 0                       ; R0_w=0
  15: (b4) w0 = -1                      ; R0_w=0xffffffff
  16: (74) w0 >>= 1                     ; R0_w=0x7fffffff
  17: (5c) w6 &= w0                     ; R0_w=0x7fffffff R6_w=scalar(smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff))
  18: (44) w6 |= 2                      ; R6_w=scalar(smin=umin=smin32=umin32=2,smax=umax=umax32=0x7fffffff,var_off=(0x2; 0x7ffffffd))
  19: (56) if w6 != 0x7ffffffd goto pc+1
  REG INVARIANTS VIOLATION (true_reg2): range bounds violation u64=[0x7fffffff, 0x7ffffffd] s64=[0x7fffffff, 0x7ffffffd] u32=[0x7fffffff, 0x7ffffffd] s32=[0x7fffffff, 0x7ffffffd] var_off=(0x7fffffff, 0x0)
  REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0x7fffffff, 0x7ffffffd] s64=[0x7fffffff, 0x7ffffffd] u32=[0x7fffffff, 0x7ffffffd] s32=[0x7fffffff, 0x7ffffffd] var_off=(0x7fffffff, 0x0)
  REG INVARIANTS VIOLATION (false_reg2): const tnum out of sync with range bounds u64=[0x0, 0xffffffffffffffff] s64=[0x8000000000000000, 0x7fffffffffffffff] u32=[0x0, 0xffffffff] s32=[0x80000000, 0x7fffffff] var_off=(0x7fffffff, 0x0)
  19: R6_w=0x7fffffff
  20: (95) exit

  from 19 to 21: R0=0x7fffffff R6=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=0x7ffffffe,var_off=(0x2; 0x7ffffffd)) R7=map_ptr(ks=4,vs=8) R9=ctx() R10=fp0 fp-24=map_ptr(ks=4,vs=8) fp-40=mmmmmmmm
  21: R0=0x7fffffff R6=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=0x7ffffffe,var_off=(0x2; 0x7ffffffd)) R7=map_ptr(ks=4,vs=8) R9=ctx() R10=fp0 fp-24=map_ptr(ks=4,vs=8) fp-40=mmmmmmmm
  21: (14) w6 -= 2147483632             ; R6_w=scalar(smin=umin=umin32=2,smax=umax=0xffffffff,smin32=0x80000012,smax32=14,var_off=(0x2; 0xfffffffd))
  22: (76) if w6 s>= 0xe goto pc+1      ; R6_w=scalar(smin=umin=umin32=2,smax=umax=0xffffffff,smin32=0x80000012,smax32=13,var_off=(0x2; 0xfffffffd))
  23: (95) exit

  from 22 to 24: R0=0x7fffffff R6_w=14 R7=map_ptr(ks=4,vs=8) R9=ctx() R10=fp0 fp-24=map_ptr(ks=4,vs=8) fp-40=mmmmmmmm
  24: R0=0x7fffffff R6_w=14 R7=map_ptr(ks=4,vs=8) R9=ctx() R10=fp0 fp-24=map_ptr(ks=4,vs=8) fp-40=mmmmmmmm
  24: (14) w6 -= 14                     ; R6_w=0
  [...]

What can be seen here is a register invariant violation on line 19. After
the binary-or in line 18, the verifier knows that bit 2 is set but knows
nothing about the rest of the content which was loaded from a map value,
meaning, range is [2,0x7fffffff] with var_off=(0x2; 0x7ffffffd). When in
line 19 the verifier analyzes the branch, it splits the register states
in reg_set_min_max() into the registers of the true branch (true_reg1,
true_reg2) and the registers of the false branch (false_reg1, false_reg2).

Since the test is w6 != 0x7ffffffd, the src_reg is a known constant.
Internally, the verifier creates a "fake" register initialized as scalar
to the value of 0x7ffffffd, and then passes it onto reg_set_min_max(). Now,
for line 19, it is mathematically impossible to take the false branch of
this program, yet the verifier analyzes it. It is impossible because the
second bit of r6 will be set due to the prior or operation and the
constant in the condition has that bit unset (hex(fd) == binary(1111 1101).

When the verifier first analyzes the false / fall-through branch, it will
compute an intersection between the var_off of r6 and of the constant. This
is because the verifier creates a "fake" register initialized to the value
of the constant. The intersection result later refines both registers in
regs_refine_cond_op():

  [...]
  t = tnum_intersect(tnum_subreg(reg1->var_off), tnum_subreg(reg2->var_off));
  reg1->var_off = tnum_with_subreg(reg1->var_off, t);
  reg2->var_off = tnum_with_subreg(reg2->var_off, t);
  [...]

Since the verifier is analyzing the false branch of the conditional jump,
reg1 is equal to false_reg1 and reg2 is equal to false_reg2, i.e. the reg2
is the "fake" register that was meant to hold a constant value. The resulting
var_off of the intersection says that both registers now hold a known value
of var_off=(0x7fffffff, 0x0) or in other words: this operation manages to
make the verifier think that the "constant" value that was passed in the
jump operation now holds a different value.

Normally this would not be an issue since it should not influence the true
branch, however, false_reg2 and true_reg2 are pointers to the same "fake"
register. Meaning, the false branch can influence the results of the true
branch. In line 24, the verifier assumes R6_w=0, but the actual runtime
value in this case is 1. The fix is simply not passing in the same "fake"
register location as inputs to reg_set_min_max(), but instead making a
copy. With this, the verifier successfully rejects invalid accesses from
the test program.

  [0] https://github.com/google/buzzer

Fixes: 67420501e868 ("bpf: generalize reg_set_min_max() to handle non-const register comparisons")
Reported-by: Juan José López Jaimez <jjlopezjaimez@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 36ef8e96787e..366b312203d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15112,8 +15112,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *other_branch;
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
+	struct bpf_reg_state fake_reg1 = {}, fake_reg2 = {};
 	struct bpf_reg_state *eq_branch_regs;
-	struct bpf_reg_state fake_reg = {};
 	u8 opcode = BPF_OP(insn->code);
 	bool is_jmp32;
 	int pred = -1;
@@ -15179,7 +15179,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
 			return -EINVAL;
 		}
-		src_reg = &fake_reg;
+		src_reg = &fake_reg1;
 		src_reg->type = SCALAR_VALUE;
 		__mark_reg_known(src_reg, insn->imm);
 	}
@@ -15239,10 +15239,15 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 				      &other_branch_regs[insn->src_reg],
 				      dst_reg, src_reg, opcode, is_jmp32);
 	} else /* BPF_SRC(insn->code) == BPF_K */ {
+		/* reg_set_min_max() can mangle the fake_reg. Make a copy
+		 * so that these are two different memory locations. The
+		 * src_reg is not used beyond here in context of K.
+		 */
+		memcpy(&fake_reg2, &fake_reg1, sizeof(fake_reg1));
 		err = reg_set_min_max(env,
 				      &other_branch_regs[insn->dst_reg],
-				      src_reg /* fake one */,
-				      dst_reg, src_reg /* same fake one */,
+				      &fake_reg1,
+				      dst_reg, &fake_reg2,
 				      opcode, is_jmp32);
 	}
 	if (err)
-- 
2.43.0


