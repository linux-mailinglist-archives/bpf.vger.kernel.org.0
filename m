Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195795A8C7
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2019 05:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfF2Dt3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jun 2019 23:49:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9092 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726772AbfF2Dt2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Jun 2019 23:49:28 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5T3nR5C006440
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2019 20:49:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=etv2EydXSCPalYGTBOBtkWwpKD5eSt/5Ti8pCm361LY=;
 b=jZ2yUkzuyuyLfh1pAP9F5uB1lvw6JvmDihhFidWOu1mO3hYD1hy6Hb8Wj2fcvvolfl5j
 XuRGi2wqeZ01DoQ/i+yJbaUYJt1XcJeljRhbfxqWfqhrwWYMnkcNWhSJ80qR3HP7SkP+
 pDirhZxgsqRQ2CLLfmbbkpSrQ/xbAdd20UQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2tdqm4shym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2019 20:49:27 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Jun 2019 20:49:25 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 17D76861418; Fri, 28 Jun 2019 20:49:24 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <sdf@fomichev.me>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 8/9] selftests/bpf: add kprobe/uprobe selftests
Date:   Fri, 28 Jun 2019 20:49:05 -0700
Message-ID: <20190629034906.1209916-9-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629034906.1209916-1-andriin@fb.com>
References: <20190629034906.1209916-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-29_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906290044
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests verifying kprobe/kretprobe/uprobe/uretprobe APIs work as
expected.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 155 ++++++++++++++++++
 .../selftests/bpf/progs/test_attach_probe.c   |  55 +++++++
 2 files changed, 210 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_probe.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_attach_probe.c

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
new file mode 100644
index 000000000000..f22929063c58
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+ssize_t get_base_addr() {
+	size_t start;
+	char buf[256];
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return -errno;
+
+	while (fscanf(f, "%zx-%*x %s %*s\n", &start, buf) == 2) {
+		if (strcmp(buf, "r-xp") == 0) {
+			fclose(f);
+			return start;
+		}
+	}
+
+	fclose(f);
+	return -EINVAL;
+}
+
+void test_attach_probe(void)
+{
+	const char *kprobe_name = "kprobe/sys_nanosleep";
+	const char *kretprobe_name = "kretprobe/sys_nanosleep";
+	const char *uprobe_name = "uprobe/trigger_func";
+	const char *uretprobe_name = "uretprobe/trigger_func";
+	const int kprobe_idx = 0, kretprobe_idx = 1;
+	const int uprobe_idx = 2, uretprobe_idx = 3;
+	const char *file = "./test_attach_probe.o";
+	struct bpf_program *kprobe_prog, *kretprobe_prog;
+	struct bpf_program *uprobe_prog, *uretprobe_prog;
+	struct bpf_object *obj;
+	int err, prog_fd, duration = 0, res;
+	struct bpf_link *kprobe_link = NULL;
+	struct bpf_link *kretprobe_link = NULL;
+	struct bpf_link *uprobe_link = NULL;
+	struct bpf_link *uretprobe_link = NULL;
+	int results_map_fd;
+	size_t uprobe_offset;
+	ssize_t base_addr;
+
+	base_addr = get_base_addr();
+	if (CHECK(base_addr < 0, "get_base_addr",
+		  "failed to find base addr: %zd", base_addr))
+		return;
+	uprobe_offset = (size_t)&get_base_addr - base_addr;
+
+	/* load programs */
+	err = bpf_prog_load(file, BPF_PROG_TYPE_KPROBE, &obj, &prog_fd);
+	if (CHECK(err, "obj_load", "err %d errno %d\n", err, errno))
+		return;
+
+	kprobe_prog = bpf_object__find_program_by_title(obj, kprobe_name);
+	if (CHECK(!kprobe_prog, "find_probe",
+		  "prog '%s' not found\n", kprobe_name))
+		goto cleanup;
+	kretprobe_prog = bpf_object__find_program_by_title(obj, kretprobe_name);
+	if (CHECK(!kretprobe_prog, "find_probe",
+		  "prog '%s' not found\n", kretprobe_name))
+		goto cleanup;
+	uprobe_prog = bpf_object__find_program_by_title(obj, uprobe_name);
+	if (CHECK(!uprobe_prog, "find_probe",
+		  "prog '%s' not found\n", uprobe_name))
+		goto cleanup;
+	uretprobe_prog = bpf_object__find_program_by_title(obj, uretprobe_name);
+	if (CHECK(!uretprobe_prog, "find_probe",
+		  "prog '%s' not found\n", uretprobe_name))
+		goto cleanup;
+
+	/* load maps */
+	results_map_fd = bpf_find_map(__func__, obj, "results_map");
+	if (CHECK(results_map_fd < 0, "find_results_map",
+		  "err %d\n", results_map_fd))
+		goto cleanup;
+
+	kprobe_link = bpf_program__attach_kprobe(kprobe_prog,
+						 false /* retprobe */,
+						 "sys_nanosleep");
+	if (CHECK(IS_ERR(kprobe_link), "attach_kprobe",
+		  "err %ld\n", PTR_ERR(kprobe_link)))
+		goto cleanup;
+
+	kretprobe_link = bpf_program__attach_kprobe(kretprobe_prog,
+						    true /* retprobe */,
+						    "sys_nanosleep");
+	if (CHECK(IS_ERR(kretprobe_link), "attach_kretprobe",
+		  "err %ld\n", PTR_ERR(kretprobe_link)))
+		goto cleanup;
+
+	uprobe_link = bpf_program__attach_uprobe(uprobe_prog,
+						 false /* retprobe */,
+						 0 /* self pid */,
+						 "/proc/self/exe",
+						 uprobe_offset);
+	if (CHECK(IS_ERR(uprobe_link), "attach_uprobe",
+		  "err %ld\n", PTR_ERR(uprobe_link)))
+		goto cleanup;
+
+	uretprobe_link = bpf_program__attach_uprobe(uretprobe_prog,
+						    true /* retprobe */,
+						    -1 /* any pid */,
+						    "/proc/self/exe",
+						    uprobe_offset);
+	if (CHECK(IS_ERR(uretprobe_link), "attach_uretprobe",
+		  "err %ld\n", PTR_ERR(uretprobe_link)))
+		goto cleanup;
+
+	/* trigger & validate kprobe && kretprobe */
+	usleep(1);
+
+	err = bpf_map_lookup_elem(results_map_fd, &kprobe_idx, &res);
+	if (CHECK(err, "get_kprobe_res",
+		  "failed to get kprobe res: %d\n", err))
+		goto cleanup;
+	if (CHECK(res != kprobe_idx + 1, "check_kprobe_res",
+		  "wrong kprobe res: %d\n", res))
+		goto cleanup;
+
+	err = bpf_map_lookup_elem(results_map_fd, &kretprobe_idx, &res);
+	if (CHECK(err, "get_kretprobe_res",
+		  "failed to get kretprobe res: %d\n", err))
+		goto cleanup;
+	if (CHECK(res != kretprobe_idx + 1, "check_kretprobe_res",
+		  "wrong kretprobe res: %d\n", res))
+		goto cleanup;
+
+	/* trigger & validate uprobe & uretprobe */
+	get_base_addr();
+
+	err = bpf_map_lookup_elem(results_map_fd, &uprobe_idx, &res);
+	if (CHECK(err, "get_uprobe_res",
+		  "failed to get uprobe res: %d\n", err))
+		goto cleanup;
+	if (CHECK(res != uprobe_idx + 1, "check_uprobe_res",
+		  "wrong uprobe res: %d\n", res))
+		goto cleanup;
+
+	err = bpf_map_lookup_elem(results_map_fd, &uretprobe_idx, &res);
+	if (CHECK(err, "get_uretprobe_res",
+		  "failed to get uretprobe res: %d\n", err))
+		goto cleanup;
+	if (CHECK(res != uretprobe_idx + 1, "check_uretprobe_res",
+		  "wrong uretprobe res: %d\n", res))
+		goto cleanup;
+
+cleanup:
+	bpf_link__destroy(kprobe_link);
+	bpf_link__destroy(kretprobe_link);
+	bpf_link__destroy(uprobe_link);
+	bpf_link__destroy(uretprobe_link);
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
new file mode 100644
index 000000000000..7a7c5cd728c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Facebook
+
+#include <linux/ptrace.h>
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
+
+struct {
+	int type;
+	int max_entries;
+	int *key;
+	int *value;
+} results_map SEC(".maps") = {
+	.type = BPF_MAP_TYPE_ARRAY,
+	.max_entries = 4,
+};
+
+SEC("kprobe/sys_nanosleep")
+int handle_sys_nanosleep_entry(struct pt_regs *ctx)
+{
+	const int key = 0, value = 1;
+
+	bpf_map_update_elem(&results_map, &key, &value, 0);
+	return 0;
+}
+
+SEC("kretprobe/sys_nanosleep")
+int handle_sys_getpid_return(struct pt_regs *ctx)
+{
+	const int key = 1, value = 2;
+
+	bpf_map_update_elem(&results_map, &key, &value, 0);
+	return 0;
+}
+
+SEC("uprobe/trigger_func")
+int handle_uprobe_entry(struct pt_regs *ctx)
+{
+	const int key = 2, value = 3;
+
+	bpf_map_update_elem(&results_map, &key, &value, 0);
+	return 0;
+}
+
+SEC("uretprobe/trigger_func")
+int handle_uprobe_return(struct pt_regs *ctx)
+{
+	const int key = 3, value = 4;
+
+	bpf_map_update_elem(&results_map, &key, &value, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+__u32 _version SEC("version") = 1;
-- 
2.17.1

