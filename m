Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADD3EA765
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbhHLPS5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 11:18:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237917AbhHLPS4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Aug 2021 11:18:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CF2dEm169911;
        Thu, 12 Aug 2021 11:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4G5/4s83oiiY4Nz+mchKFYvy0mEJckidQFhBnYq3ago=;
 b=YYVYkd7hi+3icHIt/gYE7KV7Q/emSs4y5S6Ms+I7QmcV2ri4VfIwA9G3WCWcvfmLgRFe
 gcWAXhMHRQRSU8BHkqHX36KI7VwxYC5y77kH0LzATymU/YJIMFFURWJpl5ZV86r4L0Mg
 lDEgoBdZU78KG+WayRdtmf+ohWhCQMvi8Gv4k+fO1TR9YqrBd8gx4RY1oE3knIMIc+dK
 TjmeMmRDMQkXgRSo2tgrCroIanbqFG9Yj8wpStIyPuipSwQifoxPGRZCVZNgGljh6eXT
 fmdpASevndPiSFq2Q2mBtas4qBN+YxE7r+2IBxCfR1q2w7kLxqojHzAi5g5g+cgRz+2v xw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ad0qy3s7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 11:18:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CFCNTl014968;
        Thu, 12 Aug 2021 15:18:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3acn76a5hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 15:18:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CFF0BJ23789900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 15:15:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5992BA406F;
        Thu, 12 Aug 2021 15:18:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0007DA405C;
        Thu, 12 Aug 2021 15:18:13 +0000 (GMT)
Received: from vm.lan (unknown [9.145.77.113])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 15:18:13 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf v3 2/2] selftests: bpf: test that dead ldx_w insns are accepted
Date:   Thu, 12 Aug 2021 17:18:11 +0200
Message-Id: <20210812151811.184086-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812151811.184086-1-iii@linux.ibm.com>
References: <20210812151811.184086-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Eh19lVGilFG-Q8yJ-gtdc4O-lIBbca0c
X-Proofpoint-ORIG-GUID: Eh19lVGilFG-Q8yJ-gtdc4O-lIBbca0c
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_05:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108120098
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prevent regressions related to zero-extension metadata handling during
dead code sanitization.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/verifier/dead_code.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/dead_code.c b/tools/testing/selftests/bpf/verifier/dead_code.c
index 2c8935b3e65d..ee454327e5c6 100644
--- a/tools/testing/selftests/bpf/verifier/dead_code.c
+++ b/tools/testing/selftests/bpf/verifier/dead_code.c
@@ -159,3 +159,15 @@
 	.result = ACCEPT,
 	.retval = 2,
 },
+{
+	"dead code: zero extension",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4),
+	BPF_JMP_IMM(BPF_JGE, BPF_REG_0, 0, 1),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -4),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 0,
+},
-- 
2.31.1

