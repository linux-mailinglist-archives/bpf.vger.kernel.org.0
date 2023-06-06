Return-Path: <bpf+bounces-1966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A6724F8B
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 00:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88213280F1D
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 22:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46CF3447C;
	Tue,  6 Jun 2023 22:24:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F02DBA3
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 22:24:44 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB45C1717
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 15:24:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f63a2e1c5fso1357921e87.2
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686090280; x=1688682280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FY8DHcuOI5eQFTHipjEwufiRKLKym1KP2TWMxC+LyEA=;
        b=qRR5YK9kh6tFstiY5l23csjNesjo2MURczN2KYP43kJnxgU9IxxSo3Nw56TkJqXSYQ
         4BFOiCFGX0BkJf1xtZnMwu03DD+qHM2XMME1FUsqKYiBSNijDU7eOJ9mGEK8NBZ5sYIX
         opzFfMIkzbw3OYgcuThBWHC8hpBCe5NvEArU0e+Dsea3dg7jZSi/Oy7DmPHI9DiwD+fl
         Hkqp3gDynfzBHfTLIoGcqvkxPSXXWNf9Kq29wsFA6MG92Q4d+ksDsFP31rpgussMIA7c
         /qQxUqU0tVincpaaOkIsWurmW9Po2+45mca3Dxf+oSsc9skdhi5o77X+OHnzQ9OqG4T8
         EHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090280; x=1688682280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FY8DHcuOI5eQFTHipjEwufiRKLKym1KP2TWMxC+LyEA=;
        b=Tr2l+0+AX1XxKcNSmlH95KAwBZI2pgtxOHhYNaPNYk0DYJqhdhlmbyDjtKtnUKyGZX
         Ps3/W3d2/0+VTzZUY0waqFyuZ0PNyODtzVxZHFzOu7W2ln9EA0N5LKmpcH2ytrV/OIKn
         8jwRiSFXRIxurIxJJ2Aopuopgyfm+3dSvJI7vYdvJEQYYDhzEv7Lb7KJZt2rUON22w4m
         NgEU+roKBM5IX6rpS4AZHcVH/Isez12zphTVIXgSYb+rSJBvIggo+B43qxGzrgYiU9AK
         XJOy+17Ut8rvgmHO2Pj6NZGvi7jnSfHRgftlv13JhzLkq6cf8eN6n+qrWqSDtbxJNlbq
         sSZA==
X-Gm-Message-State: AC+VfDzp/pb1tyxd7BehENfheqvaHhyuWlvm+OiziqUcOSthhF+qrODm
	+OdKsmmSb0yQx87HN8oUT3ybNWFtbyw=
X-Google-Smtp-Source: ACHHUZ5mroYLbD5/gmnz/+QhVZviiZ6AuMM4o4M79N7uerGu05LFfhdHc7Tkern4iiB1araI4AuMLQ==
X-Received: by 2002:ac2:55aa:0:b0:4ed:b263:5e64 with SMTP id y10-20020ac255aa000000b004edb2635e64mr1427255lfg.27.1686090280517;
        Tue, 06 Jun 2023 15:24:40 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r15-20020ac252af000000b004f3a79c9e0fsm1577487lfm.57.2023.06.06.15.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:24:40 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 3/4] bpf: verify scalar ids mapping in regsafe() using check_ids()
Date: Wed,  7 Jun 2023 01:24:10 +0300
Message-Id: <20230606222411.1820404-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606222411.1820404-1-eddyz87@gmail.com>
References: <20230606222411.1820404-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make sure that the following unsafe example is rejected by verifier:

1: r9 = ... some pointer with range X ...
2: r6 = ... unbound scalar ID=a ...
3: r7 = ... unbound scalar ID=b ...
4: if (r6 > r7) goto +1
5: r6 = r7
6: if (r6 > X) goto ...
--- checkpoint ---
7: r9 += r7
8: *(u64 *)r9 = Y

This example is unsafe because not all execution paths verify r7 range.
Because of the jump at (4) the verifier would arrive at (6) in two states:
I.  r6{.id=b}, r7{.id=b} via path 1-6;
II. r6{.id=a}, r7{.id=b} via path 1-4, 6.

Currently regsafe() does not call check_ids() for scalar registers,
thus from POV of regsafe() states (I) and (II) are identical. If the
path 1-6 is taken by verifier first, and checkpoint is created at (6)
the path [1-4, 6] would be considered safe.

This commit updates regsafe() to call check_ids() for precise scalar
registers.

To minimize the impact on verification performance, avoid generating
bpf_reg_state::id for constant scalar values when processing BPF_MOV
in check_alu_op(). Scalar IDs are utilized by find_equal_scalars() to
propagate information about value ranges for registers that hold the
same value. However, there is no need to propagate range information
for constants.

