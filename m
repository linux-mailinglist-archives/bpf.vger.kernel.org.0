Return-Path: <bpf+bounces-17427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6724480D4F2
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 19:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C3B281947
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289224F21C;
	Mon, 11 Dec 2023 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3tI2yVk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184399
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 10:08:01 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b86f3cdca0so3565858b6e.3
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 10:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702318080; x=1702922880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl4hQ8sZnel/XgyNC/UtzuQFBcmD7EfKF724BgShtfc=;
        b=h3tI2yVkD7hilLMxDOe2z10u0TZoh9dEaIH/0W7nEs79NYmUdraoT4K4gKCgP4eYt7
         Q7dIxJHzpx6ZwTpkVqNHJ7JgIS944yQg7/R3UVuzKwtggNkA0Zh4YDfE3JJ6X6ikhxh0
         8ahzzgA971eDSXO1J76w2sXsffbf2XioXoGxDX3bcYnFKjMqLyNQDENFnhmMGBLi/d9k
         B+ti/MxzzKVTX/Iqqx+erBi2WJB4Eq7ilUKcU0o2ZAMh6FihaBxzHMYS/VO8mWsnEqj9
         GQ0i1+c+17bHDeMo/hV8lT23X6lVXazszrc0iUvugIBeZDS6doKdp6++Ak1HRFWcKrhC
         3LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702318080; x=1702922880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl4hQ8sZnel/XgyNC/UtzuQFBcmD7EfKF724BgShtfc=;
        b=iBU20Q5SRBlUYMaELZFz8LTL4KKAQgBQVg/0dBMqieUbZEKVC0MFBE7QBVXk0mY5Ax
         XZ7DAGGrpJrpEnsmw0FF9JvpARULU8uae8sFjb0hjQcJtIYozLO2CeMLgwnsvpOYQb/7
         e00u1h/RGgQSy73lKYUVZ4LIJa6RbXv4JfUrKm/D7brspD+gZMQ6EbG/soZncGDunXj2
         LJYnW9CNzY6jBdYL0RWkRRynspHLxXs5Td2cMp5dU4CUz7sMmevwc2SY/K7BGclOTKRp
         IKaEa5yqlib3barBzoQPxFexNMfFaOgjVTVnIQ778nRj3ENx8V8+Fj0HgDCVK12tfRnq
         dlCw==
X-Gm-Message-State: AOJu0Yy9XHlWuzO8UHXBbFX0DrngpyFb5Et6ciESpaiudSBkZaxcJG25
	cX6QVK5bY9TlWKRq16hmrZVSDpuWMwTztg==
X-Google-Smtp-Source: AGHT+IHi5CL0pzzwc0ydV9GbYXWB07foNTtXpdCkNuO77eP6JM58q7Tj4HeOkiH86PigZakaKnBCvg==
X-Received: by 2002:a05:6870:b522:b0:1f9:f527:8880 with SMTP id v34-20020a056870b52200b001f9f5278880mr5826978oap.43.1702318080087;
        Mon, 11 Dec 2023 10:08:00 -0800 (PST)
