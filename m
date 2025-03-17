Return-Path: <bpf+bounces-54222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA67A65B1D
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5751174588
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A801AF0D0;
	Mon, 17 Mar 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbMk/dP5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24031B043E
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233255; cv=none; b=V2Xtdxi0RQfdM7fzKhTQKC5QsieGdpU7i1zF305/oTqK8goK5GLX80Boik4+S91AP+IZ2CXGPohrNti0BgqXxC6IvY/P9FANA2EtpHOOXMut1kv9qIPH6yen5NmujC8C8uhX2zffOksbNhMyenwV6NuIAE5ufdOP3MxeMlGqIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233255; c=relaxed/simple;
	bh=qlVzoobfcMKhrZJlUXVsYUBWE3RYkGGNjsUv4tABpv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzKJzV7BWNNMym/FaGKCZsUU43lLBmq2o/BZ/+/gjCn6/vcDC81iwJgC7yWyrCjtG0Q5LjERLQw9r/nieG21UZZAk2e0iRo32yEDHq6yls+M0ic1cWdjdvffpk2ABF1aT1I4G2Vz3/ovH6clR6+CXocoMGJZsRt9zoTDvhoprSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbMk/dP5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso838677066b.1
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 10:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233252; x=1742838052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cWjdThWCRTh5geVzdUfIM+DjntvFxskQHUQIqGAp+g=;
        b=CbMk/dP5YfFYSNSoVFls9MHG3CZY9Qy0xcv/5YZNsfag2bHH0WUPyBaUUmFB7+hxS1
         MHizz96rSMD1+s56eqgIhRPvuIBizd7QALsOIrzWayEZtJ3kylUnhtUmS5KfDjPwGE4E
         8+zskjLhZDgGKAGtOuKLU9xf62LciDQgzBPg/PfKRSLoifLKvs7NymSstkWq4I/Ax6Od
         mScPddKD1TWH+bJzl1f6RLUueYA/Papt0W6Vclw33UDGD5htsnkTJU2sakmAL1DZnEmT
         qVk8K3u6uq7zJwToOr7Y3EsZtMiRXtqtaL+Y4Wq2mjiGfyLluJ/NkDocUrvgQVutthbj
         eOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233252; x=1742838052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cWjdThWCRTh5geVzdUfIM+DjntvFxskQHUQIqGAp+g=;
        b=DoJTwgTQr57iJjGalhMeRK/EReb47p+J9TNGvbDJyfCYNaGZ0SyJJYFz4CWxsvByNw
         Z3Oamh79mFIqt8cA4QIrcgnDMjoWy+qo0qV0fTH3j0G+IG2d1y2oTTOmWYnE1E/2iETQ
         fCjWZxbj4T4JV29sWEu5jJwHNTlKBB9gRzzBSoRHxTfIU46hlrkCkOlLztpw7IkrETdr
         5mx5n14G5hRTuDEhy4ebikQd4kJUeAakfaD6ysw+MlsZinMYXEZWRf3aWmLULLunyV0h
         +45lIjFYe6MnRelRfY2twXOlGZAVpLtaPtfrc/ocb8zJejn2u+iR8xwkS+vZhZve2o8n
         Oz7Q==
X-Gm-Message-State: AOJu0Yxu2XdHA9/JVLKta8W8WM867Be0bxcZb9vgKPkvLaYhQN/ogCtu
	OKwjscm1170dEjnagr1gJUN6ezZeY1bzbg69SKPWgmoECzsi/F3/TMzvhQ==
X-Gm-Gg: ASbGncvG9A5xHcHms6S8l4HvJdFf429tyFuj7EU6kOuyDhoyzSGe2E8svyAOo/j1t6s
	jFSYQ77ClCqjEixdupM6Wg8e+rmE9ephFayR15uGP+l5xP6y4pBT//ortLcr2plgPJ3TTDhzLeE
	wOD0BHRdGIwVRzz2zv+K69ojqxgM+AVG1KEuoub9XFfxb1aIvUwhvXP5g019Xdm/hoKRHAD1VUN
	CLVVvLU1rT/zPnGtWm1GXcW6iJsGjOPFiPgZvkbqGecGF24XJy9yvc3NM9MVEoUNGvgxB0Y9aD1
	f0+W0GogzPI+JIr0adUKEhT+m7zffljE9fUzqwxraOnDclmUUXHYjB9pAQ==
