Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3E85E8D0A
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiIXNSc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Sep 2022 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIXNS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Sep 2022 09:18:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AA3B6547
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 06:18:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MZV071TPdzKJcQ
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 21:16:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOXAy9jXzpPBQ--.3282S15;
        Sat, 24 Sep 2022 21:18:24 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf-next v2 11/13] selftests/bpf: Add prog tests for qp-trie map
Date:   Sat, 24 Sep 2022 21:36:18 +0800
Message-Id: <20220924133620.4147153-12-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220924133620.4147153-1-houtao@huaweicloud.com>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOXAy9jXzpPBQ--.3282S15
X-Coremail-Antispam: 1UD129KBjvJXoW3ur4xKrWfJF4kur4fZFyxXwb_yoWkKr1Upa
        yFgryUtr4vqw17XrWFqa1fuFWrGa18Xw1UGF90ga43A3s7Zr93Wr1xKry0yFnakrWDX3y5
        Aas8tF4rG3yUJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUoeOJUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Add three test cases for qp-trie map. Firstly checking the basic
operations of qp-trie (lookup/update/delete) from both bpf syscall and
bpf program are working properly, then ensuring dynptr with zero size or
null data is handled correclty in qp-trie, lastly using full path from
bpf_d_path() as a dynptr key to show the possible use case for qp-trie.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/qp_trie_test.c   | 214 ++++++++++++++++++
 .../selftests/bpf/progs/qp_trie_test.c        | 200 ++++++++++++++++
 2 files changed, 414 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/qp_trie_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/qp_trie_test.c b/tools/testing/selftests/bpf/prog_tests/qp_trie_test.c
