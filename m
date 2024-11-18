Return-Path: <bpf+bounces-45058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 285109D0758
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 01:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800B5B21BC9
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 00:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B808C1758B;
	Mon, 18 Nov 2024 00:56:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2113D517
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731891373; cv=none; b=a5hb+s538ape5YoMVtpRdmrOCff+9wjLZCi+13neFkn7x8t2OT2DdLi4XZazMBs6XPOb67VZhRzID/96hlLypYg14LA6otu8kOJ1RJQHO310iiJ/Pmn8B2t+aPdBC/EsThN+vcoMdix1IMCcKNckcT1JPpg3E+84MEbplpdK0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731891373; c=relaxed/simple;
	bh=FvDTvhfIuWLEyb6na+3CTeXY7LBRFnkOoVM8Cr2HYb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osl5IdSqLWyNUhphu6Ynop/eP7ASGc6eQGd2zx5wJOvCykrIEJIkOGWvTp5+sN8211UeQXXTOtoQGK4NBylDH/EGtcSHX3i+/ZxKJWE8LsuD+AmLuF7LeXemTS9Ov4hx3Ph57XCWLcN2/Z5z1qcFgTkF69Q1ybomPYyDm2x2xS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xs8Ly3h1Qz4f3jkk
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:55:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D6A8F1A0197
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:56:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4eckDpn2G5fCA--.44635S14;
	Mon, 18 Nov 2024 08:56:07 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 10/10] selftests/bpf: Add more test cases for LPM trie
Date: Mon, 18 Nov 2024 09:08:08 +0800
Message-Id: <20241118010808.2243555-11-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241118010808.2243555-1-houtao@huaweicloud.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4eckDpn2G5fCA--.44635S14
X-Coremail-Antispam: 1UD129KBjvAXoWfGw43AFW3XF15GrWxAr43Wrg_yoW8XF18Wo
	WfWwsxtw1FgryUZ3y8Wa4kuw15GF4Uu34kJr9aqwsxtw4UtrykAa18GFW3Gay8WF12kryq
	v3sFvr9ayr9YkrWfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOY7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU0sqXPUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add more test cases for LPM trie in test_maps:

1) test_lpm_trie_update_flags()
It constructs various use cases for BPF_EXIST and BPF_NOEXIST and check
whether the return value of update operation is expected.
2) test_lpm_trie_reuse_leaf_node
It tests whether the reuse of leaf node as intermediate node is handled
correctly when freeing the intermediate node.
3) test_lpm_trie_iterate_strs & test_lpm_trie_iterate_ints
There two test case test whether the iteration through get_next_key is
sorted and expected. These two test cases delete the minimal key after
each iteration and check whether next iteration returns the second
minimal key. The only difference between these two test cases is the
former one saves strings in the LPM trie and the latter saves integers.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/map_tests/lpm_trie_map_basic_ops.c    | 391 ++++++++++++++++++
 1 file changed, 391 insertions(+)

diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
index f375c89d78a4..eb17c711b4c8 100644
--- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
@@ -20,10 +20,12 @@
 #include <string.h>
 #include <time.h>
 #include <unistd.h>
+#include <endian.h>
 #include <arpa/inet.h>
 #include <sys/time.h>
 
 #include <bpf/bpf.h>
+#include <test_maps.h>
 
 #include "bpf_util.h"
 
@@ -33,6 +35,22 @@ struct tlpm_node {
 	uint8_t key[];
 };
 
+struct lpm_trie_bytes_key {
+	union {
+		struct bpf_lpm_trie_key_hdr hdr;
+		__u32 prefixlen;
+	};
+	unsigned char data[8];
+};
+
+struct lpm_trie_int_key {
+	union {
+		struct bpf_lpm_trie_key_hdr hdr;
+		__u32 prefixlen;
+	};
+	unsigned int data;
+};
+
 static struct tlpm_node *tlpm_match(struct tlpm_node *list,
 				    const uint8_t *key,
 				    size_t n_bits);
@@ -770,6 +788,374 @@ static void test_lpm_multi_thread(void)
 	close(map_fd);
 }
 
