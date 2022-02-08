Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107AA4AD0CA
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbiBHFci (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiBHFRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 00:17:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A76C0401ED
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 21:17:13 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2182jWpY010661;
        Tue, 8 Feb 2022 05:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9BV0umtU4uqmUlD8CjFKbc/UsAQ3TN3IGw58+vupHC4=;
 b=kQ6sLKaWIern85/1ublYPyvFEe5jDLZY6itXG/KrEeQ6gYLDVTHTyND7IhEpyWynDvaq
 zrwmeTb1qnts6cgWjrv4NoXHaneUA62QMr/MgAZ3mrjP+jEqEmoFKKHPjcz289JJ0tgU
 CLO308HYhqbIY46r5xFpgDp14iVIQwjsuba1vT62Arz74xhg8Wtd9Tcr9F/+PZggM8zS
 odQoqfw0MK6MIGoitvxpNke/MfbMvByIsKwpBx82TSDpcDjcxjda1NTsjfeilq4EL8jd
 8S5e1Sx1xQ7LfOCsOUk5WnffUsJFmBTWUUHIglPQU4zZK+AHpV7RTLjNBVzBLQCt5IW+ 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22qf868g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:55 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21856UCn023865;
        Tue, 8 Feb 2022 05:16:55 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22qf867v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:54 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2185EEMF029344;
        Tue, 8 Feb 2022 05:16:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3e1ggj1g6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:52 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2185GhSc48497046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 05:16:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E26B11C04A;
        Tue,  8 Feb 2022 05:16:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C21711C052;
        Tue,  8 Feb 2022 05:16:42 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 05:16:42 +0000 (GMT)
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
Subject: [PATCH bpf-next v4 05/14] libbpf: Generalize overriding syscall parameter access macros
Date:   Tue,  8 Feb 2022 06:16:26 +0100
Message-Id: <20220208051635.2160304-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208051635.2160304-1-iii@linux.ibm.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZmSsgwT3gMQEz2tVgYzrf_LClhSuCsJq
X-Proofpoint-GUID: kSmJ0LR4A8BbUq0O4n4Ggt6dyrLbCpJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of conditionally overriding PT_REGS_PARM4_SYSCALL, provide
default fallbacks for all __PT_PARMn_REG_SYSCALL macros, so that
architectures can simply override a specific syscall parameter macro.
Also allow completely overriding PT_REGS_PARM1_SYSCALL for
non-trivial access sequences.

Co-developed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 48 +++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index da7e8d5c939c..82f1e935d549 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -265,25 +265,43 @@ struct pt_regs;
 
 #endif
 
-#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
-#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
-#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
-#ifdef __PT_PARM4_REG_SYSCALL
+#ifndef __PT_PARM1_REG_SYSCALL
+#define __PT_PARM1_REG_SYSCALL __PT_PARM1_REG
+#endif
+#ifndef __PT_PARM2_REG_SYSCALL
+#define __PT_PARM2_REG_SYSCALL __PT_PARM2_REG
+#endif
+#ifndef __PT_PARM3_REG_SYSCALL
+#define __PT_PARM3_REG_SYSCALL __PT_PARM3_REG
+#endif
+#ifndef __PT_PARM4_REG_SYSCALL
+#define __PT_PARM4_REG_SYSCALL __PT_PARM4_REG
+#endif
+#ifndef __PT_PARM5_REG_SYSCALL
+#define __PT_PARM5_REG_SYSCALL __PT_PARM5_REG
+#endif
+
+#ifndef PT_REGS_PARM1_SYSCALL
+#define PT_REGS_PARM1_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM1_REG_SYSCALL)
+#endif
+#ifndef PT_REGS_PARM2_SYSCALL
+#define PT_REGS_PARM2_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM2_REG_SYSCALL)
+#endif
+#ifndef PT_REGS_PARM3_SYSCALL
+#define PT_REGS_PARM3_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM3_REG_SYSCALL)
+#endif
+#ifndef PT_REGS_PARM4_SYSCALL
 #define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCALL)
-#else /* __PT_PARM4_REG_SYSCALL */
-#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
 #endif
-#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
+#ifndef PT_REGS_PARM5_SYSCALL
+#define PT_REGS_PARM5_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM5_REG_SYSCALL)
+#endif
 
-#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
-#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
-#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
-#ifdef __PT_PARM4_REG_SYSCALL
+#define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM1_REG_SYSCALL)
+#define PT_REGS_PARM2_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM2_REG_SYSCALL)
+#define PT_REGS_PARM3_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM3_REG_SYSCALL)
 #define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG_SYSCALL)
-#else /* __PT_PARM4_REG_SYSCALL */
-#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
-#endif
-#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
+#define PT_REGS_PARM5_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM5_REG_SYSCALL)
 
 #else /* defined(bpf_target_defined) */
 
-- 
2.34.1

