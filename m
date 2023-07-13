Return-Path: <bpf+bounces-4958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7199B752421
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 15:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D80F281DDF
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BE0156E3;
	Thu, 13 Jul 2023 13:46:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5896747E
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 13:46:01 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666C7B4
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:45:59 -0700 (PDT)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A6393F18F
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1689255957;
	bh=OISdSbIRHeqAVpn1Q65It/xjmRXvWdsGR3LrX1oU/l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Z+KmMCsJeiSXb0rVKNjutFzoDGzrCuAc5AG5JOSGosVwGuROxw8oEx4ZrHONFBwzE
	 kpDqi+xVcv7tdFGjIKyMzsutcHBde7Hrv0JDWpLP4eac3jzp0m56YYaRIXCc+Lib4M
	 +UkFCpNgQSpfdpqE/76Aty1tljfUE7G1LJ1QCLJLrXPpUthSqFphyBI5Lmik7mUjSo
	 mEL1LBTBI/TN9o72eE0xyUEucC62V/rLoPpkMO6nptbBztBxgsy9o+WZSNMasLxKcp
	 O0MPlqjOdtJwCSlP4sQY9OSazyXWbvH8SUzHiO7N2Ipd0OWVW90tW+fd9/WAeo2HGc
	 PfbhBDBm3zGNg==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b70bfcd15aso7298231fa.0
        for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689255956; x=1691847956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OISdSbIRHeqAVpn1Q65It/xjmRXvWdsGR3LrX1oU/l0=;
        b=FIzbOUKJn+qpVdIG44zog/j+Kunakx3Es/jNdYvTJHoOLyLKd3EDy/vFl+LxcxtJc9
         LZ8EPByHvgHfEl+Yb4hdP9orRGo63ydYpY4ftCwOgFn4ZuYvs6xQn4xgWJbDuLr3GWSo
         0KOANLb8ODWk9YWo8bw6iZZtw+R0wYIYp5tqAVSG7+svMOIzhsrd7uD+q0T3UAg9bD1E
         MqWAcUjyEo0kQa8T98vWUrqKEuzt19NKmuE6sROdkXVBpvDxodVT4VW8X+0AZIIcB/lJ
         2LbDjFwL8PqyXRnKdVse3SJqPZxe2L5LX/Y1jgL5KSOOxn/ZWi59DMhQz/451Hg847rA
         ADTg==
X-Gm-Message-State: ABy/qLYXhxAaE4rZSPrDM03CLRDlmLLbEe7G/uyY1lEE7rE5TZg1z6Du
	OneQvCtR1fnONcP9Q/Lhr5oa9QUZNLapWZNwGbwKiROgvt1o5YgBXmDLBaXsDIrRT+l15vzEBxA
	WFLWadYMsxu211cS0yw8Mss5nB75vWg==
X-Received: by 2002:a2e:981a:0:b0:2b6:db9b:aadc with SMTP id a26-20020a2e981a000000b002b6db9baadcmr1584687ljj.32.1689255955960;
        Thu, 13 Jul 2023 06:45:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE2dpAIUyE2fHjrVG/n8WiIgznzDLplWQKMUeTqw6wLHiRrapaxTb3XySPXwgpFPGrCmMoBkg==
X-Received: by 2002:a2e:981a:0:b0:2b6:db9b:aadc with SMTP id a26-20020a2e981a000000b002b6db9baadcmr1584640ljj.32.1689255955562;
        Thu, 13 Jul 2023 06:45:55 -0700 (PDT)
Received: from localhost (host-95-234-206-203.retail.telecomitalia.it. [95.234.206.203])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064a8a00b0098e422d6758sm3974713eju.219.2023.07.13.06.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 06:45:55 -0700 (PDT)
Date: Thu, 13 Jul 2023 15:45:54 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 27/34] sched_ext: Implement SCX_KICK_WAIT
Message-ID: <ZLAAEnd2HOinKrA+@righiandr-XPS-13-7390>
References: <20230711011412.100319-1-tj@kernel.org>
 <20230711011412.100319-28-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711011412.100319-28-tj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 03:13:45PM -1000, Tejun Heo wrote:
...
> +	for_each_cpu_andnot(cpu, this_rq->scx.cpus_to_wait,
> +			    cpumask_of(this_cpu)) {
> +		/*
> +		 * Pairs with smp_store_release() issued by this CPU in
> +		 * scx_notify_pick_next_task() on the resched path.
> +		 *
> +		 * We busy-wait here to guarantee that no other task can be
> +		 * scheduled on our core before the target CPU has entered the
> +		 * resched path.
> +		 */
> +		while (smp_load_acquire(&cpu_rq(cpu)->scx.pnt_seq) == pseqs[cpu])
> +			cpu_relax();
> +	}
> +

