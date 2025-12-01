Return-Path: <bpf+bounces-75807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF08CC97DFF
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 15:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E763A3FB4
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A551031B804;
	Mon,  1 Dec 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+On5pTo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C442F25F3
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764599930; cv=none; b=WA4em6W9Jvpz6jx1dXglZ3CN9zkPEkO47xZytYMa5jJW15MiAgw07udNYER46ljj3/+c2/kRhLiJrMV9xqKlqa4Zyr1jOrT5jloZSuj/cOKVhX+bdtuPtzQASMM/s4X08srvgEtzc/2FCVfG7iVyOESfktXH0VTboavchPeEDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764599930; c=relaxed/simple;
	bh=qM7RV0MVgKkPuugCJA5gyjnZ7ZMfHWsak5/IcOuknMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YitYiYZItYQYrQbopo59+9maR0enuMfxA5objZdxCtBgifpDI0jKjMfVxrJIZGauvxlBRSYXyvPypqUP3gIFz3Aj1owEtt+XJlFdm9gmJj2ArsPpDXW3TMxxFNOiAj0iE9S3EZJbzjh/SGotiA3Z3xa4l8i7qcOLxWWn31HQbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+On5pTo; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso3312959d50.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764599926; x=1765204726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo9YRGLlIAYiT7xnWNZFnCqDAVAkIBY4ckpgELisi8o=;
        b=c+On5pToj0s8Zh0VmKNPJd9+P2w9n1RI9c/dWLLGXUGFYh+tkcEbDRI8gk524d+bqo
         /J3j0QtRjeHrAHwue29f+RUrPigjGYHAKdtieim92Gz5uTPOmWta8lxNjpDI0+U4Fq78
         Yd0QjgxJiAtmw6llq4fz8RJLQlwhPVlYLzThLvO2/m9a/agS3Lls4nsTqfKfME5Jsxlv
         cCP+zqOOEKeD+EYMX7ThSyuTyRgF281A/dMSAN79gTiTQiAd10M3gnaY1jR+T+k2b7uD
         AhSDNBm/qZeGxSMkGM7d3L4SD9Sw7q2v4QbR8IPxRGLiyE4XCE+lfZFD0PGyUT4XgBmE
         st9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764599926; x=1765204726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xo9YRGLlIAYiT7xnWNZFnCqDAVAkIBY4ckpgELisi8o=;
        b=mQTQ22GKFQCalepDBj3aA5tVUxGCY/hjk4nvshwICeREied8yMukrL+WPxPU7mKJxx
         +hKhxYAmy3csIiNdkVAW2L2b1iphIoSY7efg7XBxdMvuo8yz/mnELDdTcHUipNTCnibc
         lYAwSFk8MjGsO309BCWWyCqtGP5UffG2TBEq641OGBoZg2Azbq7l5e+Um2LicO8PIrbM
         Qk7Bzpu9q3nWe83dXl8124jlZ5v3h3t/kpTtcRvgUkjTNtNTmdZseIFBGsggF8/SOPg+
         UNG7wrzVXCPFJxJ5HqOafwI2E6mcIhhtUtQtD2GwBzEADU6PuLYwRKVgAQ0qmLA3gkzQ
         pxzA==
X-Forwarded-Encrypted: i=1; AJvYcCUBlWzfQPPdO/UJU7OferToVbUCpvM0GAQ849pYKcWSU9XoBa1XEspm7zfOapYGm7fbB2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoLXf59QXBZgeNxlxCY0Vlcs9nXQ9/KaoxH6yUI1RC214lqKIo
	/aJIMRHF6ZTKVD/3e88ROYoY2uJFymEsdjxs//8aloedpXOMjez5poFZ
X-Gm-Gg: ASbGnctN4Jo2DLJCdOj3JfNuxQ/J//i001AmVFevwyBe8/d8Rn7y8wBppaTTlydKeel
	0i4P0vphVtWh699Xkr2UbETWyPKChTbJZoInopHBnhnPtxOCKTDGvy2nzBeE3AwSSU+pfRKdttp
	+TLtH8g6N2EjI/GfLZDW8EYLideWgLhOFoqZHvT4hyCvndpGtw5Mzuhpt2y9HoNEEFO/ytBiPkv
	FX3V/Pj5Jo+DdtVXQIHw7oe7pM7pmqtVtO91klLbcIxqtg/DgM77etnAJo8XPck5RET3wocUMdU
	UIo55xfSPsyQ3f6/41/gj2u81ma1Vrd12mfPNhvSoLk9XHXiDRIo7sl+Rd32VtU+5sC/WA6QL7i
	FlBBruoEZY62qjP22BAJbC2W5Dr1Y+XC8i+USt7oP1bbJ+T+bvPcdIhmB97UWfckxcWAi/tgavO
	o5Gx14eGK+p0tz0Fv6aMscAX4qVmCPwYoJlR2860eLSD2UBGms6wQ=
