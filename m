Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23474AE69A
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242874AbiBICjd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244816AbiBICSL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 21:18:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A71C06157B
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 18:18:11 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2191Bs0v015933;
        Wed, 9 Feb 2022 02:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cZd0b1fo9mLcchReJ0eNkskaOtdkEVIIY1jRlA8RFOE=;
 b=f0ZWGoFfLNlzhFTxt7M/8m2NUza+EE7AUgdzfrADBHS+E7lS/6ebjO9wp4tCkWebUVux
 O8sJZCyf+OsZJsvEpAlxKLMMgO9tQXrUx89KvK/6DGFo3kvpXP/DPgKi+qUDXjkhh8OG
 /77ZNoD7nR+ZtxddaIgbPa8nLoEhwicybbx5F0duUMV7zosoWeVM/Yj6Srf3qk0FCNVQ
 /1de2kwCiW6kqEOjQ2c40NMAuba5DXHoqnyjfuYtJEGz1JN2e+co9Au71yYdX8sXjGxX
 aSC8rs5xYG7fBrgrd2xDuJ2gvea2VXq89AOLVk2yu27vJm3fDHBRW6uNzUbVbTrUqPF0 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3tst7a07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:17:59 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21927ova019352;
        Wed, 9 Feb 2022 02:17:58 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3tst79yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:17:58 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2192D5Rc023232;
        Wed, 9 Feb 2022 02:17:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3e1ggj997v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:17:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2192HoFB37552452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 02:17:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 381D5A405F;
        Wed,  9 Feb 2022 02:17:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B835FA4054;
        Wed,  9 Feb 2022 02:17:49 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Feb 2022 02:17:49 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v5 02/10] libbpf: Add PT_REGS_SYSCALL_REGS macro
Date:   Wed,  9 Feb 2022 03:17:37 +0100
Message-Id: <20220209021745.2215452-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209021745.2215452-1-iii@linux.ibm.com>
References: <20220209021745.2215452-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4arUK9C-lE1QDblazVHtjUtgtCTr3xff
X-Proofpoint-GUID: miog70DscaN_0YaaMmuXA62JujO-q6y6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_08,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=995 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Architectures that select ARCH_HAS_SYSCALL_WRAPPER pass a pointer to
struct pt_regs to syscall handlers, others unpack it into individual
function parameters. Introduce a macro to describe what a particular
arch does.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 032ba809f3e5..a5e92656bfba 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -326,6 +326,16 @@ struct pt_regs;
 
 #endif /* defined(bpf_target_defined) */
 
+/*
+ * When invoked from a syscall handler kprobe, returns a pointer to a
+ * struct pt_regs containing syscall arguments and suitable for passing to
+ * PT_REGS_PARMn_SYSCALL() and PT_REGS_PARMn_CORE_SYSCALL().
+ */
+#ifndef PT_REGS_SYSCALL_REGS
+/* By default, assume that the arch selects ARCH_HAS_SYSCALL_WRAPPER. */
+#define PT_REGS_SYSCALL_REGS(ctx) ((struct pt_regs *)PT_REGS_PARM1(ctx))
+#endif
+
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
 #endif
-- 
2.34.1

