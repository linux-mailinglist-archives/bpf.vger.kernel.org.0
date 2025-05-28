Return-Path: <bpf+bounces-59112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C93AC607A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 658607B1BA2
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36A422126D;
	Wed, 28 May 2025 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQgSsfYu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955A1F790F;
	Wed, 28 May 2025 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404229; cv=none; b=hvfqMEO+X7QIH/JAH4JKdtcpEGsAmE1luXVoP2kEGg/r4WoDnQ671oocFeo3/KCQ3OhtB2MGrpD3h8meg+8wviSq/e5aJqiEI8eabaNpzydtnwGWpCuWen6PI8r9nvoP4GUiOm8yLKVe/g1n0c9umqZeam/r5+PnpBt0M2KWd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404229; c=relaxed/simple;
	bh=AcaO69fi2Cm16me+V0/KdP3xPRhkcRRYM/GGL20HM90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GvQPwJmzYQSxElEmnWJX2X/KqtO3f6uE7v7toCxzCiCmVJCoOxzYyAZLjjqDTk/XGNMbTufGleVCwcUC8JMoneptjk2DrdwIDB8xvBYLmQhdEadl5/dmRPF/Z5GKScLTgdFMFb+FPXUIM5OvWEgo6UoluZxdWaU8q3GPMvBXQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQgSsfYu; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22e16234307so4362895ad.0;
        Tue, 27 May 2025 20:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404226; x=1749009026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv8Gaih+91J3pEdij4+7GRCFDqzELtyA4Kb4EEM5piM=;
        b=OQgSsfYu1I7GYiFcgXDqOPhGv8XsQ9LzYhcYafWUFJOBKpN8140YCtSFgzZ3k+8Lw7
         3jHZIBcIKYOKyGKvB3EG6qgSe2QqdZn2J1rORcwXY7AzUpVF+yW519e3p3Tow+D7iFz0
         7y8svWEaSApd6pv9mHNACZJQaRHslCnH6dLkKBuscq0XZ9pKFe+en/zY4G0TH6pn/YFO
         qlpjKPUYd099+U58+ZnfEJG1NA9pVyBcuCiJesBEC3hvG7BbTBpr0o66uC38Wztn+XW8
         dbDdC2LLXX/bMiOfqQEoRhMWgb2sY/EUKU1V7nDyojpCOxBI5Tccx1nMGAL+zVYZMijI
         fC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404226; x=1749009026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cv8Gaih+91J3pEdij4+7GRCFDqzELtyA4Kb4EEM5piM=;
        b=rUE6W+HB/PTiiDxRKerMmb8VD/oRkwN8D6GlFXPb2d4+cejSzmHA2Vu+1erjDCyL52
         GG1JRa7VCByDXC/HI7/VLBKmaZS/PpbXg6z3W9TGiStwqGQUA2oKtLCET/N8GMnst1Kf
         O7xItq+sLTyNSyafHLFNJg5SkvsqhlNjjvcwtwIWiRj2BbPLSH211pJoZ56EE04jT3Ta
         CYNrYsDdjUy+JCDYcB7P6fGMzDl5McVbZwad0sOGItihBx++4TZRa+U5htlLEOk767Ga
         fCgofBlXdgc8YA3nAmZ4CU0PTsj77NJ3uRCRsMZLzsSG8j3prFq0CpBm6AdoG0JJtxMG
         Nq3w==
X-Forwarded-Encrypted: i=1; AJvYcCXw9QcMobtJx7rliQM4MCpnQJbB2n1FTk3lpBUC/ykCD/eYCR+mFAlzX72eaPPacjZTcgwWPdyaP1lGavE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTqJ5dhLxmzLVoOAwvT86O2sMPM81/7Ek8MYY800dEL2LbNyE
	bnh7QdzXpsC2V9vtOuuJmq5jVjyvLnd1SPJUULfmxlUl/JFyQlLHJ4OE
