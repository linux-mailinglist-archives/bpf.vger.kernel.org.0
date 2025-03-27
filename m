Return-Path: <bpf+bounces-54796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1973FA72B63
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD613B890C
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07D2205AAE;
	Thu, 27 Mar 2025 08:23:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6AE204F96
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063785; cv=none; b=XZx+2mKvFrGTFzCq/0q4FrO8SoB2xOoSzJAaSix8578s1owigpPBf0tiWBrB8G8BtkW0TgCgEqP60kx1TN+gX39mOCcqqbeEuNA7sJWHKbJLrVfboDmQPAs88JljWtZSvomY2I2RoRh4JDuEvet8yWD9mnILGnBM2/P4rKOqUX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063785; c=relaxed/simple;
	bh=d2PZC4BT9MFbbsMr20DrWTdKflOL1SmXT7tDEsHdVs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWKDiOMD1uPh4ZOUElRjM3jvepCx4VHu6IDNpyAa3x4mi4ZbQ9oMw1d6YPlxu86jKW3MGaXF9YsmbQHlDFv4UgZSF5sSwcpFL5vEhEc5TcrpgW9YILXMphGvnMvfbPx+rVqLLuSMVAY5t8jI8nHJpanAjPjOxueUkLhLaaLHtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8q1qYzz4f3m7Y
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A88B81A1D42
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S19;
	Thu, 27 Mar 2025 16:22:59 +0800 (CST)
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
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 15/16] selftests/bpf: Add test cases for hash map with dynptr key
Date: Thu, 27 Mar 2025 16:34:54 +0800
Message-Id: <20250327083455.848708-16-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250327083455.848708-1-houtao@huaweicloud.com>
References: <20250327083455.848708-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S19
X-Coremail-Antispam: 1UD129KBjvAXoWfurWrurW3CF1DWr1DZF48Crg_yoW5Cw4DXo
	ZxWrs0y3W8CF95Aw1DW3s7Ca1fXw48JryDCr4Sqws8Jw48KryYva4xGw45Gw42vw4rtFy8
	uryfZw1fXrZ2gr15n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOY7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU1aLvJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add three positive test cases to test the basic operations on the
dynptr-keyed hash map. The basic operations include lookup, update,
delete and get_next_key. These operations are exercised both through
bpf syscall and bpf program. These three test cases use different map
keys. The first test case uses both bpf_dynptr and a struct with only
bpf_dynptr as map key, the second one uses a struct with an integer and
a bpf_dynptr as map key, and the last one use a struct with two
bpf_dynptr as map key: one in the struct itself and another is nested in
another struct.

Also add multiple negative test cases for dynptr-keyed hash map. These
test cases mainly check whether the layout of dynptr and non-dynptr in
the stack is matched with the definition of map->key_record.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/prog_tests/htab_dynkey_test.c         | 446 ++++++++++++++++++
 .../bpf/progs/htab_dynkey_test_failure.c      | 266 +++++++++++
 .../bpf/progs/htab_dynkey_test_success.c      | 382 +++++++++++++++
 3 files changed, 1094 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_dynkey_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_dynkey_test.c b/tools/testing/selftests/bpf/prog_tests/htab_dynkey_test.c
