Return-Path: <bpf+bounces-67685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C705BB4812F
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 01:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BE5189EF64
	for <lists+bpf@lfdr.de>; Sun,  7 Sep 2025 23:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C840235072;
	Sun,  7 Sep 2025 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pao2JTpA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B923183B
	for <bpf@vger.kernel.org>; Sun,  7 Sep 2025 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757286277; cv=none; b=sDNSn9njCyDB/e09OPDjP7s/MJnX8Ubq5S8RgT3AHC466f9ZNf5m/9wqTcWWOSdAslnpw4CzYR6Xdr/cpEgEFt5ZvrwCm7yXvrMzVgxzlsO7ajCV5+u4E+eeFxCRnZQqxMNDIwkq05jCPUh8DhPEhyHj2Ldfwxlt3+8Y99Zz1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757286277; c=relaxed/simple;
	bh=GIq31y9xzB8TFC/ZTZagrIOpYKVbUazUFnX8e3e+COg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vucg6UDVruTN1oLVqyyqd5qSlZu/AoMqlskN3LPpNHSP6cXNZ0rY531a+wzCsLWbEBpzQ0OssNfmGCsr0xXHEWFzdGWlnWlcQa5CmAsiomwRUyVbJ9RT31FOxIAccEetq2IIdNVVTA67RAVRYHDym4gojimZCAp5N34ZUqWQbS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pao2JTpA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24c784130e6so42616485ad.3
        for <bpf@vger.kernel.org>; Sun, 07 Sep 2025 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757286275; x=1757891075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGTCLy658JtzUlU/LIkV5gaaVJilu1gfYlyRzBD4JEY=;
        b=Pao2JTpAZ7QeJAaG5ZNk7p/0eqYZctkdvaCbx4NLaa0A1NPllc9cdMXRSfxHjv2bu/
         78Jppsl6omAvJyIqMoj+aQyuwYRRuEmr6szXlEnJXu1ohzFndlJ7Z+D8Y6uUpRMFZ/wc
         0a/lmT+yhPT3IPPshhZaT1kK5CpnLlmJRSI4nX55AUykEN7QrHUKPGQrDSQANJmVFmu1
         U3jwIZM8SHCWjNXDGZhaXTpr83R/NivsEw4tqhjSsmReDh7bfnY0h5oEg3bcnZNJrxaN
         ySo/NhB/RI59TTtg5aHNKFewNgv7OE9xv6MA7JBaIWByNhQkiQPZL+6f5WtmWtFSumQZ
         dyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757286275; x=1757891075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGTCLy658JtzUlU/LIkV5gaaVJilu1gfYlyRzBD4JEY=;
        b=a9dh1gRwKrw86O/246YkyafaMDg5SKUjzyjCtLxHdGeHTRQ0h5+sIWcWRLWyMYlccg
         GHeTe/jzbpj7fi7DhK/aFBsmYdk8OdrxpvkIk1GlSZxwjyO6senJS5FZ/CBQlk0AUTlN
         7nnhrC5VN8B3/i9cvyRBIuFrakXy7F8vcciKu1dita1WCudviVO6Op1Cx/KuA5DZ36Um
         4HnBspCwxxLtrK2gABu1SrdXu9mjML+vxzSzHmqRp/TW1V31ni1YNMwEYj2xi5tLgQ9y
         r6ibCwyTitpmkgGUIsN+rortOfAYpV3bw685Cr1jIn6uaFrl2ve+LK/J7VVqtFFXwa1F
         W4xg==
X-Gm-Message-State: AOJu0YyEgnxllPQ4GKl3346/oKzJGc8Lxyi/sm5M+PnwZS6NxRJXeHde
	WQcQqcuqsZevbkNwAyJeI0X8tTNK+EJYoHXDZtGv+oiDjqrmslHj4Tj4eanj2/Hs
X-Gm-Gg: ASbGncvOeL92cCutYvLPvBrOhNYTn1yXGR5VzikgfQCjhRfCM9LIo1ZEmpc1H/xYH5e
	CyC+99SHBbwdv/p+3reUf99X/VuAI+ycrFbMgIJqy/hpLGVQ8oRU90K4jBjHT8+AMy5hBhQ2Nfs
	5uTvAhqcdm4ULzSM/c/y27GN1t7kfHVCG/d/R0IySWH4pBmDRVk1yZqs9cwT0LqexHOjk9vEkFK
	BpH9VIWEpAT4eg93mLwQFrGq8oRRwusaC1crL/uu6j8CLSwvxvd/A4qLHaFTWRFBnCm/3Z+Apes
	N8GGksuMzaFn1lsXlFnwnWhuFXCZ4mJOnZA5Fr3SzEmaXU+eS44Ts3uqYUMC0thLNeHmguW69NI
	uGYgzKC5DpdWkarhAYye8xznvkQYECjoou+U31Q4xbb/flIjGNkXDcJqPDIRwoc6nZ454Zo7z+y
	15G3nZY2uHaMED2w7BR9giRNyJXiBpJ4o=
