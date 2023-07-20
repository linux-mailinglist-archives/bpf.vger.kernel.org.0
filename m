Return-Path: <bpf+bounces-5406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C925875A360
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDDB1C211EB
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D77337D;
	Thu, 20 Jul 2023 00:22:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA317F
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:22:18 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A07E1FF3
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:21:47 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3BAF6C151980
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689812486; bh=BevXS4MJadYTsPajxwR1JQdyVBlitB/h9PNCkTU9n0Q=;
	h=To:CC:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YvS+KkBB1CCEwAam6O9zEIpPdaxh7gBsR1rKknsmfF+k23x0orH++KO2tVVzD7OVv
	 ExknWWcl5vDgBu31QIyYtwEpBiOQGKKCywjBKHBVD7E9cFiE7K6n5K6yk872TkkMMb
	 L/3Qtn+6skd794TCyYA9N87/w4ZfkMPd2a6oM5fw=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 12897C1516EA;
 Wed, 19 Jul 2023 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1689812486; bh=BevXS4MJadYTsPajxwR1JQdyVBlitB/h9PNCkTU9n0Q=;
 h=From:To:CC:Date:In-Reply-To:References:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=xONdKPO+5QVnFu2kBkPfqz4BnlhXTgc5+cRlNwcS7rZdr0RuQ8kmSLZJoZdk6NdNJ
 E56c0CwmOltuwIQ6KrE/LyczTF9epJo4W5FVD6wRep5f9WXNJApfVwfEgLKXnMkbr+
 63LzOcSWYczkqNOOnOmmvRXIyW/7A9Sb/0wGoSFk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id DFE89C1516EA
 for <bpf@ietfa.amsl.com>; Wed, 19 Jul 2023 17:21:24 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.746
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=fb.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I_avpOLXsUde for <bpf@ietfa.amsl.com>;
 Wed, 19 Jul 2023 17:21:21 -0700 (PDT)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 42614C151064
 for <bpf@ietf.org>; Wed, 19 Jul 2023 17:21:21 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JMZxr4031400 for <bpf@ietf.org>; Wed, 19 Jul 2023 17:02:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JvwS+eQtAyiZfca19jlDDiEqhj/SUG9J5VgEzpy4wvw=;
 b=DyyRYBbBCli0toWYGgjspNgoNfksbeRqpEpyqo3N7hcHyZEYMOdSHpA8ik3Jbe7zZmFy
 ZvFmrZhPtHZCIdLeEANMxCrxPs6BaJZV+98dCPQOfiPLm/WecqHyMCJKl9EJLCnaWGbN
 X4dnY3gnd1GZb+eJ+Vu9XR/JkaEbR1XXs7g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxbc6q1aa-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <bpf@ietf.org>; Wed, 19 Jul 2023 17:02:13 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:01:41 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
 id C7A942354E876; Wed, 19 Jul 2023 17:01:29 -0700 (PDT)
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song
 <maskray@google.com>, <kernel-team@fb.com>
Date: Wed, 19 Jul 2023 17:01:29 -0700
Message-ID: <20230720000129.104838-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720000103.99949-1-yhs@fb.com>
References: <20230720000103.99949-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FB-Internal: Safe
X-Proofpoint-GUID: ptgwTeosgYBzwrO2cyPPqcuXJgDBaCte
X-Proofpoint-ORIG-GUID: ptgwTeosgYBzwrO2cyPPqcuXJgDBaCte
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/PRCv2OzwgenIdLGClABe8um0yDg>
Subject: [Bpf] [PATCH bpf-next v3 05/17] bpf: Support new signed div/mod
 instructions.
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Yonghong Song <yhs@fb.com>
From: Yonghong Song <yhs=40fb.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add interpreter/jit support for new signed div/mod insns.
The new signed div/mod instructions are encoded with
unsigned div/mod instructions plus insn->off == 1.
Also add basic verifier support to ensure new insns get
accepted.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c |  27 ++++++---
 kernel/bpf/core.c           | 110 ++++++++++++++++++++++++++++++------
 kernel/bpf/verifier.c       |   6 +-
 3 files changed, 117 insertions(+), 26 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4942a4c188b9..a89b62eb2b40 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1194,15 +1194,26 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 				/* mov rax, dst_reg */
 				emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
 
-			/*
-			 * xor edx, edx
-			 * equivalent to 'xor rdx, rdx', but one byte less
-			 */
-			EMIT2(0x31, 0xd2);
+			if (insn->off == 0) {
+				/*
+				 * xor edx, edx
+				 * equivalent to 'xor rdx, rdx', but one byte less
+				 */
+				EMIT2(0x31, 0xd2);
 
-			/* div src_reg */
-			maybe_emit_1mod(&prog, src_reg, is64);
-			EMIT2(0xF7, add_1reg(0xF0, src_reg));
+				/* div src_reg */
+				maybe_emit_1mod(&prog, src_reg, is64);
+				EMIT2(0xF7, add_1reg(0xF0, src_reg));
+			} else {
+				if (BPF_CLASS(insn->code) == BPF_ALU)
+					EMIT1(0x99); /* cdq */
+				else
+					EMIT2(0x48, 0x99); /* cqo */
+
+				/* idiv src_reg */
+				maybe_emit_1mod(&prog, src_reg, is64);
+				EMIT2(0xF7, add_1reg(0xF8, src_reg));
+			}
 
 			if (BPF_OP(insn->code) == BPF_MOD &&
 			    dst_reg != BPF_REG_3)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ad58697cec4b..3fe895199f6e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1792,36 +1792,114 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		(*(s64 *) &DST) >>= IMM;
 		CONT;
 	ALU64_MOD_X:
