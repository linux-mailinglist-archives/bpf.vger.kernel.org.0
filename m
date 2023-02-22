Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2D69FF1B
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjBVXBo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjBVXBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:01:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B072474C7
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:01:40 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MMBvD2013625;
        Wed, 22 Feb 2023 22:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=X9aZ9b6e/U33Ukzcuc6kINLFABFIHMkWTp/fAIXzxj8=;
 b=MqimUSUDlMqRtW8vG9xNTqS8HprQaZPsV3U7d3kzhYb00igEDQYocy0BPw8yLd8wZshA
 cdA/db/vAUxTm5PkSx4q//sdqe9xbUMLcZm59Ih2dqgzXpyqq5c1cv/biKOxFs3IVWSD
 nziolYQ3a6NdLu+P4qjec9Cyb4rfy6hfyHfilv9k3jZpIca6CUI/xfKJxfB54K5GQIDx
 KpUoF+m1jV2EcrlDZjeAYqo6xd5y7+bs0DX5htr5kiEMRT00ugRr8CzMytQcUlwaCMS+
 VMF6Hx7WXCuIp11HoNewhsO1IfBX0iz+5Z9y1c7seHsAFzvzGH0sZE5Q20HtaiQIZGAc hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwumnghes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:37 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMDtEH023003;
        Wed, 22 Feb 2023 22:37:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwumnghdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MEuGVx016645;
        Wed, 22 Feb 2023 22:37:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6dwrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbVRw25952538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A0E120040;
        Wed, 22 Feb 2023 22:37:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB95920043;
        Wed, 22 Feb 2023 22:37:30 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:30 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 10/12] bpf, x86_32: Use bpf_jit_get_func_addr()
Date:   Wed, 22 Feb 2023 23:37:12 +0100
Message-Id: <20230222223714.80671-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ft_IjArKdOWg9tEtU7PVCANKTuxkIaAV
X-Proofpoint-GUID: dgvE0SK6Tdvxu9VzTbeX7a5KkZIwWjuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
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
 arch/x86/net/bpf_jit_comp32.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 0abb4d6c9dec..998d9bebe4ae 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1567,7 +1567,7 @@ static u8 get_cond_jmp_opcode(const u8 op, bool is_cmp_lo)
  *	- 0-2 jit-insns (3 bytes each) to handle the return value.
  */
 static int emit_kfunc_call(const struct bpf_prog *bpf_prog, u8 *end_addr,
-			   const struct bpf_insn *insn, u8 **pprog)
+			   const struct bpf_insn *insn, u8 *func, u8 **pprog)
 {
 	const u8 arg_regs[] = { IA32_EAX, IA32_EDX, IA32_ECX };
 	int i, cnt = 0, first_stack_regno, last_stack_regno;
@@ -1628,7 +1628,7 @@ static int emit_kfunc_call(const struct bpf_prog *bpf_prog, u8 *end_addr,
 	if (fm->ret_size)
 		end_addr -= 3;
 
-	jmp_offset = (u8 *)__bpf_call_base + insn->imm - end_addr;
+	jmp_offset = func - end_addr;
 	if (!is_simm32(jmp_offset)) {
 		pr_err("unsupported BPF kernel function jmp_offset:%lld\n",
 		       jmp_offset);
@@ -1657,7 +1657,7 @@ static int emit_kfunc_call(const struct bpf_prog *bpf_prog, u8 *end_addr,
 }
 
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
-		  int oldproglen, struct jit_context *ctx)
+		  int oldproglen, struct jit_context *ctx, bool extra_pass)
 {
 	struct bpf_insn *insn = bpf_prog->insnsi;
 	int insn_cnt = bpf_prog->len;
@@ -2087,6 +2087,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			const u8 *r3 = bpf2ia32[BPF_REG_3];
 			const u8 *r4 = bpf2ia32[BPF_REG_4];
 			const u8 *r5 = bpf2ia32[BPF_REG_5];
+			bool func_addr_fixed;
+			u64 func_addr;
+			int err;
 
 			if (insn->src_reg == BPF_PSEUDO_CALL)
 				goto notyet;
@@ -2103,14 +2106,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 
 				err = emit_kfunc_call(bpf_prog,
 						      image + addrs[i],
-						      insn, &prog);
+						      insn, func, &prog);
 
 				if (err)
 					return err;
 				break;
 			}
 
-			func = (u8 *) __bpf_call_base + imm32;
 			jmp_offset = func - (image + addrs[i]);
 
 			if (!imm32 || !is_simm32(jmp_offset)) {
@@ -2533,6 +2535,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	struct jit_context ctx = {};
 	bool tmp_blinded = false;
 	u8 *image = NULL;
+	bool extra_pass;
 	int *addrs;
 	int pass;
 	int i;
@@ -2552,6 +2555,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog = tmp;
 	}
 
+	extra_pass = prog->aux->jit_data;
+	if (!extra_pass)
+		prog->aux->jit_data = bpf_int_jit_compile;
+
 	addrs = kmalloc_array(prog->len, sizeof(*addrs), GFP_KERNEL);
 	if (!addrs) {
 		prog = orig_prog;
@@ -2575,7 +2582,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * pass to emit the final image.
 	 */
 	for (pass = 0; pass < 20 || image; pass++) {
-		proglen = do_jit(prog, addrs, image, oldproglen, &ctx);
+		proglen = do_jit(prog, addrs, image, oldproglen, &ctx,
+				 extra_pass);
 		if (proglen <= 0) {
 out_image:
 			image = NULL;
-- 
2.39.1

