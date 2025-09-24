Return-Path: <bpf+bounces-69638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A49B9C888
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 01:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEED64E3312
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A72BD5A8;
	Wed, 24 Sep 2025 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5pgjaOj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A4296BB3
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756287; cv=none; b=QXG/bZyhEa3um2eyeQzaBh/lAX/QBaV91bQghp0vag47odnVIRwoQRptJMYBmSTfJ/mMuAR2cX6IttVqohwBdgphNvCYQ46OlbXBWw/7i2qDGwUSwJ2L/Iawljeak+9ArRoH05kAA1NPvQuCCaV60BGPZufDVz1OjiVHedDmaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756287; c=relaxed/simple;
	bh=jaQTaJ4mYwHZIzYYD9MZVWoeMd3U8prEmCe/Sz2asJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhDMXSpMBBrJIbUJdSaOibEbjwgCwA38JxuZqlIkhXg/cR/SY0PnO+WP3gQaGMSYhPZjUYC5MUQRNWubJ5cpLsuDQGhPo4kJX2zMh+Y8eJfO9cB5j2TJwiLiSt1rSopmxZvgpsmz04KfgC8Xd+B+YUwo2+yh7c63Sjr+HcOeYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5pgjaOj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-84ab207c37cso33593085a.2
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 16:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758756284; x=1759361084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhxvs9hARKBT28uRXK2/9g46kPCnOYI+QDN0T6RZ7PI=;
        b=C5pgjaOjnjLCyt1/dXB1iHOHahrN5q/U98S0flynxEgcR8xdlEpIvNZ0iF+r8PQvRh
         csajHqfYlUoJLHTUS7mwPpFj0kNL/gvbMW0OTIlj45ru373KKNL5vmYr+BqQnOrI0Wdf
         uu/Sbm/KuJPDWun0vcrRIcXco6IFz1a13DmYcsCgpYLXAGpl2i0TQI+4hcz4J/UIUnNM
         5ezeUHq+RF1jY5muBgCaB682Ro+GWuD4jIW9yrX5pXs9l7pExN5+qFp4VuegOSZeUeIz
         khJv0eURBXLCtmYFO0wgyYZexzx/vUIG95mhlvoOp/NQI//fJBEQqxYGU/nFcxMLw1em
         MJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756284; x=1759361084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhxvs9hARKBT28uRXK2/9g46kPCnOYI+QDN0T6RZ7PI=;
        b=fEJdkBkmdyPNgwI77bXFAvPhn1iuE1DugbtWjuY74UdaMJmSxqDtFvExsT6XJExrBR
         cMNhClRe5s3v9z6F6Y6OhxZ9iSZhRhKg3crTVLAMt2AwYG2Q6xZRIp6WMD4eOAUYlXuw
         k6dDsNVex2WtyR4wBKeTAts2vns+rM9/AgId2H7HkKXoxJGf70AFrse4RjpSgnlOtJ1D
         LM8tP/wfOPyLdki85VRonbaX6nDx+hs0eaLl4nS/29gNwX+JrVc42gTM7L/jLh85QT/R
         tTsAMwe2bTkDAJQKpiHgCTOsjbwWhfTQzmcPqIje5vuq8gTt0Ijol7bBkRPktlflGV2g
         sKsA==
X-Gm-Message-State: AOJu0Yxb5VTRElJtPgWZz1RjeHROfF2JEelqyuNqXBruDUWbeIlgpUgH
	LXiFDcdTdPcIpVcIh6GfBHX/XBQgnQH0KZB7zOu1K+CEezegFPsoTiM4k/K+IYIPauI=
X-Gm-Gg: ASbGncv4EDqer87lo1b3WI5YmhdXe/2c0JqeE9Rvf/GKIiLs+E3iC2G5+/r3blYhEox
	uWgYZJ2mafSYQ6OLIBJdKozPr6zmBmfSTtJJmzzvNqbOkYxoNWMwPYumrpoMfPOgMd0yZaAuDs3
	wN2oA2/7mstEyVRvanpGUZ/luG0F3eScIExOLn93D1Y2RnG/a+npCUbI1btC5I/l/6hcVKXVVO6
	pPH1MrNPxawwMXi/TtHa9eLhNTQesi1GfI+I0eqteRyP+Q0oePrDD8Akbk3A9nWOeQzHk+SZGA3
	ku5PmtpJ4XAzDe8iKj16yppgYFB3ISaD0n3+xgYXwDh/EEQ/HBq9kL067DD6+xqoMKLrgQb1Tla
	MA683wU6ZOMMg1EGJgri1zdVOzLb1uOWkkgJVZT85x4fo0Ay+zu2kBwBxoUNyfnHXMYQ8cxw0+x
	9zEHInhL64MBsYzev986IHKRn8eoI=
