Return-Path: <bpf+bounces-53243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DACA4EF46
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D650B7A12BF
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 21:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290125F979;
	Tue,  4 Mar 2025 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNA7Fozp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97263201103
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122918; cv=none; b=GNySeVI2InhJQJrvA4O5fOFZWEM/kguttF9VjW3H5VflWkWm2ZgN0g5evfv1I+q6shcyh8ugRqR4ppMRMZ8imzdmX43h9axcAKusjS8/e12SVJDvxfJ1y308DMagUo+S4o9aAHVA1K/VT+2I5KDbpEbCOSso+a62FvhPblnl4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122918; c=relaxed/simple;
	bh=qA/gX0Xc0Iy3peK6P5tDtvu5Pdb8YABKWE4OuBXALwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTzQYp7r54Z110iBd+YR8AA1MJMEoPthhzpDG3Pvm+UhWdJBjoqLaWt2mrbuKFE71D52sXaCD4Bb1jx7QQ0yckqjGSWxevAE0Mwk6jJTQuUXdvQTBvaH+oFiJi4UUdaJ3yHK1CSf/9o28c5t/l9pBnmP++H+o2cdWqcwnBiszeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNA7Fozp; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so458426a12.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 13:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741122914; x=1741727714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhhoRp75AMWUH+rfKEbIq770+MUmWmEnzQBSRCHAaI4=;
        b=HNA7FozpSNycP8Om14yK/mhNT0uxb3mQDWZfQT2hTtGzTrDcIHd9hZLPwzP82FAa+u
         cprH/9Bzn1bfbeOK1xZR/VNRTHtAS7azqtxUb4U8iWV6UXyrnrmn0a5mlCCWjnrSLW7t
         +NVYToznQ+tcKwM5u5DOs8d245pyJt7Fb7l8IuKhcEwiIhDlQDEi00TzyPG7BR8R88lr
         8L9lVk5gm6a4/ukmMNcGm+uuTb07aYUvHDStYUDGXemiQsWEddJ7yJtq6kdGebcn3F/0
         MSRpBGTImn32W+pvZL9gU8Hl4cdeu4A43vKewTMkaHHu8JZKxWUSaZAzb7zVSzmuNWq7
         pOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741122914; x=1741727714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhhoRp75AMWUH+rfKEbIq770+MUmWmEnzQBSRCHAaI4=;
        b=Cwhm7nhw3nQ8gukwIOEm8HakwGuidFN7eQRwlC8sWjzJYbUovKqoIuNN7IXHXB7BHE
         JYk4riUkdzBvqm01X49mPCwG1d6PyA1m+JcQuDpvBT6F2Cf441UmohUYxK1CZy44fY1M
         8tL7P71fN7pD+mj9SmcDCyBR8kMJnSD4CKzSeblUnn79s+zVz85BNDFPdVrHvakRF4se
         LpsvpCVxmI8pNKz8jGW5VmGCJeHX1cA1jXorlyeHQWOHNAQdKddzn3Vbkl/kPOMMRNEy
         1mbZpN2Sw+KdfiouCErpZIjhgH9BZ/9r4VYgzwRyZ3wNhcaxDaiPWqQOWusyP6ekm+Jp
         Mefg==
X-Gm-Message-State: AOJu0Yz7rmkU2PPgB4d2q3d/Vc/b7aaXMziEmI5PQJLMffBH2+78Mm3A
	sO9K+BdUYFg0s/8FCduFhv9WzB875bJndG7qd2ilhIMzQam/a4tG6ZEnUA==
X-Gm-Gg: ASbGncusxuk7gBX/sSTcGWmsu+J7x3W/H13YQ1o0OKPxgJF/Vo2DjvTHxdkiTLQoTSR
	3MNLxqNx0usHA0jliNBvQasLlpTpNmslnTf6WD2+fAYzqqOVT0NDCrLnDNnJn/XmFDNJTwwTRMA
	pw6BZeqUxl4kbwi2gwbfQ2WydlXthnAx9vE5NbE5QKuXTO5goYwOs3nExIlMbBwtumYNXigpbCI
	JGOdfytskyAb9GwmT7qHIh8jDOLWvSGzS6x4c0c69kkQbNqdl3d6xNb8/GDlhkVLZfbWmiKEINu
	Gu7EWf0P2sCep9BxrnweL8GFhQ/2jBHWeaiAK7UorU8NUaCNCnn9zJhOAoI=
X-Google-Smtp-Source: AGHT+IFVewJcvZJaumS68twYWetdDg7JNqSkeZAVA/gwBwFKhUHNBgw/oL7xuE/h6KhuBql2ggDB1g==
X-Received: by 2002:a05:6402:2742:b0:5dc:eb2:570d with SMTP id 4fb4d7f45d1cf-5e59f0dc9d3mr688248a12.2.1741122913315;
        Tue, 04 Mar 2025 13:15:13 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:8902])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4ae60sm8582112a12.10.2025.03.04.13.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:15:12 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: test freplace from user namespace
Date: Tue,  4 Mar 2025 21:15:00 +0000
Message-ID: <20250304211500.213073-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304211500.213073-1-mykyta.yatsenko5@gmail.com>
References: <20250304211500.213073-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add selftests to verify that it is possible to load freplace program
from user namespace if BPF token is initialized by bpf_object__prepare
before calling bpf_program__set_attach_target.
Negative test is added as well.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 94 +++++++++++++++++++
 .../selftests/bpf/progs/priv_freplace_prog.c  | 13 +++
 tools/testing/selftests/bpf/progs/priv_prog.c |  4 +-
 3 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/priv_freplace_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index c3ab9b6fb069..38f405b8a2c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -19,6 +19,7 @@
 #include "priv_prog.skel.h"
 #include "dummy_st_ops_success.skel.h"
 #include "token_lsm.skel.h"
