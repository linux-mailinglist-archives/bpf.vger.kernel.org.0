Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C0526EA4
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 21:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbfEVTvL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 15:51:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35350 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732163AbfEVTvK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 May 2019 15:51:10 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MJibA1020018
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 12:51:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=6IkGN47itqvsDgU54e9J/eyqJ7CWK9rhsQzcXCsnF8Q=;
 b=iOrUwu/7/bG+qx0bYM/CSRudK4CZbYqqiuhkOngbEUQ/5nzKxDH+nnVYwM4fDwwA7r32
 7JIUll3OZNhMI1J/dUtDjmXOmlMwIXSe8OOblf4Kwgzp9Vu18J1u/23hGG9JM+G7awk0
 622uW23Jq73VqkmvtWU8CLAovvhmtt7SjJw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sncpwr1u2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 12:51:08 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 22 May 2019 12:51:08 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 4B4E7862334; Wed, 22 May 2019 12:51:07 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 06/12] selftests/bpf: add tests for libbpf's hashmap
Date:   Wed, 22 May 2019 12:50:47 -0700
Message-ID: <20190522195053.4017624-7-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522195053.4017624-1-andriin@fb.com>
References: <20190522195053.4017624-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220138
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test all APIs for internal hashmap implementation.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/.gitignore     |   1 +
 tools/testing/selftests/bpf/Makefile       |   2 +-
 tools/testing/selftests/bpf/test_hashmap.c | 382 +++++++++++++++++++++
 3 files changed, 384 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/test_hashmap.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index dd5d69529382..138b6c063916 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -35,3 +35,4 @@ test_sysctl
 alu32
 libbpf.pc
 libbpf.so.*
+test_hashmap
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 66f2dca1dee1..ddae06498a00 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -23,7 +23,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
 	test_socket_cookie test_cgroup_storage test_select_reuseport test_section_names \
