Return-Path: <bpf+bounces-50384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC57A26D4D
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 09:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DD33A84BE
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6A5207A06;
	Tue,  4 Feb 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiT9NoRt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261AD206F15;
	Tue,  4 Feb 2025 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657785; cv=none; b=G0GULsXbDzpICEgTMTrKIq1JBCBq11d5dtHjk42e7wULzgB16sIgQ2DwnG0QjEUg2rGw3qf+TzSCKMYWPsTFiEf3KrJWTl6kkOqGzJ2SDO5CWlI1gn7IWs7Z3MRt3wzPZW5ELoOMVhL1ckIrCC3u9wn5GXnqJk6iJxPRe1iXAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657785; c=relaxed/simple;
	bh=grBlq7AtrDzJznDIIMWKhUXEENML1Ru70TG8QouqedA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqNvAMFWmVXikmc0icMKywCXCOjMTk4YFWbRQ9zq9lhqhA/EjQnQB1/9lpbUahUXS3a7yhNGExFSMrJVD3Vv/Oijfa4KEMdmb7MBP/64V7gs+NmP0b50oWDqaT5u9UfKU7gOrB/UUgcrMO6amaPVShHspfn79EA1NJDInqJxzts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiT9NoRt; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso6702491a91.2;
        Tue, 04 Feb 2025 00:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738657783; x=1739262583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/rXpZZJDHG/iORGqfX0hjTAkoUOQszW7vZ0F9giU4M=;
        b=DiT9NoRt60TNAAmfpjYk7s21YIoCogrBQ4/J2Ng9vZwpX6t91FlQoOOBnY0KvYziDj
         dBjfxwhtb5BGs6O5eOo7Ve8yyZwd2FiDfmQPKlbIbtgjFvqlgbGN3JPRW8hCdIlLTDL+
         inIJDQ86j/Huz5GQkeoQDAwcpHsBgGE8wiZNNwp/noD/ePbL5TQ79MKswqeclWtkOezu
         Dl07t1bSLPutkxxVcEXeBcpAfU8s7I2bd7gUN/cGnQ5wVXLgYSsooL5JvIWMl7Jn6Mtw
         nCxftWaepUEDMbaLHmGXUJr7eFkxV8ExgJ+IrEFp/XSJU6c6MjYhaj6Z1aq+LIg1CSw2
         Lo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738657783; x=1739262583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/rXpZZJDHG/iORGqfX0hjTAkoUOQszW7vZ0F9giU4M=;
        b=f19XxGdU8skAqO0cV15nZzIsQY4nX8VQrxO21e7gVQFFNxbySB4GL5ANoARX6JWl4q
         UDfNhsTErPjoV622JMYVP+zafeaFGn4aOc1mFPPuxlvwChV8JvTHpN1hwvFFAAc5cmS+
         ovC3TneS5SzAsBoX27UXDo9vrIIEKBxRixBSqN/VPCTuJ265wQ+JU6uE0oW2vp774oWq
         lIgKtAS/XHnUsjtzX7YvtFRzkccNnCxtEf5anrQBtNUVpEwUam6y8y9qfEbJsUMR6e9Z
         FCXtSi04BWFdxFyF/uUJKLz0t2FfsCVqhD9uLRB5pNuqjudvhjUfIXZcFdnjQPYUFFvl
         UY1g==
X-Forwarded-Encrypted: i=1; AJvYcCXo61JcqT0pQV+/U3amwC8k+GodQ8ZxvZ9iwZnMeLX4zCxctUhkpF9bT7CaQEr+M43DL/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEX6ZAVIYrlMZGxLciR8/ltMkOHyPymNhZUibh1tL+cI4jlNc7
	L9L/WCyIr1mL7nKwynrhuwf0IL3lzLkYA0U7XWRrn6Jbe/RjdpOMBpVtX26JLXvfIw==
X-Gm-Gg: ASbGncuPL3O9AnFoqjImfhik8BhmvsUtKS4CtUReTX9iLUPzEUj5zajwM2kD/MFKmlQ
	ca8vPJr/mC2l2eiesfxoU2X78Olj6XMFTQfWATVZULY8jbKeGXKITyu9pu3hhS4/USTuXFMqCNr
	1ob3nuhrfXxiVNdgBfxZ2wKpsWgrBZ3z4C94BicxkRuBuBsOqE9sySUqZI+UybB8M+iWlsi2lxb
	9bQ/b9grDmUWYyBkney/bFXUuCBsek4+uVNVw5uZA5DQfDzec6lRfgjRJJwU3m9yZw3VGkp6Htk
	NiiiSxErnCSs
X-Google-Smtp-Source: AGHT+IE7qoevV/2Nueo/bysoZM0pFqAonau//1OeJSs0qmWUP13x2qewRIwThpkyE4IkwtRkidfEYw==
X-Received: by 2002:a17:90b:2585:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2f83ac8bb24mr40935768a91.33.1738657782854;
        Tue, 04 Feb 2025 00:29:42 -0800 (PST)
