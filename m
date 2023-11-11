Return-Path: <bpf+bounces-14867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2A7E89F7
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 10:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFF72810F9
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9C711731;
	Sat, 11 Nov 2023 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNSsUD+8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D56111B5
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 09:00:44 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D963C3C
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:43 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5b31c5143a0so32903727b3.3
        for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699693242; x=1700298042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBmbTwV/SCzHF6Ex+v7R9Tm3nCh0Ha6QemKh6sWeBKo=;
        b=GNSsUD+8y5Ij0zEId5g9iBLpGul5Pa1upSU4JAHn4JN0072rbzbbrHDtSGthPJOGRb
         Xba/iLT5PprBWe6eaflIVx0ZsIpFibpYukJA9fGLcX2n1IXTYCFL6aG++JuiFvHbfSKS
         aDUCwMueFuWB4HG8tKfB1H63CGHW6t5TYQGLvJhr23dqqxbMRHJf84JeEKWQilky4QSg
         wCNX3inj8bSbVVvUKsgOvWoPK2N5xbUJThD8ii4740ANyd1TeQqxylKGf92gcXaNcKJq
         ccC5Jqy+QJ9Et55aqhPvpCxIRuGsbQgDfi7tyLe3uIoFsQ/RZVAV3OdxeQbZAZvXRu6+
         X9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699693242; x=1700298042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBmbTwV/SCzHF6Ex+v7R9Tm3nCh0Ha6QemKh6sWeBKo=;
        b=ZR6NU18R3hCicwePPwuu29b3tn6ha3yuL4b2liAjX8f2gLXzDXpFKdvbZfaM9Mns1N
         16kjnUezAddAq3TjPyFuUzxzI8cTBkz8TUedbdR4Vu2kdr8M9/0slp2gKsNLCqSYOMTO
         YAkL3tWc0PR8H1WpIPDOb5LWdJRfcCVtY/ckPU/kqT429COvdMsvu89UN0X3W66YNAMY
         MRmpoSgxSyp68CMMBSKEzpxz0cryrO9QCO85xd/L0iQmPmrSrulQo0uyc+QoZ6AlEjo4
         Q6xeH/yWX9fgniIpG28IjLpWuQz6+shlkfPJSg8EVIbA00grIs34aWO/AhMb55+fheGO
         gPyw==
X-Gm-Message-State: AOJu0YyAnUW/ist3ayeUSjZidRrprdXs45su9h0GEPIDfOMJDs3Mopb8
	bR7RjHRxRI3DpX9PIEK5sJ8=
X-Google-Smtp-Source: AGHT+IG08s68EDdDYI6htBuuqqqdTTCFxBv/BYwzF853586zZBB04If1msd420TRWFnbsXpiiD2u4A==
X-Received: by 2002:a81:54d6:0:b0:589:f9f0:2e8c with SMTP id i205-20020a8154d6000000b00589f9f02e8cmr1712469ywb.48.1699693242159;
        Sat, 11 Nov 2023 01:00:42 -0800 (PST)
Received: from vultr.guest ([45.63.84.83])
        by smtp.gmail.com with ESMTPSA id fh38-20020a056a00392600b006b2e07a6235sm894254pfb.136.2023.11.11.01.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:00:41 -0800 (PST)
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
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 2/6] selftests/bpf: Fix issues in setup_classid_environment()
Date: Sat, 11 Nov 2023 09:00:30 +0000
Message-Id: <20231111090034.4248-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231111090034.4248-1-laoar.shao@gmail.com>
References: <20231111090034.4248-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 5b1da2a..10b5f42 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -523,10 +523,20 @@ int setup_classid_environment(void)
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


