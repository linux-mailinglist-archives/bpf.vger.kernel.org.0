Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE7402FB9
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 22:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346584AbhIGU3z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 16:29:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346500AbhIGU3r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 16:29:47 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187KQfsG027571
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 13:28:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=evZMmfU690epbmaRHFUfjC1IXQGgSDnM9C8Ch86lkRc=;
 b=AIDzIy37tjmJY01XL2555fraDs5TuEhOkKOjH9XzsD7m/6AD7OD5VpzXwfl+l7oy61p0
 NcUrwm7PZXAebxOP/b70cFB6IjjiYf6IHguBU7veNrREeQJFHm8QtqsDez1WW2EiItxC
 Ug8ePGST4uqQKFa4rVZ+UYPVoLE31Dhr3C4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcqf90em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 13:28:41 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 13:28:36 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 31C671027A65E; Tue,  7 Sep 2021 13:28:36 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kjain@linux.ibm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH v6 bpf-next 3/3] selftests/bpf: add test for bpf_get_branch_snapshot
Date:   Tue, 7 Sep 2021 13:28:02 -0700
Message-ID: <20210907202802.3675104-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907202802.3675104-1-songliubraving@fb.com>
References: <20210907202802.3675104-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: gnJccxZXNaCLga8b8bEwcJ5z8kpNxXxs
X-Proofpoint-ORIG-GUID: gnJccxZXNaCLga8b8bEwcJ5z8kpNxXxs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_07:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109070130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test uses bpf_get_branch_snapshot from a fexit program. The test use=
s
a target function (bpf_testmod_loop_test) and compares the record against
kallsyms. If there isn't enough record matching kallsyms, the test fails.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  19 +++-
 .../selftests/bpf/prog_tests/core_reloc.c     |  14 +--
 .../bpf/prog_tests/get_branch_snapshot.c      | 100 ++++++++++++++++++
 .../selftests/bpf/prog_tests/module_attach.c  |  39 -------
 .../selftests/bpf/progs/get_branch_snapshot.c |  40 +++++++
 tools/testing/selftests/bpf/test_progs.c      |  39 +++++++
 tools/testing/selftests/bpf/test_progs.h      |   2 +
 tools/testing/selftests/bpf/trace_helpers.c   |  37 +++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   5 +
 9 files changed, 243 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_sna=
pshot.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot=
.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 141d8da687d21..50fc5561110a4 100644
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
@@ -24,7 +36,11 @@ bpf_testmod_test_read(struct file *file, struct kobjec=
t *kobj,
 		.len =3D len,
 	};
=20
-	trace_bpf_testmod_test_read(current, &ctx);
+	/* This is always true. Use the check to make sure the compiler
+	 * doesn't remove bpf_testmod_loop_test.
+	 */
+	if (bpf_testmod_loop_test(101) > 100)
+		trace_bpf_testmod_test_read(current, &ctx);
=20
 	return -EIO; /* always fail */
 }
@@ -71,4 +87,3 @@ module_exit(bpf_testmod_exit);
 MODULE_AUTHOR("Andrii Nakryiko");
 MODULE_DESCRIPTION("BPF selftests module");
 MODULE_LICENSE("Dual BSD/GPL");
-
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/=
testing/selftests/bpf/prog_tests/core_reloc.c
index 4739b15b2a979..15d355af8d1d2 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -30,7 +30,7 @@ static int duration =3D 0;
 	.output_len =3D sizeof(struct core_reloc_module_output),		\
 	.prog_sec_name =3D sec_name,					\
 	.raw_tp_name =3D tp_name,						\
-	.trigger =3D trigger_module_test_read,				\
+	.trigger =3D __trigger_module_test_read,				\
 	.needs_testmod =3D true,						\
 }
=20
@@ -475,19 +475,11 @@ static int setup_type_id_case_failure(struct core_r=
eloc_test_case *test)
 	return 0;
 }
=20
-static int trigger_module_test_read(const struct core_reloc_test_case *t=
est)
+static int __trigger_module_test_read(const struct core_reloc_test_case =
*test)
 {
 	struct core_reloc_module_output *exp =3D (void *)test->output;
-	int fd, err;
-
-	fd =3D open("/sys/kernel/bpf_testmod", O_RDONLY);
-	err =3D -errno;
-	if (CHECK(fd < 0, "testmod_file_open", "failed: %d\n", err))
-		return err;
-
-	read(fd, NULL, exp->len); /* request expected number of bytes */
-	close(fd);
=20
+	trigger_module_test_read(exp->len);
 	return 0;
 }
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c=
 b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
