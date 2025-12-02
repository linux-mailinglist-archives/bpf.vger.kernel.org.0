Return-Path: <bpf+bounces-75865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1968AC9A93E
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 08:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43EDF347AF3
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC93043A5;
	Tue,  2 Dec 2025 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRJ867LZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC03043A1
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662123; cv=none; b=eoQRzeYLppIwm7m1VvucBVmuWU2evjE5n5HwEmr3q6u+NrrSrEKBXPpmCYradnHegN+tRToS8oibNlAfqaxs5brsuRhSqeOKhkEIXCK0SCCJT8i+putbhPZ/UXP2ASNGhxt7oF1zBYhD9rVyVgufdo8F/4ViHwGxjePz6lRWViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662123; c=relaxed/simple;
	bh=DlEUECo7M63H1OqNhLS+qKZR0ruGpDHGQTpKkGqR9vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuoqYiHzkXn7tJFzWPGzFHpN4CHKzCgyFS01szVBWHcQDffvlm9B53ErbnDJm1jIfu2J1exzjzifIzmZxj3lU8hGA/+e/H+a8khJ/B92nMNZo5J0lMVfXH1oOE85Bu4/CAgx+rmHUcApkaVcfraBEHIiTJ+/1HcoDVNzbcmtJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRJ867LZ; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6420c08f886so6501199d50.3
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 23:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764662120; x=1765266920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5oKGhiBwYy+xZA2AKv2yiXglU9XOl18BMEeorRKrAk=;
        b=HRJ867LZxicxDGPMBMIAYwyKenAeeYqUFAWXPriGd8tsG+m3cy7Hf9pCnlS1FRsMr/
         vBTwGP2IR338zzI5m0A6zntcn+JfZ8lDVihbOu/WGrzZc8ytzJ6QlHVdOqyRM++dBlsn
         Q/OOwoiE0QW08G/hMTpuRN3jYtn8nNcoCo+nZIWbN4H0iVO5UL1dV56LzOP7iIb1vRP6
         MdOGhRPe/r8gHkbLM5PhgOrm2+AnB75Xq1NnSA1zTniFQ0rpwOlGSkiIFzETuD7E7dYO
         ic98SHOHkPqbqqDT4fGB/qm0Q2hvKqmmg1Zavxw5ey87MliRZrMwEEXD3SU82YsGZTbg
         97kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764662120; x=1765266920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5oKGhiBwYy+xZA2AKv2yiXglU9XOl18BMEeorRKrAk=;
        b=JxQTNri73X+VEj/I5bVhiYzBmg7BlBRh2LcLltdieo9wjDA14ll5V2gFLAT5NVTCYZ
         Tqm9J1dAmmC9m53LkVToqEyYqiOkd93a5hHnNnpcElNg1fojWfsEDxtPkF8MvlhAQIrF
         8RYtzY9RktEaUQ2XOIWLhJmP7xJfCVW1nmpeyR1pzerOKGT68ZQElj03CiRU0JzOn55y
         xnIRsrbFaFz+FI6c7CZ6yuB/M9p3rI+X9mq2UKGfcrzeoioY9jHY5SydyJueB6bVP/BL
         gSdOsKJNPoDWOLrs3qSyL3CcV8o2DgIpOLSd690ViFa+IVe8pMHka353Wl6FvTyyq+8N
         F5Dg==
X-Forwarded-Encrypted: i=1; AJvYcCW6JpqYm2otq9Ey02ashGwf01q911SOCCQ0QkosMfCkw0cjKxwmgFSJ8io8lWK6+/1ESB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJQi6jG14+OVkHnoGsipykzuVFdBmH6Jnt5iO2l3HRW84ACmq
	D2zXXd20FaGjwu7DdSMcwlxrVevwCK3GI/mdGVvtMK9jOdSoExu/I7zL
X-Gm-Gg: ASbGnctNvCe+JfxIvaLM8wJ0ZqXXSFWqQsmEfIRlMRkmcTTB4wqjg0hcb4rC9Uz5YLR
	W2pawolvNyhWtgajT2eSEpfer4mdLZMmTLOZrz7WMn7TXQL1CIZmOGSC++Yx85LLN56SIQe6k04
	BmqUSHjJ26SsCIH/57S6WJ/FduM2RXwO89GwYUcevs6LOQzrMmPKZeCd6dz/w7oBPEwjgIxUC5x
	spkbiYYNojJ28DcHkUCjrG9wGGIQWXUpxqqZ9bMBD0/ijSer0SS+Ly4v2SI4gOvbgqZYF30BlCW
	LM2+IMV8ypKDH7xKB22uPelsO3kAP58M7FZKNqdyKx9ksbroyHd1uKz1dH32J8Rdqwk1VkUiQzU
	Ktdmzp8Mv+t9D3SJ8C52Huy33CcyCrSkGW71deDLtOTRy1MPz++m8OTLyQAlu1wXqCtm1mkoEnP
	pcpVCowaIo8HI1L8+26llA3q4C4Y8ix1OhY2WIMmv38MswCF2Ak3IEre89IVv0hA==