new file mode 100644
index 000000000000..fbfee0916f4c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/qp_trie_test.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "qp_trie_test.skel.h"
+
+#define FILE_PATH_SIZE 64
+
+static int setup_trie(struct bpf_map *trie, void *data, unsigned int size, unsigned int value)
+{
+	struct bpf_dynptr_user dynptr;
+	char raw[FILE_PATH_SIZE];
+	int fd, err, zero;
+
+	fd = bpf_map__fd(trie);
+	bpf_dynptr_user_init(data, size, &dynptr);
+	err = bpf_map_update_elem(fd, &dynptr, &value, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "trie add data"))
+		return -EINVAL;
+
+	zero = 0;
+	memset(raw, 0, size);
+	bpf_dynptr_user_init(raw, size, &dynptr);
+	err = bpf_map_update_elem(fd, &dynptr, &zero, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "trie add zero"))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int setup_array(struct bpf_map *array, void *data, unsigned int size)
+{
+	char raw[FILE_PATH_SIZE];
+	int fd, idx, err;
+
+	fd = bpf_map__fd(array);
+
+	idx = 0;
+	memcpy(raw, data, size);
+	memset(raw + size, 0, sizeof(raw) - size);
+	err = bpf_map_update_elem(fd, &idx, raw, BPF_EXIST);
+	if (!ASSERT_OK(err, "array add data"))
+		return -EINVAL;
+
+	idx = 1;
+	memset(raw, 0, sizeof(raw));
+	err = bpf_map_update_elem(fd, &idx, raw, BPF_EXIST);
+	if (!ASSERT_OK(err, "array add zero"))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int setup_htab(struct bpf_map *htab, void *data, unsigned int size, unsigned int value)
+{
+	char raw[FILE_PATH_SIZE];
+	int fd, err;
+
+	fd = bpf_map__fd(htab);
+
+	memcpy(raw, data, size);
+	memset(raw + size, 0, sizeof(raw) - size);
+	err = bpf_map_update_elem(fd, &raw, &value, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "htab add data"))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void test_qp_trie_basic_ops(void)
+{
+	const char *name = "qp_trie_basic_ops";
+	unsigned int value, new_value;
+	struct bpf_dynptr_user dynptr;
+	struct qp_trie_test *skel;
+	char raw[FILE_PATH_SIZE];
+	int err;
+
+	if (!ASSERT_LT(strlen(name), sizeof(raw), "lengthy data"))
+		return;
+
+	skel = qp_trie_test__open();
+	if (!ASSERT_OK_PTR(skel, "qp_trie_test__open()"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.basic_ops, true);
+
+	err = qp_trie_test__load(skel);
+	if (!ASSERT_OK(err, "qp_trie_test__load()"))
+		goto out;
+
+	value = time(NULL);
+	if (setup_trie(skel->maps.trie, (void *)name, strlen(name), value))
+		goto out;
+
+	if (setup_array(skel->maps.array, (void *)name, strlen(name)))
+		goto out;
+
+	skel->bss->key_size = strlen(name);
+	skel->bss->pid = getpid();
+	err = qp_trie_test__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->lookup_str_value, -1, "trie lookup str");
+	ASSERT_EQ(skel->bss->lookup_bytes_value, value, "trie lookup byte");
+	ASSERT_EQ(skel->bss->delete_again_err, -ENOENT, "trie delete again");
+
+	bpf_dynptr_user_init((void *)name, strlen(name), &dynptr);
+	new_value = 0;
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.trie), &dynptr, &new_value);
+	ASSERT_OK(err, "lookup trie");
+	ASSERT_EQ(new_value, value + 1, "check updated value");
+
+	memset(raw, 0, sizeof(raw));
+	bpf_dynptr_user_init(&raw, strlen(name), &dynptr);
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.trie), &dynptr, &new_value);
+	ASSERT_EQ(err, -ENOENT, "check deleted elem");
+out:
+	qp_trie_test__destroy(skel);
+}
+
+static void test_qp_trie_zero_size_dynptr(void)
+{
+	struct qp_trie_test *skel;
+	int err;
+
+	skel = qp_trie_test__open();
+	if (!ASSERT_OK_PTR(skel, "qp_trie_test__open()"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.zero_size_dynptr, true);
+
+	err = qp_trie_test__load(skel);
+	if (!ASSERT_OK(err, "qp_trie_test__load()"))
+		goto out;
+
+	skel->bss->pid = getpid();
+	err = qp_trie_test__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	usleep(1);
+
+	ASSERT_OK(skel->bss->zero_size_err, "handle zero sized dynptr");
+out:
+	qp_trie_test__destroy(skel);
+}
+
+static void test_qp_trie_d_path_key(void)
+{
+	const char *name = "/tmp/qp_trie_d_path_key";
+	struct qp_trie_test *skel;
+	char raw[FILE_PATH_SIZE];
+	unsigned int value;
+	int fd, err;
+
+	if (!ASSERT_LT(strlen(name), sizeof(raw), "lengthy data"))
+		return;
+
+	skel = qp_trie_test__open();
+	if (!ASSERT_OK_PTR(skel, "qp_trie_test__open()"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.d_path_key, true);
+
+	err = qp_trie_test__load(skel);
+	if (!ASSERT_OK(err, "qp_trie_test__load()"))
+		goto out;
+
+	value = time(NULL);
+	/* Include the trailing zero byte */
+	if (setup_trie(skel->maps.trie, (void *)name, strlen(name) + 1, value))
+		goto out;
+
+	if (setup_htab(skel->maps.htab, (void *)name, strlen(name) + 1, value))
+		goto out;
+
+	skel->bss->pid = getpid();
+	err = qp_trie_test__attach(skel);
+	/* No support for bpf trampoline ? */
+	if (err == -ENOTSUPP) {
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	fd = open(name, O_RDONLY | O_CREAT, 0644);
+	if (!ASSERT_GT(fd, 0, "open tmp file"))
+		goto out;
+	close(fd);
+	unlink(name);
+
+	ASSERT_EQ(skel->bss->trie_path_value, value, "trie lookup");
+	ASSERT_EQ(skel->bss->htab_path_value, -1, "htab lookup");
+out:
+	qp_trie_test__destroy(skel);
+}
+
+void test_qp_trie_test(void)
+{
+	if (test__start_subtest("basic_ops"))
+		test_qp_trie_basic_ops();
+	if (test__start_subtest("zero_size_dynptr"))
+		test_qp_trie_zero_size_dynptr();
+	if (test__start_subtest("d_path_key"))
+		test_qp_trie_d_path_key();
+}
diff --git a/tools/testing/selftests/bpf/progs/qp_trie_test.c b/tools/testing/selftests/bpf/progs/qp_trie_test.c
new file mode 100644
index 000000000000..3aa6c4784564
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/qp_trie_test.c
@@ -0,0 +1,200 @@
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
+	__uint(map_flags, BPF_F_NO_PREALLOC);
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
+
+unsigned int key_size;
+unsigned int lookup_str_value;
+unsigned int lookup_bytes_value;
+unsigned int delete_again_err;
+
+unsigned int zero_size_err;
+unsigned int null_data_err;
+
+unsigned int trie_path_value = 0;
+unsigned int htab_path_value = 0;
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int BPF_PROG(basic_ops)
+{
+	struct bpf_dynptr str_ptr, bytes_ptr, zero_ptr;
+	unsigned int new_value, byte_size;
+	unsigned int *value;
+	char *raw;
+	int idx;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	idx = 0;
+	raw = bpf_map_lookup_elem(&array, &idx);
+	if (!raw)
+		return 0;
+
+	byte_size = key_size;
+	if (!byte_size || byte_size >= FILE_PATH_SIZE)
+		return 0;
+
+	/* Append a zero byte to make it as a string */
+	bpf_dynptr_from_mem(raw, byte_size + 1, 0, &str_ptr);
+	value = bpf_map_lookup_elem(&trie, &str_ptr);
+	if (value)
+		lookup_str_value = *value;
+	else
+		lookup_str_value = -1;
+
+	/* Lookup map */
+	bpf_dynptr_from_mem(raw, byte_size, 0, &bytes_ptr);
+	value = bpf_map_lookup_elem(&trie, &bytes_ptr);
+	if (value)
+		lookup_bytes_value = *value;
+	else
+		lookup_bytes_value = -1;
+
+	/* Update map and check it in userspace */
+	new_value = lookup_bytes_value + 1;
+	bpf_map_update_elem(&trie, &bytes_ptr, &new_value, BPF_EXIST);
+
+	/* Delete map and check it in userspace */
+	idx = 1;
+	raw = bpf_map_lookup_elem(&array, &idx);
+	if (!raw)
+		return 0;
+	bpf_dynptr_from_mem(raw, byte_size, 0, &zero_ptr);
+	bpf_map_delete_elem(&trie, &zero_ptr);
+	delete_again_err = bpf_map_delete_elem(&trie, &zero_ptr);
+
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int BPF_PROG(zero_size_dynptr)
+{
+	struct bpf_dynptr ptr, bad_ptr;
+	unsigned int new_value;
+	void *value;
+	int idx, err;
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
+	/* Use zero-sized bpf_dynptr */
+	bpf_dynptr_from_mem(raw, 0, 0, &ptr);
+
+	value = bpf_map_lookup_elem(&trie, &ptr);
+	if (value)
+		zero_size_err |= 1;
+	new_value = 0;
+	err = bpf_map_update_elem(&trie, &ptr, &new_value, BPF_ANY);
+	if (err != -EINVAL)
+		zero_size_err |= 2;
+	err = bpf_map_delete_elem(&trie, &ptr);
+	if (err != -EINVAL)
+		zero_size_err |= 4;
+
+	/* A bad dynptr also is zero-sized */
+	bpf_dynptr_from_mem(raw, 1, 1U << 31, &bad_ptr);
+
+	value = bpf_map_lookup_elem(&trie, &bad_ptr);
+	if (value)
+		zero_size_err |= 8;
+	new_value = 0;
+	err = bpf_map_update_elem(&trie, &bad_ptr, &new_value, BPF_ANY);
+	if (err != -EINVAL)
+		zero_size_err |= 16;
+	err = bpf_map_delete_elem(&trie, &bad_ptr);
+	if (err != -EINVAL)
+		zero_size_err |= 32;
+	return 0;
+}
+
+SEC("?fentry/filp_close")
+int BPF_PROG(d_path_key, struct file *filp)
+{
+	struct bpf_dynptr ptr;
+	unsigned int *value;
+	struct path *p;
+	int idx, err;
+	long len;
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
+	if (len < 1 || len > FILE_PATH_SIZE)
+		return 0;
+
+	/* Include the trailing zero byte */
+	bpf_dynptr_from_mem(raw, len, 0, &ptr);
+	value = bpf_map_lookup_elem(&trie, &ptr);
+	if (value)
+		trie_path_value = *value;
+	else
+		trie_path_value = -1;
+
+	/* Due to the implementation of bpf_d_path(), there will be "garbage"
+	 * characters instead of zero bytes after raw[len-1], so the lookup
+	 * will fail.
+	 */
+	value = bpf_map_lookup_elem(&htab, raw);
+	if (value)
+		htab_path_value = *value;
+	else
+		htab_path_value = -1;
+
+	return 0;
+}
-- 
2.29.2

