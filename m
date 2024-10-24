Return-Path: <bpf+bounces-43028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC229AE022
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026562849E2
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB41AF0D9;
	Thu, 24 Oct 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ptuum9xb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA523CB;
	Thu, 24 Oct 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760895; cv=none; b=EqRKPcfZw5tYagAnHPcwMeGtueebwwe9LwtKNvOv6zNQR+i7cOfD5to5xZiF4FJLe08IFXvp3sJXoZRCZJWFq73lpGQXg6sA8f5yQsRfwywoXz5V0XCdJDAYE8zzW5bF/IrXVFZNaW90iKqgb53LpHtCC1EAtb85KY5ZTdyws6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760895; c=relaxed/simple;
	bh=LCDz0BjH5WXUYTeduPUXa/9qPryjKBr6/BXmKTsfKrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TkYEDPlbJrUcoOSBrvbIDidoddsAVszb3o8fb/bj27UJoXcKKz8s0rzbCCWJsYsVXqMXhpv7Py6/6sm3KOoZHuOiKwHuig9SE0J0CvYKXAbJNuSjkTOhZzd7dvh8LsyKVcezWw6Jp4TB/IDbswRw1mo+gTNv7xXF+GwjsoPqARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ptuum9xb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so498403b3a.0;
        Thu, 24 Oct 2024 02:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729760893; x=1730365693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FyfELd4QVPrc5+5AM3J7c0Vg01cAju9q8KqH3ru2oto=;
        b=Ptuum9xbt8VlVZaY87M5zlTzwYreViPRW5n5BpB1yBqAtN6P/yWmhoKksjJGjbomOb
         2bag7zDolTOvh1c5JBKfRGJghkuwwEYACAhRVPgjZ2LSWhlDX/1sj/kOoNSup3xRM0PY
         ygBWJVWZsuEQODBzqd/YtG52fDibX41w2+EZY9zEvmU1DMAI2CTtyyV5tjYyBsffXA7Z
         eZusjui6LgF9mAIulyDmf2bKbNYsMWIPLW8J3TmcTO88m9+X/bscQsul96bF5N1iJKke
         B+PpMoyS0hq/vwATQ/FbLS5/ojYqNvjDXgmtZSpRLnT690ev+m410jTORXMcEKGBIhAY
         w15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729760893; x=1730365693;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyfELd4QVPrc5+5AM3J7c0Vg01cAju9q8KqH3ru2oto=;
        b=i3rVp0rE90GOrmLYIqWIRrxj+k8e9EZGtQqxlZeUB14v9bDW1RGPb80aIlgUKNp+oz
         s0ztuOSg17YyTCtteiDP9GDC4oMjDWh5ffu1pPW6NS2d0UPq/WGu2w75DJHE4eal8iK2
         9NfHb7sbFA3BhC02YLM+bRzKIMNgjsUiexiuIS81JlDit1HZCPDJ7cqC0dFsXppsw2se
         Muit/jTPd5jmIhegJ/uxWY7GvGSrCyFk0qHrhoz8/NWFEOnfTgsqbHZ66KT8CgbxICMY
         t/YWQENZ1GR1G7FW4TQjRjmcycEpE1Q2xY305WYN/1UHfn0M5x41+jkVEDISNWJO1jes
         7qyg==
X-Forwarded-Encrypted: i=1; AJvYcCV902lyDi8FS75o/nSQzBUoj9P3OFW9XsnsJDTlSRJQEXmvQWRRN9ttILYoeHSYQMG4Ul88nP5cNWmQ3X4l@vger.kernel.org, AJvYcCVKSyEpeJnxiATR2B6/p/Jxp1jgTNW+fJWJrp5k8i7Rz2vGqsTP3O7OxaHCe6V6skWit1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RPPjoGeTXmj3b/QPSgBsKFF9x/FsPV726sbRYGhmMk3oA/ho
	BLmCFCZo4a0nmOnWid9wUrSyM5Em2nBv0qoZUroDhTIDf7OFiNSU46z+n73C
X-Google-Smtp-Source: AGHT+IHngrlbgbtsmzpQr/de9V/qtWKNgkShpDoBF8s2v+/L9N5JLFpww2TdNErR85Q7axjBA7n7oA==
X-Received: by 2002:a05:6a21:2d8c:b0:1d9:6c07:6481 with SMTP id adf61e73a8af0-1d978bd4b70mr6056738637.42.1729760892818;
        Thu, 24 Oct 2024 02:08:12 -0700 (PDT)
