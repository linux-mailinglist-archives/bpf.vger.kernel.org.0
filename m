Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D33869FE9C
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 23:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBVWkZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 17:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjBVWkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 17:40:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8227646166
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:40:19 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MMLQN2026077;
        Wed, 22 Feb 2023 22:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5v3uOfYdPx9TGrEusQnaTaJkKRpMbTyxGH1U810wr5U=;
 b=fibQj1GReSFOsxCRo1edeGG/CCgQTKaF62KeLqmJCiw22ybfUOkUYkesZfd/AED1te6b
 G4kDGsm8dUQ6Chyb4cNQFNqsu9BL7XCw525iN8JhoGqJrYuQX5/OynRwuqhnPhcMBzic
 +HNOZtjw1nnjsRhh/6SVXsYxOGSFlmlyJnfSEeUgTXZmdpryvjjkYGkgLETgqqa0AePQ
 /Ofq/cNN2OYM+JiwOzT8jJwqWt6EBdsk5lDpLwEeNtgPpMqLNQgH2V+ZQrRIr+QASef0
 DYM2vEb+hSuwi40xNWHlOuGgXj0v5Ro0hcj0mbprCmVm1Zo+pfj8dGAaoovfXtRgwZyq dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwus8r9ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:35 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMYuCe007010;
        Wed, 22 Feb 2023 22:37:34 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwus8r9xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:34 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MAIfXT002111;
        Wed, 22 Feb 2023 22:37:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ntpa64g35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbTaH19989016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DFCE2004B;
        Wed, 22 Feb 2023 22:37:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91CDB20043;
        Wed, 22 Feb 2023 22:37:28 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:28 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 08/12] bpf: sparc64: Use bpf_jit_get_func_addr()
Date:   Wed, 22 Feb 2023 23:37:10 +0100
Message-Id: <20230222223714.80671-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LXH2UXieD3uu3QOLEw2kWkESLYmUBALe
X-Proofpoint-GUID: jhf_VVE8UsOfPWLEFbm-iEbL1QmvXy_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Preparation for moving kfunc address from bpf_insn.imm.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/sparc/net/bpf_jit_comp_64.c | 20 ++++++++++++++------
 arch/x86/net/bpf_jit_comp32.c    |  7 +++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 6c482685dc6c..b23083776718 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -893,7 +893,8 @@ static void emit_tail_call(struct jit_ctx *ctx)
 	emit_nop(ctx);
 }
 
-static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
+static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
+		      bool extra_pass)
 {
 	const u8 code = insn->code;
 	const u8 dst = bpf2sparc[insn->dst_reg];
@@ -1214,7 +1215,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* function call */
 	case BPF_JMP | BPF_CALL:
 	{
-		u8 *func = ((u8 *)__bpf_call_base) + imm;
+		bool func_addr_fixed;
+		u64 func;
+		int err;
+
+		err = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
+					    &func, &func_addr_fixed);
+		if (err)
+			return err;
 
 		ctx->saw_call = true;
 
@@ -1445,7 +1453,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	return 0;
 }
 
-static int build_body(struct jit_ctx *ctx)
+static int build_body(struct jit_ctx *ctx, bool extra_pass)
 {
 	const struct bpf_prog *prog = ctx->prog;
 	int i;
@@ -1455,7 +1463,7 @@ static int build_body(struct jit_ctx *ctx)
 		int ret;
 
 		ctx->offset[i] = ctx->idx;
-		ret = build_insn(insn, ctx);
+		ret = build_insn(insn, ctx, extra_pass);
 		if (ret < 0)
 			return ret;
 
@@ -1549,7 +1557,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		ctx.idx = 0;
 
 		build_prologue(&ctx);
-		if (build_body(&ctx)) {
+		if (build_body(&ctx, extra_pass)) {
 			prog = orig_prog;
 			goto out_off;
 		}
@@ -1586,7 +1594,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	build_prologue(&ctx);
 
-	if (build_body(&ctx)) {
+	if (build_body(&ctx, extra_pass)) {
 		bpf_jit_binary_free(header);
 		prog = orig_prog;
 		goto out_off;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 429a89c5468b..0abb4d6c9dec 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2091,6 +2091,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			if (insn->src_reg == BPF_PSEUDO_CALL)
 				goto notyet;
 
+			err = bpf_jit_get_func_addr(bpf_prog, insn, extra_pass,
+						    &func_addr,
+						    &func_addr_fixed);
+			if (err)
+				return err;
+			func = (u8 *)(unsigned long)func_addr;
+
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 				int err;
 
-- 
2.39.1

