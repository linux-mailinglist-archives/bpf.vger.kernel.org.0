Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08434863DD
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 12:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbiAFLqv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 06:46:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238456AbiAFLqv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 06:46:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206BSsVi022879;
        Thu, 6 Jan 2022 11:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JLfDOMIk9qWu6idD4oo6W5afeNMAxuq0v5hK3HpQIyM=;
 b=BZXouAYT78wYZ7736k4xIIo3rRHYyQUWmdIlGT6v8Ayq+lbf19gOnQ11W+neIewULwac
 3/6tHnpeEQD30C+1ZRkJ1VaXwgEW8ljX5dGTJg73XIXbgblTFAxomjAtPkps6QzWuOpx
 PnOliiWDjbku+1H0OA5JGEFovMrbd71B3mUQeJia3BzrXlSr/pQGuo5tsBs2FgdlkkXc
 UAulhZnsIEtGKhExk9iIYksVt60oEpWsZm5SiPvx3kW/6ieq3fVDbaBl7+T03QAEF0Y3
 NpyhOHgbUULXr98boQNbNp3gXQlXVRjoyVxM41/qpcAJoJjsFnFvqYI2yoFxP2guzpLQ Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddyk6rapq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:31 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 206BXdmN004162;
        Thu, 6 Jan 2022 11:46:30 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddyk6rap9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:30 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 206BgkGH004652;
        Thu, 6 Jan 2022 11:46:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3ddn4u4ffa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 206BbZ5q16122132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 11:37:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3197A4066;
        Thu,  6 Jan 2022 11:46:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E49A3A4065;
        Thu,  6 Jan 2022 11:46:21 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.91.118])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 11:46:21 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 09/13] powerpc64/bpf: Do not save/restore LR on each call to bpf_stf_barrier()
Date:   Thu,  6 Jan 2022 17:15:13 +0530
Message-Id: <5e0238a782acfa118a1b5e7cbbe0c7a508122bc0.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4gz1ovg3w6I04GYNBZl1DPM_NF4FlrYQ
X-Proofpoint-GUID: RMRCfzBLVkILFzba0_QEBguq9EYLyO0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_04,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=845
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of saving and restoring LR before each invocation to
bpf_stf_barrier(), set SEEN_FUNC flag so that we save/restore LR in
prologue/epilogue.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 7d38b4be26c3a5..ce4fc59bbd6a92 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -690,11 +690,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				EMIT(PPC_RAW_ORI(_R31, _R31, 0));
 				break;
 			case STF_BARRIER_FALLBACK:
-				EMIT(PPC_RAW_MFLR(b2p[TMP_REG_1]));
+				ctx->seen |= SEEN_FUNC;
 				PPC_LI64(12, dereference_kernel_function_descriptor(bpf_stf_barrier));
 				EMIT(PPC_RAW_MTCTR(12));
 				EMIT(PPC_RAW_BCTRL());
-				EMIT(PPC_RAW_MTLR(b2p[TMP_REG_1]));
 				break;
 			case STF_BARRIER_NONE:
 				break;
-- 
2.34.1