new file mode 100644
index 0000000000000..77c3547b553c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/htab_dynkey_test.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <test_progs.h>
+
+#include "htab_dynkey_test_success.skel.h"
+#include "htab_dynkey_test_failure.skel.h"
+
+struct id_dname_key {
+	int id;
+	struct bpf_dynptr name;
+};
+
+struct dname_key {
+	struct bpf_dynptr name;
+};
+
+struct multiple_dynptr_key {
+	struct dname_key f_1;
+	unsigned long f_2;
+	struct id_dname_key f_3;
+	unsigned long f_4;
+};
+
+static char *name_list[] = {
+	"systemd",
+	"[rcu_sched]",
+	"[kworker/42:0H-events_highpri]",
+	"[ksoftirqd/58]",
+	"[rcu_tasks_trace]",
+};
+
+#define INIT_VALUE 100
+#define INIT_ID 1000
+
+static void setup_pure_dynptr_key_map(int fd)
+{
+	struct bpf_dynptr key, _cur_key, _next_key;
+	struct bpf_dynptr *cur_key, *next_key;
+	bool marked[ARRAY_SIZE(name_list)];
+	unsigned int i, next_idx, size;
+	unsigned long value, got;
+	char name[2][64];
+	char msg[64];
+	void *data;
+	int err;
+
+	/* lookup non-existent keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u bad lookup", i);
+		/* Use strdup() to ensure that the content pointed by dynptr is
+		 * used for lookup instead of the pointer in dynptr. sys_bpf()
+		 * will handle the NULL case properly.
+		 */
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key);
+		err = bpf_map_lookup_elem(fd, &key, &value);
+		ASSERT_EQ(err, -ENOENT, msg);
+		free(data);
+	}
+
+	/* update keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u insert", i);
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key);
+		value = INIT_VALUE + i;
+		err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+		ASSERT_OK(err, msg);
+		free(data);
+	}
+
+	/* lookup existent keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u lookup", i);
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key);
+		got = 0;
+		err = bpf_map_lookup_elem(fd, &key, &got);
+		ASSERT_OK(err, msg);
+		free(data);
+
+		value = INIT_VALUE + i;
+		ASSERT_EQ(got, value, msg);
+	}
+
+	/* delete keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u delete", i);
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key);
+		err = bpf_map_delete_elem(fd, &key);
+		ASSERT_OK(err, msg);
+		free(data);
+	}
+
+	/* re-insert keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u re-insert", i);
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key);
+		value = 0;
+		err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+		ASSERT_OK(err, msg);
+		free(data);
+	}
+
+	/* overwrite keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u overwrite", i);
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key);
+		value = INIT_VALUE + i;
+		err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
+		ASSERT_OK(err, msg);
+		free(data);
+	}
+
+	/* get_next keys */
+	next_idx = 0;
+	cur_key = NULL;
+	next_key = &_next_key;
+	memset(&marked, 0, sizeof(marked));
+	while (true) {
+		bpf_dynptr_user_init(name[next_idx], sizeof(name[next_idx]), next_key);
+		err = bpf_map_get_next_key(fd, cur_key, next_key);
+		if (err) {
+			ASSERT_EQ(err, -ENOENT, "get_next_key");
+			break;
+		}
+
+		size = next_key->size;
+		data = next_key->data;
+		for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+			if (size == strlen(name_list[i]) + 1 &&
+			    !memcmp(name_list[i], data, size)) {
+				ASSERT_FALSE(marked[i], name_list[i]);
+				marked[i] = true;
+				break;
+			}
+		}
+		ASSERT_EQ(next_key->reserved, 0, "reserved");
+
+		if (!cur_key)
+			cur_key = &_cur_key;
+		*cur_key = *next_key;
+		next_idx ^= 1;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(marked); i++)
+		ASSERT_TRUE(marked[i], name_list[i]);
+
+	/* lookup_and_delete all elements except the first one */
+	for (i = 1; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u lookup_delete", i);
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key);
+		got = 0;
+		err = bpf_map_lookup_and_delete_elem(fd, &key, &got);
+		ASSERT_OK(err, msg);
+		free(data);
+
+		value = INIT_VALUE + i;
+		ASSERT_EQ(got, value, msg);
+	}
+
+	/* get the key after the first element */
+	cur_key = &_cur_key;
+	strncpy(name[0], name_list[0], sizeof(name[0]) - 1);
+	name[0][sizeof(name[0]) - 1] = 0;
+	bpf_dynptr_user_init(name[0], strlen(name[0]) + 1, cur_key);
+
+	next_key = &_next_key;
+	bpf_dynptr_user_init(name[1], sizeof(name[1]), next_key);
+	err = bpf_map_get_next_key(fd, cur_key, next_key);
+	ASSERT_EQ(err, -ENOENT, "get_last");
+}
+
+static void setup_mixed_dynptr_key_map(int fd)
+{
+	struct id_dname_key key, _cur_key, _next_key;
+	struct id_dname_key *cur_key, *next_key;
+	bool marked[ARRAY_SIZE(name_list)];
+	unsigned int i, next_idx, size;
+	unsigned long value;
+	char name[2][64];
+	char msg[64];
+	void *data;
+	int err;
+
+	/* Zero the hole */
+	memset(&key, 0, sizeof(key));
+
+	/* lookup non-existent keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u bad lookup", i);
+		key.id = INIT_ID + i;
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key.name);
+		err = bpf_map_lookup_elem(fd, &key, &value);
+		ASSERT_EQ(err, -ENOENT, msg);
+		free(data);
+	}
+
+	/* update keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u insert", i);
+		key.id = INIT_ID + i;
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key.name);
+		value = INIT_VALUE + i;
+		err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+		ASSERT_OK(err, msg);
+		free(data);
+	}
+
+	/* lookup existent keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		unsigned long got = 0;
+
+		snprintf(msg, sizeof(msg), "#%u lookup", i);
+		key.id = INIT_ID + i;
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key.name);
+		err = bpf_map_lookup_elem(fd, &key, &got);
+		ASSERT_OK(err, msg);
+		free(data);
+
+		value = INIT_VALUE + i;
+		ASSERT_EQ(got, value, msg);
+	}
+
+	/* delete keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u delete", i);
+		key.id = INIT_ID + i;
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key.name);
+		err = bpf_map_delete_elem(fd, &key);
+		ASSERT_OK(err, msg);
+		free(data);
+	}
+
+	/* re-insert keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u re-insert", i);
+		key.id = INIT_ID + i;
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key.name);
+		value = 0;
+		err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+		ASSERT_OK(err, msg);
+		free(data);
+	}
+
+	/* overwrite keys */
+	for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+		snprintf(msg, sizeof(msg), "#%u overwrite", i);
+		key.id = INIT_ID + i;
+		data = strdup(name_list[i]);
+		bpf_dynptr_user_init(data, strlen(name_list[i]) + 1, &key.name);
+		value = INIT_VALUE + i;
+		err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
+		ASSERT_OK(err, msg);
+		free(data);
+	}
+
+	/* get_next keys */
+	next_idx = 0;
+	cur_key = NULL;
+	next_key = &_next_key;
+	memset(&marked, 0, sizeof(marked));
+	while (true) {
+		bpf_dynptr_user_init(name[next_idx], sizeof(name[next_idx]), &next_key->name);
+		err = bpf_map_get_next_key(fd, cur_key, next_key);
+		if (err) {
+			ASSERT_EQ(err, -ENOENT, "last get_next");
+			break;
+		}
+
+		size = next_key->name.size;
+		data = next_key->name.data;
+		for (i = 0; i < ARRAY_SIZE(name_list); i++) {
+			if (size == strlen(name_list[i]) + 1 &&
+			    !memcmp(name_list[i], data, size)) {
+				ASSERT_FALSE(marked[i], name_list[i]);
+				ASSERT_EQ(next_key->id, INIT_ID + i, name_list[i]);
+				marked[i] = true;
+				break;
+			}
+		}
+		ASSERT_EQ(next_key->name.reserved, 0, "reserved");
+
+		if (!cur_key)
+			cur_key = &_cur_key;
+		*cur_key = *next_key;
+		next_idx ^= 1;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(marked); i++)
+		ASSERT_TRUE(marked[i], name_list[i]);
+}
+
+static void setup_multiple_dynptr_key_map(int fd)
+{
+	struct multiple_dynptr_key key, cur_key, next_key;
+	unsigned long value;
+	unsigned int size;
+	char name[4][64];
+	void *data[2];
+	int err;
+
+	/* Zero the hole */
+	memset(&key, 0, sizeof(key));
+
+	key.f_2 = 2;
+	key.f_3.id = 3;
+	key.f_4 = 4;
+
+	/* lookup a non-existent key */
+	data[0] = strdup(name_list[0]);
+	data[1] = strdup(name_list[1]);
+	bpf_dynptr_user_init(data[0], strlen(name_list[0]) + 1, &key.f_1.name);
+	bpf_dynptr_user_init(data[1], strlen(name_list[1]) + 1, &key.f_3.name);
+	err = bpf_map_lookup_elem(fd, &key, &value);
+	ASSERT_EQ(err, -ENOENT, "lookup");
+
+	/* update key */
+	value = INIT_VALUE;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+	ASSERT_OK(err, "update");
+	free(data[0]);
+	free(data[1]);
+
+	/* lookup key */
+	data[0] = strdup(name_list[0]);
+	data[1] = strdup(name_list[1]);
+	bpf_dynptr_user_init(data[0], strlen(name_list[0]) + 1, &key.f_1.name);
+	bpf_dynptr_user_init(data[1], strlen(name_list[1]) + 1, &key.f_3.name);
+	err = bpf_map_lookup_elem(fd, &key, &value);
+	ASSERT_OK(err, "lookup");
+	ASSERT_EQ(value, INIT_VALUE, "lookup");
+
+	/* delete key */
+	err = bpf_map_delete_elem(fd, &key);
+	ASSERT_OK(err, "delete");
+	free(data[0]);
+	free(data[1]);
+
+	/* re-insert keys */
+	bpf_dynptr_user_init(name_list[0], strlen(name_list[0]) + 1, &key.f_1.name);
+	bpf_dynptr_user_init(name_list[1], strlen(name_list[1]) + 1, &key.f_3.name);
+	value = 0;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+	ASSERT_OK(err, "re-insert");
+
+	/* overwrite keys */
+	data[0] = strdup(name_list[0]);
+	data[1] = strdup(name_list[1]);
+	bpf_dynptr_user_init(data[0], strlen(name_list[0]) + 1, &key.f_1.name);
+	bpf_dynptr_user_init(data[1], strlen(name_list[1]) + 1, &key.f_3.name);
+	value = INIT_VALUE;
+	err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
+	ASSERT_OK(err, "overwrite");
+	free(data[0]);
+	free(data[1]);
+
+	/* get_next_key */
+	bpf_dynptr_user_init(name[0], sizeof(name[0]), &next_key.f_1.name);
+	bpf_dynptr_user_init(name[1], sizeof(name[1]), &next_key.f_3.name);
+	err = bpf_map_get_next_key(fd, NULL, &next_key);
+	ASSERT_OK(err, "first get_next");
+
+	size = next_key.f_1.name.size;
+	data[0] = next_key.f_1.name.data;
+	if (ASSERT_EQ(size, strlen(name_list[0]) + 1, "f_1 size"))
+		ASSERT_TRUE(!memcmp(name_list[0], data[0], size), "f_1 data");
+	ASSERT_EQ(next_key.f_1.name.reserved, 0, "f_1 reserved");
+
+	ASSERT_EQ(next_key.f_2, 2, "f_2");
+
+	ASSERT_EQ(next_key.f_3.id, 3, "f_3 id");
+	size = next_key.f_3.name.size;
+	data[0] = next_key.f_3.name.data;
+	if (ASSERT_EQ(size, strlen(name_list[1]) + 1, "f_3 size"))
+		ASSERT_TRUE(!memcmp(name_list[1], data[0], size), "f_3 data");
+	ASSERT_EQ(next_key.f_3.name.reserved, 0, "f_3 reserved");
+
+	ASSERT_EQ(next_key.f_4, 4, "f_4");
+
+	cur_key = next_key;
+	bpf_dynptr_user_init(name[2], sizeof(name[2]), &next_key.f_1.name);
+	bpf_dynptr_user_init(name[3], sizeof(name[3]), &next_key.f_3.name);
+	err = bpf_map_get_next_key(fd, &cur_key, &next_key);
+	ASSERT_EQ(err, -ENOENT, "last get_next_key");
+}
+
+static void test_htab_dynptr_key(bool pure, bool multiple)
+{
+	struct htab_dynkey_test_success *skel;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct bpf_program *prog;
+	int err;
+
+	skel = htab_dynkey_test_success__open();
+	if (!ASSERT_OK_PTR(skel, "open()"))
+		return;
+
+	prog = pure ? skel->progs.pure_dynptr_key :
+	       (multiple ? skel->progs.multiple_dynptr_key : skel->progs.mixed_dynptr_key);
+	bpf_program__set_autoload(prog, true);
+
+	err = htab_dynkey_test_success__load(skel);
+	if (!ASSERT_OK(err, "load()"))
+		goto out;
+
+	if (pure) {
+		setup_pure_dynptr_key_map(bpf_map__fd(skel->maps.htab_1));
+		setup_pure_dynptr_key_map(bpf_map__fd(skel->maps.htab_2));
+	} else if (multiple) {
+		setup_multiple_dynptr_key_map(bpf_map__fd(skel->maps.htab_4));
+	} else {
+		setup_mixed_dynptr_key_map(bpf_map__fd(skel->maps.htab_3));
+	}
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	ASSERT_OK(err, "run");
+	ASSERT_EQ(opts.retval, 0, "retval");
+out:
+	htab_dynkey_test_success__destroy(skel);
+}
+
+void test_htab_dynkey_test(void)
+{
+	if (test__start_subtest("pure_dynptr_key"))
+		test_htab_dynptr_key(true, false);
+	if (test__start_subtest("mixed_dynptr_key"))
+		test_htab_dynptr_key(false, false);
+	if (test__start_subtest("multiple_dynptr_key"))
+		test_htab_dynptr_key(false, true);
+
+	RUN_TESTS(htab_dynkey_test_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/htab_dynkey_test_failure.c b/tools/testing/selftests/bpf/progs/htab_dynkey_test_failure.c
new file mode 100644
index 0000000000000..2577f2a2fe309
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/htab_dynkey_test_failure.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct bpf_map;
+
+struct id_dname_key {
+	int id;
+	struct bpf_dynptr name;
+};
+
+struct dname_id_key {
+	struct bpf_dynptr name;
+	int id;
+};
+
+struct id_name_key {
+	int id;
+	char name[20];
+};
+
+struct dname_key {
+	struct bpf_dynptr name;
+};
+
+struct dname_dname_key {
+	struct bpf_dynptr name_1;
+	struct bpf_dynptr name_2;
+};
+
+struct dname_dname_id_key {
+	struct dname_dname_key names;
+	__u64 id;
+};
+
+struct dname_id_id_id_key {
+	struct bpf_dynptr name;
+	__u64 id[3];
+};
+
+struct dname_dname_dname_key {
+	struct bpf_dynptr name_1;
+	struct bpf_dynptr name_2;
+	struct bpf_dynptr name_3;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, struct id_dname_key);
+	__type(value, unsigned long);
+} htab_1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, struct dname_key);
+	__type(value, unsigned long);
+} htab_2 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, struct dname_dname_id_key);
+	__type(value, unsigned long);
+} htab_3 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, struct bpf_dynptr);
+	__type(value, unsigned long);
+} htab_4 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+char dynptr_buf[32] = {};
+
+/* uninitialized dynptr */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("dynptr-key expects dynptr at offset 8")
+int BPF_PROG(uninit_dynptr)
+{
+	struct id_dname_key key;
+
+	key.id = 100;
+	bpf_map_lookup_elem(&htab_1, &key);
+
+	return 0;
+}
+
+/* invalid dynptr */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("dynptr-key expects dynptr at offset 8")
+int BPF_PROG(invalid_dynptr)
+{
+	struct id_dname_key key;
+
+	key.id = 100;
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 10, 0, &key.name);
+	bpf_ringbuf_discard_dynptr(&key.name, 0);
+	bpf_map_lookup_elem(&htab_1, &key);
+
+	return 0;
+}
+
+/* expect no-dynptr got dynptr */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("dynptr-key expects non-dynptr at offset 0")
+int BPF_PROG(invalid_non_dynptr)
+{
+	struct dname_id_key key;
+
+	__builtin_memcpy(dynptr_buf, "test", 4);
+	bpf_dynptr_from_mem(dynptr_buf, 4, 0, &key.name);
+	key.id = 100;
+	bpf_map_lookup_elem(&htab_1, &key);
+
+	return 0;
+}
+
+/* expect dynptr get non-dynptr */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("dynptr-key expects dynptr at offset 8")
+int BPF_PROG(no_dynptr)
+{
+	struct id_name_key key;
+
+	key.id = 100;
+	__builtin_memset(key.name, 0, sizeof(key.name));
+	__builtin_memcpy(key.name, "test", 4);
+	bpf_map_lookup_elem(&htab_1, &key);
+
+	return 0;
+}
+
+/* malformed */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("malformed dynptr-key at offset 8")
+int BPF_PROG(malformed_dynptr)
+{
+	struct dname_dname_key key;
+
+	bpf_dynptr_from_mem(dynptr_buf, 4, 0, &key.name_1);
+	bpf_dynptr_from_mem(dynptr_buf, 4, 0, &key.name_2);
+
+	bpf_map_lookup_elem(&htab_2, (void *)&key + 8);
+
+	return 0;
+}
+
+/* expect no-dynptr got dynptr */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("dynptr-key expects non-dynptr at offset 32")
+int BPF_PROG(invalid_non_dynptr_2)
+{
+	struct dname_dname_dname_key key;
+
+	bpf_dynptr_from_mem(dynptr_buf, 4, 0, &key.name_1);
+	bpf_dynptr_from_mem(dynptr_buf, 4, 0, &key.name_2);
+	bpf_dynptr_from_mem(dynptr_buf, 4, 0, &key.name_3);
+
+	bpf_map_lookup_elem(&htab_3, &key);
+
+	return 0;
+}
+
+/* expect dynptr get non-dynptr */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("dynptr-key expects dynptr at offset 16")
+int BPF_PROG(no_dynptr_2)
+{
+	struct dname_id_id_id_key key;
+
+	bpf_dynptr_from_mem(dynptr_buf, 4, 0, &key.name);
+	bpf_map_lookup_elem(&htab_3, &key);
+
+	return 0;
+}
+
+/* misaligned */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("R2 misaligned offset -28 for dynptr-key")
+int BPF_PROG(misaligned_dynptr)
+{
+	struct dname_dname_key key = {};
+
+	bpf_map_lookup_elem(&htab_1, (char *)&key + 4);
+
+	return 0;
+}
+
+/* variable offset */
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("R2 variable offset prohibited for dynptr-key")
+int BPF_PROG(variable_offset_dynptr)
+{
+	struct bpf_dynptr dynptr_1;
+	struct bpf_dynptr dynptr_2;
+	char *key;
+
+	bpf_dynptr_from_mem(dynptr_buf, 4, 0, &dynptr_1);
+	bpf_dynptr_from_mem(dynptr_buf, 4, 0, &dynptr_2);
+
+	key = (char *)&dynptr_2;
+	key = key + (bpf_get_prandom_u32() & 1) * 16;
+
+	bpf_map_lookup_elem(&htab_2, key);
+
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("map dynptr-key requires stack ptr but got map_value")
+int BPF_PROG(map_value_as_key)
+{
+	bpf_map_lookup_elem(&htab_1, dynptr_buf);
+
+	return 0;
+}
+
+static int lookup_htab(struct bpf_map *map, struct id_dname_key *key, void *value, void *data)
+{
+	bpf_map_lookup_elem(&htab_1, key);
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("cannot pass map_type 1 into func bpf_for_each_map_elem")
+int BPF_PROG(map_key_as_key)
+{
+	bpf_for_each_map_elem(&htab_1, lookup_htab, NULL, 0);
+	return 0;
+}
+
+__noinline __weak int subprog_lookup_htab(struct bpf_dynptr *dynptr)
+{
+	bpf_map_lookup_elem(&htab_4, dynptr);
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("R2 type=dynptr_ptr expected=")
+int BPF_PROG(subprog_dynptr)
+{
+	struct bpf_dynptr dynptr;
+
+	bpf_dynptr_from_mem(dynptr_buf, 4, 0, &dynptr);
+	subprog_lookup_htab(&dynptr);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
new file mode 100644
index 0000000000000..84e6931cc19c0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct pure_dynptr_key {
+	struct bpf_dynptr name;
+};
+
+struct mixed_dynptr_key {
+	int id;
+	struct bpf_dynptr name;
+};
+
+struct multiple_dynptr_key {
+	struct pure_dynptr_key f_1;
+	unsigned long f_2;
+	struct mixed_dynptr_key f_3;
+	unsigned long f_4;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, struct bpf_dynptr);
+	__type(value, unsigned long);
+} htab_1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, struct pure_dynptr_key);
+	__type(value, unsigned long);
+} htab_2 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, struct mixed_dynptr_key);
+	__type(value, unsigned long);
+} htab_3 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, struct multiple_dynptr_key);
+	__type(value, unsigned long);
+} htab_4 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+char dynptr_buf[2][32] = {{}, {}};
+
+static const char systemd_name[] = "systemd";
+static const char udevd_name[] = "udevd";
+static const char rcu_sched_name[] = "[rcu_sched]";
+
+struct bpf_map;
+
+static int test_pure_dynptr_key_htab(struct bpf_map *htab)
+{
+	unsigned long new_value, *value;
+	struct bpf_dynptr key;
+	int err = 0;
+
+	/* Lookup a existent key */
+	__builtin_memcpy(dynptr_buf[0], systemd_name, sizeof(systemd_name));
+	bpf_dynptr_from_mem(dynptr_buf[0], sizeof(systemd_name), 0, &key);
+	value = bpf_map_lookup_elem(htab, &key);
+	if (!value) {
+		err = 1;
+		goto out;
+	}
+	if (*value != 100) {
+		err = 2;
+		goto out;
+	}
+
+	/* Look up a non-existent key */
+	__builtin_memcpy(dynptr_buf[0], udevd_name, sizeof(udevd_name));
+	bpf_dynptr_from_mem(dynptr_buf[0], sizeof(udevd_name), 0, &key);
+	value = bpf_map_lookup_elem(htab, &key);
+	if (value) {
+		err = 3;
+		goto out;
+	}
+
+	/* Insert a new key */
+	new_value = 42;
+	err = bpf_map_update_elem(htab, &key, &new_value, BPF_NOEXIST);
+	if (err) {
+		err = 4;
+		goto out;
+	}
+
+	/* Insert an existent key */
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(udevd_name), 0, &key);
+	err = bpf_dynptr_write(&key, 0, (void *)udevd_name, sizeof(udevd_name), 0);
+	if (err) {
+		bpf_ringbuf_discard_dynptr(&key, 0);
+		err = 5;
+		goto out;
+	}
+
+	err = bpf_map_update_elem(htab, &key, &new_value, BPF_NOEXIST);
+	bpf_ringbuf_discard_dynptr(&key, 0);
+	if (err != -EEXIST) {
+		err = 6;
+		goto out;
+	}
+
+	/* Lookup it again */
+	bpf_dynptr_from_mem(dynptr_buf[0], sizeof(udevd_name), 0, &key);
+	value = bpf_map_lookup_elem(htab, &key);
+	if (!value) {
+		err = 7;
+		goto out;
+	}
+	if (*value != 42) {
+		err = 8;
+		goto out;
+	}
+
+	/* Delete then lookup it */
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(udevd_name), 0, &key);
+	err = bpf_dynptr_write(&key, 0, (void *)udevd_name, sizeof(udevd_name), 0);
+	if (err) {
+		bpf_ringbuf_discard_dynptr(&key, 0);
+		err = 9;
+		goto out;
+	}
+	err = bpf_map_delete_elem(htab, &key);
+	bpf_ringbuf_discard_dynptr(&key, 0);
+	if (err) {
+		err = 10;
+		goto out;
+	}
+
+	bpf_dynptr_from_mem(dynptr_buf[0], sizeof(udevd_name), 0, &key);
+	value = bpf_map_lookup_elem(htab, &key);
+	if (value) {
+		err = 10;
+		goto out;
+	}
+out:
+	return err;
+}
+
+static int test_mixed_dynptr_key_htab(struct bpf_map *htab)
+{
+	unsigned long new_value, *value;
+	char udevd_name[] = "udevd";
+	struct mixed_dynptr_key key;
+	int err = 0;
+
+	__builtin_memset(&key, 0, sizeof(key));
+	key.id = 1000;
+
+	/* Lookup a existent key */
+	__builtin_memcpy(dynptr_buf[0], systemd_name, sizeof(systemd_name));
+	bpf_dynptr_from_mem(dynptr_buf[0], sizeof(systemd_name), 0, &key.name);
+	value = bpf_map_lookup_elem(htab, &key);
+	if (!value) {
+		err = 1;
+		goto out;
+	}
+	if (*value != 100) {
+		err = 2;
+		goto out;
+	}
+
+	/* Look up a non-existent key */
+	__builtin_memcpy(dynptr_buf[0], udevd_name, sizeof(udevd_name));
+	bpf_dynptr_from_mem(dynptr_buf[0], sizeof(udevd_name), 0, &key.name);
+	value = bpf_map_lookup_elem(htab, &key);
+	if (value) {
+		err = 3;
+		goto out;
+	}
+
+	/* Insert a new key */
+	new_value = 42;
+	err = bpf_map_update_elem(htab, &key, &new_value, BPF_NOEXIST);
+	if (err) {
+		err = 4;
+		goto out;
+	}
+
+	/* Insert an existent key */
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(udevd_name), 0, &key.name);
+	err = bpf_dynptr_write(&key.name, 0, (void *)udevd_name, sizeof(udevd_name), 0);
+	if (err) {
+		bpf_ringbuf_discard_dynptr(&key.name, 0);
+		err = 5;
+		goto out;
+	}
+
+	err = bpf_map_update_elem(htab, &key, &new_value, BPF_NOEXIST);
+	bpf_ringbuf_discard_dynptr(&key.name, 0);
+	if (err != -EEXIST) {
+		err = 6;
+		goto out;
+	}
+
+	/* Lookup it again */
+	bpf_dynptr_from_mem(dynptr_buf[0], sizeof(udevd_name), 0, &key.name);
+	value = bpf_map_lookup_elem(htab, &key);
+	if (!value) {
+		err = 7;
+		goto out;
+	}
+	if (*value != 42) {
+		err = 8;
+		goto out;
+	}
+
+	/* Delete then lookup it */
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(udevd_name), 0, &key.name);
+	err = bpf_dynptr_write(&key.name, 0, (void *)udevd_name, sizeof(udevd_name), 0);
+	if (err) {
+		bpf_ringbuf_discard_dynptr(&key.name, 0);
+		err = 9;
+		goto out;
+	}
+	err = bpf_map_delete_elem(htab, &key);
+	bpf_ringbuf_discard_dynptr(&key.name, 0);
+	if (err) {
+		err = 10;
+		goto out;
+	}
+
+	bpf_dynptr_from_mem(dynptr_buf[0], sizeof(udevd_name), 0, &key.name);
+	value = bpf_map_lookup_elem(htab, &key);
+	if (value) {
+		err = 10;
+		goto out;
+	}
+out:
+	return err;
+}
+
+static int test_multiple_dynptr_key_htab(struct bpf_map *htab)
+{
+	unsigned long new_value, *value;
+	struct multiple_dynptr_key key;
+	int err = 0;
+
+	__builtin_memset(&key, 0, sizeof(key));
+	key.f_2 = 2;
+	key.f_3.id = 3;
+	key.f_4 = 4;
+
+	/* Lookup a existent key */
+	__builtin_memcpy(dynptr_buf[0], systemd_name, sizeof(systemd_name));
+	bpf_dynptr_from_mem(dynptr_buf[0], sizeof(systemd_name), 0, &key.f_1.name);
+	__builtin_memcpy(dynptr_buf[1], rcu_sched_name, sizeof(rcu_sched_name));
+	bpf_dynptr_from_mem(dynptr_buf[1], sizeof(rcu_sched_name), 0, &key.f_3.name);
+	value = bpf_map_lookup_elem(htab, &key);
+	if (!value) {
+		err = 1;
+		goto out;
+	}
+	if (*value != 100) {
+		err = 2;
+		goto out;
+	}
+
+	/* Look up a non-existent key */
+	bpf_dynptr_from_mem(dynptr_buf[1], sizeof(rcu_sched_name), 0, &key.f_1.name);
+	bpf_dynptr_from_mem(dynptr_buf[0], sizeof(systemd_name), 0, &key.f_3.name);
+	value = bpf_map_lookup_elem(htab, &key);
+	if (value) {
+		err = 3;
+		goto out;
+	}
+
+	/* Insert a new key */
+	new_value = 42;
+	err = bpf_map_update_elem(htab, &key, &new_value, BPF_NOEXIST);
+	if (err) {
+		err = 4;
+		goto out;
+	}
+
+	/* Insert an existent key */
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(rcu_sched_name), 0, &key.f_1.name);
+	err = bpf_dynptr_write(&key.f_1.name, 0, (void *)rcu_sched_name, sizeof(rcu_sched_name), 0);
+	if (err) {
+		bpf_ringbuf_discard_dynptr(&key.f_1.name, 0);
+		err = 5;
+		goto out;
+	}
+	err = bpf_map_update_elem(htab, &key, &new_value, BPF_NOEXIST);
+	bpf_ringbuf_discard_dynptr(&key.f_1.name, 0);
+	if (err != -EEXIST) {
+		err = 6;
+		goto out;
+	}
+
+	/* Lookup a non-existent key */
+	bpf_dynptr_from_mem(dynptr_buf[1], sizeof(rcu_sched_name), 0, &key.f_1.name);
+	key.f_4 = 0;
+	value = bpf_map_lookup_elem(htab, &key);
+	if (value) {
+		err = 7;
+		goto out;
+	}
+
+	/* Lookup an existent key */
+	key.f_4 = 4;
+	value = bpf_map_lookup_elem(htab, &key);
+	if (!value) {
+		err = 8;
+		goto out;
+	}
+	if (*value != 42) {
+		err = 9;
+		goto out;
+	}
+
+	/* Delete the newly-inserted key */
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(systemd_name), 0, &key.f_3.name);
+	err = bpf_dynptr_write(&key.f_3.name, 0, (void *)systemd_name, sizeof(systemd_name), 0);
+	if (err) {
+		bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
+		err = 10;
+		goto out;
+	}
+	err = bpf_map_delete_elem(htab, &key);
+	if (err) {
+		bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
+		err = 11;
+		goto out;
+	}
+
+	/* Lookup it again */
+	value = bpf_map_lookup_elem(htab, &key);
+	bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
+	if (value) {
+		err = 12;
+		goto out;
+	}
+out:
+	return err;
+}
+
+SEC("?raw_tp")
+int BPF_PROG(pure_dynptr_key)
+{
+	int err;
+
+	err = test_pure_dynptr_key_htab((struct bpf_map *)&htab_1);
+	err |= test_pure_dynptr_key_htab((struct bpf_map *)&htab_2) << 8;
+
+	return err;
+}
+
+SEC("?raw_tp")
+int BPF_PROG(mixed_dynptr_key)
+{
+	return test_mixed_dynptr_key_htab((struct bpf_map *)&htab_3);
+}
+
+SEC("?raw_tp")
+int BPF_PROG(multiple_dynptr_key)
+{
+	return test_multiple_dynptr_key_htab((struct bpf_map *)&htab_4);
+}
-- 
2.29.2


