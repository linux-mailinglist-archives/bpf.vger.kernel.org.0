Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3A50D564
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiDXVwh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbiDXVw1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:52:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2878644DF
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n8so23004092plh.1
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjmvhYxS8afFZx5j9YBQMFNiV9OCM7KknZKWcG19uRc=;
        b=hzVxAAayuFeoK4S/OUjuHozHt+jAN8reUPPGDjMVlpxL4rB0RIMBw+jCjfEdJnHMOC
         m6IWCSm2AIx8vo+iE2TU+qW/viwbcAcQh9qxWIMN1462or7TSjw0jfywXPs+/yuK8pEV
         VkNVPmsXHXWpPVyiAiYj3z604oWi/dhV2qJ5h5jTlb2DtL2UsOdYTjPQh7KnITzDO6Bb
         8uhUBXRIobbFafo9n3LLqx6iFSFALaa+g56etUU/FFv7d7fVUeKs/7yIUnZzq61J4V6K
         ZBrDlxHT1BmLTyfKMMd8Q7PAL3fj8t9wwe3eaTzSYKJmKdQm63mWo5y7qWyJ6J7xJgNK
         m20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjmvhYxS8afFZx5j9YBQMFNiV9OCM7KknZKWcG19uRc=;
        b=UXBTkTS7/ZWhc5MnzJRNNX6i4G674/l5lTLFCT4Gxj//gR9twsh9q9zb9U/NoGRwYz
         MqYpQypfq+guOoD7aTRtLnEnAZf3wdoUUK13OE7huA/ACN6554QuNixF7LuO8dIkrnSA
         gvjohW3qiWAaxMb1bh4VD6ja9h17eKppVCFgiRIUDOkHw43UK8RdFmQ1UKfKsMTHy+iz
         Y0zZ0NQKgow5qjhvizH1d8HFG1vyCfgZ98Y8CzsXo83uaOa6nrTvqXv7QWPTff777ks8
         66Yc/5aJeAIJacOSbHpkTfBvOpn4WA4qrd9VU/GL51lepjLYclt1pu7VL0VxEAqH0z5B
         1zrQ==
X-Gm-Message-State: AOAM531KUqHAVnll/ZUW0HACmINedChTzINAT7Iw7gvoB5Y7LFUJiKov
        Efn9L6QNZvsF0au3z0YqYLASJfNoynA=
X-Google-Smtp-Source: ABdhPJzqhKklaCqHB0UxcEOhLNNWdt2Iz7LvlE2+HKkBRyrAzBDUAD5BrDD06/s9K9ql499Y2VJUiA==
X-Received: by 2002:a17:90b:3d91:b0:1d9:51e3:3229 with SMTP id pq17-20020a17090b3d9100b001d951e33229mr6150122pjb.179.1650836965108;
        Sun, 24 Apr 2022 14:49:25 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090ae01600b001d945337442sm4462699pjy.10.2022.04.24.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:49:24 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v6 11/13] selftests/bpf: Add C tests for kptr