Still, there is some performance impact because of this change.
Using veristat to compare number of processed states for selftests
object files listed in tools/testing/selftests/bpf/veristat.cfg and
Cilium object files from [1] gives the following statistics:

$ ./veristat -e file,prog,states -f "states_pct>10" \
    -C master-baseline.log current.log
File         Program                         States  (DIFF)
-----------  ------------------------------  --------------
bpf_xdp.o    tail_handle_nat_fwd_ipv6        +155 (+23.92%)
bpf_xdp.o    tail_nodeport_nat_ingress_ipv4  +102 (+27.20%)
bpf_xdp.o    tail_rev_nodeport_lb4            +83 (+20.85%)
loop6.bpf.o  trace_virtqueue_add_sgs          +25 (+11.06%)

Also test case verifier_search_pruning/allocated_stack has to be
updated to avoid conflicts in register ID assignments between cached
and new states.

[1] git@github.com:anakryiko/cilium.git

Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assignments.")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                         | 34 ++++++++++++++++---
 .../bpf/progs/verifier_search_pruning.c       |  3 +-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2aa60b73f1b5..175ca22b868e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12933,12 +12933,14 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		if (BPF_SRC(insn->code) == BPF_X) {
 			struct bpf_reg_state *src_reg = regs + insn->src_reg;
 			struct bpf_reg_state *dst_reg = regs + insn->dst_reg;
+			bool need_id = (src_reg->type == SCALAR_VALUE && !src_reg->id &&
+					!tnum_is_const(src_reg->var_off));
 
 			if (BPF_CLASS(insn->code) == BPF_ALU64) {
 				/* case: R1 = R2
 				 * copy register state to dest reg
 				 */
-				if (src_reg->type == SCALAR_VALUE && !src_reg->id)
+				if (need_id)
 					/* Assign src and dst registers the same ID
 					 * that will be used by find_equal_scalars()
 					 * to propagate min/max range.
@@ -12957,7 +12959,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				} else if (src_reg->type == SCALAR_VALUE) {
 					bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;
 
-					if (is_src_reg_u32 && !src_reg->id)
+					if (is_src_reg_u32 && need_id)
 						src_reg->id = ++env->id_gen;
 					copy_register_state(dst_reg, src_reg);
 					/* Make sure ID is cleared if src_reg is not in u32 range otherwise
@@ -15289,9 +15291,33 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			return false;
 		if (!rold->precise)
 			return true;
-		/* new val must satisfy old val knowledge */
+		/* Why check_ids() for scalar registers?
+		 *
+		 * Consider the following BPF code:
+		 *   1: r6 = ... unbound scalar, ID=a ...
+		 *   2: r7 = ... unbound scalar, ID=b ...
+		 *   3: if (r6 > r7) goto +1
+		 *   4: r6 = r7
+		 *   5: if (r6 > X) goto ...
+		 *   6: ... memory operation using r7 ...
+		 *
+		 * First verification path is [1-6]:
+		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
+		 * - at (5) r6 would be marked <= X, find_equal_scalars() would also mark
+		 *   r7 <= X, because r6 and r7 share same id.
+		 * Next verification path is [1-4, 6].
+		 *
+		 * Instruction (6) would be reached in two states:
+		 *   I.  r6{.id=b}, r7{.id=b} via path 1-6;
+		 *   II. r6{.id=a}, r7{.id=b} via path 1-4, 6.
+		 *
+		 * Use check_ids() to distinguish these states.
+		 * ---
+		 * Also verify that new value satisfies old value range knowledge.
+		 */
 		return range_within(rold, rcur) &&
-		       tnum_in(rold->var_off, rcur->var_off);
+		       tnum_in(rold->var_off, rcur->var_off) &&
+		       check_ids(rold->id, rcur->id, idmap);
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
 	case PTR_TO_MEM:
diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
index 5a14498d352f..bb3cd14bb3a1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
+++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
@@ -271,7 +271,7 @@ l2_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("allocated_stack")
-__success __msg("processed 15 insns")
+__success __msg("processed 16 insns")
 __success_unpriv __msg_unpriv("") __log_level(1) __retval(0)
 __naked void allocated_stack(void)
 {
@@ -279,6 +279,7 @@ __naked void allocated_stack(void)
 	r6 = r1;					\
 	call %[bpf_get_prandom_u32];			\
 	r7 = r0;					\
+	call %[bpf_get_prandom_u32];			\
 	if r0 == 0 goto l0_%=;				\
 	r0 = 0;						\
 	*(u64*)(r10 - 8) = r6;				\
-- 
2.40.1


