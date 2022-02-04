Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD25E4A9B6B
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 15:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359381AbiBDOuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 09:50:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229837AbiBDOuu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 09:50:50 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214DvUNH011688;
        Fri, 4 Feb 2022 14:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=egM1L1sH7Nic6f1M2/NzF/5uEkXzgIz7BNjGTk0Ehvo=;
 b=R+S8k9DhIAWoxrgHbLatWK0Yk3OnxGXxmDTWdGBBBqVGLLHH3rikxWJUByo51AIPW+J/
 qv+9q8Jq+tA5SY14umPn2wQ0pW5/m5qZr5CgzQaHoCFtTB1VBhQzzqyE0b220bmSrUlT
 fFYaoH7MDzWCL82B+6oJADqMOJIy7I2w37ZmitCy04yYKS1V+tixJF9PHlCt5DhhjxkO
 V1fzYJdXejYpYpNMZ9Ax7bZ5FZoUtMbZx2EtLF+gKc/oBBC0JejT+2+tmyB+rfhX664N
 Rpnsw1BdKkOhzIr8S1gBRDJGQXF8gFvLxHSaL/cdZ+0tGPWek67Z7NgJsBZr2jY3435r eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0qxfyhdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:31 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214DqJWf017987;
        Fri, 4 Feb 2022 14:50:31 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0qxfyhd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:31 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214ElQo7003143;
        Fri, 4 Feb 2022 14:50:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3e0r0u5uga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214EoP4N42991978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 14:50:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E0C752052;
        Fri,  4 Feb 2022 14:50:25 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7F6E65204E;
        Fri,  4 Feb 2022 14:50:24 +0000 (GMT)
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
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 04/11] libbpf: Add __PT_PARM1_REG_SYSCALL macro
Date:   Fri,  4 Feb 2022 15:50:11 +0100
Message-Id: <20220204145018.1983773-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204145018.1983773-1-iii@linux.ibm.com>
References: <20220204145018.1983773-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bSUZbZiAAaOBvMOMpOJy91Ugp-FlSWxT
X-Proofpoint-ORIG-GUID: 7Xl6vkVHoT9zLWN65KIUnsGD2PhbWMn8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_05,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040082
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some architectures have a special way to access the first syscall
argument. There already exists __PT_PARM4_REG_SYSCALL for the
fourth argument, so define a similar macro for the first one.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 032ba809f3e5..30f0964f8c9e 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -265,7 +265,11 @@ struct pt_regs;
 
 #endif
 
+#ifdef __PT_PARM1_REG_SYSCALL
+#define PT_REGS_PARM1_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM1_REG_SYSCALL)
+#else /* __PT_PARM1_REG_SYSCALL */
 #define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
+#endif
 #define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
 #define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
 #ifdef __PT_PARM4_REG_SYSCALL
@@ -275,7 +279,11 @@ struct pt_regs;
 #endif
 #define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
 
+#ifdef __PT_PARM1_REG_SYSCALL
+#define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM1_REG_SYSCALL)
+#else /* __PT_PARM1_REG_SYSCALL */
 #define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
+#endif
 #define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
 #define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
 #ifdef __PT_PARM4_REG_SYSCALL
-- 
2.34.1

