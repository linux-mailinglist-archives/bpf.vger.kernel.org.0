Return-Path: <bpf+bounces-10744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6347AD674
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 12:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9F4181C2089C
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1BF1640F;
	Mon, 25 Sep 2023 10:56:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947F10A3D
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 10:56:04 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D20CE
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 03:56:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-277564f049dso945395a91.1
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 03:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695639362; x=1696244162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNW2oYGtelVvgczyk2A13Ij/ocoUNYFTCyV6b+P6gh8=;
        b=OEwcpaKFyUBrhux6ODETbu0bBt7ufnZGf78YErg8LsIrzPqTYE+VUom7slonPVHwW1
         97S6H+00UmkrTq0AFH35AvdQFWouBCpgNBGC6c+EPGvdRab0FJKUn48mpoBv07/wXZBv
         L90JM6rlJoky0sicp8VCZn9GSXf8GC/XF03ib67JI3+Emn4pFnflXpGEa7wFctDuSdpU
         BcBCmoLAlG4MPVRDrFAqHLNL3kxLL6B9k432WmiXU0nQ41IUQaX1TUf1Do/dV4JZRylR
         0yGtKz9rE3cLW4+qWF436aqOx1UCcpeNUfjmHDhZM0UTT+36DzCKN9yKNxuR12pYto96
         VaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639362; x=1696244162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNW2oYGtelVvgczyk2A13Ij/ocoUNYFTCyV6b+P6gh8=;
        b=ZZq9a0bov4dnITaEFKWubOziEoI/J70zhQWaYGRMFNjP72AvzBuhFWuxL4n++Z8jpW
         9g9XCgUUOA9ZLBmdeiS9j8bQloaJqTc3HyEBogAme4dXmTN+2SxpI4trXzW8CmG37cU2
         bnBWn364eqSo+4vd4Z15MyTL8EEli3YRdpanbDrRYHQguu5OgHaUAltoMnlwzrpp/nM5
         tjxL0/F+9N7lV7nW5zw5tIqcbZkA3dC6ODt0fZRS7r0obMzAU13VnH+OsWiAXB15tPXk
         PlU/9GmHIqfcHktorkrnWWyyxdytAMl3ZMWhS545TyX2DEcJ+zKV6Y4tS1pHiZbeQYW/
         lgrg==
X-Gm-Message-State: AOJu0YzAXo/PuwbYmnb57TXCrZpoFaWYnkSaNaaWU2nKYPwUBqpJtdAR
	LgXM7XBr8E4fkAoVSc/YPPmX67K9zdeeYTCNRfM=
X-Google-Smtp-Source: AGHT+IHp/dxOp5lZfYz+AJSDE+Z1GQcVZzaw2B/oB9wdhmCRbIN3OCr0RuL9gwN+a707ArGcZRGeBQ==
X-Received: by 2002:a17:90b:4f8d:b0:268:c5c7:f7f1 with SMTP id qe13-20020a17090b4f8d00b00268c5c7f7f1mr3640155pjb.29.1695639362307;
        Mon, 25 Sep 2023 03:56:02 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a16c900b002772faee740sm2297842pje.5.2023.09.25.03.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:56:02 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v3 1/7] cgroup: Prepare for using css_task_iter_*() in BPF
Date: Mon, 25 Sep 2023 18:55:46 +0800
Message-Id: <20230925105552.817513-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230925105552.817513-1-zhouchuyi@bytedance.com>
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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


