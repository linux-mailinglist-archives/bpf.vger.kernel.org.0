Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ACF324118
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 17:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhBXPkz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 10:40:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234935AbhBXOUK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 09:20:10 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OE2sNT062743;
        Wed, 24 Feb 2021 09:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HJbMTsWESOFt4kZeS7nIgzjkOTMhKFoR98G1ivOAfD4=;
 b=RfR+rKGseufsfnCydTUecU1Im5j2Gl8AJhEnegNkKSOim6O7tugGemYpfMAFrMwc5RPp
 +9/ts6Hdsx7daKY09irFTgIFTxJAEh7o/eKo7fnGo+07jT0Drcmv7GjhdFY4CKKg7aLz
 0+G2CJjmupg9FmK089OAj/3ILeRW8mEqpmAW0M0yxS39nPHS0/auT/8lyLvIy5Swezcy
 vnpGfmYLiKfihdVZSP9BniVpARMcgnw6oqW2zHMafM07ult80OAXHjYzfoz0z5S0t7wv
 6by0S/yk1IyaStOhQmWjdCDM3NJSdwolpLgsxI+Qlfl3XZa+UKXr5wsXZqftOdxr9zCG bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wmmf7trp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 09:18:46 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11OE3aqx065775;
        Wed, 24 Feb 2021 09:18:46 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wmmf7tqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 09:18:45 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11OEIUD0017987;
        Wed, 24 Feb 2021 14:18:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt283m6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 14:18:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11OEISHh37159252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 14:18:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E32994C044;
        Wed, 24 Feb 2021 14:18:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CE1E4C046;
        Wed, 24 Feb 2021 14:18:40 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 14:18:40 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Brendan Jackman <jackmanb@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] bpf: Account for BPF_FETCH in insn_has_def32()
Date:   Wed, 24 Feb 2021 15:18:37 +0100
Message-Id: <20210224141837.104654-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_04:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240109
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

insn_has_def32() returns false for 32-bit BPF_FETCH insns. This makes
adjust_insn_aux_data() incorrectly set zext_dst, as can be seen in [1].
This happens because insn_no_def() does not know about BPF_FETCH
variants of BPF_STX.

Fix in two steps.

First, replace insn_no_def() with insn_def_regno(), which returns which
the register an insn defines. Normally insn_no_def() calls are followed
by insn->dst_reg uses; replace those with insn_def_regno() return
value.

Second, adjust the BPF_STX special case in is_reg64() to deal with
queries made from opt_subreg_zext_lo32_rnd_hi32(), where the state
information is no longer available. Add a comment, since the purpose
of this special case is not clear at the first glance.

[1] https://lore.kernel.org/bpf/20210223150845.1857620-1-jackmanb@google.com/

Fixes: 37086bfdc737 ("bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 65 ++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1dda9d81f12c..f4df805d6bfd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1703,7 +1703,10 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	if (class == BPF_STX) {
-		if (reg->type != SCALAR_VALUE)
+		/* BPF_STX (including atomic variants) has multiple source
+		 * operands, one of which is a ptr. Check whether the caller is
+		 * asking about it. */
+		if (t == SRC_OP && reg->type != SCALAR_VALUE)
 			return true;
 		return BPF_SIZE(code) == BPF_DW;
 	}
@@ -1735,22 +1738,33 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
+		return (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			(insn->imm & BPF_FETCH)) ?
+		       (insn->imm == BPF_CMPXCHG ? BPF_REG_0 : insn->src_reg) :
+		       -1;
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
@@ -11006,9 +11020,10 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
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
@@ -11018,14 +11033,14 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 
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
@@ -11040,7 +11055,7 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 			imm_rnd = get_random_int();
 			rnd_hi32_patch[0] = insn;
 			rnd_hi32_patch[1].imm = imm_rnd;
-			rnd_hi32_patch[3].dst_reg = insn.dst_reg;
+			rnd_hi32_patch[3].dst_reg = load_reg;
 			patch = rnd_hi32_patch;
 			patch_len = 4;
 			goto apply_patch_buffer;
@@ -11049,23 +11064,9 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
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
-		}
+		/* If no register is defined, zext_dst cannot be set. */
+		if (WARN_ON(load_reg == -1))
+			return -EINVAL;
 
 		zext_patch[0] = insn;
 		zext_patch[1].dst_reg = load_reg;
-- 
2.29.2

