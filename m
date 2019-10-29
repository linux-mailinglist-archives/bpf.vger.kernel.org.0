Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAA2E8AC8
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 15:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbfJ2Oas (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 10:30:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728306AbfJ2Oas (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Oct 2019 10:30:48 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9TEPOsK143439
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 10:30:46 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxntjc48f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 10:30:46 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Tue, 29 Oct 2019 14:30:34 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Oct 2019 14:30:32 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9TEUUC343581602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 14:30:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 428FFAE061;
        Tue, 29 Oct 2019 14:30:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06A40AE053;
        Tue, 29 Oct 2019 14:30:30 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.96.221])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Oct 2019 14:30:29 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Ignatov <rdna@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: test narrow load from bpf_sysctl.write
Date:   Tue, 29 Oct 2019 15:30:27 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102914-0020-0000-0000-00000380A502
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102914-0021-0000-0000-000021D6AE8D
Message-Id: <20191029143027.28681-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290139
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are tests for full and narrows loads from bpf_sysctl.file_pos, but
for bpf_sysctl.write only full load is tested. Add the missing test.

Suggested-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/test_sysctl.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index a320e3844b17..7aff907003d3 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -120,6 +120,29 @@ static struct sysctl_test tests[] = {
 		.newval = "(none)", /* same as default, should fail anyway */
 		.result = OP_EPERM,
 	},
+	{
+		.descr = "ctx:write sysctl:write read ok narrow",
+		.insns = {
+			/* u64 w = (u16)write & 1; */
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+			BPF_LDX_MEM(BPF_H, BPF_REG_7, BPF_REG_1,
+				    offsetof(struct bpf_sysctl, write)),
+#else
+			BPF_LDX_MEM(BPF_H, BPF_REG_7, BPF_REG_1,
+				    offsetof(struct bpf_sysctl, write) + 2),
+#endif
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_7, 1),
+			/* return 1 - w; */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_7),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "kernel/domainname",
+		.open_flags = O_WRONLY,
+		.newval = "(none)", /* same as default, should fail anyway */
+		.result = OP_EPERM,
+	},
 	{
 		.descr = "ctx:write sysctl:read write reject",
 		.insns = {
-- 
2.23.0

