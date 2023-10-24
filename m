Return-Path: <bpf+bounces-13157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20B57D5C4B
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 22:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E11281AFC
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1143E47A;
	Tue, 24 Oct 2023 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic/9UaJl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169563E01E
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 20:19:41 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFE8D7A
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 13:19:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ca3a54d2c4so40919645ad.3
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698178779; x=1698783579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3K2T1S1+YZpUdmcQvQ+gGi3HocS0qGhCik3vUdjcGiI=;
        b=ic/9UaJlyGsjkw/dLcW8PKOW74tfP+uKJeEIixbtJS+xHfNRnU2iN6Ep1ifHvc4WWs
         om9gK8IUoA7rsqk1vR3U1eprOFZArUVMoy0R+mtG87bylCvqjw3zewEl4WbKQ9GWNzJg
         U58iGlivqRrizTLy+C8x4Gho8kzrlK2e5gTy8NQY8pJlopbIuoMX1VZQwhKPLfaxqk1d
         riXLULk5G0mqzBSIyTo7R2IA5uAvAxybXZfJvUfjp2kUqbNmMaBeh8RnJZzG4Yc8hyP9
         zxdiDlX/rrPAUt0UzCnwVzbWXSTGHZVcj20izLMMPyluKwWt9dIkQOk3t29VsPgMFc0P
         +H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698178779; x=1698783579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3K2T1S1+YZpUdmcQvQ+gGi3HocS0qGhCik3vUdjcGiI=;
        b=Yu3liTreB5qrHCAzFi2w2OR3a4YgzL5y0hMmJpxZGmwHEe90hUFKQAR4wGbY0ytjg0
         18/O4SXT0QmOa/TrbjH8RXBKK3VKsrzcRt8gpmwmy25Do5jZHpZHBiI+UA02iyibZ1eP
         PLH+hcUlK1+7w7aEK0uc8lfT7dXgxLXTiiDUNKQzdfXkBtZAad8NMz3w7CWmLH7A+IzO
         xZ2WtzTt9ASfPbCkJP4Fllwc3YbNvQaFcx3eB58ZtE+dpu/iDE+8jQ9rmwkzsoxfGAWj
         M3C/XT5utJ6Nkz2H5bCMioKrPh0RYB3SP08fZEVpOwGfu3x++TMYtigdgGQpI+tzACYE
         8iXQ==
X-Gm-Message-State: AOJu0YzwmXq7RwGWO5M0Df+RyuWN199VDEkdvsum+O55lSNXSSscwJK1
	k/lHS4p7qs/BP5mN0Uaj4LUSgw8H0SKfAA==
X-Google-Smtp-Source: AGHT+IEesXVpv7VW7fsu9te30XvX6ugSB1QQ4YIsMj+I5BW7fZdRPLf7ba7bCYCLyu9D521rzlVHUg==
X-Received: by 2002:a17:903:2846:b0:1c9:cc88:5029 with SMTP id kq6-20020a170903284600b001c9cc885029mr12715628plb.32.1698178778874;
        Tue, 24 Oct 2023 13:19:38 -0700 (PDT)
Received: from surya.localdomain ([2600:1700:3ec2:2011:3ef3:bbdb:b46b:4676])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001c74df14e6fsm7717872plg.284.2023.10.24.13.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 13:19:38 -0700 (PDT)
From: Manu Bretelle <chantr4@gmail.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org
Cc: Manu Bretelle <chantr4@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: umount children of TDIR in test_bpffs
Date: Tue, 24 Oct 2023 13:18:52 -0700
Message-Id: <20231024201852.1512720-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently this tests tries to umount /sys/kernel/debug (TDIR) but the
system it is running on may have mounts below.

For example, danobi/vmtest [0] VMs have
    mount -t tracefs tracefs /sys/kernel/debug/tracing
as part of their init.

This change list mounts and will umount any mounts below TDIR before
umounting TDIR itself.

Note that it is not umounting recursively, so in the case of a sub-mount
of TDIR  having another sub-mount, this will fail as mtab is ordered.

Test:

Originally:

    $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -a test_bpffs"
    => bzImage
    ===> Booting
    ===> Setting up VM
    ===> Running command
    [    2.138818] bpf_testmod: loading out-of-tree module taints kernel.
    [    2.140913] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
    bpf_testmod.ko is already unloaded.
    Loading bpf_testmod.ko...
    Successfully loaded bpf_testmod.ko.
    test_test_bpffs:PASS:clone 0 nsec
    fn:PASS:unshare 0 nsec
    fn:PASS:mount / 0 nsec
    fn:FAIL:umount /sys/kernel/debug unexpected error: -1 (errno 16)
    bpf_testmod.ko is already unloaded.
    Loading bpf_testmod.ko...
    Successfully loaded bpf_testmod.ko.
    test_test_bpffs:PASS:clone 0 nsec
    test_test_bpffs:PASS:waitpid 0 nsec
    test_test_bpffs:FAIL:bpffs test  failed 255#282     test_bpffs:FAIL
    Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
    Successfully unloaded bpf_testmod.ko.
    Command failed with exit code: 1

