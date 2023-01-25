Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0967BECB
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbjAYVkC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjAYVjz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5522F783
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:52 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLqBR027295;
        Wed, 25 Jan 2023 21:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fRsK5ZvcsVESdWk6u40yHBMw3EWwDq0Nb1OaZOxrhpk=;
 b=IFg4n2WMf/6gCd7wyfPAfKfCdsg9TaeuJO3pX8oQLvlwEjQ7rfBxKkMBMtfwDg4cGS9U
 JGp4IeKJcwK6Opvbzcrjbw4P5dz+dZjJh/2vqYwcKs8hu+wPsKH08O6FZApReYJ+xBMq
 unEvNOx6RwwB2mfhPWigHmV4rrFbgxp1gWgyeIhoPOBqoVYfK2x2zEEFI5e/MhVpIpTX
 rjTz8oEqtVobhQ0ouPY7Z9nzPR4Ve0zzupvxkjbsyQsvOtX+nqRKzPCrhx+uLnA3QcXx
 txjVMctG/3JEAxQd9RG2sWcODxl3OqtT5M8+oph1u0wS8ObMFETx5PMcfUYooInw/b+3 bA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb6na2w7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:40 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEs8Ap015310;
        Wed, 25 Jan 2023 21:39:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6c0wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdYa422217088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32BFB20043;
        Wed, 25 Jan 2023 21:39:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 000BC20040;
        Wed, 25 Jan 2023 21:39:33 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:33 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 23/24] s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()
Date:   Wed, 25 Jan 2023 22:38:16 +0100
Message-Id: <20230125213817.1424447-24-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kvmLgvcv9JBYqmHn2xyRybwBj8xkXnRI
X-Proofpoint-ORIG-GUID: kvmLgvcv9JBYqmHn2xyRybwBj8xkXnRI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index ea8203bd4112..f4cdecb32629 100644
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
@@ -2455,3 +2467,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 
 	return ret;
 }
+
+bool bpf_jit_supports_subprog_tailcalls(void)
+{
+	return true;
+}
-- 
2.39.1

