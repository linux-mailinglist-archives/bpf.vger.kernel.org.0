Return-Path: <bpf+bounces-43222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713989B14F3
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 07:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AAA1C210AE
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 05:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A671632F1;
	Sat, 26 Oct 2024 05:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrBjgNnu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457F3398B;
	Sat, 26 Oct 2024 05:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729919106; cv=none; b=oe7qJ38DLUhKygO6T8fL+rhPcKAZnDmD2S/LYOPSq6NyrFD4A3FBB4qVVvib3IGTzgAVjMHalQKZGS3y69fnTNBYV3W682797f0bicsKOI/ZFQmojLL1a0C4aRsmVNEBxoW2UiHwMqmh/tRlIV07Em+7H3oKyeEzgFo0c1vAWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729919106; c=relaxed/simple;
	bh=83BNDMZYHh7THxcOT6EMx1nYZHH4/+7P9EvKGPKbppA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MRIO8/I73iML8oXV7as3z5tlcXzkHI2cvFfMY/3wOykAzPndAiGKgGcWIOu0Hrxj1RMYWjC0oXr0JGKeqtdJuyrNzlavfX1tAhmezd2XPNKTxZFQrG1dFHJjkRFWpsURbbaNrCGlYeXyndHDBYAwjgKuqAmPDCsAVlXA1jlzwhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrBjgNnu; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so2059182a12.0;
        Fri, 25 Oct 2024 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729919104; x=1730523904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1gFZ09BPOfzHvjNYWOqC2145s1yc+PKpA6ny3/E+XQ=;
        b=UrBjgNnupUF5Nr00nSph0OXvxbglevjI8G0PFhNvM6Sx0ElpLkg+E/SHAz4Tq5wjxE
         Lz/ZCcc+RhgAfqvuPJ2T8/g1OJ2cPNtf8BncmY7qE142hJ4fZ2yMxr+ee04yFEXAWlxF
         hrJhnDhr7mhC17mkufnZ54AMIVymne/ncCHGCkE3H+uHqELaCXDeOe/LqNn5HWJ3oEl1
         9aNMdKH8PFkdWpW8DC+hD1ukgBfK4vi7Z+q/NZ54RWP/4NbzzgIn8nz42SVquOAqWkIY
         gX/1XM6tStB8OEeHnDlidanQTkJyJIov39c8KVLQI7hAWB3G+Wioa3IP5IYimWRg/7OQ
         tX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729919104; x=1730523904;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1gFZ09BPOfzHvjNYWOqC2145s1yc+PKpA6ny3/E+XQ=;
        b=q8S7QJzVblMYc+ZYU01YcudIRfDVsuwnIE9z0xiHJCacKrKmH3rNW5dIN38Poftg5+
         v0/GTWcd9QoCrYU3e6LdsUIK99UWvtcXqNl0ONXQWp9Qp38NzTbWvdAoV+WhiLuzYwfO
         ccS34Jew2PIUsUU3NNkfAarowEVIys0VQu9tHCpHPEBTLETx1RgW5XXxhw6UqsjrAcZd
         fwJzAqcjQxw7N/EjMMh1i4jOlZ9yoAtDU+qWYaT2PaH94d2ORw7cXUGh5zRSR8YTKvco
         eGCfvbnm0B2zHwj4rrePCj4Mel1JFAgI+S5+2P/+IEKXYWNVJGVSermnvMiS1jSHs33G
         IwAA==
X-Forwarded-Encrypted: i=1; AJvYcCU4w6eQUqUzqfh93L89BIXuUYHn8aQBLo51449Q+gL4BQTgCYyrsN/p4uc4Bu7xnR6ft9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwukJi3KUX0wuHoWGrYEZtyunIEivmX8F6xwumOoVeaXYYzPbfK
	wvdQOjpZVY+g75AguPV9GeSb6HO/1exlBQ8tvVUMpk5BK5p06Fa5
X-Google-Smtp-Source: AGHT+IFOBqIZdLWrqdbJ8ern5k5129qAspVS4COwJfcywYv6snpMH/jgCI24HLI89bTyzo5kRfz2Kw==
X-Received: by 2002:a05:6a21:4781:b0:1d8:f5e1:6b30 with SMTP id adf61e73a8af0-1d9a850ab78mr2139652637.48.1729919103894;
        Fri, 25 Oct 2024 22:05:03 -0700 (PDT)
Received: from localhost.localdomain ([210.205.14.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3c20fsm1974695b3a.200.2024.10.25.22.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 22:05:03 -0700 (PDT)
Date: Sat, 26 Oct 2024 14:04:58 +0900
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Hou Tao <houtao@huaweicloud.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2 bpf 2/2] selftests/bpf: Add test for trie_get_next_key()
Message-ID: <Zxx4ep78tsbeWPVM@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxx384ZfdlFYnz6J@localhost.localdomain>

Add a test for out-of-bounds write in trie_get_next_key() when a full
path from root to leaf exists and bpf_map_get_next_key() is called
with the leaf node. It may crashes the kernel on failure, so please
run in a VM.

Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>
---
v1 -> v2:
  - Fixed a build error.
  - Removed unnecessary comments about crash-on-failure warning.
  - Fix a variable to be initialized before using it.
---
 .../bpf/map_tests/lpm_trie_map_get_next_key.c | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c

diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c
new file mode 100644
index 000000000000..0ba015686492
--- /dev/null
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
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
+	int i = 0;
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
+#define MAX_NR_THREADS 8
+	LIBBPF_OPTS(bpf_map_create_opts, create_opts,
+		    .map_flags = BPF_F_NO_PREALLOC);
+	struct test_lpm_key key = {};
+	__u32 val = 0;
+	int map_fd;
+	const __u32 max_prefixlen = 8 * (sizeof(key) - sizeof(key.prefix));
+	const __u32 max_entries = max_prefixlen + 1;
+	unsigned int i, nr = MAX_NR_THREADS, loop = 65536;
+	pthread_t tids[MAX_NR_THREADS];
+	struct get_next_key_ctx ctx;
+	int err;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, "lpm_trie_map",
+				sizeof(struct test_lpm_key), sizeof(__u32),
+				max_entries, &create_opts);
+	CHECK(map_fd == -1, "bpf_map_create()", "error:%s\n",
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


