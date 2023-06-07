Return-Path: <bpf+bounces-2009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F87267CB
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 19:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16DE1C20E79
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D980738CCA;
	Wed,  7 Jun 2023 17:52:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411D1772E
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 17:52:30 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8728319BB;
	Wed,  7 Jun 2023 10:52:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b2439e9004so8128165ad.3;
        Wed, 07 Jun 2023 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686160348; x=1688752348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/7wVi2PQeb70vtjxUPsGGvKTtWbtq1CFy2L95Et03FM=;
        b=lo/6968jtYZvvFV4f2s0rafTXPDJVzRApYBRh0wPyFkPicUakIryIwSBe5QL1vfwlw
         bxHP85c30HSoiSgchEwENK2hPXnM0nWI85CVnTgS+1o/MGLyZSJkH9qpw/WILqnXPDjS
         ocri8qx+iV4negQAjTgmQF5vUOFYqCWk5IZJUBrERkalqN0GeCm+kLEWEn8aFamLsZlA
         lA0mgHEJfrjwQemfQQtqA/LM4EYqQoshq+BhyT+dNYvCrJEIC/PVQK1XxNzspc/rxA/P
         uq4oDN3EVbLo3WpR+szXr2lxNqMvUcKO9F7MAX46vjLrhOHUH5mZluScCGjIdr8niyy6
         HR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686160348; x=1688752348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7wVi2PQeb70vtjxUPsGGvKTtWbtq1CFy2L95Et03FM=;
        b=gSp8R9KV8zOW9oY942SnqnzVj+hezlKxxcS5yy1y/dGZDcaSI4HifzaRC/E+OMxHTX
         bEEYbKlaecSUogxFdooCfm+2xa/fI4Hsh9lMOEXa1O5VQU2EflWn/m5sJSBxfpswzPbQ
         SjnKcPe5a3DHDjHlmsF1fz5Ijs9fO2PCyuDlCatFu/Y8xJvjEx7dk/uBGISlLBuxkXV+
         9G9yMI9t9ipVtFlEKvSfesNmchpNs93CBwTuCSBxX5L3tjp5wOcwOOmvM0mYScAFhoY/
         dqTjIdqvtxJCFnvmCwNu1IPyXeNwYaZViD0rVuvjvMXDouBEQPSBriBLEsscl4NJN456
         YHuw==
X-Gm-Message-State: AC+VfDxC96J08Tfy8ShLJ9Hzm53RBvyS3TMFa9aYN5/fJCfsQCKuvVV6
	d5TzVbOZSC6VmHr7r06SdJI=
X-Google-Smtp-Source: ACHHUZ4mxC/zXoB6RQXHQWVTuJMCKrlaiJLr3pRGbH4Yfo2bZxe/mnoWfdx2twWuKzhcRwEakwTVPA==
X-Received: by 2002:a17:902:ea0e:b0:1b0:3576:c2a9 with SMTP id s14-20020a170902ea0e00b001b03576c2a9mr2849066plg.33.1686160347714;
        Wed, 07 Jun 2023 10:52:27 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:500::6:1c96])
        by smtp.gmail.com with ESMTPSA id ix3-20020a170902f80300b001ab01598f40sm2186085plb.173.2023.06.07.10.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:52:27 -0700 (PDT)
Date: Wed, 7 Jun 2023 10:52:24 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	"houtao1@huawei.com" <houtao1@huawei.com>
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory
 allocator
Message-ID: <20230607175224.oqezpaztsb5hln2s@MacBook-Pro-8.local>
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com>
 <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
 <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 07, 2023 at 04:42:11PM +0800, Hou Tao wrote:
> As said in the commit message, the command line for test is
> "./map_perf_test 4 8 16384", because the default max_entries is 1000. If
> using default max_entries and the number of CPUs is greater than 15,
> use_percpu_counter will be false.

Right. percpu or not depends on number of cpus.

> 
> I have double checked my local VM setup (8 CPUs + 16GB) and rerun the
> test.  For both "./map_perf_test 4 8" and "./map_perf_test 4 8 16384"
> there are obvious performance degradation.
...
> [root@hello bpf]# ./map_perf_test 4 8 16384
> 2:hash_map_perf kmalloc 359201 events per sec
..
> [root@hello bpf]# ./map_perf_test 4 8 16384
> 4:hash_map_perf kmalloc 203983 events per sec

this is indeed a degration in a VM.

> I also run map_perf_test on a physical x86-64 host with 72 CPUs. The
> performances for "./map_perf_test 4 8" are similar, but there is obvious
> performance degradation for "./map_perf_test 4 8 16384"

