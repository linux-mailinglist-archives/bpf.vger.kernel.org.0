Return-Path: <bpf+bounces-12505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A067CD3C7
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3BF2814D7
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 06:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAB58F61;
	Wed, 18 Oct 2023 06:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bAuwMM04"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8528F59
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 06:03:36 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4382F9
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:03:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6934202b8bdso5612152b3a.1
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697609014; x=1698213814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNW2oYGtelVvgczyk2A13Ij/ocoUNYFTCyV6b+P6gh8=;
        b=bAuwMM04S+xXGF2mph5y8RlqZdBfuL+ajSBfC8QXGjoeoJLWhuDh9nA+BdUrXXdLWW
         rAcCpcs/Es1uO8VE3XLTgYaTkbQjVIEV9jUb7FbiWZw7IQFuWX4KPZshS/VpkfuxGY95
         gG+7EPKiLPEgzcEEtBy0H+VoRbAHW+VPthYHyGF2s1f0FyHjGshSkGdg98/x2qOIMNX3
         KzKzI0rP+BpU16oX2RhLPKA7HZ8oP3OY22w/9SvTGbbI+UBlJ4soHBifGHe1CQu6RrRg
         R3vJ9t8sdS0Zt4Wy4xat/oxRzcwuGr+5ANeSo+Tbq7RprU/9rGDHYL09ypIrKBbbatUI
         jiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609014; x=1698213814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNW2oYGtelVvgczyk2A13Ij/ocoUNYFTCyV6b+P6gh8=;
        b=wzpwo5KaXbhzPdpbHOxvH5ZAqbpAFSoJ5W0W/izoD5z3C3AMoEX0awxBeW5gnl4hDD
         5UPyZZk0gxmeFzUuqQVdBGWl+ZDvbL4d/RgHlWyAxeIwwI2qcEiBQ6Mrlh3Q2Vu0hz1T
         o5EJ2rLH6YKtM47+DuWzfngBD+kFcqakFUUNxbd2OFkYc+wUfGyGHiGownEKte8huzVF
         0vkyrgdm8Hwuyo6UPWiYc/B2qNAnahP+UfAFUEp3phWzCF+yfxgynM0eFUFeGrAhWuc1
         YqUGYkge94KpBHNnubOYUawFZQpp6ZtVYTc89hzroxCtByvBbuI7cV072ShuQ+jjnMKt
         CMkQ==
X-Gm-Message-State: AOJu0Yxn0oaVygptJKaxq2IarbHr7hmR4ANYMQNycLdgGiRBb8HdH3Ub
	BvTGscAnM32253A02Emm261jO1fAXQfkqMyRCD0=
X-Google-Smtp-Source: AGHT+IHqopjsr9BP1ss3CSoo05FNLUC7HlYkBIJAwdcXGipKNcB3IBn5N91CU3D2e0oxtKbS3nDKUA==
X-Received: by 2002:a05:6a20:72ab:b0:15e:bb88:b76e with SMTP id o43-20020a056a2072ab00b0015ebb88b76emr4544752pzk.14.1697609014178;
        Tue, 17 Oct 2023 23:03:34 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090acc0e00b00276cb03a0e9sm505782pju.46.2023.10.17.23.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:03:33 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v6 1/8] cgroup: Prepare for using css_task_iter_*() in BPF
Date: Wed, 18 Oct 2023 14:03:11 +0800
Message-Id: <20231018060318.105524-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231018060318.105524-1-zhouchuyi@bytedance.com>
References: <20231018060318.105524-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch makes some preparations for using css_task_iter_*() in BPF
Program.

1. Flags CSS_TASK_ITER_* are #define-s and it's not easy for bpf prog to
use them. Convert them to enum so bpf prog can take them from vmlinux.h.

2. In the next patch we will add css_task_iter_*() in common kfuncs which
is not safe. Since css_task_iter_*() does spin_unlock_irq() which might
screw up irq flags depending on the context where bpf prog is running.
So we should use irqsave/irqrestore here and the switching is harmless.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h | 12 +++++-------
 kernel/cgroup/cgroup.c | 18 ++++++++++++------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b307013b9c6c..0ef0af66080e 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -40,13 +40,11 @@ struct kernel_clone_args;
 #define CGROUP_WEIGHT_DFL		100
 #define CGROUP_WEIGHT_MAX		10000
 
-/* walk only threadgroup leaders */
-#define CSS_TASK_ITER_PROCS		(1U << 0)
-/* walk all threaded css_sets in the domain */
-#define CSS_TASK_ITER_THREADED		(1U << 1)
-
-/* internal flags */
-#define CSS_TASK_ITER_SKIPPED		(1U << 16)
+enum {
+	CSS_TASK_ITER_PROCS    = (1U << 0),  /* walk only threadgroup leaders */
+	CSS_TASK_ITER_THREADED = (1U << 1),  /* walk all threaded css_sets in the domain */
+	CSS_TASK_ITER_SKIPPED  = (1U << 16), /* internal flags */
+};
 
 /* a css_task_iter should be treated as an opaque object */
 struct css_task_iter {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1fb7f562289d..b6d64f3b8888 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4917,9 +4917,11 @@ static void css_task_iter_advance(struct css_task_iter *it)
 void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it)
 {
+	unsigned long irqflags;
+
 	memset(it, 0, sizeof(*it));
 
-	spin_lock_irq(&css_set_lock);
+	spin_lock_irqsave(&css_set_lock, irqflags);
 
 	it->ss = css->ss;
 	it->flags = flags;
@@ -4933,7 +4935,7 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 
 	css_task_iter_advance(it);
 
-	spin_unlock_irq(&css_set_lock);
+	spin_unlock_irqrestore(&css_set_lock, irqflags);
 }
 
 /**
@@ -4946,12 +4948,14 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
  */
 struct task_struct *css_task_iter_next(struct css_task_iter *it)
 {
+	unsigned long irqflags;
+
 	if (it->cur_task) {
 		put_task_struct(it->cur_task);
 		it->cur_task = NULL;
 	}
 
-	spin_lock_irq(&css_set_lock);
+	spin_lock_irqsave(&css_set_lock, irqflags);
 
 	/* @it may be half-advanced by skips, finish advancing */
 	if (it->flags & CSS_TASK_ITER_SKIPPED)
@@ -4964,7 +4968,7 @@ struct task_struct *css_task_iter_next(struct css_task_iter *it)
 		css_task_iter_advance(it);
 	}
 
-	spin_unlock_irq(&css_set_lock);
+	spin_unlock_irqrestore(&css_set_lock, irqflags);
 
 	return it->cur_task;
 }
@@ -4977,11 +4981,13 @@ struct task_struct *css_task_iter_next(struct css_task_iter *it)
  */
 void css_task_iter_end(struct css_task_iter *it)
 {
+	unsigned long irqflags;
+
 	if (it->cur_cset) {
-		spin_lock_irq(&css_set_lock);
+		spin_lock_irqsave(&css_set_lock, irqflags);
 		list_del(&it->iters_node);
 		put_css_set_locked(it->cur_cset);
-		spin_unlock_irq(&css_set_lock);
+		spin_unlock_irqrestore(&css_set_lock, irqflags);
 	}
 
 	if (it->cur_dcset)
-- 
2.20.1


