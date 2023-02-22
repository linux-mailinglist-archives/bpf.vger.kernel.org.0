Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8443969FECC
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 23:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjBVW6Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 17:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBVW6Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 17:58:25 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A52412054
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:58:23 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MLj5Mc010332;
        Wed, 22 Feb 2023 22:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9Nglydpq9Z4mt/bU+YJkmVXTpwppIqV497AisYsjKpw=;
 b=PV2KzD953mppV8SKq1QcbeSONxAnfFyIZR90QMd/3TU9gLg5+gFaUYIQgJlUoICMij7R
 1uFYyrJMwphNkJ0jvQl5BlABtG1geaPS7W9GcKhR9fZbSI212CRWLy0QFngE4N6On+w4
 vXQVzmfLoami+J8lfiZk++LkGx+7uQ1ktA7tq1rMFQcbjThl3at8/1x2OoX1cpunzQSv
 nRBp0EXnaNdU3mhvE4JhSupU0kwpS5mIB12rKLaOjVsF5+ujLjMnxt38I+gNXd/4yuJ/
 jmRciFfDnRoHPLZdLUQWb8DSskn4eJGQY/WRSA4RvWCbxuZ0g0It2Slz+NCRDfM+0iXH xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwu7x13y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:25 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMajAB016597;
        Wed, 22 Feb 2023 22:37:24 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwu7x13xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:24 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MASW2Y014648;
        Wed, 22 Feb 2023 22:37:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3ntpa64gdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbJ2h30277898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CFC420043;
        Wed, 22 Feb 2023 22:37:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D64120040;
        Wed, 22 Feb 2023 22:37:18 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:18 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 01/12] selftests/bpf: Finish folding after BPF_FUNC_csum_diff
Date:   Wed, 22 Feb 2023 23:37:03 +0100
Message-Id: <20230222223714.80671-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8DT1mmDUyv8qElAU5EvcbBo59umV8Nte
X-Proofpoint-GUID: E7sxXQsS69Xd77iprDa_6eClBgwNnCSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=923
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_csum_diff() may return non-folded checksum, and the arm
implementation actually does this. Finish folding in the test prog.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/verifier/array_access.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/verifier/array_access.c b/tools/testing/selftests/bpf/verifier/array_access.c
index 1b138cd2b187..e570d6a95702 100644
--- a/tools/testing/selftests/bpf/verifier/array_access.c
+++ b/tools/testing/selftests/bpf/verifier/array_access.c
@@ -241,7 +241,7 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 14),
 
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_MOV64_IMM(BPF_REG_2, 4),
@@ -250,7 +250,15 @@
 	BPF_MOV64_IMM(BPF_REG_5, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 		     BPF_FUNC_csum_diff),
+	/* csum_partial() is allowed to return both 0xffffffe3 and 0x1ffe2 */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 16),
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffff),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 16),
 	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffff),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-- 
2.39.1