-	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl
+	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl test_hashmap
 
 BPF_OBJ_FILES = $(patsubst %.c,%.o, $(notdir $(wildcard progs/*.c)))
 TEST_GEN_FILES = $(BPF_OBJ_FILES)
diff --git a/tools/testing/selftests/bpf/test_hashmap.c b/tools/testing/selftests/bpf/test_hashmap.c
new file mode 100644
index 000000000000..b64094c981e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_hashmap.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+/*
+ * Tests for libbpf's hashmap.
+ *
+ * Copyright (c) 2019 Facebook
+ */
+#include <stdio.h>
+#include <errno.h>
+#include <linux/err.h>
+#include "hashmap.h"
+
+#define CHECK(condition, format...) ({					\
+	int __ret = !!(condition);					\
+	if (__ret) {							\
+		fprintf(stderr, "%s:%d:FAIL ", __func__, __LINE__);	\
+		fprintf(stderr, format);				\
+	}								\
+	__ret;								\
+})
+
+size_t hash_fn(const void *k, void *ctx)
+{
+	return (long)k;
+}
+
+bool equal_fn(const void *a, const void *b, void *ctx)
+{
+	return (long)a == (long)b;
+}
+
+static inline size_t next_pow_2(size_t n)
+{
+	size_t r = 1;
+
+	while (r < n)
+		r <<= 1;
+	return r;
+}
+
+static inline size_t exp_cap(size_t sz)
+{
+	size_t r = next_pow_2(sz);
+
+	if (sz * 4 / 3 > r)
+		r <<= 1;
+	return r;
+}
+
+#define ELEM_CNT 62
+
+int test_hashmap_generic(void)
+{
+	struct hashmap_entry *entry, *tmp;
+	int err, bkt, found_cnt, i;
+	long long found_msk;
+	struct hashmap *map;
+
+	fprintf(stderr, "%s: ", __func__);
+
+	map = hashmap__new(hash_fn, equal_fn, NULL);
+	if (CHECK(IS_ERR(map), "failed to create map: %ld\n", PTR_ERR(map)))
+		return 1;
+
+	for (i = 0; i < ELEM_CNT; i++) {
+		const void *oldk, *k = (const void *)(long)i;
+		void *oldv, *v = (void *)(long)(1024 + i);
+
+		err = hashmap__update(map, k, v, &oldk, &oldv);
+		if (CHECK(err != -ENOENT, "unexpected result: %d\n", err))
+			return 1;
+
+		if (i % 2) {
+			err = hashmap__add(map, k, v);
+		} else {
+			err = hashmap__set(map, k, v, &oldk, &oldv);
+			if (CHECK(oldk != NULL || oldv != NULL,
+				  "unexpected k/v: %p=%p\n", oldk, oldv))
+				return 1;
+		}
+
+		if (CHECK(err, "failed to add k/v %ld = %ld: %d\n",
+			       (long)k, (long)v, err))
+			return 1;
+
+		if (CHECK(!hashmap__find(map, k, &oldv),
+			  "failed to find key %ld\n", (long)k))
+			return 1;
+		if (CHECK(oldv != v, "found value is wrong: %ld\n", (long)oldv))
+			return 1;
+	}
+
+	if (CHECK(hashmap__size(map) != ELEM_CNT,
+		  "invalid map size: %zu\n", hashmap__size(map)))
+		return 1;
+	if (CHECK(hashmap__capacity(map) != exp_cap(hashmap__size(map)),
+		  "unexpected map capacity: %zu\n", hashmap__capacity(map)))
+		return 1;
+
+	found_msk = 0;
+	hashmap__for_each_entry(map, entry, bkt) {
+		long k = (long)entry->key;
+		long v = (long)entry->value;
+
+		found_msk |= 1ULL << k;
+		if (CHECK(v - k != 1024, "invalid k/v pair: %ld = %ld\n", k, v))
+			return 1;
+	}
+	if (CHECK(found_msk != (1ULL << ELEM_CNT) - 1,
+		  "not all keys iterated: %llx\n", found_msk))
+		return 1;
+
+	for (i = 0; i < ELEM_CNT; i++) {
+		const void *oldk, *k = (const void *)(long)i;
+		void *oldv, *v = (void *)(long)(256 + i);
+
+		err = hashmap__add(map, k, v);
+		if (CHECK(err != -EEXIST, "unexpected add result: %d\n", err))
+			return 1;
+
+		if (i % 2)
+			err = hashmap__update(map, k, v, &oldk, &oldv);
+		else
+			err = hashmap__set(map, k, v, &oldk, &oldv);
+
+		if (CHECK(err, "failed to update k/v %ld = %ld: %d\n",
+			       (long)k, (long)v, err))
+			return 1;
+		if (CHECK(!hashmap__find(map, k, &oldv),
+			  "failed to find key %ld\n", (long)k))
+			return 1;
+		if (CHECK(oldv != v, "found value is wrong: %ld\n", (long)oldv))
+			return 1;
+	}
+
+	if (CHECK(hashmap__size(map) != ELEM_CNT,
+		  "invalid updated map size: %zu\n", hashmap__size(map)))
+		return 1;
+	if (CHECK(hashmap__capacity(map) != exp_cap(hashmap__size(map)),
+		  "unexpected map capacity: %zu\n", hashmap__capacity(map)))
+		return 1;
+
+	found_msk = 0;
+	hashmap__for_each_entry_safe(map, entry, tmp, bkt) {
+		long k = (long)entry->key;
+		long v = (long)entry->value;
+
+		found_msk |= 1ULL << k;
+		if (CHECK(v - k != 256,
+			  "invalid updated k/v pair: %ld = %ld\n", k, v))
+			return 1;
+	}
+	if (CHECK(found_msk != (1ULL << ELEM_CNT) - 1,
+		  "not all keys iterated after update: %llx\n", found_msk))
+		return 1;
+
+	found_cnt = 0;
+	hashmap__for_each_key_entry(map, entry, (void *)0) {
+		found_cnt++;
+	}
+	if (CHECK(!found_cnt, "didn't find any entries for key 0\n"))
+		return 1;
+
+	found_msk = 0;
+	found_cnt = 0;
+	hashmap__for_each_key_entry_safe(map, entry, tmp, (void *)0) {
+		const void *oldk, *k;
+		void *oldv, *v;
+
+		k = entry->key;
+		v = entry->value;
+
+		found_cnt++;
+		found_msk |= 1ULL << (long)k;
+
+		if (CHECK(!hashmap__delete(map, k, &oldk, &oldv),
+			  "failed to delete k/v %ld = %ld\n",
+			  (long)k, (long)v))
+			return 1;
+		if (CHECK(oldk != k || oldv != v,
+			  "invalid deleted k/v: expected %ld = %ld, got %ld = %ld\n",
+			  (long)k, (long)v, (long)oldk, (long)oldv))
+			return 1;
+		if (CHECK(hashmap__delete(map, k, &oldk, &oldv),
+			  "unexpectedly deleted k/v %ld = %ld\n",
+			  (long)oldk, (long)oldv))
+			return 1;
+	}
+
+	if (CHECK(!found_cnt || !found_msk,
+		  "didn't delete any key entries\n"))
+		return 1;
+	if (CHECK(hashmap__size(map) != ELEM_CNT - found_cnt,
+		  "invalid updated map size (already deleted: %d): %zu\n",
+		  found_cnt, hashmap__size(map)))
+		return 1;
+	if (CHECK(hashmap__capacity(map) != exp_cap(hashmap__size(map)),
+		  "unexpected map capacity: %zu\n", hashmap__capacity(map)))
+		return 1;
+
+	hashmap__for_each_entry_safe(map, entry, tmp, bkt) {
+		const void *oldk, *k;
+		void *oldv, *v;
+
+		k = entry->key;
+		v = entry->value;
+
+		found_cnt++;
+		found_msk |= 1ULL << (long)k;
+
+		if (CHECK(!hashmap__delete(map, k, &oldk, &oldv),
+			  "failed to delete k/v %ld = %ld\n",
+			  (long)k, (long)v))
+			return 1;
+		if (CHECK(oldk != k || oldv != v,
+			  "invalid old k/v: expect %ld = %ld, got %ld = %ld\n",
+			  (long)k, (long)v, (long)oldk, (long)oldv))
+			return 1;
+		if (CHECK(hashmap__delete(map, k, &oldk, &oldv),
+			  "unexpectedly deleted k/v %ld = %ld\n",
+			  (long)k, (long)v))
+			return 1;
+	}
+
+	if (CHECK(found_cnt != ELEM_CNT || found_msk != (1ULL << ELEM_CNT) - 1,
+		  "not all keys were deleted: found_cnt:%d, found_msk:%llx\n",
+		  found_cnt, found_msk))
+		return 1;
+	if (CHECK(hashmap__size(map) != 0,
+		  "invalid updated map size (already deleted: %d): %zu\n",
+		  found_cnt, hashmap__size(map)))
+		return 1;
+
+	found_cnt = 0;
+	hashmap__for_each_entry(map, entry, bkt) {
+		CHECK(false, "unexpected map entries left: %ld = %ld\n",
+			     (long)entry->key, (long)entry->value);
+		return 1;
+	}
+
+	hashmap__free(map);
+	hashmap__for_each_entry(map, entry, bkt) {
+		CHECK(false, "unexpected map entries left: %ld = %ld\n",
+			     (long)entry->key, (long)entry->value);
+		return 1;
+	}
+
+	fprintf(stderr, "OK\n");
+	return 0;
+}
+
+size_t collision_hash_fn(const void *k, void *ctx)
+{
+	return 0;
+}
+
+int test_hashmap_multimap(void)
+{
+	void *k1 = (void *)0, *k2 = (void *)1;
+	struct hashmap_entry *entry;
+	struct hashmap *map;
+	long found_msk;
+	int err, bkt;
+
+	fprintf(stderr, "%s: ", __func__);
+
+	/* force collisions */
+	map = hashmap__new(collision_hash_fn, equal_fn, NULL);
+	if (CHECK(IS_ERR(map), "failed to create map: %ld\n", PTR_ERR(map)))
+		return 1;
+
+
+	/* set up multimap:
+	 * [0] -> 1, 2, 4;
+	 * [1] -> 8, 16, 32;
+	 */
+	err = hashmap__append(map, k1, (void *)1);
+	if (CHECK(err, "failed to add k/v: %d\n", err))
+		return 1;
+	err = hashmap__append(map, k1, (void *)2);
+	if (CHECK(err, "failed to add k/v: %d\n", err))
+		return 1;
+	err = hashmap__append(map, k1, (void *)4);
+	if (CHECK(err, "failed to add k/v: %d\n", err))
+		return 1;
+
+	err = hashmap__append(map, k2, (void *)8);
+	if (CHECK(err, "failed to add k/v: %d\n", err))
+		return 1;
+	err = hashmap__append(map, k2, (void *)16);
+	if (CHECK(err, "failed to add k/v: %d\n", err))
+		return 1;
+	err = hashmap__append(map, k2, (void *)32);
+	if (CHECK(err, "failed to add k/v: %d\n", err))
+		return 1;
+
+	if (CHECK(hashmap__size(map) != 6,
+		  "invalid map size: %zu\n", hashmap__size(map)))
+		return 1;
+
+	/* verify global iteration still works and sees all values */
+	found_msk = 0;
+	hashmap__for_each_entry(map, entry, bkt) {
+		found_msk |= (long)entry->value;
+	}
+	if (CHECK(found_msk != (1 << 6) - 1,
+		  "not all keys iterated: %lx\n", found_msk))
+		return 1;
+
+	/* iterate values for key 1 */
+	found_msk = 0;
+	hashmap__for_each_key_entry(map, entry, k1) {
+		found_msk |= (long)entry->value;
+	}
+	if (CHECK(found_msk != (1 | 2 | 4),
+		  "invalid k1 values: %lx\n", found_msk))
+		return 1;
+
+	/* iterate values for key 2 */
+	found_msk = 0;
+	hashmap__for_each_key_entry(map, entry, k2) {
+		found_msk |= (long)entry->value;
+	}
+	if (CHECK(found_msk != (8 | 16 | 32),
+		  "invalid k2 values: %lx\n", found_msk))
+		return 1;
+
+	fprintf(stderr, "OK\n");
+	return 0;
+}
+
+int test_hashmap_empty()
+{
+	struct hashmap_entry *entry;
+	int bkt;
+	struct hashmap *map;
+	void *k = (void *)0;
+
+	fprintf(stderr, "%s: ", __func__);
+
+	/* force collisions */
+	map = hashmap__new(hash_fn, equal_fn, NULL);
+	if (CHECK(IS_ERR(map), "failed to create map: %ld\n", PTR_ERR(map)))
+		return 1;
+
+	if (CHECK(hashmap__size(map) != 0,
+		  "invalid map size: %zu\n", hashmap__size(map)))
+		return 1;
+	if (CHECK(hashmap__capacity(map) != 0,
+		  "invalid map capacity: %zu\n", hashmap__capacity(map)))
+		return 1;
+	if (CHECK(hashmap__find(map, k, NULL), "unexpected find\n"))
+		return 1;
+	if (CHECK(hashmap__delete(map, k, NULL, NULL), "unexpected delete\n"))
+		return 1;
+
+	hashmap__for_each_entry(map, entry, bkt) {
+		CHECK(false, "unexpected iterated entry\n");
+		return 1;
+	}
+	hashmap__for_each_key_entry(map, entry, k) {
+		CHECK(false, "unexpected key entry\n");
+		return 1;
+	}
+
+	fprintf(stderr, "OK\n");
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	bool failed = false;
+
+	if (test_hashmap_generic())
+		failed = true;
+	if (test_hashmap_multimap())
+		failed = true;
+	if (test_hashmap_empty())
+		failed = true;
+
+	return failed;
+}
-- 
2.17.1

