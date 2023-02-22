Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3094A69FE9B
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 23:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjBVWkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 17:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjBVWkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 17:40:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D35A460BD
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:40:16 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MMX0C5031993;
        Wed, 22 Feb 2023 22:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Hx47rluwZ4Mdd35Kezib1ixj7ovE6nsh2j1Uz3++FbY=;
 b=fqkYUp77BW8cC1mU8pWTDsXzBurQTHa2sBQWcqinQsKapEIifxyJK6AhzHvICHMjUNXb
 1OmygKGf0LZSSeal1G8Wxym2jW4uXF3Bo9l3sTCboXAeah0LRnGPsNm5nKfJ8zu4qRYy
 +FBC2nVvvNnyMP8DFTx8Ozlu+IOGp9nQnMG82B98+d7Dmtc8Y40/tUfxlDbN3p2FZKyB
 K29fQ5kLsv7viHbsu2/+7HEx3K4U/wQR90oBs7JeV5r/wWWoy4rWfypf9caKV1YQOaQu
 57jL8KYqfAP8Ql696Zwz2XAA8/AHDNH43M/8ggUDnId80zdhHKnPLDLLBuVfmUAMRdnJ Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwuxpg2xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:32 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMX2NS032124;
        Wed, 22 Feb 2023 22:37:31 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwuxpg2ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:31 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MAd0BL019863;
        Wed, 22 Feb 2023 22:37:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3ntpa64fd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbPtL47710556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAF7B20043;
        Wed, 22 Feb 2023 22:37:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C07320040;
        Wed, 22 Feb 2023 22:37:25 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:24 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 05/12] bpf: sparc64: Fix jumping to the first insn
Date:   Wed, 22 Feb 2023 23:37:07 +0100
Message-Id: <20230222223714.80671-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lKNLPWtR1r3EeufYcZUSB-M_DF5SCGZq
X-Proofpoint-GUID: MdiUuOIFTDwsIHpKxixkg8N7UdOjpaNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jumping to the first insn causes emit_compare_and_branch() to access
ctx->offsets[-1]. Currently ctx->offsets[] stores instruction end
addresses; change it to store start addresses instead. We never need
the end address of the last instruction.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/sparc/net/bpf_jit_comp_64.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 59d2d9953aa7..0a3c18e39199 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1168,7 +1168,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 
 	/* JUMP off */
 	case BPF_JMP | BPF_JA:
-		emit_branch(BA, ctx->idx, ctx->offset[i + off], ctx);
+		emit_branch(BA, ctx->idx, ctx->offset[i + off + 1], ctx);
 		emit_nop(ctx);
 		break;
 	/* IF (dst COND src) JUMP off */
@@ -1185,7 +1185,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_JMP | BPF_JSET | BPF_X: {
 		int err;
 
-		err = emit_compare_and_branch(code, dst, src, 0, false, i + off, ctx);
+		err = emit_compare_and_branch(code, dst, src, 0, false, i + off + 1, ctx);
 		if (err)
 			return err;
 		break;
@@ -1204,7 +1204,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_JMP | BPF_JSET | BPF_K: {
 		int err;
 
-		err = emit_compare_and_branch(code, dst, 0, imm, true, i + off, ctx);
+		err = emit_compare_and_branch(code, dst, 0, imm, true, i + off + 1, ctx);
 		if (err)
 			return err;
 		break;
@@ -1453,16 +1453,12 @@ static int build_body(struct jit_ctx *ctx)
 		const struct bpf_insn *insn = &prog->insnsi[i];
 		int ret;
 
-		ret = build_insn(insn, ctx);
-
-		if (ret > 0) {
-			i++;
-			ctx->offset[i] = ctx->idx;
-			continue;
-		}
 		ctx->offset[i] = ctx->idx;
-		if (ret)
+		ret = build_insn(insn, ctx);
+		if (ret < 0)
 			return ret;
+
+		i += ret;
 	}
 	return 0;
 }
-- 
2.39.1

