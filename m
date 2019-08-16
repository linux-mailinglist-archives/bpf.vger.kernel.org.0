Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224BE90052
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2019 12:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfHPKzD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 06:55:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbfHPKzD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 06:55:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GAsucS004824
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 06:55:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2udr2dpr98-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 06:54:59 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Fri, 16 Aug 2019 11:53:07 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Aug 2019 11:53:04 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7GAr3ea60293156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 10:53:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07FE1A4054;
        Fri, 16 Aug 2019 10:53:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADA42A405C;
        Fri, 16 Aug 2019 10:53:02 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.96.190])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 10:53:02 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Andrey Ignatov <rdna@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf v2] bpf: fix accessing bpf_sysctl.file_pos on s390
Date:   Fri, 16 Aug 2019 12:53:00 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19081610-0012-0000-0000-0000033F5CCD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081610-0013-0000-0000-000021797650
Message-Id: <20190816105300.49035-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160114
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
v1->v2: Merge bpf_ctx_narrow_load_shift and
bpf_ctx_narrow_access_offset.

 include/linux/filter.h                    |  8 ++++----
 kernel/bpf/cgroup.c                       | 10 ++++++++--
 kernel/bpf/verifier.c                     |  4 ++--
 tools/testing/selftests/bpf/test_sysctl.c |  9 ++++++++-
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 92c6e31fb008..2ce57645f3cd 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -749,14 +749,14 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
 }
 
 static inline u8
-bpf_ctx_narrow_load_shift(u32 off, u32 size, u32 size_default)
+bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
 {
-	u8 load_off = off & (size_default - 1);
+	u8 access_off = off & (size_default - 1);
 
 #ifdef __LITTLE_ENDIAN
-	return load_off * 8;
+	return access_off;
 #else
-	return (size_default - (load_off + size)) * 8;
+	return size_default - (access_off + size);
 #endif
 }
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 0a00eaca6fae..00c4647ce92a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1325,6 +1325,7 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
 				     struct bpf_prog *prog, u32 *target_size)
 {
 	struct bpf_insn *insn = insn_buf;
+	u32 read_size;
 
 	switch (si->off) {
 	case offsetof(struct bpf_sysctl, write):
@@ -1356,7 +1357,9 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
 				treg, si->dst_reg,
 				offsetof(struct bpf_sysctl_kern, ppos));
 			*insn++ = BPF_STX_MEM(
-				BPF_SIZEOF(u32), treg, si->src_reg, 0);
+				BPF_SIZEOF(u32), treg, si->src_reg,
+				bpf_ctx_narrow_access_offset(
+					0, sizeof(u32), sizeof(loff_t)));
 			*insn++ = BPF_LDX_MEM(
 				BPF_DW, treg, si->dst_reg,
 				offsetof(struct bpf_sysctl_kern, tmp_reg));
@@ -1365,8 +1368,11 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
 				BPF_FIELD_SIZEOF(struct bpf_sysctl_kern, ppos),
 				si->dst_reg, si->src_reg,
 				offsetof(struct bpf_sysctl_kern, ppos));
+			read_size = bpf_size_to_bytes(BPF_SIZE(si->code));
 			*insn++ = BPF_LDX_MEM(
-				BPF_SIZE(si->code), si->dst_reg, si->dst_reg, 0);
+				BPF_SIZE(si->code), si->dst_reg, si->dst_reg,
+				bpf_ctx_narrow_access_offset(
+					0, read_size, sizeof(loff_t)));
 		}
 		*target_size = sizeof(u32);
 		break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c84d83f86141..d1d4c995a9eb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8616,8 +8616,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 
 		if (is_narrower_load && size < target_size) {
-			u8 shift = bpf_ctx_narrow_load_shift(off, size,
-							     size_default);
+			u8 shift = bpf_ctx_narrow_access_offset(
+				off, size, size_default) * 8;
 			if (ctx_field_size <= 4) {
 				if (shift)
 					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
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

