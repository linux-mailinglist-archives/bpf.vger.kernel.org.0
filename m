Return-Path: <bpf+bounces-9153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E585790C75
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 16:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946EA280F6D
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975733FE3;
	Sun,  3 Sep 2023 14:28:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5D3D6A
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 14:28:16 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE32FA;
	Sun,  3 Sep 2023 07:28:13 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bf298ef1f5so615224a34.0;
        Sun, 03 Sep 2023 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693751292; x=1694356092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LgHnZQNGB4Eit9U3o8mixt+awQqbQlREXizLoHuW3w=;
        b=OpwgeB0rPVExtv+MYfamdJI2GM78Y3tsmCPhK/B2beO1FkvnHisykeZiZbPoHL3jGP
         gVRmGyjq0rD+PH0PNe79+4M2+Lh1U+edEEqgtl5JdifSV+bb+G3MsHp1Jpc4EW3zQszd
         fZGaJwO+kcufP73gJWHhARrytMEdqXWhlaNOTR+q8bf5Dy+ZVocpfiQ+8/gvUCaR0/UX
         uTx/YUrColnT2ZKTlNSBADWErptez0NiS9cI+SzczFo4CCppLjaFN6ptdrlAsbZL+/ZI
         cnRwBn8PFFHcv8CIdcBjA9WjW8Y+G5T6JHRsN11jqPcy5jPOY1eer5NQg2glrA9y3LPa
         kE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693751292; x=1694356092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LgHnZQNGB4Eit9U3o8mixt+awQqbQlREXizLoHuW3w=;
        b=e7RWE9UfQdByM75rUoig6qISPNdSHMympMHLkVOfq942KqbuXUHruUPLqVqwpwnHNf
         nB3NQPq/8Niw654zANy0lPh6oCk6QbnIv30+hZ8iZ/aDrRF9V0XcBDjK3ivK9Mjr3by/
         Vy8DN5SIrbB809pMJ6Kc5VieAraj4jqLH8lU30xcBuKYREQtR0+6gBC+xFCYEba2ZF+w
         dytfPVF566POgqBf4ssddbVjzX0Z/INLn8O7+JdI8A5viSQsgh+BTmRAvwiWW68zw2Zx
         3z+hhQ0ugI3b/IqxsnSXVtvjSZ4DoBJl9SlbaVSAZfop5coVePTaC9Nc3zPCyg2wBJjT
         t7Sg==
X-Gm-Message-State: AOJu0YwAkxAV/fYlsloQFTOVQ7X2FsIkKH6Je8S034mP3cRRJJDLM46n
	nkMp8xTTY28tFzuJqvxktJ0=
X-Google-Smtp-Source: AGHT+IF/4x1DTf3nTbnErroz86b5PDz7cTr8M1aC5V17cBJnzVBJJURcQ+gJ/IjztiHIiKd28XJBoA==
X-Received: by 2002:a05:6830:478c:b0:6bd:cf64:d105 with SMTP id df12-20020a056830478c00b006bdcf64d105mr8691478otb.12.1693751292265;
        Sun, 03 Sep 2023 07:28:12 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:185:5400:4ff:fe8f:9150])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78117000000b0065a1b05193asm5809977pfi.185.2023.09.03.07.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 07:28:11 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	yosryahmed@google.com
Cc: cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 3/5] selftests/bpf: Fix issues in setup_classid_environment()
Date: Sun,  3 Sep 2023 14:27:58 +0000
Message-Id: <20230903142800.3870-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230903142800.3870-1-laoar.shao@gmail.com>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If the net_cls subsystem is already mounted, attempting to mount it again
in setup_classid_environment() will result in a failure with the error code
EBUSY. Despite this, tmpfs will have been successfully mounted at
/sys/fs/cgroup/net_cls. Consequently, the /sys/fs/cgroup/net_cls directory
will be empty, causing subsequent setup operations to fail.

Here's an error log excerpt illustrating the issue when net_cls has already
been mounted at /sys/fs/cgroup/net_cls prior to running
setup_classid_environment():

- Before that change

  $ tools/testing/selftests/bpf/test_progs --name=cgroup_v1v2
  test_cgroup_v1v2:PASS:server_fd 0 nsec
  test_cgroup_v1v2:PASS:client_fd 0 nsec
  test_cgroup_v1v2:PASS:cgroup_fd 0 nsec
  test_cgroup_v1v2:PASS:server_fd 0 nsec
  run_test:PASS:skel_open 0 nsec
  run_test:PASS:prog_attach 0 nsec
  test_cgroup_v1v2:PASS:cgroup-v2-only 0 nsec
  (cgroup_helpers.c:248: errno: No such file or directory) Opening Cgroup Procs: /sys/fs/cgroup/net_cls/cgroup.procs
  (cgroup_helpers.c:540: errno: No such file or directory) Opening cgroup classid: /sys/fs/cgroup/net_cls/cgroup-test-work-dir/net_cls.classid
  run_test:PASS:skel_open 0 nsec
  run_test:PASS:prog_attach 0 nsec
  (cgroup_helpers.c:248: errno: No such file or directory) Opening Cgroup Procs: /sys/fs/cgroup/net_cls/cgroup-test-work-dir/cgroup.procs
  run_test:FAIL:join_classid unexpected error: 1 (errno 2)
  test_cgroup_v1v2:FAIL:cgroup-v1v2 unexpected error: -1 (errno 2)
  (cgroup_helpers.c:248: errno: No such file or directory) Opening Cgroup Procs: /sys/fs/cgroup/net_cls/cgroup.procs
  #44      cgroup_v1v2:FAIL
  Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

- After that change
  $ tools/testing/selftests/bpf/test_progs --name=cgroup_v1v2
  #44      cgroup_v1v2:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 2caee84..f68fbc6 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -499,10 +499,20 @@ int setup_classid_environment(void)
 		return 1;
 	}
 
-	if (mount("net_cls", NETCLS_MOUNT_PATH, "cgroup", 0, "net_cls") &&
-	    errno != EBUSY) {
-		log_err("mount cgroup net_cls");
-		return 1;
+	if (mount("net_cls", NETCLS_MOUNT_PATH, "cgroup", 0, "net_cls")) {
+		if (errno != EBUSY) {
+			log_err("mount cgroup net_cls");
+			return 1;
+		}
+
+		if (rmdir(NETCLS_MOUNT_PATH)) {
+			log_err("rmdir cgroup net_cls");
+			return 1;
+		}
+		if (umount(CGROUP_MOUNT_DFLT)) {
+			log_err("umount cgroup base");
+			return 1;
+		}
 	}
 
 	cleanup_classid_environment();
-- 
1.8.3.1


