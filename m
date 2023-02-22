Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7154169FF42
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjBVXLk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjBVXLk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:11:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BA12658B
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:11:39 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MMSlFT014115;
        Wed, 22 Feb 2023 22:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vG/quiERzOQzxgUfKqQtH9ZqIXTjkHkKEZAX5hp7pSs=;
 b=TLnxxz83iyHJ/fYYbEqtvNFgIBnB/HP807dcesmCQT0iZ5jMtuoJixW8uRV0YhkUX62V
 dh1G43izg5J9LgLwtQGrT55Lbnl8d+jn3kZA0M/qyKkvpNP+cTZPxJVxs8R5WUhYOw1L
 qCf3+6Rvi9uIV2wYMo0FkDIpihT+gWCT7lS2yNAIjDMDfdu18eZTZj/HscakoFhZWWN9
 crHtZlU8llC5aWzK3MZTPm9SPVtEgfFwSwbjj4sdn1RQrNH7g7IU2gPkOpdNa6zam27t
 YZjkovc0IK8nC2Qggwx7RRiL8AQig44KYEb8s76hKX2cbrRX8lro3zG/lkB+ou5U1oFE Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwuvng5s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:36 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMTDx5015266;
        Wed, 22 Feb 2023 22:37:36 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwuvng5rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:36 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MF3RWQ019836;
        Wed, 22 Feb 2023 22:37:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ntnxf5wfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbUX537224936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6317120043;
        Wed, 22 Feb 2023 22:37:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B62B72004B;
        Wed, 22 Feb 2023 22:37:29 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:29 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 09/12] bpf: x86: Use bpf_jit_get_func_addr()
Date:   Wed, 22 Feb 2023 23:37:11 +0100
Message-Id: <20230222223714.80671-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wULOuctQXUGNvSmCiuEVMM-iYy9x8pKo
X-Proofpoint-ORIG-GUID: _m7GAA6AOxh68UDTFhVCIPehxuzwOs-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Preparation for moving kfunc address from bpf_insn.imm.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/x86/net/bpf_jit_comp.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1056bbf55b17..f722f431ba6f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -964,7 +964,8 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
-		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
+		  int oldproglen, struct jit_context *ctx, bool jmp_padding,
+		  bool extra_pass)
 {
 	bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
 	struct bpf_insn *insn = bpf_prog->insnsi;
@@ -1000,9 +1001,11 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 		const s32 imm32 = insn->imm;
 		u32 dst_reg = insn->dst_reg;
 		u32 src_reg = insn->src_reg;
+		bool func_addr_fixed;
 		u8 b2 = 0, b3 = 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
+		u64 func_addr;
 		s16 insn_off;
 		u8 jmp_cond;
 		u8 *func;
@@ -1536,7 +1539,12 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			int offs;
 
-			func = (u8 *) __bpf_call_base + imm32;
+			err = bpf_jit_get_func_addr(bpf_prog, insn, extra_pass,
+						    &func_addr,
+						    &func_addr_fixed);
+			if (err < 0)
+				return err;
+			func = (u8 *)(unsigned long)func_addr;
 			if (tail_call_reachable) {
 				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
 				EMIT3_off32(0x48, 0x8B, 0x85,
@@ -2518,7 +2526,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	for (pass = 0; pass < MAX_PASSES || image; pass++) {
 		if (!padding && pass >= PADDING_PASSES)
 			padding = true;
-		proglen = do_jit(prog, addrs, image, rw_image, oldproglen, &ctx, padding);
+		proglen = do_jit(prog, addrs, image, rw_image, oldproglen, &ctx,
+				 padding, extra_pass);
 		if (proglen <= 0) {
 out_image:
 			image = NULL;
-- 
2.39.1

