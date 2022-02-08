Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5EE4AD0DA
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbiBHFcw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiBHFRO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 00:17:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C9C0401E9
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 21:17:12 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2182I3PN021119;
        Tue, 8 Feb 2022 05:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9Qd6UpMF3oJo+XUqq9Ez4PY7I6X62OEtlCTwwlWOB3I=;
 b=nwCku9xjRGXgwN9cGN2IG959S9UuW1/G6ZC3CgudbWZeV5wFUiqRMSu6vRuGa+F6avfC
 OVr68f0scV0REGuOawAeiTrcCJc79CfIpzytiSR4IafzAXP2eg0YaCt8EhbHcozd7T4Z
 VbOMvPgGcpW/Sp0rgdG/vG58h5ZHcmSZBUUDE0ed2X/xJN1ll4lmjE5GbZEA5Aj2sQbj
 8Jqs/qtMn7QPfow09y1wY4IT6j0BrrfSvszQ2ZDnpuDEgMsfugUr0mZ+Ien2Hfiwn9Vo
 ma/79Ok776mldpxxp1hjJu3zZRWYIXJ6A3SE/FwcEd3TL8B42lNWh3Dwsty67cRagot7 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e3fm4js41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:54 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2185GTbp016590;
        Tue, 8 Feb 2022 05:16:53 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e3fm4js3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2185COoq022043;
        Tue, 8 Feb 2022 05:16:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggjtf3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2185GjeM46268712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 05:16:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D933111C04C;
        Tue,  8 Feb 2022 05:16:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41A8011C069;
        Tue,  8 Feb 2022 05:16:45 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 05:16:45 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v4 08/14] libbpf: Use struct pt_regs when compiling with kernel headers
Date:   Tue,  8 Feb 2022 06:16:29 +0100
Message-Id: <20220208051635.2160304-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208051635.2160304-1-iii@linux.ibm.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Uet0BPsgthsOvfvki21-hFZj0xGK88zb
X-Proofpoint-GUID: 7F8L9nOuqSz32NoUU9HEfKsKY0fKKrrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=921 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii says: "... with CO-RE and vmlinux.h it would be more reliable
and straightforward to just stick to kernel-internal struct pt_regs
everywhere ...".

Actually, if vmlinux.h is available, then it's ok to do so for both
CO-RE and non-CO-RE cases, since the beginning of struct pt_regs must
match (struct) user_pt_regs, which must never change.

Implement this by not defining __PT_REGS_CAST if the user included
vmlinux.h.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 7a015ee8fb11..07e291d77e83 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -118,8 +118,11 @@
 
 #define __BPF_ARCH_HAS_SYSCALL_WRAPPER
 
+#if !defined(__KERNEL__) && !defined(__VMLINUX_H__)
 /* s390 provides user_pt_regs instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
+#endif
+
 #define __PT_PARM1_REG gprs[2]
 #define __PT_PARM2_REG gprs[3]
 #define __PT_PARM3_REG gprs[4]
@@ -148,8 +151,11 @@
 
 #define __BPF_ARCH_HAS_SYSCALL_WRAPPER
 
+#if !defined(__KERNEL__) && !defined(__VMLINUX_H__)
 /* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
+#endif
+
 #define __PT_PARM1_REG regs[0]
 #define __PT_PARM2_REG regs[1]
 #define __PT_PARM3_REG regs[2]
@@ -207,7 +213,10 @@
 
 #elif defined(bpf_target_riscv)
 
+#if !defined(__KERNEL__) && !defined(__VMLINUX_H__)
 #define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
+#endif
+
 #define __PT_PARM1_REG a0
 #define __PT_PARM2_REG a1
 #define __PT_PARM3_REG a2
-- 
2.34.1

