Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0857B4B4DE3
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350070AbiBNLNT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:13:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350425AbiBNLNG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:13:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC2AD129
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 02:42:34 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E9E41u003446;
        Mon, 14 Feb 2022 10:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FUefhHlovKHvSxorDvsShQYTpbtcDRxQomkvjmrhEQ0=;
 b=sCcCptFeU7bjTuGZ/zltw6Qo1X3v97XSthcfMRgwimdHxQKQtDW1O7o83tEeTuySmq9D
 dToxUGvDicXhAfFcE72oUaL6GYS/RNJdirFZxkHHdnTSVrj3bFHYCqGXcH+i8pKwRu95
 Ibz1ehnuPQPfsP+3GquAHPYB9zchWF0P6PQSMuUwLo61a255DNRiKI51ZX8wx709sTCX
 S5byHfq2hs/6PdUBqn8XH20VAbDB7pE3I3mxas1iMImTlnwDUdTtY5Dk8Uiw1ascPVGU
 nRBqYgtQhl55gdWLz5q1GFp4ilSvLznVNnJMVt1C+CSx3PceFrAKzirl7Wf8bNtkMMK9 Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e6rt11wdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:15 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EAKiBT024681;
        Mon, 14 Feb 2022 10:42:15 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e6rt11wcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EAXecv028257;
        Mon, 14 Feb 2022 10:42:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3e64h9m0ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EAg8uC41943304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:42:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3B38AE045;
        Mon, 14 Feb 2022 10:42:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FA45AE05F;
        Mon, 14 Feb 2022 10:42:06 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.124.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 10:42:06 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <bpf@vger.kernel.org>
Subject: [PATCH powerpc/next 01/17] powerpc/bpf: Skip branch range validation during first pass
Date:   Mon, 14 Feb 2022 16:11:35 +0530
Message-Id: <bc517413d11636e20dbfc88503dad14bcbe391e2.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wgVAv8MaGgRMSGjs7IIED0oe0vUS_oad
X-Proofpoint-ORIG-GUID: LlYy-R8l7RdSGKhWrRiXvnVwU5iM_qZb
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

During the first pass, addrs[] is still being populated. So, all
branches to following instructions will appear to be going to the start
of the JIT program. Ignore branch range validation for such instructions
and assume those to be in range. Branch range validation will happen
during the second pass after addrs[] is setup properly.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index b20a2a83a6e75b..9cdd33d6be4cc0 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -27,7 +27,7 @@
 #define PPC_JMP(dest)							      \
 	do {								      \
 		long offset = (long)(dest) - (ctx->idx * 4);		      \
-		if (!is_offset_in_branch_range(offset)) {		      \
+		if ((dest) != 0 && !is_offset_in_branch_range(offset)) {		      \
 			pr_err_ratelimited("Branch offset 0x%lx (@%u) out of range\n", offset, ctx->idx);			\
 			return -ERANGE;					      \
 		}							      \
@@ -41,7 +41,7 @@
 #define PPC_BCC_SHORT(cond, dest)					      \
 	do {								      \
 		long offset = (long)(dest) - (ctx->idx * 4);		      \
-		if (!is_offset_in_cond_branch_range(offset)) {		      \
+		if ((dest) != 0 && !is_offset_in_cond_branch_range(offset)) {		      \
 			pr_err_ratelimited("Conditional branch offset 0x%lx (@%u) out of range\n", offset, ctx->idx);		\
 			return -ERANGE;					      \
 		}							      \
-- 
2.35.1

