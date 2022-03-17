Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F34C4DC563
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiCQMC0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiCQMCZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:02:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737D618B7B9
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:01:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c2so2486635pga.10
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5AusX+nzdt7vClF8vfdk+V3fORFppwiqg1Tqm0/0Qw=;
        b=CxLV8EDOnat6ykBaxsKHILrLuqhwEGLD9Y8DgxQcTy3XWiAfcdimhndudQuM65CnmD
         9oTusoDAY/P3765lCuJB1ohqM9oVxX0o72cIqPDjwG3pcFg7mAOkgplQ7AC56yWvclFE
         1R4M1gyPzBeyTAW5i34joRcYflx5i3u6CyI+eQw1Pza7/78K3jacMMsKjHOVSHT4HFUy
         09QupQU8D6U/4pudi96Ud5bNzCkINYaxTOUQWwGHYQ+jq2fxXgq0rQMsoZ698kcMbeVE
         +HqABM17h3NRJUjMjudhDjIT14xgZB+7kvH2GWXvl1jl0CrVjnLEgaTNDfjKGkMY+cCJ
         Ebxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5AusX+nzdt7vClF8vfdk+V3fORFppwiqg1Tqm0/0Qw=;
        b=szmz0M+2Pr+g20N1fv4nvJVdp/CBbIZjCAMdigNWWCHf8/ugMKQtG+cSEso8ZlQS7/
         3SQiiz+BRjglNCy1poYntJxPj8LfVGmWQIuGQPemHZXw9GHu5z1HGENnLxMyJ6YpXM8q
         uQtIdU/CroAX/Z3Fhvn3JaBana8DWU6E8joc7B24wIRSzYphrN8E02i/Euq3q9Zg0sX0
         3nwJENAER08SVWBpEskeU0pevbefckxT/MpP59z9d6fqORcSurVUfEsjuWjRL5CV6JS4
         X8nUCq5lWTHWJpYYwVK85XyJ38hUVCk8DgsWcWO8aB250anJXdMk3V8V0lsTOpbO4YGb
         C7pQ==
X-Gm-Message-State: AOAM5330ezhRdrTe3gKz2ZLZUVgkNjHM0b1tEihnRiE/QSmvH7xU+E9H
        2F+5B7jp3/kjzUKZ4mi+VH7U2mUphQQ=
X-Google-Smtp-Source: ABdhPJzplMmAm4unKT93/LeXCKe9z1yzLahRms/4XqJTCLhrZA9HYV1AL5Kc4VJXzmZgoRjVJp2F+A==
X-Received: by 2002:a63:500e:0:b0:36c:3697:7aab with SMTP id e14-20020a63500e000000b0036c36977aabmr3491116pgb.98.1647518468609;
        Thu, 17 Mar 2022 05:01:08 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090ad3c400b001c65ba76911sm5153392pjw.3.2022.03.17.05.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:01:08 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 14/15] selftests/bpf: Add C tests for kptr
Date:   Thu, 17 Mar 2022 17:29:56 +0530
Message-Id: <20220317115957.3193097-15-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7836; h=from:subject; bh=qC6w+qwtxCyTShwscLg7TdPuLuzameG3JdJhPxH6ZJo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKkJCZ3PbsTUjJChhdrP4kCVMwzEfZkXIimDuf3 Q0hhaVyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMipAAKCRBM4MiGSL8RytWQD/ 9q2YfvK1QCJ9MKZZY5GjAX9HKdfFneIl37oz5JMtvZRDYFMoUwU2WE+Zdtnwlx0RUGLxI2QgNZ3IBg AwL45DgObTP8qMjLdl0lTYA15+RykyYR7/BadiHxgfrHikhgfJyG2V7SSJdE0V4Zvk7FIT0QnFS0Gh s9RNfNP9FiE9yVYcaBz4w4EfxhD8a7hfwOB1f6P9GQRacn4Ozaj+BDgrRwhc1Q7xlppzDTM2MXmTLF l4TvGLNXVl8VO0nrMBXznjzPkOeYlL0UU19WMT8Y1+JlJDmhH1W/ACIJ8kFQOKVSedSHpdojsTe3VT m3RioYCFBIbLLgoIpYk3jOXeUgOSIRz/WP2u/NtDDKvJjiIsfP7NZRcrt0aZ916Oif3H+1kDbPQqnQ uyFpdq3Kpffl/T+StxrDcQW2a9ohQdZBByynF53NvyM9jF22RBWJBjKLfv1T8WkqbY7LcyhyUfjuHY 3Bpp3BFw2VLSJQUjsCQqu1pVL6HC0KB2mzlbTiHiEtr3gucqXj1UR7RYdZESavPOIgktn9+pqVzpgP 6/H8vVUJN/ZyyHzspdAF/2muhn81u3VHaehTR9W9TQDLaqGcz2hUZ84Qa3ahYDzkHOjAaLle1fdPG3 +ofJLHq7VNLrzdjvYzvCaqOGP0ot6GsCa4qqieH683VLSZF7M5zsU1OsLGhQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This uses the __kptr* macros as well, and tries to test the stuff that
is supposed to work, since we have negative tests in test_verifier
suite. Also include some code to test map-in-map support, such that the
inner_map_meta matches the map value of map added as element.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_kptr.c       |  20 ++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 236 ++++++++++++++++++
 2 files changed, 256 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
