Return-Path: <bpf+bounces-11432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4BA7B9BD9
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 10:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C46DE281ECF
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC996FDB;
	Thu,  5 Oct 2023 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt09mLUB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8FD63BC
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 08:40:00 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38283900C
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 01:39:59 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c4e38483d2so490079a34.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696495198; x=1697099998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rav7UA9fjYcLMW/Ce8u1TcInhyTckMjufqi9PA0YJLQ=;
        b=bt09mLUBa9aNN1Jt5mAZq/lSmIs6xxla1Y5Hrrv9xwpCd8+IKCS153HI2bf9UykDkv
         Cwl4YAoT33zFNZDrNGtomp9Hi6sfJaNnrrVdF+JWKESvWPa3vGzNPQ/KELawe0SrL3qz
         TTONDasEhrMqAJQiz/WFG9MrcV6SFXJ+D4oir73rQ9wylf6TgZ5tH3TCsM6i7GKAqXq6
         eXw9SGfIV/zU0WhJSFEtt+LTWjZ4ZE4FUCXhBBr+iq9pSQ0ET+HhiybLCc+ahOL7hLhI
         B/uYlysWQ2PY+wV5OlM2c4DG1X5PhF7uXM8VSeQFbBRgCq9H0A88WnRbGwuVEdxZm+H6
         hNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696495198; x=1697099998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rav7UA9fjYcLMW/Ce8u1TcInhyTckMjufqi9PA0YJLQ=;
        b=GfuL/ulcZ774PSCOKYosRvzNgS0qjwfyVIXzTAM7x8M3rtDEqfmw/SkoLbcVq7sztQ
         v34tXY7r05QzopsHGimQRnprg7ThhT6BDDmv7k3V9ho6EHQOsEq1sndR8Um/1I30iTs6
         I8CVpXbNUVTAL2YrLAqlGIut9YXh54sPbKdXJwA02uSf9NGuaY41D6FrQScQOQctFQQt
         U7lkn7dHMUXGGn2ioFbYoMqYzyyMkHk71e8s17E8ICY4vk/ktNsOlsbnVTBjQi4dDKlg
         EZZVQY43CP2Qck8Ag1XYZmHa8GxTkqO0yG2AEatBGaaMPD6y6DGcZsC7cicHn0Tv4mCm
         0hyA==
X-Gm-Message-State: AOJu0Yxz53V4OAHq+4DMa+fFESLh/mrikXb8pHsAj712CcdcXLVkyoJV
	e6dqtq6hkqbyxoAaNu/FAKm6NWhY4OupX9mHwaU=
X-Google-Smtp-Source: AGHT+IHM2AKHSMhaxq3uTynhZj+XWPrQV3awCk0KBwCnwl0pBxUMh/XFYaengKw0YlAS1QBKg0UGzQ==
X-Received: by 2002:a9d:7d98:0:b0:6bc:de95:a639 with SMTP id j24-20020a9d7d98000000b006bcde95a639mr4835530otn.16.1696495198357;
        Thu, 05 Oct 2023 01:39:58 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac00:4fd4:5400:4ff:fe99:6afd])
        by smtp.gmail.com with ESMTPSA id n20-20020a638f14000000b00563e1ef0491sm924755pgd.8.2023.10.05.01.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:39:57 -0700 (PDT)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for sleepable bpf_task_under_cgroup()
Date: Thu,  5 Oct 2023 08:39:53 +0000
Message-Id: <20231005083953.1281-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231005083953.1281-1-laoar.shao@gmail.com>
References: <20231005083953.1281-1-laoar.shao@gmail.com>
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

The result as follows,

  $ tools/testing/selftests/bpf/test_progs --name=task_under_cgroup
  #237     task_under_cgroup:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

And no error messages in dmesg.

Without the prev patch, there will be RCU warnings in dmesg.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/task_under_cgroup.c   |  8 +++++--
 .../selftests/bpf/progs/test_task_under_cgroup.c   | 28 +++++++++++++++++++++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
index 4224727..d1a5a5c 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
@@ -30,8 +30,12 @@ void test_task_under_cgroup(void)
 	if (!ASSERT_OK(ret, "test_task_under_cgroup__load"))
 		goto cleanup;
 
-	ret = test_task_under_cgroup__attach(skel);
-	if (!ASSERT_OK(ret, "test_task_under_cgroup__attach"))
+	skel->links.lsm_run = bpf_program__attach_lsm(skel->progs.lsm_run);
+	if (!ASSERT_OK_PTR(skel->links.lsm_run, "attach_lsm"))
+		goto cleanup;
+
+	skel->links.tp_btf_run = bpf_program__attach_trace(skel->progs.tp_btf_run);
+	if (!ASSERT_OK_PTR(skel->links.tp_btf_run, "attach_tp_btf"))
 		goto cleanup;
 
 	pid = fork();
diff --git a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
index 56cdc0a..7e750309 100644
--- a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
@@ -18,7 +18,7 @@
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
1.8.3.1


