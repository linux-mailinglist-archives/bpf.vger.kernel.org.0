Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC362762E5
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 23:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWVKZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 17:10:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28470 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgIWVKZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Sep 2020 17:10:25 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NL3gBe028109;
        Wed, 23 Sep 2020 17:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=O0riEQBcHAByTBDZht2IlH8uw5fWt8oxSUZFG0BZNxM=;
 b=J4a5035aarKqSxSFtLCZzm1qVIkm/VI5mpUxJMYyRu2We9bUyBrP7VShchjet7PH6v1E
 2QcRr3Kfe2Uof/I6RdWo+6sQJYG2I83JshT4riyVnomfzOY1CjM24U6h+uukQ53TKNtc
 gEi/WLi+s6+qhw5IzOYWVnE0sRsSN9pzcWK53OvFY8A00FgXipYkHyvxVEo8XDu0zGmX
 PfOeUtvvgI7FSlhOGMcLdFynhc0T8EvVEv821V1AWBFvN6emXae8vyJvUdbuW/kMJUZD
 mF946ab/U0dBg/dJh/2ObjGgL0HRFevZL61wCgPlPO8FLIbk18I5yFq9bBPRjRXggnNy fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33rd7ch5j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 17:10:10 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08NL3shr028951;
        Wed, 23 Sep 2020 17:10:10 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33rd7ch5hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 17:10:09 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08NL2K5d008453;
        Wed, 23 Sep 2020 21:10:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 33n98gvjtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 21:10:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08NLA5q726935700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 21:10:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4661052059;
        Wed, 23 Sep 2020 21:10:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.183.66])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DBBC35204F;
        Wed, 23 Sep 2020 21:10:04 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RESEND bpf-next] selftests/bpf: Skip some verifier tests on BTFless kernels
Date:   Wed, 23 Sep 2020 23:09:59 +0200
Message-Id: <20200923210959.95921-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_16:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230155
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mark seven tests as requiring vmlinux btf. Check whether vmlinux btf is
available, and if not, skip them.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

Resending due to patchwork having missed the original submission:

https://lore.kernel.org/bpf/20200921184219.4168733-1-iii@linux.ibm.com/

tools/testing/selftests/bpf/test_verifier.c   | 24 +++++++++++++++++++
 tools/testing/selftests/bpf/verifier/d_path.c |  2 ++
 .../testing/selftests/bpf/verifier/map_ptr.c  |  4 ++++
 .../selftests/bpf/verifier/map_ptr_mixing.c   |  1 +
 4 files changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 9be395d9dc64..dc696aa2b9e9 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -30,8 +30,10 @@
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/btf.h>
+#include <linux/err.h>
 
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
 #include <bpf/libbpf.h>
 
 #ifdef HAVE_GENHDR
@@ -115,6 +117,7 @@ struct bpf_test {
 	};
 	enum bpf_attach_type expected_attach_type;
 	const char *kfunc;
+	bool need_vmlinux_btf;
 };
 
 /* Note we want this to be 64 bit aligned so that the end of our array is
@@ -926,6 +929,19 @@ static bool cmp_str_seq(const char *log, const char *exp)
 	return true;
 }
 
+static bool vmlinux_btf_available;
+
+static void probe_vmlinux_btf(void)
+{
+	struct btf *btf_vmlinux;
+
+	btf_vmlinux = libbpf_find_kernel_btf();
+	if (IS_ERR(btf_vmlinux))
+		return;
+	btf__free(btf_vmlinux);
+	vmlinux_btf_available = true;
+}
+
 static void do_test_single(struct bpf_test *test, bool unpriv,
 			   int *passes, int *errors)
 {
@@ -940,6 +956,12 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	__u32 pflags;
 	int i, err;
 
+	if (test->need_vmlinux_btf && !vmlinux_btf_available) {
+		printf("SKIP (no vmlinux BTF)\n");
+		skips++;
+		goto done;
+	}
+
 	for (i = 0; i < MAX_NR_MAPS; i++)
 		map_fds[i] = -1;
 
@@ -1097,6 +1119,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	close(fd_prog);
 	for (i = 0; i < MAX_NR_MAPS; i++)
 		close(map_fds[i]);
+done:
 	sched_yield();
 	return;
 fail_log:
@@ -1230,5 +1253,6 @@ int main(int argc, char **argv)
 	}
 
 	bpf_semi_rand_init();
+	probe_vmlinux_btf();
 	return do_test(unpriv, from, to);
 }
diff --git a/tools/testing/selftests/bpf/verifier/d_path.c b/tools/testing/selftests/bpf/verifier/d_path.c
index b988396379a7..08613013f828 100644
--- a/tools/testing/selftests/bpf/verifier/d_path.c
+++ b/tools/testing/selftests/bpf/verifier/d_path.c
@@ -15,6 +15,7 @@
 	.prog_type = BPF_PROG_TYPE_TRACING,
 	.expected_attach_type = BPF_TRACE_FENTRY,
 	.kfunc = "dentry_open",
+	.need_vmlinux_btf = true,
 },
 {
 	"d_path reject",
@@ -34,4 +35,5 @@
 	.prog_type = BPF_PROG_TYPE_TRACING,
 	.expected_attach_type = BPF_TRACE_FENTRY,
 	.kfunc = "d_path",
+	.need_vmlinux_btf = true,
 },
diff --git a/tools/testing/selftests/bpf/verifier/map_ptr.c b/tools/testing/selftests/bpf/verifier/map_ptr.c
index 637f9293bda8..c6e075dadac6 100644
--- a/tools/testing/selftests/bpf/verifier/map_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_ptr.c
@@ -12,6 +12,7 @@
 	.errstr_unpriv = "bpf_array access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
 	.result = REJECT,
 	.errstr = "R1 is bpf_array invalid negative access: off=-8",
+	.need_vmlinux_btf = true,
 },
 {
 	"bpf_map_ptr: write rejected",
@@ -29,6 +30,7 @@
 	.errstr_unpriv = "bpf_array access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
 	.result = REJECT,
 	.errstr = "only read from bpf_array is supported",
+	.need_vmlinux_btf = true,
 },
 {
 	"bpf_map_ptr: read non-existent field rejected",
@@ -44,6 +46,7 @@
 	.errstr_unpriv = "bpf_array access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
 	.result = REJECT,
 	.errstr = "cannot access ptr member ops with moff 0 in struct bpf_map with off 1 size 4",
+	.need_vmlinux_btf = true,
 },
 {
 	"bpf_map_ptr: read ops field accepted",
@@ -59,6 +62,7 @@
 	.errstr_unpriv = "bpf_array access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
 	.result = ACCEPT,
 	.retval = 1,
+	.need_vmlinux_btf = true,
 },
 {
 	"bpf_map_ptr: r = 0, map_ptr = map_ptr + r",
diff --git a/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c b/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
index 1f2b8c4cb26d..75afb8fc3aad 100644
--- a/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
+++ b/tools/testing/selftests/bpf/verifier/map_ptr_mixing.c
@@ -57,6 +57,7 @@
 	.fixup_map_array_48b = { 13 },
 	.result = REJECT,
 	.errstr = "only read from bpf_array is supported",
+	.need_vmlinux_btf = true,
 },
 {
 	"cond: two branches returning different map pointers for lookup (tail, tail)",
-- 
2.25.4

