Return-Path: <bpf+bounces-11909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BA57C5317
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 14:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A4E282DCE
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1751F16A;
	Wed, 11 Oct 2023 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NjZIAIq1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19251EA97
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 12:10:02 +0000 (UTC)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54B31B2
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 05:09:40 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3573dc94399so5651045ab.0
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697026168; x=1697630968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jb4XCkqj/mzqd+4TpsdA3MQ6n4XHCTZgLyR23iVy2IY=;
        b=NjZIAIq1ZljMAE8nAyTpgqx6BMlmgdjyUoD6YzslAGbNKcKwkmkKpFoeLLPz0H13iG
         wYnnldAvGm9134va8/1857CPIYCPnGbfH7kJxgyJDUUKueEnNbi/8bJF7WDiEXW6Nn5L
         p+vbEOd70b6zW8T72V7psSHO8oRZiCBnqwGoJTDyNs2eRhkDbxBdjmbYBE4DXBkuVleT
         GfF6PxLz08/6dmS7iEbPThlBqKwjH84qTud/9/ElysYPxt85Q/HQv4QCDd03MvWmHJQ7
         /3LyeBrrDobJOkmiydCmcSdoLbzenjbAzNqo2TaK+Z2HOoaCGMSFlMMvDYj4GqImyPpN
         fOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026168; x=1697630968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jb4XCkqj/mzqd+4TpsdA3MQ6n4XHCTZgLyR23iVy2IY=;
        b=g2YP19JbRjJEbmlZargEQtZpRNABgoXB0SyQAI/GLp4Wyvvs/fR+IPwRFDno264Euu
         xeAGhPBkKK6IW/CHZt1OFapnWUVeC/DlR/D97vcXj2bH7WEj+hNoSE4VrGAI3VqA2EN8
         AjNldnzwJbU4AtpsWu3zomq2vICXHDHghFj92kusZl2h1MEnhFPUxaARtIJbj72WLC6A
         dn+SxwwdXVr26QxoH8avxFvi//U/bu6G42qcZ/Do4P+JIMP85A+qNS5CO+40PcAxFfHC
         o5S4ftAaXk8NjXsRWl2nH+FFQuoVNyD/0EPyGhT61jZ9MWG7xJg8pQ9nTmCahTjU/cMP
         11Ag==
X-Gm-Message-State: AOJu0Yz7udOWERxVMSqNpyHZviPbdYv14yoZtsSG/LFMVvNUkkG9g29D
	ZXfSdtXAhpAacbx+ADNS0FKGBTFUj4EJvopX+dE=
X-Google-Smtp-Source: AGHT+IFn1UGmN9LEFhWMABBgAL/4r/CP0V4oYXeE14IAWaUfM6NBBfN6IBTbip8JBs09CUWuKs95eQ==
X-Received: by 2002:a05:6e02:1a4b:b0:352:6251:2364 with SMTP id u11-20020a056e021a4b00b0035262512364mr25805078ilv.11.1697026168227;
        Wed, 11 Oct 2023 05:09:28 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id u13-20020a62ed0d000000b006930db1e6cfsm9962769pfh.62.2023.10.11.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:27 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v5 4/8] bpf: Introduce css open-coded iterator kfuncs
Date: Wed, 11 Oct 2023 20:08:53 +0800
Message-Id: <20231011120857.251943-5-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231011120857.251943-1-zhouchuyi@bytedance.com>
References: <20231011120857.251943-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This Patch adds kfuncs bpf_iter_css_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_css in open-coded iterator
style. These kfuncs actually wrapps css_next_descendant_{pre, post}.
css_iter can be used to:

1) iterating a sepcific cgroup tree with pre/post/up order

2) iterating cgroup_subsystem in BPF Prog, like
for_each_mem_cgroup_tree/cpuset_for_each_descendant_pre in kernel.

The API design is consistent with cgroup_iter. bpf_iter_css_new accepts
parameters defining iteration order and starting css. Here we also reuse
BPF_CGROUP_ITER_DESCENDANTS_PRE, BPF_CGROUP_ITER_DESCENDANTS_POST,
BPF_CGROUP_ITER_ANCESTORS_UP enums.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/bpf/cgroup_iter.c                      | 59 +++++++++++++++++++
 kernel/bpf/helpers.c                          |  3 +
 .../testing/selftests/bpf/bpf_experimental.h  |  6 ++
 3 files changed, 68 insertions(+)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 810378f04fbc..df2d6b6a5dd8 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -294,3 +294,62 @@ static int __init bpf_cgroup_iter_init(void)
 }
 
 late_initcall(bpf_cgroup_iter_init);
+
+struct bpf_iter_css {
+	__u64 __opaque[3];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_css_kern {
+	struct cgroup_subsys_state *start;
+	struct cgroup_subsys_state *pos;
+	unsigned int flags;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
+		struct cgroup_subsys_state *start, unsigned int flags)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) > sizeof(struct bpf_iter_css));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css));
+
+	kit->start = NULL;
+	switch (flags) {
+	case BPF_CGROUP_ITER_DESCENDANTS_PRE:
+	case BPF_CGROUP_ITER_DESCENDANTS_POST:
+	case BPF_CGROUP_ITER_ANCESTORS_UP:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	kit->start = start;
+	kit->pos = NULL;
+	kit->flags = flags;
+	return 0;
+}
+
+__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it)
+{
+	struct bpf_iter_css_kern *kit = (void *)it;
+
+	if (!kit->start)
+		return NULL;
+
+	switch (kit->flags) {
+	case BPF_CGROUP_ITER_DESCENDANTS_PRE:
+		kit->pos = css_next_descendant_pre(kit->pos, kit->start);
+		break;
+	case BPF_CGROUP_ITER_DESCENDANTS_POST:
+		kit->pos = css_next_descendant_post(kit->pos, kit->start);
+		break;
+	case BPF_CGROUP_ITER_ANCESTORS_UP:
+		kit->pos = kit->pos ? kit->pos->parent : kit->start;
+	}
+
+	return kit->pos;
+}
+
+__bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css *it)
+{
+}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 690763751f6e..6330e37ca8d5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2558,6 +2558,9 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 1ec82997cce7..9aab609f6edd 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -463,4 +463,10 @@ extern int bpf_iter_task_new(struct bpf_iter_task *it,
 extern struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it) __weak __ksym;
 extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksym;
 
+struct bpf_iter_css;
+extern int bpf_iter_css_new(struct bpf_iter_css *it,
+				struct cgroup_subsys_state *start, unsigned int flags) __weak __ksym;
+extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
+extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
+
 #endif
-- 
2.20.1


