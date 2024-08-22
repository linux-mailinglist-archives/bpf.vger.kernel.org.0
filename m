Return-Path: <bpf+bounces-37830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3B95AFD1
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323D02844C2
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E91D16DC15;
	Thu, 22 Aug 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY9vFaiR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E719470
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313704; cv=none; b=UqpoyIouW/fk9Q+jpgCDhwaHv6U24g+9ukILWPmPbZHSLkMXDQmRkUcvD0BZa4KxJ8/GLQJNHG9wg8BhlUmFm+FTA538U5omsK3auGUR2SmD9eFkLzwHXXGM9yHWLoxCsMftED7riIRsz7QQ2J0a79NkjzPGXtiG3K2hMp/r4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313704; c=relaxed/simple;
	bh=E8jMbnpSVSd1Wnd75l0McI+0bHNQFt7AMri7u1mGlCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5r/t2xIouskBWNloBwQNhcpl3B5Sd0TioXJbO21yP4mTwZzUhevMxzjMn0Qd8DuROoZQuoVnonObWXVtVK4Ao8hTmn6WtS0QWSrbFuzCUllqdwGe+qsvrgIKyRloBFqGA4apMpxfbquk40FCpSuqqm/QzOAjIhc93cuTGu+W+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY9vFaiR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201fbd0d7c2so5027125ad.0
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724313702; x=1724918502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6vbz8n7f2I/mpXBTtUbKY1l3jcFD8guj2CHH6VYKj4=;
        b=MY9vFaiRnppc8t1/n2482eIpkXOkp9rUNjgLDlk4nR7zhPlqvGxplnGXqLx+RVFvQx
         XPJaQhoK2FjBdjVeXls/5oo/yDcbv5NG5xPB4rrh8pu3/xJKK5+lGT3UoHE/ZH9+PhS9
         5kj6RqCIlGFJ6jebbL+ZakK6EVSJgsr50kZ5JcO8b7lfxto5ca9KYyeZGK8RA1ML0PL6
         /bEFlRmT+6fujHhui6kBEAzlmmF+koXw/yrbK1oNzE/p4otiyvLjeaWFrwnzsyuqd489
         R5eYssJLz7LKZ/xirXZUTHv1qI+L+AQMbmF1/QSuqMmJontGp5T/xvXQVYx6h9cE1Ygg
         jNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724313702; x=1724918502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6vbz8n7f2I/mpXBTtUbKY1l3jcFD8guj2CHH6VYKj4=;
        b=wZl+IIUTYdwvkIJWYtlS8Gqymrfqqz16aGXBwEZJ8/fbQ6jLtdx4DhS3dJryOO9fq4
         0RMgABpWRX8oU9mMIOREekLgrevhKc8zAMlHZLHQr+GnRL7GjEbTrt8EJpxWF6i63UY8
         FpnNIg7RyWZiRIO7S4bFrqiiHkK+BTXDjPZQY8OEosap62WZE4hDet5Naj84vd4ggSBs
         xE0POWM7e6LY5d4vUiVkAkYHRw5Y/5xcFkqgbkvo8wMpyJvFFKDx9em1T2K84zsKnpkT
         CMk8QGn0td343JVugk5RgodP4RXhTJ9K0cqFACTL9XeCkLjZ4OKSMZbwQ95qUm7geMjP
         Li9Q==
X-Gm-Message-State: AOJu0YzonYywMtVx3b9GzD5TVHFoZy/WUTuHNi6upj2xkYdbSyCLzm5W
	7vBwLwCHUrILQWy00AlCFpAb/PU0gp7J3gn+c+jtEkWUiaIMOlPQ+TcAIGhH
X-Google-Smtp-Source: AGHT+IF7mVzllIoqP1IqUcDM5GUBRNwNqKe7Io+8sMKnzVIYiEEVnN/W1zOMHWbEtZIInm1tuRrVSQ==
X-Received: by 2002:a17:903:228a:b0:1ff:5135:130f with SMTP id d9443c01a7336-203681b16fcmr55475145ad.53.1724313701588;
        Thu, 22 Aug 2024 01:01:41 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557f093sm7233445ad.63.2024.08.22.01.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:01:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	cnitlrt@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: test for malformed BPF_CORE_TYPE_ID_LOCAL relocation
Date: Thu, 22 Aug 2024 01:01:24 -0700
Message-ID: <20240822080124.2995724-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822080124.2995724-1-eddyz87@gmail.com>
References: <20240822080124.2995724-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that verifier rejects BPF program containing relocation
pointing to non-existent BTF type.