Date:   Mon, 25 Apr 2022 03:18:59 +0530
Message-Id: <20220424214901.2743946-12-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424214901.2743946-1-memxor@gmail.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7611; h=from:subject; bh=7e/aTyfCpmunXQGI2UYImXVw/gfBPVbL4M94CXJvIAE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiZcTLkg60q/7p1Lm/ZPlGCGfBldsdB9amOmr5Bz/v 3v2i5NaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYmXEywAKCRBM4MiGSL8RygJoD/ 4wBJOxD1Jy0fh9Uj4jotWPPs7wNxl25/GDc7AO2JChxT3jlLhuNVrf79vwvgjIBXtAtXIO24X46vyZ KV+WpoEtR6EfrUA53o7RRkN4/d8JXMdPCELPTQFiQox/HquXG2QinbyuS4WzkG/dJ8UVdUjkK/pKFt lclWKAg//W+CelNzP74hhgOaN0h/bEIUSmjrEeCyVgReeycZpP66XGvjDco+aS9VXq6La74geJTohI +JzoyxNUyZBIFobHLc8TOUjRELirt9/jjMuWcaRd4hgBogJ26N9OqpCzp8ErWdZqB814ivqVFvnXas KydsnBDljj5byrxTDesCs8qZNyzsi/Ho4iZxOHnQqJhttQlFExVk+bEzPlDVGqzx9WwU9qYGR75LBR VF3JQx9GRyVFR4BEMluwjaoyiQckqRcn6WrEy/grmvgU7peeH/2btySUh8/EdbMUgaQOhiREPpBSto 38TiGszUoHxHGVz6oyMtL/dVltHhCudEcL7WwlV1KRDpqBG8ME7N8lkiBAZ13YK51SkDqLFE+N/iru SQbbU44ojF1FK+MP6guWlHJBPpsdrbJ8x//k/P0GTNeXI43RDS1rvyL2YykVRvF5PvDccRPS7F6iqb 5WwHDc8BxbK2LoAsIWvgurfOXrbnFtWVODUNwMy+bbiKiUZCvu/GdQdj1i5w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This uses the __kptr and __kptr_ref macros as well, and tries to test
the stuff that is supposed to work, since we have negative tests in
test_verifier suite. Also include some code to test map-in-map support,
such that the inner_map_meta matches the kptr_off_tab of map added as
element.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_kptr.c       |  37 ++++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 190 ++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
new file mode 100644
index 000000000000..9e2fbda64a65
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "map_kptr.skel.h"
+
+void test_map_kptr(void)
+{
+	struct map_kptr *skel;
+	int key = 0, ret;
+	char buf[24];
+
+	skel = map_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
+		return;
+
+	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.array_map), &key, buf, 0);
+	ASSERT_OK(ret, "array_map update");
+	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.array_map), &key, buf, 0);
+	ASSERT_OK(ret, "array_map update2");
+
+	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.hash_map), &key, buf, 0);
+	ASSERT_OK(ret, "hash_map update");
+	ret = bpf_map_delete_elem(bpf_map__fd(skel->maps.hash_map), &key);
+	ASSERT_OK(ret, "hash_map delete");
+
+	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.hash_malloc_map), &key, buf, 0);
+	ASSERT_OK(ret, "hash_malloc_map update");
+	ret = bpf_map_delete_elem(bpf_map__fd(skel->maps.hash_malloc_map), &key);
+	ASSERT_OK(ret, "hash_malloc_map delete");
+
+	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.lru_hash_map), &key, buf, 0);
+	ASSERT_OK(ret, "lru_hash_map update");
+	ret = bpf_map_delete_elem(bpf_map__fd(skel->maps.lru_hash_map), &key);
+	ASSERT_OK(ret, "lru_hash_map delete");
+
+	map_kptr__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
new file mode 100644
index 000000000000..1b0e0409eaa5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct map_value {
+	struct prog_test_ref_kfunc __kptr *unref_ptr;
+	struct prog_test_ref_kfunc __kptr_ref *ref_ptr;
+};
+
+struct array_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} array_map SEC(".maps");
+
+struct hash_map {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} hash_map SEC(".maps");
+
+struct hash_malloc_map {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} hash_malloc_map SEC(".maps");
+
+struct lru_hash_map {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} lru_hash_map SEC(".maps");
+
+#define DEFINE_MAP_OF_MAP(map_type, inner_map_type, name)       \
+	struct {                                                \
+		__uint(type, map_type);                         \
+		__uint(max_entries, 1);                         \
+		__uint(key_size, sizeof(int));                  \
+		__uint(value_size, sizeof(int));                \
+		__array(values, struct inner_map_type);         \
+	} name SEC(".maps") = {                                 \
+		.values = { [0] = &inner_map_type },            \
+	}
+
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_ARRAY_OF_MAPS, array_map, array_of_array_maps);
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_ARRAY_OF_MAPS, hash_map, array_of_hash_maps);
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_ARRAY_OF_MAPS, hash_malloc_map, array_of_hash_malloc_maps);
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_ARRAY_OF_MAPS, lru_hash_map, array_of_lru_hash_maps);
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, array_map, hash_of_array_maps);
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, hash_map, hash_of_hash_maps);
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, hash_malloc_map, hash_of_hash_malloc_maps);
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, lru_hash_map, hash_of_lru_hash_maps);
+
+extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
+extern struct prog_test_ref_kfunc *
+bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
+extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
+
+static void test_kptr_unref(struct map_value *v)
+{
+	struct prog_test_ref_kfunc *p;
+
+	p = v->unref_ptr;
+	/* store untrusted_ptr_or_null_ */
+	v->unref_ptr = p;
+	if (!p)
+		return;
+	if (p->a + p->b > 100)
+		return;
+	/* store untrusted_ptr_ */
+	v->unref_ptr = p;
+	/* store NULL */
+	v->unref_ptr = NULL;
+}
+
+static void test_kptr_ref(struct map_value *v)
+{
+	struct prog_test_ref_kfunc *p;
+
+	p = v->ref_ptr;
+	/* store ptr_or_null_ */
+	v->unref_ptr = p;
+	if (!p)
+		return;
+	if (p->a + p->b > 100)
+		return;
+	/* store NULL */
+	p = bpf_kptr_xchg(&v->ref_ptr, NULL);
+	if (!p)
+		return;
+	if (p->a + p->b > 100) {
+		bpf_kfunc_call_test_release(p);
+		return;
+	}
+	/* store ptr_ */
+	v->unref_ptr = p;
+	bpf_kfunc_call_test_release(p);
+
+	p = bpf_kfunc_call_test_acquire(&(unsigned long){0});
+	if (!p)
+		return;
+	/* store ptr_ */
+	p = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (!p)
+		return;
+	if (p->a + p->b > 100) {
+		bpf_kfunc_call_test_release(p);
+		return;
+	}
+	bpf_kfunc_call_test_release(p);
+}
+
+static void test_kptr_get(struct map_value *v)
+{
+	struct prog_test_ref_kfunc *p;
+
+	p = bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
+	if (!p)
+		return;
+	if (p->a + p->b > 100) {
+		bpf_kfunc_call_test_release(p);
+		return;
+	}
+	bpf_kfunc_call_test_release(p);
+}
+
+static void test_kptr(struct map_value *v)
+{
+	test_kptr_unref(v);
+	test_kptr_ref(v);
+	test_kptr_get(v);
+}
+
+SEC("tc")
+int test_map_kptr(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int i, key = 0;
+
+#define TEST(map)					\
+	v = bpf_map_lookup_elem(&map, &key);		\
+	if (!v)						\
+		return 0;				\
+	test_kptr(v)
+
+	TEST(array_map);
+	TEST(hash_map);
+	TEST(hash_malloc_map);
+	TEST(lru_hash_map);
+
+#undef TEST
+	return 0;
+}
+
+SEC("tc")
+int test_map_in_map_kptr(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int i, key = 0;
+	void *map;
+
+#define TEST(map_in_map)                                \
+	map = bpf_map_lookup_elem(&map_in_map, &key);   \
+	if (!map)                                       \
+		return 0;                               \
+	v = bpf_map_lookup_elem(map, &key);		\
+	if (!v)						\
+		return 0;				\
+	test_kptr(v)
+
+	TEST(array_of_array_maps);
+	TEST(array_of_hash_maps);
+	TEST(array_of_hash_malloc_maps);
+	TEST(array_of_lru_hash_maps);
+	TEST(hash_of_array_maps);
+	TEST(hash_of_hash_maps);
+	TEST(hash_of_hash_malloc_maps);
+	TEST(hash_of_lru_hash_maps);
+
+#undef TEST
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.35.1

