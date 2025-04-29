Return-Path: <bpf+bounces-56887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F71AA0006
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 04:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7533F4657D0
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 02:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8429CB51;
	Tue, 29 Apr 2025 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emb4/5V/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778C29CB4F
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745894529; cv=none; b=PaXtwXLsuZBjxmEqA2Frh85HKiMYQfUr2c+JOWx7RyaKlkpBOQWn7wHpmuMRLbhX/FgFoErxzwRi6TxhvLG1K17D7bK+QV2FggXaLuvHE3vt6IN7W8LSw+zNSg4zHAtDsQQhEwFUzGz17+7QzAmjDUj+IMvd69FEq4o2cYat0zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745894529; c=relaxed/simple;
	bh=pvlYtfd8IANKDkxD92GAF4hLEbiXQGXClvov1K7M2fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7ChS0A1vrSP/cd9v11OaQZhxHB14O/LinFLYmuoIz9J6k5vRT2jbbCiGeDfN+kXuYPX3Jio+JboSKfLDWDnu1L4uiI2fppqZCmaVWKhF3mNRbnniQG7K2cXqdpTDmwKuolQAzn/+R4TUNEY/fD30fwv3UNF4q4uIjWEeibLM8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Emb4/5V/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224171d6826so82278025ad.3
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 19:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745894527; x=1746499327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3QG2CpnPlW2O8r0CXBDdTY9z46Ur2fJxVr7OR5m68k=;
        b=Emb4/5V/i/FyxfyRnFe4ZSdaKQ2TI4/vvFFWnRa0cKCyY+tEauEL+4N8l4rqzMdocP
         67HijwzKUqBU5eNOaL2rkowSY2jVGWhZgJQP/LkRt2Ra2RPqZ199MODJ8tj12DVBak0g
         2qQEkNB2RGtEYOJOi/kblBdiiv18rfhwT+JN6dAhkCRXuY6dO0LOnwb7nMNqBIofBa9g
         468fzr6rBaMaIN0PH+5A79Q8ULq/aq9NQ8o7DlwWRZwQge28AOYRNOc29lgoyO5WVbuk
         E5jmCud0xBCRdDqIQutPkGzKwtPSFUMnycFK9TsCVnrAsyIf2HZyrZxCy5X55uAUFKHQ
         hMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745894527; x=1746499327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3QG2CpnPlW2O8r0CXBDdTY9z46Ur2fJxVr7OR5m68k=;
        b=LbdqrJG7LDbND09CdrpM51YczZKZ/Hjr4EVoKnt3qiyQfEl0KaNS6Nc96VConf4D9T
         +wFrhzg+xT3RNCY/pReRuNXvknl7WkX6a9SkddVMV/6B4jZpne+y+TvN3SvEzTsuvZvB
         U3+dQT5OwNA9cSNmflp1VcDAKxA6j75IECX6aD/jsCejjRUQIpgZOaKX6g0GoQ9XOJ/u
         i1UiAZxTefDAwLVm4EnxEvcl+UyC9L6zZkzpxJEpwO86v1Q24+z6LCNmV4ynFQ7ZkOdh
         ch7ebdiLRRi1/hAsbEiJ8j2O5xURvMI1tHB9WRYcRLTYnM/MqbYLXki63qQu86Ay5YYM
         wKQg==
X-Gm-Message-State: AOJu0YzV2NiLFBN0U4ezGzDolgzKurHIMz1NhJ2cl0NMymHtlvT4uaJx
	df0godB/5eK3xZcCWSo2JEnwFi82lxDDuiA0YjvXNZfkpKgYfD+T
X-Gm-Gg: ASbGncsJsejkT4HFmpnzWsH6TnflGta3P8Slz10rBnyzAHJUBXA1M81f5BUB60+8qB5
	o3YqpnorJGS8Mk1bearQZPZTh99dALJCJkTv2ZzaqIX1Fu1HdcPauuNwS1b9SsVFxvxMW8/7eWJ
	VeQ19imawtFhnG21fDujm7p8nFVCZYIqt0P98/hjjF4PFaWCKhS0M8Kntdt1DpzxXuBGLmxekLa
	r9Lr4mvtpknPLoR+7uTo70Lhno4pYfsBf7ftOmf3RCpstO5W3M6C3HxdoQzX/5V/vkBDrCV5l8C
	zqqiN96Wk5CVXczSM0D/3LHxQgeDloqgZds06bvjlB6jirT3w6Ur6MtXiSk3mPXk+C0ainY8dG9
	l
X-Google-Smtp-Source: AGHT+IEAPeUPVli4qWO5QlQ8d+cOcwqO5ztj8wQFajiMTD80rBatM9e7ukKG/Yqh5OXtnBM5KFGKnw==
X-Received: by 2002:a17:902:d50c:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-22dc69f83b7mr138676735ad.8.1745894527223;
        Mon, 28 Apr 2025 19:42:07 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097cb7sm9893211a91.22.2025.04.28.19.42.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Apr 2025 19:42:06 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 4/4] selftests/bpf: Add selftest for THP adjustment
Date: Tue, 29 Apr 2025 10:41:39 +0800
Message-Id: <20250429024139.34365-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250429024139.34365-1-laoar.shao@gmail.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this test case, we intentionally reject THP allocations via
madvise(MADV_HUGEPAGE) when THP is configured in either 'madvise' or
'always' mode. To prevent spurious failures (e.g., due to insufficient
memory for THP allocation), we deliberately omit testing the THP allocation
path when the system is configured with THP 'never' mode.

The result is as follows,

  $ ./test_progs --name="thp_adjust"
  #437     thp_adjust:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

