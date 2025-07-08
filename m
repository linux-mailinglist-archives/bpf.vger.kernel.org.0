Return-Path: <bpf+bounces-62718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0BAAFDB92
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297FF1AA2518
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 23:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8A2235067;
	Tue,  8 Jul 2025 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brT8FknJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601323314B
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016113; cv=none; b=PkMGLBMXKE1QmShgQbNhWnuux7wVoyfht3806ADmV5trGUolVAB6MWGFOUWBfunfQ1Hd7nQcsRboHEUhsfz34b1NoA+XWzirZfk9BJycwEjN8qBfMxYC18Pe2y9M4zQlvEPNjM8ePTqmY7xmNT+Mn3spjSNoHgaRjHL76b6HEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016113; c=relaxed/simple;
	bh=AO06kzeTNMgu6T/23hDVIqI1VVkQZyeC4PdcOAxDgj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTQc97a6h1nfnUzOV4hD9z9qw+VzsuMk30VMmtdEoPfvpJbqWatCWaux3yHDrP4Xty9xJt9YDJsVbWTzR7fH3YUe2eD1JFeO+mVKVeSxM75hSKG+Fdz60nM6FIF+Ja9VWWEYfdmjDeYv/6mY8FSlqscIab+HuclkemalfLLQKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brT8FknJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so4084411a12.0
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752016111; x=1752620911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrGVV0CDvOIgnRq78G+ReRLH2fbSRM60n635mX5Wf7g=;
        b=brT8FknJzvtFjD5ObtHKpH14FKftTP5Jf1m2fQp8QNa2jkgaMkAn96ZUUBiTLnO8yQ
         MH14zw6dSOfufW9SyLZ0ySDO+6hUa7uP4ZREmmFipvohJjr+QbyMT2pZ7nImj2dJmYlR
         1LtZk+ZSitB1vk/mt98CL/EEp91361Ur7+Mg5POGAyP+E8jHgqKn3Um0CayiZNlAVG9T
         97oW2h1RGn7/7Ly+trqMnWkT3+MEvwpnAl1QnB4zIdEq8ZMivYsincqb+IQBZ1tH7aTD
         muQ1u24byRwCVnDxYKEJtMlaIEpDyPIeRRSyjSWG0eEY4KuY2owyxAtXWyu4nsj2rZMC
         v9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752016111; x=1752620911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrGVV0CDvOIgnRq78G+ReRLH2fbSRM60n635mX5Wf7g=;
        b=WFDS+nDByNC2lL5IpyCnO3R7hoMVFpbCW60BflGl2xegGShAHtpwyngnUix+unPG7s
         4LRlhxk3Yk0KAYxqwnZrRt+GfMS9sfNxdKgMCQJ0cd99XHu3qS04MgFZ66BNFu5cAweI
         xeix39uj73sAquVsCHAzeH9P1JgP9g0qXytIyCnjPg9Li0QuVoH2513s8xcWbqgHuJbE
         4oNbDICariACH+bzTzK4z9ItIBmVvvGJrC3glL9wDaiPQbg4HgM3dtrcLQJjkKp3OZhm
         gWxRKit1517g+VQSIJ/3sS2QHprAmYiPcSGcfL6XmQIQNjzwC+uZ01r1qvTWwfOgRC0U
         fRdg==
X-Gm-Message-State: AOJu0Yz5a+uz0jK68SzbK7MELBS2XlDp5K6mWIsiL+rKtCykp2CJPJpu
	v9Pvi1Qmr5kH/52OmPrUhO+mGjxyxSqV7lAlBEQF8qRNWEuCzlnSvd1L8BDGGQ==
X-Gm-Gg: ASbGncsFVjtWnx5lXwjzAZArF9OasC6C+GidNXoSfM641B6ixDdUJEB7SHfgdh/nxaL
	eipfKrJNXBgEz/mX0hq2y5iH4hb0tDuvo+mHgkTNDj5G+uswVi4l85gVIK3NbbJShfvbIiyXHpt
	6EDWtusd8qD4C/HpMaFkio+Q0nz3XtEHZkZFneyKjI+1XuC7Elpfu6gXJAmS2SmdWvBzyiEdgxb
	F+GAx6z8+Bmv/U/adk+qnSUxOyFE43cZiTXReFLzn9WcackvzphHU0I7VNBLLls6SiiOzocJOc1
	zzyeW0QfZcFuapqrNq3z1GfZnTlzmOe9GEk8x6W7GAgdF2nmdiFx
