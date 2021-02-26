Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96343326996
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 22:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBZVch (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 16:32:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230303AbhBZVce (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 16:32:34 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QLSss0047257;
        Fri, 26 Feb 2021 16:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rmwVZzDC30ohVj4OrPPR/FtdZ6lSklm6BSgBE0htdr8=;
 b=m0uzKsTfz8ujxyV63WW/oR79n7cCNb7JbIQC1EVdcZlVPnetZ+WvATcElkauYTR2jxLT
 uaKqPDeAGqrgqEY6gsxudKDjVW7aCVRyplcShzHoYlAXBqgTIzIC3gRkKdvxDFKc057H
 y7pDWV08+5n4do0nZ4vuSu/9ZDj/fYJOaCcsCnjepeSMMo6NP/fb6HzmdFF1drErPmbj
 rWc5YXqVvgk7u3QqmTf6s5cNeG7lrKDw4BVKVjMytAhI1eRdCXRZP+u0On1WHz99gOJU
 HuGLKjE0baScup65VF42dR18WUxQyzU84676MTIR0G+MBezt4F4TL53xWafBQkry3eKb HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y8xb015c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 16:31:39 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11QLTeTT051253;
        Fri, 26 Feb 2021 16:31:39 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y8xb014t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 16:31:39 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QLMIAc021361;
        Fri, 26 Feb 2021 21:31:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 36tt28u08h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 21:31:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QLVX7d43581886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 21:31:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE1A0A4040;
        Fri, 26 Feb 2021 21:31:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 380F6A4051;
        Fri, 26 Feb 2021 21:31:33 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 21:31:33 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Brendan Jackman <jackmanb@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf] bpf: Account for BPF_FETCH in insn_has_def32()
Date:   Fri, 26 Feb 2021 22:31:31 +0100
Message-Id: <20210226213131.118173-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_09:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102260157
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
---

v1: https://lore.kernel.org/bpf/20210224141837.104654-1-iii@linux.ibm.com/
v1 -> v2: Per Martin's comments: rebase against the bpf branch, fix the
          Fixes: tag, fix the comment style, replace ?: with the more
          readable if-else, handle the internal verifier error using
          WARN_ON_ONCE(), verbose() and -EFAULT.

 kernel/bpf/verifier.c | 70 ++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d34ba492d46..4730d5628b02 100644
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
+		if (WARN_ON_ONCE(load_reg == -1)) {
+			verbose(env, "zext_dst is set, but no reg is defined\n");
+			return -EFAULT;
 		}
 
 		zext_patch[0] = insn;
-- 
2.29.2

