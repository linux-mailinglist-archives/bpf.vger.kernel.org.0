Return-Path: <bpf+bounces-2052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3869727352
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32C32815A5
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF63A3B417;
	Wed,  7 Jun 2023 23:50:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D23B3E0
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 23:50:51 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2862E211C;
	Wed,  7 Jun 2023 16:50:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af189d323fso14247171fa.1;
        Wed, 07 Jun 2023 16:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686181847; x=1688773847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEr4wrDjFQ6sDkdcqHvWRVLsCBEZ4ymCDo8zHgNh2K8=;
        b=eep/DyuC5fPgaLBEetUQ9DiD6u0dJC9nqeJxBig6+N2CpWAIQ792RoYUf8K59nWGYQ
         MEJNtKBzJd7L6FCJeoOGqUucZF3NqLU/ON+MW9z/sQCYA5WNMO29n5RxgVSro65wg/TM
         AAlaBmRuqkA3HwtU+bBHfrHDGNCLtIZdgZdKSS6K2TVssQfzFSEdfTB0INtgPxeJjGic
         p/p+HVOmLVQTZtkvrmhgS6iWhl5TVeJMsfsCrTT7tNAbNxnfGNE9qqacz/vAarezmqo8
         cBBUbo3QzP7N4Zn8heWzQzEbeNw+86UscJpJbV5LHjCQxZEiz3YHYX8dFhH5zMJjQDHD
         gPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181847; x=1688773847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEr4wrDjFQ6sDkdcqHvWRVLsCBEZ4ymCDo8zHgNh2K8=;
        b=T3HipdEuzL04vb2fCGZiUUqbym+3THrbKtjfnmVnnwPiYvoDdZeYOsNaVMgOG6awuM
         pbk2bwiWwTN19ZEBKcT4wuk1YkjLYHyDrUY84kTKDoBvNT7qC7Gg+fRgn6NPvcaMTNng
         SFK8D8h5urYfeEJg1x4OCvi6ra59yiIZjgj2m2Ot3sm0mQ7sPXBT1zFQJHuwyxih/zVu
         x7z+SZockhoAsxLk+G3zCjo6e89NRdgJvT8NeavdznR63u/NrtmHojy1ZkBgKauw5txJ
         9aT3dz+h6oiqzWQbNYaWHkhh3EbW3cONanbUpmjP8gZ6vLS8pOWnjrohz9UIz8msqWCu
         cKGQ==
X-Gm-Message-State: AC+VfDymulRpZEsWq3+d/pw4yWQyu41NqPlrK2Jx27UiRBBNXDL1FzTH
	6VJsiqfG3z1sLltW2Sorgnv9StXKeo6rFe5sLfw=
X-Google-Smtp-Source: ACHHUZ4J10LsS6igfBZ2IWr1pMyqg3fOnXRWGmE23k8xLcOlVkklFlvymaWhD/dRZFEUY2ZokOfrlKZlXKnUOO2Knx0=
X-Received: by 2002:a2e:6806:0:b0:2af:332e:3039 with SMTP id
 c6-20020a2e6806000000b002af332e3039mr149261lja.11.1686181846977; Wed, 07 Jun
 2023 16:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com> <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
 <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com> <20230607175224.oqezpaztsb5hln2s@MacBook-Pro-8.local>
 <CAADnVQJMM2ueRoDMmmBsxb_chPFr_WCH34tyiYQiwphnDhyuGw@mail.gmail.com>
 <CAADnVQJ1njnHb96HfO4k48XDY9L3YXqQW1iUW=ti5iBNKKcE9A@mail.gmail.com> <55f5e64d-9d9e-4c65-8d1b-8fd4684ee9a3@paulmck-laptop>
In-Reply-To: <55f5e64d-9d9e-4c65-8d1b-8fd4684ee9a3@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Jun 2023 16:50:35 -0700
Message-ID: <CAADnVQLps=4CjVbZN6wfFWS9VnPE=1b4Gqmw-uPeH5=hGn_xwQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory allocator
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, rcu@vger.kernel.org, 
	"houtao1@huawei.com" <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 7, 2023 at 4:30=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Wed, Jun 07, 2023 at 04:23:20PM -0700, Alexei Starovoitov wrote:
> > On Wed, Jun 7, 2023 at 1:50=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Jun 7, 2023 at 10:52=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Jun 07, 2023 at 04:42:11PM +0800, Hou Tao wrote:
> > > > > As said in the commit message, the command line for test is
> > > > > "./map_perf_test 4 8 16384", because the default max_entries is 1=
000. If
> > > > > using default max_entries and the number of CPUs is greater than =
15,
> > > > > use_percpu_counter will be false.
> > > >
> > > > Right. percpu or not depends on number of cpus.
> > > >
> > > > >
> > > > > I have double checked my local VM setup (8 CPUs + 16GB) and rerun=
 the
