Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADA011A169
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 03:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfLKCej (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 21:34:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26652 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727702AbfLKCej (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Dec 2019 21:34:39 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB2UIsu022471
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 18:34:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=+cHqEbvmQGf+cs9Z4CpXM8jVJsNUx1xdTw/3yOVpL8M=;
 b=JGFK7zjoADjMWHU3L7/kJMx56SOY+RLmt5FDwyKZHuzicGff2R2ZwmYWF0tYTfQNzwCM
 SJ/pzoiuUOfQNPy6a3h14cMU74bXk4NgtQcAtB/rHjWWJIWn0vSAmIH2mg+yco9wyGl0
 dKYLwFQrjCPAfaIibyhI/SGhCsPUGVmIy1A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wt831cuwa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 18:34:38 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 18:34:37 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 617C33713892; Tue, 10 Dec 2019 18:34:34 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 5/5] selftests/bpf: Cover BPF_F_REPLACE in test_cgroup_attach
Date:   Tue, 10 Dec 2019 18:33:31 -0800
Message-ID: <829ef294f0395649f459334b48d4d9a6103a4fc1.1576031228.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576031228.git.rdna@fb.com>
References: <cover.1576031228.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_08:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 suspectscore=13 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=567 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110021
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test replacement of a cgroup-bpf program attached with BPF_F_ALLOW_MULTI
and possible failure modes: invalid combination of flags, invalid
replace_bpf_fd, replacing a non-attachd to specified cgroup program.

Example of program replacing:

  # gdb -q ./test_cgroup_attach
  Reading symbols from /data/users/rdna/bin/test_cgroup_attach...done.
  ...
  Breakpoint 1, test_multiprog () at test_cgroup_attach.c:442
  442     test_cgroup_attach.c: No such file or directory.
  (gdb)
  [2]+  Stopped                 gdb -q ./test_cgroup_attach
  # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
  ID       AttachType      AttachFlags     Name
  35       egress          multi
  36       egress          multi
  # fg gdb -q ./test_cgroup_attach
  c
  Continuing.
  Detaching after fork from child process 361.

  Breakpoint 2, test_multiprog () at test_cgroup_attach.c:453
  453     in test_cgroup_attach.c
  (gdb)
  [2]+  Stopped                 gdb -q ./test_cgroup_attach
  # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
  ID       AttachType      AttachFlags     Name
  41       egress          multi
  36       egress          multi

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 .../selftests/bpf/test_cgroup_attach.c        | 61 +++++++++++++++++--
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_cgroup_attach.c b/tools/testing/selftests/bpf/test_cgroup_attach.c
index 7671909ee1cb..b9148d752207 100644
--- a/tools/testing/selftests/bpf/test_cgroup_attach.c
+++ b/tools/testing/selftests/bpf/test_cgroup_attach.c
@@ -250,7 +250,7 @@ static int prog_load_cnt(int verdict, int val)
 		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
+		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = val */
 		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /* xadd r0 += r1 */
 
 		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
@@ -290,11 +290,12 @@ static int test_multiprog(void)
 {
 	__u32 prog_ids[4], prog_cnt = 0, attach_flags, saved_prog_id;
 	int cg1 = 0, cg2 = 0, cg3 = 0, cg4 = 0, cg5 = 0, key = 0;
-	int drop_prog, allow_prog[6] = {}, rc = 0;
+	int drop_prog, allow_prog[7] = {}, rc = 0;
+	struct bpf_prog_attach_attr attach_attr;
 	unsigned long long value;
 	int i = 0;
 
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < ARRAY_SIZE(allow_prog); i++) {
 		allow_prog[i] = prog_load_cnt(1, 1 << i);
 		if (!allow_prog[i])
 			goto err;
@@ -400,6 +401,56 @@ static int test_multiprog(void)
 	assert(bpf_map_lookup_elem(map_fd, &key, &value) == 0);
 	assert(value == 1 + 2 + 8 + 16);
 
+	/* invalid input */
+
+	memset(&attach_attr, 0, sizeof(attach_attr));
+	attach_attr.target_fd		= cg1;
+	attach_attr.prog_fd		= allow_prog[6];
+	attach_attr.replace_prog_fd	= allow_prog[0];
+	attach_attr.type		= BPF_CGROUP_INET_EGRESS;
+	attach_attr.flags		= BPF_F_ALLOW_OVERRIDE | BPF_F_REPLACE;
+
+	if (!bpf_prog_attach_xattr(&attach_attr)) {
+		log_err("Unexpected success with OVERRIDE | REPLACE");
+		goto err;
+	}
+	assert(errno == EINVAL);
+
+	attach_attr.flags = BPF_F_REPLACE;
+	if (!bpf_prog_attach_xattr(&attach_attr)) {
+		log_err("Unexpected success with REPLACE alone");
+		goto err;
+	}
+	assert(errno == EINVAL);
+	attach_attr.flags = BPF_F_ALLOW_MULTI | BPF_F_REPLACE;
+
+	attach_attr.replace_prog_fd = -1;
+	if (!bpf_prog_attach_xattr(&attach_attr)) {
+		log_err("Unexpected success with bad replace fd");
+		goto err;
+	}
+	assert(errno == EBADF);
+
+	/* replacing a program that is not attached to cgroup should fail  */
+	attach_attr.replace_prog_fd = allow_prog[3];
+	if (!bpf_prog_attach_xattr(&attach_attr)) {
+		log_err("Unexpected success: replace not-attached prog on cg1");
+		goto err;
+	}
+	assert(errno == ENOENT);
+	attach_attr.replace_prog_fd = allow_prog[0];
+
+	/* replace 1st from the top program */
+	if (bpf_prog_attach_xattr(&attach_attr)) {
+		log_err("Replace prog1 with prog7 on cg1");
+		goto err;
+	}
+	value = 0;
+	assert(bpf_map_update_elem(map_fd, &key, &value, 0) == 0);
+	assert(system(PING_CMD) == 0);
+	assert(bpf_map_lookup_elem(map_fd, &key, &value) == 0);
+	assert(value == 64 + 2 + 8 + 16);
+
 	/* detach 3rd from bottom program and ping again */
 	errno = 0;
 	if (!bpf_prog_detach2(0, cg3, BPF_CGROUP_INET_EGRESS)) {
@@ -414,7 +465,7 @@ static int test_multiprog(void)
 	assert(bpf_map_update_elem(map_fd, &key, &value, 0) == 0);
 	assert(system(PING_CMD) == 0);
 	assert(bpf_map_lookup_elem(map_fd, &key, &value) == 0);
-	assert(value == 1 + 2 + 16);
+	assert(value == 64 + 2 + 16);
 
 	/* detach 2nd from bottom program and ping again */
 	if (bpf_prog_detach2(-1, cg4, BPF_CGROUP_INET_EGRESS)) {
@@ -425,7 +476,7 @@ static int test_multiprog(void)
 	assert(bpf_map_update_elem(map_fd, &key, &value, 0) == 0);
 	assert(system(PING_CMD) == 0);
 	assert(bpf_map_lookup_elem(map_fd, &key, &value) == 0);
-	assert(value == 1 + 2 + 4);
+	assert(value == 64 + 2 + 4);
 
 	prog_cnt = 4;
 	assert(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS, BPF_F_QUERY_EFFECTIVE,
-- 
2.17.1

