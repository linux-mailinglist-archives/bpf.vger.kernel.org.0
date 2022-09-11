Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F9F5B4CA0
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 10:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiIKIfh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 04:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIKIfd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 04:35:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C2303F8
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 01:35:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 201-20020a2505d2000000b006a941934651so5171113ybf.13
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=D/SnG5xrOwQyB3eTr7OdaTwvgtrUGbj63fgiKAgNxbM=;
        b=M/K0SjnRJmdCFEWYVswlTFVNzjsHrR1K8GxZkKq6baQAyAH/bmO7hzJLnKdCp6L+GZ
         exieJ/UH1UGGduTYYSiK4FOImZJYAxakkne6KqJLso6swfanKPAYmjlCGrbaDY0A1Vhv
         PhWTOMLXOT9qaK5PA1eEW1WtjKb1vKMmZLQYKIaNC23+HfLAeVjeRijwkbKEP9G+Dz//
         PpNCDuxGFuAwhFZOKkksVQ9wr14TeG7saP4E7gQ3RQ9dwZ3rxS4c7ynPfbHB6Og33sVf
         dLhaHGG+WqTC0hHazDZJJSZ8skH9Jt5MZUyMVqgYeVO/osfy4rA1fd6OpQL5f7nLxC3n
         wQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=D/SnG5xrOwQyB3eTr7OdaTwvgtrUGbj63fgiKAgNxbM=;
        b=ZSaO1PPb7uCVeWSOLT3gAz7P9v54QzTAVF4E9tnVHFuTvBCZqiSVZSbez1yzyZm2t7
         hH8KML9P8gg51KhXgbS1SLApXOsvCcivdYx1xblRKg7wZ4ovmQS6xobwDb++BXlE4FzW
         ww2X4hfetpFCvaK2EyTJtGZ8GUXIkVAvTwXQKWq9MxAiEvk/PsKl8v0WMsxWJ3kB1DPI
         PRo9G8S2vquRHYfWndkosYuxkmdiXJ+B6IG14ZbVbZpz4IpVhIqUxN7bdT5gjPn67qit
         vfJhSm1qgYAnQQa/jQHOZp7e8Rr8mH6wo5VB9iueH7+84ixlhA5CzEZj1yIOz0OteHQA
         AwaA==
X-Gm-Message-State: ACgBeo3t13lwyolulucF3hNOZMJFomgL1NnU2nHAi1+40DD0q9DClH9T
        GxChQXqEd/bty0C2lui2UKcQ6Mcg7wbS
X-Google-Smtp-Source: AA6agR5dpiapAsp3xKW4Wg/S1sd2oIoNnsMBpFfht+/wsDHmsUji1L4eWND7lDlK0KhImgnei3AARX1/dStv
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2d4:203:5076:f273:1383:891d])
 (user=yuanchu job=sendgmr) by 2002:a0d:d441:0:b0:345:83ae:9330 with SMTP id
 w62-20020a0dd441000000b0034583ae9330mr18173203ywd.97.1662885331253; Sun, 11
 Sep 2022 01:35:31 -0700 (PDT)
Date:   Sun, 11 Sep 2022 01:34:17 -0700
In-Reply-To: <20220911083418.2818369-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20220911083418.2818369-1-yuanchu@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220911083418.2818369-2-yuanchu@google.com>
Subject: [RFC PATCH 1/2] mm: multi-gen LRU: support page access info
 harvesting with eBPF
From:   Yuanchu Xie <yuanchu@google.com>
To:     linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Cc:     Michael Larabel <Michael@MichaelLarabel.com>,
        Jon Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yuanchu Xie <yuanchu@google.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add the infrastructure to enable bpf programs to hook into MGLRU and
capture the page access information as MGLRU walks page tables.

- Add empty functions as hook points to capture pte and pmd access bit
harvesting of MGLRU page table walks.

- Add a kfunc to invoke MGLRU aging.

- Add a kfunc and hook point to enable the filtering of MGLRU aging by
PIDs.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/mmzone.h |   1 +
 mm/vmscan.c            | 154 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 710fc1d83bd0..f652b9473c6f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -481,6 +481,7 @@ struct lru_gen_mm_walk {
 	int mm_stats[NR_MM_STATS];
 	/* total batched items */
 	int batched;
+	pid_t pid;
 	bool can_swap;
 	bool force_scan;
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 762e7cb3d2d0..28499ba15e96 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -60,6 +60,10 @@
 #include <linux/swapops.h>
 #include <linux/balloon_compaction.h>
 #include <linux/sched/sysctl.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/rcupdate.h>
 
 #include "internal.h"
 #include "swap.h"
@@ -3381,12 +3385,41 @@ static void reset_mm_stats(struct lruvec *lruvec, struct lru_gen_mm_walk *walk,
 	}
 }
 
