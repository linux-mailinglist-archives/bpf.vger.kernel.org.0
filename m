Return-Path: <bpf+bounces-52200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5518DA3FBC1
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 17:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EAA189A368
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4C1218593;
	Fri, 21 Feb 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZGo9rfnH"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69D20FA86
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155799; cv=none; b=J1gTTWv9WqWhvoWWVTvHl4N9UGgbYCW0a6PYR7D6okMSXIK+wv1blPrDNMq3gZa4SSyCVIoAuuOoIoZUU2+AmoHyO1WGz3+391t29//jyo6pykMI36X5pbYk/qPmocAr3NDXQNMwCFmwDg4OE0vwuRg3jlKyJtd0kuigIwhCQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155799; c=relaxed/simple;
	bh=iX7YqtTQujLLqaNAUh00iVuqffF/jAbti+QBntYH1tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mX2oOSrq7sa66+JFWdOGhJYxmZgTMkr59vYKuPEy00pDzLH7HQXbbmRSuDoEJjzlREiL/I7TV/AsZa0cUKeQbY369Tiz0LhH6gjtPre3CuYGgl8v6tPY0ZYkLwcl928xCnCIA4iUIKpL8Ojc51ggi9WdSu/4e/1fUI5YZb1Gi6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZGo9rfnH; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740155795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8rj6X3iOa/EdVnWOpvJZa4qIATKiMnTI+AiRDP2lgg=;
	b=ZGo9rfnHFOI2ll6L/pxZZNSZSsn/4h5DSdVFjyEdQYLlc8UnhLe5XY82bobN1nzc0oazwH
	Bxv1OuqV3p7zEmae3s83rtmCfkTtjMLZnTBdyW7hxlCYzltskSzIZ4x4lunPZKSsAuXs8N
	mcwAGJOeM0BBuTogYobqSZmAbSDmuiE=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com,
	Tao Chen <chen.dylane@linux.dev>,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: [PATCH bpf-next v8 4/4] selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
Date: Sat, 22 Feb 2025 00:33:35 +0800
Message-Id: <20250221163335.262143-5-chen.dylane@linux.dev>
In-Reply-To: <20250221163335.262143-1-chen.dylane@linux.dev>
References: <20250221163335.262143-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add selftests for prog_kfunc feature probing. Thanks for
Eduard providing the libbpf_probe_func_many test case.

 ./test_progs -t libbpf_probe_kfuncs
 #153     libbpf_probe_kfuncs:OK
 Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

 ./test_progs -t libbpf_probe_kfuncs_many
 #154     libbpf_probe_kfuncs_many:OK
 Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Cc: Tao Chen <dylane.chen@didiglobal.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 4ed46ed58a7b..db408fd67add 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -126,3 +126,176 @@ void test_libbpf_probe_helpers(void)
 		ASSERT_EQ(res, d->supported, buf);
 	}
 }
