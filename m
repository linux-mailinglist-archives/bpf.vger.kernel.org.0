Return-Path: <bpf+bounces-48637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F6AA0A760
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 07:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312B23A8E5D
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 06:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43119153BD7;
	Sun, 12 Jan 2025 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+2lw/3N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF6153565;
	Sun, 12 Jan 2025 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736664340; cv=none; b=G3CBFrHd2+RN5Kv2zWEZLUbzlBL1Pe/2T4EmdkLFLSZyiHL1W+nrMthGaOy9jn9fK4gvWCbUta6oRrkddImFYKe2229WGIT0p79am931oh+ScbtyhfLFfB0lXkUtDdkeJHxFS9V5WyaqOEG4SLnSllPHf+HMRzst4/ODjdnplq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736664340; c=relaxed/simple;
	bh=FgiPQZLHjdBhvNHUb51LDXrk94brprSc2qxyNQ+EMuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMlFjZ2yJEF9urNHLdn0pZymGBb3l57m4Q/IegoKPwEMQqdHmU2zMe3WdItnT42qM9pCufMeTiPtinvTanXmKHVET+ZvIUhZVrNgDxQKD+cORKRBYRmLAqg9szlo3ODOie7UssdqXWiO4oV5Sv9L28siT3o3ePclYRsGtnJHC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+2lw/3N; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21649a7bcdcso54451335ad.1;
        Sat, 11 Jan 2025 22:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736664338; x=1737269138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeUUT6tB7eQseeCbJ+jJFiA2u3SRpa1tYvUiwFoYm5U=;
        b=c+2lw/3N7+omLWLkx0s6nJx834Po2mBFAZZp7TtCiSv/AfDxf1CqmIgFe3FzUHYkTm
         Z9jYevJ7WLXDxBmYORHncQN2+1Sh+jyp38ytTH5unq2BmGOug3+RavjD86KTlFU2U5k4
         4mjJRQrEYm1RrA/j2ZoU/H4du8ARPT+Zdrej/EFqoRWxqX0uX8KrZHw6tb+OKDKcL12M
         MMAOgQxrInH5RJKU/88sOdXFyY8LgvP0qqmteQsGHPsvRMFw1pPlvMxjQjoiGaxMSRDW
         QRTMZMYaTwyQ6rp32+bqKgJFQnozgToiqBSRRSCI0tEJD5Vs15A+1GCd5CIsQEVCakqH
         RJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736664338; x=1737269138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeUUT6tB7eQseeCbJ+jJFiA2u3SRpa1tYvUiwFoYm5U=;
        b=skEpIk1Bh/rMpKVtVzY6Tp6D394Wv1GBW9T2Q9iPPgBGt2ZEDv4WS1cOWdmKxo7yBZ
         HBSluxC1J8px5f7N7Ysl4+xV1MX//NSODMnTv7r4LrXhE1V1lqFVrXXiq8qSIuTv2jhV
         R5JYxo5lMAAjLF0bYJagmykWIG6X2yHyvBwJYN3sLaLdjQoSMNws5t8WKB2Ax7E1TnBP
         8zEvkhF8ocEJzO2MoRRtAoZARMHjjuhntuEIP6Au3tqqtfU/q5XKR5FIyOvJ3/BqJ1yv
         quFv+zqd9H6Tw2/fll2kXWNNcWBgYh3jCmKcK7NFK5HKTh2kuTPtsu1Q8LPyaNMBjid2
         /EZg==
X-Forwarded-Encrypted: i=1; AJvYcCWKZlr9FejuuOzuA4AHOT6TKfF39X1YZg6LxK15g2L6cTisAjTjS7P2MmFCNDTDAKnXIAwlDDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0P0U7wP52aKFFFPevT8xsoxOTEUEj2Np4DPf2GpU+IofJqmmr
	NUTqAnUAeiWmqqTLMf5q0TwpXEp8LvAKas6IXkfSjEppumHdabDe
X-Gm-Gg: ASbGncuYdwm4Er9bvKmyU13u3WudoKC+cfotVniAoTJRcmspEf2cLUhlnWII5aKxbs2
	oVIL2J5ji28dKHTIg8F5FPpYuyOSU5i7BGwNqbsWsGXUefILbiJGujDXDX9yQZCMt9wwnGTfgqA
	IxWTETApAFV4Vho13gToymcQR+hMrbNtx0eV3UQ2uJrzm7V2jegNl3T/bxBGk9VskTF9EEvAd65
	HTJmz8gVpXSJVgz6Ln/w8y4QBC203EyzkhGb5yZYCKExRtRN6MO5Y0kB3jzJsGZ9xrt9ygV0ISB
	2Rlyi2M=