X-Gm-Gg: ASbGncvywImuCENZ6nq/pTuR9n843UnSn3knL3IViGWj7r+qTIxA6jUTiKKQFlTzY2D
	jbG/FRzKT/3qHmeZqj8zFOb2iALThBojViIpojjSPImd/m2Y/+TmICLeBLSfknFYh/oZ3ihinEV
	T6tRwDrzFVT/A1lBKdqRoICcnE4MZ/j9JS21wOiZwZL4DK8n6w2pBwob1HtlOdoN5+VvtwgaGYK
	LqHnklTEuI+3XQoAvIjmwRWPyC5eLuYswMhWCns1xMjCNAdtYCWPw4PH9uVq2ousGIidqzD5gNX
	l/74vusfNHeEHQBsZ6UpUwj900Npw2cbKnt6bSwxwfpJU3lheA80wyy+XSS2cUBBNwly
X-Google-Smtp-Source: AGHT+IEt91bPXG7soyKF2aKcPaT2KY1bHpuur1X67g7WjyjNsrjONQCoB0VAJ9kcDLP+2eGzwYxV1g==
X-Received: by 2002:a17:903:2f89:b0:215:6c5f:d142 with SMTP id d9443c01a7336-234b74dba8amr44353475ad.20.1748404226348;
        Tue, 27 May 2025 20:50:26 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:25 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 23/25] selftests/bpf: add get_ksyms and get_addrs to test_progs.c
Date: Wed, 28 May 2025 11:47:10 +0800
Message-Id: <20250528034712.138701-24-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to get all the kernel function that can be traced sometimes, so we
move the get_syms() and get_addrs() in kprobe_multi_test.c to test_progs.c
and rename it to bpf_get_ksyms() and bpf_get_addrs().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +-----------------
 tools/testing/selftests/bpf/test_progs.c      | 214 +++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |   2 +
 3 files changed, 219 insertions(+), 217 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index e19ef509ebf8..171706e78da8 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -422,220 +422,6 @@ static void test_unique_match(void)
 	kprobe_multi__destroy(skel);
 }
 
