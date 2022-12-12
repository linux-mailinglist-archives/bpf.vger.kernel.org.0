Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7F649768
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 01:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiLLAhs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 19:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiLLAhs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 19:37:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0192657
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:37:46 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so10475421pjm.2
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGtC3SN6Ifn7NlhGu9Dw24wgt0iqbWERqtVVRikZ7FU=;
        b=aylXhwHRB/AnaqV0nbRReAnU29I+73XtbQYit2HtT6Nf4V02lXAmWcUcXfAMaKKMyW
         ongHgiHPo/1Yo/hBjs1Yonph+tyD/hp39THh63O0jAOOrpoVfVW/gFXkc1QVjqQ1sYiL
         Q5Pobduy9ttgieGJeoJ3ggbEV9QYNbSZ2mX4u1ANqmQlGpY9GKRtcV7baGzZ6FgIVx+r
         +kOxzFrlGcZCgssVQNCEtuJh9I0VFURrNHQW8x1ib2kSYXZO8Wpiu8uGtc2/lvGfclsb
         8VSviT9bHd5lIOEooS7oy7agNzaiKd6m4bpfeDCtz+Mex01Uu0FR1DKPDPgjyDTOXIqa
         XzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGtC3SN6Ifn7NlhGu9Dw24wgt0iqbWERqtVVRikZ7FU=;
        b=38o1gYlCp298BHeehKI7h8BRGy9uShH8pU0t8k923ZUQP2R4XtPV0hyUa0Yr6aZccX
         2wZ1UH0FHhsVNUbLTzoLnyVoz5Llb5YSZoQVa2ybiSm1PEDw7nkyezMnc/638jmNIo7M
         6PtfsK1VdJwcx3UBPQ+o2Z3RQWG8MzZQcLW3BerXOqMMcA7FXFVZKGNAu/5Xxz5LLFN1
         RVKOakd2oJfu0CAIVlhA4cobd0tYvwxMr4BuVEjZY3K/pdEqwtO8hF5XilVcP9KQw8no
         5SyxaVhdzpWy0y3mQGPma6pv1rS7fI7PCKsXhXEdBH7hQYqNd4dYOmhNWDhA/+XIT5rv
         WoLg==
X-Gm-Message-State: ANoB5pkeemllOvdd3ywkl+5nvuLlcADejf8pNUGUpMNQysYamwhOYMi4
        S7/W/VCgqsLPlicqoE0oOE5EIqm/dpnUyIXhDu0=
X-Google-Smtp-Source: AA0mqf5OlxYfuHjLp+MFFLeSNr64rxHfH89FJoaBzG1fbT222yfAv8sK9MnrXVllA3XEBIYOCtCxTg==
X-Received: by 2002:a05:6a20:a681:b0:ac:1266:bda with SMTP id ba1-20020a056a20a68100b000ac12660bdamr19043512pzb.7.1670805466209;
        Sun, 11 Dec 2022 16:37:46 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7002:8c7:5400:4ff:fe3d:656a])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b00177fb862a87sm4895960plg.20.2022.12.11.16.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:37:45 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 2/9] mm: Allow using active vm in all contexts
Date:   Mon, 12 Dec 2022 00:37:04 +0000
Message-Id: <20221212003711.24977-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221212003711.24977-1-laoar.shao@gmail.com>
References: <20221212003711.24977-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We can use active vm in task, softirq and irq to account specific memory
usage. Two new helpers active_vm_{add,sub} are introduced.

A dummy item is introduced here, which will be removed when we introduce
real item.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/active_vm.h | 50 +++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h     |  5 ++++
 kernel/fork.c             |  4 ++++
 mm/active_vm.c            | 23 ++++++++++++++++++
 mm/active_vm.h            | 38 +++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+)

diff --git a/include/linux/active_vm.h b/include/linux/active_vm.h
index 899e578e94fa..21f9aaca12c4 100644
--- a/include/linux/active_vm.h
+++ b/include/linux/active_vm.h
@@ -4,6 +4,9 @@
 
 #ifdef CONFIG_ACTIVE_VM
 #include <linux/jump_label.h>
+#include <linux/preempt.h>
+#include <linux/percpu-defs.h>
+#include <linux/sched.h>
 
 extern struct static_key_true active_vm_disabled;
 
@@ -14,10 +17,57 @@ static inline bool active_vm_enabled(void)
 
 	return true;
 }
