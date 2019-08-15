Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8518EA1D
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfHOLUx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 07:20:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728922AbfHOLUx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Aug 2019 07:20:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FBGdsU117540
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 07:20:52 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ud3urd49y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 07:20:52 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 15 Aug 2019 12:20:49 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Aug 2019 12:20:47 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7FBKjxR60489742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 11:20:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A8534C040;
        Thu, 15 Aug 2019 11:20:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 612FF4C046;
        Thu, 15 Aug 2019 11:20:45 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.99.89])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Aug 2019 11:20:45 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf] bpf: fix accessing bpf_sysctl.file_pos on s390
Date:   Thu, 15 Aug 2019 13:20:44 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19081511-4275-0000-0000-00000359678A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081511-4276-0000-0000-0000386B7CE6
Message-Id: <20190815112044.38420-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150122
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"ctx:file_pos sysctl:read write ok" fails on s390 with "Read value  !=
nux". This is because verifier rewrites a complete 32-bit
bpf_sysctl.file_pos update to a partial update of the first 32 bits of
64-bit *bpf_sysctl_kern.ppos, which is not correct on big-endian
systems.

Fix by using an offset on big-endian systems.

Ditto for bpf_sysctl.file_pos reads. Currently the test does not detect
a problem there, since it expects to see 0, which it gets with high
probability in error cases, so change it to seek to offset 3 and expect
3 in bpf_sysctl.file_pos.

Fixes: e1550bfe0de4 ("bpf: Add file_pos field to bpf_sysctl ctx")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/linux/filter.h                    | 10 ++++++++++
 kernel/bpf/cgroup.c                       |  9 +++++++--
 tools/testing/selftests/bpf/test_sysctl.c |  9 ++++++++-
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 92c6e31fb008..94e81c56d81c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -760,6 +760,16 @@ bpf_ctx_narrow_load_shift(u32 off, u32 size, u32 size_default)
 #endif
 }
 
+static inline s16
+bpf_ctx_narrow_access_offset(size_t variable_size, size_t access_size)
+{
+#ifdef __LITTLE_ENDIAN
+	return 0;
+#else
+	return variable_size - access_size;
+#endif
+}
+
 #define bpf_ctx_wide_access_ok(off, size, type, field)			\
 	(size == sizeof(__u64) &&					\
 	off >= offsetof(type, field) &&					\
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 0a00eaca6fae..b835fbb13ea8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1356,7 +1356,9 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
 				treg, si->dst_reg,
 				offsetof(struct bpf_sysctl_kern, ppos));
 			*insn++ = BPF_STX_MEM(
-				BPF_SIZEOF(u32), treg, si->src_reg, 0);
+				BPF_SIZEOF(u32), treg, si->src_reg,
+				bpf_ctx_narrow_access_offset(
+					sizeof(loff_t), sizeof(u32)));
 			*insn++ = BPF_LDX_MEM(
 				BPF_DW, treg, si->dst_reg,
 				offsetof(struct bpf_sysctl_kern, tmp_reg));
@@ -1366,7 +1368,10 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
 				si->dst_reg, si->src_reg,
 				offsetof(struct bpf_sysctl_kern, ppos));
 			*insn++ = BPF_LDX_MEM(
-				BPF_SIZE(si->code), si->dst_reg, si->dst_reg, 0);
+				BPF_SIZE(si->code), si->dst_reg, si->dst_reg,
+				bpf_ctx_narrow_access_offset(
+					sizeof(loff_t),
+					bpf_size_to_bytes(BPF_SIZE(si->code))));
 		}
 		*target_size = sizeof(u32);
 		break;
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index a3bebd7c68dd..abc26248a7f1 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -31,6 +31,7 @@ struct sysctl_test {
 	enum bpf_attach_type attach_type;
 	const char *sysctl;
 	int open_flags;
+	int seek;
 	const char *newval;
 	const char *oldval;
 	enum {
@@ -139,7 +140,7 @@ static struct sysctl_test tests[] = {
 			/* If (file_pos == X) */
 			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
 				    offsetof(struct bpf_sysctl, file_pos)),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 3, 2),
 
 			/* return ALLOW; */
 			BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -152,6 +153,7 @@ static struct sysctl_test tests[] = {
 		.attach_type = BPF_CGROUP_SYSCTL,
 		.sysctl = "kernel/ostype",
 		.open_flags = O_RDONLY,
+		.seek = 3,
 		.result = SUCCESS,
 	},
 	{
@@ -1442,6 +1444,11 @@ static int access_sysctl(const char *sysctl_path,
 	if (fd < 0)
 		return fd;
 
+	if (test->seek && lseek(fd, test->seek, SEEK_SET) == -1) {
+		log_err("lseek(%d) failed", test->seek);
+		goto err;
+	}
+
 	if (test->open_flags == O_RDONLY) {
 		char buf[128];
 
-- 
2.21.0

