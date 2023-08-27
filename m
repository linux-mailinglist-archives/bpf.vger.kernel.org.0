Return-Path: <bpf+bounces-8767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6171C789BC0
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 09:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D60A1C20926
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA0110F3;
	Sun, 27 Aug 2023 07:21:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDABED4
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 07:21:09 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDEA12F
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 00:21:07 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf1935f6c2so14826625ad.1
        for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 00:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693120867; x=1693725667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzhP0acP8pgCXiXgIT5pVDiQStW31xdVy7iDR4WyW0I=;
        b=M9uriV0oDBou+phHxwXSY1DpUBh3pU1M/amkzlMTqxk9KoPkdJKhVfH3Rn1tQehoiQ
         bS8Y6ukSay/A9Ig3ySf4VRCNbrDtYgH+rcSaMsijUIWxUDsoC2JYZlU31EOz1IQIs3jo
         gJUTIO3q9S036zcZO7czp/RhlSHXeT7gL03yOZhrgQ3DU/kso1Ho5Caujr+JI7tFLHYB
         vF/JHYfX84frp/fDHZMmJUUdlO3FLYP9w0hATmfbDw+KH78Mu6QwlprSaZh91UQ124Xp
         1gCtbNxv1x+wCrd4y8ZHWHDZqwlp26qNCJgtylgkP/7wTwQZwUqX9HiGjjeAeOhZLIGe
         fWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693120867; x=1693725667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzhP0acP8pgCXiXgIT5pVDiQStW31xdVy7iDR4WyW0I=;
        b=EJitfh2Nzz94h8MxNX4vhL7emotMHzSEXlJFccrxgdeEJQt7DB+or/0rHWAN4yrlBy
         PzomGKUDci60G3+9o8q2kSKm9KQVTIlzn/51Z9PS8iimZBWe96jqhxne6J4cs+gfOm/G
         Z0j4ZchxVK6lL7mCSzDkX3x892RrGX2MIGWBpP/ugZ/9m7NWhooD6ykFik9jWxpbxrWZ
         2X3YQq1RK8K5N4O033cqxcykCttDF0lD4N8xbY7RTSEaKv4xALL89I8V65bJgVKV+9bw
         aBV1BzRlhjTMeO0E0xhhzwCMpJAt/Ni/5QunY9wKTnn9cah8RLOZ+o+TgcVT7qNn/BTH
         oWow==
X-Gm-Message-State: AOJu0YzaJOqofRi0u/9/B875BEu89PujinsvxaKd8JONx9/6xIFaxKYT
	uKLDh+R/+Db66Jb/z1AYioEu/bf1+Zkc/MdnQ0s=
X-Google-Smtp-Source: AGHT+IGabF3YBXqt6mcOkwn094X/QhnZ4R6HHN1HhEJhKSefItAGmzR4qpXEmdGvbs71ifeR+ZMagw==
X-Received: by 2002:a17:902:ecc4:b0:1c0:cbaf:6954 with SMTP id a4-20020a170902ecc400b001c0cbaf6954mr13191830plh.25.1693120867032;
        Sun, 27 Aug 2023 00:21:07 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709026bc300b001befac3b3cbsm4769723plt.290.2023.08.27.00.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 00:21:06 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH bpf-next 1/4] bpf: Introduce css_task open-coded iterator kfuncs
Date: Sun, 27 Aug 2023 15:20:54 +0800
Message-Id: <20230827072057.1591929-2-zhouchuyi@bytedance.com>
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

This Patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_css_task in open-coded
iterator style. These kfuncs actually wrapps
css_task_iter_{start,next,end}. BPF programs can use these kfuncs through
bpf_for_each macro for iteration of all tasks under a css.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/uapi/linux/bpf.h       |  4 ++++
 kernel/bpf/helpers.c           |  3 +++
 kernel/bpf/task_iter.c         | 39 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 ++++
 tools/lib/bpf/bpf_helpers.h    |  7 ++++++
 5 files changed, 57 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..2a6e9b99564b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7195,4 +7195,8 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_css_task {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9e80efa59a5d..cf113ad24837 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2455,6 +2455,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c4ab9d6cdbe9..b1bdba40b684 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -823,6 +823,45 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+struct bpf_iter_css_task_kern {
+	struct css_task_iter *css_it;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
+		struct cgroup_subsys_state *css, unsigned int flags)
+{
+	struct bpf_iter_css_task_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) != sizeof(struct bpf_iter_css_task));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=
+					__alignof__(struct bpf_iter_css_task));
+
+	kit->css_it = kzalloc(sizeof(struct css_task_iter), GFP_KERNEL);
+	if (!kit->css_it)
+		return -ENOMEM;
+	css_task_iter_start(css, flags, kit->css_it);
+	return 0;
+}
+
+__bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it)
+{
+	struct bpf_iter_css_task_kern *kit = (void *)it;
+
+	if (!kit->css_it)
+		return NULL;
+	return css_task_iter_next(kit->css_it);
+}
+
+__bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
+{
+	struct bpf_iter_css_task_kern *kit = (void *)it;
+
+	if (!kit->css_it)
+		return;
+	css_task_iter_end(kit->css_it);
+	kfree(kit->css_it);
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..2a6e9b99564b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7195,4 +7195,8 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_css_task {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index bbab9ad9dc5a..f4d74b2aaddd 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -302,6 +302,13 @@ extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak
 extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
 extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
 
+struct bpf_iter_css_task;
+struct cgroup_subsys_state;
+extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
+		struct cgroup_subsys_state *css, unsigned int flags) __weak __ksym;
+extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it) __weak __ksym;
+extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __weak __ksym;
+
 #ifndef bpf_for_each
 /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
  * using BPF open-coded iterators without having to write mundane explicit
-- 
2.20.1


