Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C794B4DDE
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiBNLOu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:14:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350218AbiBNLNs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:13:48 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2DFEBDD5
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 02:43:02 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E9qSgl021250;
        Mon, 14 Feb 2022 10:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lAEgJpRc7Axt19nA4v7qlvjY18H3dJUjf7i1M5n8Eeo=;
 b=cB1mt2h8AwBSS07ozLi+mhUy6n2uwG3IqLkqjPNCPw/L2XFjxsO7fx4y3pxokMn5NB/H
 FCF9rvFLgfJvZI/hyODKHJHUA5lcbHfUIW955JAg83b43XYSKA/2en5WewFzgnat6+DT
 Zy+ghGFPtNjZFec6rfUelJQ1J79OzOQHiIUrvpEijSGFmY0raGbPmamdYA7eKClnUpS1
 b3aFJdLep9exkYsWXghdwdKQODsBJXwFCTenRI3lT45dCU7LgahJQvdQabKROr93zF8C
 GSaJ4nRzpDniLU0OjdZxmFFPjuR5Bk1dNHflxqzhXB5Pa4IgPT/yFZ4LdRm1ZJ8HxpCz 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7c4dtp7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:36 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EAM3Rk014859;
        Mon, 14 Feb 2022 10:42:36 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7c4dtp79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:36 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EAXmx5021691;
        Mon, 14 Feb 2022 10:42:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3e64h9b841-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:34 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EAgVrN32178644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:42:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93165AE053;
        Mon, 14 Feb 2022 10:42:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51B19AE055;
        Mon, 14 Feb 2022 10:42:29 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.124.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 10:42:29 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <bpf@vger.kernel.org>
Subject: [PATCH powerpc/next 09/17] powerpc64/bpf: Optimize instruction sequence used for function calls
Date:   Mon, 14 Feb 2022 16:11:43 +0530
Message-Id: <1233c7544e60dcb021c52b1f840b0f21a87b33ed.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5Mc-DbJ7PjjnKXp5VFsHPzA9JLpXvwyr
X-Proofpoint-ORIG-GUID: raRKn1-IqFLoHkTL09sr08sJ91fij1nz
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

When calling BPF helpers, we load the function address to call into a
register. This can result in upto 5 instructions. Optimize this by
instead using the kernel toc in r2 and adjusting offset to the BPF
helper. This works since all BPF helpers are part of kernel text, and
all BPF programs/functions utilize the kernel TOC.

Further more:
- load the actual function entry address in elf v1, rather than loading
  it through the function descriptor address.
- load the Local Entry Point (LEP) in elf v2 skipping TOC setup.
- consolidate code across elf abi v1 and v2 by using r12 on both.

Reported-by: Anton Blanchard <anton@ozlabs.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index e9fd4694226fe0..bff200723e7282 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -150,22 +150,20 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
+	long reladdr;
 
 	if (WARN_ON_ONCE(!core_kernel_text(func_addr)))
 		return -EINVAL;
 
-#ifdef PPC64_ELF_ABI_v1
-	/* func points to the function descriptor */
-	PPC_LI64(b2p[TMP_REG_2], func);
-	/* Load actual entry point from function descriptor */
-	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_2], 0);
-	/* ... and move it to CTR */
-	EMIT(PPC_RAW_MTCTR(b2p[TMP_REG_1]));
-#else
-	/* We can clobber r12 */
-	PPC_FUNC_ADDR(12, func);
-	EMIT(PPC_RAW_MTCTR(12));
-#endif
+	reladdr = func_addr - kernel_toc_addr();
+	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
+		pr_err("eBPF: address of %ps out of range of kernel_toc.\n", (void *)func);
+		return -ERANGE;
+	}
+
+	EMIT(PPC_RAW_ADDIS(_R12, _R2, PPC_HA(reladdr)));
+	EMIT(PPC_RAW_ADDI(_R12, _R12, PPC_LO(reladdr)));
+	EMIT(PPC_RAW_MTCTR(_R12));
 	EMIT(PPC_RAW_BCTRL());
 
 	return 0;
@@ -178,6 +176,9 @@ int bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func
 	if (WARN_ON_ONCE(func && is_module_text_address(func)))
 		return -EINVAL;
 
+	/* skip past descriptor if elf v1 */
+	func += FUNCTION_DESCR_SIZE;
+
 	/* Load function address into r12 */
 	PPC_LI64(12, func);
 
@@ -194,11 +195,6 @@ int bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func
 	for (i = ctx->idx - ctx_idx; i < 5; i++)
 		EMIT(PPC_RAW_NOP());
 
-#ifdef PPC64_ELF_ABI_v1
-	/* Load actual entry point from function descriptor */
-	PPC_BPF_LL(12, 12, 0);
-#endif
-
 	EMIT(PPC_RAW_MTCTR(12));
 	EMIT(PPC_RAW_BCTRL());
 
-- 
2.35.1

