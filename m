Return-Path: <bpf+bounces-2032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB9726E65
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 22:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3C0280D41
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 20:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256CD3734F;
	Wed,  7 Jun 2023 20:50:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286C35B30
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 20:50:26 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830C61FEA;
	Wed,  7 Jun 2023 13:50:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1b3836392so69066951fa.0;
        Wed, 07 Jun 2023 13:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686171018; x=1688763018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weUuKYmSwWcxsNM/CIKb+s3SATqcEOPMWtO22lxFnuQ=;
        b=sOkkV9tx18Ge7uyxs4jllSZ8TBAl/wYynnhR295IGoTY7PnAwoCPnD0KWQfEbieFOe
         qQIyW+ywy4l4sKQvfjkuyUD+PxLVD7rq2M7Onb7b0XtKDl51wvtR1ecosafo8+8BHMSU
         jGZMynUcQq/OwzxIowCml4oeqzbpv2FgO/2ByJOdm+ltbIKexElJDJ+pz2zA2YDko5CP
         FKTq6AgPVL3K69EGT3Mncjp8EyNjULldHh7C82cefdhymn2/cUzMp//WdQQlRGlUboAe
         2PFcEgGukebatGnafojis43e4WsdCRqLVWLGYpoOsTtHEZbvb7h4ABGNuq94iZsNqmyR
         6BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686171018; x=1688763018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weUuKYmSwWcxsNM/CIKb+s3SATqcEOPMWtO22lxFnuQ=;
        b=ZMx82Ji7BLy8yXioBwxa4qquGica+nKj3pqaupr3nk1DQBkSWGAd7bx/cHG56JjqoE
         veD59wYEGJv3rWq6slAedJ/ojDm7ufksKwL+0mJg0Jbn2jW+ZFKyJMpd1VGQmb6qRzN/
         4ymJRGObu/SK/cKlZX+rqwBwi/YHovKVneBUCsCy/3du5Yh+Pe9iOSgOd33kaYtszPIm
         yB+MGFpapNmI5QZWq/BJ96bqS3HPTdJMTWqLhGbyjaCWmLx81PfNdwdREZLA4TMYr7Mi
         M0Ge0BLHSPkheKLVdI8YpeZ3AmvCaNhFCMwuBQUMjQBQt+aAl50CeJKS/VWj1co1G1cO
         p85A==
X-Gm-Message-State: AC+VfDx0ZKE0Hl4unuyXq1v4hDftAxy454o59yR2kbHF/FHZdQ1ftVxs
	kB7wdmVYCjZ0xT5a9DXPuBqBONywbkF/LKxERXs=
X-Google-Smtp-Source: ACHHUZ6q06ZhPLd3BWOvO3msURp1IDFm8GG9eM80mVAF4s2CKqix9Q2D70oL21ofomtUqN1XMg4vvqYQSuQrZp54AWg=
X-Received: by 2002:a05:651c:90:b0:2ac:770f:8831 with SMTP id
 16-20020a05651c009000b002ac770f8831mr2387676ljq.40.1686171017240; Wed, 07 Jun
 2023 13:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com> <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
 <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com> <20230607175224.oqezpaztsb5hln2s@MacBook-Pro-8.local>
In-Reply-To: <20230607175224.oqezpaztsb5hln2s@MacBook-Pro-8.local>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Jun 2023 13:50:05 -0700
Message-ID: <CAADnVQJMM2ueRoDMmmBsxb_chPFr_WCH34tyiYQiwphnDhyuGw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory allocator
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	"houtao1@huawei.com" <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 7, 2023 at 10:52=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 07, 2023 at 04:42:11PM +0800, Hou Tao wrote:
> > As said in the commit message, the command line for test is
> > "./map_perf_test 4 8 16384", because the default max_entries is 1000. I=
f
> > using default max_entries and the number of CPUs is greater than 15,
> > use_percpu_counter will be false.
>
> Right. percpu or not depends on number of cpus.
>
> >
> > I have double checked my local VM setup (8 CPUs + 16GB) and rerun the
> > test.  For both "./map_perf_test 4 8" and "./map_perf_test 4 8 16384"
> > there are obvious performance degradation.
> ...
> > [root@hello bpf]# ./map_perf_test 4 8 16384
> > 2:hash_map_perf kmalloc 359201 events per sec
> ..
> > [root@hello bpf]# ./map_perf_test 4 8 16384
> > 4:hash_map_perf kmalloc 203983 events per sec
>
> this is indeed a degration in a VM.
>
> > I also run map_perf_test on a physical x86-64 host with 72 CPUs. The
> > performances for "./map_perf_test 4 8" are similar, but there is obviou=
s
> > performance degradation for "./map_perf_test 4 8 16384"
>
> but... a degradation?
>
> > Before reuse-after-rcu-gp:
> >
> > [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> > 1:hash_map_perf kmalloc 388088 events per sec
> ...
> > After reuse-after-rcu-gp:
> > [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> > 5:hash_map_perf kmalloc 655628 events per sec
>
> This is a big improvement :) Not a degration.
> You always have to double check the numbers with perf report.
>
> > So could you please double check your setup and rerun map_perf_test ? I=
f
> > there is no performance degradation, could you please share your setup
> > and your kernel configure file ?
>
> I'm testing on normal no-debug kernel. No kasan. No lockdep. HZ=3D1000
> Playing with it a bit more I found something interesting:
> map_perf_test 4 8 16348
> before/after has too much noise to be conclusive.
>
> So I did
> map_perf_test 4 8 16348 1000000
>
> and now I see significant degration from patch 3.
> It drops from 800k to 200k.
> And perf report confirms that heavy contention on sc->reuse_lock is the c=
ulprit.
> The following hack addresses most of the perf degradtion:
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index fea1cb0c78bb..eeadc9359097 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -188,7 +188,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_cac=
he *c, int cnt)
>         alloc =3D 0;
>         head =3D NULL;
>         tail =3D NULL;
> -       raw_spin_lock_irqsave(&sc->reuse_lock, flags);
> +       if (raw_spin_trylock_irqsave(&sc->reuse_lock, flags)) {
>         while (alloc < cnt) {
>                 obj =3D __llist_del_first(&sc->reuse_ready_head);
>                 if (obj) {
> @@ -206,6 +206,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_cac=
he *c, int cnt)
>                 alloc++;
>         }
>         raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> +       }
>
>         if (alloc) {
>                 if (IS_ENABLED(CONFIG_PREEMPT_RT))
> @@ -334,9 +335,11 @@ static void bpf_ma_add_to_reuse_ready_or_free(struct=
 bpf_mem_cache *c)
>                 sc->reuse_ready_tail =3D NULL;
>                 WARN_ON_ONCE(!llist_empty(&sc->wait_for_free));
>                 __llist_add_batch(head, tail, &sc->wait_for_free);
> +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
>                 call_rcu_tasks_trace(&sc->rcu, free_rcu);
> +       } else {
> +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
>         }
> -       raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
>  }
>
> It now drops from 800k to 450k.
> And perf report shows that both reuse is happening and slab is working ha=
rd to satisfy kmalloc/kfree.
> So we may consider per-cpu waiting_for_rcu_gp and per-bpf-ma waiting_for_=
rcu_task_trace_gp lists.

