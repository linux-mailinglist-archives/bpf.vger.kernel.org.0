Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774344B4DF6
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350109AbiBNLNT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:13:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350426AbiBNLNG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:13:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B497AD138
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 02:42:35 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E98GPV016790;
        Mon, 14 Feb 2022 10:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XQ6lCiR4LKy7Umsg3hkLr/V6hAFrgSAGCRT7uapK/10=;
 b=WFknDgocQv2N+xrRXyS3p1eVSoiNqq7se8G8XrZm1C9v/LKopsipcSaiLg58uowhZV08
 ffk01t7iWXUbki3GPW/hrMTQoLfpuF5/1Wins7pb7vTBn4n3oOYzk0HekA/QCMarW0qu
 dv4XpSOjuh5JxhxnLIMaPz+ddedBVGrIzHrk7uJqMVG2eBp4GMyDeHhxubxvVLZdk8RO
 UpzomSWi75swgB9I3uSY3no8L0wo2CJl8CF5z7G7KYGo+6oszMG2hkaGd9+qnpVao7GI
 jJ5JJeYvxRV+xGdjj+l/LHMmEATKBRd9zRdAqnisC0tjcMlj+DoB9qInAikoKawkAvly eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e6rt11wea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:17 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EAKBaU022666;
        Mon, 14 Feb 2022 10:42:17 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e6rt11wdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EAXfeh028272;
        Mon, 14 Feb 2022 10:42:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3e64h9m0p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EAgBv344695882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:42:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FC54AE051;
        Mon, 14 Feb 2022 10:42:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C248AE057;
        Mon, 14 Feb 2022 10:42:09 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.124.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 10:42:08 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <bpf@vger.kernel.org>
Subject: [PATCH powerpc/next 02/17] powerpc/bpf: Emit a single branch instruction for known short branch ranges
Date:   Mon, 14 Feb 2022 16:11:36 +0530
Message-Id: <edbca01377d1d5f472868bf6d8962b0a0d85b96f.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oha8cpTjk6aMfEZ6829g7w6OgqljNmlC
X-Proofpoint-ORIG-GUID: KKR5asIXZNWXgfPUxB9fbEaoa-QTBWDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PPC_BCC() emits two instructions to accommodate scenarios where we need
to branch outside the range of a conditional branch. PPC_BCC_SHORT()
emits a single branch instruction and can be used when the branch is
known to be within a conditional branch range.

Convert some of the uses of PPC_BCC() in the powerpc BPF JIT over to
PPC_BCC_SHORT() where we know the branch range.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 8 ++++----
 arch/powerpc/net/bpf_jit_comp64.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index cf8dd8aea386c4..81e0c56661ddf2 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -221,7 +221,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	EMIT(PPC_RAW_LWZ(_R0, b2p_bpf_array, offsetof(struct bpf_array, map.max_entries)));
 	EMIT(PPC_RAW_CMPLW(b2p_index, _R0));
 	EMIT(PPC_RAW_LWZ(_R0, _R1, bpf_jit_stack_offsetof(ctx, BPF_PPC_TC)));
-	PPC_BCC(COND_GE, out);
+	PPC_BCC_SHORT(COND_GE, out);
 
 	/*
 	 * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
@@ -230,7 +230,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	EMIT(PPC_RAW_CMPLWI(_R0, MAX_TAIL_CALL_CNT));
 	/* tail_call_cnt++; */
 	EMIT(PPC_RAW_ADDIC(_R0, _R0, 1));
-	PPC_BCC(COND_GE, out);
+	PPC_BCC_SHORT(COND_GE, out);
 
 	/* prog = array->ptrs[index]; */
 	EMIT(PPC_RAW_RLWINM(_R3, b2p_index, 2, 0, 29));
@@ -243,7 +243,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 *   goto out;
 	 */
 	EMIT(PPC_RAW_CMPLWI(_R3, 0));
-	PPC_BCC(COND_EQ, out);
+	PPC_BCC_SHORT(COND_EQ, out);
 
 	/* goto *(prog->bpf_func + prologue_size); */
 	EMIT(PPC_RAW_LWZ(_R3, _R3, offsetof(struct bpf_prog, bpf_func)));
@@ -834,7 +834,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			if (BPF_MODE(code) == BPF_PROBE_MEM) {
 				PPC_LI32(_R0, TASK_SIZE - off);
 				EMIT(PPC_RAW_CMPLW(src_reg, _R0));
-				PPC_BCC(COND_GT, (ctx->idx + 5) * 4);
+				PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 4);
 				EMIT(PPC_RAW_LI(dst_reg, 0));
 				/*
 				 * For BPF_DW case, "li reg_h,0" would be needed when
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index e1e8c934308adb..b1ed8611091d2b 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -225,7 +225,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	EMIT(PPC_RAW_LWZ(b2p[TMP_REG_1], b2p_bpf_array, offsetof(struct bpf_array, map.max_entries)));
 	EMIT(PPC_RAW_RLWINM(b2p_index, b2p_index, 0, 0, 31));
 	EMIT(PPC_RAW_CMPLW(b2p_index, b2p[TMP_REG_1]));
-	PPC_BCC(COND_GE, out);
+	PPC_BCC_SHORT(COND_GE, out);
 
 	/*
 	 * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
@@ -233,7 +233,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 */
 	PPC_BPF_LL(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx));
 	EMIT(PPC_RAW_CMPLWI(b2p[TMP_REG_1], MAX_TAIL_CALL_CNT));
-	PPC_BCC(COND_GE, out);
+	PPC_BCC_SHORT(COND_GE, out);
 
 	/*
 	 * tail_call_cnt++;
@@ -251,7 +251,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 *   goto out;
 	 */
 	EMIT(PPC_RAW_CMPLDI(b2p[TMP_REG_1], 0));
-	PPC_BCC(COND_EQ, out);
+	PPC_BCC_SHORT(COND_EQ, out);
 
 	/* goto *(prog->bpf_func + prologue_size); */
 	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_prog, bpf_func));
@@ -807,7 +807,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				else /* BOOK3S_64 */
 					PPC_LI64(b2p[TMP_REG_2], PAGE_OFFSET);
 				EMIT(PPC_RAW_CMPLD(b2p[TMP_REG_1], b2p[TMP_REG_2]));
-				PPC_BCC(COND_GT, (ctx->idx + 4) * 4);
+				PPC_BCC_SHORT(COND_GT, (ctx->idx + 3) * 4);
 				EMIT(PPC_RAW_LI(dst_reg, 0));
 				/*
 				 * Check if 'off' is word aligned because PPC_BPF_LL()
-- 
2.35.1

