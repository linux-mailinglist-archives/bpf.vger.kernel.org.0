Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296903EA62E
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 16:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbhHLOGI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 10:06:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237823AbhHLOGE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Aug 2021 10:06:04 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CE3CMW051521;
        Thu, 12 Aug 2021 10:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gnQNCAeW+594utPqWg7e5kYt+6HMtJSgfkL12DDN7bA=;
 b=JK6OE+N1qB38CWR5RATLjki08gXY10A8gOHRhcBe89DF6LXUaGquv1oCL06Z56zGgnPi
 DeQPbEM+mSfdVYmJ0XPxd6ePGmhulBXP7UxCzsPBIOtIapkgG30n0/ViFE/ejBAampZX
 pIiWanROX+XomYd1ESCvhCXnrkcaQT9E3dYN/tyd5oY/rAwYcJnPhbC2z0q+Y3OLn+4M
 riP1C9Z9zDRZ1u2iBGMDi1x5fR8XuBg22TQq5wq2UxG3tMTCZMe24ymmIL+mEfP0ZKSL
 W6GNEETKLmdL9DzaNpStw/uwL6pcuftQ0BI5vVwqhmPTVBXUymlnpOgG4O2i63yNxHTA EQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3acstnubyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 10:05:27 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CE44UX014802;
        Thu, 12 Aug 2021 14:05:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3abujquhtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 14:05:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CE5Liv46793134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 14:05:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DE4211C06E;
        Thu, 12 Aug 2021 14:05:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FB1B11C082;
        Thu, 12 Aug 2021 14:05:21 +0000 (GMT)
Received: from vm.lan (unknown [9.145.77.113])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 14:05:21 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf 2/2] selftests: bpf: test that dead ldx_w insns are accepted
Date:   Thu, 12 Aug 2021 16:05:18 +0200
Message-Id: <20210812140518.183178-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812140518.183178-1-iii@linux.ibm.com>
References: <20210812140518.183178-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wYzBSyIcLb4HJzAXqC-r9kYyLvTqFhQJ
X-Proofpoint-ORIG-GUID: wYzBSyIcLb4HJzAXqC-r9kYyLvTqFhQJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_05:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120091
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prevent regressions related to zero-extension metadata handling during
dead code sanitization.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/verifier/dead_code.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/dead_code.c b/tools/testing/selftests/bpf/verifier/dead_code.c
index 2c8935b3e65d..c642138b7fc2 100644
--- a/tools/testing/selftests/bpf/verifier/dead_code.c
+++ b/tools/testing/selftests/bpf/verifier/dead_code.c
@@ -159,3 +159,16 @@
 	.result = ACCEPT,
 	.retval = 2,
 },
+{
+	"dead code: zero extension",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 1),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, 0),
+	BPF_EXIT_INSN(),
+	},
+	.errstr_unpriv = "invalid read from stack R10 off=0 size=4",
+	.result_unpriv = REJECT,
+	.result = ACCEPT,
+	.retval = 0,
+},
-- 
2.31.1

