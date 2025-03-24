Return-Path: <bpf+bounces-54609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C8A6D9C1
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 13:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC961678E6
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC51725E473;
	Mon, 24 Mar 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4jlnpM3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A825E454
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817843; cv=none; b=rrOVoLWfOMxFFYt0UZjnXW65U32w1Vt2OHMUkWhy40p3Qxr6vRPYTsHWKGwFmstZ75NTTFmLGmWu34Gfns4GFg3zeWC7fgZQxwMbZToA/WUFmkbf2D/wTtDI1fiNvigRlbp7Yn5eMXy3AZ4tiCOasf/2c14mw6ykOT7TC8v0EUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817843; c=relaxed/simple;
	bh=fsPb0/xAUuWNQ1yyPjb6s5jDhHd4bvtr6NESEK4wlas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHv3Tk3phgrSNzRGd7+hS5pW8X+H8U3v7f8V2+OguniefqxWXt9vG4nm+r3ctk8dI2uj0Tek4rQl+oCAA5eLYNu4pPRx+dYgDU9H+tcpZDFwCZ/7UvurGWP2u7Pok6vp9lq5sacxMgTH+WXMilE0lzpiEOcmJUfY9ovZzhkNphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4jlnpM3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742817840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKXD/mujp+dUvYmRlp0CWi5l1KC2G2XyDqDO9KGt13A=;
	b=R4jlnpM3TH+IhmnkDBlAlEdwnHFx6QazxyvSinHtXQJwpiSPDchDWjilTFh7aDl1dxp2Em
	ijdo0mi+GdeVOeoyj0Kdb0U3SfBsfKrcjyN+K6XTj4ozeSvEwC6Q3NhlVh/isUR7zCINqq
	d5HptB5Wg0IXWoM6jDZtG82PCSKzunk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-VaPf9774MwGlk8D1qLDbUA-1; Mon,
 24 Mar 2025 08:03:56 -0400
X-MC-Unique: VaPf9774MwGlk8D1qLDbUA-1
X-Mimecast-MFC-AGG-ID: VaPf9774MwGlk8D1qLDbUA_1742817834
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA7921809CA3;
	Mon, 24 Mar 2025 12:03:53 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.25])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88F83180B485;
	Mon, 24 Mar 2025 12:03:48 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Add tests for string kfuncs
Date: Mon, 24 Mar 2025 13:03:29 +0100
Message-ID: <2a26a72e223811f3060d772f5e9c2cf217541f18.1741874348.git.vmalik@redhat.com>
In-Reply-To: <cover.1741874348.git.vmalik@redhat.com>
References: <cover.1741874348.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The tests use the RUN_TESTS helper which executes BPF programs with
BPF_PROG_TEST_RUN and check for the expected return value.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 .../selftests/bpf/prog_tests/string_kfuncs.c  | 10 ++++
 .../selftests/bpf/progs/string_kfuncs.c       | 58 +++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
new file mode 100644
index 000000000000..79dab172eb92
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Red Hat, Inc.*/
+#include <test_progs.h>
+#include "string_kfuncs.skel.h"
+
+void test_string_kfuncs(void)
+{
+	RUN_TESTS(string_kfuncs);
+}
+
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs.c b/tools/testing/selftests/bpf/progs/string_kfuncs.c
new file mode 100644
index 000000000000..9fb1ed5ba1fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Red Hat, Inc.*/
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+int bpf_strcmp(const char *cs, const char *ct) __ksym;
+char *bpf_strchr(const char *s, int c) __ksym;
+char *bpf_strchrnul(const char *s, int c) __ksym;
+char *bpf_strnchr(void *s, u32 s__sz, int c) __ksym;
+char *bpf_strnchrnul(void *s, u32 s__sz, int c) __ksym;
+char *bpf_strrchr(const char *s, int c) __ksym;
+size_t bpf_strlen(const char *s) __ksym;
+size_t bpf_strnlen(void *s, u32 s__sz) __ksym;
+size_t bpf_strspn(const char *s, const char *accept) __ksym;
+size_t bpf_strcspn(const char *s, const char *reject) __ksym;
+char *bpf_strpbrk(const char *cs, const char *ct) __ksym;
+char *bpf_strstr(const char *s1, const char *s2) __ksym;
+char *bpf_strstr(const char *s1, const char *s2) __ksym;
+char *bpf_strnstr(void *s1, u32 s1__sz, void *s2, u32 s2__sz) __ksym;
+
+char str1[] = "hello world";
+char str2[] = "hello";
+char str3[] = "world";
+char str4[] = "abc";
+char str5[] = "";
+
+#define __test(retval) SEC("syscall") __success __retval(retval)
+
+__test(0) int test_strcmp_eq(void *ctx) { return bpf_strcmp(str1, str1); }
+__test(1) int test_strcmp_neq(void *ctx) { return bpf_strcmp(str1, str2); }
+__test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str1, 'e') - str1; }
+__test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str1, '\0') - str1; }
+__test(0) u64 test_strchr_notfound(void *ctx) { return (u64)bpf_strchr(str1, 'x'); }
+__test(1) int test_strchrnul_found(void *ctx) { return bpf_strchrnul(str1, 'e') - str1; }
+__test(11) int test_strchrnul_notfound(void *ctx) { return bpf_strchrnul(str1, 'x') - str1; }
+__test(1) int test_strnchr_found(void *ctx) { return bpf_strnchr(str1, 5, 'e') - str1; }
+__test(11) int test_strnchr_null(void *ctx) { return bpf_strnchr(str1, 12, '\0') - str1; }
+__test(0) u64 test_strnchr_notfound(void *ctx) { return (u64)bpf_strnchr(str1, 5, 'w'); }
+__test(1) int test_strnchrnul_found(void *ctx) { return bpf_strnchrnul(str1, 5, 'e') - str1; }
+__test(11) int test_strnchrnul_notfound(void *ctx) { return bpf_strnchrnul(str1, 12, 'x') - str1; }
+__test(9) int test_strrchr_found(void *ctx) { return bpf_strrchr(str1, 'l') - str1; }
+__test(0) u64 test_strrchr_notfound(void *ctx) { return (u64)bpf_strrchr(str1, 'x'); }
+__test(11) size_t test_strlen(void *ctx) { return bpf_strlen(str1); }
+__test(11) size_t test_strnlen(void *ctx) { return bpf_strnlen(str1, 12); }
+__test(5) size_t test_strspn(void *ctx) { return bpf_strspn(str1, str2); }
+__test(2) size_t test_strcspn(void *ctx) { return bpf_strcspn(str1, str3); }
+__test(2) int test_strpbrk_found(void *ctx) { return bpf_strpbrk(str1, str3) - str1; }
+__test(0) u64 test_strpbrk_notfound(void *ctx) { return (u64)bpf_strpbrk(str1, str4); }
+__test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str1, str3) - str1; }
+__test(0) u64 test_strstr_notfound(void *ctx) { return (u64)bpf_strstr(str1, str4); }
+__test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str1, str5) - str1; }
+__test(6) int test_strnstr_found(void *ctx) { return bpf_strnstr(str1, 12, str3, 6) - str1; }
+__test(0) u64 test_strnstr_unsafe(void *ctx) { return (u64)bpf_strnstr(str1, 5, str3, 5); }
+__test(0) u64 test_strnstr_notfound(void *ctx) { return (u64)bpf_strnstr(str1, 12, str4, 4); }
+__test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str1, 5, str5, 1) - str1; }
+
+char _license[] SEC("license") = "GPL";
-- 
2.48.1