To force relocation resolution on kernel side test case uses
bpf_attr->core_relos field. This field is not exposed by libbpf,
so directly do BPF system call in the test.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
new file mode 100644
index 000000000000..a18d3680fb16
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Test cases that can't load programs using libbpf and need direct
+ * BPF syscall access
+ */
+
+#include <sys/syscall.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+
+#include "test_progs.h"
+#include "test_btf.h"
+#include "bpf/libbpf_internal.h"
+
+static char log[16 * 1024];
+
+/* Check that verifier rejects BPF program containing relocation
+ * pointing to non-existent BTF type.
+ */
+static void test_bad_local_id(void)
+{
+	struct test_btf {
+		struct btf_header hdr;
+		__u32 types[15];
+		char strings[128];
+	} raw_btf = {
+		.hdr = {
+			.magic = BTF_MAGIC,
+			.version = BTF_VERSION,
+			.hdr_len = sizeof(struct btf_header),
+			.type_off = 0,
+			.type_len = sizeof(raw_btf.types),
+			.str_off = offsetof(struct test_btf, strings) -
+				   offsetof(struct test_btf, types),
+			.str_len = sizeof(raw_btf.strings),
+		},
+		.types = {
+			BTF_PTR_ENC(0),					/* [1] void*  */
+			BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),	/* [2] int    */
+			BTF_FUNC_PROTO_ENC(2, 1),			/* [3] int (*)(void*) */
+			BTF_FUNC_PROTO_ARG_ENC(8, 1),
+			BTF_FUNC_ENC(8, 3)			/* [4] FUNC 'foo' type_id=2   */
+		},
+		.strings = "\0int\0 0\0foo\0"
+	};
+	__u32 log_level = 1 | 2 | 4;
+	LIBBPF_OPTS(bpf_btf_load_opts, opts,
+		    .log_buf = log,
+		    .log_size = sizeof(log),
+		    .log_level = log_level,
+	);
+	struct bpf_insn insns[] = {
+		BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_func_info funcs[] = {
+		{
+			.insn_off = 0,
+			.type_id = 4,
+		}
+	};
+	struct bpf_core_relo relos[] = {
+		{
+			.insn_off = 0,		/* patch first instruction (r0 = 0) */
+			.type_id = 100500,	/* !!! this type id does not exist */
+			.access_str_off = 6,	/* offset of "0" */
+			.kind = BPF_CORE_TYPE_ID_LOCAL,
+		}
+	};
+	union bpf_attr attr;
+	int saved_errno;
+	int prog_fd = -1;
+	int btf_fd = -1;
+
+	btf_fd = bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
+	saved_errno = errno;
+	if (btf_fd < 0 || env.verbosity > VERBOSE_NORMAL) {
+		printf("-------- BTF load log start --------\n");
+		printf("%s", log);
+		printf("-------- BTF load log end ----------\n");
+	}
+	if (btf_fd < 0) {
+		PRINT_FAIL("bpf_btf_load() failed, errno=%d\n", saved_errno);
+		return;
+	}
+
+	log[0] = 0;
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_btf_fd = btf_fd;
+	attr.prog_type = BPF_TRACE_RAW_TP;
+	attr.license = (__u64)"GPL";
+	attr.insns = (__u64)&insns;
+	attr.insn_cnt = sizeof(insns) / sizeof(*insns);
+	attr.log_buf = (__u64)log;
+	attr.log_size = sizeof(log);
+	attr.log_level = log_level;
+	attr.func_info = (__u64)funcs;
+	attr.func_info_cnt = sizeof(funcs) / sizeof(*funcs);
+	attr.func_info_rec_size = sizeof(*funcs);
+	attr.core_relos = (__u64)relos;
+	attr.core_relo_cnt = sizeof(relos) / sizeof(*relos);
+	attr.core_relo_rec_size = sizeof(*relos);
+	prog_fd = sys_bpf_prog_load(&attr, sizeof(attr), 1);
+	saved_errno = errno;
+	if (prog_fd < 0 || env.verbosity > VERBOSE_NORMAL) {
+		printf("-------- program load log start --------\n");
+		printf("%s", log);
+		printf("-------- program load log end ----------\n");
+	}
+	if (prog_fd >= 0) {
+		PRINT_FAIL("sys_bpf_prog_load() expected to fail\n");
+		goto out;
+	}
+	ASSERT_HAS_SUBSTR(log, "relo #0: bad type id 100500", "program load log");
+
+out:
+	close(prog_fd);
+	close(btf_fd);
+}
+
+void test_core_reloc_raw(void)
+{
+	if (test__start_subtest("bad_local_id"))
+		test_bad_local_id();
+}
-- 
2.45.2


