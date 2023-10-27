Return-Path: <bpf+bounces-13520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37297DA35F
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 00:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555E8282464
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C705405EA;
	Fri, 27 Oct 2023 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5vJCqoG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82FE405EE
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 22:30:29 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80DF1A5
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 15:30:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc30bf9e22so1627925ad.1
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698445826; x=1699050626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9QSM+KtYdpcWHcpyYiN1cxwRoWwN7ybZxmiv2SQhxc=;
        b=E5vJCqoGjIlSKO9zC0/wcxQjh+vvB1vcoNeqlLOPtuI+stkS578ShRQkOC7byZ/ZCY
         eeR+WKFHstyyFq8WuBqPmchmXrfyNr59nVqGEAyHId1e+WREk4WFvk9dNsqGaMPvUvAl
         aJhg3c/9J8z9mfI5WC+DOORH6VE6KlR25thv7f90uBWICQ1/5H3DFJl3hN45ldNM6sYh
         7V8T5BtOVXUZhCq5hYvx0YuFoxH3wE0WfSgLaOeBvoG51WQ5jX0zqqwzQsCeUc1+avKC
         zQte3qiV/o6nv2K01xyqYG8Pk/jGmgtdM54Bw8buhEaCv6+YeCldC6XPFEywDJitfrHs
         tjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698445826; x=1699050626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9QSM+KtYdpcWHcpyYiN1cxwRoWwN7ybZxmiv2SQhxc=;
        b=deVPu3TaDDLRMWu7syJIyKUTfDnXrxUPtW5wv+nQ1jzjypkya6WM8L1uJ9fcyl+JtG
         PqBXlz8g28jGfyv0o5/I6QBNdb+F4ygEDDxWQj0bx5fS2Pdy9RtXtJKeJCXCjkFzL0g+
         KaapZu+c72B+MxLeWSXba44Z9+AfU+4dJbdsuENT37xDRW41j6I76lfESup+lGvYgHWR
         lPLxEX3fiYnV6Qr/0eYllDQoev9E0whyWbFIjdR8LRE017r4bpEzB5rGkKnH3+SnKsj3
         bvAAhT0LDeBbobCbCOj8N90n63Hnn3VxgZReUqhd+NX/oAArybJjgjoAdmgEQOUEsVwW
         sJ+g==
X-Gm-Message-State: AOJu0YyZGlcLJ7Or4XXVAWtHrK7dMai2jLIS2xSQ5zsXRJAYgUOOp5z5
	Pyd+MldGUrbuBU5VyeSHzm9xUegYmQZfBw==
X-Google-Smtp-Source: AGHT+IEv0tELnOmwjEDdAFEhNY+gN5rbDIRN2vb5LcgmaTYR+cQ+TIO0K6zFqyksUlzEHOIZwPmpCQ==
X-Received: by 2002:a17:902:d2cf:b0:1c7:49dd:2ff with SMTP id n15-20020a170902d2cf00b001c749dd02ffmr4769256plc.27.1698445825752;
        Fri, 27 Oct 2023 15:30:25 -0700 (PDT)
Received: from surya.localdomain ([2600:1700:3ec2:2011:3ef3:bbdb:b46b:4676])
        by smtp.gmail.com with ESMTPSA id g17-20020a170902869100b001bf11cf2e21sm2035357plo.210.2023.10.27.15.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 15:30:25 -0700 (PDT)
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
Subject: [PATCH bpf-next] selftests/bpf: fix test_bpffs
Date: Fri, 27 Oct 2023 15:30:06 -0700
Message-Id: <20231027223006.2062967-1-chantr4@gmail.com>
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

    $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -a test_bpffs"
    => bzImage
    ===> Booting
    ===> Setting up VM
    ===> Running command
    [    2.119236] bpf_testmod: loading out-of-tree module taints kernel.
    [    2.121768] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
    bpf_testmod.ko is already unloaded.
    Loading bpf_testmod.ko...
    Successfully loaded bpf_testmod.ko.
    test_test_bpffs:PASS:clone 0 nsec
    fn:PASS:unshare 0 nsec
    fn:PASS:mount / 0 nsec
    fn:PASS:mount tmpfs 0 nsec
    fn:PASS:mkdir /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1 0 nsec
    fn:PASS:mkdir /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs2 0 nsec
    fn:PASS:mount bpffs /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1 0 nsec
    fn:PASS:mount bpffs /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs2 0 nsec
    fn:PASS:reading /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/maps.debug 0 nsec
    fn:PASS:reading /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs2/progs.debug 0 nsec
    fn:PASS:creating /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/a 0 nsec
    fn:PASS:creating /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/a/1 0 nsec
    fn:PASS:creating /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b 0 nsec
    fn:PASS:create_map(ARRAY) 0 nsec
    fn:PASS:pin map 0 nsec
    fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/a) 0 nsec
    fn:PASS:renameat2(/fs1/a, /fs1/b, RENAME_EXCHANGE) 0 nsec
    fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b) 0 nsec
    fn:PASS:b should have a's inode 0 nsec
    fn:PASS:access(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b/1) 0 nsec
    fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/map) 0 nsec
    fn:PASS:renameat2(/fs1/c, /fs1/b, RENAME_EXCHANGE) 0 nsec
    fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b) 0 nsec
    fn:PASS:b should have c's inode 0 nsec
    fn:PASS:access(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/c/1) 0 nsec
    fn:PASS:renameat2(RENAME_NOREPLACE) 0 nsec
    fn:PASS:access(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b) 0 nsec
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

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/test_bpffs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index 214d9f4a94a5..80a1afb9589d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -8,7 +8,8 @@
 #include <sys/types.h>
 #include <test_progs.h>
 
-#define TDIR "/sys/kernel/debug"
+// TDIR must be in a location we can create a directory in.
+#define TDIR "/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed"
 
 static int read_iter(char *file)
 {
@@ -43,8 +44,10 @@ static int fn(void)
 	if (!ASSERT_OK(err, "mount /"))
 		goto out;
 
-	err = umount(TDIR);
-	if (!ASSERT_OK(err, "umount " TDIR))
+	err =  mkdir(TDIR, 0777);
+	// If the directory already exists we can carry on. It may be left over
+	// from a previous run.
+	if ((err && errno != EEXIST) && !ASSERT_OK(err, "mkdir " TDIR))
 		goto out;
 
 	err = mount("none", TDIR, "tmpfs", 0, NULL);
@@ -138,6 +141,7 @@ static int fn(void)
 	rmdir(TDIR "/fs1");
 	rmdir(TDIR "/fs2");
 	umount(TDIR);
+	rmdir(TDIR);
 	exit(err);
 }
 
-- 
2.40.1


