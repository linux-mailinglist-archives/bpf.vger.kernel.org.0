Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0392A6A25
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 17:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgKDQpR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 11:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbgKDQpI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 11:45:08 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E68C061A4A
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 08:45:08 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id w13so17199550eju.13
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 08:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thk0dsFzxKUTJg2wIhday9Zx1B4NcEyIkuylRVdGgcw=;
        b=NGLM86TG3ew60zP6WbLEJY7uGdhXZ9lUSsMDVB7el2JvmIyX9hqobGAp3SaRzQ2N4l
         MYOTav4soBanSqatdv/UMbxfN5DZRTCC/aMozzOcdVEo9h5ZTjCVL2pU5WUzK7M1oIN9
         grVF5LN92QrwA0GbJa33y7ImE8bAsBKLxU1CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thk0dsFzxKUTJg2wIhday9Zx1B4NcEyIkuylRVdGgcw=;
        b=nbDamDwo5KQ2/PIpgsF5P14edgAZapEI7I/Q8pQqc1k4SxsXIAebXOMPqzp34W+0Ke
         hQqPUt73ZpQ8ntT8loK+gf+QLXNb2x6HlRXdlJh0L3ZsbeLeEQTOInXtV85GNgF7GdXX
         h1Vy/VmYE+SJi40VZcvzzfzp6MJi9uesBJM4FG7n7awhialrWr4J/v2X20AVNHdqTHRD
         kvcWfaKinCeasK0sMydLOAcLCThi2xNpEM3Y1xe7xg92X0RNv0bGYeDZuSnayhrlyqYW
         gtCcUFfRn5611Y7itEm3IH7oG+Eg45NxFUcakR4bkarKg31ivoALc6Edz/rMVz9DLll6
         6Odg==
X-Gm-Message-State: AOAM530hq1bXEQZ8FLzQxkyF4KWEt5fZRiv1/bC6+OWE1Kbis2SFQt8i
        QddZsyLW2ewD/xWi9mNtUWbWdyFl/EjSvmN0
X-Google-Smtp-Source: ABdhPJxFbVmZEmH1aQ4Y7bnw5PfXhhXQjkeU50nmpu9mwvltAGMH1dqAapFxHNJVy5h3/USnN1pzZg==
X-Received: by 2002:a17:906:c186:: with SMTP id g6mr24580689ejz.465.1604508307179;
        Wed, 04 Nov 2020 08:45:07 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id g20sm1283551ejz.88.2020.11.04.08.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:45:06 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v3 9/9] bpf: Exercise syscall operations for inode and sk storage
Date:   Wed,  4 Nov 2020 17:44:53 +0100
Message-Id: <20201104164453.74390-10-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201104164453.74390-1-kpsingh@chromium.org>
References: <20201104164453.74390-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Use the check_syscall_operations added for task_local_storage to
exercise syscall operations for other local storage maps:

* Check the absence of an element for the given fd.
* Create a new element, retrieve and compare its value.
* Delete the element and check again for absence.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../bpf/prog_tests/test_local_storage.c         | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index feba23f8848b..48c9237f1314 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -145,7 +145,7 @@ bool check_syscall_operations(int map_fd, int obj_fd)
 void test_test_local_storage(void)
 {
 	char tmp_exec_path[PATH_MAX] = "/tmp/copy_of_rmXXXXXX";
-	int err, serv_sk = -1, task_fd = -1;
+	int err, serv_sk = -1, task_fd = -1, rm_fd = -1;
 	struct local_storage *skel = NULL;
 
 	skel = local_storage__open_and_load();
@@ -169,6 +169,15 @@ void test_test_local_storage(void)
 	if (CHECK(err < 0, "copy_rm", "err %d errno %d\n", err, errno))
 		goto close_prog;
 
+	rm_fd = open(tmp_exec_path, O_RDONLY);
+	if (CHECK(rm_fd < 0, "open", "failed to open %s err:%d, errno:%d",
+		  tmp_exec_path, rm_fd, errno))
+		goto close_prog;
+
+	if (!check_syscall_operations(bpf_map__fd(skel->maps.inode_storage_map),
+				      rm_fd))
+		goto close_prog;
+
 	/* Sets skel->bss->monitored_pid to the pid of the forked child
 	 * forks a child process that executes tmp_exec_path and tries to
 	 * unlink its executable. This operation should be denied by the loaded
@@ -197,9 +206,13 @@ void test_test_local_storage(void)
 	CHECK(skel->data->sk_storage_result != 0, "sk_storage_result",
 	      "sk_local_storage not set\n");
 
-	close(serv_sk);
+	if (!check_syscall_operations(bpf_map__fd(skel->maps.sk_storage_map),
+				      serv_sk))
+		goto close_prog;
 
 close_prog:
+	close(serv_sk);
+	close(rm_fd);
 	close(task_fd);
 	local_storage__destroy(skel);
 }
-- 
2.29.1.341.ge80a0c044ae-goog

