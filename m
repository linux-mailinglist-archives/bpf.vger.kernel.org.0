Return-Path: <bpf+bounces-4157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CB574945C
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F962810AB
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFAC4C9D;
	Thu,  6 Jul 2023 03:35:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B04A39;
	Thu,  6 Jul 2023 03:35:20 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7A0198E;
	Wed,  5 Jul 2023 20:35:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso242008a12.1;
        Wed, 05 Jul 2023 20:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614519; x=1691206519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlxTnp19Kd/MPSDl2RItcTKx2L7V0g2IZhfiMGy+r1A=;
        b=PL6vG5dldSNfBDDR4wMIJuXt34CqyG/cEZSisH8+df89ejxGlPE7xb2+6WrnXlktd+
         xDaeoZMEm+e9hFHCBffxTYrHezwQUbSncj9F2FfxF2inLvZ6bAaSoxYl8s/spHC1qqN6
         8lJ31bsSrJEZKKV+yJcroBeQ8xzqFGGMe20kXHJKsJAvBZfUw05j2Wil6Mo081jQNEJn
         +UD8GBpZoBbwgfTW0nbEqv2TslIPG3wNce7wXbRi1EtfeGz4HiOkBhcsuUikP8w0HvrB
         3uUI1H/OyumiFqkVDM73lUPbYVqBl9VUIdiJO17U8/XODjO77QqZiz+XxkQ9LEAoTBNB
         PQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614519; x=1691206519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlxTnp19Kd/MPSDl2RItcTKx2L7V0g2IZhfiMGy+r1A=;
        b=BX0oNi0/ePByzMoM35Ssuw7SXLrXLviCL3ZvmKpw/UNzQJp+aBph/jlTlzFRAS6sge
         VBGbUEl9MamFzbtH823FtH0EkEreAKyQuDAjJIV7pRHi6Y6aw5fX8HkjFu4JTtwZjYGF
         jNAeFqwdf8Fy0moVnTpUYy0bBETdmXqvv9v/YPtfA1E5DRe+vhQ3dVS2nb1IbF2qtyWB
         brDg4bQyNnXHLwRnyXRuzmSWqCzxkdjd80KjQpGgf1Int1lkIJ8KqpeJuPw5K/thy9rS
         Lg/Bg0CPAaQwNBMsNECjfS96y05jykONLiGyo2T7Ivq5/Xol/rvJviWEa/Alc4IN/wJI
         29Gg==
X-Gm-Message-State: ABy/qLYO8ppNA61UvQggdv3glYrRKSccNzsyMS2X/2AMnE53uGF9bnQ+
	+gA9A8wLzZe9WJy0Y3hlXBj94aJEwPI=
X-Google-Smtp-Source: APBJJlE4dAGCchgSlrQhJoYURk2GJisA49zLNYkETzZuSP/JeLmew7hUsrUOwYCzJwEXhQZu51OyMQ==
X-Received: by 2002:a05:6a20:8411:b0:105:6d0e:c046 with SMTP id c17-20020a056a20841100b001056d0ec046mr976502pzd.26.1688614518729;
        Wed, 05 Jul 2023 20:35:18 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id q15-20020a62ae0f000000b00678159eacecsm240851pff.121.2023.07.05.20.35.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:18 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 07/14] bpf: Change bpf_mem_cache draining process.
Date: Wed,  5 Jul 2023 20:34:40 -0700
Message-Id: <20230706033447.54696-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
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
objects back to llist of cpu A. Add 'bool draining' flag.
The modified sequence looks like:
for_each_cpu:
  WRITE_ONCE(c->draining, true); // do_call_rcu_ttrace() won't be doing call_rcu() any more
  irq_work_sync(); // wait for irq_work callback (free_bulk) to finish
  drain_mem_cache(); // free all objects
rcu_barrier_tasks_trace(); // wait for RCU callbacks to execute

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 0ee566a7719a..2615f296f052 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -98,6 +98,7 @@ struct bpf_mem_cache {
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
+	bool draining;
 
 	/* list of objects to be freed after RCU tasks trace GP */
 	struct llist_head free_by_rcu_ttrace;
@@ -301,6 +302,12 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 		 * from __free_rcu() and from drain_mem_cache().
 		 */
 		__llist_add(llnode, &c->waiting_for_gp_ttrace);
+
+	if (unlikely(READ_ONCE(c->draining))) {
+		__free_rcu(&c->rcu_ttrace);
+		return;
+	}
+
 	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
 	 * If RCU Tasks Trace grace period implies RCU grace period, free
 	 * these elements directly, else use call_rcu() to wait for normal
@@ -544,15 +551,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
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
 			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
@@ -568,6 +567,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			cc = per_cpu_ptr(ma->caches, cpu);
 			for (i = 0; i < NUM_CACHES; i++) {
 				c = &cc->cache[i];
+				WRITE_ONCE(c->draining, true);
 				irq_work_sync(&c->refill_work);
 				drain_mem_cache(c);
 				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
-- 
2.34.1


