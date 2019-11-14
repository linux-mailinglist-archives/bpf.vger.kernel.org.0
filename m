Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88CAEFC9B7
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2019 16:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKNPSg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Nov 2019 10:18:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726318AbfKNPSg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Nov 2019 10:18:36 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEFGcPp056217
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 10:18:35 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w98jparrs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 10:18:33 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 14 Nov 2019 15:18:27 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Nov 2019 15:18:24 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAEFHk7B42402114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 15:17:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45999A4069;
        Thu, 14 Nov 2019 15:18:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02F51A405D;
        Thu, 14 Nov 2019 15:18:23 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.99.199])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Nov 2019 15:18:22 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] s390/bpf: make sure JIT passes do not increase code size
Date:   Thu, 14 Nov 2019 16:18:20 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111415-0012-0000-0000-00000363A0DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111415-0013-0000-0000-0000219F1AC2
Message-Id: <20191114151820.53222-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=901 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140141
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The upcoming s390 branch length extension patches rely on "passes do
not increase code size" property in order to consistently choose between
short and long branches. Currently this property does not hold between
the first and the second passes for register save/restore sequences, as
well as various code fragments that depend on SEEN_* flags.

Generate the code during the first pass conservatively: assume register
save/restore sequences have the maximum possible length, and that all
SEEN_* flags are set.

Also refuse to JIT if this happens anyway (e.g. due to a bug), as this
might lead to verifier bypass once long branches are introduced.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 74 ++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index ce88211b9c6c..f667fe5bbae4 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -306,6 +306,24 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 	}							\
 })
 
+/*
+ * Return whether this is the first pass. The first pass is special, since we
+ * don't know any sizes yet, and thus must be conservative.
+ */
+static bool is_first_pass(struct bpf_jit *jit)
+{
+	return jit->size == 0;
+}
+
+/*
+ * Return whether this is the code generation pass. The code generation pass is
+ * special, since we should change as little as possible.
+ */
+static bool is_codegen_pass(struct bpf_jit *jit)
+{
+	return jit->prg_buf;
+}
+
 /*
  * Fill whole space with illegal instructions
  */
@@ -383,9 +401,18 @@ static int get_end(struct bpf_jit *jit, int start)
  */
 static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth)
 {
-
+	const int last = 15, save_restore_size = 6;
 	int re = 6, rs;
 
+	if (is_first_pass(jit)) {
+		/*
+		 * We don't know yet which registers are used. Reserve space
+		 * conservatively.
+		 */
+		jit->prg += (last - re + 1) * save_restore_size;
+		return;
+	}
+
 	do {
 		rs = get_start(jit, re);
 		if (!rs)
@@ -396,7 +423,7 @@ static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth)
 		else
 			restore_regs(jit, rs, re, stack_depth);
 		re++;
-	} while (re <= 15);
+	} while (re <= last);
 }
 
 /*
@@ -420,21 +447,21 @@ static void bpf_jit_prologue(struct bpf_jit *jit, u32 stack_depth)
 	/* Save registers */
 	save_restore_regs(jit, REGS_SAVE, stack_depth);
 	/* Setup literal pool */
-	if (jit->seen & SEEN_LITERAL) {
+	if (is_first_pass(jit) || (jit->seen & SEEN_LITERAL)) {
 		/* basr %r13,0 */
 		EMIT2(0x0d00, REG_L, REG_0);
 		jit->base_ip = jit->prg;
 	}
 	/* Setup stack and backchain */
-	if (jit->seen & SEEN_STACK) {
-		if (jit->seen & SEEN_FUNC)
+	if (is_first_pass(jit) || (jit->seen & SEEN_STACK)) {
+		if (is_first_pass(jit) || (jit->seen & SEEN_FUNC))
 			/* lgr %w1,%r15 (backchain) */
 			EMIT4(0xb9040000, REG_W1, REG_15);
 		/* la %bfp,STK_160_UNUSED(%r15) (BPF frame pointer) */
 		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15, STK_160_UNUSED);
 		/* aghi %r15,-STK_OFF */
 		EMIT4_IMM(0xa70b0000, REG_15, -(STK_OFF + stack_depth));
-		if (jit->seen & SEEN_FUNC)
+		if (is_first_pass(jit) || (jit->seen & SEEN_FUNC))
 			/* stg %w1,152(%r15) (backchain) */
 			EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
 				      REG_15, 152);
@@ -476,7 +503,7 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 	_EMIT2(0x07fe);
 
 	if (__is_defined(CC_USING_EXPOLINE) && !nospec_disable &&
-	    (jit->seen & SEEN_FUNC)) {
+	    (is_first_pass(jit) || (jit->seen & SEEN_FUNC))) {
 		jit->r1_thunk_ip = jit->prg;
 		/* Generate __s390_indirect_jump_r1 thunk */
 		if (test_facility(35)) {
@@ -1285,6 +1312,34 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	return insn_count;
 }
 
+/*
+ * Return whether new i-th instruction address does not violate any invariant
+ */
+static bool bpf_is_new_addr_sane(struct bpf_jit *jit, int i)
+{
+	/* On the first pass anything goes */
+	if (is_first_pass(jit))
+		return true;
+
+	/* The codegen pass must not change anything */
+	if (is_codegen_pass(jit))
+		return jit->addrs[i] == jit->prg;
+
+	/* Passes in between must not increase code size */
+	return jit->addrs[i] >= jit->prg;
+}
+
+/*
+ * Update the address of i-th instruction
+ */
+static int bpf_set_addr(struct bpf_jit *jit, int i)
+{
+	if (!bpf_is_new_addr_sane(jit, i))
+		return -1;
+	jit->addrs[i] = jit->prg;
+	return 0;
+}
+
 /*
  * Compile eBPF program into s390x code
  */
@@ -1297,12 +1352,15 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	jit->prg = 0;
 
 	bpf_jit_prologue(jit, fp->aux->stack_depth);
+	if (bpf_set_addr(jit, 0) < 0)
+		return -1;
 	for (i = 0; i < fp->len; i += insn_count) {
 		insn_count = bpf_jit_insn(jit, fp, i, extra_pass);
 		if (insn_count < 0)
 			return -1;
 		/* Next instruction address */
-		jit->addrs[i + insn_count] = jit->prg;
+		if (bpf_set_addr(jit, i + insn_count) < 0)
+			return -1;
 	}
 	bpf_jit_epilogue(jit, fp->aux->stack_depth);
 
-- 
2.23.0