but... a degradation?

> Before reuse-after-rcu-gp:
>
> [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> 1:hash_map_perf kmalloc 388088 events per sec
...
> After reuse-after-rcu-gp:
> [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> 5:hash_map_perf kmalloc 655628 events per sec

This is a big improvement :) Not a degration.
You always have to double check the numbers with perf report.

> So could you please double check your setup and rerun map_perf_test ? If
> there is no performance degradation, could you please share your setup
> and your kernel configure file ?

I'm testing on normal no-debug kernel. No kasan. No lockdep. HZ=1000
Playing with it a bit more I found something interesting:
map_perf_test 4 8 16348
before/after has too much noise to be conclusive.

So I did
map_perf_test 4 8 16348 1000000

and now I see significant degration from patch 3.
It drops from 800k to 200k.
And perf report confirms that heavy contention on sc->reuse_lock is the culprit.
The following hack addresses most of the perf degradtion:

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index fea1cb0c78bb..eeadc9359097 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -188,7 +188,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_cache *c, int cnt)
        alloc = 0;
        head = NULL;
        tail = NULL;
-       raw_spin_lock_irqsave(&sc->reuse_lock, flags);
+       if (raw_spin_trylock_irqsave(&sc->reuse_lock, flags)) {
        while (alloc < cnt) {
                obj = __llist_del_first(&sc->reuse_ready_head);
                if (obj) {
@@ -206,6 +206,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_cache *c, int cnt)
                alloc++;
        }
        raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
+       }

        if (alloc) {
                if (IS_ENABLED(CONFIG_PREEMPT_RT))
@@ -334,9 +335,11 @@ static void bpf_ma_add_to_reuse_ready_or_free(struct bpf_mem_cache *c)
                sc->reuse_ready_tail = NULL;
                WARN_ON_ONCE(!llist_empty(&sc->wait_for_free));
                __llist_add_batch(head, tail, &sc->wait_for_free);
+               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
                call_rcu_tasks_trace(&sc->rcu, free_rcu);
+       } else {
+               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
        }
-       raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
 }

It now drops from 800k to 450k.
And perf report shows that both reuse is happening and slab is working hard to satisfy kmalloc/kfree.
So we may consider per-cpu waiting_for_rcu_gp and per-bpf-ma waiting_for_rcu_task_trace_gp lists.
For now I still prefer to see v5 with per-bpf-ma and no _tail optimization.

Answering your other email:

> I see your point. I will continue to debug the memory usage difference
> between v3 and v4.

imo it's a waste of time to continue analyzing performance based on bench in patch 2.

> I don't think so. Let's considering the per-cpu list first. Assume the
> normal RCU grace period is about 30ms and we are tracing the IO latency
> of a normal SSD. The iops is about 176K per seconds, so before one RCU
> GP is passed, we will need to allocate about 176 * 30 = 5.2K elements.
> For the per-ma list, when the number of CPUs increased, it is easy to
> make the list contain thousands of elements.

That would be true only if there were no scheduling events in all of 176K ops.
Which is not the case.
I'm not sure why you're saying that RCU GP is 30ms.
In CONFIG_PREEMPT_NONE rcu_read_lock/unlock are true nops.
Every sched event is sort-of implicit rcu_read_lock/unlock.
Network and block IO doesn't process 176K packets without resched.
Don't know how block does it, but in networking NAPI will process 64 packets and will yield softirq.

For small size buckets low_watermark=32 and high=96.
We typically move 32 elements at a time from one list to another.
A bunch of elements maybe sitting in free_by_rcu and moving them to waiting_for_gp
is not instant, but once __free_rcu_tasks_trace is called we need to take
elements from waiting_for_gp one at a time and kfree it one at a time.
So optimizing the move from free_by_rcu into waiting_for_gp is not worth the code complexity.

> Before I post v5, I want to know the reason why per-bpf-ma list is
>introduced. Previously, I though it was used to handle the case in which
> allocation and freeing are done on different CPUs. 

Correct. per-bpf-ma list is necessary to avoid OOM-ing due to slow rcu_tasks_trace GP.

> And as we can see
> from the benchmark result above and in v3, the performance and the
> memory usage of v4 for add_del_on_diff_cpu is better than v3. 

bench from patch 2 is invalid. Hence no conclusion can be made.

So far the only bench we can trust and analyze is map_perf_test.
Please make bench in patch 2 yield the cpu after few updates.
Earlier I suggested to stick to 10, but since NAPI can do 64 at a time.
64 updates is realistic too. A thousand is not.

