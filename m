Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C5541F6BA
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 23:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJAVRj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 17:17:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230112AbhJAVRj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 Oct 2021 17:17:39 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191Km7XQ001152;
        Fri, 1 Oct 2021 17:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=M9E5E2r4oyDNCb/cmqTCEQytx5eh9RBd94buGdG8res=;
 b=WXpzcrx3dCkQGdBSlsMf/lcQHYdySuuzWvR8uU7ll71Px2SDkIcGKaJ1x8JtGZRYN95J
 YQqII8EBxDx2J54HT5+TfwMGcN3gKZkZ3+fCV0NsovsMZGHES4w5o6t1dK8YRZx+dAD/
 hJSYPCxDIyjyPhh9rUJKn7GmECarrXQojyvzcWl8z3kBrSpJ/fC8Ku5etbZxd6koZQ3O
 BsOY7Bpxg1glLX5ZLRZDmLZUmtAHEDFGrdCE84bwIjixGfSAMDI6X9GSpbF6hdqKeFsi
 QD1Ze2Gb3ZDOhtROWCnsfNI+yyAox6Dto3Q3vHelpbJzK7uqR1duwEBu40DCQ/Ou7THG AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3be9p60f00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 17:15:35 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 191LFYtx013752;
        Fri, 1 Oct 2021 17:15:35 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3be9p60eyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 17:15:34 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 191L6UmQ019880;
        Fri, 1 Oct 2021 21:15:32 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3b9udae6jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 21:15:32 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 191LFUGw17498464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Oct 2021 21:15:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8FA94C044;
        Fri,  1 Oct 2021 21:15:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF6044C046;
        Fri,  1 Oct 2021 21:15:26 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.54.98])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Oct 2021 21:15:26 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/9] powerpc/bpf: Remove unused SEEN_STACK
Date:   Sat,  2 Oct 2021 02:44:49 +0530
Message-Id: <92fcd53a43dede52fbba52dc50c76042a6ce284c.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tfs1r-0OmKq7jpWxLrSQj1CQ8J1Gcqjd
X-Proofpoint-ORIG-GUID: 7kTiKjL8bXpOwxPSImV5r59_sGpeijKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-01_05,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010147
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

SEEN_STACK is unused on PowerPC. Remove it. Also, have
SEEN_TAILCALL use 0x40000000.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/net/bpf_jit.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 7e9b978b768ed9..89bd744c2bffd4 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -125,8 +125,7 @@
 #define COND_LE		(CR0_GT | COND_CMP_FALSE)
 
 #define SEEN_FUNC	0x20000000 /* might call external helpers */
-#define SEEN_STACK	0x40000000 /* uses BPF stack */
-#define SEEN_TAILCALL	0x80000000 /* uses tail calls */
+#define SEEN_TAILCALL	0x40000000 /* uses tail calls */
 
 #define SEEN_VREG_MASK	0x1ff80000 /* Volatile registers r3-r12 */
 #define SEEN_NVREG_MASK	0x0003ffff /* Non volatile registers r14-r31 */
-- 
2.33.0

