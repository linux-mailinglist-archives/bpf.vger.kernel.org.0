Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9E27321C
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 20:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgIUSmr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 14:42:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727470AbgIUSmr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 21 Sep 2020 14:42:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LIW7a8121671;
        Mon, 21 Sep 2020 14:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=pU6EPWqplPdw2lxTDBjuW+y+uMwiOW3eQOHpaqDYWgw=;
 b=FOJu2FreY66i36ZiJwVYmqc4cPIh3rDWUJQwLgfCIC0muQDsVWgO2HHnPg4pYvKhLxmF
 tPaMyNQRSbpRXe+sn8c5JGimHUYL1CPykRUKxXnnJu2qtXl+B/XoAiy5xENPPTJmMYlu
 A/wbu38HgqOM2JGmSsWO5eWxaafNGR6zseFWjOw6+rphKVtzU3A3wdJieghYY6owdNMd
 Q2RUlSTuSRvntXI9UvipkiyqQTRTc17EP51LWMdO+PbH9Lo3OjRsYiquhxs0Szp0IPho
 0gk8o/BSEU+qNHmhYiyERR4rHC2P64HdAVhof0m82eSlrB1ZdsqZFAEPn+LFcaNx6Xhl 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33pyj9kyu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 14:42:32 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08LIX713128056;
        Mon, 21 Sep 2020 14:42:32 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33pyj9kytg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 14:42:32 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08LIaeYG012922;
        Mon, 21 Sep 2020 18:42:30 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 33n9m8aaxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 18:42:30 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08LIgR9Z18940190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 18:42:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D47CAE053;
        Mon, 21 Sep 2020 18:42:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19240AE04D;
        Mon, 21 Sep 2020 18:42:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.44.24])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Sep 2020 18:42:27 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Skip some verifier tests on BTFless kernels
Date:   Mon, 21 Sep 2020 20:42:19 +0200
Message-Id: <20200921184219.4168733-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_06:2020-09-21,2020-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=2
 mlxscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210128
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mark seven tests as requiring vmlinux btf. Check whether vmlinux btf is
available, and if not, skip them.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
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