+
+enum active_vm_item {
+	DUMMY_ITEM = 1,
+	NR_ACTIVE_VM_ITEM = DUMMY_ITEM,
+};
+
+struct active_vm_stat {
+	long stat[NR_ACTIVE_VM_ITEM];
+};
+
+DECLARE_PER_CPU(struct active_vm_stat, active_vm_stats);
+DECLARE_PER_CPU(int, irq_active_vm_item);
+DECLARE_PER_CPU(int, soft_active_vm_item);
+
+static inline int
+active_vm_item_set(int item)
+{
+	int old_item;
+
+	if (in_irq()) {
+		old_item = this_cpu_read(irq_active_vm_item);
+		this_cpu_write(irq_active_vm_item, item);
+	} else if (in_softirq()) {
+		old_item = this_cpu_read(soft_active_vm_item);
+		this_cpu_write(soft_active_vm_item, item);
+	} else {
+		old_item = current->active_vm_item;
+		current->active_vm_item = item;
+	}
+
+	return old_item;
+}
+
+long active_vm_item_sum(int item);
+
 #else
 static inline bool active_vm_enabled(void)
 {
 	return false;
 }
+
+static inline int
+active_vm_item_set(int item)
+{
+	return 0;
+}
+
+static inline long active_vm_item_sum(int item)
+{
+	return 0;
+}
+
 #endif /* CONFIG_ACTIVE_VM */
 #endif /* __INCLUDE_ACTIVE_VM_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd13..05acefd383d4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1441,6 +1441,11 @@ struct task_struct {
 	struct mem_cgroup		*active_memcg;
 #endif
 
+#ifdef CONFIG_ACTIVE_VM
+	/* Used for scope-based memory accounting */
+	int				active_vm_item;
+#endif
+
 #ifdef CONFIG_BLK_CGROUP
 	struct request_queue		*throttle_queue;
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..590d949ff131 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1043,6 +1043,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->active_memcg = NULL;
 #endif
 
+#ifdef CONFIG_ACTIVE_VM
+	tsk->active_vm_item = 0;
+#endif
+
 #ifdef CONFIG_CPU_SUP_INTEL
 	tsk->reported_split_lock = 0;
 #endif
diff --git a/mm/active_vm.c b/mm/active_vm.c
index 60849930a7d3..541b2ba22da9 100644
--- a/mm/active_vm.c
+++ b/mm/active_vm.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/page_ext.h>
+#include <linux/active_vm.h>
 
 static bool __active_vm_enabled __initdata =
 				IS_ENABLED(CONFIG_ACTIVE_VM);
@@ -31,3 +32,25 @@ struct page_ext_operations active_vm_ops = {
 	.need = need_active_vm,
 	.init = init_active_vm,
 };
+
+DEFINE_PER_CPU(int, irq_active_vm_item);
+DEFINE_PER_CPU(int, soft_active_vm_item);
+EXPORT_PER_CPU_SYMBOL(irq_active_vm_item);
+EXPORT_PER_CPU_SYMBOL(soft_active_vm_item);
+DEFINE_PER_CPU(struct active_vm_stat, active_vm_stats);
+EXPORT_PER_CPU_SYMBOL(active_vm_stats);
+
+long active_vm_item_sum(int item)
+{
+	struct active_vm_stat *this;
+	long sum = 0;
+	int cpu;
+
+	WARN_ON_ONCE(item <= 0);
+	for_each_online_cpu(cpu) {
+		this = &per_cpu(active_vm_stats, cpu);
+		sum += this->stat[item - 1];
+	}
+
+	return sum;
+}
diff --git a/mm/active_vm.h b/mm/active_vm.h
index 72978955833e..1df088d768ef 100644
--- a/mm/active_vm.h
+++ b/mm/active_vm.h
@@ -3,6 +3,44 @@
 #define __MM_ACTIVE_VM_H
 
 #ifdef CONFIG_ACTIVE_VM
+#include <linux/active_vm.h>
+
 extern struct page_ext_operations active_vm_ops;
+
+static inline int active_vm_item(void)
+{
+	if (in_irq())
+		return this_cpu_read(irq_active_vm_item);
+
+	if (in_softirq())
+		return this_cpu_read(soft_active_vm_item);
+
+	return current->active_vm_item;
+}
+
+static inline void active_vm_item_add(int item, long delta)
+{
+	WARN_ON_ONCE(item <= 0);
+	this_cpu_add(active_vm_stats.stat[item - 1], delta);
+}
+
+static inline void active_vm_item_sub(int item, long delta)
+{
+	WARN_ON_ONCE(item <= 0);
+	this_cpu_sub(active_vm_stats.stat[item - 1], delta);
+}
+#else /* CONFIG_ACTIVE_VM */
+static inline int active_vm_item(void)
+{
+	return 0;
+}
+
+static inline void active_vm_item_add(int item, long delta)
+{
+}
+
+static inline void active_vm_item_sub(int item, long delta)
+{
+}
 #endif /* CONFIG_ACTIVE_VM */
 #endif /* __MM_ACTIVE_VM_H */
-- 
2.30.1 (Apple Git-130)