new file mode 100644
index 000000000000..688732295ce9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "map_kptr.skel.h"
+
+void test_map_kptr(void)
+{
+	struct map_kptr *skel;
+	char buf[24];
+	int key = 0;
+
+	skel = map_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
+		return;
+	ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.hash_map), &key, buf, 0),
+		  "bpf_map_update_elem hash_map");
+	ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.hash_malloc_map), &key, buf, 0),
+		  "bpf_map_update_elem hash_malloc_map");
+	map_kptr__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
new file mode 100644
index 000000000000..0b6f60423219
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct map_value {
+	struct prog_test_ref_kfunc __kptr *unref_ptr;
+	struct prog_test_ref_kfunc __kptr_ref *ref_ptr;
+	struct prog_test_ref_kfunc __kptr_percpu *percpu_ptr;
+	struct prog_test_ref_kfunc __kptr_user *user_ptr;
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
+	__uint(map_flags, BPF_F_NO_PREALLOC);
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
+static __always_inline
+void test_kptr_unref(struct map_value *v)
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
+static __always_inline
+void test_kptr_ref(struct map_value *v)
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
+static __always_inline
+void test_kptr_percpu(struct map_value *v)
+{
+	struct prog_test_ref_kfunc *p;
+
+	p = v->percpu_ptr;
+	/* store percpu_ptr_or_null_ */
+	v->percpu_ptr = p;
+	if (!p)
+		return;
+	p = bpf_this_cpu_ptr(p);
+	if (p->a + p->b > 100)
+		return;
+	/* store percpu_ptr_ */
+	v->percpu_ptr = p;
+	/* store NULL */
+	v->percpu_ptr = NULL;
+}
+
+static __always_inline
+void test_kptr_user(struct map_value *v)
+{
+	struct prog_test_ref_kfunc *p;
+	char buf[sizeof(*p)];
+
+	p = v->user_ptr;
+	/* store user_ptr_or_null_ */
+	v->user_ptr = p;
+	if (!p)
+		return;
+	bpf_probe_read_user(buf, sizeof(buf), p);
+	/* store user_ptr_ */
+	v->user_ptr = p;
+	/* store NULL */
+	v->user_ptr = NULL;
+}
+
+static __always_inline
+void test_kptr_get(struct map_value *v)
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
+static __always_inline
+void test_kptr(struct map_value *v)
+{
+	test_kptr_unref(v);
+	test_kptr_ref(v);
+	test_kptr_percpu(v);
+	test_kptr_user(v);
+	test_kptr_get(v);
+}
+
+SEC("tc")
+int test_map_kptr(struct __sk_buff *ctx)
+{
+	void *maps[] = {
+		&array_map,
+		&hash_map,
+		&hash_malloc_map,
+		&lru_hash_map,
+	};
+	struct map_value *v;
+	int i, key = 0;
+
+	for (i = 0; i < sizeof(maps) / sizeof(*maps); i++) {
+		v = bpf_map_lookup_elem(&array_map, &key);
+		if (!v)
+			return 0;
+		test_kptr(v);
+	}
+	return 0;
+}
+
+SEC("tc")
+int test_map_in_map_kptr(struct __sk_buff *ctx)
+{
+	void *map_of_maps[] = {
+		&array_of_array_maps,
+		&array_of_hash_maps,
+		&array_of_hash_malloc_maps,
+		&array_of_lru_hash_maps,
+		&hash_of_array_maps,
+		&hash_of_hash_maps,
+		&hash_of_hash_malloc_maps,
+		&hash_of_lru_hash_maps,
+	};
+	struct map_value *v;
+	int i, key = 0;
+	void *map;
+
+	for (i = 0; i < sizeof(map_of_maps) / sizeof(*map_of_maps); i++) {
+		map = bpf_map_lookup_elem(&array_of_array_maps, &key);
+		if (!map)
+			return 0;
+		v = bpf_map_lookup_elem(map, &key);
+		if (!v)
+			return 0;
+		test_kptr(v);
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.35.1