+
+static int module_btf_fd(char *module)
+{
+	int fd, err;
+	__u32 id = 0, len;
+	struct bpf_btf_info info;
+	char name[64];
+
+	while (true) {
+		err = bpf_btf_get_next_id(id, &id);
+		if (err)
+			return -1;
+
+		fd = bpf_btf_get_fd_by_id(id);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
+			return -1;
+		}
+		len = sizeof(info);
+		memset(&info, 0, sizeof(info));
+		info.name = ptr_to_u64(name);
+		info.name_len = sizeof(name);
+		err = bpf_btf_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			close(fd);
+			return -1;
+		}
+		/* find target module BTF */
+		if (!strcmp(name, module))
+			break;
+
+		close(fd);
+	}
+
+	return fd;
+}
+
+void test_libbpf_probe_kfuncs(void)
+{
+	int ret, kfunc_id, fd;
+	char *kfunc = "bpf_cpumask_create";
+	struct btf *vmlinux_btf = NULL;
+	struct btf *module_btf = NULL;
+
+	vmlinux_btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(vmlinux_btf, "btf_parse"))
+		return;
+
+	kfunc_id = btf__find_by_name_kind(vmlinux_btf, kfunc, BTF_KIND_FUNC);
+	if (!ASSERT_GT(kfunc_id, 0, kfunc))
+		goto cleanup;
+
+	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, -1, NULL);
+	if (!ASSERT_EQ(ret, 1, "kfunc in vmlinux support"))
+		goto cleanup;
+
+	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, -1, NULL);
+	if (!ASSERT_EQ(ret, 0, "kfunc in vmlinux not suuport"))
+		goto cleanup;
+
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, -1, -1, NULL);
+	if (!ASSERT_EQ(ret, 0, "invalid kfunc id:-1"))
+		goto cleanup;
+
+	ret = libbpf_probe_bpf_kfunc(100000, kfunc_id, -1, NULL);
+	if (!ASSERT_ERR(ret, "invalid prog type:100000"))
+		goto cleanup;
+
+	if (!env.has_testmod)
+		goto cleanup;
+
+	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (!ASSERT_OK_PTR(module_btf, "load module BTF"))
+		goto cleanup;
+
+	kfunc_id = btf__find_by_name(module_btf, "bpf_kfunc_call_test1");
+	if (!ASSERT_GT(kfunc_id, 0, "func not found"))
+		goto cleanup;
+
+	fd = module_btf_fd("bpf_testmod");
+	if (!ASSERT_GE(fd, 0, "module BTF fd"))
+		goto cleanup;
+
+	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_kfunc_call_test1 in bpf_testmod */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, fd, NULL);
+	if (!ASSERT_EQ(ret, 1, "kfunc in module BTF support"))
+		goto cleanup_fd;
+
+	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_kfunc_call_test1
+	 * in bpf_testmod
+	 */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, fd, NULL);
+	if (!ASSERT_EQ(ret, 0, "kfunc in module BTF not support"))
+		goto cleanup_fd;
+
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, -1, fd, NULL);
+	if (!ASSERT_EQ(ret, 0, "invalid kfunc id in module BTF"))
+		goto cleanup_fd;
+
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, 100, NULL);
+	ASSERT_EQ(ret, 0, "invalid BTF fd in module BTF");
+
+cleanup_fd:
+	close(fd);
+cleanup:
+	btf__free(vmlinux_btf);
+	btf__free(module_btf);
+}
+
+static const struct {
+	const char *name;
+	int code;
+} program_types[] = {
+#define _T(n) { #n, BPF_PROG_TYPE_##n }
+	_T(KPROBE),
+	_T(XDP),
+	_T(SYSCALL),
+	_T(SCHED_CLS),
+	_T(SCHED_ACT),
+	_T(SK_SKB),
+	_T(SOCKET_FILTER),
+	_T(CGROUP_SKB),
+	_T(LWT_OUT),
+	_T(LWT_IN),
+	_T(LWT_XMIT),
+	_T(LWT_SEG6LOCAL),
+	_T(NETFILTER),
+	_T(CGROUP_SOCK_ADDR),
+	_T(SCHED_ACT)
+#undef _T
+};
+
+void test_libbpf_probe_kfuncs_many(void)
+{
+	int i, kfunc_id, ret, id;
+	const struct btf_type *t;
+	struct btf *btf = NULL;
+	const char *kfunc;
+	const char *tag;
+
+	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+		return;
+	for (id = 0; id < btf__type_cnt(btf); ++id) {
+		t = btf__type_by_id(btf, id);
+		if (!t)
+			continue;
+		if (!btf_is_decl_tag(t))
+			continue;
+		tag = btf__name_by_offset(btf, t->name_off);
+		if (strcmp(tag, "bpf_kfunc") != 0)
+			continue;
+		kfunc_id = t->type;
+		t = btf__type_by_id(btf, kfunc_id);
+		if (!btf_is_func(t))
+			continue;
+		kfunc = btf__name_by_offset(btf, t->name_off);
+		for (i = 0; i < ARRAY_SIZE(program_types); ++i) {
+			ret = libbpf_probe_bpf_kfunc(program_types[i].code,
+						     kfunc_id, -1, NULL);
+			if (ret < 0) {
+				ASSERT_FAIL("kfunc:%s use prog type:%d",
+				      kfunc, program_types[i].code);
+				goto cleanup;
+			}
+		}
+	}
+cleanup:
+	btf__free(btf);
+}
-- 
2.43.0


