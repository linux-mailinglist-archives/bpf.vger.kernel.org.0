Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6963737BC
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 11:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhEEJmo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 05:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhEEJmm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 05:42:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76492C061574
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 02:41:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id m12so1855799eja.2
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 02:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zs4y+LeKvSn0Za+0kviL18vgXo7KIBo+wHC5tjuNTKM=;
        b=XAru8KmqXg0b0TqoMJWReQLKwf4P7JOY5wRDLOa441AnINseGAaw5ptsrE27W5XDcd
         qXUsfXsnKADdLqe9j0umaOGx7lDSCwfOX6VjkUpa+RB0NowjPE6GO/6Dr42LvFfQx1gh
         epl/tOly7jcs4n6zaY6fK3YnAyCz8ZqSmMyVkhQCjpn/9haybCOdkK0TIrgVj2O79i5S
         YBiCeulW2djs1htwFNG8lW/ZjswhsujN/yvogUPfhEesWGUMrRkkTwPKjFHqWkpjLS7H
         r4VcPKIXg1wSgWFh7ACCiwP9XHOBYGP02409vszJpDsxaRi2PMoTAeIzmVKQJZnbEwOx
         iTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zs4y+LeKvSn0Za+0kviL18vgXo7KIBo+wHC5tjuNTKM=;
        b=tDlLEKE1eeKWk3drqcvWKOIioX89lJ6oQWhMGauwzKwO/4Whf6XiOKmexMedR6TTD8
         qXx3gwpmMsW0X2hkRVbdWbYNapddXnA/7csK4yR/FclI5ZnSCKyMp4AxPdh0f0LlGzWi
         m+krIdZ/tnQwnk5sepcmORgRSAWTJs9wnzIvEzhq7L9arzpxqNMIZibxtIzUPSpgimdI
         TB3dfGMqJHlm0PefpyWbItzhgQCvyYuzni0nV2zQN8cXYbhXwXePrqqOTVshyG1KFFSm
         9m+f8Q91ZtCcoYa52AjkqVliUhR7aDUZdokBC02sO5umbu6UVppBUG0rhXupU4V/8A80
         dLmA==
X-Gm-Message-State: AOAM5320dcihFHFJrDu3W8qjdmMHvMgnvA7p4Hosbu2OX1lHCR0We+XY
        9v9r34szm2iA4HvtxHdbr8UY2FnaW1tJV+nML48rLHAplESzeqYeKmmuOcx+YSXRPaQIH53Fs9N
        2+XSAxxz9f4Ul9oCD6xZrDxBIB6am6Zlkep2Kp+nlt2RAEptCaEvNdjwUlEOwIITHYhmkmUX9
X-Google-Smtp-Source: ABdhPJzPPWPekDi0xoDXLvY48VVjM5itBl4cFbS/Ldk2PirINQ9D5DtH3LsZhF23eToSsbHm0008MA==
X-Received: by 2002:a17:906:63d2:: with SMTP id u18mr19079493ejk.186.1620207704126;
        Wed, 05 May 2021 02:41:44 -0700 (PDT)
Received: from localhost.localdomain (93-136-23-177.adsl.net.t-com.hr. [93.136.23.177])
        by smtp.gmail.com with ESMTPSA id e12sm2599975ejk.99.2021.05.05.02.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 02:41:43 -0700 (PDT)
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     bpf@vger.kernel.org
Cc:     Denis Salopek <denis.salopek@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 3/3] add bpf_lookup_and_delete_elem tests
Date:   Wed,  5 May 2021 11:40:28 +0200
Message-Id: <20210505094028.22079-3-denis.salopek@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210505094028.22079-1-denis.salopek@sartura.hr>
References: <20210505094028.22079-1-denis.salopek@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf selftests and extend existing ones for a new function
bpf_lookup_and_delete_elem() for (percpu) hash and (percpu) LRU hash map
types.
In test_lru_map and test_maps we add an element, lookup_and_delete it,
then check whether it's deleted.
The newly added lookup_and_delete prog tests practically do the same
thing but additionally use a BPF program to change the value of the
element for LRU maps.

Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Yonghong Song <yhs@fb.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
---
v5: Use more appropriate macros. Better check for changed value.
v6: Remove PERCPU macros, add ASSERT_GE macro to test_progs.h, remove
leftover code.
---
 .../bpf/prog_tests/lookup_and_delete.c        | 288 ++++++++++++++++++
 .../bpf/progs/test_lookup_and_delete.c        |  26 ++
 tools/testing/selftests/bpf/test_lru_map.c    |   8 +
 tools/testing/selftests/bpf/test_maps.c       |  17 ++
 tools/testing/selftests/bpf/test_progs.h      |  11 +
 5 files changed, 350 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
