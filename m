Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84C811BFEB
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 23:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfLKWev (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Dec 2019 17:34:51 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:36279 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfLKWet (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:49 -0500
Received: by mail-vk1-f201.google.com with SMTP id d70so242824vkf.3
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2019 14:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FRjIG/g0K2IGdjOAb2+WCbnXVcvbBcY/wXAKpp2H258=;
        b=fMAf3YmYk6BzYsIS5NLamvhKYc47KKPO/g3p54MY9DkwZQ1QAJVTG0HBnp0Gx3s8/k
         tpTSUO5Imh7sZqzMtWZ7ViMJZbHWQn7UGEGsZ+pR3Hzz2sIsvllYPGaAaQkkwcnCoPgr
         PKtwHuOII1x0sIyGjXn5XXdcAcnjzds5IuS7L/9H7TfliJd6Zb3TLmw4zJmbhOLbZzsm
         0tz/0yYG/PzDRoiAR9NetCDXY4Yvpv5Totd2kl/qRR0U28qwQGO3Okjbxa/B9QbPmWxs
         SP/WCxu+N/z8lERZQOVqXvgtz6xOcuIBapSnFr6EpCls+qJTVg+wRvNqxmlGwAq4d4SS
         dnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FRjIG/g0K2IGdjOAb2+WCbnXVcvbBcY/wXAKpp2H258=;
        b=DtFbmyQZmMWwoOw+vB+7ochAEnXa1kEZEeXBATCtVcPtuGWQDO0YsWDkzE4CQ4nqbB
         nTehi0Nnf7wb2iz19k9w+nlgadBKTFy3H4k0Dvq/tf4R/fDZnQAdOLloy8PjeTLwKsNo
         LeP/y02SCjaelrx6Wkw0+KhDUageE5pva4o1Q/4miXYJr3nhFq4DM72Ae5DzKiktEgBD
         v4UTTHU5ucsk0DAZOenO1snghMPH0c0gE2+Q3GwHnMocMm6Dpy9q6eCPVPXhdNIKPXFn
         JVl/i7h27z6xLkfNgloLRxAuw2ilIA7RlVP/AIPbv34yAktSke6VvcSWosr9/Dgnt5Yh
         e8mQ==
X-Gm-Message-State: APjAAAVQNCbls6dOVQl2qqnMP65DbrrlFYWf28bCYXXhRTNeFctnIaGS
        IJJRKQE58wtI6KMtQTk46qmEl59D97MV
X-Google-Smtp-Source: APXvYqxpL2gsGZWIEQ0viz4UuUU4hw/0alcO2NWtN0dVrXFCNJbf92MO2WEwm9cr5/JW2ueT6NK7o/oziSXW
X-Received: by 2002:a67:e205:: with SMTP id g5mr4593164vsa.186.1576103688521;
 Wed, 11 Dec 2019 14:34:48 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:33:42 -0800
In-Reply-To: <20191211223344.165549-1-brianvv@google.com>
Message-Id: <20191211223344.165549-10-brianvv@google.com>
Mime-Version: 1.0
References: <20191211223344.165549-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 bpf-next 09/11] selftests/bpf: add batch ops testing for
 htab and htab_percpu map
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

Tested bpf_map_lookup_batch(), bpf_map_lookup_and_delete_batch(),
bpf_map_update_batch(), and bpf_map_delete_batch() functionality.
  $ ./test_maps
    ...
      test_htab_map_batch_ops:PASS
      test_htab_percpu_map_batch_ops:PASS
    ...

Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 .../bpf/map_tests/htab_map_batch_ops.c        | 269 ++++++++++++++++++
 1 file changed, 269 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c

diff --git a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
new file mode 100644
index 0000000000000..dabc4d420a10e
--- /dev/null
+++ b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook  */
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include <bpf_util.h>
+#include <test_maps.h>
+
+static void map_batch_update(int map_fd, __u32 max_entries, int *keys,
+			     void *values, bool is_pcpu)
+{
+	typedef BPF_DECLARE_PERCPU(int, value);
+	int i, j, err;
+	value *v;
+
+	if (is_pcpu)
+		v = (value *)values;
+
+	for (i = 0; i < max_entries; i++) {
+		keys[i] = i + 1;
+		if (is_pcpu)
+			for (j = 0; j < bpf_num_possible_cpus(); j++)
+				bpf_percpu(v[i], j) = i + 2 + j;
+		else
+			((int *)values)[i] = i + 2;
+	}
+
+	err = bpf_map_update_batch(map_fd, keys, values, &max_entries, 0, 0);
+	CHECK(err, "bpf_map_update_batch()", "error:%s\n", strerror(errno));
+}
+
+static void map_batch_verify(int *visited, __u32 max_entries,
+			     int *keys, void *values, bool is_pcpu)
+{
+	typedef BPF_DECLARE_PERCPU(int, value);
+	value *v;
+	int i, j;
+
+	if (is_pcpu)
+		v = (value *)values;
+
+	memset(visited, 0, max_entries * sizeof(*visited));
+	for (i = 0; i < max_entries; i++) {
+
+		if (is_pcpu) {
+			for (j = 0; j < bpf_num_possible_cpus(); j++) {
+				CHECK(keys[i] + 1 + j != bpf_percpu(v[i], j),
+				      "key/value checking",
+				      "error: i %d j %d key %d value %d\n",
+				      i, j, keys[i], bpf_percpu(v[i],  j));
+			}
+		} else {
+			CHECK(keys[i] + 1 != ((int *)values)[i],
+			      "key/value checking",
+			      "error: i %d key %d value %d\n", i, keys[i],
+			      ((int *)values)[i]);
+		}
+
+		visited[i] = 1;
+
+	}
+	for (i = 0; i < max_entries; i++) {
+		CHECK(visited[i] != 1, "visited checking",
+		      "error: keys array at index %d missing\n", i);
+	}
+}
+
+void __test_map_lookup_and_delete_batch(bool is_pcpu)
+{
+	int map_type = is_pcpu ? BPF_MAP_TYPE_PERCPU_HASH : BPF_MAP_TYPE_HASH;
+	struct bpf_create_map_attr xattr = {
+		.name = "hash_map",
+		.map_type = map_type,
+		.key_size = sizeof(int),
+		.value_size = sizeof(int),
+	};
+	__u32 batch, count, total, total_success;
+	typedef BPF_DECLARE_PERCPU(int, value);
+	int map_fd, *keys, *visited, key;
+	const __u32 max_entries = 10;
+	int err, step, value_size;
+	value pcpu_values[10];
+	bool nospace_err;
+	void *values;
+
+	xattr.max_entries = max_entries;
+	map_fd = bpf_create_map_xattr(&xattr);
+	CHECK(map_fd == -1,
+	      "bpf_create_map_xattr()", "error:%s\n", strerror(errno));
+
+	value_size = is_pcpu ? sizeof(value) : sizeof(int);
+	keys = malloc(max_entries * sizeof(int));
+	if (is_pcpu)
+		values = pcpu_values;
+	else
+		values = malloc(max_entries * sizeof(int));
+	visited = malloc(max_entries * sizeof(int));
+	CHECK(!keys || !values || !visited, "malloc()",
+	      "error:%s\n", strerror(errno));
+
+	/* test 1: lookup/delete an empty hash table, -ENOENT */
+	count = max_entries;
+	err = bpf_map_lookup_and_delete_batch(map_fd, NULL, &batch, keys,
+					      values, &count, 0, 0);
+	CHECK((err && errno != ENOENT), "empty map",
+	      "error: %s\n", strerror(errno));
+
+	/* populate elements to the map */
+	map_batch_update(map_fd, max_entries, keys, values, is_pcpu);
+
+	/* test 2: lookup/delete with count = 0, success */
+	count = 0;
+	err = bpf_map_lookup_and_delete_batch(map_fd, NULL, &batch, keys,
+					      values, &count, 0, 0);
+	CHECK(err, "count = 0", "error: %s\n", strerror(errno));
+
+	/* test 3: lookup/delete with count = max_entries, success */
+	memset(keys, 0, max_entries * sizeof(*keys));
+	memset(values, 0, max_entries * value_size);
+	count = max_entries;
+	err = bpf_map_lookup_and_delete_batch(map_fd, NULL, &batch, keys,
+					      values, &count, 0, 0);
+	CHECK((err && errno != ENOENT), "count = max_entries",
+	       "error: %s\n", strerror(errno));
+	CHECK(count != max_entries, "count = max_entries",
+	      "count = %u, max_entries = %u\n", count, max_entries);
+	map_batch_verify(visited, max_entries, keys, values, is_pcpu);
+
+	/* bpf_map_get_next_key() should return -ENOENT for an empty map. */
+	err = bpf_map_get_next_key(map_fd, NULL, &key);
+	CHECK(!err, "bpf_map_get_next_key()", "error: %s\n", strerror(errno));
+
+	/* test 4: lookup/delete in a loop with various steps. */
+	total_success = 0;
+	for (step = 1; step < max_entries; step++) {
+		map_batch_update(map_fd, max_entries, keys, values, is_pcpu);
+		memset(keys, 0, max_entries * sizeof(*keys));
+		memset(values, 0, max_entries * value_size);
+		total = 0;
+		/* iteratively lookup/delete elements with 'step'
+		 * elements each
+		 */
+		count = step;
+		nospace_err = false;
+		while (true) {
+			err = bpf_map_lookup_batch(map_fd,
+						   total ? &batch : NULL,
+						   &batch, keys + total,
+						   values +
+						   total * value_size,
+						   &count, 0, 0);
+			/* It is possible that we are failing due to buffer size
+			 * not big enough. In such cases, let us just exit and
+			 * go with large steps. Not that a buffer size with
+			 * max_entries should always work.
+			 */
+			if (err && errno == ENOSPC) {
+				nospace_err = true;
+				break;
+			}
+
+			CHECK((err && errno != ENOENT), "lookup with steps",
+			      "error: %s\n", strerror(errno));
+
+			total += count;
+			if (err)
+				break;
+
+		}
+		if (nospace_err == true)
+			continue;
+
+		CHECK(total != max_entries, "lookup with steps",
+		      "total = %u, max_entries = %u\n", total, max_entries);
+		map_batch_verify(visited, max_entries, keys, values, is_pcpu);
+
+		total = 0;
+		count = step;
+		while (true) {
+			err = bpf_map_delete_batch(map_fd,
+						   keys + total,
+						   &count, 0, 0);
+			CHECK((err && errno != ENOENT), "delete with steps",
+			      "error: %s\n", strerror(errno));
+			total += count;
+			if (err)
+				break;
+		}
+		CHECK(total != max_entries, "delete with steps",
+		      "total = %u, max_entries = %u\n", total, max_entries);
+
+		/* check map is empty, errono == ENOENT */
+		err = bpf_map_get_next_key(map_fd, NULL, &key);
+		CHECK(!err || errno != ENOENT, "bpf_map_get_next_key()", "error: %s\n",
+		      strerror(errno));
+
+		/* iteratively lookup/delete elements with 'step'
+		 * elements each
+		 */
+		map_batch_update(map_fd, max_entries, keys, values, is_pcpu);
+		memset(keys, 0, max_entries * sizeof(*keys));
+		memset(values, 0, max_entries * value_size);
+		total = 0;
+		count = step;
+		nospace_err = false;
+		while (true) {
+			err = bpf_map_lookup_and_delete_batch(map_fd,
+							total ? &batch : NULL,
+							&batch, keys + total,
+							values +
+							total * value_size,
+							&count, 0, 0);
+			/* It is possible that we are failing due to buffer size
+			 * not big enough. In such cases, let us just exit and
+			 * go with large steps. Not that a buffer size with
+			 * max_entries should always work.
+			 */
+			if (err && errno == ENOSPC) {
+				nospace_err = true;
+				break;
+			}
+
+			CHECK((err && errno != ENOENT), "lookup with steps",
+			      "error: %s\n", strerror(errno));
+
+			total += count;
+			if (err)
+				break;
+		}
+
+		if (nospace_err == true)
+			continue;
+
+		CHECK(total != max_entries, "lookup/delete with steps",
+		      "total = %u, max_entries = %u\n", total, max_entries);
+
+		map_batch_verify(visited, max_entries, keys, values, is_pcpu);
+		err = bpf_map_get_next_key(map_fd, NULL, &key);
+		CHECK(!err, "bpf_map_get_next_key()", "error: %s\n",
+		      strerror(errno));
+
+		total_success++;
+	}
+
+	CHECK(total_success == 0, "check total_success",
+	      "unexpected failure\n");
+}
+
+void htab_map_batch_ops(void)
+{
+	__test_map_lookup_and_delete_batch(false);
+	printf("test_%s:PASS\n", __func__);
+}
+
+void htab_percpu_map_batch_ops(void)
+{
+	__test_map_lookup_and_delete_batch(true);
+	printf("test_%s:PASS\n", __func__);
+}
+
+void test_htab_map_batch_ops(void)
+{
+	htab_map_batch_ops();
+	htab_percpu_map_batch_ops();
+}
-- 
2.24.1.735.g03f4e72817-goog