+static int lpm_trie_create(unsigned int key_size, unsigned int value_size, unsigned int max_entries)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	int fd;
+
+	opts.map_flags = BPF_F_NO_PREALLOC;
+	fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, "lpm_trie", key_size, value_size, max_entries,
+			    &opts);
+	CHECK(fd < 0, "bpf_map_create", "error %d\n", errno);
+
+	return fd;
+}
+
+static void test_lpm_trie_update_flags(void)
+{
+	struct lpm_trie_int_key key;
+	unsigned int value, got;
+	int fd, err;
+
+	fd = lpm_trie_create(sizeof(key), sizeof(value), 3);
+
+	/* invalid flags (Error) */
+	key.prefixlen = 32;
+	key.data = 0;
+	value = 0;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_F_LOCK);
+	CHECK(err != -EINVAL, "invalid update flag", "error %d\n", err);
+
+	/* invalid flags (Error) */
+	key.prefixlen = 32;
+	key.data = 0;
+	value = 0;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST | BPF_EXIST);
+	CHECK(err != -EINVAL, "invalid update flag", "error %d\n", err);
+
+	/* overwrite an empty qp-trie (Error) */
+	key.prefixlen = 32;
+	key.data = 0;
+	value = 2;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
+	CHECK(err != -ENOENT, "overwrite empty qp-trie", "error %d\n", err);
+
+	/* add a new node */
+	key.prefixlen = 16;
+	key.data = 0;
+	value = 1;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+	CHECK(err, "add new elem", "error %d\n", err);
+	got = 0;
+	err = bpf_map_lookup_elem(fd, &key, &got);
+	CHECK(err, "lookup elem", "error %d\n", err);
+	CHECK(got != value, "check value", "got %d exp %d\n", got, value);
+
+	/* add the same node as new node (Error) */
+	err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+	CHECK(err != -EEXIST, "add new elem again", "error %d\n", err);
+
+	/* overwrite the existed node */
+	value = 4;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
+	CHECK(err, "overwrite elem", "error %d\n", err);
+	got = 0;
+	err = bpf_map_lookup_elem(fd, &key, &got);
+	CHECK(err, "lookup elem", "error %d\n", err);
+	CHECK(got != value, "check value", "got %d exp %d\n", got, value);
+
+	/* overwrite the node */
+	value = 1;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_ANY);
+	CHECK(err, "update elem", "error %d\n", err);
+	got = 0;
+	err = bpf_map_lookup_elem(fd, &key, &got);
+	CHECK(err, "lookup elem", "error %d\n", err);
+	CHECK(got != value, "check value", "got %d exp %d\n", got, value);
+
+	/* overwrite a non-existent node which is the prefix of the first
+	 * node (Error).
+	 */
+	key.prefixlen = 8;
+	key.data = 0;
+	value = 2;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
+	CHECK(err != -ENOENT, "overwrite nonexistent elem", "error %d\n", err);
+
+	/* add a new node which is the prefix of the first node */
+	err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+	CHECK(err, "add new elem", "error %d\n", err);
+	got = 0;
+	err = bpf_map_lookup_elem(fd, &key, &got);
+	CHECK(err, "lookup key", "error %d\n", err);
+	CHECK(got != value, "check value", "got %d exp %d\n", got, value);
+
+	/* add another new node which will be the sibling of the first node */
+	key.prefixlen = 9;
+	key.data = htobe32(1 << 23);
+	value = 5;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+	CHECK(err, "add new elem", "error %d\n", err);
+	got = 0;
+	err = bpf_map_lookup_elem(fd, &key, &got);
+	CHECK(err, "lookup key", "error %d\n", err);
+	CHECK(got != value, "check value", "got %d exp %d\n", got, value);
+
+	/* overwrite the third node */
+	value = 3;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_ANY);
+	CHECK(err, "overwrite elem", "error %d\n", err);
+	got = 0;
+	err = bpf_map_lookup_elem(fd, &key, &got);
+	CHECK(err, "lookup key", "error %d\n", err);
+	CHECK(got != value, "check value", "got %d exp %d\n", got, value);
+
+	/* delete the second node to make it an intermediate node */
+	key.prefixlen = 8;
+	key.data = 0;
+	err = bpf_map_delete_elem(fd, &key);
+	CHECK(err, "del elem", "error %d\n", err);
+
+	/* overwrite the intermediate node (Error) */
+	value = 2;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
+	CHECK(err != -ENOENT, "overwrite nonexistent elem", "error %d\n", err);
+
+	close(fd);
+}
+
+static void test_lpm_trie_reuse_leaf_node(void)
+{
+	/* Use a big value_size to prevent the merging of intermediate node
+	 * allocator and leaf node allocator.
+	 */
+	char value[64] = {}, got[64] = {};
+	struct lpm_trie_int_key key;
+	int fd, err;
+
+	fd = lpm_trie_create(sizeof(key), sizeof(value), 3);
+
+	/* add a new node */
+	key.prefixlen = 16;
+	key.data = 0;
+	memset(value, 'a', sizeof(value));
+	err = bpf_map_update_elem(fd, &key, value, BPF_NOEXIST);
+	CHECK(err, "add new elem", "error %d\n", err);
+	memset(got, 0, sizeof(got));
+	err = bpf_map_lookup_elem(fd, &key, got);
+	CHECK(err, "lookup elem", "error %d\n", err);
+	CHECK(memcmp(value, got, sizeof(value)), "check value", "got %.*s exp %.*s\n",
+	      (int)sizeof(value), value, (int)sizeof(got), got);
+
+	/* add a new node which is the prefix of the first node */
+	key.prefixlen = 8;
+	key.data = 0;
+	memset(value, 'b', sizeof(value));
+	err = bpf_map_update_elem(fd, &key, value, BPF_NOEXIST);
+	CHECK(err, "add new elem", "error %d\n", err);
+	memset(got, 0, sizeof(got));
+	err = bpf_map_lookup_elem(fd, &key, got);
+	CHECK(err, "lookup elem", "error %d\n", err);
+	CHECK(memcmp(value, got, sizeof(value)), "check value", "got %.*s exp %.*s\n",
+	      (int)sizeof(value), value, (int)sizeof(got), got);
+
+	/* add another new node which will be the sibling of the first node */
+	key.prefixlen = 9;
+	key.data = htobe32(1 << 23);
+	memset(value, 'c', sizeof(value));
+	err = bpf_map_update_elem(fd, &key, value, BPF_NOEXIST);
+	CHECK(err, "add new elem", "error %d\n", err);
+	memset(got, 0, sizeof(got));
+	err = bpf_map_lookup_elem(fd, &key, got);
+	CHECK(err, "lookup elem", "error %d\n", err);
+	CHECK(memcmp(value, got, sizeof(value)), "check value", "got %.*s exp %.*s\n",
+	      (int)sizeof(value), value, (int)sizeof(got), got);
+
+	/* try to add more node (Error) */
+	key.prefixlen = 32;
+	key.data = 0;
+	memset(value, 'd', sizeof(value));
+	err = bpf_map_update_elem(fd, &key, value, BPF_NOEXIST);
+	CHECK(err != -ENOSPC, "add to full trie", "error %d\n", err);
+
+	/* delete the second node to make it an intermediate node */
+	key.prefixlen = 8;
+	key.data = 0;
+	err = bpf_map_delete_elem(fd, &key);
+	CHECK(err, "del elem", "error %d\n", err);
+
+	/* delete the first node to free the intermediate node */
+	key.prefixlen = 16;
+	key.data = 0;
+	err = bpf_map_delete_elem(fd, &key);
+	CHECK(err, "del elem", "error %d\n", err);
+
+	close(fd);
+}
+
+static int cmp_str(const void *a, const void *b)
+{
+	const char *str_a = *(const char **)a, *str_b = *(const char **)b;
+
+	return strcmp(str_a, str_b);
+}
+
+/* Save strings in LPM trie. The trailing '\0' for each string will be
+ * accounted in the prefixlen. The strings returned during the iteration
+ * should be sorted as expected.
+ */
+static void test_lpm_trie_iterate_strs(void)
+{
+	static const char * const keys[] = {
+		"ab", "abc", "abo", "abS", "abcd",
+	};
+	const char *sorted_keys[ARRAY_SIZE(keys)];
+	struct lpm_trie_bytes_key key, next_key;
+	unsigned int value, got, i, j, len;
+	struct lpm_trie_bytes_key *cur;
+	int fd, err;
+
+	fd = lpm_trie_create(sizeof(key), sizeof(value), ARRAY_SIZE(keys));
+
+	for (i = 0; i < ARRAY_SIZE(keys); i++) {
+		unsigned int flags;
+
+		/* add i-th element */
+		flags = i % 2 ? BPF_NOEXIST : 0;
+		len = strlen(keys[i]);
+		/* include the trailing '\0' */
+		key.prefixlen = (len + 1) * 8;
+		memset(key.data, 0, sizeof(key.data));
+		memcpy(key.data, keys[i], len);
+		value = i + 100;
+		err = bpf_map_update_elem(fd, &key, &value, flags);
+		CHECK(err, "add elem", "#%u error %d\n", i, err);
+
+		err = bpf_map_lookup_elem(fd, &key, &got);
+		CHECK(err, "lookup elem", "#%u error %d\n", i, err);
+		CHECK(got != value, "lookup elem", "#%u expect %u got %u\n", i, value, got);
+
+		/* re-add i-th element (Error) */
+		err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+		CHECK(err != -EEXIST, "re-add elem", "#%u error %d\n", i, err);
+
+		/* Overwrite i-th element */
+		flags = i % 2 ? 0 : BPF_EXIST;
+		value = i;
+		err = bpf_map_update_elem(fd, &key, &value, flags);
+		CHECK(err, "update elem", "error %d\n", err);
+
+		/* Lookup #[0~i] elements */
+		for (j = 0; j <= i; j++) {
+			len = strlen(keys[j]);
+			key.prefixlen = (len + 1) * 8;
+			memset(key.data, 0, sizeof(key.data));
+			memcpy(key.data, keys[j], len);
+			err = bpf_map_lookup_elem(fd, &key, &got);
+			CHECK(err, "lookup elem", "#%u/%u error %d\n", i, j, err);
+			CHECK(got != j, "lookup elem", "#%u/%u expect %u got %u\n",
+			      i, j, value, got);
+		}
+	}
+
+	/* Add element to a full qp-trie (Error) */
+	key.prefixlen = sizeof(key.data) * 8;
+	memset(key.data, 0, sizeof(key.data));
+	value = 0;
+	err = bpf_map_update_elem(fd, &key, &value, 0);
+	CHECK(err != -ENOSPC, "add to full qp-trie", "error %d\n", err);
+
+	/* Iterate sorted elements: no deletion */
+	memcpy(sorted_keys, keys, sizeof(keys));
+	qsort(sorted_keys, ARRAY_SIZE(sorted_keys), sizeof(sorted_keys[0]), cmp_str);
+	cur = NULL;
+	for (i = 0; i < ARRAY_SIZE(sorted_keys); i++) {
+		len = strlen(sorted_keys[i]);
+		err = bpf_map_get_next_key(fd, cur, &next_key);
+		CHECK(err, "iterate", "#%u error %d\n", i, err);
+		CHECK(next_key.prefixlen != (len + 1) * 8, "iterate",
+		      "#%u invalid len %u expect %u\n",
+		      i, next_key.prefixlen, (len + 1) * 8);
+		CHECK(memcmp(sorted_keys[i], next_key.data, len + 1), "iterate",
+		      "#%u got %.*s exp %.*s\n", i, len, next_key.data, len, sorted_keys[i]);
+
+		cur = &next_key;
+	}
+	err = bpf_map_get_next_key(fd, cur, &next_key);
+	CHECK(err != -ENOENT, "more element", "error %d\n", err);
+
+	/* Iterate sorted elements: delete the found key after each iteration */
+	cur = NULL;
+	for (i = 0; i < ARRAY_SIZE(sorted_keys); i++) {
+		len = strlen(sorted_keys[i]);
+		err = bpf_map_get_next_key(fd, cur, &next_key);
+		CHECK(err, "iterate", "#%u error %d\n", i, err);
+		CHECK(next_key.prefixlen != (len + 1) * 8, "iterate",
+		      "#%u invalid len %u expect %u\n",
+		      i, next_key.prefixlen, (len + 1) * 8);
+		CHECK(memcmp(sorted_keys[i], next_key.data, len + 1), "iterate",
+		      "#%u got %.*s exp %.*s\n", i, len, next_key.data, len, sorted_keys[i]);
+
+		cur = &next_key;
+
+		err = bpf_map_delete_elem(fd, cur);
+		CHECK(err, "delete", "#%u error %d\n", i, err);
+	}
+	err = bpf_map_get_next_key(fd, cur, &next_key);
+	CHECK(err != -ENOENT, "non-empty qp-trie", "error %d\n", err);
+
+	close(fd);
+}
+
+/* Use the fixed prefixlen (32) and save integers in LPM trie. The iteration of
+ * LPM trie will return these integers in big-endian order, therefore, convert
+ * these integers to big-endian before update. After each iteration, delete the
+ * found key (the smallest integer) and expect the next iteration will return
+ * the second smallest number.
+ */
+static void test_lpm_trie_iterate_ints(void)
+{
+	struct lpm_trie_int_key key, next_key;
+	unsigned int i, max_entries;
+	struct lpm_trie_int_key *cur;
+	unsigned int *data_set;
+	int fd, err;
+	bool value;
+
+	max_entries = 4096;
+	data_set = calloc(max_entries, sizeof(*data_set));
+	CHECK(!data_set, "malloc", "no mem\n");
+	for (i = 0; i < max_entries; i++)
+		data_set[i] = i;
+
+	fd = lpm_trie_create(sizeof(key), sizeof(value), max_entries);
+	value = true;
+	for (i = 0; i < max_entries; i++) {
+		key.prefixlen = 32;
+		key.data = htobe32(data_set[i]);
+
+		err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+		CHECK(err, "add elem", "#%u error %d\n", i, err);
+	}
+
+	cur = NULL;
+	for (i = 0; i < max_entries; i++) {
+		err = bpf_map_get_next_key(fd, cur, &next_key);
+		CHECK(err, "iterate", "#%u error %d\n", i, err);
+		CHECK(next_key.prefixlen != 32, "iterate", "#%u invalid len %u\n",
+		      i, next_key.prefixlen);
+		CHECK(be32toh(next_key.data) != data_set[i], "iterate", "#%u got 0x%x exp 0x%x\n",
+		      i, be32toh(next_key.data), data_set[i]);
+		cur = &next_key;
+
+		/*
+		 * Delete the minimal key, the next call of bpf_get_next_key()
+		 * will return the second minimal key.
+		 */
+		err = bpf_map_delete_elem(fd, &next_key);
+		CHECK(err, "del elem", "#%u elem error %d\n", i, err);
+	}
+	err = bpf_map_get_next_key(fd, cur, &next_key);
+	CHECK(err != -ENOENT, "more element", "error %d\n", err);
+
+	err = bpf_map_get_next_key(fd, NULL, &next_key);
+	CHECK(err != -ENOENT, "no-empty qp-trie", "error %d\n", err);
+
+	free(data_set);
+
+	close(fd);
+}
+
 void test_lpm_trie_map_basic_ops(void)
 {
 	int i;
@@ -789,5 +1175,10 @@ void test_lpm_trie_map_basic_ops(void)
 	test_lpm_get_next_key();
 	test_lpm_multi_thread();
 
+	test_lpm_trie_update_flags();
+	test_lpm_trie_reuse_leaf_node();
+	test_lpm_trie_iterate_strs();
+	test_lpm_trie_iterate_ints();
+
 	printf("%s: PASS\n", __func__);
 }
-- 
2.29.2


