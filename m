Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589AD4A68A8
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 00:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiBAXmW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 18:42:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230039AbiBAXmV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 18:42:21 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211Mt85Y014530;
        Tue, 1 Feb 2022 23:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uKY7oDTgX3fPpckMMfUJdTADb5iXBbsdB7I9p4Ry3vc=;
 b=QOwe8t0X+365N0nfQkLISQqGFPe1MH1HVy7G4hcbPsxN5f+6KbgmSb2/oc6bGJo8BCXi
 iwauVIS6CrHdf66rlxAdRr+NPEjQDtqwaRRYKJbsFonrUaFTbpaFdr1LYx3u4UrsnfDf
 2Z1jiTkNQ4iS1Mp7ITGZZf/UQBrYFn2e7VAEarldEuBZUZH1xMhcGj5oV4BR7u6sATV4
 onoJdCniiUwAl7tKFJ05VJ4J1KQQe/Ai1yJdxODQGjnmvAHGxRJ6pCDtvMVOw6NO9FYG
 SuzBA/tLG28NXx8ngcL3XrClgv7Zx7f6HAWlPsZOlXOK2ANMbIjKGWM6EKj8kn7viTmY 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dye31gmpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:09 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211Nbcgl027393;
        Tue, 1 Feb 2022 23:42:09 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dye31gmny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:09 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211NcvR9003581;
        Tue, 1 Feb 2022 23:42:07 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3dvw79feqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211Ng3oV46727646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 23:42:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9097911C04C;
        Tue,  1 Feb 2022 23:42:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19FCE11C050;
        Tue,  1 Feb 2022 23:42:03 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 23:42:03 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/3] s390/bpf: Add orig_gpr2 to user_pt_regs
Date:   Wed,  2 Feb 2022 00:41:58 +0100
Message-Id: <20220201234200.1836443-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201234200.1836443-1-iii@linux.ibm.com>
References: <20220201234200.1836443-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tCRABy8EmXqiThBH6xY_moutu7gUKqii
X-Proofpoint-ORIG-GUID: 4E2VC9486uE9nw49F2eN1AUMiFfZPwhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_10,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 mlxlogscore=974 priorityscore=1501 spamscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010130
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

