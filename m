Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7834A9303
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 05:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356932AbiBDEUj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 23:20:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356924AbiBDEUj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 23:20:39 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2143buSO006602;
        Fri, 4 Feb 2022 04:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bzk1GaOJXCcc0BGy+kCmvuGnBcWRbJV8zMo9OxM8Nnw=;
 b=E+yiIk/e/yzeRKujlcQ+wNxNnxf1p8HQyRqhwrMv8z9uUv88ReCAIUbSbB6B7/LPwlBK
 e60DO3oN/cJmVmrsT9DEd3mHuy98kyKrbsTIKjvogs0nyJR3oxYg1/pm5F5pttlX/knF
 Bmbb9+qlISk6Sdpd/i3UiXGX5L6j2wS8+D18WmazBSZc1928p/g+91PMko4D4/51wmeL
 0B1YV1s4Tv3NbuBl7Ni5KTAHjCpaTP5nYT8FhIUmangGIOz7uFaVRUIIfiBYqzoMiflP
 HyHlk7ezYiebuzlx6TEU3RYBbb7TeblxSKomBBBXQDVD1Bmvgjqkqp7GK1C1dWycsvwi BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx0chw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:13 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21440BSe007501;
        Fri, 4 Feb 2022 04:20:13 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx0chve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:13 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2144DHfB012212;
        Fri, 4 Feb 2022 04:20:11 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3e0r0u15gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2144K5EE25952654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 04:20:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 186B0A4053;
        Fri,  4 Feb 2022 04:20:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D234A404D;
        Fri,  4 Feb 2022 04:20:04 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 04:20:04 +0000 (GMT)
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
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 07/10] libbpf: Fix accessing the first syscall argument on arm64
Date:   Fri,  4 Feb 2022 05:19:52 +0100
Message-Id: <20220204041955.1958263-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204041955.1958263-1-iii@linux.ibm.com>
References: <20220204041955.1958263-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ld6hkt9-urXzjIXAh7oQOG_iuki_AoBQ
X-Proofpoint-ORIG-GUID: tWNn4Ukv2iIWNwEWSwpAFXCFzcZ01JNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_01,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040019
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On arm64, the first syscall argument should be accessed via orig_x0
(see arch/arm64/include/asm/syscall.h). Currently regs[0] is used
instead, leading to bpf_syscall_macro test failure.

Fixes: d084df3b7a4c ("libbpf: Fix the incorrect register read for syscalls on x86_64")
Reported-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 400a4f002f77..4a990111d9a8 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -145,6 +145,7 @@
 /* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
 #define __PT_PARM1_REG regs[0]
+#define __PT_PARM1_REG_SYSCALL orig_x0
 #define __PT_PARM2_REG regs[1]
 #define __PT_PARM3_REG regs[2]
 #define __PT_PARM4_REG regs[3]
-- 
2.34.1

