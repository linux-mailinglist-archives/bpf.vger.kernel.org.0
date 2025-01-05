Return-Path: <bpf+bounces-47888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19305A0196C
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 13:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD0D162991
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE922152E0C;
	Sun,  5 Jan 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9cKVJMF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B056F4F1;
	Sun,  5 Jan 2025 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081067; cv=none; b=iUBtz/blvet1OLx/05lLlD3/3m3IowwCZo2NWWdOnDHun+NryjB6PQxZRbEfdWe7iy0vDyOXrx9BiTE/LHTD5Nsd7xAEiMH72VyYwl0HDlf6EkQnCEMjO/axaK/ZQpvFX6oMKQBA6tHrvVfq4ns/TfYpgeH0mwtUSd+yBazdg70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081067; c=relaxed/simple;
	bh=0cMtjsYw5GYaOQQdPqWBMytXdL3KwOso5A2EwA2Vi14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/LY787a/sLRTsmFD7fwewukCYYR973CIgASbzURqqseijcrcmFnbcDeorB3fRZwNQkICGbPDPoMpiyc3qsHWloG7oUTsl/neBQseoIF+OMuAoZrOaWRpY8Q/nzVRL4xFPg0M7bB0qKL83Gu8zi1lgS1cZ5OV74Ul1sBqzSb4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9cKVJMF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2167141dfa1so188272655ad.1;
        Sun, 05 Jan 2025 04:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736081065; x=1736685865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTg+N44l+2GwWmpHJz9n/usIoOvMWh6cNhmUAu9Fkx0=;
        b=Z9cKVJMFzyjp/ORsB/60rZEY5DFLyOEviqF5CxnXlq4xJ/wdpcjmCz5xjkUeCf5Lgh
         LMWGrpUYBQl7aOQ7fjA0IVTGNhtgap5jn4jaugRvapmRXwzE77nvdVvXhEVazygic+Ch
         guvGNZ3xAWKkAvdAY7jZnGellOO+euaGqvq9YtCiit0sP5IKjZYheWriUcD/44/hhrpr
         qeWICOml0AYcAEa9dmxG3I6r7WeLJU6Tf3nWvVgELFpAt3fzGmASWA3xCIOmCFOpr7IZ
         LfD9i9912DI8C+yIiY5cO4I6azRJAOCi/XqqpASRCMqRWmbqXJTmQPyG4Fg6dnWcE4BY
         eiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736081065; x=1736685865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTg+N44l+2GwWmpHJz9n/usIoOvMWh6cNhmUAu9Fkx0=;
        b=L5FrJAAefr0ElM4HUNz66gTUYjqKC4kYwT6VT3hzpv7iTTgHqA2frMCrDu31a1MAWj
         tUNN8uHBNi/Ks9XIOuIb/jnX4D5O2wRYG4NgN1MPyEgan9rO8xN86QA2UDqZKzqrcMD1
         TCwpcAyHnuAfZ8vPxXrQqh9QfUJrncGCSo3tFfqxUUmGckvHFZ7PnK1goAAFUDnB66D/
         5XBsC+J1oJ+KSAept21CLJ6VTGhhQwvvttZbwkB9Ex5dpgJ3XWXHLNP5/L52mnhpX6sW
         LLyPx7roGpIGXp3aTQxZmIcYO4EyMnIpNR5gRCTPSMRFWt7lhn4fGkwApyo5YRabNmyT
         Y1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8p7nJ+Xdp/OCBBHCxiGfJcIIoROVIWmOo6YOgfu9NxIaTjcIqPX+9sV68/edFx9XfH1ZQYhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8wewYphXyZGxkGPByXzpkpDBKJyZto/g8JODJY1ZGCaLoiiJC
	r9OJJqEsT8o5EftWTU77Th1rjUWr1XpgV3aLgBAY4NMcxEt3v4iWAVl4qXHu
X-Gm-Gg: ASbGncu50C2O+J/Mw9SMr+6etOlKY/cD9QM94vTL09bRXTVZAUq8IIj1XWqoVjwzwHR
	b3OV3Hc4U7RTb2ZVUfG0PFmeY0o8JexVXCptoInDhQZ1RXYsydCQWZnL3jN8Kf5UhOyThN++9xY
	uzW6JmLS7nJMqLOsu6c4Q//4tMhwlnh1tQFTBBkilah9VSPCSTygxkrT0xtfy/Mr6eUiTi8Ubse
	rbSudt6Zwa8bZaOyaIBQhqZ0CIH1xVsUb921u6uZGZGAAlKDhCKcSZsthC8X+iHlwlBiDxvl7QP
	JU/EAzo=
X-Google-Smtp-Source: AGHT+IFc7Al9tZFYBPNzFE9E34/aK6HJN2XXuzNdUQWFaA6KW/XmAcnWEFLuxv47rFCY58lhSpUoPg==
X-Received: by 2002:a17:902:f646:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-219e6ca6c61mr875732575ad.2.1736081064820;
        Sun, 05 Jan 2025 04:44:24 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca01415sm275427215ad.231.2025.01.05.04.44.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jan 2025 04:44:24 -0800 (PST)
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
	edumazet@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add selftest for dynamic tracepoint
Date: Sun,  5 Jan 2025 20:44:03 +0800
Message-Id: <20250105124403.991-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250105124403.991-1-laoar.shao@gmail.com>
References: <20250105124403.991-1-laoar.shao@gmail.com>
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
index 000000000000..b3d46a3db03a
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
+		goto cleanup;
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
+	/* remove the dynamic tracepoint */
+	dynamic_tp("-:my_dynamic_tp kernel_clone");
+}
diff --git a/tools/testing/selftests/bpf/progs/dynamic_tp.c b/tools/testing/selftests/bpf/progs/dynamic_tp.c
new file mode 100644
index 000000000000..0aec0cd48547
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
+SEC("dynamic_tp/kprobes/my_dynamic_tp")
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


