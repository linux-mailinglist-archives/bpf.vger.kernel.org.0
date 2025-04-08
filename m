Return-Path: <bpf+bounces-55491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A866AA8197D
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 01:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681E51BA5B19
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 23:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A70C256C68;
	Tue,  8 Apr 2025 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6bspLCE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4A255252
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155937; cv=none; b=r4qp7ZafLC6/HzuMazbRBZ9xrHAxNy6enIXHTm5LvVhf2H5ZiT8FxdyhdUY9NG7I3G9RCKyeDrdvUQwDgH41YqDb1Jl3F3AsBUc/k1LCI5ZKem1VLtzuQIBtuycZ+1rkzXaisRSzdthv/zOmqaMt7qrX7wTOs5uTS+aN7eWSsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155937; c=relaxed/simple;
	bh=TthG+ZHnUklh73JqMrZRWQqaSpdoqfXY+I1Qa+H63Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2yv1NEnMLjHAq/Jxb+yYCe9pS2hoK/bARdMemX0JRmlMQOxkugJCdx6HLbFwcj4LQwEk4tDIjdOwwtPtfy+O027JOsHZ5w2UsAaUZ/Vg7XEPQia0YSS8D8lW3zsWCtAUFCCM/NvB2YkfGY2tT6zZ5Pe7uqOQml7qpxiRIIr3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6bspLCE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so65494815e9.3
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 16:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744155934; x=1744760734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iONg82zMQemNPbgxA7jxSH2JC9My7h5OhxwLdjI1R2I=;
        b=e6bspLCEjN3RkYsE1QOiz4zYnwUzuN32rKwlciSnWrsnRuqOGz89CBNSDf+S8I2YJ8
         2KVaL2b2Ukt/t/dYzQVPxfJj1AP445htTfd8ZOi8MivelSHEZALwVM9z585BXp18qy03
         1F/Kcne7ajT2lxbH2TeJ8cZrlB4Z2RaVg4uracruSV5jKHM5mUxQz8eT7bh+NuLtMakn
         tAQeLcSPEh0BF+HCqIB7PD0VCCMtXjl+zD3xHSOuiAkc+E3XGR7/U3VRoWsaUVXHUOlN
         7cJ6A8ey7YnribleS6sOwTAZ/6YG9HgS02LWn6p6wEzIOJv6fbge7Z2jCtBXVGUmnSuT
         8UoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744155934; x=1744760734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iONg82zMQemNPbgxA7jxSH2JC9My7h5OhxwLdjI1R2I=;
        b=CQLAQR211Z3mK7dDQaOR3Wp84X0Mx5zzanvsNdDZBYcD3o22iN3tE40LV2O8sSpkEE
         0UI4A9rLVXmwWL9C4HBgmgBrVB0jshf+4JzVEG99tHurrvsHWuItCiUR8+c0nSWJTSAp
         ZhOxdbse1P2bTbwgQ68hiamXMCSnfAy6huUtgEJa3S/yegqrkzD6miJ4Qu3IFXaYuzDe
         4+oAEO2ZzMovJaeq/VLdiF3aoqZQVb5v4vAjNNZuX+1R9LnIpI9Djq0neHPMieZ+SfN/
         52ZxJ5nmx35dIa40RDaTcJAPORLGXIlkcMMwtV/Isy6w4ny9WVUl+xgyy8RCwxhjH/ey
         /oeA==
X-Gm-Message-State: AOJu0Yw93gJh7p0yCxp1iikAX1WuWOoVCxBp3FGUBQ/gTXky/AMI1y/X
	p0lU1yW5181xOvhBSJt7qkmThNHO/UjxUir9XEwEzWE3vbEBkn6hb33sJQ==
X-Gm-Gg: ASbGncv1LL2JIrpIJnYV2MtJdBkj92n/VcQxrQfMsFXlt6NzQuDeDsg7KG2AnjAataa
	nJQO9mWwvbSStRymRSQSvMBHSEuus73SzQxaW53m153L8HtKZfDUZk4DeEYe58/vFWek+gbJ4PC
	QxOPVPX7tdb1HYXH07R3T5FFTfR7uBr+WQwGkEb2SmbJn5XoAhYGkiY3erf6GKdUb9m0PxLkqU9
	+u3uvJdV44ffZgRKHKVoGoKXe6ICjpUkG7oo6QbvMCYxv9izXl8u0pM775dpaH8XE1aC/PX5YF1
	0Nfti76eCU3SwD9c8j30bE1WWODSut/NuUuHlKh5/eZ8q0YAoZDb/rCwmC0NUR4=
