Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAA64FA67F
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbiDIJf6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241153AbiDIJfz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:35:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E05513F91
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:33:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b2-20020a17090a010200b001cb0c78db57so8680240pjb.2
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjmvhYxS8afFZx5j9YBQMFNiV9OCM7KknZKWcG19uRc=;
        b=SCogdAOQPnv+QEvMUtbklnAIyyCp1uJUFX55/xCvFCQFos2Rra4MyLuRP2iSUX7sY4
         4p9hVECnn0/s/lcKq21+w/Nk4hUd235lhOEBM69r9lpS3Ii8usj6iCyYPPu0v0IDJ49O
         zRv0o4yBttxS6SiPFTuNqwcHu5IXlCGaUi0RRj9JaMIRZMoe8qHX6hU6yO+c+YLyNELH
         D4VZ0Z4P6TU2VdzR4W6qM5iu8AE7QHaB1yqIuqD/n+5vY2DpjnHB8uWqn2KEz1cIdSQZ
         ExuGTN1pYUuPv++T0UhTkrPteuux+NnLOJC0M3Kxa8TEQN7pkURXi/RRo44daqsWG845
         +fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjmvhYxS8afFZx5j9YBQMFNiV9OCM7KknZKWcG19uRc=;
        b=2dyn8R/Cmx8JooMLAOSWU9RFBLtOTaYzQEsx/gTuFr07rRLsLzSB56UymM8jAgJyj7
         9C73LrpwUlP3yzDxKBQmQiZKRIV1x9fBS87wqj5i4raHj+cANA75gpRLBQ+IghpQDj6s
         tyRVHAuoIpommbe5ad3fa21Z/HZ2Hqxb9GQ/qW5xwd9EySoTZcOcD5VWw4pVVjHHhOls
         xaGrvVqV0P1PshAHzVhp6RCbCFCPiBqjvguu0TGwyyyX5fqjXHTO8WAzU4A1QBLpXv+6
         mzDNlWEn6HH2vUNlzrZPSEcouzDU4MR+siT16O+iVu52t47ezaPBA9mBxaUEo2UidLwh
         0PPg==
X-Gm-Message-State: AOAM533eRS7Mfm4yX3ZgQzeRU/EiaWZcAImXeAAHis1qe6b0tLbcPHHi
        /55LSJL/11ULNPMnZbLQu3v5KmcyIYE=
X-Google-Smtp-Source: ABdhPJwqtUzwQUtWUMq3IJr5SlDm0JTGVSHOQ3PXBRFeIyQudS9VTMvEashPawAdDi09KXMNgp/ZwA==
X-Received: by 2002:a17:90b:3e8c:b0:1c7:462c:af6b with SMTP id rj12-20020a17090b3e8c00b001c7462caf6bmr25973353pjb.150.1649496828562;
        Sat, 09 Apr 2022 02:33:48 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id x123-20020a623181000000b004fdf99d25f6sm21149383pfx.80.2022.04.09.02.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:33:48 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 12/13] selftests/bpf: Add C tests for kptr
Date:   Sat,  9 Apr 2022 15:03:02 +0530
Message-Id: <20220409093303.499196-13-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7611; h=from:subject; bh=7e/aTyfCpmunXQGI2UYImXVw/gfBPVbL4M94CXJvIAE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVF0kg60q/7p1Lm/ZPlGCGfBldsdB9amOmr5Bz/v 3v2i5NaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRdAAKCRBM4MiGSL8RyiV8D/ 46wMYhlh1fEudIjG21neC3ej6BkoKYwA3XvDChxLfTTuczOMFPIN9NSF6S6mCnYlzJn3dSn8W9B6c+ paOV1QDXcDlpuaPBldAQoIuzkQp+7WYzD4ZmIt5mw/+LOZFaEYpeiZHlIwGQBMKqDUWbysLacRnuTj wPm4EffZLFIhApGwsz+nJt/XuGTBAmhp6+QOkyDQRWqxHGg25mdw4mLoXdZC8PJZscRRQYPA8jo/qm yFS/HLT2PbrxwJkW2gPMVvLcWHdq7tevHtCePscZmf7Gx5vjI+iKAExU2LpsdDenrmqQdLWcq1guyJ BIuWutLOx/UbzLta+pgocpQh8gzeHA+TXepByKGb4fzKGPL7dpo9kujBYna+ndV6w6uIlST71PnRCd TpBQJyoG5J/45im5+KHur+xccl8EWM1o/yAvgpmP+RXaQdCUG40GfYqZudZoO7rG8KdvgWgHaR3bbM M2/nxwM/JlZ+1OQSsowDhAFiGAfS5wyqYue4zR0W2yOTPBLO1zIzXKIaiIcR9Jr2ssBXxooWJANJR1 nVgvQdfnjOBLvWRMTPizSJ0KJ60eenM9tlagbnPMcNT8heSmzs8OtLc+nB951bUqwGakuAx/k0Tbok rLivl7cHJztY2M8IEjtj7q0ocqMY8WUzCFhKWLImpt1S4ScF0jTkywahmccw==
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

