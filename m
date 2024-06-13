Return-Path: <bpf+bounces-32070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00A906D31
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 13:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC98B265AF
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7F0146A8C;
	Thu, 13 Jun 2024 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="q+P166Hc"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE3137914
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279607; cv=none; b=LidWvnm8nRpvq2VQqKPdS1rkbUuFcvpzMvzfWYs07nGX7s3JbK7J+5vubltw2vSCpdAjRoVcSdiIs1DuiBF+W8Nx2ipjpMs3dggu+V8t35vLEspDuRxwpKK7vavFz1HKymlQdd/EyxGq8MyXC0p1LSvJ2rZjRX1c7yoCda7BCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279607; c=relaxed/simple;
	bh=SUBeEWbi9iRFbotRv5BAo93D2cHY44IHRdb7Ba49AWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZupKim9d9/3+OyfuKNetYXMo4zePsHJoYg02zTICu/um+LP6qLwNN/nd0AkhRaMnPAl1VGo9D7gOCReeyEEdZJnVPHu+w2XnuCeiEO24c4ZsThaPcxtJIldKMIPUZ1bpFnWwdgvsDeAwAuTwjt1ZOGJ4NFyrwf2+sC9ysOj5d8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=q+P166Hc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=G4OWiHb3vlw57g4vk3pnB/Aau4wT6BkITiks8Yezo/g=; b=q+P166HcLcBi6LeDHr2wqUrbop
	Rl4lCd6h0+0RZ6g3NTdQd+PW5xYyQRDxHWsFaEufH7VR4VkzVfqkqvppe+ZsMRf53Td8Sofzp/YHx
	adNv4soCRda8WaX8jm8GphZyqTpWVoFln3Esfqy4Nt0F2i4zKV6Bth/zarKKvamzSQasVqGrfoLFw
	QaNR6QcFxzS1kpZHBunxD35d4siq+qDcvopQ/I94h+mKtTyItFgHBol7d/aat7xXKug706tikYbtc
	fCbyEHOdf9ftRY227ZUojSdUv8EOR6tPaJ1XFIw0Qim/sGoq5CEW84wEGA02EGzh6janB1y09iNRD
	CVUbbBIw==;
Received: from 34.249.197.178.dynamic.cust.swisscom.net ([178.197.249.34] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sHj16-000G9f-PQ; Thu, 13 Jun 2024 13:53:20 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	jjlopezjaimez@google.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 1/3] bpf: Fix reg_set_min_max corruption of fake_reg
Date: Thu, 13 Jun 2024 13:53:08 +0200
Message-Id: <20240613115310.25383-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27305/Thu Jun 13 10:33:25 2024)

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
copy. Moving the fake_reg into the env also reduces stack consumption by
120 bytes. With this, the verifier successfully rejects invalid accesses
from the test program.

  [0] https://github.com/google/buzzer

Fixes: 67420501e868 ("bpf: generalize reg_set_min_max() to handle non-const register comparisons")
Reported-by: Juan José López Jaimez <jjlopezjaimez@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
  - Reduce stack space consumption (Alexei)

 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 14 ++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 50aa87f8d77f..e4070fb02b11 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -746,6 +746,8 @@ struct bpf_verifier_env {
 	/* Same as scratched_regs but for stack slots */
 	u64 scratched_stack_slots;
 	u64 prev_log_pos, prev_insn_print_pos;
+	/* buffer used to temporary hold constants as scalar registers */
+	struct bpf_reg_state fake_reg[2];
 	/* buffer used to generate temporary string representations,
 	 * e.g., in reg_type_str() to generate reg_type string
 	 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 36ef8e96787e..f455548ba46c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15113,7 +15113,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
 	struct bpf_reg_state *eq_branch_regs;
-	struct bpf_reg_state fake_reg = {};
 	u8 opcode = BPF_OP(insn->code);
 	bool is_jmp32;
 	int pred = -1;
@@ -15179,7 +15178,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
 			return -EINVAL;
 		}
-		src_reg = &fake_reg;
+		src_reg = &env->fake_reg[0];
+		memset(src_reg, 0, sizeof(*src_reg));
 		src_reg->type = SCALAR_VALUE;
 		__mark_reg_known(src_reg, insn->imm);
 	}
@@ -15239,10 +15239,16 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 				      &other_branch_regs[insn->src_reg],
 				      dst_reg, src_reg, opcode, is_jmp32);
 	} else /* BPF_SRC(insn->code) == BPF_K */ {
+		/* reg_set_min_max() can mangle the fake_reg. Make a copy
+		 * so that these are two different memory locations. The
+		 * src_reg is not used beyond here in context of K.
+		 */
+		memcpy(&env->fake_reg[1], &env->fake_reg[0],
+		       sizeof(env->fake_reg[0]));
 		err = reg_set_min_max(env,
 				      &other_branch_regs[insn->dst_reg],
-				      src_reg /* fake one */,
-				      dst_reg, src_reg /* same fake one */,
+				      &env->fake_reg[0],
+				      dst_reg, &env->fake_reg[1],
 				      opcode, is_jmp32);
 	}
 	if (err)
-- 
2.43.0


