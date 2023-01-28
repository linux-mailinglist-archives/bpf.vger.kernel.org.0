Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4261D67F2A7
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjA1AH0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjA1AHZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:25 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6353286EA4
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:21 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNBv0L024305;
        Sat, 28 Jan 2023 00:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FhrdczOAfth9xjel/j35ymoFjhKcmWrEff+1tFwF/X4=;
 b=dnjY8Oz1SaT+d7vJN+BMne8n15q9Gt6w0IS4317D5UcVM3CHgTUfC7+ksIgOnSlcDRPX
 1JtQB8SozegZCjT6yuuPhe/j1cE76L/0o81q00bevf9irWNZOmGb42ZTeOgXbglGqMZI
 qruue+KghhBZqj1/6s4bxnqRFcBqKYHhONwrbTL3AlgFLPAy0kcsceaRwKALdgNDxggF
 4Mgkn2m9soAd318hXU36nF+m/hllGINlP2AxdIzvflzXG6qVmVR7cJ/Yd4hXEcMrNg04
 T/HgFTD/8BkABVDY0dQ7fypabpPdvdp2cu3y54k9aCUFMXGWt16hrCvhWTlgZMEqk28I Ww== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncr2nrxe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:06 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RKO0jJ026714;
        Sat, 28 Jan 2023 00:07:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6g5jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S070q745089170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD55220040;
        Sat, 28 Jan 2023 00:07:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AE0720043;
        Sat, 28 Jan 2023 00:07:00 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:00 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 03/31] selftests/bpf: Query BPF_MAX_TRAMP_LINKS using BTF
Date:   Sat, 28 Jan 2023 01:06:22 +0100
Message-Id: <20230128000650.1516334-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a2tjo46Z1eh8KyPfPGJrCi0r8-YsxBzi
X-Proofpoint-ORIG-GUID: a2tjo46Z1eh8KyPfPGJrCi0r8-YsxBzi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_15,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270220
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not hard-code the value, since for s390x it will be smaller than
for x86.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/fexit_stress.c   | 22 +++++++----
 .../bpf/prog_tests/trampoline_count.c         | 18 +++++++--
 tools/testing/selftests/bpf/test_progs.c      | 38 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  2 +
 4 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
index 5a7e6011f6bf..596536def43d 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
@@ -2,14 +2,19 @@
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
 