X-Google-Smtp-Source: AGHT+IEIrSHba8FocFc5Gk3MFeTWxBnLr3J1VTXOHJr+YqTAbJw73W+9zD/FtWppzYACtNAQhWj4iQ==
X-Received: by 2002:a05:690e:1187:b0:63f:b445:6a0a with SMTP id 956f58d0204a3-643293b7773mr16916167d50.54.1764599926388;
        Mon, 01 Dec 2025 06:38:46 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c078297sm4889911d50.9.2025.12.01.06.38.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 06:38:46 -0800 (PST)
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
Subject: [PATCH bpf 2/2] selftests/bpf: add regression test for bpf_d_path()
Date: Mon,  1 Dec 2025 22:38:13 +0800
Message-ID: <20251201143813.5212-3-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201143813.5212-1-electronlsr@gmail.com>
References: <20251201143813.5212-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple LSM BPF program and a corresponding test_progs test case
to exercise bpf_d_path() and ensure that prefix comparisons on the
returned path keep working.

The LSM program hooks bprm_check_security, calls bpf_d_path() on the
binary being executed, and compares the returned path against the
"/tmp/" prefix. The result is recorded in an array map.

The user space test runs /tmp/bpf_d_path_test (copied from /bin/true)
and checks that the BPF program records a successful prefix match.

Without the preceding fix to bpf_d_path()'s helper prototype, the
test can fail due to the verifier incorrectly assuming that the
buffer contents are unchanged across the helper call and misoptimizing
the program. With the fix applied, the test passes.

Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
---
 .../selftests/bpf/prog_tests/d_path_lsm.c     | 27 ++++++++++++
 .../selftests/bpf/progs/d_path_lsm.bpf.c      | 43 +++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/d_path_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path_lsm.c b/tools/testing/selftests/bpf/prog_tests/d_path_lsm.c
new file mode 100644
index 000000000000..92aad744ed12
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/d_path_lsm.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <test_progs.h>
+#include "d_path_lsm.skel.h"
+
+void test_d_path_lsm(void)
+{
+	struct d_path_lsm *skel = NULL;
+	int err, map_fd, key = 0, val = 0;
+
+	skel = d_path_lsm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	err = d_path_lsm__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");
+	system("/tmp/bpf_d_path_test >/dev/null 2>&1");
+
+	map_fd = bpf_map__fd(skel->maps.result);
+	err = bpf_map_lookup_elem(map_fd, &key, &val);
+	ASSERT_OK(err, "lookup_result");
+	ASSERT_EQ(val, 1, "prefix_match");
+out:
+	d_path_lsm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c b/tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c
new file mode 100644
index 000000000000..36f9ff37e817
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+#define FILENAME_MAX_SIZE 256
+#define TARGET_DIR "/tmp/"
+#define TARGET_DIR_LEN 5
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} result SEC(".maps");
+
+SEC("lsm/bprm_check_security")
+int BPF_PROG(d_path_lsm_prog, struct linux_binprm *bprm)
+{
+	char path[FILENAME_MAX_SIZE] = {};
+	long len;
+	int key = 0;
+	int val = 0;
+
+	len = bpf_d_path(&bprm->file->f_path, path, sizeof(path));
+	if (len < 0)
+		return 0;
+
+#pragma unroll
+	for (int i = 0; i < TARGET_DIR_LEN; i++) {
+		if ((u8)path[i] != (u8)TARGET_DIR[i]) {
+			val = -1; /* mismatch */
+			bpf_map_update_elem(&result, &key, &val, BPF_ANY);
+			return 0;
+		}
+	}
+
+	val = 1; /* prefix match */
+	bpf_map_update_elem(&result, &key, &val, BPF_ANY);
+	return 0;
+}
-- 
2.52.0


