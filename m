Return-Path: <bpf+bounces-3097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EFB7395CB
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 05:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C131C2101C
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 03:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E841C2B;
	Thu, 22 Jun 2023 03:23:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A2188;
	Thu, 22 Jun 2023 03:23:35 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03151A4;
	Wed, 21 Jun 2023 20:23:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b516978829so52244575ad.1;
        Wed, 21 Jun 2023 20:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687404213; x=1689996213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MYF9HAnCDgmsFnN2M7Gvz17JQGRKfkP7N+Wg3WPKfTk=;
        b=Q9uPlXL31uhzzmpJnLFP1hSPhXQ7/9aBLlDdtU4kMbgZuJzLK14QcpBNZfhZmuwu2Y
         DkQMVaE0H4l3eV5FwVTelkSxwDTL1bXnvA7Akv2shpo6l/MSsOapahGJYroD64SM6Djm
         DMPVeDWUHqG2pbCR7rMajebMqIMAKXOWmS15Zp4kLv3yP2xZZkjLL6U709xUWjm72a+l
         6klJKrLhvZhwz1I69v372EIOdp9js2TEoUdCOWUJN7XyHnAQTQWCRkNOdlOmgc/wB9Eq
         0S+zrASNYNPMzq6ZdkG4cXKQ2VQfQaxG2QXdHIjE2Zkstox7pHEbrG1/rWuKzRY2gMh3
         +Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687404213; x=1689996213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYF9HAnCDgmsFnN2M7Gvz17JQGRKfkP7N+Wg3WPKfTk=;
        b=ACx128ViPp3LjYe8Uj6MmqFRNy0QlOHiEdoHgNeEpHox1IaKadbUoT7bfSPQhEnUi/
         AGs1ZfPYNR6V2N69wcSgCdRddqVvwCMWRGlezPoiDsYswOxoUIRVQgEXy2siYLAB6icB
         9qrzibO/v2BN+PTqRgTiCONQ/yQfomw71Q9JXbw3e4Nx7G2KYC9iOBK2zxAFD6oA+yot
         hiln6SMyeOD9biHkkTmXbQg9BcjBcNiS0QA6PfnUBSp/L9NXPRBTraKfezukbZ8LYCH6
         kI8rSYaL76qSATJSIcL119oIv41gHC3Op8sYOwoRwryfhGst1fZ1/sFMwWbVkU+Mya9D
         V/Aw==
X-Gm-Message-State: AC+VfDxcMbmOlMlhEZT/fj/7qs3mljFf6rPsZ89vI6z7FDgKAHRj8C9i
	27vEGQiP9gcYiEgyzAqG8rzq45E0zdc=
X-Google-Smtp-Source: ACHHUZ6ubv5SAI46LgQYM3rq2aMd/eU77d+5fQTD56vFciI6SvGfMNj113LSEuRbuZhUNICUfNWZdg==
X-Received: by 2002:a17:902:ce91:b0:1b6:68bb:6ad0 with SMTP id f17-20020a170902ce9100b001b668bb6ad0mr11035062plg.55.1687404213250;
        Wed, 21 Jun 2023 20:23:33 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:400::5:c6c4])
        by smtp.gmail.com with ESMTPSA id jw9-20020a170903278900b001b3f809e7e4sm4220596plb.36.2023.06.21.20.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 20:23:32 -0700 (PDT)
Date: Wed, 21 Jun 2023 20:23:30 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@fb.com, daniel@iogearbox.net,
	andrii@kernel.org, void@manifault.com, paulmck@kernel.org
Subject: Re: [PATCH bpf-next 11/12] bpf: Introduce bpf_mem_free_rcu() similar
 to kfree_rcu().
Message-ID: <20230622032330.3allcf7legl6vhp5@macbook-pro-8.dhcp.thefacebook.com>
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
 <20230621023238.87079-12-alexei.starovoitov@gmail.com>
 <eee33106-21ef-9f0b-86e7-137deefc6f50@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eee33106-21ef-9f0b-86e7-137deefc6f50@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 08:26:30PM +0800, Hou Tao wrote:
