Return-Path: <bpf+bounces-12511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848D37CD422
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64EC1C20A0C
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 06:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72306947E;
	Wed, 18 Oct 2023 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GCUuEqUP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EAE8F69
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 06:18:22 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D549910CC
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:18:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9b7c234a7so55863405ad.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697609884; x=1698214684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pA+uWgAid8oSLs2nLYNpXTwEjADAAqZra1pWMMUUeE=;
        b=GCUuEqUPkuFXUrlH4jF65SsMpb0CT2u0W9yNLIkpXbxsj8hcMmcE+sgk+AT6VzYt24
         wEd+1xAzig/a5u1Ah5HAF02eTqp090xRPCm2jvrDlMCt6H7s5h3a3SLdwOrIsOiY7PYK
         OsLOaiHdPhZqwXANd0BvSJISlwyefwCYKgBH215KN9Tbcv/V6gALShr30Jcg6rw/ayII
         fcYE2S/u1kx7XF7QdZyDVgQLQesPOVof5fufpZ3pRNDHNWHMMrcSYvixVvf/bufXgK7p
         zJ1woFrIc3OXdKRm+dwsS2CIOKCIbLhMKtqcjPMx93xIi4HIckOKGwD1oFdSbgUOZC/p
         2n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609884; x=1698214684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pA+uWgAid8oSLs2nLYNpXTwEjADAAqZra1pWMMUUeE=;
        b=Qt1NmTURxIMlHo56Qwna1W0LuM+o+v9yveQYHumHqIWYgpIzg7wAGZmsIksqelP4uH
         SuPPuxL4Hv+A+302UtCVmFQU1TCQrqBIptKR3zOWAudAtcorK2QfwMKcfjmepSGYS4w3
         Cwm6PWHKR32tn5lRGjcvXmi+NuIhn7R8TFjt2LMRyOwObo+tfsNi6tkHsR4hlT/EiS4c
         nEt6Fhe5+G9yd3J4iXkP5Y8LCAp3Na6Jr4s0zN01+iuxHxQnpJYTZiCIPgQFgM8044+o
         c44Ct5gzJjXimgI6QVroTUkRJa6SPDBg8V6IfbM6Zz8m1862Z/qiIrYZ1sgKiSjgm8ya
         02/g==
X-Gm-Message-State: AOJu0YxtmMN0P2tp7YmNxxBuVm2X+jV9tWGwzzNHZJHqoIiHQH1xGlrc
	XCc1OfZvfOv5UOwMn6XDjn3tOobc3DxL5QdSDEis1A==
X-Google-Smtp-Source: AGHT+IEu1cwdY+inclpKJZuJOmUeLfwpoRGRDI+l1Fg/xmqZVRdAq+jqmv38u/FUxQWYqTqljbUnhQ==
X-Received: by 2002:a17:903:110c:b0:1c5:ec97:1718 with SMTP id n12-20020a170903110c00b001c5ec971718mr4519753plh.6.1697609883879;
        Tue, 17 Oct 2023 23:18:03 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001c61acd5bd2sm2659116plb.112.2023.10.17.23.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:18:03 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RESEND PATCH bpf-next v6 3/8] bpf: Introduce task open coded iterator kfuncs
Date: Wed, 18 Oct 2023 14:17:41 +0800
Message-Id: <20231018061746.111364-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231018061746.111364-1-zhouchuyi@bytedance.com>
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds kfuncs bpf_iter_task_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_task in open-coded iterator
style. BPF programs can use these kfuncs or through bpf_for_each macro to
iterate all processes in the system.

The API design keep consistent with SEC("iter/task"). bpf_iter_task_new()
accepts a specific task and iterating type which allows:

1. iterating all process in the system (BPF_TASK_ITER_ALL_PROCS)

2. iterating all threads in the system (BPF_TASK_ITER_ALL_THREADS)

3. iterating all threads of a specific task (BPF_TASK_ITER_PROC_THREADS)

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/bpf/helpers.c                          |  3 +
 kernel/bpf/task_iter.c                        | 90 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  5 ++
 3 files changed, 98 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c01441db9fd5..c25941531265 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2563,6 +2563,9 @@ BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index e4126698cecf..faa1712c1df5 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -952,6 +952,96 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 
 __diag_pop();
 
+struct bpf_iter_task {
+	__u64 __opaque[3];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_task_kern {
+	struct task_struct *task;
+	struct task_struct *pos;
+	unsigned int flags;
+} __attribute__((aligned(8)));
+
+enum {
+	/* all process in the system */
+	BPF_TASK_ITER_ALL_PROCS,
+	/* all threads in the system */
+	BPF_TASK_ITER_ALL_THREADS,
+	/* all threads of a specific process */
+	BPF_TASK_ITER_PROC_THREADS
+};
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
+		struct task_struct *task, unsigned int flags)
+{
+	struct bpf_iter_task_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) > sizeof(struct bpf_iter_task));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
+					__alignof__(struct bpf_iter_task));
+
+	kit->task = kit->pos = NULL;
+	switch (flags) {
+	case BPF_TASK_ITER_ALL_THREADS:
+	case BPF_TASK_ITER_ALL_PROCS:
+	case BPF_TASK_ITER_PROC_THREADS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (flags == BPF_TASK_ITER_PROC_THREADS)
+		kit->task = task;
+	else
+		kit->task = &init_task;
+	kit->pos = kit->task;
+	kit->flags = flags;
+	return 0;
+}
+
+__bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it)
+{
+	struct bpf_iter_task_kern *kit = (void *)it;
+	struct task_struct *pos;
+	unsigned int flags;
+
+	flags = kit->flags;
+	pos = kit->pos;
+
+	if (!pos)
+		return pos;
+
+	if (flags == BPF_TASK_ITER_ALL_PROCS)
+		goto get_next_task;
+
+	kit->pos = next_thread(kit->pos);
+	if (kit->pos == kit->task) {
+		if (flags == BPF_TASK_ITER_PROC_THREADS) {
+			kit->pos = NULL;
+			return pos;
+		}
+	} else
+		return pos;
+
+get_next_task:
+	kit->pos = next_task(kit->pos);
+	kit->task = kit->pos;
+	if (kit->pos == &init_task)
+		kit->pos = NULL;
+
+	return pos;
+}
+
+__bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
+{
+}
+
+__diag_pop();
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 6792ed2b45d7..2f6c747aa874 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -465,5 +465,10 @@ extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
 extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it) __weak __ksym;
 extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __weak __ksym;
 
+struct bpf_iter_task;
+extern int bpf_iter_task_new(struct bpf_iter_task *it,
+		struct task_struct *task, unsigned int flags) __weak __ksym;
+extern struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it) __weak __ksym;
+extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksym;
 
 #endif
-- 
2.20.1


