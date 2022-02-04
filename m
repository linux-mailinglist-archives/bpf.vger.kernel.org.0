Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3023D4A9B68
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 15:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359356AbiBDOur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 09:50:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229837AbiBDOur (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 09:50:47 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214E4ooY015998;
        Fri, 4 Feb 2022 14:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uKY7oDTgX3fPpckMMfUJdTADb5iXBbsdB7I9p4Ry3vc=;
 b=FAQc0e+Wy8lKk+c9+7ka3RRkoa8v/4nt7eZ9COVaHA5YGhd8ivIevGHyvWqpBjKFwmwA
 EbzkXciIKDC/xDWVleTmrRRpUw74P/crDZ8voahFbs0dbLxRXy6vJ1m0hBrItXZ+j/WE
 JdH4ua6iwxX67jvnLchonY/FOnNHhpS25EvFBrT3BTVaJEA/UAmw/+7LXTEhvktnTjEY
 mrf5Lk40XCkCJ5mezeKvZcfB7jblZonSd6lkvvHpCHvTlDWbK0Wc5dRg9yahjA44Or/A
 S6KN1EM+gGqEsVNaOU4HZIk3J8DXGH5YuDh7iIuXKwWAjuJU8EgpBTGyL5wwNQEho15W /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0rt5e7yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:29 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214EbaF5007606;
        Fri, 4 Feb 2022 14:50:29 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0rt5e7xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:28 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214ElGda005874;
        Fri, 4 Feb 2022 14:50:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3e0r0v5hry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214EoNde48038318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 14:50:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B7C15204E;
        Fri,  4 Feb 2022 14:50:23 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A152852050;
        Fri,  4 Feb 2022 14:50:22 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 02/11] s390/bpf: Add orig_gpr2 to user_pt_regs
Date:   Fri,  4 Feb 2022 15:50:09 +0100
Message-Id: <20220204145018.1983773-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204145018.1983773-1-iii@linux.ibm.com>
References: <20220204145018.1983773-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2_MAasIQ1vIDjmINu8nRj2LdfkIwDZ8B
X-Proofpoint-ORIG-GUID: PrbcGq-3MDVmAPnBDW3r6l9RqgjSl8nM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_05,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 mlxlogscore=927 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040082
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

user_pt_regs is used by eBPF in order to access userspace registers -
see commit 466698e654e8 ("s390/bpf: correct broken uapi for
BPF_PROG_TYPE_PERF_EVENT program type"). In order to access the first
syscall argument from eBPF programs, we need to export orig_gpr2.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/ptrace.h      | 2 +-
 arch/s390/include/uapi/asm/ptrace.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 4ffa8e7f0ed3..c8698e643904 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -83,9 +83,9 @@ struct pt_regs {
 			unsigned long args[1];
 			psw_t psw;
 			unsigned long gprs[NUM_GPRS];
+			unsigned long orig_gpr2;
 		};
 	};
-	unsigned long orig_gpr2;
 	union {
 		struct {
 			unsigned int int_code;
diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
index ad64d673b5e6..b3dec603f507 100644
--- a/arch/s390/include/uapi/asm/ptrace.h
+++ b/arch/s390/include/uapi/asm/ptrace.h
@@ -295,6 +295,7 @@ typedef struct {
 	unsigned long args[1];
 	psw_t psw;
 	unsigned long gprs[NUM_GPRS];
+	unsigned long orig_gpr2;
 } user_pt_regs;
 
 /*
-- 
2.34.1