CONFIG_TRANSPARENT_HUGEPAGE=y is required for this test.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/thp_adjust.c     | 176 ++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     |  32 ++++
 3 files changed, 209 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c378d5d07e02..bb8a8a9d77a2 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -113,3 +113,4 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
new file mode 100644
index 000000000000..bc307dac5bda
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/mman.h>
+#include <test_progs.h>
+#include "test_thp_adjust.skel.h"
+
+#define LEN (4 * 1024 * 1024) /* 4MB */
+#define THP_ENABLED_PATH "/sys/kernel/mm/transparent_hugepage/enabled"
+#define SMAPS_PATH "/proc/self/smaps"
+#define ANON_HUGE_PAGES "AnonHugePages:"
+
+static bool need_reset;
+static char *thp_addr;
+
+int parse_thp_setting(const char *buf)
+{
+	const char *start = strchr(buf, '[');
+	const char *end = start ? strchr(start, ']') : NULL;
+	char setting[32] = {0};
+	size_t len;
+
+	if (!start || !end || end <= start)
+		return -1;
+
+	len = end - start - 1;
+	if (len >= sizeof(setting))
+		len = sizeof(setting) - 1;
+
+	strncpy(setting, start + 1, len);
+	setting[len] = '\0';
+
+	if (strcmp(setting, "madvise") == 0 || strcmp(setting, "always") == 0)
+		return 0;
+	return 1;
+}
+
+int thp_set(void)
+{
+	const char *desired_value = "madvise";
+	char buf[32] = {0};
+	int fd, err;
+
+	fd = open(THP_ENABLED_PATH, O_RDWR);
+	if (fd == -1)
+		return -1;
+
+	err = read(fd, buf, sizeof(buf) - 1);
+	if (err == -1)
+		goto close_fd;
+
+	err = parse_thp_setting(buf);
+	if (err == -1 || err == 0)
+		goto close_fd;
+
+	err = lseek(fd, 0, SEEK_SET);
+	if (err == -1)
+		goto close_fd;
+
+	err = write(fd, desired_value, strlen(desired_value));
+	if (err == -1)
+		goto close_fd;
+	need_reset = true;
+
+close_fd:
+	close(fd);
+	return err;
+}
+
+int thp_reset(void)
+{
+	int fd, err;
+
+	if (!need_reset)
+		return 0;
+
+	fd = open(THP_ENABLED_PATH, O_WRONLY);
+	if (fd == -1)
+		return -1;
+
+	err = write(fd, "never", strlen("never"));
+	close(fd);
+	return err;
+}
+
+int thp_alloc(void)
+{
+	int err, i;
+
+	thp_addr = mmap(NULL, LEN, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (thp_addr == MAP_FAILED)
+		return -1;
+
+	err = madvise(thp_addr, LEN, MADV_HUGEPAGE);
+	if (err == -1)
+		goto unmap;
+
+	for (i = 0; i < LEN; i += 4096)
+		thp_addr[i] = 1;
+	return 0;
+
+unmap:
+	munmap(thp_addr, LEN);
+	return -1;
+}
+
+void thp_free(void)
+{
+	if (!thp_addr)
+		return;
+	munmap(thp_addr, LEN);
+}
+
+int thp_size(void)
+{
+	unsigned long total_kb = 0;
+	char *line, *saveptr;
+	ssize_t bytes_read;
+	char buf[4096];
+	int fd;
+
+	fd = open(SMAPS_PATH, O_RDONLY);
+	if (fd == -1)
+		return -1;
+
+	while ((bytes_read = read(fd, buf, sizeof(buf) - 1)) > 0) {
+		buf[bytes_read] = '\0';
+		line = strtok_r(buf, "\n", &saveptr);
+		while (line) {
+			if (strstr(line, ANON_HUGE_PAGES)) {
+				unsigned long kb;
+
+				if (sscanf(line + strlen(ANON_HUGE_PAGES), "%lu", &kb) == 1)
+					total_kb += kb;
+			}
+			line = strtok_r(NULL, "\n", &saveptr);
+		}
+	}
+
+	if (bytes_read == -1)
+		total_kb = -1;
+
+	close(fd);
+	return total_kb;
+}
+
+void test_thp_adjust(void)
+{
+	struct test_thp_adjust *skel;
+	int err;
+
+	skel = test_thp_adjust__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	skel->bss->target_pid = getpid();
+
+	err = test_thp_adjust__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto destroy;
+
+	err = test_thp_adjust__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto destroy;
+
+	if (!ASSERT_NEQ(thp_set(), -1, "THP set"))
+		goto destroy;
+	if (!ASSERT_NEQ(thp_alloc(), -1, "THP alloc"))
+		goto thp_reset;
+	ASSERT_EQ(thp_size(), 0, "THP size");
+	thp_free();
+
+thp_reset:
+	ASSERT_NEQ(thp_reset(), -1, "THP reset");
+destroy:
+	test_thp_adjust__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
new file mode 100644
index 000000000000..45026bba2c8d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define MM_BPF_ALLOWABLE        (1)
+#define MM_BPF_NOT_ALLOWABLE    (-1)
+
+int target_pid;
+
+SEC("fmod_ret/mm_bpf_thp_vma_allowable")
+int BPF_PROG(thp_vma_allowable, struct vm_area_struct *vma)
+{
+	struct task_struct *p;
+	struct mm_struct *mm;
+
+	if (!vma)
+		return 0;
+
+	mm = vma->vm_mm;
+	if (!mm)
+		return 0;
+
+	p = mm->owner;
+	/* The target task is not allowed to use THP. */
+	if (p->pid == target_pid)
+		return MM_BPF_NOT_ALLOWABLE;
+	return 0;
+}
-- 
2.43.5


