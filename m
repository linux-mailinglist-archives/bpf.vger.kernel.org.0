Return-Path: <bpf+bounces-3348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DD673C67B
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A801C21443
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD8C3C31;
	Sat, 24 Jun 2023 03:14:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C47F;
	Sat, 24 Jun 2023 03:14:06 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE37E47;
	Fri, 23 Jun 2023 20:14:05 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b5d4b359d3so1214908a34.2;
        Fri, 23 Jun 2023 20:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576444; x=1690168444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duNqWZDO3/6HncjrcON7PuH7YZgYXu50jcANK1eHCwM=;
        b=ZOFQNEFTttgq8yp6fz032yFZrP1lQA8sbIsYdC43C+SGNcVNoFH97svtFSzA33SlIr
         A5Nz6qIPOBP8fYhasfUJIMHtNYUMg/vMQjrZ7wB6zrb6buV4HAQUpN+boXShki8Ial7c
         n/a5UWPOt9AFkaDWOC37X6A4GCXUKNn8IEdSt6hnAC3Cw0OjyB09FWJ129TBxYGo37aa
         FyDxZklB0I4Ru3H40c6Uz8kZuMjTXig8iriUIWf8WT0g3rnS813kJwgw29l/uU3vInqh
         zYJdq7a235Nz8qZIPDlz5zSBhJV2W/bG46lJuGM+rqmCOY6OKP145klRiVCf+W8gCOcC
         ievA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576444; x=1690168444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duNqWZDO3/6HncjrcON7PuH7YZgYXu50jcANK1eHCwM=;
        b=WRfMLh07wrWhI4PBILUb9cANWcUOUWS9ID1io8+LoIvDJpDjB107OVcczZOgRxbUqc
         JZmhI9TUgIVTz6MWwZMwRO6uAw/hUCYgUQJG+1jjjHz+8fHkBkmo9Sm1qLntM1YpuA8J
         ivWoSd0pWFYog8lPdXAActKXz3aTNQSCEJuDiEcedqB6dKtwAbtUl5uHPfZu8vqGKqh7
         a8lv4Le4nwfEhXJdc+jhF3LOabC7xoR5Dp48PxY6zZlUCdL2PXbDz7EgWmNgtgjVqDGK
         XUq9ido5fNzSNXiMZ7t3qzH6FDaZLPjuX9UR3GZoXnDp37tsHMO+Kx6/dDPn7voTKelW
         XP7w==
X-Gm-Message-State: AC+VfDyMBmwY4qcytchMBfPVI1j+DajCBeODtYGrkXsUG3EL4CzYcO2p
	S7TGuuJnomhHwzyStVD+Avg=
X-Google-Smtp-Source: ACHHUZ6FKQtMwOK84nF8VW2bU0nzN+YBigoFd8DVHGXtTmuRd/GhRu1lN3z2GcluBAb3bGCe9HhaLA==
X-Received: by 2002:a9d:6343:0:b0:6b1:d368:557c with SMTP id y3-20020a9d6343000000b006b1d368557cmr20046744otk.30.1687576444556;
        Fri, 23 Jun 2023 20:14:04 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ab9100b001aadd0d7364sm245495plr.83.2023.06.23.20.14.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:14:04 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	void@manifault.com,
	houtao@huaweicloud.com,
	paulmck@kernel.org
Cc: tj@kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 07/13] bpf: Change bpf_mem_cache draining process.
Date: Fri, 23 Jun 2023 20:13:27 -0700
Message-Id: <20230624031333.96597-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexei Starovoitov <ast@kernel.org>

The next patch will introduce cross-cpu llist access and existing
irq_work_sync() + drain_mem_cache() + rcu_barrier_tasks_trace() mechanism will
not be enough, since irq_work_sync() + drain_mem_cache() on cpu A won't
guarantee that llist on cpu A are empty. The free_bulk() on cpu B might add
objects back to llist of cpu A. Add 'bool draining' flag and set it all cpus
before proceeding with irq_work_sync.
The modified sequence looks like:
for_each_cpu:
  WRITE_ONCE(c->draining, true); // make RCU callback a nop
  irq_work_sync(); // wait for irq_work callback (free_bulk) to finish
for_each_cpu:
  drain_mem_cache(); // free all objects
rcu_barrier_tasks_trace(); // wait for RCU callbacks to execute as a nop

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 4fd79bd51f5a..d68a854f45ee 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -98,6 +98,7 @@ struct bpf_mem_cache {
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
+	bool draining;
 
 	/* list of objects to be freed after RCU tasks trace GP */
 	struct llist_head free_by_rcu_ttrace;
@@ -252,7 +253,10 @@ static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
 
+	if (unlikely(READ_ONCE(c->draining)))
+		goto out;
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+out:
 	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
 }
 
@@ -542,16 +546,11 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		rcu_in_progress = 0;
 		for_each_possible_cpu(cpu) {
 			c = per_cpu_ptr(ma->cache, cpu);
-			/*
-			 * refill_work may be unfinished for PREEMPT_RT kernel
-			 * in which irq work is invoked in a per-CPU RT thread.
-			 * It is also possible for kernel with
-			 * arch_irq_work_has_interrupt() being false and irq
-			 * work is invoked in timer interrupt. So waiting for
-			 * the completion of irq work to ease the handling of
-			 * concurrency.
-			 */
+			WRITE_ONCE(c->draining, true);
 			irq_work_sync(&c->refill_work);
+		}
+		for_each_possible_cpu(cpu) {
+			c = per_cpu_ptr(ma->cache, cpu);
 			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
 		}
@@ -566,7 +565,14 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			cc = per_cpu_ptr(ma->caches, cpu);
 			for (i = 0; i < NUM_CACHES; i++) {
 				c = &cc->cache[i];
+				WRITE_ONCE(c->draining, true);
 				irq_work_sync(&c->refill_work);
+			}
+		}
+		for_each_possible_cpu(cpu) {
+			cc = per_cpu_ptr(ma->caches, cpu);
+			for (i = 0; i < NUM_CACHES; i++) {
+				c = &cc->cache[i];
 				drain_mem_cache(c);
 				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
 			}
-- 
2.34.1