-/* that's kernel internal BPF_MAX_TRAMP_PROGS define */
-#define CNT 38
-
 void serial_test_fexit_stress(void)
 {
-	int fexit_fd[CNT] = {};
-	int link_fd[CNT] = {};
-	int err, i;
+	int bpf_max_tramp_links, err, i;
+	int *fd, *fexit_fd, *link_fd;
+
+	bpf_max_tramp_links = get_bpf_max_tramp_links();
+	if (!ASSERT_GE(bpf_max_tramp_links, 1, "bpf_max_tramp_links"))
+		return;
+	fd = calloc(bpf_max_tramp_links * 2, sizeof(*fd));
+	if (!ASSERT_OK_PTR(fd, "fd"))
+		return;
+	fexit_fd = fd;
+	link_fd = fd + bpf_max_tramp_links;
 
 	const struct bpf_insn trace_program[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -28,7 +33,7 @@ void serial_test_fexit_stress(void)
 		goto out;
 	trace_opts.attach_btf_id = err;
 
-	for (i = 0; i < CNT; i++) {
+	for (i = 0; i < bpf_max_tramp_links; i++) {
 		fexit_fd[i] = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
 					    trace_program,
 					    sizeof(trace_program) / sizeof(struct bpf_insn),
@@ -44,10 +49,11 @@ void serial_test_fexit_stress(void)
 	ASSERT_OK(err, "bpf_prog_test_run_opts");
 
 out:
-	for (i = 0; i < CNT; i++) {
+	for (i = 0; i < bpf_max_tramp_links; i++) {
 		if (link_fd[i])
 			close(link_fd[i]);
 		if (fexit_fd[i])
 			close(fexit_fd[i]);
 	}
+	free(fd);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
index 564b75bc087f..416addbb9d8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
@@ -2,7 +2,11 @@
 #define _GNU_SOURCE
 #include <test_progs.h>
 
+#if defined(__s390x__)
+#define MAX_TRAMP_PROGS 27
+#else
 #define MAX_TRAMP_PROGS 38
+#endif
 
 struct inst {
 	struct bpf_object *obj;
@@ -37,14 +41,21 @@ void serial_test_trampoline_count(void)
 {
 	char *file = "test_trampoline_count.bpf.o";
 	char *const progs[] = { "fentry_test", "fmod_ret_test", "fexit_test" };
-	struct inst inst[MAX_TRAMP_PROGS + 1] = {};
+	int bpf_max_tramp_links, err, i, prog_fd;
 	struct bpf_program *prog;
 	struct bpf_link *link;
-	int prog_fd, err, i;
+	struct inst *inst;
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 
+	bpf_max_tramp_links = get_bpf_max_tramp_links();
+	if (!ASSERT_GE(bpf_max_tramp_links, 1, "bpf_max_tramp_links"))
+		return;
+	inst = calloc(bpf_max_tramp_links + 1, sizeof(*inst));
+	if (!ASSERT_OK_PTR(inst, "inst"))
+		return;
+
 	/* attach 'allowed' trampoline programs */
-	for (i = 0; i < MAX_TRAMP_PROGS; i++) {
+	for (i = 0; i < bpf_max_tramp_links; i++) {
 		prog = load_prog(file, progs[i % ARRAY_SIZE(progs)], &inst[i]);
 		if (!prog)
 			goto cleanup;
@@ -91,4 +102,5 @@ void serial_test_trampoline_count(void)
 		bpf_link__destroy(inst[i].link);
 		bpf_object__close(inst[i].obj);
 	}
+	free(inst);
 }
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 4716e38e153a..a9b7a649bb4f 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -17,6 +17,7 @@
 #include <sys/select.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <bpf/btf.h>
 
 static bool verbose(void)
 {
@@ -967,6 +968,43 @@ int write_sysctl(const char *sysctl, const char *value)
 	return 0;
 }
 
+int get_bpf_max_tramp_links_from(struct btf *btf)
+{
+	const struct btf_enum *e;
+	const struct btf_type *t;
+	__u32 i, type_cnt;
+	const char *name;
+	__u16 j, vlen;
+
+	for (i = 1, type_cnt = btf__type_cnt(btf); i < type_cnt; i++) {
+		t = btf__type_by_id(btf, i);
+		if (!t || !btf_is_enum(t) || t->name_off)
+			continue;
+		e = btf_enum(t);
+		for (j = 0, vlen = btf_vlen(t); j < vlen; j++, e++) {
+			name = btf__str_by_offset(btf, e->name_off);
+			if (name && !strcmp(name, "BPF_MAX_TRAMP_LINKS"))
+				return e->val;
+		}
+	}
+
+	return -1;
+}
+
+int get_bpf_max_tramp_links(void)
+{
+	struct btf *vmlinux_btf;
+	int ret;
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "vmlinux btf"))
+		return -1;
+	ret = get_bpf_max_tramp_links_from(vmlinux_btf);
+	btf__free(vmlinux_btf);
+
+	return ret;
+}
+
 #define MAX_BACKTRACE_SZ 128
 void crash_handler(int signum)
 {
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 3f058dfadbaf..d5d51ec97ec8 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -394,6 +394,8 @@ int kern_sync_rcu(void);
 int trigger_module_test_read(int read_sz);
 int trigger_module_test_write(int write_sz);
 int write_sysctl(const char *sysctl, const char *value);
+int get_bpf_max_tramp_links_from(struct btf *btf);
+int get_bpf_max_tramp_links(void);
 
 #ifdef __x86_64__
 #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
-- 
2.39.1

