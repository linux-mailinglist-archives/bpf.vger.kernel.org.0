Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09AF2A8A42
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 23:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgKEW6m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 17:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732509AbgKEW6l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 17:58:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A160FC0401C1
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 14:58:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so3147438wmg.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 14:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pm0NxoA/7Z6v/tkb4U6GU+e1eqN4wR4f0rR2Wx/opQk=;
        b=XvrVChY3HLu0cF1X2Yq8eJggFsDulo6GgswvD06X4r+9gZXTKDp5SDIWVoXAZcWISE
         l1flqo2T1PkPfnrR5U51gBmtbA0Gpw6vaEzAr6yzGSXbbaXwho/E9IpsBs5Xqchb18cp
         qlBcGtqxKoHrKdKMxWP7UPCDaTVTQICWjlqy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pm0NxoA/7Z6v/tkb4U6GU+e1eqN4wR4f0rR2Wx/opQk=;
        b=h/irUcspgvD9/UgSH3ZTJhxCNA6ZdPXncxPqPrHOu0a9ju4FLxqQjiJEkXJ2GGmUup
         JlVIEGcWj2Mw63wkESn/egFlfjf4I/yjUa6+h5aVD2PLKB49I4nDm1tYb/4fDVudUEwH
         jizEMaS/XPsFo3c5joK54zjYTvLho4AxkmbhOpfe4nV2lvCnDM4ouuMDDWy+eas7FrFS
         zHEmcrh7QT32OgjIhFHm1w4C/eSGFPpYxE7uHnKI7b26djTrWVZju8xjIao2vQrgIWu0
         TvTkys3AGzjec6m2LzWJmAQbpI/fMwPmgDkPPaA7vzxLcLDF6JxTt5CUHFMomY4YAHtB
         e/Ag==
X-Gm-Message-State: AOAM531p2ZLkhot0EqTrdZXSBV8FIROgvzUYPjkImy3Z7wBe0Mk8TyLf
        mN5C/TOpi2ogtc3s/ImA7UGyWA==
X-Google-Smtp-Source: ABdhPJzfs5kKthnPF4GGLkZmcmJcYu8Wj6Rdqhzd8k9EZz3hwJTF2o7jD1lZU5NxA/6boAT+XSvK5w==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr4891609wmg.81.1604617118393;
        Thu, 05 Nov 2020 14:58:38 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f19sm3977366wml.21.2020.11.05.14.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:58:37 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v5 9/9] bpf: Exercise syscall operations for inode and sk storage
Date:   Thu,  5 Nov 2020 22:58:27 +0000
Message-Id: <20201105225827.2619773-10-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105225827.2619773-1-kpsingh@chromium.org>
References: <20201105225827.2619773-1-kpsingh@chromium.org>
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

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../bpf/prog_tests/test_local_storage.c         | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index 5b4788b97d96..2c1b4e9c9a76 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -152,7 +152,7 @@ static bool check_syscall_operations(int map_fd, int obj_fd)
 void test_test_local_storage(void)
 {
 	char tmp_exec_path[PATH_MAX] = "/tmp/copy_of_rmXXXXXX";
-	int err, serv_sk = -1, task_fd = -1;
+	int err, serv_sk = -1, task_fd = -1, rm_fd = -1;
 	struct local_storage *skel = NULL;
 
 	skel = local_storage__open_and_load();
@@ -176,6 +176,15 @@ void test_test_local_storage(void)
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
@@ -204,11 +213,15 @@ void test_test_local_storage(void)
 	CHECK(skel->data->sk_storage_result != 0, "sk_storage_result",
 	      "sk_local_storage not set\n");
 
-	close(serv_sk);
+	if (!check_syscall_operations(bpf_map__fd(skel->maps.sk_storage_map),
+				      serv_sk))
+		goto close_prog;
 
 close_prog_unlink:
 	unlink(tmp_exec_path);
 close_prog:
+	close(serv_sk);
+	close(rm_fd);
 	close(task_fd);
 	local_storage__destroy(skel);
 }
-- 
2.29.1.341.ge80a0c044ae-goog