Sorry. per-cpu waiting_for_rcu_gp is what patch 3 does already.
I meant per-cpu reuse_ready and per-bpf-ma waiting_for_rcu_task_trace_gp.

Also noticed that the overhead of shared reuse_ready list
comes both from the contended lock and from cache misses
when one cpu pushes to the list after RCU GP and another
cpu removes.

Also low/batch/high watermark are all wrong in patch 3.
low=3D32 and high=3D96 makes no sense when it's not a single list.
I'm experimenting with 32 for all three heuristics.

Another thing I noticed that per-cpu prepare_reuse and free_by_rcu
are redundant.
unit_free() can push into free_by_rcu directly
then reuse_bulk() can fill it up with free_llist_extra and
move them into waiting_for_gp.

All these _tail optimizations are obscuring the code and make it hard
to notice these issues.

> For now I still prefer to see v5 with per-bpf-ma and no _tail optimizatio=
n.
>
> Answering your other email:
>
> > I see your point. I will continue to debug the memory usage difference
> > between v3 and v4.
>
> imo it's a waste of time to continue analyzing performance based on bench=
 in patch 2.
>
> > I don't think so. Let's considering the per-cpu list first. Assume the
> > normal RCU grace period is about 30ms and we are tracing the IO latency
> > of a normal SSD. The iops is about 176K per seconds, so before one RCU
> > GP is passed, we will need to allocate about 176 * 30 =3D 5.2K elements=
.
> > For the per-ma list, when the number of CPUs increased, it is easy to
> > make the list contain thousands of elements.
>
> That would be true only if there were no scheduling events in all of 176K=
 ops.
> Which is not the case.
> I'm not sure why you're saying that RCU GP is 30ms.
> In CONFIG_PREEMPT_NONE rcu_read_lock/unlock are true nops.
> Every sched event is sort-of implicit rcu_read_lock/unlock.
> Network and block IO doesn't process 176K packets without resched.
> Don't know how block does it, but in networking NAPI will process 64 pack=
ets and will yield softirq.
>
> For small size buckets low_watermark=3D32 and high=3D96.
> We typically move 32 elements at a time from one list to another.
> A bunch of elements maybe sitting in free_by_rcu and moving them to waiti=
ng_for_gp
> is not instant, but once __free_rcu_tasks_trace is called we need to take
> elements from waiting_for_gp one at a time and kfree it one at a time.
> So optimizing the move from free_by_rcu into waiting_for_gp is not worth =
the code complexity.
>
> > Before I post v5, I want to know the reason why per-bpf-ma list is
> >introduced. Previously, I though it was used to handle the case in which
> > allocation and freeing are done on different CPUs.
>
> Correct. per-bpf-ma list is necessary to avoid OOM-ing due to slow rcu_ta=
sks_trace GP.
>
> > And as we can see
> > from the benchmark result above and in v3, the performance and the
> > memory usage of v4 for add_del_on_diff_cpu is better than v3.
>
> bench from patch 2 is invalid. Hence no conclusion can be made.
>
> So far the only bench we can trust and analyze is map_perf_test.
> Please make bench in patch 2 yield the cpu after few updates.
> Earlier I suggested to stick to 10, but since NAPI can do 64 at a time.
> 64 updates is realistic too. A thousand is not.