...

> +static inline void scx_notify_pick_next_task(struct rq *rq,
> +					     const struct task_struct *p,
> +					     const struct sched_class *active)
> +{
> +#ifdef CONFIG_SMP
> +	if (!scx_enabled())
> +		return;
> +	/*
> +	 * Pairs with the smp_load_acquire() issued by a CPU in
> +	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
> +	 * resched.
> +	 */
> +	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
> +#endif
> +}

We can't use smp_load_acquire()/smp_store_release() with a u64 on
32-bit architectures.

For example, on armhf the build is broken:

In function ‘scx_notify_pick_next_task’,
    inlined from ‘__pick_next_task’ at /<<PKGBUILDDIR>>/kernel/sched/core.c:6106:4,
    inlined from ‘pick_next_task’ at /<<PKGBUILDDIR>>/kernel/sched/core.c:6605:9,
    inlined from ‘__schedule’ at /<<PKGBUILDDIR>>/kernel/sched/core.c:6750:9:
/<<PKGBUILDDIR>>/include/linux/compiler_types.h:397:45: error: call to ‘__compiletime_assert_597’ declared with attribute error: Need native word sized stores/loads for atomicity.
  397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
/<<PKGBUILDDIR>>/include/linux/compiler_types.h:378:25: note: in definition of macro ‘__compiletime_assert’
  378 |                         prefix ## suffix();                             \
      |                         ^~~~~~
/<<PKGBUILDDIR>>/include/linux/compiler_types.h:397:9: note: in expansion of macro ‘_compiletime_assert’
  397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
/<<PKGBUILDDIR>>/include/linux/compiler_types.h:400:9: note: in expansion of macro ‘compiletime_assert’
  400 |         compiletime_assert(__native_word(t),                            \
      |         ^~~~~~~~~~~~~~~~~~
/<<PKGBUILDDIR>>/include/asm-generic/barrier.h:141:9: note: in expansion of macro ‘compiletime_assert_atomic_type’
  141 |         compiletime_assert_atomic_type(*p);                             \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/<<PKGBUILDDIR>>/include/asm-generic/barrier.h:172:55: note: in expansion of macro ‘__smp_store_release’
  172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
      |                                                       ^~~~~~~~~~~~~~~~~~~
/<<PKGBUILDDIR>>/kernel/sched/ext.h:159:9: note: in expansion of macro ‘smp_store_release’
  159 |         smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);

There's probably a better way to fix this, but for now I've temporarily
solved this using cmpxchg64() - see patch below.

I'm not sure if we already have an equivalent of
smp_store_release_u64/smp_load_acquire_u64(). Otherwise, it may be worth
to add them to a more generic place.

-Andrea

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 051c79fa25f7..5da72b1cf88d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3667,7 +3667,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 		 * scheduled on our core before the target CPU has entered the
 		 * resched path.
 		 */
-		while (smp_load_acquire(&cpu_rq(cpu)->scx.pnt_seq) == pseqs[cpu])
+		while (smp_load_acquire_u64(&cpu_rq(cpu)->scx.pnt_seq) == pseqs[cpu])
 			cpu_relax();
 	}
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 405037a4e6ce..ef4a24d77d30 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -144,6 +144,40 @@ void __scx_notify_pick_next_task(struct rq *rq,
 				 struct task_struct *p,
 				 const struct sched_class *active);
 
+#ifdef CONFIG_64BIT
+static inline u64 smp_load_acquire_u64(u64 *ptr)
+{
+	return smp_load_acquire(ptr);
+}
+
+static inline void smp_store_release_u64(u64 *ptr, u64 val)
+{
+	smp_store_release(ptr, val);
+}
+#else
+static inline u64 smp_load_acquire_u64(u64 *ptr)
+{
+	u64 prev, next;
+
+	do {
+		prev = *ptr;
+		next = prev;
+	} while (cmpxchg64(ptr, prev, next) != prev);
+
+	return prev;
+}
+
+static inline void smp_store_release_u64(u64 *ptr, u64 val)
+{
+	u64 prev, next;
+
+	do {
+		prev = *ptr;
+		next = val;
+	} while (cmpxchg64(ptr, prev, next) != prev);
+}
+#endif
+
 static inline void scx_notify_pick_next_task(struct rq *rq,
 					     struct task_struct *p,
 					     const struct sched_class *active)
@@ -156,7 +190,7 @@ static inline void scx_notify_pick_next_task(struct rq *rq,
 	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
 	 * resched.
 	 */
-	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+	smp_store_release_u64(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
 #endif
 	if (!static_branch_unlikely(&scx_ops_cpu_preempt))
 		return;
-- 
2.40.1