+struct bpf_mglru_should_skip_mm_control {
+	pid_t pid;
+	bool should_skip;
+};
+
+void bpf_set_skip_mm(struct bpf_mglru_should_skip_mm_control *ctl)
+{
+	ctl->should_skip = true;
+}
+
+__weak noinline void
+bpf_mglru_should_skip_mm(struct bpf_mglru_should_skip_mm_control *ctl)
+{
+}
+
+static bool bpf_mglru_should_skip_mm_wrapper(pid_t pid)
+{
+	struct bpf_mglru_should_skip_mm_control ctl = {
+		.pid = pid,
+		.should_skip = false,
+	};
+
+	bpf_mglru_should_skip_mm(&ctl);
+	return ctl.should_skip;
+}
+
 static bool should_skip_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 {
 	int type;
 	unsigned long size = 0;
 	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
 	int key = pgdat->node_id % BITS_PER_TYPE(mm->lru_gen.bitmap);
+#ifdef CONFIG_MEMCG
+	struct task_struct *task;
+#endif
 
 	if (!walk->force_scan && !test_bit(key, &mm->lru_gen.bitmap))
 		return true;
@@ -3402,6 +3435,16 @@ static bool should_skip_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 	if (size < MIN_LRU_BATCH)
 		return true;
 
+#ifdef CONFIG_MEMCG
+	rcu_read_lock();
+	task = rcu_dereference(mm->owner);
+	if (task && bpf_mglru_should_skip_mm_wrapper(task->pid)) {
+		rcu_read_unlock();
+		return true;
+	}
+	rcu_read_unlock();
+#endif
+
 	return !mmget_not_zero(mm);
 }
 
@@ -3842,6 +3885,22 @@ static bool suitable_to_scan(int total, int young)
 	return young * n >= total;
 }
 
+/*
+ * __weak noinline guarantees that both the function and the callsite are
+ * preserved
+ */
+__weak noinline void mglru_pte_probe(pid_t pid, unsigned int nid, unsigned long addr,
+				     unsigned long len, bool anon)
+{
+
+}
+
+__weak noinline void mglru_pmd_probe(pid_t pid, unsigned int nid, unsigned long addr,
+				     unsigned long len, bool anon)
+{
+
+}
+
 static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 			   struct mm_walk *args)
 {
@@ -3898,6 +3957,8 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 			folio_mark_dirty(folio);
 
 		old_gen = folio_update_gen(folio, new_gen);
+		mglru_pte_probe(walk->pid, pgdat->node_id, addr, folio_nr_pages(folio),
+				folio_test_anon(folio));
 		if (old_gen >= 0 && old_gen != new_gen)
 			update_batch_size(walk, folio, old_gen, new_gen);
 	}
@@ -3978,6 +4039,8 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long next, struct vm_area
 			folio_mark_dirty(folio);
 
 		old_gen = folio_update_gen(folio, new_gen);
+		mglru_pmd_probe(walk->pid, pgdat->node_id, addr, folio_nr_pages(folio),
+				folio_test_anon(folio));
 		if (old_gen >= 0 && old_gen != new_gen)
 			update_batch_size(walk, folio, old_gen, new_gen);
 next:
@@ -4139,6 +4202,7 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 	int err;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
+	walk->pid = mm->owner->pid;
 	walk->next_addr = FIRST_USER_ADDRESS;
 
 	do {
@@ -5657,6 +5721,96 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 	return err;
 }
 
+int bpf_run_aging(int memcg_id, bool can_swap,
+			 bool force_scan)
+{
+	struct scan_control sc = {
+		.may_writepage = true,
+		.may_unmap = true,
+		.may_swap = true,
+		.reclaim_idx = MAX_NR_ZONES - 1,
+		.gfp_mask = GFP_KERNEL,
+	};
+	int err = -EINVAL;
+	struct mem_cgroup *memcg = NULL;
+	struct blk_plug plug;
+	unsigned int flags;
+	unsigned int nid;
+
+	if (!mem_cgroup_disabled()) {
+		rcu_read_lock();
+		memcg = mem_cgroup_from_id(memcg_id);
+#ifdef CONFIG_MEMCG
+		if (memcg && !css_tryget(&memcg->css))
+			memcg = NULL;
+#endif
+		rcu_read_unlock();
+
+		if (!memcg)
+			return -EINVAL;
+	}
+
+	if (memcg_id != mem_cgroup_id(memcg)) {
+		mem_cgroup_put(memcg);
+		return err;
+	}
+
+	set_task_reclaim_state(current, &sc.reclaim_state);
+	flags = memalloc_noreclaim_save();
+	blk_start_plug(&plug);
+	if (!set_mm_walk(NULL)) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	for_each_online_node(nid) {
+		struct lruvec *lruvec = get_lruvec(memcg, nid);
+		DEFINE_MAX_SEQ(lruvec);
+
+		err = run_aging(lruvec, max_seq, &sc, can_swap, force_scan);
+		if (err)
+			goto done;
+	}
+done:
+	clear_mm_walk();
+	blk_finish_plug(&plug);
+	memalloc_noreclaim_restore(flags);
+	set_task_reclaim_state(current, NULL);
+	mem_cgroup_put(memcg);
+
+	return err;
+}
+
+BTF_SET8_START(bpf_lru_gen_trace_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_set_skip_mm)
+BTF_SET8_END(bpf_lru_gen_trace_kfunc_ids)
+
+BTF_SET8_START(bpf_lru_gen_syscall_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_run_aging)
+BTF_SET8_END(bpf_lru_gen_syscall_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_lru_gen_trace_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_lru_gen_trace_kfunc_ids,
+};
+
+static const struct btf_kfunc_id_set bpf_lru_gen_syscall_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_lru_gen_syscall_kfunc_ids,
+};
+
+static int __init bpf_lru_gen_kfunc_init(void)
+{
+	int err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					    &bpf_lru_gen_trace_kfunc_set);
+	if (err)
+		return err;
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					 &bpf_lru_gen_syscall_kfunc_set);
+}
+late_initcall(bpf_lru_gen_kfunc_init);
+
+
 /* see Documentation/admin-guide/mm/multigen_lru.rst for details */
 static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 				 size_t len, loff_t *pos)
-- 
2.37.2.789.g6183377224-goog

