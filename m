Return-Path: <bpf+bounces-20832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7548084437E
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D26B22928
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2929A12A143;
	Wed, 31 Jan 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1Vn0quX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BC12A14E
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716584; cv=none; b=NmSpHoQAWGyL8V1pKyF/6nAsrttSPM5U6ZxipACTZQ4XpCOY/JqX+xUu3SqxRNnGfkX2+UAKQhvpS4geZhoDN0qBinpy7/lyQRg1C7t/Kp6omhA9uRw/yS/YPmojTqPkgfCIyL3udtNN87Q8Vmo5qYNxA8HOTwjodNhGQ9pMkpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716584; c=relaxed/simple;
	bh=hhkQYl8KcPRu+irtgULksjvTDiCQ+Pz2q9XPbYWzZds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWRv2kPkCvpuh5C9Hzsj0EPYZMxJUkCMbpjmT0zPGtnQZ9/pySNDh3KZ8pwXBV0BM0MOudGYGM5gbojc/JmQPERa/FQRDajkYznau3Goeh3mbrAmxJfvhYvJ7mJH1Ny+I5p1/Yy901Iqz+U4OeZJNftPsQGhmILVwizjpCJid2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1Vn0quX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddc0c02665so2454426b3a.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 07:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706716581; x=1707321381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+TCs+Apll2Yw+xvWmQD2/rWi5jB5u1UxsFg6nvQixg=;
        b=j1Vn0quXyBOXxREGTBH1vcp5l2vwBuviNU9ex4mwZAxJW7FszNMMb/kl/PXdlLbSfl
         DxRGCX+W4LRMxaGVXEGwgv8kigVIhfqWk2ARfHUxcsfGgF35pxxJN77zsxBkraZ9TGZ2
         ZrvrYHkpWqBuDj24tjV+B+1lI82D9R/VWgmew3lTv+IwMoJ3BEu2zwOQV7kjaQ0EhVdQ
         jZsIsFKaJ6eInFnC3sIuBXypJsMISyn5KIKqKaE+EEKfpJfBgR/OVHjcRPrkLaL4qqGM
         wtlYfnY+UbqPuR+NUb4HvmC/Rgr7ME+bF1T5ZJeMlaYmWSWotgFTL+U1HXJxI2v0YZ3a
         QyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716581; x=1707321381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+TCs+Apll2Yw+xvWmQD2/rWi5jB5u1UxsFg6nvQixg=;
        b=hdrIbKA6MDUBJjPPLrcsO7SDaxL823+Eq4cfRRSOewxmIue5VbVRJI2dOhhgNlAbwQ
         8g8ZRNtw0QXDe8Xm9Z7NBLZ6f9D5+oY5+b/OxvOTrKj+xW8+PjuZ8heqJZrBVlOXc+ZD
         zCvOYJj7rHSv0zwFbBqyH5W7Mx2q/n5DqVkrNIY98UCEP0XF0f8cqEP65PFzzm3Ms/wF
         6Qj8UoHMJ9w8wvq4CP1i9ugkjQlGHgm6fY33CJzmP+vD0UbZcSy8a/TJlkVBCJgABKW4
         t6BfUTUhYryq+jktLA0cIpK96ikw0ZkuOIlq3iLWovCRJJW0PesE1zs3+Z91Nz9q9uoS
         KlCw==
X-Gm-Message-State: AOJu0Ywu7gMVfzJEDw45GqZLACLAktvO95rckAnaU5qKuBsbXND6vnjZ
	sKqLV5QDScyFLF+N2k3e5yaQ78enABWe8hufVaBNdk0/gkJ5Vm9KaisDupWk
X-Google-Smtp-Source: AGHT+IHyt6p9GSJc+KCsdk+fYHns1Rurkgap0PU9UZHst5lhZuuz8d6Ole7pRwinWz/xGGr92ewcdA==
X-Received: by 2002:aa7:8c47:0:b0:6df:b9ae:98f7 with SMTP id e7-20020aa78c47000000b006dfb9ae98f7mr1791316pfd.10.1706716581596;
        Wed, 31 Jan 2024 07:56:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXSIA7/1rr7L7rKanhrpjMqiQHjiC2437B5PKbf/0BPhsel98VJiE3bOGjfJFZZAKixJ58CjbqIpfOAGQOgcQe4WoaOP2WlqEpRPg1GoNVQrVr/gp4JQZnaasAh5r/vHOJYYVCEUKLwYmUJxP4=
Received: from localhost.localdomain (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006ddc2cf3662sm10073450pfu.184.2024.01.31.07.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:56:21 -0800 (PST)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	Leon Hwang <hffilwlqm@gmail.com>
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add testcases for generic kfunc bpf_ffs64()
Date: Wed, 31 Jan 2024 23:56:07 +0800
Message-ID: <20240131155607.51157-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240131155607.51157-1-hffilwlqm@gmail.com>
References: <20240131155607.51157-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to confirm the kfunc bpf_ffs64() runs OK.

./tools/testing/selftests/bpf/test_progs -t bitops
12/1    bitops/bitops_ffs64:OK
12      bitops:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/bitops.c | 54 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bitops.c    | 21 ++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bitops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bitops.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bitops.c b/tools/testing/selftests/bpf/prog_tests/bitops.c
new file mode 100644
index 0000000000000..e4c68da626280
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bitops.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+
+#include <test_progs.h>
+
+/* test_ffs64 tests the generic kfunc bpf_ffs64().
+ */
+static void test_ffs64(void)
+{
+	struct bpf_object *obj = NULL;
+	struct bpf_program *prog;
+	char buff[128] = {};
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = buff,
+		.data_size_in = sizeof(buff),
+		.repeat = 1,
+	);
+
+	err = bpf_prog_test_load("bitops.bpf.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
+				 &prog_fd);
+	if (!ASSERT_OK(err, "load obj"))
+		return;
+
+	prog = bpf_object__find_program_by_name(obj, "tc_ffs64");
+	if (!ASSERT_OK_PTR(prog, "find tc_ffs64"))
+		goto out;
+
+#define TEST_FFS(n)						\
+	do {							\
+		u64 __n = 1;					\
+								\
+		*(u64 *)(void *) buff = (u64) (__n << n);	\
+		err = bpf_prog_test_run_opts(prog_fd, &topts);	\
+		ASSERT_OK(err, "run prog");			\
+		ASSERT_EQ(topts.retval, n, "run prog");		\
+	} while (0)
+
+	TEST_FFS(0);
+	TEST_FFS(1);
+	TEST_FFS(31);
+	TEST_FFS(63);
+
+#undef TEST_FFS
+out:
+	bpf_object__close(obj);
+}
+
+void test_bitops(void)
+{
+	if (test__start_subtest("bitops_ffs64"))
+		test_ffs64();
+}
diff --git a/tools/testing/selftests/bpf/progs/bitops.c b/tools/testing/selftests/bpf/progs/bitops.c
new file mode 100644
index 0000000000000..0863d1392b3d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bitops.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+unsigned long bpf_ffs64(u64 word) __ksym;
+
+SEC("tc")
+int tc_ffs64(struct __sk_buff *skb)
+{
+	void *data_end = (void *)(long)skb->data_end;
+	u64 *data = (u64 *)(long)skb->data;
+
+	if ((void *)(u64)(data + 1) > data_end)
+		return -1;
+
+	return bpf_ffs64(*data);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.42.1