X-Google-Smtp-Source: AGHT+IHP6kQ3rLsZ+zhU+9qC7bA8VQu65E/tck16nOgks9Lv59Yvs239cLZu4FcBTKmI7nHXF2OYEA==
X-Received: by 2002:a05:690e:154f:20b0:63f:a6da:4b38 with SMTP id 956f58d0204a3-64302a3a8eemr25656408d50.5.1764662120407;
        Mon, 01 Dec 2025 23:55:20 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c050d98sm6008225d50.2.2025.12.01.23.55.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 23:55:20 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: fix and consolidate d_path LSM regression test
Date: Tue,  2 Dec 2025 15:54:41 +0800
Message-ID: <20251202075441.1409-3-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251202075441.1409-1-electronlsr@gmail.com>
References: <20251202075441.1409-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for bpf_d_path() when invoked from an LSM program.
The test attaches to the bprm_check_security hook, calls bpf_d_path() on
the binary being executed, and verifies that a simple prefix comparison on
the returned pathname behaves correctly after the fix in patch 1.

To avoid nondeterminism, the LSM program now filters based on the
expected PID, which is populated from userspace before the test binary is
executed. This prevents unrelated processes that also trigger the
bprm_check_security LSM hook from overwriting test results. Parent and
child processes are synchronized through a pipe to ensure the PID is set
before the child execs the test binary.

Per review feedback, the new test is merged into the existing d_path
selftest rather than adding new prog_tests/ or progs/ files.

Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/d_path.c | 64 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
 2 files changed, 97 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index ccc768592e66..2909ca3bae0f 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -195,6 +195,67 @@ static void test_d_path_check_types(void)
 	test_d_path_check_types__destroy(skel);
 }
 
+static void test_d_path_lsm(void)
+{
+	struct test_d_path *skel;
+	int err;
+	int pipefd[2];
+	pid_t pid;
+
+	skel = test_d_path__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "d_path skeleton failed"))
+		return;
+
+	err = test_d_path__attach(skel);
+	if (!ASSERT_OK(err, "attach failed"))
+		goto cleanup;
+
+	/* Prepare the test binary */
+	system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");
+
+	if (!ASSERT_OK(pipe(pipefd), "pipe failed"))
+		goto cleanup;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork failed")) {
+		close(pipefd[0]);
+		close(pipefd[1]);
+		goto cleanup;
+	}
+
+	if (pid == 0) {
+		/* Child */
+		char buf;
+
+		close(pipefd[1]);
+		/* Wait for parent to set PID in BPF map */
+		if (read(pipefd[0], &buf, 1) != 1)
+			exit(1);
+		close(pipefd[0]);
+		execl("/tmp/bpf_d_path_test", "/tmp/bpf_d_path_test", NULL);
+		exit(1);
+	}
+
+	/* Parent */
+	close(pipefd[0]);
+
+	/* Update BPF map with child PID */
+	skel->bss->my_pid = pid;
+
+	/* Signal child to proceed */
+	write(pipefd[1], "G", 1);
+	close(pipefd[1]);
+
+	/* Wait for child */
+	waitpid(pid, NULL, 0);
+
+	ASSERT_EQ(skel->bss->called_lsm, 1, "lsm hook called");
+	ASSERT_EQ(skel->bss->lsm_match, 1, "lsm match");
+
+cleanup:
+	test_d_path__destroy(skel);
+}
+
 void test_d_path(void)
 {
 	if (test__start_subtest("basic"))
@@ -205,4 +266,7 @@ void test_d_path(void)
 
 	if (test__start_subtest("check_alloc_mem"))
 		test_d_path_check_types();
+
+	if (test__start_subtest("lsm"))
+		test_d_path_lsm();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index 84e1f883f97b..7f65c282069a 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -17,6 +17,8 @@ int rets_close[MAX_FILES] = {};
 
 int called_stat = 0;
 int called_close = 0;
+int called_lsm = 0;
+int lsm_match = 0;
 
 SEC("fentry/security_inode_getattr")
 int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
@@ -62,4 +64,35 @@ int BPF_PROG(prog_close, struct file *file, void *id)
 	return 0;
 }
 
+SEC("lsm/bprm_check_security")
+int BPF_PROG(prog_lsm, struct linux_binprm *bprm)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+	char path[MAX_PATH_LEN] = {};
+	int ret;
+
+	if (pid != my_pid)
+		return 0;
+
+	called_lsm = 1;
+	ret = bpf_d_path(&bprm->file->f_path, path, MAX_PATH_LEN);
+	if (ret < 0)
+		return 0;
+
+	{
+		static const char target_dir[] = "/tmp/";
+
+#pragma unroll
+		for (int i = 0; i < sizeof(target_dir) - 1; i++) {
+			if (path[i] != target_dir[i]) {
+				lsm_match = -1; /* mismatch */
+				return 0;
+			}
+		}
+	}
+
+	lsm_match = 1; /* prefix match */
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0


