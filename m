Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5814AB021
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 16:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbiBFPM1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Feb 2022 10:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBFPM1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Feb 2022 10:12:27 -0500
X-Greylist: delayed 1077 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 07:12:26 PST
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E53C06173B
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 07:12:25 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 216EQq32008001;
        Sun, 6 Feb 2022 14:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pFHuJ+woiU4TtW3bwhgnb1aDkw50enHp7sB7RAC6Ghs=;
 b=lX41Uj+WCOeiB7G9+uCwsVIviaQdy5ZtCFidi+LqO9xfTi00BbedGx+Mml71yBp3ZXGo
 R6EGrAlCYNhsPkLfr0zLsxyXaz7rSRhaMZWxLhxq743WNQFoF1VEMti0EUH9Di+Pro3h
 ebrpIFWOGqgzrgtxmXADlDRivLXOzySkgrABZrmvxNcsZvyKJlwEyn/67GJRRLW/2k0b
 qVyfsdil9pRC++CS2W+ayJsEsNZYsh2JDid8Uv5ulQvS1VY16V9IQa1b8VFhpVMf3yAl
 nNa5cqz1m+OWm/jmjABtCebybPOce00sOxQSi+xtZCGh09xoU2wQwhcIkcvwHs2YbrH6 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22vk1461-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 14:54:06 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 216Es6m7004770;
        Sun, 6 Feb 2022 14:54:06 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22vk145p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 14:54:06 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 216Emn5a031205;
        Sun, 6 Feb 2022 14:54:04 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3e1gv9nm1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 14:54:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 216Es1dm45744554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Feb 2022 14:54:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3976411C050;
        Sun,  6 Feb 2022 14:54:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B878A11C04A;
        Sun,  6 Feb 2022 14:54:00 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Feb 2022 14:54:00 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/2] s390/bpf: Introduce user_pt_regs_v2
Date:   Sun,  6 Feb 2022 15:53:49 +0100
Message-Id: <20220206145350.2069779-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220206145350.2069779-1-iii@linux.ibm.com>
References: <20220206145350.2069779-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uOqfLGjwAE4Hzk2JEGpSx0ahKU6Jz4ZT
X-Proofpoint-ORIG-GUID: rVa8qETv7VRa8FkDu_-tYNtet-iGeCVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-06_04,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=898
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060108
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extending user_pt_regs breaks struct bpf_perf_event_data ABI, so
instead of exposing orig_gpr2 through it, create its copy with
orig_gpr2 at the end and use it in libbpf.

The existing members are copy-pasted, so now there are 3 copies in
total. It might be tempting to add a user_pt_regs member to
user_pt_regs_v2 instead, however, there is no guarantee that then
user_pt_regs_v2.orig_gpr2 would be at the same offset as
pt_regs.orig_gpr2.

Fixes: 61f88e88f263 ("s390/bpf: Add orig_gpr2 to user_pt_regs")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/ptrace.h      |  1 +
 arch/s390/include/uapi/asm/ptrace.h | 10 ++++++++--
 tools/lib/bpf/bpf_tracing.h         |  4 ++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index c8698e643904..1a08f36395e5 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -79,6 +79,7 @@ enum {
 struct pt_regs {
 	union {
 		user_pt_regs user_regs;
+		user_pt_regs_v2 user_regs_v2;
 		struct {
 			unsigned long args[1];
 			psw_t psw;
diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
index b3dec603f507..b9405b8f0d47 100644
--- a/arch/s390/include/uapi/asm/ptrace.h
+++ b/arch/s390/include/uapi/asm/ptrace.h
@@ -288,16 +288,22 @@ typedef struct {
 } s390_regs;
 
 /*
- * The user_pt_regs structure exports the beginning of
+ * The user_pt_regs and user_pt_regs_v2 structures export the beginning of
  * the in-kernel pt_regs structure to user space.
  */
 typedef struct {
 	unsigned long args[1];
 	psw_t psw;
 	unsigned long gprs[NUM_GPRS];
-	unsigned long orig_gpr2;
 } user_pt_regs;
 
+typedef struct {
+	unsigned long args[1];
+	psw_t psw;
+	unsigned long gprs[NUM_GPRS];
+	unsigned long orig_gpr2;
+} user_pt_regs_v2;
+
 /*
  * Now for the user space program event recording (trace) definitions.
  * The following structures are used only for the ptrace interface, don't
diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index cf980e54d331..76abbc5ff2e8 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -114,8 +114,8 @@
 
 #elif defined(bpf_target_s390)
 
-/* s390 provides user_pt_regs instead of struct pt_regs to userspace */
-#define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
+/* s390 provides user_pt_regs_v2 instead of struct pt_regs to userspace */
+#define __PT_REGS_CAST(x) ((const user_pt_regs_v2 *)(x))
 #define __PT_PARM1_REG gprs[2]
 #define __PT_PARM1_REG_SYSCALL orig_gpr2
 #define __PT_PARM2_REG gprs[3]
-- 
2.34.1

