Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BA45BB906
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 17:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIQPNf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Sep 2022 11:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIQPNa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 11:13:30 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F692D1CB
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 08:13:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MVDtX6SMdzl1km
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 23:11:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnenMO5CVjskryAw--.61987S12;
        Sat, 17 Sep 2022 23:13:27 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf-next 08/10] selftests/bpf: Add test case for basic qp-trie map operations
Date:   Sat, 17 Sep 2022 23:31:23 +0800
Message-Id: <20220917153125.2001645-9-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220917153125.2001645-1-houtao@huaweicloud.com>
References: <20220917153125.2001645-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenMO5CVjskryAw--.61987S12
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW8tr4DZFW8Kw18KFW5Awb_yoW3GFy3pa
        95G34Utr4xXw1aqrySqa1SgrWrWa18Ww1UGF90g345Zr97XF9xWF1xKFy8tF1SyrZ0qrWf
        ZasxtF4rCw48J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

First showing the lookup on qp-trie map is different with on hash-tab,
because qp-trie map only uses the specified length in key buffer instead
of the full key size, then checking update and deletion operations on
qp-trie map work as expected by using bpf_dynptr. Also checking the
zero-sized bpf_dynptr is rejected by map operations.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/qp_trie_test.c   |  91 +++++++++++++++
 .../selftests/bpf/progs/qp_trie_test.c        | 110 ++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/qp_trie_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_test.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 168c5b287b5c..e18d6f5ffeef 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -71,3 +71,4 @@ cb_refs                                  # expected error message unexpected err
 cgroup_hierarchical_stats                # JIT does not support calling kernel function                                (kfunc)
 htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
 tracing_struct                           # failed to auto-attach: -524                                                 (trampoline)