> >  	 */
> > -	rcu_barrier_tasks_trace();
> > +	rcu_barrier(); /* wait for __free_by_rcu() */
> > +	rcu_barrier_tasks_trace(); /* wait for __free_rcu() via call_rcu_tasks_trace */
> Using rcu_barrier_tasks_trace and rcu_barrier() is not enough, the
> objects in c->free_by_rcu_ttrace may be leaked as shown below. We may
> need to add an extra variable to notify __free_by_rcu() to free these
> elements directly instead of trying to move it into
> waiting_for_gp_ttrace as I did before. Or we can just drain
> free_by_rcu_ttrace twice.
> 
> destroy process       __free_by_rcu
> 
> llist_del_all(&c->free_by_rcu_ttrace)
> 
>                         // add to free_by_rcu_ttrace again
>                         llist_add_batch(..., &tgt->free_by_rcu_ttrace)
>                             do_call_rcu_ttrace()
>                                 // call_rcu_ttrace_in_progress is 1, so
> xchg return 1
>                                 // and it will not be moved to
> waiting_for_gp_ttrace
>                                
> atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)
> 
> // got 1
> atomic_read(&c->call_rcu_ttrace_in_progress)

The formatting is off, but I think I got the idea.
Yes. It's a race.

> >  				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
> > +				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
> I got a oops in rcu_tasks_invoke_cbs() during stressing test and it
> seems we should do atomic_read(&call_rcu_in_progress) first, then do
> atomic_read(&call_rcu_ttrace_in_progress) to fix the problem. And to

yes. it's a race. As you find out yourself changing the order won't fix it.

> The introduction of c->tgt make the destroy procedure more complicated.
> Even with the proposed fix above, there is still oops in
> rcu_tasks_invoke_cbs() and I think it happens as follows:

Right. That's another issue.

Please send bench htab test and your special stress test,
so we can have a common ground to reason about.
Also please share your bench htab numbers before/after.

I'm thinking to fix the races in the following way.
Could you please test it with your stress test?
The idea is to set 'draining' first everywhere that it will make all rcu
callbacks a nop.
Then drain all link lists. At this point nothing races with them.
And then wait for single rcu_barrier_tasks_trace() that will make sure
all callbcaks done. At this point the only thing they will do is
if (c->draining) goto out;
The barriers are needed to make 'c' access not uaf.

...

From e20782160166d4327c76b57af160c4973396e0d0 Mon Sep 17 00:00:00 2001
From: Alexei Starovoitov <ast@kernel.org>
Date: Wed, 21 Jun 2023 20:11:33 -0700
Subject: [PATCH bpf-next] bpf: Fix races.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 4d1002e7b4b5..75c553b15deb 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -99,6 +99,7 @@ struct bpf_mem_cache {
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
 	struct bpf_mem_cache *tgt;
+	bool draining;
 
 	/* list of objects to be freed after RCU GP */
 	struct llist_head free_by_rcu;
@@ -264,7 +265,10 @@ static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
 
+	if (unlikely(c->draining))
+		goto out;
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+out:
 	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
 }
 
@@ -353,8 +357,11 @@ static void __free_by_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
 	struct bpf_mem_cache *tgt = c->tgt;
-	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp);
+	struct llist_node *llnode;
 
+	if (unlikely(c->draining))
+		goto out;
+	llnode = llist_del_all(&c->waiting_for_gp);
 	if (!llnode)
 		goto out;
 
@@ -568,10 +575,9 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
 	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
 	 * using rcu_trace_implies_rcu_gp() as well.
 	 */
-	rcu_barrier(); /* wait for __free_by_rcu() */
-	rcu_barrier_tasks_trace(); /* wait for __free_rcu() via call_rcu_tasks_trace */
+	rcu_barrier_tasks_trace();
 	if (!rcu_trace_implies_rcu_gp())
-		rcu_barrier(); /* wait for __free_rcu() via call_rcu */
+		rcu_barrier();
 	free_mem_alloc_no_barrier(ma);
 }
 
@@ -616,6 +622,10 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 
 	if (ma->cache) {
 		rcu_in_progress = 0;
+		for_each_possible_cpu(cpu) {
+			c = per_cpu_ptr(ma->cache, cpu);
+			c->draining = true;
+		}
 		for_each_possible_cpu(cpu) {
 			c = per_cpu_ptr(ma->cache, cpu);
 			/*
@@ -639,6 +649,13 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 	}
 	if (ma->caches) {
 		rcu_in_progress = 0;
+		for_each_possible_cpu(cpu) {
+			cc = per_cpu_ptr(ma->caches, cpu);
+			for (i = 0; i < NUM_CACHES; i++) {
+				c = &cc->cache[i];
+				c->draining = true;
+			}
+		}
 		for_each_possible_cpu(cpu) {
 			cc = per_cpu_ptr(ma->caches, cpu);
 			for (i = 0; i < NUM_CACHES; i++) {
-- 
2.34.1


