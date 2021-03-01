Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CC33282B2
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 16:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhCAPl0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Mar 2021 10:41:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237347AbhCAPlZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Mar 2021 10:41:25 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121FbTFJ172538;
        Mon, 1 Mar 2021 10:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rqEItZcx3MG+sY+ivIs3sh1uFFSi/qK5tYq34fYft88=;
 b=SgnCJPynSNiwoGyz7iTm1xc1m13RDQTumHFq5X1m4vp7HGuECSJnavm98TA/r+pDyFLA
 ZarErkA+2cAWg6rhOuDrIxXtbZlT29tczR0zGApSKlR9VE/EmWEF4BfRZI5zMq2aG9LC
 Vx+OLXGGb8Vp3LhOyo2S0kId1bPi8s/mkT+m9WXTB4iV5W8aus6+q+UYDRbBWIkf8zqv
 SwMc0/S7LxzM5Mg33CrgtMG9ZAKDumyDpGERQ26NJh2kIqvXzUEGXUWlZWNjj+lEyRYG
 SanFJoe56zGIIz2/qSYI7q0ibjFZB5jfl8F1Pz6VwP3Ttcm7UUvNFhYqcTa6UL+AyYkD Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37103q6jh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 10:40:27 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 121FbiOH177275;
        Mon, 1 Mar 2021 10:40:26 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37103q6jfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 10:40:26 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 121FbJFC029750;
        Mon, 1 Mar 2021 15:40:24 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3712fmg0qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 15:40:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 121FeLYw43909576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Mar 2021 15:40:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE13FA4053;
        Mon,  1 Mar 2021 15:40:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F629A4059;
        Mon,  1 Mar 2021 15:40:21 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Mar 2021 15:40:21 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Jackman <jackmanb@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 bpf] bpf: Account for BPF_FETCH in insn_has_def32()
Date:   Mon,  1 Mar 2021 16:40:19 +0100
Message-Id: <20210301154019.129110-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_11:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010130
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

insn_has_def32() returns false for 32-bit BPF_FETCH insns. This makes
adjust_insn_aux_data() incorrectly set zext_dst, as can be seen in [1].
This happens because insn_no_def() does not know about the BPF_FETCH
variants of BPF_STX.

Fix in two steps.

First, replace insn_no_def() with insn_def_regno(), which returns the
register an insn defines. Normally insn_no_def() calls are followed by
insn->dst_reg uses; replace those with the insn_def_regno() return
value.

Second, adjust the BPF_STX special case in is_reg64() to deal with
queries made from opt_subreg_zext_lo32_rnd_hi32(), where the state
information is no longer available. Add a comment, since the purpose
of this special case is not clear at first glance.

[1] https://lore.kernel.org/bpf/20210223150845.1857620-1-jackmanb@google.com/

Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---

v1: https://lore.kernel.org/bpf/20210224141837.104654-1-iii@linux.ibm.com/
v1 -> v2: Per Martin's comments: rebase against the bpf branch, fix the
          Fixes: tag, fix the comment style, replace ?: with the more
          readable if-else, handle the internal verifier error using
          WARN_ON_ONCE(), verbose() and -EFAULT.

v2: https://lore.kernel.org/bpf/20210226213131.118173-1-iii@linux.ibm.com/
v2 -> v3: Per Brendan's comment, add "verifier bug." to the error
          message. Unfortunately, the load_reg assignment cannot be
          moved, because this would also require moving the insn
          assignment, and this would ruin the reverse xmas tree.

 kernel/bpf/verifier.c | 70 ++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d34ba492d46..bb3eaab934f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1703,7 +1703,11 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	if (class == BPF_STX) {
-		if (reg->type != SCALAR_VALUE)
+		/* BPF_STX (including atomic variants) has multiple source
+		 * operands, one of which is a ptr. Check whether the caller is
+		 * asking about it.
+		 */
+		if (t == SRC_OP && reg->type != SCALAR_VALUE)
 			return true;
 		return BPF_SIZE(code) == BPF_DW;
 	}
@@ -1735,22 +1739,38 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return true;
 }
 