Received: from localhost (fwdproxy-vll-120.fbsv.net. [2a03:2880:12ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id xa14-20020a0568707f0e00b001faff1908d3sm2567729oab.53.2023.12.11.10.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:07:59 -0800 (PST)
From: Manu Bretelle <chantr4@gmail.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH bpf-next ] selftests/bpf: Fixes tests for filesystem kfuncs
Date: Mon, 11 Dec 2023 10:07:33 -0800
Message-Id: <20231211180733.763025-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`fs_kfuncs.c`'s `test_xattr` would fail the test even when the
filesystem did not support xattr, for instance when /tmp is mounted as
tmpfs.

This change checks errno when setxattr fail. If the failure is due to
the operation being unsupported, we will skip the test (just like we
would if verity was not enabled on the FS.

Before the change, fs_kfuncs test would fail in test_axattr:

 $ vmtest -k $(make -s image_name) './tools/testing/selftests/bpf/test_progs -a fs_kfuncs'
 => bzImage
 ===> Booting
 [    0.000000] rcu:        RCU restricting CPUs from NR_CPUS=128 to
 nr_cpu_
 ===> Setting up VM
 ===> Running command
 [    4.157491] bpf_testmod: loading out-of-tree module taints kernel.
 [    4.161515] bpf_testmod: module verification failed: signature and/or
 required key missing - tainting kernel
 test_xattr:PASS:create_file 0 nsec
 test_xattr:FAIL:setxattr unexpected error: -1 (errno 95)
 #90/1    fs_kfuncs/xattr:FAIL
 #90/2    fs_kfuncs/fsverity:SKIP
 #90      fs_kfuncs:FAIL

 All error logs:
 test_xattr:PASS:create_file 0 nsec
 test_xattr:FAIL:setxattr unexpected error: -1 (errno 95)
 #90/1    fs_kfuncs/xattr:FAIL
 #90      fs_kfuncs:FAIL

 Summary: 0/0 PASSED, 1 SKIPPED, 1 FAILED

Test plan:

  $ touch tmpfs_file && truncate -s 1G tmpfs_file && mkfs.ext4 tmpfs_file
  # /tmp mounted as tmpfs
  $ vmtest -k $(make -s image_name) './tools/testing/selftests/bpf/test_progs -a fs_kfuncs'
  => bzImage
  ===> Booting
  ===> Setting up VM
  ===> Running command
  WARNING! Selftests relying on bpf_testmod.ko will be skipped.
  Can't find bpf_testmod.ko kernel module: -2
  #90/1    fs_kfuncs/xattr:SKIP
  #90/2    fs_kfuncs/fsverity:SKIP
  #90      fs_kfuncs:SKIP
  Summary: 1/0 PASSED, 2 SKIPPED, 0 FAILED
  # /tmp mounted as ext4 with xattr enabled but not verity
  $ vmtest -k $(make -s image_name) 'mount -o loop tmpfs_file /tmp && \
    /tools/testing/selftests/bpf/test_progs -a fs_kfuncs'
  => bzImage
  ===> Booting
  ===> Setting up VM
  ===> Running command
  [    4.067071] loop0: detected capacity change from 0 to 2097152
  [    4.191882] EXT4-fs (loop0): mounted filesystem
  407ffa36-4553-4c8c-8c78-134443630f69 r/w with ordered data mode. Quota
  mode: none.
  WARNING! Selftests relying on bpf_testmod.ko will be skipped.
  Can't find bpf_testmod.ko kernel module: -2
  #90/1    fs_kfuncs/xattr:OK
  #90/2    fs_kfuncs/fsverity:SKIP
  #90      fs_kfuncs:OK (SKIP: 1/2)
  Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED
  $ tune2fs -O verity tmpfs_file
  # /tmp as ext4 with both xattr and verity enabled
  $ vmtest -k $(make -s image_name) 'mount -o loop tmpfs_file /tmp && \
    ./tools/testing/selftests/bpf/test_progs -a fs_kfuncs'
  => bzImage
  ===> Booting
  ===> Setting up VM
  ===> Running command
  [    4.291434] loop0: detected capacity change from 0 to 2097152
  [    4.460828] EXT4-fs (loop0): recovery complete
  [    4.468631] EXT4-fs (loop0): mounted filesystem
  7b4a7b7f-c442-4b06-9ede-254e63cceb52 r/w with ordered data mode. Quota
  mode: none.
  [    4.988074] fs-verity: sha256 using implementation "sha256-generic"
  WARNING! Selftests relying on bpf_testmod.ko will be skipped.
  Can't find bpf_testmod.ko kernel module: -2
  #90/1    fs_kfuncs/xattr:OK
  #90/2    fs_kfuncs/fsverity:OK
  #90      fs_kfuncs:OK
  Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Fixes: 341f06fdddf7 ("selftests/bpf: Add tests for filesystem kfuncs")
Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index d3196a4b089f..37056ba73847 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -25,6 +25,14 @@ static void test_xattr(void)
 	fd = -1;
 
 	err = setxattr(testfile, "user.kfuncs", "hello", sizeof("hello"), 0);
+	if (err && errno == EOPNOTSUPP) {
+		printf("%s:SKIP:local fs doesn't support xattr (%d)\n"
+		       "To run this test, make sure /tmp filesystem supports xattr.\n",
+		       __func__, errno);
+		test__skip();
+		goto out;
+	}
+
 	if (!ASSERT_OK(err, "setxattr"))
 		goto out;
 
-- 
2.39.3


