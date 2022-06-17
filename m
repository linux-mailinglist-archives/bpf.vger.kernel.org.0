Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B72C54F93D
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382762AbiFQOel (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jun 2022 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382756AbiFQOej (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 10:34:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380FB5000F
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 07:34:39 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HEGLsU013788;
        Fri, 17 Jun 2022 14:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=11/7WVhePdiAUod4P0hDDDAUuVYmrH+ISXkj25QkLQk=;
 b=VIxono7Y+V1nDYl15usemNszbxICgvBZPuLcOutib2k1mYbI8kvuP1cVFXNd1abOq4MV
 xT0cV7CNrvSa29st5IXaOXbxaeypgXNLPIo8YJUFMb4LM6DzPfjdn0vVVaS6+WRn2Zfc
 84AjcnZI0ZSKA4cVmeY3fyIXn0u5LsXuuejudnpvpFYHS2sH8Sly8YG1rG/z+yRxk2na
 lJQknFLBaxMVoNDMQgrDwtj7gnFPH0UUAkwa529APNDhjp2WS1R1WRG9cOG9oB9KTYSl
 hEckWMfRKcicFJkHsYLghWk46zTUCox9DDobZdYWjTcaR3R5/W7rT/Ji8OuUZkuhF/X4 Vg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3grtjdsnra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 14:34:30 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25HEJevu005926;
        Fri, 17 Jun 2022 14:34:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3gmjp8xyhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 14:34:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25HEYQxk19333392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 14:34:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19F1DAE045;
        Fri, 17 Jun 2022 14:34:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC6F6AE051;
        Fri, 17 Jun 2022 14:34:24 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.107.233])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jun 2022 14:34:24 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <bpf@vger.kernel.org>
Subject: [PATCH powerpc] powerpc/bpf: Fix use of user_pt_regs in uapi
Date:   Fri, 17 Jun 2022 20:04:04 +0530
Message-Id: <20220617143404.158097-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qfumgx9qVeoKTBlWrN3-GWKpJg8rN7qg
X-Proofpoint-ORIG-GUID: Qfumgx9qVeoKTBlWrN3-GWKpJg8rN7qg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-17_08,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 mlxlogscore=877 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206170061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a partial revert of commit a6460b03f945ee ("powerpc/bpf: Fix
broken uapi for BPF_PROG_TYPE_PERF_EVENT").

Unlike x86, powerpc has both pt_regs and user_pt_regs structures. As
such, we still need to override perf_arch_bpf_user_pt_regs() so that the
correct user_regs structure is used.

However, unlike arm64 and s390, we expose user_pt_regs to userspace as
just 'pt_regs'. Due to this, trying to #include <linux/bpf_perf_event.h>
throws the below error:
  /usr/include/linux/bpf_perf_event.h:14:28: error: field ‘regs’ has incomplete type
     14 |         bpf_user_pt_regs_t regs;
	|                            ^~~~

Note that this was not showing up with the bpf selftest build since
tools/include/uapi/asm/bpf_perf_event.h didn't include the powerpc
variant.

Fix this by removing arch/powerpc/include/uapi/asm/bpf_perf_event.h,
allowing fallback to the asm-generic version.

Fixes: a6460b03f945ee ("powerpc/bpf: Fix broken uapi for BPF_PROG_TYPE_PERF_EVENT")
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/bpf_perf_event.h | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 arch/powerpc/include/uapi/asm/bpf_perf_event.h

diff --git a/arch/powerpc/include/uapi/asm/bpf_perf_event.h b/arch/powerpc/include/uapi/asm/bpf_perf_event.h
deleted file mode 100644
index 5e1e648aeec4c8..00000000000000
--- a/arch/powerpc/include/uapi/asm/bpf_perf_event.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
-#define _UAPI__ASM_BPF_PERF_EVENT_H__
-
-#include <asm/ptrace.h>
-
-typedef struct user_pt_regs bpf_user_pt_regs_t;
-
-#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */

base-commit: bcd1c02813b8ab4ae019c65ffb716c9f579868e7
-- 
2.36.1

