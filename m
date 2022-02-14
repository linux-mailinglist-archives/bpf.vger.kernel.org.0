Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEAC4B4D9F
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350088AbiBNLNv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:13:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350007AbiBNLN1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:13:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D7AEA37E
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 02:42:56 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E9KcXt003835;
        Mon, 14 Feb 2022 10:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qR8jr5cL1XsNd9SeyXVEBz02oFdfMhnbRLDfeU/T6WY=;
 b=gBZmJm3TiLoBiqqmqHzjKjBX8A3hN5Nji2E4bNoA6Kub7i8vBpygZ8tGzAnlRple5cyf
 7arHh7YP+Jt1eVCyFxhCmbb+bTC73rDu7fB7brHTP/10IMQTFvsYFWWeRa/zdEfbx8fN
 hwvVGcyWCyf2dReVCIJnDmf41zvSLqLjMdolxBJJBGBs3vhyGYmUZE1KFQTIlBqLsFgn
 fxXzToJHLwO7oUO4GRjPLxG+/4nwg81Xw1CqRCk+N8Dk7dUvxbdeblfUbJjczIRyWrvG
 SKy9vxHElrxYLHygX9Ax96g/nsSiQvn4bB0E3nEtQeK0fpXXNn4joyp+CQffyzkcEgmM 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e6rt11wjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:32 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EARLIh013518;
        Mon, 14 Feb 2022 10:42:31 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e6rt11whs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:31 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EAXZtj009881;
        Mon, 14 Feb 2022 10:42:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3e64h9k8sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EAgPtv42795338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:42:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F7B8AE061;
        Mon, 14 Feb 2022 10:42:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C2F5AE053;
        Mon, 14 Feb 2022 10:42:22 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.124.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 10:42:22 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <bpf@vger.kernel.org>
Subject: [PATCH powerpc/next 07/17] powerpc64/bpf elfv2: Setup kernel TOC in r2 on entry
Date:   Mon, 14 Feb 2022 16:11:41 +0530
Message-Id: <18a05a4ceec14a8617c9dd4b7128d0afa83fd14e.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y7nwRu5BjKiux17tQPqNIsY-2uutkei1
X-Proofpoint-ORIG-GUID: JXR7n1RK3MV3YZc1p4kpqUeVKxjd6aK2
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

In preparation for using kernel TOC, load the same in r2 on entry. With
elfv1, the kernel TOC is already setup by our caller.

We adjust the number of instructions to skip on a tail call accordingly.
We get rid of the #ifdef in bpf_jit_emit_tail_call() since
FUNCTION_DESCR_SIZE is itself under a #ifdef.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 27ac2fc7670298..44314ee60155e4 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -73,6 +73,9 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 {
 	int i;
 
+	if (__is_defined(PPC64_ELF_ABI_v2))
+		PPC_BPF_LL(_R2, _R13, offsetof(struct paca_struct, kernel_toc));
+
 	/*
 	 * Initialize tail_call_cnt if we do tail calls.
 	 * Otherwise, put in NOPs so that it can be skipped when we are
@@ -87,8 +90,6 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		EMIT(PPC_RAW_NOP());
 	}
 
-#define BPF_TAILCALL_PROLOGUE_SIZE	8
-
 	if (bpf_has_stack_frame(ctx)) {
 		/*
 		 * We need a stack frame, but we don't necessarily need to
@@ -217,6 +218,10 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 */
 	int b2p_bpf_array = b2p[BPF_REG_2];
 	int b2p_index = b2p[BPF_REG_3];
+	int bpf_tailcall_prologue_size = 8;
+
+	if (__is_defined(PPC64_ELF_ABI_v2))
+		bpf_tailcall_prologue_size += 4; /* skip past the toc load */
 
 	/*
 	 * if (index >= array->map.max_entries)
@@ -255,13 +260,8 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 
 	/* goto *(prog->bpf_func + prologue_size); */
 	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_prog, bpf_func));
-#ifdef PPC64_ELF_ABI_v1
-	/* skip past the function descriptor */
 	EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], b2p[TMP_REG_1],
-			FUNCTION_DESCR_SIZE + BPF_TAILCALL_PROLOGUE_SIZE));
-#else
-	EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], b2p[TMP_REG_1], BPF_TAILCALL_PROLOGUE_SIZE));
-#endif
+			FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
 	EMIT(PPC_RAW_MTCTR(b2p[TMP_REG_1]));
 
 	/* tear down stack, restore NVRs, ... */
-- 
2.35.1

