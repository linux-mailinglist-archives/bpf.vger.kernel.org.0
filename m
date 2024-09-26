Return-Path: <bpf+bounces-40336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B2986C5F
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 08:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AA4CB2299F
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 06:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5836185E6E;
	Thu, 26 Sep 2024 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlMxS2JQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7247185941
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331529; cv=none; b=CBV4m/dQYyVZ+dcr4h2nqPTA4vSAQAX79ipXjjGipYQwCSLzlP7ETXR+QvHQXlWBW0tImIdQY9783KRuOuftPnd8/g/LjdRqCIp7EpXLtZ8eQJCkI7rHZysH1zqYw9K140ZoQ9vOoZU1NhfKlTAStv/jDtN/UZ7VpqNgXBsmwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331529; c=relaxed/simple;
	bh=m1TQSoCEWQiUlQH12wEOBWA4yAd9Km6f4HBclLYNfmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALr7HTU6yqP/fRDppO/243ahmSzuTvWVqjVHywxZCQfRvto9JUx2RpvoF3P2pl8uOrqzxcqYuGMnbPh5hAK3MidzO55mgm7Q8sKX323ym4e0iF67TjHB55OrCRF4qNcSRbvxwZcn8xJx5sk7Cyv52opsoVjreazg0THX8xOsQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlMxS2JQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727331525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZVWaeI6SaaqwhYLfOE9+bHktDs4NjzDVqk2vxgQJPA=;
	b=WlMxS2JQlz3ISJTz2dODrNv7SrMlMcs7AkmvWG5RM7Kxv55RBHrxAXcwt73WARsV1fNQIe
	GcgwfPay2pL2lTbUPBqGt65btnIouCjuSwIvA1cLH91wxYTYl8bA7qUygTyEBDKi3Tm6S4
	R+U2bqJrXOePs9zC3efd4uHiPbooUq0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-fS8SqtgKMnuLue8xWxQFJA-1; Thu,
 26 Sep 2024 02:18:43 -0400
X-MC-Unique: fS8SqtgKMnuLue8xWxQFJA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50E8919772D9;
	Thu, 26 Sep 2024 06:18:41 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9982E1956048;
	Thu, 26 Sep 2024 06:18:37 +0000 (UTC)
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
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for string kfuncs
Date: Thu, 26 Sep 2024 08:18:22 +0200
Message-ID: <343da0c9cbe75454e1a69d18acc902bf5d3b6c2b.1727329823.git.vmalik@redhat.com>
In-Reply-To: <cover.1727329823.git.vmalik@redhat.com>
References: <cover.1727329823.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The tests attach to `raw_tp/bpf_testmod_test_write_bare` triggerred by
`trigger_module_test_write` which writes the string "aaa..." of the
given size.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  37 +++
 .../selftests/bpf/progs/test_string_kfuncs.c  | 215 ++++++++++++++++++
 2 files changed, 252 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_string_kfuncs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
