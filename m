Return-Path: <bpf+bounces-3625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903F87407FB
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 04:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF0280A65
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F4463D3;
	Wed, 28 Jun 2023 01:57:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3C257E;
	Wed, 28 Jun 2023 01:57:09 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C602D59;
	Tue, 27 Jun 2023 18:57:08 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1b06777596cso977451fac.2;
        Tue, 27 Jun 2023 18:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917426; x=1690509426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlxTnp19Kd/MPSDl2RItcTKx2L7V0g2IZhfiMGy+r1A=;
        b=BWxvq9lbYpleN97RGzQFzJanjNUt2jrJp2E6e+BAiivuOVMakqPuZeTfynbkBDwZEF
         5ami1O1+TfCnXJTIHiaAKyslE39Al8jpd3rEiElNlFhGbwl4VVsxkdXypFFi3jF0vBB6
         s1gkYClix7ttxrfVmyWB15Ib9odr8qnLCtFt8Jl2B3kh7qMgfEGgY11Aku73zmUSNxBf
         +ei5SfqKmRmXsClEgzb3bh4lGNbzf5v+X5UfUIDeUMHaXBjLJqllbi1BbsrvlfCQqrT5
         N07SjTQ0xOGVaS01FPJ5LaKqF3xBM3AZSasj5qvSVUAKV/b1maIhXFpDLFndWnaa/RIl
         55FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917426; x=1690509426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlxTnp19Kd/MPSDl2RItcTKx2L7V0g2IZhfiMGy+r1A=;
        b=hjf4uNYFvdKlBrAvxZm6S5lVSq2v/G/bL5qhE1qBo0ss7JnYTFWs9ODVmrh6ADSD2e
         luZ9nMTFULvLFNw/PAAFaSejOGEAXKyX6AUhnZ/Hu6CUbI3t6psDqUeeYC9GYSP6fLit
         HivxPHyhP2K2wW4nDggdpy/CR6tDWVi4rBfT2k4/oYXwdopQFcMWMgWSA0qBPGfDJqFd
         V+uCrUX1U/a2QdlBko+lZ8nf1xFsZr4w3s2cvjWN9jeWGVDAPsIKjLWgVg7+2/qhT55c
         zaED45qPo+F6L0uTRvvth1DyXrB62yWm/aXRhB/0TwKvjuhWygB9D5yJ1X+VFynAiRtU
         0AUw==
X-Gm-Message-State: AC+VfDy/JKj99dfxJ33x+2lm0hBap+T3tGYSyo7OiBcN3vMZZrjjBkvp
	ggKREo2g8we73SSe+WWEdi8=
X-Google-Smtp-Source: ACHHUZ4fkBOSfMw7/G5gRZNGEPLmgdSCrIFHQivc+pzR++oozLp3DUQSDxB37vgplgtXPBXLTUpRLA==
X-Received: by 2002:a05:6808:168e:b0:39e:d559:61fc with SMTP id bb14-20020a056808168e00b0039ed55961fcmr33774952oib.30.1687917426430;
        Tue, 27 Jun 2023 18:57:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7809a000000b0062cf75a9e6bsm6015294pff.131.2023.06.27.18.57.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:57:06 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 07/13] bpf: Change bpf_mem_cache draining process.
Date: Tue, 27 Jun 2023 18:56:28 -0700
Message-Id: <20230628015634.33193-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
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


