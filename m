Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A3D4863E2
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 12:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbiAFLrE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 06:47:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238456AbiAFLrE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 06:47:04 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206B1U9N028396;
        Thu, 6 Jan 2022 11:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=irka7mEN/7IBgZpdteExnvHk8qowq/ibskzA6jcVfsw=;
 b=XdovKTPMOHxSZYFNQmLp3uZOSZGVOF3eD5IhJCL+CZbFzIwoOCTdnkIlQvfddEscC7EC
 x4GvnN5+DOFB8pvY3oua+d5/Ylex6pT0ufUSPpjO8EaCHbHaH5a5UeP06UQ9ZLRUflSi
 SBG5+PCQpHZYOK82t3BsAUDJJevuaX71IHXB0vIfFYGo4cBiIQexBaPrqozAnG6VC8Ah
 CrcJrn2xdTKvyuk0vfNneXqY8hDRVbHgOkWcjv20qbKER0xtRHkoQVrUcg+vR6ckmPLf
 CgHt6AtQMK9aIkHDPZnWB/IgMB+awcFnXFv5wIkzVTL9KkO6zkVXXJURCZYNtzTlbiy4 vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddy6grr38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:44 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 206BfWmL019879;
        Thu, 6 Jan 2022 11:46:44 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddy6grr2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:43 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 206Bh3JF023942;
        Thu, 6 Jan 2022 11:46:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3ddn5mvexy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:41 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 206Bkbl343909436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 11:46:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9102A405F;
        Thu,  6 Jan 2022 11:46:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8AD1A4054;
        Thu,  6 Jan 2022 11:46:34 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.91.118])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 11:46:34 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 13/13] powerpc64/bpf: Optimize instruction sequence used for function calls
Date:   Thu,  6 Jan 2022 17:15:17 +0530
Message-Id: <2a50d28963658be9703a49fb84a325e16adc264f.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mgJ-MDIRwp_0ADRjS4m0I7tJek7xBd6_
X-Proofpoint-GUID: h6MLBsXiim1blqFc7xmrSY0sEO5JETFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_04,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060081
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
- skip the initial instruction setting up r2 in case of BPF function
  calls, since we already have the kernel TOC setup in r2.

Reported-by: Anton Blanchard <anton@ozlabs.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 5da8e54d4d70b6..72179295f8e8c8 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -155,22 +155,20 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
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
@@ -183,6 +181,9 @@ int bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func
 	if (WARN_ON_ONCE(func && is_module_text_address(func)))
 		return -EINVAL;
 
+	/* skip past descriptor (elf v1) and toc load (elf v2) */
+	func += FUNCTION_DESCR_SIZE + 4;
+
 	/* Load function address into r12 */
 	PPC_LI64(12, func);
 
@@ -199,11 +200,6 @@ int bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func
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
2.34.1

