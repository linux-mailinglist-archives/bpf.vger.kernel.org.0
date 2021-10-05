Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5853F4231F2
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 22:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhJEU2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 16:28:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236395AbhJEU2w (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 Oct 2021 16:28:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195K4TwE006938;
        Tue, 5 Oct 2021 16:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mHZM+8sfCvSOETZtZksE+aG+w8FMfYUNC7iEu3POcOI=;
 b=qU1ypXImbecAlvSLctqt1Db5fPnhPR+lqK4vL3k+vjwL8mbezEcV6YSgBIFQlx8ugtxt
 ourEgg0jV3j99itHu4hx3C26mpDaRpO99ZzxFSShbZO7d3P5Qf+MgZMIhcyAiCL2lJMI
 pi6KmXDBKzkdYUR50ydzj2fsg/TA7txPNdF53nNDyH68MFU4jFhjHmCO4Ijw5N0v9L8s
 uRYSQz6vP1WCJqdh3kd1SWGRE6PuSkFlxwlH0t/eM+x/Ocpj0WHKsvEASK/qR/82MtTU
 ggp59e9gAZWXYM1J/uw46H7vCPxyV/DK6PX68YuUW4QhagWB+pYaqEF9PPogVDFdU7kK 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgs36y44s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 16:26:39 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 195KKS0R002966;
        Tue, 5 Oct 2021 16:26:39 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgs36y43y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 16:26:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 195KIn4K013018;
        Tue, 5 Oct 2021 20:26:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3bef2ax1r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 20:26:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 195KQYHo6357536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Oct 2021 20:26:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17DC1AE04D;
        Tue,  5 Oct 2021 20:26:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A61DDAE053;
        Tue,  5 Oct 2021 20:26:30 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.5.112])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Oct 2021 20:26:30 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Song Liu <songliubraving@fb.com>
Cc:     <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 10/10] powerpc/bpf ppc32: Fix BPF_SUB when imm == 0x80000000
Date:   Wed,  6 Oct 2021 01:55:29 +0530
Message-Id: <7135360a0cdf70adedbccf9863128b8daef18764.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RZ0L1NcKFxcU4p3k6fmtrbcmFvv_Vfm-
X-Proofpoint-ORIG-GUID: t7YJsAiuSAtcp-GB4HaMGRnT0o7QiUqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_04,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050117
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Special case handling of the smallest 32-bit negative number for BPF_SUB.

Fixes: 51c66ad849a703 ("powerpc/bpf: Implement extended BPF on PPC32")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 68dc8a8231de04..0da31d41d41310 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -357,7 +357,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				PPC_LI32(_R0, imm);
 				EMIT(PPC_RAW_ADDC(dst_reg, dst_reg, _R0));
 			}
-			if (imm >= 0)
+			if (imm >= 0 || (BPF_OP(code) == BPF_SUB && imm == 0x80000000))
 				EMIT(PPC_RAW_ADDZE(dst_reg_h, dst_reg_h));
 			else
 				EMIT(PPC_RAW_ADDME(dst_reg_h, dst_reg_h));
-- 
2.33.0

