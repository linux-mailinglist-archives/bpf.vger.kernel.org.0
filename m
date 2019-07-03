Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D285E9F4
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2019 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfGCRCR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jul 2019 13:02:17 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:55241 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfGCRCQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 13:02:16 -0400
Received: by mail-qk1-f201.google.com with SMTP id b139so2597186qkc.21
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2019 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7zXPbkaWJfiDYFqUaQDv1CcnFA8M8EK5B7uTwERQ454=;
        b=nomp9tHgj5x1czbVL2zJDJqXtjpKSKSPuyKFUjvAnaURASlRHYALaHhtn8TAxyG9JM
         tmJdn2pGDwGaYKQxll828yehZpKwqT8HfPtgvD+pebT4VXbM8ZPV82rjIewOGerCVgWq
         +eca2s280/NGFe80fGEGJCW4WQ9TjxJZ/kRj+OFHAprYBKLCdXygwT6zKRFgHDMNLKI8
         fMeGZzL+fz3MGtfoiXlIt7aZJEqLs9r3kbmXEF6h6K2JEIqQmIrnFiGmybC/IlfPK4oG
         poBvAW0u77XLIpwoMDaU+TOvWnFixK2tm376kgKBDoVBX9CKnu+Lnv7zIeOpWodtnhNY
         t1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7zXPbkaWJfiDYFqUaQDv1CcnFA8M8EK5B7uTwERQ454=;
        b=T2SQbgAygRUqe2RQ31deuUG4AUanP4ynQwLom/hwvaRPc550W89UO5IiB2HW8T8dHm
         bWf+KygDpPKJzOYQ21PoPGuNL+1qr7fNIPHQxupAm8pIG7rbAgE6dZ4MGax8c0TpukSv
         Q0coTd1MlKeTHo2MjREcVFBm4cIB55IrO2ozb7kdyH4WNTbNsIAmcSwYlviVKNELiLs3
         HOh8O60LaSLFreLc2pfmh9Ok5suKeCqtU5lCIZLG4cGM3n+hH0CocCAzbY9aCsJ7J4q4
         DGt2xNJvooLHKpJiQx7HqpbGiHD6x6MBPHZ7TULSb7Qsz8kRDBqx7QIdivfVJZ3COH5F
         1WhQ==
X-Gm-Message-State: APjAAAXHNWnR+uvnEpCNZ6mJFJYXM1bec9zGj251zfvGp5ZVwsTAYyMQ
        3MVsTBZ79RCcMROOgLcJ+Z4gHPKINw9f
X-Google-Smtp-Source: APXvYqw2+o4+1Uveyzv9avWN5ZCckB/E4IsSuP8b1U0tKJD988+pjZxmb77+rL2WN8IbVBCDnR75BYEHcheH
X-Received: by 2002:ac8:17ac:: with SMTP id o41mr31315016qtj.184.1562173334642;
 Wed, 03 Jul 2019 10:02:14 -0700 (PDT)
Date:   Wed,  3 Jul 2019 10:01:17 -0700
In-Reply-To: <20190703170118.196552-1-brianvv@google.com>
Message-Id: <20190703170118.196552-6-brianvv@google.com>
Mime-Version: 1.0
References: <20190703170118.196552-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next RFC v3 5/6] selftests/bpf: test BPF_MAP_DUMP command
 on a bpf hashmap
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This tests exercise the new command on a bpf hashmap and make sure it
works as expected.

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/testing/selftests/bpf/test_maps.c | 82 ++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index a3fbc571280a..b19ba6aa8e36 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -309,6 +309,85 @@ static void test_hashmap_walk(unsigned int task, void *data)
 	close(fd);
 }
 
+static void test_hashmap_dump(void)
+{
+	int fd, i, max_entries = 5;
+	uint64_t keys[max_entries], values[max_entries];
+	uint64_t key, value, next_key, prev_key;
+	bool next_key_valid = true;
+	void *buf, *elem;
+	u32 buf_len;
+	const int elem_size = sizeof(key) + sizeof(value);
+
+	fd = helper_fill_hashmap(max_entries);
+
+	// Get the elements in the hashmap, and store them in that order
+	assert(bpf_map_get_next_key(fd, NULL, &key) == 0);
+	i = 0;
+	keys[i] = key;
+	for (i = 1; next_key_valid; i++) {
+		next_key_valid = bpf_map_get_next_key(fd, &key, &next_key) == 0;
+		assert(bpf_map_lookup_elem(fd, &key, &values[i - 1]) == 0);
+		keys[i-1] = key;
+		key = next_key;
+	}
+
+	// Alloc memory for the whole table
+	buf = malloc(elem_size * max_entries);
+	assert(buf != NULL);
+
+	// Check that buf_len < elem_size returns EINVAL
+	buf_len = elem_size-1;
+	errno = 0;
+	assert(bpf_map_dump(fd, NULL, buf, &buf_len) == -1 && errno == EINVAL);
+
+	// Check that it returns the first two elements
+	errno = 0;
+	buf_len = elem_size * 2;
+	i = 0;
+	assert(bpf_map_dump(fd, NULL, buf, &buf_len) == 0 &&
+	       buf_len == 2*elem_size);
+	elem = buf;
+	assert((*(uint64_t *)elem) == keys[i] &&
+	       (*(uint64_t *)(elem + sizeof(key))) == values[i]);
+	elem = buf + elem_size;
+	i++;
+	assert((*(uint64_t *)elem) == keys[i] &&
+	       (*(uint64_t *)(elem + sizeof(key))) == values[i]);
+	i++;
+
+	/* Check that prev_key contains key from last_elem retrieved in previous
+	 * call
+	 */
+	prev_key = *((uint64_t *)elem);
+	assert(bpf_map_dump(fd, &prev_key, buf, &buf_len) == 0 &&
+	       buf_len == elem_size*2);
+	elem = buf;
+	assert((*(uint64_t *)elem) == keys[i] &&
+	       (*(uint64_t *)(elem + sizeof(key))) == values[i]);
+	elem = buf + elem_size;
+	i++;
+	assert((*(uint64_t *)elem) == keys[i] &&
+	       (*(uint64_t *)(elem + sizeof(key))) == values[i]);
+	i++;
+	assert(prev_key == (*(uint64_t *)elem));
+
+	/* Continue reading from map and verify buf_len only contains 1 element
+	 * even though buf_len is 2 elem_size.
+	 */
+	assert(bpf_map_dump(fd, &prev_key, buf, &buf_len) == 0 &&
+	       buf_len == elem_size);
+	elem = buf;
+	assert((*(uint64_t *)elem) == keys[i] &&
+	       (*(uint64_t *)(elem + sizeof(key))) == values[i]);
+
+	assert(bpf_map_dump(fd, &prev_key, buf, &buf_len) == -1 &&
+	       errno == ENOENT);
+
+	free(buf);
+	close(fd);
+}
+
 static void test_hashmap_zero_seed(void)
 {
 	int i, first, second, old_flags;
@@ -1668,6 +1747,7 @@ static void run_all_tests(void)
 	test_hashmap_percpu(0, NULL);
 	test_hashmap_walk(0, NULL);
 	test_hashmap_zero_seed();
+	test_hashmap_dump();
 
 	test_arraymap(0, NULL);
 	test_arraymap_percpu(0, NULL);
@@ -1705,11 +1785,9 @@ int main(void)
 
 	map_flags = BPF_F_NO_PREALLOC;
 	run_all_tests();
-
 #define CALL
 #include <map_tests/tests.h>
 #undef CALL
-
 	printf("test_maps: OK, %d SKIPPED\n", skips);
 	return 0;
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

