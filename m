Return-Path: <bpf+bounces-53703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2F1A5899D
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 01:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B3C16364A
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 00:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F94F320F;
	Mon, 10 Mar 2025 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+foJHPD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82D279C0
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741565637; cv=none; b=MCGWqGiQU8oeGT+VlqNNoRh56/8f0ZE6BpNy87cqXx+7pnC3+haZ1nxbqT9WCY/WbghY+yfHpHCFX3bNZsIFwyi3t9X3bHM7pDFaly/FOyaLOVMRM8JhA+efO024ybGvibZgWTJbSVldpSxvHQcPDXeiR+/eEXPUGZ5JxqfgQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741565637; c=relaxed/simple;
	bh=qlVzoobfcMKhrZJlUXVsYUBWE3RYkGGNjsUv4tABpv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/vpvi6nWEWbuKWN2JpwJR6nVfbO1JYshdQlsGCb2pzQselJDpbRh8rtHbwa0EfQs3rmKqudFbUcVYMWYLX9Q8P+Anrrpf12rxhM3kkFPU49UKynI6G9B1VFuBPOYDUMmDvMBarG6ncFBter4QJmJDJfK3EJjTYXhbZQizee8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+foJHPD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-391342fc0b5so2804666f8f.3
        for <bpf@vger.kernel.org>; Sun, 09 Mar 2025 17:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741565634; x=1742170434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cWjdThWCRTh5geVzdUfIM+DjntvFxskQHUQIqGAp+g=;
        b=A+foJHPDgfK7KQyoD4MwdESu/tWWHznkmkA7Kf0wyC9aNGihk+OivTEZWNYAN//so/
         TVQ6Q9EguKQnxa1XfqbVCHgCjTTTB+qq8r5nH7AGoYFVq1BxnT4itXWAApf+98pC2d6W
         7H0u5MCSxFS/JE1bs7ZELTxTckhhCHzgWRnI+3inENMd5NdDI3ZrAAi2fZLQmMJSx0ez
         lt74FBNjeHrOamEv6R+wSrTHr1xH/XtAtoQUfvZ6eKq5Ji3/tYXZYZV84bSdprnuQV/t
         5GKoZx7UDq+R0H4f/+T9bHpMVfmELck3E70EJgI1tSaIPBBw14u2W8DDEIL5egx1vJzF
         widg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741565634; x=1742170434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cWjdThWCRTh5geVzdUfIM+DjntvFxskQHUQIqGAp+g=;
        b=MCgrc5+GLwGGFSG68bjsJcs+gxLCNoan/vmpMTSalMZIeV9smD2QZS0fMEGJSgtPoZ
         RrEo+UbwFQi9/35AO72j7laJ2r1tGUUxhDtAzSPwBfGiwi2s0pW43pkeC4hgrOXKqxHb
         EOP09BqToKqJewe8tk1a7rVmUuHhLVlWYkX31J+I/Q4gmywRhBn0cWKaDlY8JS+/levT
         YHnArbSlvOBH55OJNGJRfkI4ErK8+RkKr5mEDPeyMICqYAqKnrgM3dyx+Ltp/aY8tu7y
         6qo1IKAvN5kD9EuZfvlDuLacH780T8bZSYQf4KH5WRB8SudLD6Tw4JsUwh6EeUBfMNdx
         xu/g==
X-Gm-Message-State: AOJu0YyZ9ZIBrzjIZ8H264AFeScKHwh9fo3Qz0u34eBHnYD820QqU9y2
	IXbjbNBzYeUIjKcyF1kdaNUEy0kfqzbjSYq+zouEmkR9LoC2mC04mbGQAQ==
X-Gm-Gg: ASbGncuJIy3iuj/yeY1SJPqJhTxHxjwC7N2mUOca0BKIHrAnk8OkYx9FmlqJiQlpPbJ
	ol8mJCOiu4/FFBfiPOEMsIcfOWSS9kE6ZOHyoTlTqToRNJRSBsuRQaMN31DNnG26XerAjHu9JdN
	E186O2SzW8Bg+aD83piplWKMIAr5SxQThL5yo6RBeZEvk6x9zD47HpfR2N5UJ/ta96DgFxsJcZX
	3Z+SaoAZfQAfUra3h3HRi/SK1ijTDH40FNKyIINsulstYH8b/liaVC9mfvB+2G7J6SlP8yORvx9
	02wP+sWkrZGNOw6LcTvErZPy1Og6Yrja/rKjChMymBsyNQaPKxmiqAw7GNUlRVo2icFt4opsfrU
	lkFi8WtKrerMAqRqwZ2QstJ0Q3L9ZiSHIKXlOJ5Q+Al/4upqWHw==
X-Google-Smtp-Source: AGHT+IGbQnba+cIAzrcR9RrRJFxuFAkGdsDxiePzK2vs9EkkHBAqAZaKA1VCOUbF6jGWNo6F5H5swA==
X-Received: by 2002:a05:6000:1f8a:b0:391:2e31:c7e5 with SMTP id ffacd0b85a97d-39132d093f8mr8368509f8f.6.1741565633966;
        Sun, 09 Mar 2025 17:13:53 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm13181050f8f.0.2025.03.09.17.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:13:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: test freplace from user namespace
Date: Mon, 10 Mar 2025 00:13:19 +0000
Message-ID: <20250310001319.41393-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
References: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
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


