Return-Path: <bpf+bounces-53620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAEFA5739C
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 22:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A7E16D726
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1B22580DF;
	Fri,  7 Mar 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lndpvSEI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BBB25523E
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382990; cv=none; b=idUZryyNos789s0onOupkOgLyrFjXtIa6vLUPNlH4KWcTnQDtv75or6dJtGTJN0o6jx5dN0ezvNmRWuC0TzrnG4emC5+IRIp9Uvl9MI8hjnEUJNKq1DaXsJr9CWzMS4zYAN38Nwpwg8b/KRtybWv6lTNtMSRbqi3nBzIW7+LfwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382990; c=relaxed/simple;
	bh=dioW0rtSUrFbWMOF5Sm4XUOjVd88CLtLSI7b2ywKPwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQSIq0dW5F5a9PdkfHzCQbYk0U9fuhPYc4pfLzEppQdjypnJVVwqQdvziSphX68cGcf0HZTi/D2gPNYZjKDNHhRG/svTbEU/HA/I09DOx7z+PxEfYTY3ZvBLTm7kMlKqFdpRq9N6dK3oNqrDUDx/KrwLO5uKTJJ6hlOxWvlxxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lndpvSEI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so13931025e9.1
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 13:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741382987; x=1741987787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCxVpM2Z70WedqRB/NM4NnXszCOJVduR87WYoAxhXFg=;
        b=lndpvSEIbikB6RvmbH1Eg5+pgmxv6BFY8S/XiQQKc8qYaIj3Kn+HhYzJdPOHos0qNP
         aE9iYsosyBwjFjyy7EkkFmSQLIawQDKhNTHuHHjxlLnALEQdnk2T/KUn/n8qRsnLHrI5
         eZg9c20OMO/EMDlkzPHi60PtVoi6erxR4t14Prr3MdZpHflIzApSG8oN3i05uiyU7yst
         Owb2xgvHahQR35iJUjgyICAejdzJUN9EsDH931+SAhs+e0bSD3f6AG15L/2/w4qeFZyV
         24NZhII8CalyiDXSwJcnhUjitM8cZA2Yu5xp00iXGVMl9l9y3eSy12Rds5vpgi1Qjw9h
         RLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741382987; x=1741987787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCxVpM2Z70WedqRB/NM4NnXszCOJVduR87WYoAxhXFg=;
        b=WDbrF9JLGGQQIojRIX/p3vtydfV54Ew4wkf5Dxlv8z2cqB5I4tVhSlg9rj7xPMkhVd
         vyr3/mZa86ZuIPOIwhqgEGXPYrzmJelE1i71av54swCK391FD3M9rGyHXd6wueLwPELf
         XtV14L4jouesRnCHjqYwQHZOmumh4rUiFptFqmXPRbdobHqXwsNKizks8cBpnqM3RMPG
         hJEt+UohpoU4hX1FQvDNP7mr68HZwG0LGQf4V/5mMETeGE9fCKn6xR9qxdfrOj2okM4u
         Jb2rpZdERdYTmPgCyVYzNXU5Qhm7MCKuLzZxd9n9pM4qqeFh0A+Es8zdsW1DxuX9H3mM
         kyfA==
X-Gm-Message-State: AOJu0YwvHfZFT6/xekJUo5uz71J9DNs96vciSZ63Z7UMOY82sF3PoArc
	xWtoBl8Yj4oHLX3hz+EMRBwebMRnp+CaPOdAI40+nZhALfM73m3/jRHubg==
X-Gm-Gg: ASbGncu42AYA2cctOfqpXNND4wp4Wnj/DrndLlDE8JdaEhZw+A8waFF0ewWQCIKNTH6
	RVGNo7UJSaf9bGg8nOeNqUlm4aTizinhAOnLidS0GEm5U7TIDXUxRulDug8SxfBsKCpbuIbqRnD
	EACFIIhIAJg6hZPVhGd396m9ScpQCvC/OOPfRF5WrSN0cIQCd09sA+zQbIQQQA2f95YBtZdTFjo
	71MLGz8q/8nAXivkUfqEZyUJg77Y1KPiDBKrgLR8mFgf8RNMhzdVHFsZcDEGozYXN42ELGkLX4q
	81tUaQ+nXXrT6Cklfh7RnoNE8IDDPEs5arWtRNg0nvmjrQwXoHdIb9ZgxL1ixnfXYXmT6w44hIi
	cX1QgU+lq5fgLW205SZLhYrMXKPSVkeI72Zi0JqjELJGw+CFc2w==
X-Google-Smtp-Source: AGHT+IE6xn6g2r43GCVVO3vvZ3J9t9njIpNv+z/KNIRi7dkWP89VS+zvNHKGd+KwQ6ead/j+XTfvEg==
X-Received: by 2002:a05:600c:35c9:b0:43b:c3af:32df with SMTP id 5b1f17b1804b1-43ce195575cmr14331935e9.26.1741382986997;
        Fri, 07 Mar 2025 13:29:46 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352e29sm92203145e9.32.2025.03.07.13.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:29:46 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: test freplace from user namespace
Date: Fri,  7 Mar 2025 21:29:34 +0000
Message-ID: <20250307212934.181996-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
References: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
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