new file mode 100644
index 000000000000..b36befd37384
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <test_progs.h>
+#include "test_lookup_and_delete.skel.h"
+
+#define START_VALUE 1234
+#define NEW_VALUE 4321
+#define MAX_ENTRIES 2
+
+static int duration;
+static int nr_cpus;
+
+static int fill_values(int map_fd)
+{
+	__u64 key, value = START_VALUE;
+	int err;
+
+	for (key = 1; key < MAX_ENTRIES + 1; key++) {
+		err = bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			return -1;
+	}
+
+	return 0;
+}
+
+static int fill_values_percpu(int map_fd)
+{
+	__u64 key, value[nr_cpus];
+	int i, err;
+
+	for (i = 0; i < nr_cpus; i++)
+		value[i] = START_VALUE;
+
+	for (key = 1; key < MAX_ENTRIES + 1; key++) {
+		err = bpf_map_update_elem(map_fd, &key, value, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			return -1;
+	}
+
+	return 0;
+}
+
+static struct test_lookup_and_delete *setup_prog(enum bpf_map_type map_type,
+						 int *map_fd)
+{
+	struct test_lookup_and_delete *skel;
+	int err;
+
+	skel = test_lookup_and_delete__open();
+	if (!ASSERT_OK(!skel, "test_lookup_and_delete__open"))
+		return NULL;
+
+	err = bpf_map__set_type(skel->maps.hash_map, map_type);
+	if (!ASSERT_OK(err, "bpf_map__set_type"))
+		goto cleanup;
+
+	err = bpf_map__set_max_entries(skel->maps.hash_map, MAX_ENTRIES);
+	if (!ASSERT_OK(err, "bpf_map__set_max_entries"))
+		goto cleanup;
+
+	err = test_lookup_and_delete__load(skel);
+	if (!ASSERT_OK(err, "test_lookup_and_delete__load"))
+		goto cleanup;
+
+	*map_fd = bpf_map__fd(skel->maps.hash_map);
+	if (!ASSERT_GE(*map_fd, 0, "bpf_map__fd"))
+		goto cleanup;
+
+	return skel;
+
+cleanup:
+	test_lookup_and_delete__destroy(skel);
+	return NULL;
+}
+
+/* Triggers BPF program that updates map with given key and value */
+static int trigger_tp(struct test_lookup_and_delete *skel, __u64 key,
+		      __u64 value)
+{
+	int err;
+
+	skel->bss->set_pid = getpid();
+	skel->bss->set_key = key;
+	skel->bss->set_value = value;
+
+	err = test_lookup_and_delete__attach(skel);
+	if (!ASSERT_OK(err, "test_lookup_and_delete__attach"))
+		return -1;
+
+	syscall(__NR_getpgid);
+
+	test_lookup_and_delete__detach(skel);
+
+	return 0;
+}
+
+static void test_lookup_and_delete_hash(void)
+{
+	struct test_lookup_and_delete *skel;
+	__u64 key, value;
+	int map_fd, err;
+
+	/* Setup program and fill the map. */
+	skel = setup_prog(BPF_MAP_TYPE_HASH, &map_fd);
+	if (!ASSERT_OK_PTR(skel, "setup_prog"))
+		return;
+
+	err = fill_values(map_fd);
+	if (!ASSERT_OK(err, "fill_values"))
+		goto cleanup;
+
+	/* Lookup and delete element. */
+	key = 1;
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
+		goto cleanup;
+
+	/* Fetched value should match the initially set value. */
+	if (CHECK(value != START_VALUE, "bpf_map_lookup_and_delete_elem",
+		  "unexpected value=%lld\n", value))
+		goto cleanup;
+
+	/* Check that the entry is non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+cleanup:
+	test_lookup_and_delete__destroy(skel);
+}
+
+static void test_lookup_and_delete_percpu_hash(void)
+{
+	struct test_lookup_and_delete *skel;
+	__u64 key, val, value[nr_cpus];
+	int map_fd, err, i;
+
+	/* Setup program and fill the map. */
+	skel = setup_prog(BPF_MAP_TYPE_PERCPU_HASH, &map_fd);
+	if (!ASSERT_OK_PTR(skel, "setup_prog"))
+		return;
+
+	err = fill_values_percpu(map_fd);
+	if (!ASSERT_OK(err, "fill_values_percpu"))
+		goto cleanup;
+
+	/* Lookup and delete element. */
+	key = 1;
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
+		goto cleanup;
+
+	for (i = 0; i < nr_cpus; i++) {
+		val = value[i];
+
+		/* Fetched value should match the initially set value. */
+		if (CHECK(val != START_VALUE, "map value",
+			  "unexpected for cpu %d: %lld\n", i, val))
+			goto cleanup;
+	}
+
+	/* Check that the entry is non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, value);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+cleanup:
+	test_lookup_and_delete__destroy(skel);
+}
+
+static void test_lookup_and_delete_lru_hash(void)
+{
+	struct test_lookup_and_delete *skel;
+	__u64 key, value;
+	int map_fd, err;
+
+	/* Setup program and fill the LRU map. */
+	skel = setup_prog(BPF_MAP_TYPE_LRU_HASH, &map_fd);
+	if (!ASSERT_OK_PTR(skel, "setup_prog"))
+		return;
+
+	err = fill_values(map_fd);
+	if (!ASSERT_OK(err, "fill_values"))
+		goto cleanup;
+
+	/* Insert new element at key=3, should reuse LRU element. */
+	key = 3;
+	err = trigger_tp(skel, key, NEW_VALUE);
+	if (!ASSERT_OK(err, "trigger_tp"))
+		goto cleanup;
+
+	/* Lookup and delete element 3. */
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
+		goto cleanup;
+
+	/* Value should match the new value. */
+	if (CHECK(value != NEW_VALUE, "bpf_map_lookup_and_delete_elem",
+		  "unexpected value=%lld\n", value))
+		goto cleanup;
+
+	/* Check that entries 3 and 1 are non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+	key = 1;
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+cleanup:
+	test_lookup_and_delete__destroy(skel);
+}
+
+static void test_lookup_and_delete_lru_percpu_hash(void)
+{
+	struct test_lookup_and_delete *skel;
+	__u64 key, val, value[nr_cpus];
+	int map_fd, err, i, cpucnt = 0;
+
+	/* Setup program and fill the LRU map. */
+	skel = setup_prog(BPF_MAP_TYPE_LRU_PERCPU_HASH, &map_fd);
+	if (!ASSERT_OK_PTR(skel, "setup_prog"))
+		return;
+
+	err = fill_values_percpu(map_fd);
+	if (!ASSERT_OK(err, "fill_values_percpu"))
+		goto cleanup;
+
+	/* Insert new element at key=3, should reuse LRU element 1. */
+	key = 3;
+	err = trigger_tp(skel, key, NEW_VALUE);
+	if (!ASSERT_OK(err, "trigger_tp"))
+		goto cleanup;
+
+	/* Clean value. */
+	for (i = 0; i < nr_cpus; i++)
+		value[i] = 0;
+
+	/* Lookup and delete element 3. */
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem")) {
+		goto cleanup;
+	}
+
+	/* Check if only one CPU has set the value. */
+	for (i = 0; i < nr_cpus; i++) {
+		val = value[i];
+		if (val) {
+			if (CHECK(val != NEW_VALUE, "map value",
+				  "unexpected for cpu %d: %lld\n", i, val))
+				goto cleanup;
+			cpucnt++;
+		}
+	}
+	if (CHECK(cpucnt != 1, "map value", "set for %d CPUs instead of 1!\n",
+		  cpucnt))
+		goto cleanup;
+
+	/* Check that entries 3 and 1 are non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+	key = 1;
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+cleanup:
+	test_lookup_and_delete__destroy(skel);
+}
+
+void test_lookup_and_delete(void)
+{
+	nr_cpus = bpf_num_possible_cpus();
+
+	if (test__start_subtest("lookup_and_delete"))
+		test_lookup_and_delete_hash();
+	if (test__start_subtest("lookup_and_delete_percpu"))
+		test_lookup_and_delete_percpu_hash();
+	if (test__start_subtest("lookup_and_delete_lru"))
+		test_lookup_and_delete_lru_hash();
+	if (test__start_subtest("lookup_and_delete_lru_percpu"))
+		test_lookup_and_delete_lru_percpu_hash();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
new file mode 100644
index 000000000000..3a193f42c7e7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+__u32 set_pid = 0;
+__u64 set_key = 0;
+__u64 set_value = 0;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 2);
+	__type(key, __u64);
+	__type(value, __u64);
+} hash_map SEC(".maps");
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int bpf_lookup_and_delete_test(const void *ctx)
+{
+	if (set_pid == bpf_get_current_pid_tgid() >> 32)
+		bpf_map_update_elem(&hash_map, &set_key, &set_value, BPF_NOEXIST);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 6a5349f9eb14..7e9049fa3edf 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -231,6 +231,14 @@ static void test_lru_sanity0(int map_type, int map_flags)
 	assert(bpf_map_lookup_elem(lru_map_fd, &key, value) == -1 &&
 	       errno == ENOENT);
 
+	/* lookup elem key=1 and delete it, then check it doesn't exist */
+	key = 1;
+	assert(!bpf_map_lookup_and_delete_elem(lru_map_fd, &key, &value));
+	assert(value[0] == 1234);
+
+	/* remove the same element from the expected map */
+	assert(!bpf_map_delete_elem(expected_map_fd, &key));
+
 	assert(map_equal(lru_map_fd, expected_map_fd));
 
 	close(expected_map_fd);
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 51adc42b2b40..8410a730c82f 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -65,6 +65,13 @@ static void test_hashmap(unsigned int task, void *data)
 	assert(bpf_map_lookup_elem(fd, &key, &value) == 0 && value == 1234);
 
 	key = 2;
+	value = 1234;
+	/* Insert key=2 element. */
+	assert(bpf_map_update_elem(fd, &key, &value, BPF_ANY) == 0);
+
+	/* Check that key=2 matches the value and delete it */
+	assert(bpf_map_lookup_and_delete_elem(fd, &key, &value) == 0 && value == 1234);
+
 	/* Check that key=2 is not found. */
 	assert(bpf_map_lookup_elem(fd, &key, &value) == -1 && errno == ENOENT);
 
@@ -166,6 +173,16 @@ static void test_hashmap_percpu(unsigned int task, void *data)
 	/* Insert key=1 element. */
 	assert(!(expected_key_mask & key));
 	assert(bpf_map_update_elem(fd, &key, value, BPF_ANY) == 0);
+
+	/* Lookup and delete elem key=1 and check value. */
+	assert(bpf_map_lookup_and_delete_elem(fd, &key, value) == 0 &&
+	       bpf_percpu(value,0) == 100);
+
+	for (i = 0; i < nr_cpus; i++)
+		bpf_percpu(value,i) = i + 100;
+
+	/* Insert key=1 element which should not exist. */
+	assert(bpf_map_update_elem(fd, &key, value, BPF_NOEXIST) == 0);
 	expected_key_mask |= key;
 
 	/* BPF_NOEXIST means add new element if it doesn't exist. */
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index dda52cb649dc..cae012e56d53 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -210,6 +210,17 @@ extern int test__join_cgroup(const char *path);
 	___ok;								\
 })
 
+#define ASSERT_GE(actual, expected, name) ({				\
+	static int duration = 0;					\
+	typeof(actual) ___act = (actual);				\
+	typeof(expected) ___exp = (expected);				\
+	bool ___ok = ___act >= ___exp;					\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual %lld < expected %lld\n",		\
+	      (name), (long long)(___act), (long long)(___exp));	\
+	___ok;								\
+})
+
 #define ASSERT_STREQ(actual, expected, name) ({				\
 	static int duration = 0;					\
 	const char *___act = actual;					\
-- 
2.26.2

