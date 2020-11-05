Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD62D2A814C
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 15:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgKEOsg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 09:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731224AbgKEOsJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 09:48:09 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2CAC0613D3
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 06:48:08 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id p93so1810144edd.7
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 06:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thk0dsFzxKUTJg2wIhday9Zx1B4NcEyIkuylRVdGgcw=;
        b=mK8LPgsfU7pBW2+UtesbOjkC/o8MfPPj0OTDi4YFrfDTHA0mM04qLm8yDLB/7kFtVM
         UClt9fUS6v0DBErj60Sf32Qd1dabwlEaAVKwt/Y9zi5EqNPOcNAK9KYUdJWsF/YMnvf4
         L5oeGc8bLMRluh9jMkpKL9/KYPEWCd+yn8ocI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thk0dsFzxKUTJg2wIhday9Zx1B4NcEyIkuylRVdGgcw=;
        b=OjFz+Exb7SxQzw+4yyaWeOmjrx5megMcxO3YsOhqAicL3WdYjjMII76I9tJ4WY2s7x
         a5UNpi2Z9ydBcmDZK1wq/Y1SDk3mk/rsQthk+AMx622LyTiYW46lkjcO9zwkiimuYAPS
         PyvW/A3AiE+3NZyYe4G2JOjkOU2Zho3owQ3QCU+WY9gNAPhWpSJrEg06sw/VIGE6U6MZ
         Eo7Bcqs77clvX6SPij0o7XqTPk3rwwHeAijHCHp/roL6UjCcsVasfrzFO/LgS58jiqgJ
         HZLrthfIhFagaOy9WEYwRG45pqtJ70oiXPxjobvilxuSfuQ89bWqfvS8teU7QJj3X/Jn
         5ppw==
X-Gm-Message-State: AOAM5320uM4QVRU4o/ZsQqpjR4V6tQKOleLixQtSiWoctDkDOX7D8BU0
        S/4kCoZdUd0fo1ysUZIG6i3lGg==
X-Google-Smtp-Source: ABdhPJxtLmEG0hUXF5rLYezSvWArmVsTJgwlggBdtGo7FYC0skKdnvFjEG/D+U33u0aibTxF8yIV7Q==
X-Received: by 2002:aa7:c7cf:: with SMTP id o15mr2762427eds.15.1604587687570;
        Thu, 05 Nov 2020 06:48:07 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id z13sm1075870ejp.30.2020.11.05.06.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:48:06 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v4 9/9] bpf: Exercise syscall operations for inode and sk storage
Date:   Thu,  5 Nov 2020 15:47:55 +0100
Message-Id: <20201105144755.214341-10-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105144755.214341-1-kpsingh@chromium.org>
References: <20201105144755.214341-1-kpsingh@chromium.org>
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

