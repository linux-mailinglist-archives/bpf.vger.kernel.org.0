Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 108AD96245
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfHTOSO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 10:18:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729995AbfHTOSO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Aug 2019 10:18:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KDvu4F127227
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 10:18:13 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ughmvb4nu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 10:18:13 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Tue, 20 Aug 2019 15:18:11 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 15:18:08 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7KEI66w11796612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 14:18:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53F1FAE06E;
        Tue, 20 Aug 2019 14:18:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1702DAE05A;
        Tue, 20 Aug 2019 14:18:06 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.160])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 14:18:06 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf] selftests/bpf: fix test_cgroup_storage on s390
Date:   Tue, 20 Aug 2019 16:18:04 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082014-0028-0000-0000-00000391B85D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082014-0029-0000-0000-00002453DC9B
Message-Id: <20190820141804.88799-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=946 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200143
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_cgroup_storage fails on s390 with an assertion failure: packets are
dropped when they shouldn't. The problem is that BPF_DW packet count is
accessed as BPF_W with an offset of 0, which is not correct on
big-endian machines.

Since the point of this test is not to verify narrow loads/stores,
simply use BPF_DW when working with packet counts.

Fixes: 68cfa3ac6b8d ("selftests/bpf: add a cgroup storage test")
Fixes: 919646d2a3a9 ("selftests/bpf: extend the storage test to test per-cpu cgroup storage")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/test_cgroup_storage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/testing/selftests/bpf/test_cgroup_storage.c
index 2fc4625c1a15..655729004391 100644
--- a/tools/testing/selftests/bpf/test_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -20,9 +20,9 @@ int main(int argc, char **argv)
 		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 			     BPF_FUNC_get_local_storage),
-		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0),
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 0x1),
-		BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_3, 0),
+		BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
 
 		BPF_LD_MAP_FD(BPF_REG_1, 0), /* map fd */
 		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
@@ -30,7 +30,7 @@ int main(int argc, char **argv)
 			     BPF_FUNC_get_local_storage),
 		BPF_MOV64_IMM(BPF_REG_1, 1),
 		BPF_STX_XADD(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
-		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
 		BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x1),
 		BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 		BPF_EXIT_INSN(),
-- 
2.21.0

