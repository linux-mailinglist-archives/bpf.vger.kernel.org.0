Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4594E1C6F
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 16:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245427AbiCTP5f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 11:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245436AbiCTP5d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 11:57:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7F554697
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:56:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s11so13523170pfu.13
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c0rlVkmTXLMsV3hnUEY6r2LXk7kBTALA/cJR/7tljik=;
        b=cfit49q3BIadHQ/j3nsC3gUTWqzHNDEzMq9nSob/zCBL45bhuEsstSZiOl9ynbznCP
         xH09rKqCGQArvmZmnfiasvMzGo0cVw19hiBc0bpIHE0TXSJegmx4GyxDmWOhoHCP2xaU
         pWvsMFzCiuL46B9X5oEMNpZVE7xxY3ER1vgnXxNFaPF4olK5/ciA0EIXqPGy3xFYEgnk
         rXPrL/TFBOR18NwcrxUffd7/dcUpBdD0NfFZSItENJ95YhOl8p5vn0ejiQ4zEqoy5Xjp
         C4NR2EMymZ1jarrymD131PzullinSgoyv+LNDlGGB1QgY4qrFt8ZRaQxoix2mr/AbjPD
         1XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0rlVkmTXLMsV3hnUEY6r2LXk7kBTALA/cJR/7tljik=;
        b=A7IIMS2mEZ6YgamUB5iTergGwyP0gGWWXTo6nCQ8eXps986X8S64wArizcAjOn+78v
         co1Y0YLQbmY9+SQmLOUXThl70i2YqJn/yC9HJeSDg7inkavl1Bxt2XTh2s04AuoOxSSF
         GmVBjsMATkNvmcg8Iw+4UVq3GRFSv9hYlxr1gP4TVm4wE2YC73KM/3VntkiaOVNy4Mdx
         VTyCCb5zMhhwEfS9LNahymc0iKVl6Hz3YI8y/hBXTkxzjs9SyzAdBTZ8Xc2/wElaDISa
         avsiJlxX3M41DdoY9bucxWSiQuX17rkG5GqiMhPUptnMSq/URLb79jLvZkTnizVozqwi
         3qCQ==
X-Gm-Message-State: AOAM533sdoTyO04P1SQEVtGYs6Zjo6jPCITk2YfEmF47TYBog6/CbldC
        8qKOkctLJ9dLnSuSC96Uf16RNNBzsVk=
X-Google-Smtp-Source: ABdhPJyuc9FI+j0CKLRtszcW2MlqWzGr5Glw25aXQUeb4j6eHintqIH99T6pnvTrOlqfbVTXOpXRgg==
X-Received: by 2002:a62:38d1:0:b0:4fa:80ad:bf5e with SMTP id f200-20020a6238d1000000b004fa80adbf5emr7427097pfa.69.1647791762823;
        Sun, 20 Mar 2022 08:56:02 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id s11-20020a056a0008cb00b004fa2a3b989dsm15631550pfu.157.2022.03.20.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:56:02 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v3 12/13] selftests/bpf: Add C tests for kptr
Date:   Sun, 20 Mar 2022 21:25:09 +0530
Message-Id: <20220320155510.671497-13-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320155510.671497-1-memxor@gmail.com>
References: <20220320155510.671497-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6907; h=from:subject; bh=Znt0CMxh3BXXaWdsjTDxTQywTmMa9VB6VICPgyuEem8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiN00yE/i1ErgwrSqAqUWpJp/0O397arzWyAZC7w4U jJqIHjyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjdNMgAKCRBM4MiGSL8RyrE+D/ 9cEq8EaLqu6TVssryg0RXTc2Mn9WBKwtxsi0GYiIk6s3pzmKI+EjcwhrykwNIuxzozpAVLvtr+Yjs3 O1n3m4ZZKt5PQYnXJmzulUrxDVmiv1LUcW8dQyhzEahUTIMKlOmZnj8iuW8EvGDspg+ZB/muJdpE3p 15HlH6UmDXPp7+fNmRaa4sfyu7i3ijyk+p23I27jBTQbJ83I6AWCqvPwMKr1rSvVvWr6uz48zPd7ty E9MmjVOvZ4PBhVlpnLqOIDm2NW4WRWs6s4m10QD5tPuNGCHS0c3LMzwvCOowyZaoIfNIiNdz7GfSOC j5ZTTAhU0YPHrfl8f84vzbdYFzQXDAnFkFmF6Miwk6LW/3iDBOfgiKOCAo6nuDkhofqE/aLcnu1yJS pPwryajdsahFDB/oCWpxMIvEDffB85n092i7J3o1wk0bi/ffDF4AFku4UH/ShDMlwN5avYfhHPYq3o PCM7mMnIrvEAUUzIqiPEOYHTfHkIEUyJ+FsOCSVTsPACyKJGbXc7KeYFeIQwfKcYOX6fNXOGRETm2/ fOyfu3cnkY2aCEqsdb0tDHDroritlFzEp0MYfAJZ2OtPhRsSGAOS4OXX/YiLk3uqgF1LYkgTp7RBOC 8s7UnVXSoMaID7rnglMKaBfDwuzjKOdQ96UpdoeCSBzGSesdllVuSPnQsvzQ==
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
 .../selftests/bpf/prog_tests/map_kptr.c       |  20 ++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 194 ++++++++++++++++++
 2 files changed, 214 insertions(+)
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
index 000000000000..75df3dc05db2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -0,0 +1,194 @@
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

