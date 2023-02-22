Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D70969FFA5
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjBVXiu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjBVXit (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:38:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C702056E
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:38:40 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MLLDMJ029969;
        Wed, 22 Feb 2023 22:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=brW+pkAsZGo0TckLECCnXgBL1vTGpgLzIIaNVCg5uYo=;
 b=sIjgNTady9RdvcJ7h4hFCNRdPPBq087tD4QYVTEtuAdXC6DsxNsbGFWM9vml/4LV9Tl6
 fKSko2FnIkX1TifPxY/Yl009YvVzhg2FX78YBc8mZYkary8if3DwA9Gb3T7glO/QK6dB
 15SrwpOcD0vqOsxMvwv+c9uMvd0z9i1YD3k2ln3OKPek0wGn9d8yeENkgI5DiNhQ+onE
 PZf/q0hZTqdIzE5f2CDD2zMB1eEkcxLK37jSqYP9KiliEXEqAU1BOXnG1x6ylP9uXD65
 2RCa8gkmaIoahN3io+kCXCz7xJf4NnsO7EXwVY8hr2imz990mmN/Zf9OVYC6rlafGxB8 Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwtvysnf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:31 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMRcKW011997;
        Wed, 22 Feb 2023 22:37:30 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwtvysne4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:30 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MA7ST0008591;
        Wed, 22 Feb 2023 22:37:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ntnxf4g5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbOP448628026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 758D020043;
        Wed, 22 Feb 2023 22:37:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B185E2004B;
        Wed, 22 Feb 2023 22:37:23 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:23 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH bpf-next v3 04/12] bpf: sparc64: Emit fixed-length instructions for BPF_PSEUDO_FUNC
Date:   Wed, 22 Feb 2023 23:37:06 +0100
Message-Id: <20230222223714.80671-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3poLbGLbcq0ryIbk4NB76tyTk_msG5Fx
X-Proofpoint-GUID: TTegQ7HCz9xwOOiqQaNmkak9eIXNKj6p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is the same as commit b54b6003612a ("riscv, bpf: Emit fixed-length
instructions for BPF_PSEUDO_FUNC"), but for sparc64. The code sequence
is borrowed from sparc64-linux-gnu-gcc -Os.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/sparc/net/bpf_jit_comp_64.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index fa0759bfe498..59d2d9953aa7 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1243,10 +1243,19 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_LD | BPF_IMM | BPF_DW:
 	{
 		const struct bpf_insn insn1 = insn[1];
+		const u8 tmp = bpf2sparc[TMP_REG_1];
 		u64 imm64;
 
-		imm64 = (u64)insn1.imm << 32 | (u32)imm;
-		emit_loadimm64(imm64, dst, ctx);
+		if (bpf_pseudo_func(insn)) {
+			/* fixed-length insns for extra jit pass */
+			emit_set_const(dst, insn1.imm, ctx);
+			emit_set_const(tmp, imm, ctx);
+			emit_alu_K(SLLX, dst, 32, ctx);
+			emit_alu3(ADD, dst, tmp, dst, ctx);
+		} else {
+			imm64 = (u64)insn1.imm << 32 | (u32)imm;
+			emit_loadimm64(imm64, dst, ctx);
+		}
 
 		return 1;
 	}
-- 
2.39.1

