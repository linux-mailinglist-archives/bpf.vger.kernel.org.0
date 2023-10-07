Return-Path: <bpf+bounces-11621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E807BC810
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 16:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A051C209B6
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929912772D;
	Sat,  7 Oct 2023 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/YROvrl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895026E32
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 14:00:12 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98480BC
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 07:00:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso2361890b3a.0
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687202; x=1697292002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhv3VG9dJ365KYTBiiu8UfDv4XisyKaCg1gY3xuMN5s=;
        b=L/YROvrlQIrhrx3ojgGHn2zbnwBj/gViKcCXT7TFmym7IaXFTwiWunZo58X6qU1XCH
         Jq8q2btkQDIXf8R9Zg6FnVYqtlWIoJevlMn14Vb/Rqdhxk2PTmiQZhRMcWA92yu9lFjg
         s8qxcZDjUwbneDVP6I81HiY9WhCXon2bnxKTO0+tuaS+kNby4inPkrsBgANov6u5fpyA
         CHycwGv2OjuySvoMuFG8bORpprUhYlBss1zPs5StkqVJMVGqr4GomudNi8wHDP0YhE7D
         LUPVJK/6GhLIe88NSGkGb5qOdln4SGNcQ8vzFRL5luPvJ5SgzzSATY3+Y6BFbsnbiJWr
         Meqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687202; x=1697292002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhv3VG9dJ365KYTBiiu8UfDv4XisyKaCg1gY3xuMN5s=;
        b=XANFsLisbOL8nJi/eoSA5qCxVSTzQJu9YvYoKz+JpAtTw7zbDkM2deDR6J83qge2di
         4ikHe8VSWRGXHIr/MlR8ZPvcuIwFl4dBrXn1cijqEaOLOf7R/V5SYIRkfYaesQw6c6k8
         kwTtx1NXpHWexX+HOckQygo38o/QM/HQahkhcwz36qbNIfYGrb3Q3ACG0IwL6eFSHVnd
         irmuVZX8w4H2Uqnsfyw7l8vm2chX9yp95g5SbNosCTr3p//4peZ+/4LRPTxfPk0m1dKf
         4xKJL1EFd8oeQs1YL/OxwdRgz5eaIdYqWU4/yoqtd7QmHHUeZnth4ND6mE7TNTER3GG5
         0HLw==
X-Gm-Message-State: AOJu0YzD8rMEZYBzfJgoAw4BFUjtB+9bZrgss95wytAcNO3OG61W4tJZ
	UqXneHc2ZGEp8X9Bv2RPVSQ=
X-Google-Smtp-Source: AGHT+IG14ps+2CM6ZBmwVgvbMD0kOXTQX0SwBiwQop3gmHxKBSdbf993ITRO+DiqqDn+eBQ4tQFlrw==
X-Received: by 2002:a05:6a00:2d1e:b0:68f:bb16:d16a with SMTP id fa30-20020a056a002d1e00b0068fbb16d16amr13625770pfb.5.1696687201925;
        Sat, 07 Oct 2023 07:00:01 -0700 (PDT)
Received: from vultr.guest ([45.77.191.53])
        by smtp.gmail.com with ESMTPSA id i23-20020aa787d7000000b00682a908949bsm3302978pfo.92.2023.10.07.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:00:01 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add selftest for bpf_task_under_cgroup() in sleepable prog
Date: Sat,  7 Oct 2023 13:59:45 +0000
Message-Id: <20231007135945.4306-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231007135945.4306-1-laoar.shao@gmail.com>
References: <20231007135945.4306-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The result as follows,

  $ tools/testing/selftests/bpf/test_progs --name=task_under_cgroup
  #237     task_under_cgroup:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Without the prev patch, there will be RCU warnings in dmesg when
CONFIG_PROVE_RCU is enabled. While with prev patch, there will be no
warnings.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
---
 .../bpf/prog_tests/task_under_cgroup.c        | 11 ++++++--
 .../bpf/progs/test_task_under_cgroup.c        | 28 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)

---
v1 -> v2: Add comments on the attachment (Stanislav)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
index 4224727fb364..626d76fe43a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
@@ -30,8 +30,15 @@ void test_task_under_cgroup(void)
 	if (!ASSERT_OK(ret, "test_task_under_cgroup__load"))
 		goto cleanup;
 
-	ret = test_task_under_cgroup__attach(skel);
-	if (!ASSERT_OK(ret, "test_task_under_cgroup__attach"))
+	/* First, attach the LSM program, and then it will be triggered when the
+	 * TP_BTF program is attached.
+	 */
+	skel->links.lsm_run = bpf_program__attach_lsm(skel->progs.lsm_run);
+	if (!ASSERT_OK_PTR(skel->links.lsm_run, "attach_lsm"))
+		goto cleanup;
+
+	skel->links.tp_btf_run = bpf_program__attach_trace(skel->progs.tp_btf_run);
+	if (!ASSERT_OK_PTR(skel->links.tp_btf_run, "attach_tp_btf"))
 		goto cleanup;
 
 	pid = fork();
diff --git a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
index 56cdc0a553f0..7e750309ce27 100644
--- a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
@@ -18,7 +18,7 @@ const volatile __u64 cgid;
 int remote_pid;
 
 SEC("tp_btf/task_newtask")
-int BPF_PROG(handle__task_newtask, struct task_struct *task, u64 clone_flags)
+int BPF_PROG(tp_btf_run, struct task_struct *task, u64 clone_flags)
 {
 	struct cgroup *cgrp = NULL;
 	struct task_struct *acquired;
@@ -48,4 +48,30 @@ int BPF_PROG(handle__task_newtask, struct task_struct *task, u64 clone_flags)
 	return 0;
 }
 
+SEC("lsm.s/bpf")
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	struct cgroup *cgrp = NULL;
+	struct task_struct *task;
+	int ret = 0;
+
+	task = bpf_get_current_task_btf();
+	if (local_pid != task->pid)
+		return 0;
+
+	if (cmd != BPF_LINK_CREATE)
+		return 0;
+
+	/* 1 is the root cgroup */
+	cgrp = bpf_cgroup_from_id(1);
+	if (!cgrp)
+		goto out;
+	if (!bpf_task_under_cgroup(task, cgrp))
+		ret = -1;
+	bpf_cgroup_release(cgrp);
+
+out:
+	return ret;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.30.1 (Apple Git-130)