X-Google-Smtp-Source: AGHT+IFZ7IP6Hgv8cuoTazvKat5dqwhVfrfeg+YM3az2UhYS0w7spSZyQUHkgzhTdKRTmmIhQBDlMQ==
X-Received: by 2002:a17:902:f54c:b0:24e:95bb:88b1 with SMTP id d9443c01a7336-25171cbfb7dmr66491315ad.34.1757286274836;
        Sun, 07 Sep 2025 16:04:34 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24caf245690sm111254675ad.10.2025.09.07.16.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 16:04:34 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	djwillia@vt.edu,
	miloc@vt.edu,
	ericts@vt.edu,
	rahult@vt.edu,
	doniaghazy@vt.edu,
	quanzhif@vt.edu,
	jinghao7@illinois.edu,
	sidchintamaneni@gmail.com,
	memxor@gmail.com,
	egor@vt.edu,
	sairoop10@gmail.com,
	rjsu26@gmail.com
Subject: [PATCH 4/4] selftests/bpf: Adds selftests to check termination of long running nested bpf loops
Date: Sun,  7 Sep 2025 23:04:15 +0000
Message-ID: <20250907230415.289327-5-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250907230415.289327-1-sidchintamaneni@gmail.com>
References: <20250907230415.289327-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds tests checks for loops termination which are nested.

32/1    bpf_termination/bpf_termination:OK
32      bpf_termination:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Raj Sahu <rjsu26@gmail.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 .../bpf/prog_tests/bpf_termination.c          | 39 +++++++++++++++
 .../selftests/bpf/progs/bpf_termination.c     | 47 +++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_termination.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_termination.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_termination.c b/tools/testing/selftests/bpf/prog_tests/bpf_termination.c
new file mode 100644
index 000000000000..d060073db8f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_termination.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <sys/socket.h>
+
+#include "bpf_termination.skel.h"
+
+void test_loop_termination(void)
+{
+	struct bpf_termination *skel;
+	int err;
+	
+	skel = bpf_termination__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_termination__open"))
+	        return;
+	
+	err = bpf_termination__load(skel);
+	if (!ASSERT_OK(err, "bpf_termination__load"))
+	        goto out;
+	
+	skel->bss->pid = getpid();
+	err = bpf_termination__attach(skel);
+	if (!ASSERT_OK(err, "bpf_termination__attach"))
+	        goto out;
+	
+	/* Triggers long running BPF program */
+	socket(AF_UNSPEC, SOCK_DGRAM, 0);
+
+	/* If the program is not terminated, it doesn't reach this point */
+	ASSERT_TRUE(true, "Program is terminated");
+out:
+       bpf_termination__destroy(skel);
+}
+
+void test_bpf_termination(void)
+{
+	if (test__start_subtest("bpf_termination"))
+		test_loop_termination();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_termination.c b/tools/testing/selftests/bpf/progs/bpf_termination.c
new file mode 100644
index 000000000000..36e97d84750b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_termination.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+int pid;
+
+#define LOOPS_CNT 1 << 10
+
+static int callback_fn4(void *ctx) {
+	return 0;
+}
+
+static int callback_fn3(void *ctx) {
+
+	bpf_loop(LOOPS_CNT, callback_fn4, NULL, 0);
+	return 0;
+
+}
+
+
+static int callback_fn2(void *ctx) {
+
+	bpf_loop(LOOPS_CNT, callback_fn3, NULL, 0);
+	return 0;
+
+}
+
+static int callback_fn(void *ctx) {
+
+	bpf_loop(LOOPS_CNT, callback_fn2, NULL, 0);
+	return 0;
+
+}
+
+SEC("tp/syscalls/sys_enter_socket")
+int bpf_loop_lr(void *ctx) {
+
+	if ((bpf_get_current_pid_tgid() >> 32) != pid)
+		return 0;
+
+	bpf_loop(LOOPS_CNT, callback_fn, NULL, 0);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