X-Google-Smtp-Source: AGHT+IHORMUvpDlJ8yRQndFce/HdBvzK7ngsk9L5n8dNk9zl4nwc0nD2Vpo4GKUT9bHBLwiLPwMR8Q==
X-Received: by 2002:a17:90b:5830:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-31c2fcf4328mr481158a91.9.1752016111055;
        Tue, 08 Jul 2025 16:08:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3ba9c99bb8sm28854a12.63.2025.07.08.16.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 16:08:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 4/4] selftests/bpf: Test bpf_get_attach_cookie() in struct_ops program
Date: Tue,  8 Jul 2025 16:08:25 -0700
Message-ID: <20250708230825.4159486-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708230825.4159486-1-ameryhung@gmail.com>
References: <20250708230825.4159486-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attach a struct_ops map with a cookie and test that struct_ops programs
can read the cookie using bpf_get_attach_cookie().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_cookie.c   | 42 ++++++++++++++++
 .../selftests/bpf/progs/struct_ops_cookie.c   | 48 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  1 +
 3 files changed, 91 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_cookie.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_cookie.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_cookie.c
new file mode 100644
index 000000000000..36179785b173
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_cookie.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "struct_ops_cookie.skel.h"
+
+static void test_struct_ops_cookie_basic(void)
+{
+	LIBBPF_OPTS(bpf_struct_ops_opts, attach_opts);
+	LIBBPF_OPTS(bpf_test_run_opts, run_opts);
+	struct struct_ops_cookie *skel;
+	struct bpf_link *link;
+	int err, prog_fd;
+
+	skel = struct_ops_cookie__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_cookie__open_and_load"))
+		return;
+
+	attach_opts.cookie = 0x12345678;
+	link = bpf_map__attach_struct_ops_opts(skel->maps.testmod_cookie, &attach_opts);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops_opts"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.trigger_test_1);
+	err = bpf_prog_test_run_opts(prog_fd, &run_opts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_EQ(skel->bss->cookie_test_1, 0x12345678, "cookie_1_value");
+
+	prog_fd = bpf_program__fd(skel->progs.trigger_test_2);
+	err = bpf_prog_test_run_opts(prog_fd, &run_opts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_EQ(skel->bss->cookie_test_2, 0x12345678, "cookie_2_value");
+
+out:
+	bpf_link__destroy(link);
+	struct_ops_cookie__destroy(skel);
+}
+
+void serial_test_struct_ops_cookie(void)
+{
+	if (test__start_subtest("struct_ops_cookie_basic"))
+		test_struct_ops_cookie_basic();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_cookie.c b/tools/testing/selftests/bpf/progs/struct_ops_cookie.c
new file mode 100644
index 000000000000..1033939fbc1e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_cookie.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u64 cookie_test_1 = 0;
+__u64 cookie_test_2 = 0;
+
+void bpf_testmod_ops3_call_test_1(void) __ksym;
+void bpf_testmod_ops3_call_test_2(void) __ksym;
+
+SEC("struct_ops/test_cookie_1")
+int BPF_PROG(test_cookie_1)
+{
+	cookie_test_1 = bpf_get_attach_cookie(ctx);
+	return 0;
+}
+
+SEC("struct_ops/test_cookie_2")
+int BPF_PROG(test_cookie_2)
+{
+	cookie_test_2 = bpf_get_attach_cookie(ctx);
+	return 0;
+}
+
+SEC("syscall")
+int trigger_test_1(void *ctx)
+{
+	bpf_testmod_ops3_call_test_1();
+	return 0;
+}
+
+SEC("syscall")
+int trigger_test_2(void *ctx)
+{
+	bpf_testmod_ops3_call_test_2();
+	return 0;
+}
+
+/* Struct ops map that will be attached with a cookie */
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_cookie = {
+	.test_1 = (void *)test_cookie_1,
+	.test_2 = (void *)test_cookie_2,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e9e918cdf31f..d273b327a1c0 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1139,6 +1139,7 @@ static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
 };
 
 static const struct bpf_verifier_ops bpf_testmod_verifier_ops3 = {
+	.get_func_proto	 = bpf_base_func_proto,
 	.is_valid_access = bpf_testmod_ops_is_valid_access,
 };
 
-- 
2.47.1