new file mode 100644
index 0000000000000..26af9b3d572e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
@@ -0,0 +1,100 @@
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
+	trigger_module_test_read(100);
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
diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/too=
ls/testing/selftests/bpf/prog_tests/module_attach.c
index d85a69b7ce449..1797a6e4d6d84 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -6,45 +6,6 @@
=20
 static int duration;
=20
-static int trigger_module_test_read(int read_sz)
-{
-	int fd, err;
-
-	fd =3D open("/sys/kernel/bpf_testmod", O_RDONLY);
-	err =3D -errno;
-	if (CHECK(fd < 0, "testmod_file_open", "failed: %d\n", err))
-		return err;
-
-	read(fd, NULL, read_sz);
-	close(fd);
-
-	return 0;
-}
-
-static int trigger_module_test_write(int write_sz)
-{
-	int fd, err;
-	char *buf =3D malloc(write_sz);
-
-	if (!buf)
-		return -ENOMEM;
-
-	memset(buf, 'a', write_sz);
-	buf[write_sz-1] =3D '\0';
-
-	fd =3D open("/sys/kernel/bpf_testmod", O_WRONLY);
-	err =3D -errno;
-	if (CHECK(fd < 0, "testmod_file_open", "failed: %d\n", err)) {
-		free(buf);
-		return err;
-	}
-
-	write(fd, buf, write_sz);
-	close(fd);
-	free(buf);
-	return 0;
-}
-
 static int delete_module(const char *name, int flags)
 {
 	return syscall(__NR_delete_module, name, flags);
diff --git a/tools/testing/selftests/bpf/progs/get_branch_snapshot.c b/to=
ols/testing/selftests/bpf/progs/get_branch_snapshot.c
new file mode 100644
index 0000000000000..a1b139888048c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
@@ -0,0 +1,40 @@
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
+#define ENTRY_CNT 32
+struct perf_branch_entry entries[ENTRY_CNT] =3D {};
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
+	for (i =3D 0; i < ENTRY_CNT; i++) {
+		if (i >=3D total_entries)
+			break;
+		if (in_range(entries[i].from) && in_range(entries[i].to))
+			test1_hits++;
+		else if (!test1_hits)
+			wasted_entries++;
+	}
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index cc1cd240445d2..2ed01f615d20f 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -743,6 +743,45 @@ int cd_flavor_subdir(const char *exec_name)
 	return chdir(flavor);
 }
=20
+int trigger_module_test_read(int read_sz)
+{
+	int fd, err;
+
+	fd =3D open("/sys/kernel/bpf_testmod", O_RDONLY);
+	err =3D -errno;
+	if (!ASSERT_GE(fd, 0, "testmod_file_open"))
+		return err;
+
+	read(fd, NULL, read_sz);
+	close(fd);
+
+	return 0;
+}
+
+int trigger_module_test_write(int write_sz)
+{
+	int fd, err;
+	char *buf =3D malloc(write_sz);
+
+	if (!buf)
+		return -ENOMEM;
+
+	memset(buf, 'a', write_sz);
+	buf[write_sz-1] =3D '\0';
+
+	fd =3D open("/sys/kernel/bpf_testmod", O_WRONLY);
+	err =3D -errno;
+	if (!ASSERT_GE(fd, 0, "testmod_file_open")) {
+		free(buf);
+		return err;
+	}
+
+	write(fd, buf, write_sz);
+	close(fd);
+	free(buf);
+	return 0;
+}
+
 #define MAX_BACKTRACE_SZ 128
 void crash_handler(int signum)
 {
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index c8c2bf878f67c..94bef0aa74cf5 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -291,6 +291,8 @@ int compare_map_keys(int map1_fd, int map2_fd);
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
 int extract_build_id(char *build_id, size_t size);
 int kern_sync_rcu(void);
+int trigger_module_test_read(int read_sz);
+int trigger_module_test_write(int write_sz);
=20
 #ifdef __x86_64__
 #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
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

