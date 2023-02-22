Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814F569FF67
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBVXZv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBVXZu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:25:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A133460A0
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:25:49 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MMLSvn026138;
        Wed, 22 Feb 2023 22:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VGgrWva8EnmWJQusMM5UoUt6sPGjOzXSXAF9NwKISGo=;
 b=eNnGSW6x5OZZkjYMcgmrftrpbyc+oJhk5nFT+tfWkhdHs8k4bjpz6da1lyPZird3gXOb
 xY4J2K8h51lee5WbZuwWMUamEfnsz1jQ9CSEkGGkL00TqV6p+Yv1yhMgXmP7lp+7K5KB
 QGMPUl+zLo3xg80bWV3VSxeW8uNB2bSnuAetr8PJN5QspkOjWVYL0H2AlfHJJRciq09/
 a6gRLvMYeNG5SJp/Tx8JYUz+PX9bj/Tsy72xAHvxsB4TYWCjgJFDT5VzRNe7tj3qCI56
 5P8g7PksjDXMm2jeyCV7Hlw9vSiXhnnS78/RkajBMu3FJ1KrqqHEHZ1Z9ppebvcPyVTn cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwus8r9xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:34 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMLQ0U026091;
        Wed, 22 Feb 2023 22:37:33 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwus8r9xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:33 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31M9OA85014704;
        Wed, 22 Feb 2023 22:37:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3ntpa64gdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbS1t46989754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21A7C2004D;
        Wed, 22 Feb 2023 22:37:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7154720043;
        Wed, 22 Feb 2023 22:37:27 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:27 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 07/12] bpf, arm: Use bpf_jit_get_func_addr()
Date:   Wed, 22 Feb 2023 23:37:09 +0100
Message-Id: <20230222223714.80671-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xb6ITpjHLA9r_PDT7xXJVYf142vSE_gK
X-Proofpoint-GUID: zvcRlLGQExBvqEXEi9WVpkWTtYvblWrz
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

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/arm/net/bpf_jit_32.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 6a1c9fca5260..b9a7f7bba811 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1345,7 +1345,8 @@ static void build_epilogue(struct jit_ctx *ctx)
  *	>0 - Successfully JITed a 16-byte eBPF instruction
  *	<0 - Failed to JIT.
  */
-static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
+static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
+		      bool extra_pass)
 {
 	const u8 code = insn->code;
 	const s8 *dst = bpf2a32[insn->dst_reg];
@@ -1783,7 +1784,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		const s8 *r3 = bpf2a32[BPF_REG_3];
 		const s8 *r4 = bpf2a32[BPF_REG_4];
 		const s8 *r5 = bpf2a32[BPF_REG_5];
-		const u32 func = (u32)__bpf_call_base + (u32)imm;
+		bool func_addr_fixed;
+		u64 func;
+		int err;
+
+		err = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
+					    &func, &func_addr_fixed);
+		if (err)
+			return err;
 
 		emit_a32_mov_r64(true, r0, r1, ctx);
 		emit_a32_mov_r64(true, r1, r2, ctx);
@@ -1791,7 +1799,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		emit_push_r64(r4, ctx);
 		emit_push_r64(r3, ctx);
 
-		emit_a32_mov_i(tmp[1], func, ctx);
+		emit_a32_mov_i(tmp[1], (u32)func, ctx);
 		emit_blx_r(tmp[1], ctx);
 
 		emit(ARM_ADD_I(ARM_SP, ARM_SP, imm8m(24)), ctx); // callee clean
@@ -1826,7 +1834,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	return 0;
 }
 
-static int build_body(struct jit_ctx *ctx)
+static int build_body(struct jit_ctx *ctx, bool extra_pass)
 {
 	const struct bpf_prog *prog = ctx->prog;
 	unsigned int i;
@@ -1835,7 +1843,7 @@ static int build_body(struct jit_ctx *ctx)
 		const struct bpf_insn *insn = &(prog->insnsi[i]);
 		int ret;
 
-		ret = build_insn(insn, ctx);
+		ret = build_insn(insn, ctx, extra_pass);
 
 		/* It's used with loading the 64 bit immediate value. */
 		if (ret > 0) {
@@ -1880,6 +1888,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	struct jit_ctx ctx;
 	unsigned int tmp_idx;
 	unsigned int image_size;
+	bool extra_pass;
 	u8 *image_ptr;
 
 	/* If BPF JIT was not enabled then we must fall back to
@@ -1901,6 +1910,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog = tmp;
 	}
 
+	extra_pass = prog->aux->jit_data;
+	if (!extra_pass)
+		prog->aux->jit_data = bpf_int_jit_compile;
+
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.prog = prog;
 	ctx.cpu_architecture = cpu_architecture();
@@ -1924,7 +1937,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * being successful in the second pass, so just fall back
 	 * to the interpreter.
 	 */
-	if (build_body(&ctx)) {
+	if (build_body(&ctx, extra_pass)) {
 		prog = orig_prog;
 		goto out_off;
 	}
@@ -1982,7 +1995,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	/* If building the body of the JITed code fails somehow,
 	 * we fall back to the interpretation.
 	 */
-	if (build_body(&ctx) < 0) {
+	if (build_body(&ctx, extra_pass) < 0) {
 		image_ptr = NULL;
 		bpf_jit_binary_free(header);
 		prog = orig_prog;
-- 
2.39.1

