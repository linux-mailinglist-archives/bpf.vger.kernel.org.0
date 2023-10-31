Return-Path: <bpf+bounces-13762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCBD7DD869
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 23:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F602813D5
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 22:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE0225CE;
	Tue, 31 Oct 2023 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPxa1Shv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357BA1F945
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 22:36:26 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E3BF4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:36:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc53d0030fso2409495ad.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698791783; x=1699396583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OKJeKTgSfVq2f+Wxak7/qIUn1AkHeqLUY0GoqdnouDQ=;
        b=XPxa1Shvy/QvHRu0ebKyeyJIgHPssRQHyxk5b4BKRWXDFOPrKVYTe7rWgKT7u39PjS
         iM7hpXy7Q5cW5n5/W/Z0ougeNvQ733W8vjUamqMyacZWMKKud6RkPud7bWAGastu+Cz2
         QFxmneiD1dKrf+LUgpnh/yftlg1cN9Moe2/y4XbXaW0ebzvzDyjIBw+CXNUF7A7JIxwr
         p9kbDhOLHEm68gaqVPi9Ep8NenLdWLyvmeajxqfP8P9D/jP7dJ9wZZHoC7+2VhWTqJr/
         MqszsEGkh5or35ILl0M2s/gIffXEIBqty4UjWnwdJX8sllJ3MjSNC3OfJNbLjFYMu9o4
         VhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791783; x=1699396583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKJeKTgSfVq2f+Wxak7/qIUn1AkHeqLUY0GoqdnouDQ=;
        b=DPmHul4c5vlS9aCRv6EfbuO8TZrO2cKKd87wGABjA7LVlWvvZ6KWj9cLxYMIDs4fZ0
         Zp6xe0zNwY7zDu3OP0IUtjEqwL56gcS+PEeH14XUuYFY6TCOSoYVYkgGRE0SNbuP1PiX
         QMz7OAHD6OiZqbNwmeA1qcjUUkQ5gzt5yYfAI5B+e+35HdXbfenbAnsskzAKgtZsu/0M
         8NJl3S4dqaeSmppgdZ1nbb3d6HW/Flb73zdT5autpK504Cb9F1h7KLn3XXhLd2DqXvTm
         8QQWhLwQdAEQqlDgTiHia3EbB/LY1a2kMV4WYMOePuy45vyL7XGlcpTia+4J/DSpa4Mc
         1Hjw==
X-Gm-Message-State: AOJu0YzpbwAcoh/XriV9qAVzyqV7yldxe6wOiaeZKUS0q3n+RqrjBtvR
	E2UowT988th7nZFAIi2NyINzjqsLqb9Rww==
X-Google-Smtp-Source: AGHT+IHpiUYDEX7EeOe73E8k12VDEk0ycmCBvzbG22nXo9nblHBBc8JuWbIcTB5oD45FYtf99zTMvA==
X-Received: by 2002:a17:903:2347:b0:1cc:4fe8:c6c6 with SMTP id c7-20020a170903234700b001cc4fe8c6c6mr5217374plh.6.1698791783286;
        Tue, 31 Oct 2023 15:36:23 -0700 (PDT)
Received: from surya.localdomain ([2600:1700:3ec2:2011:334e:7c9e:32dd:ce7a])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001cc41059a11sm66541plb.196.2023.10.31.15.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 15:36:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v2] selftests/bpf: fix test_bpffs
Date: Tue, 31 Oct 2023 15:36:06 -0700
Message-Id: <20231031223606.2927976-1-chantr4@gmail.com>
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