+#include "priv_freplace_prog.skel.h"
 
 static inline int sys_mount(const char *dev_name, const char *dir_name,
 			    const char *type, unsigned long flags,
@@ -788,6 +789,83 @@ static int userns_obj_priv_prog(int mnt_fd, struct token_lsm *lsm_skel)
 	return 0;
 }
 
+static int userns_obj_priv_freplace_setup(int mnt_fd, struct priv_freplace_prog **fr_skel,
+					  struct priv_prog **skel, int *tgt_fd)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	int err;
+	char buf[256];
+
+	/* use bpf_token_path to provide BPF FS path */
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", mnt_fd);
+	opts.bpf_token_path = buf;
+	*skel = priv_prog__open_opts(&opts);
+	if (!ASSERT_OK_PTR(*skel, "priv_prog__open_opts"))
+		return -EINVAL;
+	err = priv_prog__load(*skel);
+	if (!ASSERT_OK(err, "priv_prog__load"))
+		return -EINVAL;
+
+	*fr_skel = priv_freplace_prog__open_opts(&opts);
+	if (!ASSERT_OK_PTR(*skel, "priv_freplace_prog__open_opts"))
+		return -EINVAL;
+
+	*tgt_fd = bpf_program__fd((*skel)->progs.kprobe_prog);
+	return 0;
+}
+
+/* Verify that freplace works from user namespace, because bpf token is loaded
+ * in bpf_object__prepare
+ */
+static int userns_obj_priv_freplace_prog(int mnt_fd, struct token_lsm *lsm_skel)
+{
+	struct priv_freplace_prog *fr_skel = NULL;
+	struct priv_prog *skel = NULL;
+	int err, tgt_fd;
+
+	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd);
+	if (!ASSERT_OK(err, "setup"))
+		goto out;
+
+	err = bpf_object__prepare(fr_skel->obj);
+	if (!ASSERT_OK(err, "freplace__prepare"))
+		goto out;
+
+	err = bpf_program__set_attach_target(fr_skel->progs.new_kprobe_prog, tgt_fd, "kprobe_prog");
+	if (err)
+		goto out;
+
+	err = priv_freplace_prog__load(fr_skel);
+	ASSERT_OK(err, "priv_freplace_prog__load");
+out:
+	priv_freplace_prog__destroy(fr_skel);
+	priv_prog__destroy(skel);
+	return err;
+}
+
+/* Verify that replace fails to set attach target from user namespace without bpf token */
+static int userns_obj_priv_freplace_prog_fail(int mnt_fd, struct token_lsm *lsm_skel)
+{
+	struct priv_freplace_prog *fr_skel = NULL;
+	struct priv_prog *skel = NULL;
+	int err, tgt_fd;
+
+	err = userns_obj_priv_freplace_setup(mnt_fd, &fr_skel, &skel, &tgt_fd);
+	if (!ASSERT_OK(err, "setup"))
+		goto out;
+
+	err = bpf_program__set_attach_target(fr_skel->progs.new_kprobe_prog, tgt_fd, "kprobe_prog");
+	if (ASSERT_ERR(err, "attach fails"))
+		err = 0;
+	else
+		err = -EINVAL;
+
+out:
+	priv_freplace_prog__destroy(fr_skel);
+	priv_prog__destroy(skel);
+	return err;
+}
+
 /* this test is called with BPF FS that doesn't delegate BPF_BTF_LOAD command,
  * which should cause struct_ops application to fail, as BTF won't be uploaded
  * into the kernel, even if STRUCT_OPS programs themselves are allowed
@@ -1010,6 +1088,22 @@ void test_token(void)
 
 		subtest_userns(&opts, userns_obj_priv_prog);
 	}
+	if (test__start_subtest("obj_priv_freplace_prog")) {
+		struct bpffs_opts opts = {
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD),
+			.progs = bit(BPF_PROG_TYPE_KPROBE) | bit(BPF_PROG_TYPE_EXT),
+			.attachs = ~0ULL,
+		};
+		subtest_userns(&opts, userns_obj_priv_freplace_prog);
+	}
+	if (test__start_subtest("obj_priv_freplace_prog_fail")) {
+		struct bpffs_opts opts = {
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD),
+			.progs = bit(BPF_PROG_TYPE_KPROBE) | bit(BPF_PROG_TYPE_EXT),
+			.attachs = ~0ULL,
+		};
+		subtest_userns(&opts, userns_obj_priv_freplace_prog_fail);
+	}
 	if (test__start_subtest("obj_priv_btf_fail")) {
 		struct bpffs_opts opts = {
 			/* disallow BTF loading */
diff --git a/tools/testing/selftests/bpf/progs/priv_freplace_prog.c b/tools/testing/selftests/bpf/progs/priv_freplace_prog.c
new file mode 100644
index 000000000000..c9ab81988624
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/priv_freplace_prog.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("freplace/kprobe_prog")
+int new_kprobe_prog(struct pt_regs *ctx)
+{
+	return 1;
+}
diff --git a/tools/testing/selftests/bpf/progs/priv_prog.c b/tools/testing/selftests/bpf/progs/priv_prog.c
index 3c7b2b618c8a..be9deda38b52 100644
--- a/tools/testing/selftests/bpf/progs/priv_prog.c
+++ b/tools/testing/selftests/bpf/progs/priv_prog.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
@@ -7,7 +7,7 @@
 char _license[] SEC("license") = "GPL";
 
 SEC("kprobe")
-int kprobe_prog(void *ctx)
+int kprobe_prog(struct pt_regs *ctx)
 {
 	return 1;
 }
-- 
2.48.1