-		div64_u64_rem(DST, SRC, &AX);
-		DST = AX;
+		switch (OFF) {
+		case 0:
+			div64_u64_rem(DST, SRC, &AX);
+			DST = AX;
+			break;
+		case 1:
+			AX = div64_s64(DST, SRC);
+			DST = DST - AX * SRC;
+			break;
+		}
 		CONT;
 	ALU_MOD_X:
-		AX = (u32) DST;
-		DST = do_div(AX, (u32) SRC);
+		switch (OFF) {
+		case 0:
+			AX = (u32) DST;
+			DST = do_div(AX, (u32) SRC);
+			break;
+		case 1:
+			AX = abs((s32)DST);
+			AX = do_div(AX, abs((s32)SRC));
+			if ((s32)DST < 0)
+				DST = (u32)-AX;
+			else
+				DST = (u32)AX;
+			break;
+		}
 		CONT;
 	ALU64_MOD_K:
-		div64_u64_rem(DST, IMM, &AX);
-		DST = AX;
+		switch (OFF) {
+		case 0:
+			div64_u64_rem(DST, IMM, &AX);
+			DST = AX;
+			break;
+		case 1:
+			AX = div64_s64(DST, IMM);
+			DST = DST - AX * IMM;
+			break;
+		}
 		CONT;
 	ALU_MOD_K:
-		AX = (u32) DST;
-		DST = do_div(AX, (u32) IMM);
+		switch (OFF) {
+		case 0:
+			AX = (u32) DST;
+			DST = do_div(AX, (u32) IMM);
+			break;
+		case 1:
+			AX = abs((s32)DST);
+			AX = do_div(AX, abs((s32)IMM));
+			if ((s32)DST < 0)
+				DST = (u32)-AX;
+			else
+				DST = (u32)AX;
+			break;
+		}
 		CONT;
 	ALU64_DIV_X:
-		DST = div64_u64(DST, SRC);
+		switch (OFF) {
+		case 0:
+			DST = div64_u64(DST, SRC);
+			break;
+		case 1:
+			DST = div64_s64(DST, SRC);
+			break;
+		}
 		CONT;
 	ALU_DIV_X:
-		AX = (u32) DST;
-		do_div(AX, (u32) SRC);
-		DST = (u32) AX;
+		switch (OFF) {
+		case 0:
+			AX = (u32) DST;
+			do_div(AX, (u32) SRC);
+			DST = (u32) AX;
+			break;
+		case 1:
+			AX = abs((s32)DST);
+			do_div(AX, abs((s32)SRC));
+			if ((s32)DST < 0 == (s32)SRC < 0)
+				DST = (u32)AX;
+			else
+				DST = (u32)-AX;
+			break;
+		}
 		CONT;
 	ALU64_DIV_K:
-		DST = div64_u64(DST, IMM);
+		switch (OFF) {
+		case 0:
+			DST = div64_u64(DST, IMM);
+			break;
+		case 1:
+			DST = div64_s64(DST, IMM);
+			break;
+		}
 		CONT;
 	ALU_DIV_K:
-		AX = (u32) DST;
-		do_div(AX, (u32) IMM);
-		DST = (u32) AX;
+		switch (OFF) {
+		case 0:
+			AX = (u32) DST;
+			do_div(AX, (u32) IMM);
+			DST = (u32) AX;
+			break;
+		case 1:
+			AX = abs((s32)DST);
+			do_div(AX, abs((s32)IMM));
+			if ((s32)DST < 0 == (s32)IMM < 0)
+				DST = (u32)AX;
+			else
+				DST = (u32)-AX;
+			break;
+		}
 		CONT;
 	ALU_END_TO_BE:
 		switch (IMM) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b305f88c2569..9436fa795f39 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13237,7 +13237,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	} else {	/* all other ALU ops: and, sub, xor, add, ... */
 
 		if (BPF_SRC(insn->code) == BPF_X) {
-			if (insn->imm != 0 || insn->off != 0) {
+			if (insn->imm != 0 || insn->off > 1 ||
+			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
 			}
@@ -13246,7 +13247,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			if (err)
 				return err;
 		} else {
-			if (insn->src_reg != BPF_REG_0 || insn->off != 0) {
+			if (insn->src_reg != BPF_REG_0 || insn->off > 1 ||
+			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
 			}
-- 
2.34.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

