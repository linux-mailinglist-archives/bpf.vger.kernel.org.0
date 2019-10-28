Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D18E7159
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2019 13:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389070AbfJ1M3Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Oct 2019 08:29:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28708 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727503AbfJ1M3X (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Oct 2019 08:29:23 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9SCRmfu136956
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2019 08:29:22 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vvgy37km4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2019 08:29:21 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 28 Oct 2019 12:29:19 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Oct 2019 12:29:16 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9SCTEwu41943278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 12:29:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D098C11C05B;
        Mon, 28 Oct 2019 12:29:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8237311C054;
        Mon, 28 Oct 2019 12:29:14 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.44])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Oct 2019 12:29:14 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Ignatov <rdna@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf] bpf: allow narrow loads of bpf_sysctl fields with offset > 0
Date:   Mon, 28 Oct 2019 13:29:02 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102812-0008-0000-0000-0000032860AF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102812-0009-0000-0000-00004A479EA4
Message-Id: <20191028122902.9763-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910280128
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"ctx:file_pos sysctl:read read ok narrow" works on s390 by accident: it
reads the wrong byte, which happens to have the expected value of 0.
Improve the test by seeking to the 4th byte and expecting 4 instead of
0.

This makes the latent problem apparent: the test attempts to read the
first byte of bpf_sysctl.file_pos, assuming this is the least-significant
byte, which is not the case on big-endian machines: a non-zero offset is
needed.

The point of the test is to verify narrow loads, so we cannot cheat our
way out by simply using BPF_W. The existence of the test means that such
loads have to be supported, most likely because llvm can generate them.
Fix the test by adding a big-endian variant, which uses an offset to
access the least-significant byte of bpf_sysctl.file_pos.

This reveals the final problem: verifier rejects accesses to bpf_sysctl
fields with offset > 0. Such accesses are already allowed for a wide
range of structs: __sk_buff, bpf_sock_addr and sk_msg_md to name a few.
Extend this support to bpf_sysctl by using bpf_ctx_range instead of
offsetof when matching field offsets.

Fixes: 7b146cebe30c ("bpf: Sysctl hook")
Fixes: e1550bfe0de4 ("bpf: Add file_pos field to bpf_sysctl ctx")
Fixes: 9a1027e52535 ("selftests/bpf: Test file_pos field in bpf_sysctl ctx")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/cgroup.c                       | 4 ++--
 tools/testing/selftests/bpf/test_sysctl.c | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ddd8addcdb5c..a3eaf08e7dd3 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1311,12 +1311,12 @@ static bool sysctl_is_valid_access(int off, int size, enum bpf_access_type type,
 		return false;
 
 	switch (off) {
-	case offsetof(struct bpf_sysctl, write):
+	case bpf_ctx_range(struct bpf_sysctl, write):
 		if (type != BPF_READ)
 			return false;
 		bpf_ctx_record_field_size(info, size_default);
 		return bpf_ctx_narrow_access_ok(off, size, size_default);
-	case offsetof(struct bpf_sysctl, file_pos):
+	case bpf_ctx_range(struct bpf_sysctl, file_pos):
 		if (type == BPF_READ) {
 			bpf_ctx_record_field_size(info, size_default);
 			return bpf_ctx_narrow_access_ok(off, size, size_default);
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index a320e3844b17..7c6e5b173f33 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -161,9 +161,14 @@ static struct sysctl_test tests[] = {
 		.descr = "ctx:file_pos sysctl:read read ok narrow",
 		.insns = {
 			/* If (file_pos == X) */
+#if __BYTE_ORDER == __LITTLE_ENDIAN
 			BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_1,
 				    offsetof(struct bpf_sysctl, file_pos)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+#else
+			BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_1,
+				    offsetof(struct bpf_sysctl, file_pos) + 3),
+#endif
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 4, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -176,6 +181,7 @@ static struct sysctl_test tests[] = {
 		.attach_type = BPF_CGROUP_SYSCTL,
 		.sysctl = "kernel/ostype",
 		.open_flags = O_RDONLY,
+		.seek = 4,
 		.result = SUCCESS,
 	},
 	{
-- 
2.23.0