X-Google-Smtp-Source: AGHT+IHN90+lzDZ8rLpxr02KU0fHQumMkTgwxLgCESMdPHkG9sZhv4ljsmCWAVhc1QnrW1GRpkY5zw==
X-Received: by 2002:a05:600c:4e13:b0:43c:f597:d582 with SMTP id 5b1f17b1804b1-43f20686d54mr2969335e9.1.1744155934119;
        Tue, 08 Apr 2025 16:45:34 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f205ec97csm3012485e9.6.2025.04.08.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 16:45:33 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: add BTF.ext line/func info getter tests
Date: Wed,  9 Apr 2025 00:44:17 +0100
Message-ID: <20250408234417.452565-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408234417.452565-1-mykyta.yatsenko5@gmail.com>
References: <20250408234417.452565-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add selftests checking that line and func info retrieved by newly added
libbpf APIs are the same as returned by kernel via bpf_prog_get_info_by_fd.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/test_btf_ext.c   | 64 +++++++++++++++++++
 .../selftests/bpf/progs/test_btf_ext.c        | 22 +++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_btf_ext.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
new file mode 100644
index 000000000000..7d1b478c99a0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms Inc. */
+#include <test_progs.h>
+#include "test_btf_ext.skel.h"
+#include "btf_helpers.h"
+
+static void subtest_line_func_info(void)
+{
+	struct test_btf_ext *skel;
+	struct bpf_prog_info info;
+	struct bpf_line_info line_info[128], *libbpf_line_info;
+	struct bpf_func_info func_info[128], *libbpf_func_info;
+	__u32 info_len = sizeof(info), libbbpf_line_info_cnt, libbbpf_func_info_cnt;
+	int err, fd;
+
+	skel = test_btf_ext__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	fd = bpf_program__fd(skel->progs.global_func);
+
+	memset(&info, 0, sizeof(info));
+	info.line_info = ptr_to_u64(&line_info);
+	info.nr_line_info = sizeof(line_info);
+	info.line_info_rec_size = sizeof(*line_info);
+	err = bpf_prog_get_info_by_fd(fd, &info, &info_len);
+	if (!ASSERT_OK(err, "prog_line_info"))
+		goto out;
+
+	libbpf_line_info = bpf_program__line_info(skel->progs.global_func);
+	libbbpf_line_info_cnt = bpf_program__line_info_cnt(skel->progs.global_func);
+
+	memset(&info, 0, sizeof(info));
+	info.func_info = ptr_to_u64(&func_info);
+	info.nr_func_info = sizeof(func_info);
+	info.func_info_rec_size = sizeof(*func_info);
+	err = bpf_prog_get_info_by_fd(fd, &info, &info_len);
+	if (!ASSERT_OK(err, "prog_func_info"))
+		goto out;
+
+	libbpf_func_info = bpf_program__func_info(skel->progs.global_func);
+	libbbpf_func_info_cnt = bpf_program__func_info_cnt(skel->progs.global_func);
+
+	if (!ASSERT_OK_PTR(libbpf_line_info, "bpf_program__line_info"))
+		goto out;
+	if (!ASSERT_EQ(libbbpf_line_info_cnt, info.nr_line_info, "line_info_cnt"))
+		goto out;
+	if (!ASSERT_OK_PTR(libbpf_func_info, "bpf_program__func_info"))
+		goto out;
+	if (!ASSERT_EQ(libbbpf_func_info_cnt, info.nr_func_info, "func_info_cnt"))
+		goto out;
+	ASSERT_MEMEQ(libbpf_line_info, line_info, libbbpf_line_info_cnt * sizeof(*line_info),
+		     "line_info");
+	ASSERT_MEMEQ(libbpf_func_info, func_info, libbbpf_func_info_cnt * sizeof(*func_info),
+		     "func_info");
+out:
+	test_btf_ext__destroy(skel);
+}
+
+void test_btf_ext(void)
+{
+	if (test__start_subtest("line_func_info"))
+		subtest_line_func_info();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_btf_ext.c b/tools/testing/selftests/bpf/progs/test_btf_ext.c
new file mode 100644
index 000000000000..cdf20331db04
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_btf_ext.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Meta Platforms Inc. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+__noinline static void f0(void)
+{
+	__u64 a = 1;
+
+	__sink(a);
+}
+
+SEC("xdp")
+__u64 global_func(struct xdp_md *xdp)
+{
+	f0();
+	return XDP_DROP;
+}
-- 
2.49.0