+qp_trie_test                             # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
diff --git a/tools/testing/selftests/bpf/prog_tests/qp_trie_test.c b/tools/testing/selftests/bpf/prog_tests/qp_trie_test.c
new file mode 100644
index 000000000000..24d5719f4f7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/qp_trie_test.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "qp_trie_test.skel.h"
+
+static int setup_maps(struct qp_trie_test *skel, char *name, unsigned int value)
+{
+#define FILE_PATH_SIZE 64
+	struct bpf_dynptr_user dynptr;
+	char raw[FILE_PATH_SIZE];
+	char zero;
+	int fd, err;
+
+	memset(raw, 0, sizeof(raw));
+	strncpy(raw, name, sizeof(raw) - 1);
+
+	fd = bpf_map__fd(skel->maps.trie);
+	/* Full path returned from d_path includes the trailing terminator */
+	bpf_dynptr_user_init(name, strlen(name) + 1, &dynptr);
+	err = bpf_map_update_elem(fd, &dynptr, &value, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "trie add name"))
+		return -EINVAL;
+
+	zero = 0;
+	bpf_dynptr_user_init(&zero, 1, &dynptr);
+	err = bpf_map_update_elem(fd, &dynptr, &value, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "trie add zero"))
+		return -EINVAL;
+
+	fd = bpf_map__fd(skel->maps.htab);
+	err = bpf_map_update_elem(fd, raw, &value, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "htab add"))
+		return -EINVAL;
+
+	return 0;
+}
+
+void test_qp_trie_test(void)
+{
+	char name[] = "/tmp/qp_trie_test";
+	unsigned int value, new_value;
+	struct bpf_dynptr_user dynptr;
+	struct qp_trie_test *skel;
+	int err, fd;
+	char zero;
+
+	skel = qp_trie_test__open();
+	if (!ASSERT_OK_PTR(skel, "qp_trie_test__open()"))
+		return;
+
+	err = qp_trie_test__load(skel);
+	if (!ASSERT_OK(err, "qp_trie_test__load()"))
+		goto out;
+
+	value = time(NULL);
+	if (setup_maps(skel, name, value))
+		goto out;
+
+	skel->bss->pid = getpid();
+	err = qp_trie_test__attach(skel);
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
+	ASSERT_EQ(skel->bss->htab_value, -1, "htab lookup bytes");
+	ASSERT_FALSE(skel->bss->zero_sized_key_bad, "zero-sized key");
+
+	bpf_dynptr_user_init(name, strlen(name) + 1, &dynptr);
+	new_value = 0;
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.trie), &dynptr, &new_value);
+	ASSERT_OK(err, "lookup elem");
+	ASSERT_EQ(new_value, value + 1, "check new value");
+
+	zero = 0;
+	bpf_dynptr_user_init(&zero, 1, &dynptr);
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.trie), &dynptr, &new_value);
+	ASSERT_EQ(err, -ENOENT, "lookup deleted elem");
+
+out:
+	qp_trie_test__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/qp_trie_test.c b/tools/testing/selftests/bpf/progs/qp_trie_test.c
new file mode 100644
index 000000000000..c7cf3dfae971
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/qp_trie_test.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
+#include <stdbool.h>
+#include <errno.h>
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
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__uint(key_size, 4);
+	__uint(value_size, FILE_PATH_SIZE);
+} array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QP_TRIE);
+	__uint(max_entries, 2);
+	__type(key, struct bpf_dynptr);
+	__type(value, unsigned int);
+	__uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_DYNPTR_KEY);
+	__uint(map_extra, FILE_PATH_SIZE);
+} trie SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__uint(key_size, FILE_PATH_SIZE);
+	__uint(value_size, 4);
+} htab SEC(".maps");
+
+int pid = 0;
+unsigned int trie_value = 0;
+unsigned int htab_value = 0;
+bool zero_sized_key_bad = false;
+
+SEC("fentry/filp_close")
+int BPF_PROG(filp_close, struct file *filp)
+{
+	struct bpf_dynptr str_ptr, zero_ptr, zero_sized_ptr;
+	unsigned int new_value, *value;
+	int idx, len, err;
+	struct path *p;
+	char *raw;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	idx = 0;
+	raw = bpf_map_lookup_elem(&array, &idx);
+	if (!raw)
+		return 0;
+
+	p = &filp->f_path;
+	len = bpf_d_path(p, raw, FILE_PATH_SIZE);
+	if (len < 0 || len > FILE_PATH_SIZE)
+		return 0;
+
+	bpf_dynptr_from_mem(raw, len, 0, &str_ptr);
+	value = bpf_map_lookup_elem(&trie, &str_ptr);
+	if (value)
+		trie_value = *value;
+	else
+		trie_value = -1;
+
+	value = bpf_map_lookup_elem(&htab, raw);
+	if (value)
+		htab_value = *value;
+	else
+		htab_value = -1;
+
+	/* Update qp_trie map */
+	new_value = trie_value + 1;
+	bpf_map_update_elem(&trie, &str_ptr, &new_value, BPF_ANY);
+
+	idx = 1;
+	raw = bpf_map_lookup_elem(&array, &idx);
+	if (!raw)
+		return 0;
+	bpf_dynptr_from_mem(raw, 1, 0, &zero_ptr);
+	bpf_map_delete_elem(&trie, &zero_ptr);
+
+	/* Use zero-sized bpf_dynptr */
+	bpf_dynptr_from_mem(raw, 0, 0, &zero_sized_ptr);
+
+	value = bpf_map_lookup_elem(&trie, &zero_sized_ptr);
+	if (value)
+		zero_sized_key_bad = true;
+	err = bpf_map_update_elem(&trie, &zero_sized_ptr, &new_value, BPF_ANY);
+	if (err != -EINVAL)
+		zero_sized_key_bad = true;
+	err = bpf_map_delete_elem(&trie, &zero_sized_ptr);
+	if (err != -EINVAL)
+		zero_sized_key_bad = true;
+
+	return 0;
+}
-- 
2.29.2

