Return-Path: <bpf+bounces-53393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB0AA50BEC
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 20:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17853A270E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB9255237;
	Wed,  5 Mar 2025 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ9QakO5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4125334C
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204200; cv=none; b=kIqpm2lmzFq1yye8fsN5fSm1sj0qLouLG2vNnYgKtyTJgiYIm6kA1K0HoYgb8nL/wBDhU7sujQBiFcigglr0VP54ABpC8emCudXaI5H/Emx9ekaeNwOuA7mo8EyK+uh1JaFqEG+EV/MX63yW4kwHtFsFp4AuFhOT/lDyjzE46lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204200; c=relaxed/simple;
	bh=dZ/84hCQihC+Ypd2ZYjVPssrKGcWtViu3i2JxL7LG0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vE0Rtq5RONdoe8ewO4HL2Bn8pa4pnbzAF5+kST8wFrJGEdHZjIYE3LzVg7Yrr+DmHwBW9il74TFymoc1ltVPdTUBle6CCCHBcKvm84tYoKY8zmkR5X4aZuDVonDgxA049dNIQtntwF45gdp/CATA+Pr23QMPla2e2KBtLhZ4jNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ9QakO5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf6f3b836aso645982066b.3
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 11:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741204196; x=1741808996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO2YJoHjn82OMdZzIe7tciRRk4plbnuDr6FNsdZoOD4=;
        b=WZ9QakO57S8d8kXvxmP9wy+vEVCSWaya0zUI86osS1BXYZRJ8I8aRkd/DE45tlcMCA
         hrxdXs2lFS5z/9ndc7Vgv/f24Au6wsv41j3VYJ/rZCw9JGXPQEzZMuYPuAbo6dMUjKTD
         WzZvqwxhX4WJ5L4zIcpE/63aMN5Emw0IGxm2Dbz9ktj8cW7a6ZyhxpXtZVm+0Dny9EUj
         mHIeFbQp9ZLjXuEbbamMd3t9SYx4L8XH+HGSl7XXXqe3sxYFeFEwlsrwGxmbWOe2jH3O
         s/EOlc7VCARgZmxs20RwaofNImq9FxUB7y5grhJUfQcci5mMOOiRb97yuQFs+FnHnQr0
         4ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204196; x=1741808996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KO2YJoHjn82OMdZzIe7tciRRk4plbnuDr6FNsdZoOD4=;
        b=EMay5MvmanXKhnLxIGixjw2VLzpOLFuvOu7vdtr3GVCRlUd1atVs0rZugmLdREGtVT
         jBRyacwmid5q4Z8ePkpne9cP3d62nnAayU5MV5BvxM1NeNFU76gDysIdEva8FGGj7lDV
         KO8B1dCBrPxGI2gDDDn3g1eVdd9senlxCDYVTPVgRYrEEkbEdEb6VyjHLu6b7LMG+zsN
         vnrGc9enNIyty3HtEz0j7oA7eGpdWjwQSbE3ThCl7DthiIAZS6K0+nV7sYPDugqJtzM9
         S9BVN+xf8ZGDRoBr9sWKmijTnD1tEHpaTZ70NAOM5vv4tqCNmaoGnLcaeTgcireqdT/I
         tfDw==
X-Gm-Message-State: AOJu0YzS7Endn2AVbuKJLt0MuxvwKh0QEXNMnzT//lLvdv7IB96cvhsd
	n/5Hlt1tko5vp9UiUbMQixIyDA4LIIAakx2nxUWlPB+TE490gveIdk2zWw==
X-Gm-Gg: ASbGncv+ZWvlTtsOGusr7XaIFQ5bGe4omydM90Ht9pHjtS41ZqMOt0iWmpK0JeL7iLe
	W5wTzFXrUVaKxcBml+TJhNuuA1H2u2RSK+z6u2drZmGvy5lzvfGz+dssFRE6xHqoAVOyhdjxpNp
	nY2QEkxmk4U+KBxCM7w31cqjPfhrupPSyrViMhWImnYi41obvgVX1xUOG32kqjXgQ73zMx9oB4Z
	Zsa2lgK2jGQWNsLJwHSA5dyCkghAHEj61kCj/1nu81/ls2VEpz0NN63HopTcpKnN//f3/ivsZlt
	QbsV904SebWo8bhsIuyYPWPE9djscZJ7fppi2bvX0UAyFXZ2mZgrwSrT9NA=
X-Google-Smtp-Source: AGHT+IGPkTH5ayoxigT0tl6qNeVZiPvMa0oN1qDS2d9a1+vYBqmm6SE39lozLV4BpEAWPx8LqUCIWw==
X-Received: by 2002:a17:906:6a09:b0:ac1:ff43:82ae with SMTP id a640c23a62f3a-ac20d97c81cmr488633966b.2.1741204196217;
        Wed, 05 Mar 2025 11:49:56 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:4624])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1daea1cd2sm481584066b.181.2025.03.05.11.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:49:55 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: test freplace from user namespace
Date: Wed,  5 Mar 2025 19:49:42 +0000
Message-ID: <20250305194942.123191-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305194942.123191-1-mykyta.yatsenko5@gmail.com>
References: <20250305194942.123191-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/progs/priv_prog.c |  2 +-
 3 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/priv_freplace_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index c3ab9b6fb069..00ebfc36f202 100644
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
+	if (!ASSERT_OK(err, "set_attach_target"))
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
index 3c7b2b618c8a..bc3ccd4906b3 100644
--- a/tools/testing/selftests/bpf/progs/priv_prog.c
+++ b/tools/testing/selftests/bpf/progs/priv_prog.c
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