X-Google-Smtp-Source: AGHT+IFs44GG6kYK4nUyeT+Ps3WlS6vlrgBcNAYDbMZxIvFUaCdnufX1qH9Ha7tb7IKllp6A6+kd5A==
X-Received: by 2002:a05:6a21:9007:b0:1e1:9fef:e959 with SMTP id adf61e73a8af0-1e88d12be47mr27476859637.27.1736664338607;
        Sat, 11 Jan 2025 22:45:38 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4059485bsm3791166b3a.83.2025.01.11.22.45.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jan 2025 22:45:38 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	edumazet@google.com,
	dxu@dxuuu.xyz
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 2/2] selftests/bpf: Add selftest for dynamic tracepoint
Date: Sun, 12 Jan 2025 14:45:13 +0800
Message-Id: <20250112064513.883-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250112064513.883-1-laoar.shao@gmail.com>
References: <20250112064513.883-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The result is as follows,

  $ tools/testing/selftests/bpf/test_progs --name=dynamic_tp
  #85      dynamic_tp:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../bpf/prog_tests/test_dynamic_tp.c          | 64 +++++++++++++++++++
 .../testing/selftests/bpf/progs/dynamic_tp.c  | 27 ++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_dynamic_tp.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynamic_tp.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_dynamic_tp.c b/tools/testing/selftests/bpf/prog_tests/test_dynamic_tp.c
new file mode 100644
index 000000000000..c205e0c8e3e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_dynamic_tp.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/bpf.h>
+
+#include "dynamic_tp.skel.h"
+
+int dynamic_tp(const char *cmd)
+{
+	const char *kprobe_file = "/sys/kernel/debug/tracing/kprobe_events";
+	ssize_t bytes_written;
+	int fd, err;
+
+	fd = open(kprobe_file, O_WRONLY | O_APPEND);
+	if (!ASSERT_GE(fd, 0, "open kprobe_events"))
+		return -1;
+
+	bytes_written = write(fd, cmd, strlen(cmd));
+	if (!ASSERT_GT(bytes_written, 0, "write kprobe_events")) {
+		close(fd);
+		return -1;
+	}
+
+	err = close(fd);
+	if (!ASSERT_OK(err, "close kprobe_events"))
+		return -1;
+	return 0;
+}
+
+void test_dynamic_tp(void)
+{
+	struct dynamic_tp *skel;
+	pid_t child_pid;
+	int status, err;
+
+	/* create a dynamic tracepoint */
+	err = dynamic_tp("p:my_dynamic_tp kernel_clone");
+	if (!ASSERT_OK(err, "create dynamic tp"))
+		return;
+
+	skel = dynamic_tp__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "load progs"))
+		goto remove_tp;
+	skel->bss->pid = getpid();
+	err = dynamic_tp__attach(skel);
+	if (!ASSERT_OK(err, "attach progs"))
+		goto cleanup;
+
+	/* trigger the dynamic tracepoint */
+	child_pid = fork();
+	if (!ASSERT_GT(child_pid, -1, "child_pid"))
+		goto cleanup;
+	if (child_pid == 0)
+		_exit(0);
+	waitpid(child_pid, &status, 0);
+
+	ASSERT_EQ(skel->bss->result, 1, "result");
+
+cleanup:
+	dynamic_tp__destroy(skel);
+remove_tp:
+	dynamic_tp("-:my_dynamic_tp kernel_clone");
+}
diff --git a/tools/testing/selftests/bpf/progs/dynamic_tp.c b/tools/testing/selftests/bpf/progs/dynamic_tp.c
new file mode 100644
index 000000000000..d3be37c220f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dynamic_tp.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define MAX_STACK_TRACE_DEPTH 32
+unsigned long entries[MAX_STACK_TRACE_DEPTH] = {};
+#define SIZE_OF_ULONG (sizeof(unsigned long))
+
+int result, pid;
+
+SEC("kprobe/kprobes/my_dynamic_tp")
+int dynamic_tp(struct pt_regs *ctx)
+{
+	int ret;
+
+	ret = bpf_get_stack(ctx, entries, MAX_STACK_TRACE_DEPTH * SIZE_OF_ULONG, 0);
+	if (ret < 0) {
+		result = -1;
+		return ret;
+	}
+	if (bpf_get_current_pid_tgid() >> 32 == pid)
+		result = 1;
+	return 0;
+}
-- 
2.43.5


