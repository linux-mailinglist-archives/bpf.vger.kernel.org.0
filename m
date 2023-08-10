Return-Path: <bpf+bounces-7436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F49777299
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 10:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4491E2822EA
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8724E1E50C;
	Thu, 10 Aug 2023 08:13:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689EB1ADE8
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 08:13:52 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA28E56
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 01:13:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso442840a12.1
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 01:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691655231; x=1692260031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS6ue8t2dd5iDW6jb431VKpPx5tAdDiMNn4sU9SZ4eM=;
        b=KNJbzwTxxK3KzgAfGpr2FeHEj85XtDGujL07/8Dd3z3V3jSF8Rh+LYfOCIp5iXK0w7
         YcNv7ogCQvXKM3pEP24qCmrjpg/JDP9h1bPZJUTufYhvRvW+AfvjaCJjSAIiDVPy4YlB
         FvMnZgpH//K7t4jlj1KtZkT8Tjr1dVTBmA31ymCxgtTRo28F/xNhPrvKRxrHZK39ygQZ
         TPSiOnZgnkDk1zDo7yeScGo2f+KIT1WWFlda15vKkcDADn6i8rF0kiPkSV8N9pjikKK2
         NsnxwPD8zv745JOrycqHn98sjc4x3oYJA0Stmu2pcb6Xa6lTRk6/qVJaIsczS2Rfi1mM
         78hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655231; x=1692260031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS6ue8t2dd5iDW6jb431VKpPx5tAdDiMNn4sU9SZ4eM=;
        b=h+YwW7kWbilbrQ6P6L+D0nXgVcuc1PDIiQfGWnbp+K9t0fjWCvbw3LeMEc+uEqRl77
         wdjALWw/w4SFrKDvvLhZGnNRN171lPaTwpZEwoM4UQyee+l8xEB2vMzt39fzhJ/0D4IP
         Ni+IJ21pLXkowZ1fZerfeZ4CvxW6gHK9dSTx8brgG6MH7w0PqBnYBWupAfj/VB5y4P9i
         ET3tEPNXR0XdrWJaOMnAlUSm1Gh09LpdI1x/HeVb2ouQD32wAQVbujtEp+it0X5obkbv
         Q+TVskNYNJBzYXCnFf7w0DYO8dJDQAtUKMQjNh1AHo8cwclXVTRs2x7SkUyQMj+hxggk
         wlKg==
X-Gm-Message-State: AOJu0YzCEopx0HRbTt5jwgwAghkvriSOODWVFxJLUzRejHQoQaVT8PpB
	Rp1ygWEcVAl33gedDlGx/Dy3XA==
X-Google-Smtp-Source: AGHT+IHuFmD3Cyae7WIdtzmgxlWYjNuOj281DztPhX4TApif8F0U2Be9/d7VjjGRzVC64hKOa/1OAA==
X-Received: by 2002:a17:902:e548:b0:1ac:63ac:10a7 with SMTP id n8-20020a170902e54800b001ac63ac10a7mr1519133plf.68.1691655230885;
        Thu, 10 Aug 2023 01:13:50 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001b1a2c14a4asm1019036plg.38.2023.08.10.01.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:13:50 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	muchun.song@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com,
	robin.lu@bytedance.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH v2 5/5] bpf: Add a BPF OOM policy Doc
Date: Thu, 10 Aug 2023 16:13:19 +0800
Message-Id: <20230810081319.65668-6-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230810081319.65668-1-zhouchuyi@bytedance.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a new doc Documentation/bpf/oom.rst to describe how
BPF OOM policy is supposed to work.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 Documentation/bpf/oom.rst | 70 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/bpf/oom.rst

diff --git a/Documentation/bpf/oom.rst b/Documentation/bpf/oom.rst
new file mode 100644
index 000000000000..9bad1fd30d4a
--- /dev/null
+++ b/Documentation/bpf/oom.rst
@@ -0,0 +1,70 @@
+=============
+BPF OOM Policy
+=============
+
+The Out Of Memory Killer (aka OOM Killer) is invoked when the system is
+critically low on memory. The in-kernel implementation is to iterate over
+all tasks in the specific oom domain (all tasks for global and all members
+of memcg tree for hard limit oom) and select a victim based some heuristic
+policy to kill.
+
+Specifically:
+
+1. Begin to iterate tasks using ``oom_evaluate_task()`` and find a valid (killable)
+   victim in iteration N, select it.
+
+2. In iteration N + 1, N + 2..., we compare the current iteration task with the
+   previous selected task, if current is more suitable then select it.
+
+3. finally we get a victim to kill.
+
+However, this does not meet the needs of users in some special scenarios. Using
+the eBPF capabilities, We can implement customized OOM policies to meet needs.
+
+Developer API:
+==================
+
+bpf_oom_evaluate_task
+----------------------
+
+``bpf_oom_evaluate_task`` is a new interface hooking into ``oom_evaluate_task()``
+which is used to bypass the in-kernel selection logic. Users can customize their
+victim selection policy through BPF programs attached to it.
+::
+
+    int bpf_oom_evaluate_task(struct task_struct *task,
+                                struct oom_control *oc);
+
+return value::
+
+    NO_BPF_POLICY     no bpf policy and would fallback to the in-kernel selection
+    BPF_EVAL_ABORT    abort the selection (exit from current selection loop)
+    BPF_EVAL_NEXT     ignore the task
+    BPF_EAVL_SELECT   select the current task
+
+Suppose we want to select a victim based on the specified pid when OOM is
+invoked, we can use the following BPF program::
+
+    SEC("fmod_ret/bpf_oom_evaluate_task")
+    int BPF_PROG(bpf_oom_evaluate_task, struct task_struct *task, struct oom_control *oc)
+    {
+        if (task->pid == target_pid)
+            return BPF_EAVL_SELECT;
+        return BPF_EVAL_NEXT;
+    }
+
+bpf_set_policy_name
+---------------------
+
+``bpf_set_policy_name`` is a interface hooking before the start of victim selection. We can
+set policy's name in the attached program, so dump_header() can identify different policies
+when reporting messages. We can set policy's name through kfunc ``set_oom_policy_name``
+::
+
+    SEC("fentry/bpf_set_policy_name")
+    int BPF_PROG(set_police_name_k, struct oom_control *oc)
+    {
+	    char name[] = "my_policy";
+	    set_oom_policy_name(oc, name, sizeof(name));
+	    return 0;
+    }
\ No newline at end of file
-- 
2.20.1