Received: from fedora.. ([183.156.115.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea80csm90826685ad.140.2025.02.04.00.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 00:29:42 -0800 (PST)
From: Hou Tao <hotforest@gmail.com>
To: bpf@vger.kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
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
	"Paul E . McKenney" <paulmck@kernel.org>,
	houtao1@huawei.com,
	hotforest@gmail.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add test case for atomic htab update
Date: Tue,  4 Feb 2025 16:28:48 +0800
Message-ID: <20250204082848.13471-4-hotforest@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204082848.13471-1-hotforest@gmail.com>
References: <20250204082848.13471-1-hotforest@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case to verify the atomic update of existing element in hash
map. The test proceeds in three steps:
1) fill the map with keys in the range [0, 63]
2) create 8 threads to lookup these keys concurrently
3) create 2 threads to overwrite these keys concurrently

Without atomic update support, the lookup operation may return -ENOENT
error and the test will fail. After the atomic-update change, the lookup
operation will always return 0 and the test will succeed.

Signed-off-by: Hou Tao <hotforest@gmail.com>
---
 .../selftests/bpf/prog_tests/htab_lookup.c    | 130 ++++++++++++++++++
 .../testing/selftests/bpf/progs/htab_lookup.c |  13 ++
 2 files changed, 143 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_lookup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_lookup.c b/tools/testing/selftests/bpf/prog_tests/htab_lookup.c
new file mode 100644
index 000000000000..ef9036827439
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/htab_lookup.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <test_progs.h>
+#include "htab_lookup.skel.h"
+
+struct htab_op_ctx {
+	int fd;
+	int loop;
+	unsigned int entries;
+	bool stop;
+};
+
+static void *htab_lookup_fn(void *arg)
+{
+	struct htab_op_ctx *ctx = arg;
+	int i = 0;
+
+	while (i++ < ctx->loop && !ctx->stop) {
+		unsigned int j;
+
+		for (j = 0; j < ctx->entries; j++) {
+			unsigned long key = j, value;
+			int err;
+
+			err = bpf_map_lookup_elem(ctx->fd, &key, &value);
+			if (err) {
+				ctx->stop = true;
+				return (void *)(long)err;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static void *htab_update_fn(void *arg)
+{
+	struct htab_op_ctx *ctx = arg;
+	int i = 0;
+
+	while (i++ < ctx->loop && !ctx->stop) {
+		unsigned int j;
+
+		for (j = 0; j < ctx->entries; j++) {
+			unsigned long key = j, value = j;
+			int err;
+
+			err = bpf_map_update_elem(ctx->fd, &key, &value, BPF_EXIST);
+			if (err) {
+				if (err == -ENOMEM)
+					continue;
+				ctx->stop = true;
+				return (void *)(long)err;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static int setup_htab(int fd, unsigned int entries)
+{
+	unsigned int i;
+
+	for (i = 0; i < entries; i++) {
+		unsigned long key = i, value = i;
+		int err;
+
+		err = bpf_map_update_elem(fd, &key, &value, 0);
+		if (!ASSERT_OK(err, "init update"))
+			return -1;
+	}
+
+	return 0;
+}
+
+void test_htab_lookup(void)
+{
+	unsigned int i, wr_nr = 2, rd_nr = 8;
+	pthread_t tids[wr_nr + rd_nr];
+	struct htab_lookup *skel;
+	struct htab_op_ctx ctx;
+	int err;
+
+	skel = htab_lookup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "htab_lookup__open_and_load"))
+		return;
+
+	ctx.fd = bpf_map__fd(skel->maps.htab);
+	ctx.loop = 50;
+	ctx.stop = false;
+	ctx.entries = 64;
+
+	err = setup_htab(ctx.fd, ctx.entries);
+	if (err)
+		goto destroy;
+
+	memset(tids, 0, sizeof(tids));
+	for (i = 0; i < wr_nr; i++) {
+		err = pthread_create(&tids[i], NULL, htab_update_fn, &ctx);
+		if (!ASSERT_OK(err, "pthread_create")) {
+			ctx.stop = true;
+			goto reap;
+		}
+	}
+	for (i = 0; i < rd_nr; i++) {
+		err = pthread_create(&tids[i + wr_nr], NULL, htab_lookup_fn, &ctx);
+		if (!ASSERT_OK(err, "pthread_create")) {
+			ctx.stop = true;
+			goto reap;
+		}
+	}
+
+reap:
+	for (i = 0; i < wr_nr + rd_nr; i++) {
+		void *ret = NULL;
+		char desc[32];
+
+		if (!tids[i])
+			continue;
+
+		snprintf(desc, sizeof(desc), "thread %u", i + 1);
+		err = pthread_join(tids[i], &ret);
+		ASSERT_OK(err, desc);
+		ASSERT_EQ(ret, NULL, desc);
+	}
+destroy:
+	htab_lookup__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/htab_lookup.c b/tools/testing/selftests/bpf/progs/htab_lookup.c
new file mode 100644
index 000000000000..baa30fa5b84f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/htab_lookup.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 64);
+	__type(key, unsigned long);
+	__type(value, unsigned long);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} htab SEC(".maps");
-- 
2.48.1


