Return-Path: <bpf+bounces-76016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56547CA23D3
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 04:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EA59305C4FF
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 03:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F52B3161B7;
	Thu,  4 Dec 2025 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bnSJ4n+B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D42314B6A
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816647; cv=none; b=eYZqOLIdC/q+Qqi8SEsMQb9FtBwiDRXJRsPA27ctT8gWxN9PqDE0808PrSTSuLcwKqdFxlHiB2CNswJrmU4SnyLDuGOZo+Kp0OFwSIhiioH+r40DGyub7sOISPq3v3SgK5p08NhdzUnZceLd/juLDaDEvcQCQoZiNHPe6xuZNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816647; c=relaxed/simple;
	bh=QCDqMS2iL6NJvwlOUAHOfCZ1wJXr07eE1QzpvwzI2kI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L9G7oWaKcDOvdSFxM2x2y5TYhQ2k0qEiIDDhiniQ0DUSPx97FaHGBsXKA8/e9kP08wE2ZAIw9Fai82EVW4zVkvcpmAK6iIfVwVpNl0A/dDcdR2BX2tR3DwCOsiX0gR7gVCTbQ3Q1+9gehzvjCS0Ob37edICZhMOjh0ojQQSePNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bnSJ4n+B; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b9ceccbd7e8so843972a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 18:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764816631; x=1765421431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ojdYWQIWL/SNwbxa/IEirZwm3RCurubO9Kbb4a3348=;
        b=bnSJ4n+Buhvxweu8ey2pvCqDrfyzoP2+Oa8sg9E8tg0pYUxmjs1dXp71W4jLbmbv8F
         DeoOBwK7UM7eQq7K69/dzzD59LEkb7RUmtKrmnBS4FG9jXvXoqX29JR6ik7bFsIRu73Q
         fYQg1X65bBN5WWWMXteBqFRF4lpd301wpABf+iilN2MiuRKrZxP7ILrFKt04QkREL5lk
         XytzKL+Lg0n9/PLIYOAdZUkbPnOOytGfEph1gedwCNAL5+qkOc+s5z3ry4PZ2PjMaoUm
         o8k8V4JZOfjv5eRndEmKT0FZ/qeSjcK5oNXB2J3JIRM54Jwk0owufM4tTwmsjOwqNAUC
         anuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764816631; x=1765421431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ojdYWQIWL/SNwbxa/IEirZwm3RCurubO9Kbb4a3348=;
        b=QISTONrV3UMvqctEz12sCBlOvCktvtDlQNWXLynTMEw3Zlkc5n808EqufI4wuWjz8A
         xscrvew5CzSn18bOhIs0ar+jvbHvN385EJFviMJne2Uvqb9dK/BQh2MrKrLFkr51NLHd
         ib+yVlQ6gu02vOb3e6dTJ6MvLurYw7wbCKiGnOFPnh37uVboG5xhug20YaBYZfY9gy/Y
         qG4AtJH2fa9O2ixs98zM4w2JNyaRWeycLF+prpOTm9rgajLj6eRF6ZoBWCIhGovAu39l
         4d1UuGg7UxfvjoCmkDb4Bj47cKCDhzPZSDaOeh5/iZhnwxb+bT/A/o/E/+HqHbgud2p3
         2wJA==
X-Forwarded-Encrypted: i=1; AJvYcCUrsQD5/CbreV3CapKD2suNAMJzaq+xNW9QfZJkkAuOOzZ5xIFKAIv0Apf8hD+Xwx4chh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQ1/iDBm03PSczv5L7HlXvoChz7pFRK8wJ2jCCfIDNe7/3FeK
	4XwIOBihyEzaosTz0nTiOL/xaRkBce/rItuIk4SQAHySZxeeNjR8xZNeCq42kJ+DT+vOnIGqlNc
	14Lm9ycVqWdQE2w==
X-Google-Smtp-Source: AGHT+IE1IL3Y10G3B/sbvEiw46evUWtOH5VTTCB2roL1OD61dgKPHCl58pJNgzJKYfsG+Vq6sx889nyqCyW1Bg==
X-Received: from dycsd11.prod.google.com ([2002:a05:693c:310b:b0:2a4:5ebc:ca00])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:640d:b0:2a4:3593:9689 with SMTP id 5a478bee46e88-2ab92d39d41mr3811313eec.6.1764816631033;
 Wed, 03 Dec 2025 18:50:31 -0800 (PST)
Date: Wed,  3 Dec 2025 18:50:01 -0800
In-Reply-To: <20251204025003.3162056-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251204025003.3162056-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251204025003.3162056-5-wusamuel@google.com>
Subject: [PATCH v1 4/4] selftests/bpf: Open coded BPF wakeup_sources test
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: rafael.j.wysocki@intel.com, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This commit introduces a new selftest for the BPF wakeup_source iterator
to verify the functionality of open-coded iteration.

The test adds:
- A new BPF map `test_ws_hash` to track iterated wakeup source names.
- A BPF program `iter_ws_for_each` that iterates over wakeup sources and
  updates the `test_ws_hash` map with the names of found sources.