Received: from localhost.localdomain ([210.205.14.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d7416sm7551996b3a.101.2024.10.24.02.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:08:12 -0700 (PDT)
Date: Thu, 24 Oct 2024 18:08:07 +0900
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests/bpf: Add test for trie_get_next_key()
Message-ID: <ZxoOdzdMwvLspZiq@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>

Add a test for out-of-bounds write in trie_get_next_key() when a full
path from root to leaf exists and bpf_map_get_next_key() is called
with the leaf node. It may crashes the kernel on failure, so please
run in a VM.

Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>
---
 .../bpf/map_tests/lpm_trie_map_get_next_key.c | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c

diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c
new file mode 100644
index 000000000000..85b916b69411
--- /dev/null
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * WARNING
+ * -------
+ *  This test suite may crash the kernel, thus should be run in a VM.
+ */
+
+#define _GNU_SOURCE
+#include <linux/bpf.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <pthread.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include <test_maps.h>
+
+struct test_lpm_key {
+	__u32 prefix;
+	__u32 data;
+};
+
+struct get_next_key_ctx {
+	struct test_lpm_key key;
+	bool start;
+	bool stop;
+	int map_fd;
+	int loop;
+};
+
+static void *get_next_key_fn(void *arg)
+{
+	struct get_next_key_ctx *ctx = arg;
+	struct test_lpm_key next_key;
+	int i;
+
+	while (!ctx->start)
+		usleep(1);
+
+	while (!ctx->stop && i++ < ctx->loop)
+		bpf_map_get_next_key(ctx->map_fd, &ctx->key, &next_key);
+
+	return NULL;
+}
+
+static void abort_get_next_key(struct get_next_key_ctx *ctx, pthread_t *tids,
+			       unsigned int nr)
+{
+	unsigned int i;
+
+	ctx->stop = true;
+	ctx->start = true;
+	for (i = 0; i < nr; i++)
+		pthread_join(tids[i], NULL);
+}
+
+/* This test aims to prevent regression of future. As long as the kernel does
+ * not panic, it is considered as success.
+ */
+void test_lpm_trie_map_get_next_key(void)
+{
+#define MAX_NR_THREADS 256
+	LIBBPF_OPTS(bpf_map_create_opts, create_opts,
+		    .map_flags = BPF_F_NO_PREALLOC);
+	struct test_lpm_key key = {};
+	__u32 val = 0;
+	int map_fd;
+	const __u32 max_prefixlen = 8 * (sizeof(key) - sizeof(key.prefix));
+	const __u32 max_entries = max_prefixlen + 1;
+	unsigned int i, nr = MAX_NR_THREADS, loop = 4096;
+	pthread_t tids[MAX_NR_THREADS];
+	struct get_next_key_ctx ctx;
+	int err;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, "lpm_trie_map",
+				sizeof(struct test_lpm_key), sizeof(__u32),
+				max_entries, &create_opts);
+	CHECK(map_fd == -1, "bpf_map_create(), error:%s\n",
+	      strerror(errno));
+
+	for (i = 0; i <= max_prefixlen; i++) {
+		key.prefix = i;
+		err = bpf_map_update_elem(map_fd, &key, &val, BPF_ANY);
+		CHECK(err, "bpf_map_update_elem()", "error:%s\n",
+		      strerror(errno));
+	}
+
+	ctx.start = false;
+	ctx.stop = false;
+	ctx.map_fd = map_fd;
+	ctx.loop = loop;
+	memcpy(&ctx.key, &key, sizeof(key));
+
+	for (i = 0; i < nr; i++) {
+		err = pthread_create(&tids[i], NULL, get_next_key_fn, &ctx);
+		if (err) {
+			abort_get_next_key(&ctx, tids, i);
+			CHECK(err, "pthread_create", "error %d\n", err);
+		}
+	}
+
+	ctx.start = true;
+	for (i = 0; i < nr; i++)
+		pthread_join(tids[i], NULL);
+
+	printf("%s:PASS\n", __func__);
+
+	close(map_fd);
+}
-- 
2.43.5


