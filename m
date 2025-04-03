Return-Path: <bpf+bounces-55271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6912A7B208
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6078C178BE0
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60E1ACEDF;
	Thu,  3 Apr 2025 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeHgptzz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43121AA1E8
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743719300; cv=none; b=KdTAH64B3tcbzTZjfUvwY9l893gSzA0iA3Q4ttAcPFoT8CTFlI8UUDZrXf9r0ICjyDEHUTWCGAaHboMJkgi7EvVQNMnvfdqg7YJA/8SjRLJLk3lHfLhCXBdWrYZcFsxTdqTMpX76UMQmnOzG6WcP5yjMlwy+lo4TaUEf0Dv7sq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743719300; c=relaxed/simple;
	bh=zYVYMEQGnZ2T3o6WEjKJ+/l/K254r17SxbnV6fhA1jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAwQmQjqP9ikvcmwvTf8MVh/6tuGZpKNC2TiCDOYl06U8dZr9hnM4CzGm+FgIaavtXOTmb0Yj+QAJpFbXXUDRyev6+4ZAjwjmtiGfUUzf5NmoQwzDl79aPqANr2wn8G+XrQCC0VVNBKNg0gG4jU17UTu6eGzARCMsc0P4xmUBko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeHgptzz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913d129c1aso984585f8f.0
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743719296; x=1744324096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmBhJmOICiy7/Jl3Zk5Oyat2zeQEKDb2ia9Pv/blmps=;
        b=AeHgptzzrtUOsp16uwnJ/Fls6bFe9WOa4v00Wh6n+DpPhZmXuVGm4znEDs/bsGUpKj
         UNfoEQkVtF6wSdF5lR+YBHyhjpmK60NZeXMkU679AuTBjosppDjbiViIhQjIWYOV1VCb
         TdgCOKJiA1ZNM0nakXZoxeFA+ZzEStmLlGYtGGmqyK22S/FN3GSPjXUGTvWQN6HAxbHP
         gnACkm6WwfQKFxa2Cme0UZIrWSIvaDyMn3fVZ2NAdVkbiyXmW9p1NOQMNiWIZBI79zEP
         biobzQOW7JoqQr2P6lHvGNELL2Xdt3nRz8mKcyJpAwgN0HcUsUJ3s3PWuwhiiJ/twzki
         cD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743719296; x=1744324096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmBhJmOICiy7/Jl3Zk5Oyat2zeQEKDb2ia9Pv/blmps=;
        b=twsjBrz6wojktvyLmXepHz/cB47UNkmkF7uEcbIYk7nkEusTxs7CRaF09HifEKBiTO
         ieKChPJXc+2c0h1PXVRwq4Hh2XS96JErRiSbdtOGPe3eM9Zm3vecLGN6zvg6IjxWn5Xl
         /CWGUObRyOqaEZtXs0lxBcVm4Cii+2L6ElP8M/EvsbORlePwv2/w/tllOATpconwp/M8
         R8G8XpfUCIOgxKLLTpCDqz+KiTcKKmXFY+eOdBqSQeo5jN4rXLkpU2JU6ub4khTxhA+E
         Y+D8J08jUX4UKaXQ8ksCIkChxnxTppxKG75awSabOxWgT/tsq33KQ85bH93/cihqiLxr
         SpEQ==
X-Gm-Message-State: AOJu0Yzp0ZL5yJosWuhvGEZZPDQaoJgBhxMqoSJmOAelynsjv0Flfpwz
	kyZwzRIPRx2HqGjT7mu89bdkNml3nTMlvaprsDegjPnb07SmjJbbGWl9iA==
X-Gm-Gg: ASbGncuo2e8tIeACrQdaFr7Zsgn4UsnZ5wn82UTpX2Yq4k4FZff8597idpW/2M0nIz1
	X37BPHPTjprsrputK/dA1ujOPfyOQoSNBbhgcrFdFFrmJ7ndeMjgSeGM+toPNhYJBZ2tlgtBHP+
	ptZa23VQ675iX47Tzydom640YItjyPzW+xa231gZorJhkNgaxWtRbIH9kcAwr/LreyZN2JlTWrM
	cF4weDx4UrM0KaGBsligaWpbKyjhyNymQq1/oYFUUoIG8at8HqaYk02ybkgZw1LWdYGeENZI966
	maFLODyBOIjlCe7gksdHwbSc6xljcc9vHp8C9UAd5tsmnQI5EE3F1MeAdR7xzX4=
X-Google-Smtp-Source: AGHT+IEpqYHp285hur46cd4rbMxpHQhKuIJuMuAmd1Oa/BkEcHii2b4z8AWC2rjt2AxuBtlAYVBdyA==
X-Received: by 2002:a5d:59af:0:b0:391:9b2:f496 with SMTP id ffacd0b85a97d-39c2e621a3emr4856662f8f.16.1743719295786;
        Thu, 03 Apr 2025 15:28:15 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b816csm2846925f8f.57.2025.04.03.15.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 15:28:15 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: add BTF.ext line/func info getter tests
Date: Thu,  3 Apr 2025 23:28:09 +0100
Message-ID: <20250403222809.90634-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403222809.90634-1-mykyta.yatsenko5@gmail.com>
References: <20250403222809.90634-1-mykyta.yatsenko5@gmail.com>
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
 .../selftests/bpf/prog_tests/test_btf_ext.c   | 69 +++++++++++++++++++
 .../selftests/bpf/progs/test_btf_ext.c        | 26 +++++++
 2 files changed, 95 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_btf_ext.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
new file mode 100644
index 000000000000..76d3eb520982
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
@@ -0,0 +1,69 @@
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
+	/* Skip checks on s390x as it seems to be adding some preamble to function entry point
+	 * shifting instruction offsets by 1 byte
+	 */
+#if !defined(__TARGET_ARCH_s390) && !defined (__s390x__)
+	ASSERT_MEMEQ(libbpf_line_info, line_info, libbbpf_line_info_cnt * sizeof(*line_info),
+		     "line_info");
+	ASSERT_MEMEQ(libbpf_func_info, func_info, libbbpf_func_info_cnt * sizeof(*func_info),
+		     "func_info");
+#endif
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
index 000000000000..e4efcf823f6b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_btf_ext.c
@@ -0,0 +1,26 @@
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
+	__u8 a = 1;
+	__u8 b = 2;
+	__u8 c = 3;
+
+	__sink(a);
+	__sink(b);
+	__sink(c);
+}
+
+SEC("xdp")
+int global_func(struct xdp_md *xdp)
+{
+	f0();
+	return XDP_DROP;
+}
-- 
2.49.0