> > > > > test.  For both "./map_perf_test 4 8" and "./map_perf_test 4 8 16=
384"
> > > > > there are obvious performance degradation.
> > > > ...
> > > > > [root@hello bpf]# ./map_perf_test 4 8 16384
> > > > > 2:hash_map_perf kmalloc 359201 events per sec
> > > > ..
> > > > > [root@hello bpf]# ./map_perf_test 4 8 16384
> > > > > 4:hash_map_perf kmalloc 203983 events per sec
> > > >
> > > > this is indeed a degration in a VM.
> > > >
> > > > > I also run map_perf_test on a physical x86-64 host with 72 CPUs. =
The
> > > > > performances for "./map_perf_test 4 8" are similar, but there is =
obvious
> > > > > performance degradation for "./map_perf_test 4 8 16384"
> > > >
> > > > but... a degradation?
> > > >
> > > > > Before reuse-after-rcu-gp:
> > > > >
> > > > > [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> > > > > 1:hash_map_perf kmalloc 388088 events per sec
> > > > ...
> > > > > After reuse-after-rcu-gp:
> > > > > [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> > > > > 5:hash_map_perf kmalloc 655628 events per sec
> > > >
> > > > This is a big improvement :) Not a degration.
> > > > You always have to double check the numbers with perf report.
> > > >
> > > > > So could you please double check your setup and rerun map_perf_te=
st ? If
> > > > > there is no performance degradation, could you please share your =
setup
> > > > > and your kernel configure file ?
> > > >
> > > > I'm testing on normal no-debug kernel. No kasan. No lockdep. HZ=3D1=
000
> > > > Playing with it a bit more I found something interesting:
> > > > map_perf_test 4 8 16348
> > > > before/after has too much noise to be conclusive.
> > > >
> > > > So I did
> > > > map_perf_test 4 8 16348 1000000
> > > >
> > > > and now I see significant degration from patch 3.
> > > > It drops from 800k to 200k.
> > > > And perf report confirms that heavy contention on sc->reuse_lock is=
 the culprit.
> > > > The following hack addresses most of the perf degradtion:
> > > >
> > > > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > > > index fea1cb0c78bb..eeadc9359097 100644
> > > > --- a/kernel/bpf/memalloc.c
> > > > +++ b/kernel/bpf/memalloc.c
> > > > @@ -188,7 +188,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_m=
em_cache *c, int cnt)
> > > >         alloc =3D 0;
> > > >         head =3D NULL;
> > > >         tail =3D NULL;
> > > > -       raw_spin_lock_irqsave(&sc->reuse_lock, flags);
> > > > +       if (raw_spin_trylock_irqsave(&sc->reuse_lock, flags)) {
> > > >         while (alloc < cnt) {
> > > >                 obj =3D __llist_del_first(&sc->reuse_ready_head);
> > > >                 if (obj) {
> > > > @@ -206,6 +206,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_m=
em_cache *c, int cnt)
> > > >                 alloc++;
> > > >         }
> > > >         raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> > > > +       }
> > > >
> > > >         if (alloc) {
> > > >                 if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > > @@ -334,9 +335,11 @@ static void bpf_ma_add_to_reuse_ready_or_free(=
struct bpf_mem_cache *c)
> > > >                 sc->reuse_ready_tail =3D NULL;
> > > >                 WARN_ON_ONCE(!llist_empty(&sc->wait_for_free));
> > > >                 __llist_add_batch(head, tail, &sc->wait_for_free);
> > > > +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> > > >                 call_rcu_tasks_trace(&sc->rcu, free_rcu);
> > > > +       } else {
> > > > +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> > > >         }
> > > > -       raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> > > >  }
> > > >
> > > > It now drops from 800k to 450k.
> > > > And perf report shows that both reuse is happening and slab is work=
ing hard to satisfy kmalloc/kfree.
> > > > So we may consider per-cpu waiting_for_rcu_gp and per-bpf-ma waitin=
g_for_rcu_task_trace_gp lists.
> > >
> > > Sorry. per-cpu waiting_for_rcu_gp is what patch 3 does already.
> > > I meant per-cpu reuse_ready and per-bpf-ma waiting_for_rcu_task_trace=
_gp.
> >
> > An update..
> >
> > I tweaked patch 3 to do per-cpu reuse_ready and it addressed
> > the lock contention, but cache miss on
> > __llist_del_first(&c->reuse_ready_head);
> > was still very high and performance was still at 450k as
> > with a simple hack above.
> >
> > Then I removed some of the _tail optimizations and added counters
> > to these llists.
> > To my surprise
> > map_perf_test 4 1 16348 1000000
> > was showing ~200k on average in waiting_for_gp when reuse_rcu() is call=
ed
> > and ~400k sitting in reuse_ready_head.
> >
> > Then noticed that we should be doing:
> > call_rcu_hurry(&c->rcu, reuse_rcu);
> > instead of call_rcu(),
> > but my config didn't have RCU_LAZY, so that didn't help.
> > Obviously we cannot allow such a huge number of elements to sit
> > in these link lists.
> > The whole "reuse-after-rcu-gp" idea for bpf_mem_alloc may not work.
> > To unblock qp-trie work I suggest to add rcu_head to each inner node
> > and do call_rcu() on them before free-ing them to bpf_mem_alloc.
> > Explicit call_rcu would disqualify qp-tree from tracing programs though=
 :(
>
> I am sure that you guys have already considered and discarded this one,
> but I cannot help but suggest SLAB_TYPESAFE_BY_RCU.

SLAB_TYPESAFE_BY_RCU is what bpf_mem_alloc is doing right now.
We want to add an option to make it not do it and instead observe RCU GP
for every element freed via bpf_mem_free().
In other words, make bpf_mem_free() behave like kfree_rcu.
I just tried to use rcu_expedite_gp() before bpf prog runs
and it helps a bit.