-static size_t symbol_hash(long key, void *ctx __maybe_unused)
-{
-	return str_hash((const char *) key);
-}
-
-static bool symbol_equal(long key1, long key2, void *ctx __maybe_unused)
-{
-	return strcmp((const char *) key1, (const char *) key2) == 0;
-}
-
-static bool is_invalid_entry(char *buf, bool kernel)
-{
-	if (kernel && strchr(buf, '['))
-		return true;
-	if (!kernel && !strchr(buf, '['))
-		return true;
-	return false;
-}
-
-static bool skip_entry(char *name)
-{
-	/*
-	 * We attach to almost all kernel functions and some of them
-	 * will cause 'suspicious RCU usage' when fprobe is attached
-	 * to them. Filter out the current culprits - arch_cpu_idle
-	 * default_idle and rcu_* functions.
-	 */
-	if (!strcmp(name, "arch_cpu_idle"))
-		return true;
-	if (!strcmp(name, "default_idle"))
-		return true;
-	if (!strncmp(name, "rcu_", 4))
-		return true;
-	if (!strcmp(name, "bpf_dispatcher_xdp_func"))
-		return true;
-	if (!strncmp(name, "__ftrace_invalid_address__",
-		     sizeof("__ftrace_invalid_address__") - 1))
-		return true;
-	return false;
-}
-
-/* Do comparision by ignoring '.llvm.<hash>' suffixes. */
-static int compare_name(const char *name1, const char *name2)
-{
-	const char *res1, *res2;
-	int len1, len2;
-
-	res1 = strstr(name1, ".llvm.");
-	res2 = strstr(name2, ".llvm.");
-	len1 = res1 ? res1 - name1 : strlen(name1);
-	len2 = res2 ? res2 - name2 : strlen(name2);
-
-	if (len1 == len2)
-		return strncmp(name1, name2, len1);
-	if (len1 < len2)
-		return strncmp(name1, name2, len1) <= 0 ? -1 : 1;
-	return strncmp(name1, name2, len2) >= 0 ? 1 : -1;
-}
-
-static int load_kallsyms_compare(const void *p1, const void *p2)
-{
-	return compare_name(((const struct ksym *)p1)->name, ((const struct ksym *)p2)->name);
-}
-
-static int search_kallsyms_compare(const void *p1, const struct ksym *p2)
-{
-	return compare_name(p1, p2->name);
-}
-
-static int get_syms(char ***symsp, size_t *cntp, bool kernel)
-{
-	size_t cap = 0, cnt = 0;
-	char *name = NULL, *ksym_name, **syms = NULL;
-	struct hashmap *map;
-	struct ksyms *ksyms;
-	struct ksym *ks;
-	char buf[256];
-	FILE *f;
-	int err = 0;
-
-	ksyms = load_kallsyms_custom_local(load_kallsyms_compare);
-	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_custom_local"))
-		return -EINVAL;
-
-	/*
-	 * The available_filter_functions contains many duplicates,
-	 * but other than that all symbols are usable in kprobe multi
-	 * interface.
-	 * Filtering out duplicates by using hashmap__add, which won't
-	 * add existing entry.
-	 */
-
-	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
-		f = fopen("/sys/kernel/tracing/available_filter_functions", "r");
-	else
-		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
-
-	if (!f)
-		return -EINVAL;
-
-	map = hashmap__new(symbol_hash, symbol_equal, NULL);
-	if (IS_ERR(map)) {
-		err = libbpf_get_error(map);
-		goto error;
-	}
-
-	while (fgets(buf, sizeof(buf), f)) {
-		if (is_invalid_entry(buf, kernel))
-			continue;
-
-		free(name);
-		if (sscanf(buf, "%ms$*[^\n]\n", &name) != 1)
-			continue;
-		if (skip_entry(name))
-			continue;
-
-		ks = search_kallsyms_custom_local(ksyms, name, search_kallsyms_compare);
-		if (!ks) {
-			err = -EINVAL;
-			goto error;
-		}
-
-		ksym_name = ks->name;
-		err = hashmap__add(map, ksym_name, 0);
-		if (err == -EEXIST) {
-			err = 0;
-			continue;
-		}
-		if (err)
-			goto error;
-
-		err = libbpf_ensure_mem((void **) &syms, &cap,
-					sizeof(*syms), cnt + 1);
-		if (err)
-			goto error;
-
-		syms[cnt++] = ksym_name;
-	}
-
-	*symsp = syms;
-	*cntp = cnt;
-
-error:
-	free(name);
-	fclose(f);
-	hashmap__free(map);
-	if (err)
-		free(syms);
-	return err;
-}
-
-static int get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel)
-{
-	unsigned long *addr, *addrs, *tmp_addrs;
-	int err = 0, max_cnt, inc_cnt;
-	char *name = NULL;
-	size_t cnt = 0;
-	char buf[256];
-	FILE *f;
-
-	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
-		f = fopen("/sys/kernel/tracing/available_filter_functions_addrs", "r");
-	else
-		f = fopen("/sys/kernel/debug/tracing/available_filter_functions_addrs", "r");
-
-	if (!f)
-		return -ENOENT;
-
-	/* In my local setup, the number of entries is 50k+ so Let us initially
-	 * allocate space to hold 64k entries. If 64k is not enough, incrementally
-	 * increase 1k each time.
-	 */
-	max_cnt = 65536;
-	inc_cnt = 1024;
-	addrs = malloc(max_cnt * sizeof(long));
-	if (addrs == NULL) {
-		err = -ENOMEM;
-		goto error;
-	}
-
-	while (fgets(buf, sizeof(buf), f)) {
-		if (is_invalid_entry(buf, kernel))
-			continue;
-
-		free(name);
-		if (sscanf(buf, "%p %ms$*[^\n]\n", &addr, &name) != 2)
-			continue;
-		if (skip_entry(name))
-			continue;
-
-		if (cnt == max_cnt) {
-			max_cnt += inc_cnt;
-			tmp_addrs = realloc(addrs, max_cnt);
-			if (!tmp_addrs) {
-				err = -ENOMEM;
-				goto error;
-			}
-			addrs = tmp_addrs;
-		}
-
-		addrs[cnt++] = (unsigned long)addr;
-	}
-
-	*addrsp = addrs;
-	*cntp = cnt;
-
-error:
-	free(name);
-	fclose(f);
-	if (err)
-		free(addrs);
-	return err;
-}
-
 static void do_bench_test(struct kprobe_multi_empty *skel, struct bpf_kprobe_multi_opts *opts)
 {
 	long attach_start_ns, attach_end_ns;
@@ -670,7 +456,7 @@ static void test_kprobe_multi_bench_attach(bool kernel)
 	char **syms = NULL;
 	size_t cnt = 0;
 
-	if (!ASSERT_OK(get_syms(&syms, &cnt, kernel), "get_syms"))
+	if (!ASSERT_OK(bpf_get_ksyms(&syms, &cnt, kernel), "bpf_get_ksyms"))
 		return;
 
 	skel = kprobe_multi_empty__open_and_load();
@@ -696,13 +482,13 @@ static void test_kprobe_multi_bench_attach_addr(bool kernel)
 	size_t cnt = 0;
 	int err;
 
-	err = get_addrs(&addrs, &cnt, kernel);
+	err = bpf_get_addrs(&addrs, &cnt, kernel);
 	if (err == -ENOENT) {
 		test__skip();
 		return;
 	}
 
-	if (!ASSERT_OK(err, "get_addrs"))
+	if (!ASSERT_OK(err, "bpf_get_addrs"))
 		return;
 
 	skel = kprobe_multi_empty__open_and_load();
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index e246fe4b7b70..26cc50bbed8b 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -18,6 +18,7 @@
 #include <bpf/btf.h>
 #include <time.h>
 #include "bpf/libbpf_internal.h"
+#include "bpf/hashmap.h"
 #include "json_writer.h"
 
 #include "network_helpers.h"
@@ -646,6 +647,219 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name)
 	return bpf_map__fd(map);
 }
 