new file mode 100644
index 000000000000..4fe28a4ee6ad
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "test_string_kfuncs.skel.h"
+
+void test_string_kfuncs(void)
+{
+	const int WRITE_SZ = 10;
+	struct test_string_kfuncs *skel;
+	struct test_string_kfuncs__bss *bss;
+
+	skel = test_string_kfuncs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_string_kfuncs__open_end_load"))
+		return;
+
+	bss = skel->bss;
+
+	if (!ASSERT_OK(test_string_kfuncs__attach(skel), "test_string_kfuncs__attach"))
+		goto end;
+
+	ASSERT_OK(trigger_module_test_write(WRITE_SZ), "trigger_write");
+
+	ASSERT_EQ(bss->strcmp_check, 1, "test_strcmp");
+	ASSERT_EQ(bss->strchr_check, 1, "test_strchr");
+	ASSERT_EQ(bss->strrchr_check, 1, "test_strrchr");
+	ASSERT_EQ(bss->strnchr_check, 1, "test_strnchr");
+	ASSERT_EQ(bss->strstr_check, 1, "test_strstr");
+	ASSERT_EQ(bss->strnstr_check, 1, "test_strstr");
+	ASSERT_EQ(bss->strlen_check, 1, "test_strlen");
+	ASSERT_EQ(bss->strnlen_check, 1, "test_strnlen");
+	ASSERT_EQ(bss->strpbrk_check, 1, "test_strpbrk");
+	ASSERT_EQ(bss->strspn_check, 1, "test_strspn");
+	ASSERT_EQ(bss->strcspn_check, 1, "test_strspn");
+
+end:
+	test_string_kfuncs__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_string_kfuncs.c b/tools/testing/selftests/bpf/progs/test_string_kfuncs.c
new file mode 100644
index 000000000000..beeff3bcb00b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_string_kfuncs.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+#define BUFSZ 10
+
+int bpf_strcmp(const char *cs, const char *ct) __ksym;
+char *bpf_strchr(const char *s, int c) __ksym;
+char *bpf_strrchr(const char *s, int c) __ksym;
+char *bpf_strnchr(const char *s, size_t count, int c) __ksym;
+char *bpf_strstr(const char *s1, const char *s2) __ksym;
+char *bpf_strnstr(const char *s1, const char *s2, size_t len) __ksym;
+size_t bpf_strlen(const char *) __ksym;
+size_t bpf_strnlen(const char *s, size_t count) __ksym;
+char *bpf_strpbrk(const char *cs, const char *ct) __ksym;
+size_t bpf_strspn(const char *s, const char *accept) __ksym;
+size_t bpf_strcspn(const char *s, const char *reject) __ksym;
+
+__u32 strcmp_check = 0;
+
+SEC("raw_tp/bpf_testmod_test_write_bare")
+int BPF_PROG(test_strcmp,
+	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
+{
+	char buf[BUFSZ], *buf_ptr;
+	char expected[] = "aaaaaaaaa";
+
+	buf_ptr = BPF_PROBE_READ(write_ctx, buf);
+	bpf_probe_read_str(buf, sizeof(buf), buf_ptr);
+
+	if (bpf_strcmp(buf, expected) == 0)
+		strcmp_check = 1;
+
+	return 0;
+}
+
+__u32 strchr_check = 0;
+
+SEC("raw_tp/bpf_testmod_test_write_bare")
+int BPF_PROG(test_strchr,
+	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
+{
+	char buf[BUFSZ], *buf_ptr;
+
+	buf_ptr = BPF_PROBE_READ(write_ctx, buf);
+	bpf_probe_read_str(buf, sizeof(buf), buf_ptr);
+
+	if (bpf_strchr(buf, 'a') == buf)
+		strchr_check = 1;
+
+	return 0;
+}
+
+__u32 strrchr_check = 0;
+
+SEC("raw_tp/bpf_testmod_test_write_bare")
+int BPF_PROG(test_strrchr,
+	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
+{
+	char buf[BUFSZ], *buf_ptr;
+
+	buf_ptr = BPF_PROBE_READ(write_ctx, buf);
+	bpf_probe_read_str(buf, sizeof(buf), buf_ptr);
+
+	if (bpf_strrchr(buf, 'a') == &buf[8])
+		strrchr_check = 1;
+
+	return 0;
+}
+
+__u32 strnchr_check = 0;
+
+SEC("raw_tp/bpf_testmod_test_write_bare")
+int BPF_PROG(test_strnchr,
+	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
+{
+	char buf[BUFSZ], *buf_ptr;
+
+	buf_ptr = BPF_PROBE_READ(write_ctx, buf);
+	bpf_probe_read_str(buf, sizeof(buf), buf_ptr);
+
+	if (bpf_strnchr(buf, 1, 'a') == buf)
+		strnchr_check = 1;
+
+	return 0;
+}
+
+__u32 strstr_check = 0;
+
+SEC("raw_tp/bpf_testmod_test_write_bare")
+int BPF_PROG(test_strstr,
+	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
+{
+	char buf[BUFSZ], *buf_ptr;
+	char substr[] = "aaa";
+
+	buf_ptr = BPF_PROBE_READ(write_ctx, buf);
+	bpf_probe_read_str(buf, sizeof(buf), buf_ptr);
+
+	if (bpf_strstr(buf, substr) == buf)
+		strstr_check = 1;
+
+	return 0;
+}
+
+__u32 strnstr_check = 0;
+
+SEC("raw_tp/bpf_testmod_test_write_bare")
+int BPF_PROG(test_strnstr,
+	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
+{
+	char buf[BUFSZ], *buf_ptr;
+	char substr[] = "aaa";
+
+	buf_ptr = BPF_PROBE_READ(write_ctx, buf);
+	bpf_probe_read_str(buf, sizeof(buf), buf_ptr);
+
+	if (bpf_strnstr(buf, substr, 3) == buf)
+		strnstr_check = 1;
+
+	return 0;
+}
+
+__u32 strlen_check = 0;
+
+SEC("raw_tp/bpf_testmod_test_write_bare")
+int BPF_PROG(test_strlen,
+	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
+{
+	char buf[BUFSZ], *buf_ptr;
+
+	buf_ptr = BPF_PROBE_READ(write_ctx, buf);
+	bpf_probe_read_str(buf, sizeof(buf), buf_ptr);
+
+	if (bpf_strlen(buf) == 9)
+		strlen_check = 1;
+
+	return 0;
+}
+
+__u32 strnlen_check = 0;
+
+SEC("raw_tp/bpf_testmod_test_write_bare")
+int BPF_PROG(test_strnlen,
+	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
+{
+	char buf[BUFSZ], *buf_ptr;
+
+	buf_ptr = BPF_PROBE_READ(write_ctx, buf);
+	bpf_probe_read_str(buf, sizeof(buf), buf_ptr);
+
+	if (bpf_strnlen(buf, 5) == 5)
+		strnlen_check = 1;
+
+	return 0;
+}
+
+__u32 strpbrk_check = 0;
+
+SEC("raw_tp/bpf_testmod_test_write_bare")
+int BPF_PROG(test_strpbrk,
+	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
+{
+	char buf[BUFSZ], *buf_ptr;
+	char accept[] = "abc";
+
+	buf_ptr = BPF_PROBE_READ(write_ctx, buf);
+	bpf_probe_read_str(buf, sizeof(buf), buf_ptr);
+
+	if (bpf_strpbrk(buf, accept) == buf)
+		strpbrk_check = 1;
+
+	return 0;
+}
+
+__u32 strspn_check = 0;
+
+SEC("raw_tp/bpf_testmod_test_write_bare")
+int BPF_PROG(test_strspn,
+	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
+{
+	char buf[BUFSZ], *buf_ptr;
+	char accept[] = "abc";
+
+	buf_ptr = BPF_PROBE_READ(write_ctx, buf);
+	bpf_probe_read_str(buf, sizeof(buf), buf_ptr);
+
+	if (bpf_strspn(buf, accept) == 9)
+		strspn_check = 1;
+
+	return 0;
+}
+
+__u32 strcspn_check = 0;
+
+SEC("raw_tp/bpf_testmod_test_write_bare")
+int BPF_PROG(test_strcspn,
+	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
+{
+	char buf[BUFSZ], *buf_ptr;
+	char reject[] = "abc";
+
+	buf_ptr = BPF_PROBE_READ(write_ctx, buf);
+	bpf_probe_read_str(buf, sizeof(buf), buf_ptr);
+
+	if (bpf_strcspn(buf, reject) == 0)
+		strcspn_check = 1;
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.46.0


