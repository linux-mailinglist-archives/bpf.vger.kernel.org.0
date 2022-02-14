Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB7D4B4DE1
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350499AbiBNLOB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:14:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350249AbiBNLNv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:13:51 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC5CEBDEC
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 02:43:08 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E9EYxU012544;
        Mon, 14 Feb 2022 10:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cvC9ObvzbPeJImfegywRzrG32AOasf1vvzL4P8RqNwo=;
 b=gdc7/xxl8reYL6iv0NMEcuNaEDsKR5SMmUon/sqLzrRqDgzBCN9X1cENrbpXfd57W9jy
 DZPfH7+aonERLyV9usLMazfXfjl8T1eaKpIixzN62Atj66dpTYwoChHt8CHWfjVoa1D7
 j581eIndTE4pRPGhDPALJ1flxMd8wtRYxRiQw1yl2uQHMC8c4z/rsG8pwQaPbxcFDT+U
 8eXURyQhl8zBFyt913n6HFJyJ4N3bjNaG6zENZntIJUQxWPRmdiiDzJ6GMDcGmPQo1eG
 8Ia60eEsMlRgl1ndErQ7w9jYi8nTB391So7+R94BbdAUmJgEsn6qxoM4DXRIV5Wyl8st gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7c4dtp9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:42 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21E9d6V0013910;
        Mon, 14 Feb 2022 10:42:41 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7c4dtp90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EAXYL4000926;
        Mon, 14 Feb 2022 10:42:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645jc383-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:40 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EAgb3932833918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:42:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2826AE059;
        Mon, 14 Feb 2022 10:42:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1BDDAE045;
        Mon, 14 Feb 2022 10:42:34 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.124.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 10:42:34 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <bpf@vger.kernel.org>
Subject: [PATCH powerpc/next 11/17] powerpc64/bpf: Convert some of the uses of PPC_BPF_[LL|STL] to PPC_BPF_[LD|STD]
Date:   Mon, 14 Feb 2022 16:11:45 +0530
Message-Id: <0eb472428165a307f6fdaf22b0c33cbf13a9a635.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aZcVICrcDgTOmsjqf5v_Ys67Mud2IhM9
X-Proofpoint-ORIG-GUID: KgKB4ESyAHWLaf91gCzRClvJD2VNpFXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PPC_BPF_[LL|STL] are macros meant for scenarios where we may have to
deal with a non-word aligned offset. Limit their usage to only those
scenarios by converting the rest to just use PPC_BPF_[LD|STD].

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index bff200723e7282..411ac41dba4293 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -74,7 +74,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 	int i;
 
 	if (__is_defined(PPC64_ELF_ABI_v2))
-		PPC_BPF_LL(_R2, _R13, offsetof(struct paca_struct, kernel_toc));
+		EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
 
 	/*
 	 * Initialize tail_call_cnt if we do tail calls.
@@ -84,7 +84,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 	if (ctx->seen & SEEN_TAILCALL) {
 		EMIT(PPC_RAW_LI(b2p[TMP_REG_1], 0));
 		/* this goes in the redzone */
-		PPC_BPF_STL(b2p[TMP_REG_1], 1, -(BPF_PPC_STACK_SAVE + 8));
+		EMIT(PPC_RAW_STD(b2p[TMP_REG_1], 1, -(BPF_PPC_STACK_SAVE + 8)));
 	} else {
 		EMIT(PPC_RAW_NOP());
 		EMIT(PPC_RAW_NOP());
@@ -97,7 +97,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		 */
 		if (ctx->seen & SEEN_FUNC) {
 			EMIT(PPC_RAW_MFLR(_R0));
-			PPC_BPF_STL(0, 1, PPC_LR_STKOFF);
+			EMIT(PPC_RAW_STD(0, 1, PPC_LR_STKOFF));
 		}
 
 		PPC_BPF_STLU(1, 1, -(BPF_PPC_STACKFRAME + ctx->stack_size));
@@ -110,7 +110,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 	 */
 	for (i = BPF_REG_6; i <= BPF_REG_10; i++)
 		if (bpf_is_seen_register(ctx, b2p[i]))
-			PPC_BPF_STL(b2p[i], 1, bpf_jit_stack_offsetof(ctx, b2p[i]));
+			EMIT(PPC_RAW_STD(b2p[i], 1, bpf_jit_stack_offsetof(ctx, b2p[i])));
 
 	/* Setup frame pointer to point to the bpf stack area */
 	if (bpf_is_seen_register(ctx, b2p[BPF_REG_FP]))
@@ -125,13 +125,13 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 	/* Restore NVRs */
 	for (i = BPF_REG_6; i <= BPF_REG_10; i++)
 		if (bpf_is_seen_register(ctx, b2p[i]))
-			PPC_BPF_LL(b2p[i], 1, bpf_jit_stack_offsetof(ctx, b2p[i]));
+			EMIT(PPC_RAW_LD(b2p[i], 1, bpf_jit_stack_offsetof(ctx, b2p[i])));
 
 	/* Tear down our stack frame */
 	if (bpf_has_stack_frame(ctx)) {
 		EMIT(PPC_RAW_ADDI(1, 1, BPF_PPC_STACKFRAME + ctx->stack_size));
 		if (ctx->seen & SEEN_FUNC) {
-			PPC_BPF_LL(0, 1, PPC_LR_STKOFF);
+			EMIT(PPC_RAW_LD(0, 1, PPC_LR_STKOFF));
 			EMIT(PPC_RAW_MTLR(0));
 		}
 	}
@@ -229,7 +229,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
 	 *   goto out;
 	 */
-	PPC_BPF_LL(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx));
+	EMIT(PPC_RAW_LD(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx)));
 	EMIT(PPC_RAW_CMPLWI(b2p[TMP_REG_1], MAX_TAIL_CALL_CNT));
 	PPC_BCC_SHORT(COND_GE, out);
 
@@ -237,12 +237,12 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * tail_call_cnt++;
 	 */
 	EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], b2p[TMP_REG_1], 1));
-	PPC_BPF_STL(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx));
+	EMIT(PPC_RAW_STD(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx)));
 
 	/* prog = array->ptrs[index]; */
 	EMIT(PPC_RAW_MULI(b2p[TMP_REG_1], b2p_index, 8));
 	EMIT(PPC_RAW_ADD(b2p[TMP_REG_1], b2p[TMP_REG_1], b2p_bpf_array));
-	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_array, ptrs));
+	EMIT(PPC_RAW_LD(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_array, ptrs)));
 
 	/*
 	 * if (prog == NULL)
@@ -252,7 +252,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	PPC_BCC_SHORT(COND_EQ, out);
 
 	/* goto *(prog->bpf_func + prologue_size); */
-	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_prog, bpf_func));
+	EMIT(PPC_RAW_LD(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_prog, bpf_func)));
 	EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], b2p[TMP_REG_1],
 			FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
 	EMIT(PPC_RAW_MTCTR(b2p[TMP_REG_1]));
@@ -628,7 +628,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				break;
 			case 64:
 				/* Store the value to stack and then use byte-reverse loads */
-				PPC_BPF_STL(dst_reg, 1, bpf_jit_stack_local(ctx));
+				EMIT(PPC_RAW_STD(dst_reg, 1, bpf_jit_stack_local(ctx)));
 				EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], 1, bpf_jit_stack_local(ctx)));
 				if (cpu_has_feature(CPU_FTR_ARCH_206)) {
 					EMIT(PPC_RAW_LDBRX(dst_reg, 0, b2p[TMP_REG_1]));
-- 
2.35.1

