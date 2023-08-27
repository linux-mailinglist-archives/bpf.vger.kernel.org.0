Return-Path: <bpf+bounces-8768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FF7789BC1
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 09:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0341C20926
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 07:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C24137A;
	Sun, 27 Aug 2023 07:21:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404341361
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 07:21:12 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDC7123
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 00:21:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf3a2f44ffso17768615ad.1
        for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 00:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693120870; x=1693725670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBwoJcGBnb1veA8KnUD3qT8I054w63hMR1j00YfM/x8=;
        b=BeWq9KckrnODaNNHCG1z2qbWpWBcfLgX3L/Qu1m7FTHWPA+7aJObjrZT73pVfo2VQ8
         PDvOBcCdDGGMGy/4d6NJxGWnu+YBTX1E0z1sl3g55fY0UN+PKURSmFn5mqWUkhsNojOk
         akXAIq2Jlhx+Isuab+SvAQsA1VU3vnDp6a6fdTdrlEXiec8bKgUAcJc7Kwr/EJujGRIe
         XUz/5cuve3mM8dEsFn9UvBIGOScMhyDqYU+uANsNnx0oZ7jp04gs/ycrTUW0btrbmCdD
         zKNLa7SWbPL7dinpaXVNCYfvltjTs/MngWa0W3rrVLzD61mObJp+9goc+D2VT2Y+mGeO
         9S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693120870; x=1693725670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBwoJcGBnb1veA8KnUD3qT8I054w63hMR1j00YfM/x8=;
        b=g2bEvrg5pPGbNBXzLByXIIbD0NOPOsOGDuR8hL6PMw+4hVQzqieLUAq6DVfeO9LWB9
         6BhZ7Nqg1cu10Nc1RFCtRFMRJnIYeGE2GmTS1fKIZGyh6SuZaKPmYYSpP5yDj/ZojatM
         haQp2g+OwI6fK2QtMcIc65o1PncZVHdx9Clknsd+edy69fRervM6g6LTnVvKmQ3Nn8ZN
         1jdxK0aE1TYnKwzHVj8mUwHZTiM0CimZC2FF+yJn0XMwh+RVv+Foa3ugK1ImK/xamwMI
         sdTWnrkipZ0pF7FpA0nI8UAWJI0XTCJSIPfzFIsaoPyszbAn5TPwfZyyZv3a4frjeOMv
         k2ig==
X-Gm-Message-State: AOJu0Ywe8LVduLWV5K2iqd0xD7CdmPbZ5JdK1mPFfwda+51lVRzqz5wq
	xf2HauOOxjisn+g1P9hiL8z0MhfeNq93LHUJChg=
X-Google-Smtp-Source: AGHT+IHiEPvFBXe3lELVZXbNjUVfpsIF2DxyqTE1VuJNCcAsiC8D9F7OTFyPQRkKAGq/03B8V+Sj7w==
X-Received: by 2002:a17:902:ced0:b0:1bb:97d0:c628 with SMTP id d16-20020a170902ced000b001bb97d0c628mr27739664plg.31.1693120870474;
        Sun, 27 Aug 2023 00:21:10 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709026bc300b001befac3b3cbsm4769723plt.290.2023.08.27.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 00:21:10 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH bpf-next 2/4] bpf: Introduce process open coded iterator kfuncs
Date: Sun, 27 Aug 2023 15:20:55 +0800
Message-Id: <20230827072057.1591929-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds kfuncs bpf_iter_process_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_process in open-coded iterator
style. BPF programs can use these kfuncs or through bpf_for_each macro to
iterate all processes in the system.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/uapi/linux/bpf.h       |  4 ++++
 kernel/bpf/helpers.c           |  3 +++
 kernel/bpf/task_iter.c         | 31 +++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 tools/lib/bpf/bpf_helpers.h    |  5 +++++
 5 files changed, 47 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2a6e9b99564b..cfbd527e3733 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7199,4 +7199,8 @@ struct bpf_iter_css_task {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_process {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cf113ad24837..81a2005edc26 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2458,6 +2458,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index b1bdba40b684..a6717a76c1e0 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -862,6 +862,37 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 	kfree(kit->css_it);
 }
 
+struct bpf_iter_process_kern {
+	struct task_struct *tsk;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)
+{
+	struct bpf_iter_process_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_process_kern) != sizeof(struct bpf_iter_process));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_process_kern) !=
+					__alignof__(struct bpf_iter_process));
+
+	rcu_read_lock();
+	kit->tsk = &init_task;
+	return 0;
+}
+
+__bpf_kfunc struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it)
+{
+	struct bpf_iter_process_kern *kit = (void *)it;
+
+	kit->tsk = next_task(kit->tsk);
+
+	return kit->tsk == &init_task ? NULL : kit->tsk;
+}
+
+__bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
+{
+	rcu_read_unlock();
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2a6e9b99564b..cfbd527e3733 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7199,4 +7199,8 @@ struct bpf_iter_css_task {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_process {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index f4d74b2aaddd..7d6a828d98b5 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -309,6 +309,11 @@ extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
 extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it) __weak __ksym;
 extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __weak __ksym;
 
+struct bpf_iter_process;
+extern int bpf_iter_process_new(struct bpf_iter_process *it) __weak __ksym;
+extern struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it) __weak __ksym;
+extern void bpf_iter_process_destroy(struct bpf_iter_process *it) __weak __ksym;
+
 #ifndef bpf_for_each
 /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
  * using BPF open-coded iterators without having to write mundane explicit
-- 
2.20.1