X-Google-Smtp-Source: AGHT+IERx8EReqdB+AR4i0YygQ81NTk02G9COW9XUNRRcYHmx70BU4ZhZixQqD4M4PCXNTKY/arATA==
X-Received: by 2002:a05:620a:1a89:b0:858:a4dd:d18b with SMTP id af79cd13be357-85ae65dc29cmr174803885a.51.1758756284448;
        Wed, 24 Sep 2025 16:24:44 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c336ad64bsm14213285a.59.2025.09.24.16.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:24:44 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	dwindsor@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for dentry kfuncs
Date: Wed, 24 Sep 2025 19:24:34 -0400
Message-ID: <20250924232434.74761-3-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924232434.74761-1-dwindsor@gmail.com>
References: <20250924232434.74761-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF selftests that exercise the new dentry kfuncs via an LSM program
attached to the file_open hook.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 .../selftests/bpf/prog_tests/dentry_lsm.c     | 48 +++++++++++++++++
 .../testing/selftests/bpf/progs/dentry_lsm.c  | 51 +++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dentry_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/dentry_lsm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/dentry_lsm.c b/tools/testing/selftests/bpf/prog_tests/dentry_lsm.c
new file mode 100644
index 000000000000..3e8c68017954
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dentry_lsm.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 David Windsor <dwindsor@gmail.com> */
+
+#include <test_progs.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <limits.h>
+#include <string.h>
+#include "dentry_lsm.skel.h"
+
+void test_dentry_lsm(void)
+{
+	struct dentry_lsm *skel;
+	char test_file[PATH_MAX];
+	int fd, ret;
+
+	skel = dentry_lsm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "dentry_lsm__open_and_load"))
+		return;
+
+	ret = dentry_lsm__attach(skel);
+	if (!ASSERT_OK(ret, "dentry_lsm__attach"))
+		goto cleanup;
+
+	/* Create a temporary file to trigger file_open LSM hook */
+	ret = snprintf(test_file, sizeof(test_file), "/tmp/bpf_test_file_%d", getpid());
+	if (!ASSERT_GT(ret, 0, "snprintf"))
+		goto cleanup_link;
+	if (!ASSERT_LT(ret, sizeof(test_file), "snprintf"))
+		goto cleanup_link;
+
+	fd = open(test_file, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "open"))
+		goto cleanup_link;
+	close(fd);
+
+	/* Test passes if BPF program loaded and ran without error */
+
+	/* Clean up test file */
+	unlink(test_file);
+
+cleanup_link:
+	unlink(test_file);
+cleanup:
+	dentry_lsm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/dentry_lsm.c b/tools/testing/selftests/bpf/progs/dentry_lsm.c
new file mode 100644
index 000000000000..fa6d65d2c50f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dentry_lsm.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 David Windsor <dwindsor@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+extern struct dentry *bpf_dget(struct dentry *dentry) __ksym;
+extern void bpf_dput(struct dentry *dentry) __ksym;
+extern struct dentry *bpf_dget_parent(struct dentry *dentry) __ksym;
+extern struct dentry *bpf_d_find_alias(struct inode *inode) __ksym;
+extern struct dentry *bpf_file_dentry(struct file *file) __ksym;
+extern struct vfsmount *bpf_file_vfsmount(struct file *file) __ksym;
+
+SEC("lsm.s/file_open")
+int BPF_PROG(file_open, struct file *file)
+{
+	struct dentry *dentry, *parent, *alias, *dentry_ref;
+	struct vfsmount *vfs_mnt;
+
+	if (!file)
+		return 0;
+
+	dentry = bpf_file_dentry(file);
+	if (dentry) {
+		dentry_ref = bpf_dget(dentry);
+		if (dentry_ref)
+			bpf_dput(dentry_ref);
+
+		parent = bpf_dget_parent(dentry);
+		if (parent)
+			bpf_dput(parent);
+	}
+
+	if (file->f_inode) {
+		alias = bpf_d_find_alias(file->f_inode);
+		if (alias)
+			bpf_dput(alias);
+	}
+
+	vfs_mnt = bpf_file_vfsmount(file);
+	if (vfs_mnt) {
+		/* Test that we can access vfsmount */
+		(void)vfs_mnt;
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