+static size_t symbol_hash(long key, void *ctx __maybe_unused)
+{
+	return str_hash((const char *) key);
+}
+
+static bool symbol_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return strcmp((const char *) key1, (const char *) key2) == 0;
+}
+
+static bool is_invalid_entry(char *buf, bool kernel)
+{
+	if (kernel && strchr(buf, '['))
+		return true;
+	if (!kernel && !strchr(buf, '['))
+		return true;
+	return false;
+}
+
+static bool skip_entry(char *name)
+{
+	/*
+	 * We attach to almost all kernel functions and some of them
+	 * will cause 'suspicious RCU usage' when fprobe is attached
+	 * to them. Filter out the current culprits - arch_cpu_idle
+	 * default_idle and rcu_* functions.
+	 */
+	if (!strcmp(name, "arch_cpu_idle"))
+		return true;
+	if (!strcmp(name, "default_idle"))
+		return true;
+	if (!strncmp(name, "rcu_", 4))
+		return true;
+	if (!strcmp(name, "bpf_dispatcher_xdp_func"))
+		return true;
+	if (!strncmp(name, "__ftrace_invalid_address__",
+		     sizeof("__ftrace_invalid_address__") - 1))
+		return true;
+	return false;
+}
+
+/* Do comparison by ignoring '.llvm.<hash>' suffixes. */
+static int compare_name(const char *name1, const char *name2)
+{
+	const char *res1, *res2;
+	int len1, len2;
+
+	res1 = strstr(name1, ".llvm.");
+	res2 = strstr(name2, ".llvm.");
+	len1 = res1 ? res1 - name1 : strlen(name1);
+	len2 = res2 ? res2 - name2 : strlen(name2);
+
+	if (len1 == len2)
+		return strncmp(name1, name2, len1);
+	if (len1 < len2)
+		return strncmp(name1, name2, len1) <= 0 ? -1 : 1;
+	return strncmp(name1, name2, len2) >= 0 ? 1 : -1;
+}
+
+static int load_kallsyms_compare(const void *p1, const void *p2)
+{
+	return compare_name(((const struct ksym *)p1)->name, ((const struct ksym *)p2)->name);
+}
+
+static int search_kallsyms_compare(const void *p1, const struct ksym *p2)
+{
+	return compare_name(p1, p2->name);
+}
+
+int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
+{
+	size_t cap = 0, cnt = 0;
+	char *name = NULL, *ksym_name, **syms = NULL;
+	struct hashmap *map;
+	struct ksyms *ksyms;
+	struct ksym *ks;
+	char buf[256];
+	FILE *f;
+	int err = 0;
+
+	ksyms = load_kallsyms_custom_local(load_kallsyms_compare);
+	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_custom_local"))
+		return -EINVAL;
+
+	/*
+	 * The available_filter_functions contains many duplicates,
+	 * but other than that all symbols are usable to trace.
+	 * Filtering out duplicates by using hashmap__add, which won't
+	 * add existing entry.
+	 */
+
+	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
+		f = fopen("/sys/kernel/tracing/available_filter_functions", "r");
+	else
+		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
+
+	if (!f)
+		return -EINVAL;
+
+	map = hashmap__new(symbol_hash, symbol_equal, NULL);
+	if (IS_ERR(map)) {
+		err = libbpf_get_error(map);
+		goto error;
+	}
+
+	while (fgets(buf, sizeof(buf), f)) {
+		if (is_invalid_entry(buf, kernel))
+			continue;
+
+		free(name);
+		if (sscanf(buf, "%ms$*[^\n]\n", &name) != 1)
+			continue;
+		if (skip_entry(name))
+			continue;
+
+		ks = search_kallsyms_custom_local(ksyms, name, search_kallsyms_compare);
+		if (!ks) {
+			err = -EINVAL;
+			goto error;
+		}
+
+		ksym_name = ks->name;
+		err = hashmap__add(map, ksym_name, 0);
+		if (err == -EEXIST) {
+			err = 0;
+			continue;
+		}
+		if (err)
+			goto error;
+
+		err = libbpf_ensure_mem((void **) &syms, &cap,
+					sizeof(*syms), cnt + 1);
+		if (err)
+			goto error;
+
+		syms[cnt++] = ksym_name;
+	}
+
+	*symsp = syms;
+	*cntp = cnt;
+
+error:
+	free(name);
+	fclose(f);
+	hashmap__free(map);
+	if (err)
+		free(syms);
+	return err;
+}
+
+int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel)
+{
+	unsigned long *addr, *addrs, *tmp_addrs;
+	int err = 0, max_cnt, inc_cnt;
+	char *name = NULL;
+	size_t cnt = 0;
+	char buf[256];
+	FILE *f;
+
+	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
+		f = fopen("/sys/kernel/tracing/available_filter_functions_addrs", "r");
+	else
+		f = fopen("/sys/kernel/debug/tracing/available_filter_functions_addrs", "r");
+
+	if (!f)
+		return -ENOENT;
+
+	/* In my local setup, the number of entries is 50k+ so Let us initially
+	 * allocate space to hold 64k entries. If 64k is not enough, incrementally
+	 * increase 1k each time.
+	 */
+	max_cnt = 65536;
+	inc_cnt = 1024;
+	addrs = malloc(max_cnt * sizeof(long));
+	if (addrs == NULL) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	while (fgets(buf, sizeof(buf), f)) {
+		if (is_invalid_entry(buf, kernel))
+			continue;
+
+		free(name);
+		if (sscanf(buf, "%p %ms$*[^\n]\n", &addr, &name) != 2)
+			continue;
+		if (skip_entry(name))
+			continue;
+
+		if (cnt == max_cnt) {
+			max_cnt += inc_cnt;
+			tmp_addrs = realloc(addrs, max_cnt);
+			if (!tmp_addrs) {
+				err = -ENOMEM;
+				goto error;
+			}
+			addrs = tmp_addrs;
+		}
+
+		addrs[cnt++] = (unsigned long)addr;
+	}
+
+	*addrsp = addrs;
+	*cntp = cnt;
+
+error:
+	free(name);
+	fclose(f);
+	if (err)
+		free(addrs);
+	return err;
+}
+
 int compare_map_keys(int map1_fd, int map2_fd)
 {
 	__u32 key, next_key;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 870694f2a359..477a785c8b5f 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -468,6 +468,8 @@ int trigger_module_test_write(int write_sz);
 int write_sysctl(const char *sysctl, const char *value);
 int get_bpf_max_tramp_links_from(struct btf *btf);
 int get_bpf_max_tramp_links(void);
+int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel);
+int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel);
 
 struct netns_obj;
 struct netns_obj *netns_new(const char *name, bool open);
-- 
2.39.5


