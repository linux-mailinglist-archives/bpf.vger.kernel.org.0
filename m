Return-Path: <bpf+bounces-14866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353237E89F6
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 10:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDB728101D
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B311701;
	Sat, 11 Nov 2023 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A32t6Ujt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C510A2C
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 09:00:43 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D3449A
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:41 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5afabb23900so33538267b3.2
        for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699693241; x=1700298041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VR3534gf3VMvfyE894V2U8c9aqRybvtkoSlpZl8bWs=;
        b=A32t6UjtTy+Xq3dgVveifLFvIowbBG/ogy9OZ22jSoZL4k+BHFoYT/rAIcWkFIKZd6
         ItQFx0uYPUjH89mJKLNgUxWEPy6esARzVcWfnHYrx8jSGOB4S0ad1F/6OS5vPJw0k7DD
         g6BXePnmxnDdPkYtjCeGWJQTdE4PMYa6z3TKKjv8NGJWcPE8BKCa+zah/ys7hs0roO94
         xo4FsjiaBrXrOHyXNnxvxKigOv6NAmM48PyV/c1dM5UNvmEdsH+1LJfygCqmkHdkpNxY
         fcvbjZc0ME9nYnAhx/5dgSfoYgd/49F828SqKVNqmJWgBrK1Bscl6EFACr5RIbZBeYj8
         AQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699693241; x=1700298041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VR3534gf3VMvfyE894V2U8c9aqRybvtkoSlpZl8bWs=;
        b=Li9KBgY3aCWrn6lu0Uomj3ezwBp+ExAKr4NEPHuZiV8ZKMcnp7UqGNnb7MQy3aO64Z
         a2gsbcwMFSps3rN/k3BYV6YN9topV80Wr6LRdmg9SIKbFY9iYgigF1FV9S0s/JQF5WB4
         /A3kgXGXH1CbffCjI6dmEgZXBIILLZUxRb6npsgYljE2C/IHazswATJ2LYcdYMSY8/SP
         /D1cLj6WWie1TqhJV89++lQVkfCLqwTOYHsxhWwE+/hkY5ZoQsw32jr0935hnfxj764j
         w14eJMypKkD0KX/lfGd34wyYWhV5Gnsl4qYFTB/0FW+SKpBF9DzFFlVsJv56bmZ+MIEv
         OoaQ==
X-Gm-Message-State: AOJu0YyEYRC6B1MR1Z6Ld5URTffwG/LbLa+SRWvoNZypaC7rMVBWUA4L
	8sehCTxRygX+kQnGMIJg/kjFVG65X7jH0R2LoTI=
X-Google-Smtp-Source: AGHT+IGU4FQSNQn7G9YQzBwN2mKWYWRUqrOd9HfxawMRPE9YE//veGtU8SoKbK/mwhvF9alxEBZk+A==
X-Received: by 2002:a25:aa2c:0:b0:d9c:aa17:2ae3 with SMTP id s41-20020a25aa2c000000b00d9caa172ae3mr1315239ybi.64.1699693240784;
        Sat, 11 Nov 2023 01:00:40 -0800 (PST)
Received: from vultr.guest ([45.63.84.83])
        by smtp.gmail.com with ESMTPSA id fh38-20020a056a00392600b006b2e07a6235sm894254pfb.136.2023.11.11.01.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:00:40 -0800 (PST)
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
Subject: [PATCH v4 bpf-next 1/6] bpf: Add a new kfunc for cgroup1 hierarchy
Date: Sat, 11 Nov 2023 09:00:29 +0000
Message-Id: <20231111090034.4248-2-laoar.shao@gmail.com>
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

A new kfunc is added to acquire cgroup1 of a task:

- bpf_task_get_cgroup1
  Acquires the associated cgroup of a task whithin a specific cgroup1
  hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.

This new kfunc enables the tracing of tasks within a designated
container or cgroup directory in BPF programs.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 03517db..b45a838 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2228,6 +2228,25 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
 	rcu_read_unlock();
 	return ret;
 }
+
+/**
+ * bpf_task_get_cgroup1 - Acquires the associated cgroup of a task within a
+ * specific cgroup1 hierarchy. The cgroup1 hierarchy is identified by its
+ * hierarchy ID.
+ * @task: The target task
+ * @hierarchy_id: The ID of a cgroup1 hierarchy
+ *
+ * On success, the cgroup is returen. On failure, NULL is returned.
+ */
+__bpf_kfunc struct cgroup *
+bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
+{
+	struct cgroup *cgrp = task_get_cgroup1(task, hierarchy_id);
+
+	if (IS_ERR(cgrp))
+		return NULL;
+	return cgrp;
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2534,6 +2553,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
+BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
-- 
1.8.3.1


