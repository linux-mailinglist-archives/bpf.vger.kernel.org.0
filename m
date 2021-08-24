Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DD83F57D5
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 08:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbhHXGDF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Aug 2021 02:03:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38112 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234523AbhHXGDD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Aug 2021 02:03:03 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17O5tvFx003177
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 23:02:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ZC2rCE7EvfqbGHRQPZyzZFjfM926dNyAjUiwi8xM6iM=;
 b=Y1tPbbaeLQYCzbgaFMb8SACsxeKubQUZ/bweceCj+0L9vj1nEUaqmc9ORZAweIz1SWVG
 BtMgHxRFESGsilyz02lSvjBXNZecnJ+6w4dOJVymqsySJheqgeX7TJ1dCBybj93pmWTk
 LCSTY2aa+GAq5d9cojaOVy/4AOlbLROGGJQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3amfqt3uh6-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 23:02:19 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 23:02:17 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 7CE3BDDDF78A; Mon, 23 Aug 2021 23:02:16 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: add test for bpf_get_branch_trace
Date:   Mon, 23 Aug 2021 23:01:57 -0700
Message-ID: <20210824060157.3889139-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210824060157.3889139-1-songliubraving@fb.com>
References: <20210824060157.3889139-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Gw0Qafm_rkSejjk9SD_vlxldNez-OZV1
X-Proofpoint-ORIG-GUID: Gw0Qafm_rkSejjk9SD_vlxldNez-OZV1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_01:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test uses bpf_get_branch_trace from a fexit program. The test uses
a target kernel function (bpf_fexit_loop_test1) and compares the record
against kallsyms. If there isn't enough record matching kallsyms, the
test fails.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 net/bpf/test_run.c                            |  15 ++-
 .../bpf/prog_tests/get_branch_trace.c         | 106 ++++++++++++++++++
 .../selftests/bpf/progs/get_branch_trace.c    |  41 +++++++
 tools/testing/selftests/bpf/trace_helpers.c   |  30 +++++
 tools/testing/selftests/bpf/trace_helpers.h   |   5 +
 5 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_tra=
ce.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_branch_trace.c

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2eb0e55ef54d2..6cc179a532c9c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -231,6 +231,18 @@ struct sock * noinline bpf_kfunc_call_test3(struct s=
ock *sk)
 	return sk;
 }
=20
+noinline int bpf_fexit_loop_test1(int n)
+{
+	int i, sum =3D 0;
+
+	/* the primary goal of this test is to test LBR. Create a lot of
+	 * branches in the function, so we can catch it easily.
+	 */
+	for (i =3D 0; i < n; i++)
+		sum +=3D i;
+	return sum;
+}
+
 __diag_pop();
=20
 ALLOW_ERROR_INJECTION(bpf_modify_return_test, ERRNO);
@@ -293,7 +305,8 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 		    bpf_fentry_test5(11, (void *)12, 13, 14, 15) !=3D 65 ||
 		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) !=3D 111 =
||
 		    bpf_fentry_test7((struct bpf_fentry_test_t *)0) !=3D 0 ||
-		    bpf_fentry_test8(&arg) !=3D 0)
+		    bpf_fentry_test8(&arg) !=3D 0 ||
+		    bpf_fexit_loop_test1(101) !=3D 5050)
 			goto out;
 		break;
 	case BPF_MODIFY_RETURN:
diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_trace.c b/=
tools/testing/selftests/bpf/prog_tests/get_branch_trace.c
new file mode 100644
index 0000000000000..67693322e0974
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/get_branch_trace.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <test_progs.h>
+#include "get_branch_trace.skel.h"
+
+static int *pfd_array;
+static int cpu_cnt;
+
+static int create_perf_events(void)
+{
+	struct perf_event_attr attr =3D {0};
+	int cpu;
+
+	/* create perf event */
+	attr.size =3D sizeof(attr);
+	attr.type =3D PERF_TYPE_RAW;
+	attr.config =3D 0x1b00;
+	attr.sample_type =3D PERF_SAMPLE_BRANCH_STACK;
+	attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_KERNEL |
+		PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_ANY;
+
+	cpu_cnt =3D libbpf_num_possible_cpus();
+	pfd_array =3D malloc(sizeof(int) * cpu_cnt);
+	if (!pfd_array) {
+		cpu_cnt =3D 0;
+		return 1;
+	}
+
+	for (cpu =3D 0; cpu < libbpf_num_possible_cpus(); cpu++) {
+		pfd_array[cpu] =3D syscall(__NR_perf_event_open, &attr,
+					 -1, cpu, -1, PERF_FLAG_FD_CLOEXEC);
+		if (pfd_array[cpu] < 0)
+			break;
+	}
+
+	return cpu =3D=3D 0;
+}
+
+static void close_perf_events(void)
+{
+	int cpu =3D 0;
+	int fd;
+
+	while (cpu++ < cpu_cnt) {
+		fd =3D pfd_array[cpu];
+		if (fd < 0)
+			break;
+		close(fd);
+	}
+	free(pfd_array);
+}
+
+void test_get_branch_trace(void)
+{
+	struct get_branch_trace *skel;
+	int err, prog_fd;
+	__u32 retval;
+
+	if (create_perf_events()) {
+		test__skip();  /* system doesn't support LBR */
+		goto cleanup;
+	}
+
+	skel =3D get_branch_trace__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "get_branch_trace__open_and_load"))
+		goto cleanup;
+
+	err =3D kallsyms_find("bpf_fexit_loop_test1", &skel->bss->address_low);
+	if (!ASSERT_OK(err, "kallsyms_find"))
+		goto cleanup;
+
+	err =3D kallsyms_find_next("bpf_fexit_loop_test1", &skel->bss->address_=
high);
+	if (!ASSERT_OK(err, "kallsyms_find_next"))
+		goto cleanup;
+
+	err =3D get_branch_trace__attach(skel);
+	if (!ASSERT_OK(err, "get_branch_trace__attach"))
+		goto cleanup;
+
+	prog_fd =3D bpf_program__fd(skel->progs.test1);
+	err =3D bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, 0, &retval, NULL);
+
+	if (!ASSERT_OK(err, "bpf_prog_test_run"))
+		goto cleanup;
+
+	if (skel->bss->total_entries < 16) {
+		/* too few entries for the hit/waste test */
+		test__skip();
+		goto cleanup;
+	}
+
+	ASSERT_GT(skel->bss->test1_hits, 5, "find_test1_in_lbr");
+
+	/* Given we stop LBR in software, we will waste a few entries.
+	 * But we should try to waste as few as possibleentries. We are at
+	 * about 7 on x86_64 systems.
+	 * Add a check for < 10 so that we get heads-up when something
+	 * changes and wastes too many entries.
+	 */
+	ASSERT_LT(skel->bss->wasted_entries, 10, "check_wasted_entries");
+
+cleanup:
+	get_branch_trace__destroy(skel);
+	close_perf_events();
+}
diff --git a/tools/testing/selftests/bpf/progs/get_branch_trace.c b/tools=
/testing/selftests/bpf/progs/get_branch_trace.c
new file mode 100644
index 0000000000000..02ff41951b377
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_branch_trace.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+__u64 test1_hits =3D 0;
+__u64 address_low =3D 0;
+__u64 address_high =3D 0;
+int wasted_entries =3D 0;
+long total_entries =3D 0;
+
+#define MAX_LBR_ENTRIES 32
+
+struct perf_branch_entry entries[MAX_LBR_ENTRIES] =3D {};
+
+
+static inline bool in_range(__u64 val)
+{
+	return (val >=3D address_low) && (val < address_high);
+}
+
+SEC("fexit/bpf_fexit_loop_test1")
+int BPF_PROG(test1, int n, int ret)
+{
+	long i;
+
+	total_entries =3D bpf_get_branch_trace(entries, sizeof(entries));
+
+	for (i =3D 0; i < MAX_LBR_ENTRIES; i++) {
+		if (i >=3D total_entries)
+			break;
+		if (in_range(entries[i].from) && in_range(entries[i].to))
+			test1_hits++;
+		else if (!test1_hits)
+			wasted_entries++;
+	}
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
index e7a19b04d4eaf..2926a3b626821 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -117,6 +117,36 @@ int kallsyms_find(const char *sym, unsigned long lon=
g *addr)
 	return err;
 }
=20
+/* find the address of the next symbol, this can be used to determine th=
e
+ * end of a function
+ */
+int kallsyms_find_next(const char *sym, unsigned long long *addr)
+{
+	char type, name[500];
+	unsigned long long value;
+	bool found =3D false;
+	int err =3D 0;
+	FILE *f;
+
+	f =3D fopen("/proc/kallsyms", "r");
+	if (!f)
+		return -EINVAL;
+
+	while (fscanf(f, "%llx %c %499s%*[^\n]\n", &value, &type, name) > 0) {
+		if (found) {
+			*addr =3D value;
+			goto out;
+		}
+		if (strcmp(name, sym) =3D=3D 0)
+			found =3D true;
+	}
+	err =3D -ENOENT;
+
+out:
+	fclose(f);
+	return err;
+}
+
 void read_trace_pipe(void)
 {
 	int trace_fd;
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/=
selftests/bpf/trace_helpers.h
index d907b445524d5..bc8ed86105d94 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -16,6 +16,11 @@ long ksym_get_addr(const char *name);
 /* open kallsyms and find addresses on the fly, faster than load + searc=
h. */
 int kallsyms_find(const char *sym, unsigned long long *addr);
=20
+/* find the address of the next symbol, this can be used to determine th=
e
+ * end of a function
+ */
+int kallsyms_find_next(const char *sym, unsigned long long *addr);
+
 void read_trace_pipe(void);
=20
 ssize_t get_uprobe_offset(const void *addr, ssize_t base);
--=20
2.30.2

