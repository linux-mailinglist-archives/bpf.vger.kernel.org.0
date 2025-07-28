Return-Path: <bpf+bounces-64482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB985B135B0
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786B73AA46D
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 07:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB36D2367C4;
	Mon, 28 Jul 2025 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRAc4Nmm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857A231A3B;
	Mon, 28 Jul 2025 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687613; cv=none; b=LvfPkZH5gTVdW41nXIF9GpNMUVi/5+FMw1sx8fgz99VRgtD1H19d5cN/4TCgzP9tDLPocpJ2ebrLZR76I8HHlkE7Zrgb4AY3feZFDV7LcCiqhuQg388MgzHoH3XyslFTtSibZgIPQZbPoe0RTn6v7fCwBa9DfWhzPGQBmEYvQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687613; c=relaxed/simple;
	bh=zudiWkkAlg6yySZkWMGW/IXw6hzgirR0YopZ0oI3JAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPKgbPt727q31yvEoO6sNCNkpy0C/vDansA6lNe+puoPtVuSNLjR+5peymWSsboFvEuy4U6VCfXtRy9hAilJmvx0N5ffWMiLwfhaqoVFW1/RmACjx45dVwv6mAzMXLxSdNPVhDSgzvRzzjMOFe/4jtd20LlXwb0at1p+TeaDIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRAc4Nmm; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-31ef50d8d57so394093a91.0;
        Mon, 28 Jul 2025 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753687611; x=1754292411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8iwRQl4S0Ri7auKWOImDztrR8W3w7sQvsgC0R12G/0=;
        b=gRAc4NmmfgvWMgFH3sP/JeAU38nomaoZW8cHeZCmohCf9B7Pz5Ubtg2RjA4UDp7aUS
         QQ4xRG8Jel6ZzcDoC23pvfpwYJXOc7leSIjIqjyOoeQPQWT7rdty0UYgy7WtuPUzi0O2
         hvlr+TklY1yFNCDi0gd4Qdi2AWJON9aR4SzBq+mLFuB6HfII27Cz76x3Qb8GkzooKT3n
         WAgzgSOr8/YnOynH2E6qE6HcLAe0ObjO0CZDDYXUvinYq8IDDhaq5THtb+Cth3JlgTNr
         IqehUlsypg6nRXMlT8uaT7J3SzZuanoEg/aK5rgQuUNQprfLeOfcC0ZHfCRi+rkO1rMc
         AcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753687611; x=1754292411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8iwRQl4S0Ri7auKWOImDztrR8W3w7sQvsgC0R12G/0=;
        b=kDxcpI7drvx7DYPwsji1m6+S6dBuqtQ78CDskS3JM8s09rXBZFpyd6B6ehu376xL3l
         vSa/d5VhUsXJj1D7dKWsWnNC/XB61b7IEhen5SkhQJTE/mtrfupD8OJRk+dodIFKVNUn
         lD7fdd+tJ9UpLUHymYACsV2qa8fCNUdQ1s57HVRKibNS72jRpHuaKtmV1KrsemU4YsvU
         jvnPLJHsg8OJ+rnK6QasNI39pYuOyFqp4jJuMfHt5bIzj70R8xzHXiPK6w6PLITxcQTw
         YIes1BskkzTNraA/FhteD39vyUz73B+uil+J7VwPuiy9ki/XcNGsHb6SSOX8q0TZYbD2
         Nc8A==
X-Forwarded-Encrypted: i=1; AJvYcCUgIWhmVPQmEsJKAM62Debr+lqhFwr7IGrwYcyYZtvAm2vUP7078gr9gEx/G0IadFvrjrw=@vger.kernel.org, AJvYcCVb1kcQaLRo97aBBjfYluMZQR4WAKlgpP8Ya+xr2nCOo0PgviQ4gvHykh2eVpSMhEm4HWxirkbaR1Ecy9P55OQUvmDb@vger.kernel.org, AJvYcCXb6CwlDlnwoXUY0R+gvOTWWXNusGIM0fTGoahYgIzXLy4/xZhhSoUL6zI3JrmGX02hfRvUdKdY94Ah8vzQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sNq7hqjpXv48ElsCLmg1PB+JEgd+w4vOlHSohUBNoOYwRdaP
	sojQw5PSVw97xXRcoqSuz3Ee91kNIVO7E9Ez0o58esTIHmfaR7a7cjae
X-Gm-Gg: ASbGnct/+lNH07EBj7qflhKKHFYkEnhaVXISgyAbuPpdN8yEWgT9mQxQK91kJQfgpSr
	0a3+6X91koWggv6kxROLHF4qg0gxrViLjd8OWKKkoqmBeAH/XmIcZ2Q5IVXCtGsh/y1yvrHRVWl
	cA8bOtZS3ETwM+yPcJAlfEtX47WCjb12oMM8VVDImP26smfuDkfURYiRl0ENFOcHyv4KpiLpQZF
	Cued1FwWbFKEWw4P+cwei6I9NvXqzpQiEvYtwAnlA2IWFdta21dWNCqaF4BCLYT7Zt6PHmbdXJF
	M/n/Bt+0BNsIh5qbBGpYqsypOVBNGqJiDb9HQxHPeqzokZqcemipR8cft60cIvryO1GH74tdHI6
	XcI1jn+JzhbtqcvJnjlg=
X-Google-Smtp-Source: AGHT+IGX5hI0xOMRBS39G7QQApBvHC5rqfjHHC+lX+NkOiS304xvq30Gm0sNCZAm/R11cHzdXyQY1g==
X-Received: by 2002:a17:90b:3a88:b0:311:ea13:2e63 with SMTP id 98e67ed59e1d1-31e77867003mr14763631a91.13.1753687610421;
        Mon, 28 Jul 2025 00:26:50 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e949bbf7asm4459599a91.9.2025.07.28.00.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 00:26:50 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH RFC bpf-next v2 2/4] selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
Date: Mon, 28 Jul 2025 15:22:51 +0800
Message-ID: <20250728072637.1035818-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
References: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to get all the kernel function that can be traced sometimes, so we
move the get_syms() and get_addrs() in kprobe_multi_test.c to
trace_helpers.c and rename it to bpf_get_ksyms() and bpf_get_addrs().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +-----------------
 tools/testing/selftests/bpf/trace_helpers.c   | 214 +++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 3 files changed, 220 insertions(+), 217 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 81943c6254e6..d24baf244d1f 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -17,6 +17,7 @@
 #include <linux/limits.h>
 #include <libelf.h>
 #include <gelf.h>
+#include "bpf/hashmap.h"
 #include "bpf/libbpf_internal.h"
 
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
@@ -519,3 +520,216 @@ void read_trace_pipe(void)
 {
 	read_trace_pipe_iter(trace_pipe_cb, NULL, 0);
 }
+
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
+	if (!ksyms)
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
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 2ce873c9f9aa..9437bdd4afa5 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -41,4 +41,7 @@ ssize_t get_rel_offset(uintptr_t addr);
 
 int read_build_id(const char *path, char *build_id, size_t size);
 
+int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel);
+int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel);
+
 #endif
-- 
2.50.1