X-Google-Smtp-Source: AGHT+IFnXK3a0VXDTwjNeb7qdvaqupkLDGSsyYOdAVr+rOEu5doTvsJm6giVv5Wcu0WmUnpE7qtW2A==
X-Received: by 2002:a17:907:e84c:b0:ac3:14e1:27a5 with SMTP id a640c23a62f3a-ac38f6d8321mr40328466b.1.1742233251466;
        Mon, 17 Mar 2025 10:40:51 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::4:812])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9cadsm693917166b.48.2025.03.17.10.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:40:51 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	yonghong.song@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v6 4/4] selftests/bpf: test freplace from user namespace
Date: Mon, 17 Mar 2025 17:40:39 +0000
Message-ID: <20250317174039.161275-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317174039.161275-1-mykyta.yatsenko5@gmail.com>
References: <20250317174039.161275-1-mykyta.yatsenko5@gmail.com>
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

Modified type of the priv_prog to xdp, as kprobe did not work on aarch64
and s390x.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 97 ++++++++++++++++++-
 .../selftests/bpf/progs/priv_freplace_prog.c  | 13 +++
 tools/testing/selftests/bpf/progs/priv_prog.c |  6 +-
 3 files changed, 112 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/priv_freplace_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index c3ab9b6fb069..f9392df23f8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -19,6 +19,7 @@
 #include "priv_prog.skel.h"
 #include "dummy_st_ops_success.skel.h"
 #include "token_lsm.skel.h"
+#include "priv_freplace_prog.skel.h"
 
 static inline int sys_mount(const char *dev_name, const char *dir_name,
 			    const char *type, unsigned long flags,
@@ -788,6 +789,84 @@ static int userns_obj_priv_prog(int mnt_fd, struct token_lsm *lsm_skel)
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
+	*tgt_fd = bpf_program__fd((*skel)->progs.xdp_prog1);
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
+	err = bpf_program__set_attach_target(fr_skel->progs.new_xdp_prog2, tgt_fd, "xdp_prog1");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = priv_freplace_prog__load(fr_skel);
+	ASSERT_OK(err, "priv_freplace_prog__load");
+
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
+	err = bpf_program__set_attach_target(fr_skel->progs.new_xdp_prog2, tgt_fd, "xdp_prog1");
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
@@ -1004,12 +1083,28 @@ void test_token(void)
 	if (test__start_subtest("obj_priv_prog")) {
 		struct bpffs_opts opts = {
 			.cmds = bit(BPF_PROG_LOAD),
-			.progs = bit(BPF_PROG_TYPE_KPROBE),
+			.progs = bit(BPF_PROG_TYPE_XDP),
 			.attachs = ~0ULL,
 		};
 
 		subtest_userns(&opts, userns_obj_priv_prog);
 	}
+	if (test__start_subtest("obj_priv_freplace_prog")) {
+		struct bpffs_opts opts = {
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD) | bit(BPF_BTF_GET_FD_BY_ID),
+			.progs = bit(BPF_PROG_TYPE_EXT) | bit(BPF_PROG_TYPE_XDP),
+			.attachs = ~0ULL,
+		};
+		subtest_userns(&opts, userns_obj_priv_freplace_prog);
+	}
+	if (test__start_subtest("obj_priv_freplace_prog_fail")) {
+		struct bpffs_opts opts = {
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD) | bit(BPF_BTF_GET_FD_BY_ID),
+			.progs = bit(BPF_PROG_TYPE_EXT) | bit(BPF_PROG_TYPE_XDP),
+			.attachs = ~0ULL,
+		};
+		subtest_userns(&opts, userns_obj_priv_freplace_prog_fail);
+	}
 	if (test__start_subtest("obj_priv_btf_fail")) {
 		struct bpffs_opts opts = {
 			/* disallow BTF loading */
diff --git a/tools/testing/selftests/bpf/progs/priv_freplace_prog.c b/tools/testing/selftests/bpf/progs/priv_freplace_prog.c
new file mode 100644
index 000000000000..ccf1b04010ba
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
+SEC("freplace/xdp_prog1")
+int new_xdp_prog2(struct xdp_md *xd)
+{
+	return XDP_DROP;
+}
diff --git a/tools/testing/selftests/bpf/progs/priv_prog.c b/tools/testing/selftests/bpf/progs/priv_prog.c
index 3c7b2b618c8a..725e29595079 100644
--- a/tools/testing/selftests/bpf/progs/priv_prog.c
+++ b/tools/testing/selftests/bpf/progs/priv_prog.c
@@ -6,8 +6,8 @@
 
 char _license[] SEC("license") = "GPL";
 
-SEC("kprobe")
-int kprobe_prog(void *ctx)
+SEC("xdp")
+int xdp_prog1(struct xdp_md *xdp)
 {
-	return 1;
+	return XDP_DROP;
 }
-- 
2.48.1