After this change:

    $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -a test_bpffs"
    => bzImage
    ===> Booting
    ===> Setting up VM
    ===> Running command
    [    2.035210] bpf_testmod: loading out-of-tree module taints kernel.
    [    2.036510] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
    bpf_testmod.ko is already unloaded.
    Loading bpf_testmod.ko...
    Successfully loaded bpf_testmod.ko.
    test_test_bpffs:PASS:clone 0 nsec
    fn:PASS:unshare 0 nsec
    fn:PASS:mount / 0 nsec
    fn:PASS:accessing /etc/mtab 0 nsec
    fn:PASS:umount /sys/kernel/debug/tracing 0 nsec
    fn:PASS:umount /sys/kernel/debug 0 nsec
    fn:PASS:mount tmpfs 0 nsec
    fn:PASS:mkdir /sys/kernel/debug/fs1 0 nsec
    fn:PASS:mkdir /sys/kernel/debug/fs2 0 nsec
    fn:PASS:mount bpffs /sys/kernel/debug/fs1 0 nsec
    fn:PASS:mount bpffs /sys/kernel/debug/fs2 0 nsec
    fn:PASS:reading /sys/kernel/debug/fs1/maps.debug 0 nsec
    fn:PASS:reading /sys/kernel/debug/fs2/progs.debug 0 nsec
    fn:PASS:creating /sys/kernel/debug/fs1/a 0 nsec
    fn:PASS:creating /sys/kernel/debug/fs1/a/1 0 nsec
    fn:PASS:creating /sys/kernel/debug/fs1/b 0 nsec
    fn:PASS:create_map(ARRAY) 0 nsec
    fn:PASS:pin map 0 nsec
    fn:PASS:stat(/sys/kernel/debug/fs1/a) 0 nsec
    fn:PASS:renameat2(/fs1/a, /fs1/b, RENAME_EXCHANGE) 0 nsec
    fn:PASS:stat(/sys/kernel/debug/fs1/b) 0 nsec
    fn:PASS:b should have a's inode 0 nsec
    fn:PASS:access(/sys/kernel/debug/fs1/b/1) 0 nsec
    fn:PASS:stat(/sys/kernel/debug/fs1/map) 0 nsec
    fn:PASS:renameat2(/fs1/c, /fs1/b, RENAME_EXCHANGE) 0 nsec
    fn:PASS:stat(/sys/kernel/debug/fs1/b) 0 nsec
    fn:PASS:b should have c's inode 0 nsec
    fn:PASS:access(/sys/kernel/debug/fs1/c/1) 0 nsec
    fn:PASS:renameat2(RENAME_NOREPLACE) 0 nsec
    fn:PASS:access(/sys/kernel/debug/fs1/b) 0 nsec
    bpf_testmod.ko is already unloaded.
    Loading bpf_testmod.ko...
    Successfully loaded bpf_testmod.ko.
    test_test_bpffs:PASS:clone 0 nsec
    test_test_bpffs:PASS:waitpid 0 nsec
    test_test_bpffs:PASS:bpffs test  0 nsec
    #282     test_bpffs:OK
    Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
    Successfully unloaded bpf_testmod.ko.

[0] https://github.com/danobi/vmtest

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 .../selftests/bpf/prog_tests/test_bpffs.c     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index 214d9f4a94a5..001bf694c269 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -3,12 +3,14 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <sched.h>
+#include <mntent.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <test_progs.h>
 
 #define TDIR "/sys/kernel/debug"
+#define MTAB "/etc/mtab"
 
 static int read_iter(char *file)
 {
@@ -32,6 +34,8 @@ static int read_iter(char *file)
 
 static int fn(void)
 {
+	/* A buffer to store logging messages */
+	char buf[1024];
 	struct stat a, b, c;
 	int err, map;
 
@@ -43,6 +47,30 @@ static int fn(void)
 	if (!ASSERT_OK(err, "mount /"))
 		goto out;
 
+	/* TDIR may have mounts below. unount them first */
+	FILE *mtab = setmntent(MTAB, "r");
+
+	if (!ASSERT_TRUE(mtab != NULL, "accessing " MTAB)) {
+		err = errno;
+		goto out;
+	}
+
+	struct mntent *mnt = NULL;
+
+	while ((mnt = getmntent(mtab)) != NULL) {
+		if (strlen(mnt->mnt_dir) > strlen(TDIR) &&
+			strncmp(TDIR, mnt->mnt_dir, strlen(TDIR)) == 0) {
+			snprintf(buf, sizeof(buf) - 1, "umount %s", mnt->mnt_dir);
+			err = umount(mnt->mnt_dir);
+			if (!ASSERT_OK(err, buf)) {
+				endmntent(mtab);
+				goto out;
+			}
+		}
+	}
+	// Ignore any error here
+	endmntent(mtab);
+
 	err = umount(TDIR);
 	if (!ASSERT_OK(err, "umount " TDIR))
 		goto out;
-- 
2.40.1