-/* Return TRUE if INSN doesn't have explicit value define. */
-static bool insn_no_def(struct bpf_insn *insn)
+/* Return the regno defined by the insn, or -1. */
+static int insn_def_regno(const struct bpf_insn *insn)
 {
-	u8 class = BPF_CLASS(insn->code);
-
-	return (class == BPF_JMP || class == BPF_JMP32 ||
-		class == BPF_STX || class == BPF_ST);
+	switch (BPF_CLASS(insn->code)) {
+	case BPF_JMP:
+	case BPF_JMP32:
+	case BPF_ST:
+		return -1;
+	case BPF_STX:
+		if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+		    (insn->imm & BPF_FETCH)) {
+			if (insn->imm == BPF_CMPXCHG)
+				return BPF_REG_0;
+			else
+				return insn->src_reg;
+		} else {
+			return -1;
+		}
+	default:
+		return insn->dst_reg;
+	}
 }
 
 /* Return TRUE if INSN has defined any 32-bit value explicitly. */
 static bool insn_has_def32(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
-	if (insn_no_def(insn))
+	int dst_reg = insn_def_regno(insn);
+
+	if (dst_reg == -1)
 		return false;
 
-	return !is_reg64(env, insn, insn->dst_reg, NULL, DST_OP);
+	return !is_reg64(env, insn, dst_reg, NULL, DST_OP);
 }
 
 static void mark_insn_zext(struct bpf_verifier_env *env,
@@ -11006,9 +11026,10 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	for (i = 0; i < len; i++) {
 		int adj_idx = i + delta;
 		struct bpf_insn insn;
-		u8 load_reg;
+		int load_reg;
 
 		insn = insns[adj_idx];
+		load_reg = insn_def_regno(&insn);
 		if (!aux[adj_idx].zext_dst) {
 			u8 code, class;
 			u32 imm_rnd;
@@ -11018,14 +11039,14 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 
 			code = insn.code;
 			class = BPF_CLASS(code);
-			if (insn_no_def(&insn))
+			if (load_reg == -1)
 				continue;
 
 			/* NOTE: arg "reg" (the fourth one) is only used for
-			 *       BPF_STX which has been ruled out in above
-			 *       check, it is safe to pass NULL here.
+			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
+			 *       here.
 			 */
-			if (is_reg64(env, &insn, insn.dst_reg, NULL, DST_OP)) {
+			if (is_reg64(env, &insn, load_reg, NULL, DST_OP)) {
 				if (class == BPF_LD &&
 				    BPF_MODE(code) == BPF_IMM)
 					i++;
@@ -11040,7 +11061,7 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 			imm_rnd = get_random_int();
 			rnd_hi32_patch[0] = insn;
 			rnd_hi32_patch[1].imm = imm_rnd;
-			rnd_hi32_patch[3].dst_reg = insn.dst_reg;
+			rnd_hi32_patch[3].dst_reg = load_reg;
 			patch = rnd_hi32_patch;
 			patch_len = 4;
 			goto apply_patch_buffer;
@@ -11049,22 +11070,9 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 		if (!bpf_jit_needs_zext())
 			continue;
 
-		/* zext_dst means that we want to zero-extend whatever register
-		 * the insn defines, which is dst_reg most of the time, with
-		 * the notable exception of BPF_STX + BPF_ATOMIC + BPF_FETCH.
-		 */
-		if (BPF_CLASS(insn.code) == BPF_STX &&
-		    BPF_MODE(insn.code) == BPF_ATOMIC) {
-			/* BPF_STX + BPF_ATOMIC insns without BPF_FETCH do not
-			 * define any registers, therefore zext_dst cannot be
-			 * set.
-			 */
-			if (WARN_ON(!(insn.imm & BPF_FETCH)))
-				return -EINVAL;
-			load_reg = insn.imm == BPF_CMPXCHG ? BPF_REG_0
-							   : insn.src_reg;
-		} else {
-			load_reg = insn.dst_reg;
+		if (WARN_ON(load_reg == -1)) {
+			verbose(env, "verifier bug. zext_dst is set, but no reg is defined\n");
+			return -EFAULT;
 		}
 
 		zext_patch[0] = insn;
-- 
2.29.2