- A new subtest `subtest_ws_iter_check_open_coded` to trigger the BPF
  program and assert that the expected wakeup sources are marked in the
  map.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  5 ++
 .../bpf/prog_tests/wakeup_source_iter.c       | 42 +++++++++++++++++
 .../selftests/bpf/progs/wakeup_source_iter.c  | 47 +++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2cd9165c7348..e532999b91ca 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -598,6 +598,11 @@ extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak __ksym;
 
 extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 				 struct bpf_dynptr *value_p) __weak __ksym;
+struct bpf_iter_wakeup_source;
+extern int bpf_iter_wakeup_source_new(struct bpf_iter_wakeup_source *it) __weak __ksym;
+extern struct wakeup_source *bpf_iter_wakeup_source_next(
+		struct bpf_iter_wakeup_source *it) __weak __ksym;
+extern void bpf_iter_wakeup_source_destroy(struct bpf_iter_wakeup_source *it) __weak __ksym;
 
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
index 5cea4d4458f3..b2eaba38cc68 100644
--- a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
@@ -241,9 +241,37 @@ static void subtest_ws_iter_check_no_infinite_reads(
 	close(iter_fd);
 }
 
+static void subtest_ws_iter_check_open_coded(struct wakeup_source_iter *skel,
+					     int map_fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	char key[WAKEUP_SOURCE_NAME_LEN] = {0};
+	int err, fd;
+	bool found = false;
+
+	fd = bpf_program__fd(skel->progs.iter_ws_for_each);
+
+	err = bpf_prog_test_run_opts(fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	strncpy(key, test_ws_name, WAKEUP_SOURCE_NAME_LEN - 1);
+
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, key, &found),
+		       "lookup test_ws_name"))
+		return;
+
+	ASSERT_TRUE(found, "found test ws via bpf_for_each");
+}
+
 void test_wakeup_source_iter(void)
 {
 	struct wakeup_source_iter *skel = NULL;
+	int map_fd;
+	const bool found_val = false;
+	char key[WAKEUP_SOURCE_NAME_LEN] = {0};
 
 	if (geteuid() != 0) {
 		fprintf(stderr,
@@ -256,6 +284,17 @@ void test_wakeup_source_iter(void)
 	if (!ASSERT_OK_PTR(skel, "wakeup_source_iter__open_and_load"))
 		return;
 
+	map_fd = bpf_map__fd(skel->maps.test_ws_hash);
+	if (!ASSERT_OK_FD(map_fd, "map_fd"))
+		goto destroy_skel;
+
+	/* Copy test name to key buffer, ensuring it's zero-padded */
+	strncpy(key, test_ws_name, WAKEUP_SOURCE_NAME_LEN - 1);
+
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, key, &found_val, BPF_ANY),
+		       "insert test_ws_name"))
+		goto destroy_skel;
+
 	if (!ASSERT_OK(setup_test_ws(), "setup_test_ws"))
 		goto destroy;
 
@@ -274,8 +313,11 @@ void test_wakeup_source_iter(void)
 		subtest_ws_iter_check_sleep_times(skel);
 	if (test__start_subtest("no_infinite_reads"))
 		subtest_ws_iter_check_no_infinite_reads(skel);
+	if (test__start_subtest("open_coded"))
+		subtest_ws_iter_check_open_coded(skel, map_fd);
 
 destroy:
 	teardown_test_ws();
+destroy_skel:
 	wakeup_source_iter__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_iter.c b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
index 8c1470f06740..7812e773aa0c 100644
--- a/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
@@ -9,6 +9,13 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, WAKEUP_SOURCE_NAME_LEN);
+	__type(value, bool);
+	__uint(max_entries, 5);
+} test_ws_hash SEC(".maps");
+
 SEC("iter/wakeup_source")
 int wakeup_source_collector(struct bpf_iter__wakeup_source *ctx)
 {
@@ -68,3 +75,43 @@ int wakeup_source_collector(struct bpf_iter__wakeup_source *ctx)
 		       wakeup_count);
 	return 0;
 }
+
+SEC("syscall")
+int iter_ws_for_each(const void *ctx)
+{
+	struct wakeup_source *ws;
+
+	bpf_for_each(wakeup_source, ws) {
+		char name[WAKEUP_SOURCE_NAME_LEN];
+		const char *pname;
+		bool *found;
+		long len;
+		int i;
+
+		if (bpf_core_read(&pname, sizeof(pname), &ws->name))
+			return 1;
+
+		if (!pname)
+			continue;
+
+		len = bpf_probe_read_kernel_str(name, sizeof(name), pname);
+		if (len < 0)
+			return 1;
+
+		/*
+		 * Clear the remainder of the buffer to ensure a stable key for
+		 * the map lookup.
+		 */
+		bpf_for(i, len, WAKEUP_SOURCE_NAME_LEN)
+			name[i] = 0;
+
+		found = bpf_map_lookup_elem(&test_ws_hash, name);
+		if (found) {
+			bool t = true;
+
+			bpf_map_update_elem(&test_ws_hash, name, &t, BPF_EXIST);
+		}
+	}
+
+	return 0;
+}
-- 
2.52.0.177.g9f829587af-goog