This change instead creates a "random" directory under /tmp and uses this
as TDIR.
If the directory already exists, ignore the error and keep moving on.

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

    $ vmtest -k $(make image_name) 'cd tools/testing/selftests/bpf && ./test_progs -vv -a test_bpffs'
    => bzImage
    ===> Booting
    ===> Setting up VM
    ===> Running command
    [    2.295696] bpf_testmod: loading out-of-tree module taints kernel.
    [    2.296468] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
    bpf_testmod.ko is already unloaded.
    Loading bpf_testmod.ko...
    Successfully loaded bpf_testmod.ko.
    test_test_bpffs:PASS:clone 0 nsec
    fn:PASS:unshare 0 nsec
    fn:PASS:mount / 0 nsec
    fn:PASS:mount tmpfs 0 nsec
    fn:PASS:mkdir /tmp/test_bpffs_testdir/fs1 0 nsec
    fn:PASS:mkdir /tmp/test_bpffs_testdir/fs2 0 nsec
    fn:PASS:mount bpffs /tmp/test_bpffs_testdir/fs1 0 nsec
    fn:PASS:mount bpffs /tmp/test_bpffs_testdir/fs2 0 nsec
    fn:PASS:reading /tmp/test_bpffs_testdir/fs1/maps.debug 0 nsec
    fn:PASS:reading /tmp/test_bpffs_testdir/fs2/progs.debug 0 nsec
    fn:PASS:creating /tmp/test_bpffs_testdir/fs1/a 0 nsec
    fn:PASS:creating /tmp/test_bpffs_testdir/fs1/a/1 0 nsec
    fn:PASS:creating /tmp/test_bpffs_testdir/fs1/b 0 nsec
    fn:PASS:create_map(ARRAY) 0 nsec
    fn:PASS:pin map 0 nsec
    fn:PASS:stat(/tmp/test_bpffs_testdir/fs1/a) 0 nsec
    fn:PASS:renameat2(/fs1/a, /fs1/b, RENAME_EXCHANGE) 0 nsec
    fn:PASS:stat(/tmp/test_bpffs_testdir/fs1/b) 0 nsec
    fn:PASS:b should have a's inode 0 nsec
    fn:PASS:access(/tmp/test_bpffs_testdir/fs1/b/1) 0 nsec
    fn:PASS:stat(/tmp/test_bpffs_testdir/fs1/map) 0 nsec
    fn:PASS:renameat2(/fs1/c, /fs1/b, RENAME_EXCHANGE) 0 nsec
    fn:PASS:stat(/tmp/test_bpffs_testdir/fs1/b) 0 nsec
    fn:PASS:b should have c's inode 0 nsec
    fn:PASS:access(/tmp/test_bpffs_testdir/fs1/c/1) 0 nsec
    fn:PASS:renameat2(RENAME_NOREPLACE) 0 nsec
    fn:PASS:access(/tmp/test_bpffs_testdir/fs1/b) 0 nsec
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

This is a follow-up of https://lore.kernel.org/bpf/20231024201852.1512720-1-chantr4@gmail.com/T/

v1 -> v2:
  - use a TDIR name that is related to test
  - use C-style comments

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/test_bpffs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index 214d9f4a94a5..ea933fd151c3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -8,7 +8,8 @@
 #include <sys/types.h>
 #include <test_progs.h>
 
-#define TDIR "/sys/kernel/debug"
+/* TDIR must be in a location we can create a directory in. */
+#define TDIR "/tmp/test_bpffs_testdir"
 
 static int read_iter(char *file)
 {
@@ -43,8 +44,11 @@ static int fn(void)
 	if (!ASSERT_OK(err, "mount /"))
 		goto out;
 
-	err = umount(TDIR);
-	if (!ASSERT_OK(err, "umount " TDIR))
+	err =  mkdir(TDIR, 0777);
+	/* If the directory already exists we can carry on. It may be left over
+	 * from a previous run.
+	 */
+	if ((err && errno != EEXIST) && !ASSERT_OK(err, "mkdir " TDIR))
 		goto out;
 
 	err = mount("none", TDIR, "tmpfs", 0, NULL);
@@ -138,6 +142,7 @@ static int fn(void)
 	rmdir(TDIR "/fs1");
 	rmdir(TDIR "/fs2");
 	umount(TDIR);
+	rmdir(TDIR);
 	exit(err);
 }
 
-- 
2.40.1


