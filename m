Return-Path: <bpf+bounces-8769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906AC789BC3
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 09:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510A7280FD6
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 07:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C4A1FA6;
	Sun, 27 Aug 2023 07:21:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550217E4
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 07:21:16 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC29712A
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 00:21:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdbbede5d4so17959085ad.2
        for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 00:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693120874; x=1693725674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aaba14g0pYwSo+C1GRPKvs5a7tFEGv787StoXtTJ820=;
        b=JwVbln6N5wR5/SkAR4HytFsak9tIqVeQnyIIlX5+rht8o2CZ9ArLClTIB8PiC9IsFc
         McY+zXbts1fQ4YlKjmgkVwMznw+jaHyLo1tPnqd0gqNqtca+NN5Rxu7vbMsGZhv7RLU8
         kfQ70FIBr0eeu0n3G2iYVdMxdedqx/DGMHzkZQHuTOj4vPipKdA4dbjCfFQl3DbJc9pU
         emxbxeVWpLLA04yIW6BD8boa1+H/ZnFTTm814e2gc5R0CovgFNJ8UpxJvPKf78AKgKM5
         XQ9hlAXT37NRxQPHe2TPRG6SXmskGf9LbkYfJDcc4ldEWnm64hrmF0XS32qoNtHbvKgC
         EQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693120874; x=1693725674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aaba14g0pYwSo+C1GRPKvs5a7tFEGv787StoXtTJ820=;
        b=QazCTPELybEX7hVBooamYmkMqMDkTj+hXIWVRwmZlZdzz/p1LYGXCXRWExWunkbgeo
         RiNiYSTr5uptMGshePg2eKWFVLVk7BjQ2aH+nJmbkhB47YdHnoLU3hz0O0dLEQiXi4AY
         Cwx2rGK411AcU00sT0rZsMSxiyKy/JzKJRCJKE5sSHhGHRghWdPg6AcxyyhEhPEhnZeL
         U/G7ggcxf7EDjK5WkkuBq0RZmFYWLYX9c88jrYwwnDvXSjjqfty5FNqjJ/jrpHOjrecX
         UjnB25bZMus4zIm57+c9uqpjDOmIrM2pR34rHS0PXEA6bf9uM5nclBf733d6s8yaZe3H
         uUUg==
X-Gm-Message-State: AOJu0YxTK+MS/n1p+HWlq4S0ZB04Jvd2EYpHHTS29sMiviBszJiHHGYK
	YJRHkSxHDDFy/hm3JEYSdgtRvqibLnN0qk9qvvA=
X-Google-Smtp-Source: AGHT+IES0aZIVeC31/U5wz+SDgtdO6clWH2gS+rxwgpQr0NFr3Q721xrDf7OcxpufCUAkp3hGCZ4Og==
X-Received: by 2002:a17:902:f54b:b0:1b8:92fc:7429 with SMTP id h11-20020a170902f54b00b001b892fc7429mr27897781plf.53.1693120873965;
        Sun, 27 Aug 2023 00:21:13 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709026bc300b001befac3b3cbsm4769723plt.290.2023.08.27.00.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 00:21:13 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH bpf-next 3/4] bpf: Introduce css_descendant open-coded iterator kfuncs
Date: Sun, 27 Aug 2023 15:20:56 +0800
Message-Id: <20230827072057.1591929-4-zhouchuyi@bytedance.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This Patch adds kfuncs bpf_iter_css_{new,next,destroy} which allow creation
and manipulation of struct bpf_iter_css in open-coded iterator style. These
kfuncs actually wrapps css_next_descendant_{pre, post}. BPF programs can
use these kfuncs through bpf_for_each macro for iteration of all descendant
css under a root css.

Normally, css_next_descendant_{pre, post} should be called with rcu
locking. Although we have bpf_rcu_read_lock(), here we still calls
rcu_read_lock in bpf_iter_css_new and unlock in bpf_iter_css_destroy
for convenience use.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/helpers.c           |  3 +++
 kernel/bpf/task_iter.c         | 39 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 tools/lib/bpf/bpf_helpers.h    |  6 ++++++
 5 files changed, 58 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index cfbd527e3733..19f1f1bf9301 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7203,4 +7203,9 @@ struct bpf_iter_process {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_css {
+	__u64 __opaque[2];
+	char __opaque_c[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 81a2005edc26..47d46a51855f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2461,6 +2461,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index a6717a76c1e0..ef9aef62f1ac 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -893,6 +893,45 @@ __bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
 	rcu_read_unlock();
 }
 
+struct bpf_iter_css_kern {
+	struct cgroup_subsys_state *root;
+	struct cgroup_subsys_state *pos;
+	char flag;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
+		struct cgroup_subsys_state *root, char flag)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css));
+	kit->root = root;
+	kit->pos = NULL;
+	kit->flag = flag;
+	rcu_read_lock();
+	return 0;
+}
+
+__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	if (!kit->pos)
+		kit->pos = kit->flag ? css_next_descendant_post(NULL, kit->root)
+					: css_next_descendant_pre(NULL, kit->root);
+	else
+		kit->pos = kit->flag ? css_next_descendant_post(kit->pos, kit->root)
+					: css_next_descendant_pre(kit->pos, kit->root);
+
+	return kit->pos;
+}
+
+__bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css *it)
+{
+	rcu_read_unlock();
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index cfbd527e3733..19f1f1bf9301 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7203,4 +7203,9 @@ struct bpf_iter_process {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_css {
+	__u64 __opaque[2];
+	char __opaque_c[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 7d6a828d98b5..bb56295b1442 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -314,6 +314,12 @@ extern int bpf_iter_process_new(struct bpf_iter_process *it) __weak __ksym;
 extern struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it) __weak __ksym;
 extern void bpf_iter_process_destroy(struct bpf_iter_process *it) __weak __ksym;
 
+struct bpf_iter_css;
+extern int bpf_iter_css_new(struct bpf_iter_css *it,
+		struct cgroup_subsys_state *root, char flag) __weak __ksym;
+extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
+extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
+
 #ifndef bpf_for_each
 /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
  * using BPF open-coded iterators without having to write mundane explicit
-- 
2.20.1


