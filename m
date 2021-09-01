Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B506D3FD057
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 02:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbhIAAga (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 20:36:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230062AbhIAAg3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 20:36:29 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1810S4t7028187
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 17:35:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ji+vwwd4eLTbcJw2c2j868X0v2GjIrzS21oBKXZzeeQ=;
 b=bb85rmRpAeoxyE3Rdeywwz4bzb8c/1q2U5gZYMLxTx8U4t50tdIOCAjhTbYXtpRhcRds
 wJA8GRdMHBHe+lpID6Ez+pFp5vl4403jrC+IofdJ8yN4frlJ1M7oab/Tk/FZ7U4CmdyP
 zztfcUNXYmi96fIGB2ZLs4Hhi1Ik5G1X/nA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aryqsbt2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 17:35:33 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 31 Aug 2021 17:35:32 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 305F2F58692A; Tue, 31 Aug 2021 17:35:29 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v4 bpf-next 3/3] selftests/bpf: add test for bpf_get_branch_snapshot
Date:   Tue, 31 Aug 2021 17:35:17 -0700
Message-ID: <20210901003517.3953145-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901003517.3953145-1-songliubraving@fb.com>
References: <20210901003517.3953145-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 7w6s5v2cUE08krQbUIqKPD2aGshahgud
X-Proofpoint-ORIG-GUID: 7w6s5v2cUE08krQbUIqKPD2aGshahgud
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_10:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test uses bpf_get_branch_snapshot from a fexit program. The test use=
s
a target function (bpf_testmod_loop_test) and compares the record against
kallsyms. If there isn't enough record matching kallsyms, the test fails.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  14 ++-
 .../bpf/prog_tests/get_branch_snapshot.c      | 101 ++++++++++++++++++
 .../selftests/bpf/progs/get_branch_snapshot.c |  44 ++++++++
 tools/testing/selftests/bpf/trace_helpers.c   |  37 +++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   5 +
 5 files changed, 200 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_sna=
pshot.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot=
.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 141d8da687d21..19635e57ff21a 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -13,6 +13,18 @@
=20
 DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) =3D 123;
=20
+noinline int bpf_testmod_loop_test(int n)
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
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 		      struct bin_attribute *bin_attr,
@@ -24,6 +36,7 @@ bpf_testmod_test_read(struct file *file, struct kobject=
 *kobj,
 		.len =3D len,
 	};
=20
+	bpf_testmod_loop_test(101);
 	trace_bpf_testmod_test_read(current, &ctx);
=20
 	return -EIO; /* always fail */
@@ -71,4 +84,3 @@ module_exit(bpf_testmod_exit);
 MODULE_AUTHOR("Andrii Nakryiko");
 MODULE_DESCRIPTION("BPF selftests module");
 MODULE_LICENSE("Dual BSD/GPL");
-
diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c=
 b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
new file mode 100644
index 0000000000000..03ffa5cdf9b09
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <test_progs.h>
+#include "get_branch_snapshot.skel.h"
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
+	for (cpu =3D 0; cpu < cpu_cnt; cpu++) {
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
+void test_get_branch_snapshot(void)
+{
+	struct get_branch_snapshot *skel =3D NULL;
+	int err;
+
+	if (create_perf_events()) {
+		test__skip();  /* system doesn't support LBR */
+		goto cleanup;
+	}
+
+	skel =3D get_branch_snapshot__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "get_branch_snapshot__open_and_load"))
+		goto cleanup;
+
+	err =3D kallsyms_find("bpf_testmod_loop_test", &skel->bss->address_low)=
;
+	if (!ASSERT_OK(err, "kallsyms_find"))
+		goto cleanup;
+
+	err =3D kallsyms_find_next("bpf_testmod_loop_test", &skel->bss->address=
_high);
+	if (!ASSERT_OK(err, "kallsyms_find_next"))
+		goto cleanup;
+
+	err =3D get_branch_snapshot__attach(skel);
+	if (!ASSERT_OK(err, "get_branch_snapshot__attach"))
+		goto cleanup;
+
+	/* trigger the program */
+	system("cat /sys/kernel/bpf_testmod > /dev/null 2>& 1");
+
+	if (skel->bss->total_entries < 16) {
+		/* too few entries for the hit/waste test */
+		test__skip();
+		goto cleanup;
+	}
+
+	ASSERT_GT(skel->bss->test1_hits, 1, "find_looptest_in_lbr");
+
+	/* Given we stop LBR in software, we will waste a few entries.
+	 * But we should try to waste as few as possible entries. We are at
+	 * about 11 on x86_64 systems.
+	 * Add a check for < 15 so that we get heads-up when something
+	 * changes and wastes too many entries.
+	 */
+	ASSERT_LT(skel->bss->wasted_entries, 15, "check_wasted_entries");
+
+cleanup:
+	get_branch_snapshot__destroy(skel);
+	close_perf_events();
+}
diff --git a/tools/testing/selftests/bpf/progs/get_branch_snapshot.c b/to=
ols/testing/selftests/bpf/progs/get_branch_snapshot.c
new file mode 100644
index 0000000000000..24a6e7a9c08ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
@@ -0,0 +1,44 @@
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
+struct perf_branch_entry entries[PERF_MAX_BRANCH_SNAPSHOT] =3D {};
+
+
+static inline bool in_range(__u64 val)
+{
+	return (val >=3D address_low) && (val < address_high);
+}
+
+SEC("fexit/bpf_testmod_loop_test")
+int BPF_PROG(test1, int n, int ret)
+{
+	long i;
+
+	total_entries =3D bpf_get_branch_snapshot(entries, sizeof(entries), 0);
+	total_entries /=3D sizeof(struct perf_branch_entry);
+
+	bpf_printk("total_entries %lu\n", total_entries);
+
+	for (i =3D 0; i < PERF_MAX_BRANCH_SNAPSHOT; i++) {
+		if (i >=3D total_entries)
+			break;
+		if (in_range(entries[i].from) && in_range(entries[i].to))
+			test1_hits++;
+		else if (!test1_hits)
+			wasted_entries++;
+		bpf_printk("i %d from %llx to %llx", i, entries[i].from,
+			   entries[i].to);
+	}
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
index e7a19b04d4eaf..5100a169b72b1 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <ctype.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -117,6 +118,42 @@ int kallsyms_find(const char *sym, unsigned long lon=
g *addr)
 	return err;
 }
=20
+/* find the address of the next symbol of the same type, this can be use=
d
+ * to determine the end of a function.
+ */
+int kallsyms_find_next(const char *sym, unsigned long long *addr)
+{
+	char type, found_type, name[500];
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
+		/* Different types of symbols in kernel modules are mixed
+		 * in /proc/kallsyms. Only return the next matching type.
+		 * Use tolower() for type so that 'T' matches 't'.
+		 */
+		if (found && found_type =3D=3D tolower(type)) {
+			*addr =3D value;
+			goto out;
+		}
+		if (strcmp(name, sym) =3D=3D 0) {
+			found =3D true;
+			found_type =3D tolower(type);
+		}
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

