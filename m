Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD412A49E0
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 16:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgKCPb6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 10:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgKCPbt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 10:31:49 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F26C0613D1
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 07:31:47 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n15so19058759wrq.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 07:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0J9cFdMwodzwzPZRAVHsYI+omBNNAcUfI4NxUctKcZ0=;
        b=mZpscWSbVbls/WTdqJl5EXm/R3hbHOV28FQzbyBoeRdkqaBRVQl/kLVoiRsWL6mkH2
         AVPKYsY8AgGsVC1frGQ4OQCDRdJiVg9XQnYyu/W/NkBE7Uz2SzsMYYt5YoEG4eJzua2J
         7qh+Gu8hk/doNS6ksGHK+hwJm6Cv/VX0huMBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0J9cFdMwodzwzPZRAVHsYI+omBNNAcUfI4NxUctKcZ0=;
        b=H7L76SI1yMaytqBGJGR0tlfjb8LIWkRmWHu3TJX0AHRrC44kX5NmYY/dbRQmy+VLEC
         vuE6luV5xRKhBB8oygCrqKNoxEMsipJEWhEFgT1BK++RdtxAJD0TAriN49nKYmMUo1x5
         vmwlxDXgobdgU1354x07d2EWOmbPhd9qShWq6oNTtW+TguyyhfYB8y7g9xFTeLyus+3F
         euGhD6H/j24UvzCTBH1oQ2FBLo/3fQ6Gbu2GB7Jfpisbo4R1wYVHI6cLi289KZo7Cka1
         aU75AvUFWSZfXUbTnNMlsEv9e0ZszSrY/JtD5k6V8E3KTaeN2yLTuJmZshM4TgDn29I8
         l2eg==
X-Gm-Message-State: AOAM530KzHaaCYfGKSHGQZdRBw3+AoaAkSlBhOS3rB926mQyhaIaX2QF
        0eU3i44Al/wlgdWjH2UOZ9yy5A==
X-Google-Smtp-Source: ABdhPJxKAslxxoO7fY8mXccwrgA5933KzmE/hZBqIY4TdTluNFY6nGPPc2Vwsjftvmr9GFSKs/sUEQ==
X-Received: by 2002:adf:ce91:: with SMTP id r17mr28043137wrn.326.1604417506081;
        Tue, 03 Nov 2020 07:31:46 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id m126sm2451966wmm.0.2020.11.03.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:31:45 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v2 8/8] bpf: Exercise syscall operations for inode and sk storage
Date:   Tue,  3 Nov 2020 16:31:32 +0100
Message-Id: <20201103153132.2717326-9-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103153132.2717326-1-kpsingh@chromium.org>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../bpf/prog_tests/test_local_storage.c          | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index feba23f8848b..2e64baabb50d 100644
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
@@ -197,9 +206,14 @@ void test_test_local_storage(void)
 	CHECK(skel->data->sk_storage_result != 0, "sk_storage_result",
 	      "sk_local_storage not set\n");
 
+	if (!check_syscall_operations(bpf_map__fd(skel->maps.sk_storage_map),
+				      serv_sk))
+		goto close_prog;
+
 	close(serv_sk);
 
 close_prog:
+	close(rm_fd);
 	close(task_fd);
 	local_storage__destroy(skel);
 }
-- 
2.29.1.341.ge80a0c044ae-goog

