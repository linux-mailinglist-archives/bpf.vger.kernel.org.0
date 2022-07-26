Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96FB581344
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 14:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiGZMmB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 08:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiGZMmA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 08:42:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AACB255AB
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 05:41:58 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lsc1z2BZgzgYtf;
        Tue, 26 Jul 2022 20:40:07 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Jul
 2022 20:41:55 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, <houtao1@huawei.com>
Subject: [RFC PATCH bpf-next 2/3] selftests/bpf: add a simple test for qp-trie
Date:   Tue, 26 Jul 2022 21:00:04 +0800
Message-ID: <20220726130005.3102470-3-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220726130005.3102470-1-houtao1@huawei.com>
References: <20220726130005.3102470-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test to demonstrate that qp-trie doesn't care about the
unused part of key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/str_key.c        | 69 +++++++++++++++
 tools/testing/selftests/bpf/progs/str_key.c   | 85 +++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/str_key.c
 create mode 100644 tools/testing/selftests/bpf/progs/str_key.c

diff --git a/tools/testing/selftests/bpf/prog_tests/str_key.c b/tools/testing/selftests/bpf/prog_tests/str_key.c
new file mode 100644
index 000000000000..8f134dd45902
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/str_key.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "str_key.skel.h"
+
+#define FILE_PATH_SIZE 64
+
+struct file_path_str {
+	unsigned int len;
+	char raw[FILE_PATH_SIZE];
+};
+
+static int setup_maps(struct str_key *skel, const char *name, unsigned int value)
+{
+	struct file_path_str key;
+	int fd, err;
+
+	memset(&key, 0, sizeof(key));
+	strncpy(key.raw, name, sizeof(key.raw) - 1);
+	key.len = strlen(name) + 1;
+
+	fd = bpf_map__fd(skel->maps.trie);
+	err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "trie add"))
+		return -EINVAL;
+
+	fd = bpf_map__fd(skel->maps.htab);
+	err = bpf_map_update_elem(fd, key.raw, &value, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "htab add"))
+		return -EINVAL;
+
+	return 0;
+}
+
+void test_str_key(void)
+{
+	const char *name = "/tmp/str_key_test";
+	struct str_key *skel;
+	unsigned int value;
+	int err, fd;
+
+	skel = str_key__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load str key"))
+		return;
+
+	value = time(NULL);
+	if (setup_maps(skel, name, value))
+		goto out;
+
+	skel->bss->pid = getpid();
+	err = str_key__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	fd = open(name, O_RDONLY | O_CREAT, 0644);
+	if (!ASSERT_GE(fd, 0, "open tmp file"))
+		goto out;
+	close(fd);
+	unlink(name);
+
+	ASSERT_EQ(skel->bss->trie_value, value, "trie lookup str");
+	ASSERT_EQ(skel->bss->htab_value, -1, "htab lookup str");
+out:
+	str_key__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/str_key.c b/tools/testing/selftests/bpf/progs/str_key.c
new file mode 100644
index 000000000000..2e8becdd58c6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/str_key.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct path {
+} __attribute__((preserve_access_index));
+
+struct file {
+	struct path f_path;
+} __attribute__((preserve_access_index));
+
+#define FILE_PATH_SIZE 64
+
+struct file_path_str {
+	unsigned int len;
+	char raw[FILE_PATH_SIZE];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct file_path_str);
+} array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QP_TRIE);
+	__uint(max_entries, 1);
+	__type(key, struct file_path_str);
+	__type(value, __u32);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} trie SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__uint(key_size, FILE_PATH_SIZE);
+	__uint(value_size, sizeof(__u32));
+} htab SEC(".maps");
+
+int pid = 0;
+unsigned int trie_value = 0;
+unsigned int htab_value = 0;
+
+SEC("fentry/filp_close")
+int BPF_PROG(filp_close, struct file *filp)
+{
+	struct path *p = &filp->f_path;
+	struct file_path_str *str;
+	unsigned int *value;
+	int idx, len;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	idx = 0;
+	str = bpf_map_lookup_elem(&array, &idx);
+	if (!str)
+		return 0;
+
+	len = bpf_d_path(p, str->raw, sizeof(str->raw));
+	if (len < 0 || len > sizeof(str->raw))
+		return 0;
+
+	str->len = len;
+	value = bpf_map_lookup_elem(&trie, str);
+	if (value)
+		trie_value = *value;
+	else
+		trie_value = -1;
+
+	value = bpf_map_lookup_elem(&htab, str->raw);
+	if (value)
+		htab_value = *value;
+	else
+		htab_value = -1;
+
+	return 0;
+}
-- 
2.29.2

