Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5052680118
	for <lists+bpf@lfdr.de>; Sun, 29 Jan 2023 20:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjA2TFj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Jan 2023 14:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjA2TFf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Jan 2023 14:05:35 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3969112878
        for <bpf@vger.kernel.org>; Sun, 29 Jan 2023 11:05:34 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TE7Obd029003;
        Sun, 29 Jan 2023 19:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UHTikA6CfkLMa1hxC4XB96o8djCki6hSW5x+FRSR0EA=;
 b=hHeScjCAysnJgaO+jtvo0qmrmV9F05YTJFuY9upVsg+gD9Y94MpomyvZcVlUSqtebVMn
 k9B2xqk0duS1uKjD9AQYTjZOgMC+fZEH0Z8/w48cz3aummQZ3kiIb4SDQ3iot0gcAaN6
 qCYHqoG3Njfb24E8CIhYlvmSqqzlAV6iIjMkjjNm8i9Hj8H5sCJG27ICmaidaq1ewhsN
 k1cA/AoSWhYAHUre3Q58hzIX6wyuHfqGXBvWzGFOgX3t8zXBxQlZzhg5jipDH5kdmO2u
 XBoxNZ91foXjbyEncsEe+IbXlgKxmVCJqHTmbCaq4SwgIdJgzbmhiC8BVTRqe6O5KzrK LQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddj5naun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:15 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30T4gUGL014735;
        Sun, 29 Jan 2023 19:05:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ncvttsd7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30TJ59sM29032830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 19:05:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0CFB20043;
        Sun, 29 Jan 2023 19:05:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3730220040;
        Sun, 29 Jan 2023 19:05:09 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 29 Jan 2023 19:05:09 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 5/8] s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()
Date:   Sun, 29 Jan 2023 20:04:58 +0100
Message-Id: <20230129190501.1624747-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129190501.1624747-1-iii@linux.ibm.com>
References: <20230129190501.1624747-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZC8zP-yAi2lzXDryhUvYldZv13VRCGbF
X-Proofpoint-ORIG-GUID: ZC8zP-yAi2lzXDryhUvYldZv13VRCGbF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow mixing subprogs and tail calls by passing the current tail
call count to subprogs.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 37 ++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 3fe082d5328d..b84c7ddb758a 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -58,7 +58,6 @@ struct bpf_jit {
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
 #define SEEN_LITERAL	BIT(1)		/* code uses literals */
 #define SEEN_FUNC	BIT(2)		/* calls C functions */
-#define SEEN_TAIL_CALL	BIT(3)		/* code uses tail calls */
 #define SEEN_STACK	(SEEN_FUNC | SEEN_MEM)
 
 /*
@@ -549,20 +548,23 @@ static void bpf_jit_plt(void *plt, void *ret, void *target)
  * Save registers and create stack frame if necessary.
  * See stack frame layout description in "bpf_jit.h"!
  */
-static void bpf_jit_prologue(struct bpf_jit *jit, u32 stack_depth)
+static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
+			     u32 stack_depth)
 {
 	/* No-op for hotpatching */
 	/* brcl 0,prologue_plt */
 	EMIT6_PCREL_RILC(0xc0040000, 0, jit->prologue_plt);
 	jit->prologue_plt_ret = jit->prg;
 
-	if (jit->seen & SEEN_TAIL_CALL) {
+	if (fp->aux->func_idx == 0) {
+		/* Initialize the tail call counter in the main program. */
 		/* xc STK_OFF_TCCNT(4,%r15),STK_OFF_TCCNT(%r15) */
 		_EMIT6(0xd703f000 | STK_OFF_TCCNT, 0xf000 | STK_OFF_TCCNT);
 	} else {
 		/*
-		 * There are no tail calls. Insert nops in order to have
-		 * tail_call_start at a predictable offset.
+		 * Skip the tail call counter initialization in subprograms.
+		 * Insert nops in order to have tail_call_start at a
+		 * predictable offset.
 		 */
 		bpf_skip(jit, 6);
 	}
@@ -1410,6 +1412,19 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 
 		REG_SET_SEEN(BPF_REG_5);
 		jit->seen |= SEEN_FUNC;
+		/*
+		 * Copy the tail call counter to where the callee expects it.
+		 *
+		 * Note 1: The callee can increment the tail call counter, but
+		 * we do not load it back, since the x86 JIT does not do this
+		 * either.
+		 *
+		 * Note 2: We assume that the verifier does not let us call the
+		 * main program, which clears the tail call counter on entry.
+		 */
+		/* mvc STK_OFF_TCCNT(4,%r15),N(%r15) */
+		_EMIT6(0xd203f000 | STK_OFF_TCCNT,
+		       0xf000 | (STK_OFF_TCCNT + STK_OFF + stack_depth));
 		/* lgrl %w1,func */
 		EMIT6_PCREL_RILB(0xc4080000, REG_W1, _EMIT_CONST_U64(func));
 		/* %r1() */
@@ -1426,10 +1441,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 *  B1: pointer to ctx
 		 *  B2: pointer to bpf_array
 		 *  B3: index in bpf_array
-		 */
-		jit->seen |= SEEN_TAIL_CALL;
-
-		/*
+		 *
 		 * if (index >= array->map.max_entries)
 		 *         goto out;
 		 */
@@ -1793,7 +1805,7 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	jit->prg = 0;
 	jit->excnt = 0;
 
-	bpf_jit_prologue(jit, stack_depth);
+	bpf_jit_prologue(jit, fp, stack_depth);
 	if (bpf_set_addr(jit, 0) < 0)
 		return -1;
 	for (i = 0; i < fp->len; i += insn_count) {
@@ -2462,3 +2474,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 
 	return ret;
 }
+
+bool bpf_jit_supports_subprog_tailcalls(void)
+{
+	return true;
+}
-- 
2.39.1

