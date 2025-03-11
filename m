Return-Path: <bpf+bounces-53865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ACFA5D213
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 22:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA3017B5DF
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C806264A9F;
	Tue, 11 Mar 2025 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR+vXLTC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE606264F81
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730079; cv=none; b=Ax9cE5uD2gfo5HisrJFwxZPaFe0fF21b+J0m56wBXLBI01h3LdZbwL+urXaJLWA3P7Tiy5YD0P0VpgTetAiGfHCEwM/OT72743wQNHm8Pl3QQoQ15WhP1XzcB6+Ip5oqwL6iPBO4oQdW6x6G6aV3Ym8p5tSHakPaMwfYw5WZVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730079; c=relaxed/simple;
	bh=qlVzoobfcMKhrZJlUXVsYUBWE3RYkGGNjsUv4tABpv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxOlH1S4Sn11CQCeJtLuSjRab77Aja8qj9O1sqRRmGTLtnG8VhOSn225eshDFNfy2YDiiTEdhCR2Y+stpQtt0PtLDoxqOTbXPyknTobJeLKUcFSgGL6VJuhBwVbXJt0YId4nNOAjLxiHXYX80gFXZAUzqg9kOJ9yptqVPPLQa8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR+vXLTC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f2f391864so3131508f8f.3
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 14:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741730076; x=1742334876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cWjdThWCRTh5geVzdUfIM+DjntvFxskQHUQIqGAp+g=;
        b=QR+vXLTCYIvVu5ycm6J8EzfOoOQwmIbZbK6Wb3t3sNtRUglkVu3dU72K1eW9NpLmIl
         Q+7rqgwAE0P7hS6rwTi/VHwXsSzRW8zrKWtOzlTmUP4mRHZ7g/d88ctyvpqcUsZdCNlj
         nzWdnZaCvrWDMTpqTvhSwQ9UqgMFY8Bq57I41e7lmdWUlcm3n7y/+dOBe+8UC6B4aPWx
         JH4EWBKO7pmrbKDlWgIxk7gG29+RFZcvOXuLsYDn3cH25Og0RK8F+kj4odvdGn11miRj
         iGYPGwaTn7kXqDfJrrW4MEtiQMDdGRN3gOytXBPAoXq8cPmjxdCfE+LaNrGgEcn6u962
         DFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730076; x=1742334876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cWjdThWCRTh5geVzdUfIM+DjntvFxskQHUQIqGAp+g=;
        b=QwDKGY2zqAxH61PugYYUC1dwwZTBqOoqDCjXJ1ldXT1FxRrdHXjvXnPT6xpEj7yBVK
         Oh48sa80XwFKyuCC08aXPqzx5pxjMVAjsUqImAmjyuJwRrXJCJpr9FjWcHp6EK6hMd3c
         BGK07bqLJgmOkao5kE/cfeWMbuiEwmtZgg1KK9uuPWFL4sokxEXXZ378AvbDMoN+Jx3x
         MSmYGoVPasKkfZey4mOvwvJbOV2KLWk3wI8XhfE7zT25CbSu6RMKXOnZfrpLr3Admzio
         zx22SGZ5gAkm3wXC+hf11kDEtV4rRtPrQw1wBXSWDUeocFl9z5xnv5k0VuPkEpZB8KG2
         UJwA==
X-Gm-Message-State: AOJu0YwF2CMEsf8E4IVaxpw8IAlAKuAcLzn+D4mo/HRoWnXaJZtYKBft
	S5lzZqUzYbyOpOH+VYssfoEVMee/O3e71sfcjQKZB+A6Zf6OulH8RdlWaw==
X-Gm-Gg: ASbGncvs826HxkulwFYgtYQOUTtgPN56EpB7UfvJg+9o/hRM5JuBJeKYcgR/D4GlSNL
	scVcqp4KqiH3FaA7HwE/bTUplepXmesDloErhrap6M4l/eCsmHnedOWYA2C2A9XhY4qaEpnGc9s
	xAVP3lT/ub52BuXJzoxjGt8L+VV+Q3x+K6RIP0/L077mfnvfGtlfOTq8o0m+wbZmn5PW2QKQbvh
	0rMCHZmoy+oobRr3jg1gN3GM/Kfcdu5piT4NTV8ax9eFTJI/dCnDLtoGqEaUuzW2MFEu5Nmx7e9
	5Qf6NeEHdhXBMbcPSGtw+NmklUaGT7+orl7xfnpBI9JgEHudFU6zBKjXIkHhC+kJ+p2t6DRvRVZ
	SrfjMAelm1Aqu4AP6h5DOtHhfF6caitblhYotH62lvz8byoyPzw==
X-Google-Smtp-Source: AGHT+IFHaY9BuLe6hJTeAYaQOc/3dmTiCbhiz9nbUIrEncS/xtzdoegmS0tu8tS0pFnD6gIVJqcuyg==
X-Received: by 2002:a5d:6d8f:0:b0:391:6fd:bb64 with SMTP id ffacd0b85a97d-39132d1d1d6mr15177801f8f.13.1741730075925;
        Tue, 11 Mar 2025 14:54:35 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd62sm18815549f8f.46.2025.03.11.14.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 14:54:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: test freplace from user namespace
Date: Tue, 11 Mar 2025 21:54:20 +0000
Message-ID: <20250311215420.456512-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311215420.456512-1-mykyta.yatsenko5@gmail.com>
References: <20250311215420.456512-1-mykyta.yatsenko5@gmail.com>
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


