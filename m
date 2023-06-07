Return-Path: <bpf+bounces-2050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293CA7272E1
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4983B1C20F90
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CE03B40E;
	Wed,  7 Jun 2023 23:23:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541183B3E0
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 23:23:36 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C472109;
	Wed,  7 Jun 2023 16:23:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1af9ef7a9so72074671fa.1;
        Wed, 07 Jun 2023 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686180212; x=1688772212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cn7R2NSDc5QcbzciKPn39WoCJXF2t+mld1m96bcm0g=;
        b=m4Y2ONZ4xvrksz8LezE4Ccp0pYj3ciy5MeGwtkyy7GHCjGxDHd7F27cNW2yPWzDuJc
         fpmNckLyhto5QSyMlfcQNGT5DayxYjbgOhyHC2iKTQrr3mpr4K62JZCTuuc1Oi6Et9Py
         GlZ/IwuEYx3RGWOtpK4ewlOygcLma+gVzuIlExGoTPTHp3CINDxeZ+hNAVya310xvjXR
         sbKiN4SLgKN3Ha8CBZ6uiPS4cU/bhFHQZyRtxSJgo/SbI1R6TCLoCb6sk8/u57PXmthN
         6oGmH7gRRQHaC1YlTam9EtbiXUPPC0NfR8ehHJLRv7rx9by9gvpCL4rIodDGYiu3BwTU
         bHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686180212; x=1688772212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cn7R2NSDc5QcbzciKPn39WoCJXF2t+mld1m96bcm0g=;
        b=QJilUXFAX2g3VLYjLAxDqjiV/XJTuTdxjaTNuFc5R4JFg7BGxGerhA2AxG/0jz54/w
         kG4NT/+9YdVHoBOtbq4krqecsue2tORcK2mJGGDp3KOroLRiH89uckHP9QXTdylTUaGZ
         dADEEoYnRxaCdtd/vGX3mEIWOahRdA+G3KKSnwkORgEbSOr/2t/0tNdTgEjPi/JsS/uK
         bhTivZrvEooeF9gXQbAjBgRke9tUlgHjOfO/GeZIIoxLrSvU9oRkn0hDVOm0pTyLqejA
         6oZx9z4j0WnXcarQGrx0AGZvw1Zfjy4Zp+/dBLc0LyTuOlg6FfXHHudkokh2gSEpT04w
         2gdA==
X-Gm-Message-State: AC+VfDypEUo9wVbGjdnUlpTCSMUPI1EHTNbViWxr59NNZGJJ4p1mEHFr
	n1HjVudvzL/SPtZLjA2YWxMaBlhCuwOeIMWBmv4=
X-Google-Smtp-Source: ACHHUZ4bkejaAcqxUBPPzocHfqa+DULyATp2nN5DsGlt8zWUlEdZKdR5eu/7Elu0Q48hFiSKeF/O0PDWI1NT1ns/dAk=
X-Received: by 2002:a2e:6a17:0:b0:2ae:df5a:9651 with SMTP id
 f23-20020a2e6a17000000b002aedf5a9651mr2493503ljc.37.1686180212143; Wed, 07
 Jun 2023 16:23:32 -0700 (PDT)
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
In-Reply-To: <CAADnVQJMM2ueRoDMmmBsxb_chPFr_WCH34tyiYQiwphnDhyuGw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Jun 2023 16:23:20 -0700
Message-ID: <CAADnVQJ1njnHb96HfO4k48XDY9L3YXqQW1iUW=ti5iBNKKcE9A@mail.gmail.com>
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

On Wed, Jun 7, 2023 at 1:50=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 7, 2023 at 10:52=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jun 07, 2023 at 04:42:11PM +0800, Hou Tao wrote:
> > > As said in the commit message, the command line for test is
> > > "./map_perf_test 4 8 16384", because the default max_entries is 1000.=
 If
> > > using default max_entries and the number of CPUs is greater than 15,
> > > use_percpu_counter will be false.
> >
> > Right. percpu or not depends on number of cpus.
> >
> > >
> > > I have double checked my local VM setup (8 CPUs + 16GB) and rerun the
> > > test.  For both "./map_perf_test 4 8" and "./map_perf_test 4 8 16384"
> > > there are obvious performance degradation.
> > ...
> > > [root@hello bpf]# ./map_perf_test 4 8 16384
> > > 2:hash_map_perf kmalloc 359201 events per sec
> > ..
> > > [root@hello bpf]# ./map_perf_test 4 8 16384
> > > 4:hash_map_perf kmalloc 203983 events per sec
> >
> > this is indeed a degration in a VM.
> >
> > > I also run map_perf_test on a physical x86-64 host with 72 CPUs. The
> > > performances for "./map_perf_test 4 8" are similar, but there is obvi=
ous
> > > performance degradation for "./map_perf_test 4 8 16384"
> >
> > but... a degradation?
> >
> > > Before reuse-after-rcu-gp:
> > >
> > > [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> > > 1:hash_map_perf kmalloc 388088 events per sec
> > ...
> > > After reuse-after-rcu-gp:
> > > [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> > > 5:hash_map_perf kmalloc 655628 events per sec
> >
> > This is a big improvement :) Not a degration.
> > You always have to double check the numbers with perf report.
> >
> > > So could you please double check your setup and rerun map_perf_test ?=
 If
> > > there is no performance degradation, could you please share your setu=
p
> > > and your kernel configure file ?
> >
> > I'm testing on normal no-debug kernel. No kasan. No lockdep. HZ=3D1000
> > Playing with it a bit more I found something interesting:
> > map_perf_test 4 8 16348
> > before/after has too much noise to be conclusive.
> >
> > So I did
> > map_perf_test 4 8 16348 1000000
> >
> > and now I see significant degration from patch 3.
> > It drops from 800k to 200k.
> > And perf report confirms that heavy contention on sc->reuse_lock is the=
 culprit.
> > The following hack addresses most of the perf degradtion:
> >
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index fea1cb0c78bb..eeadc9359097 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -188,7 +188,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_c=
ache *c, int cnt)
> >         alloc =3D 0;
> >         head =3D NULL;
> >         tail =3D NULL;
> > -       raw_spin_lock_irqsave(&sc->reuse_lock, flags);
> > +       if (raw_spin_trylock_irqsave(&sc->reuse_lock, flags)) {
> >         while (alloc < cnt) {
> >                 obj =3D __llist_del_first(&sc->reuse_ready_head);
> >                 if (obj) {
> > @@ -206,6 +206,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_c=
ache *c, int cnt)
> >                 alloc++;
> >         }
> >         raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> > +       }
> >
> >         if (alloc) {
> >                 if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > @@ -334,9 +335,11 @@ static void bpf_ma_add_to_reuse_ready_or_free(stru=
ct bpf_mem_cache *c)
> >                 sc->reuse_ready_tail =3D NULL;
> >                 WARN_ON_ONCE(!llist_empty(&sc->wait_for_free));
> >                 __llist_add_batch(head, tail, &sc->wait_for_free);
> > +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> >                 call_rcu_tasks_trace(&sc->rcu, free_rcu);
> > +       } else {
> > +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> >         }
> > -       raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> >  }
> >
> > It now drops from 800k to 450k.
> > And perf report shows that both reuse is happening and slab is working =
hard to satisfy kmalloc/kfree.
> > So we may consider per-cpu waiting_for_rcu_gp and per-bpf-ma waiting_fo=
r_rcu_task_trace_gp lists.
>
> Sorry. per-cpu waiting_for_rcu_gp is what patch 3 does already.
> I meant per-cpu reuse_ready and per-bpf-ma waiting_for_rcu_task_trace_gp.

An update..

I tweaked patch 3 to do per-cpu reuse_ready and it addressed
the lock contention, but cache miss on
__llist_del_first(&c->reuse_ready_head);
was still very high and performance was still at 450k as
with a simple hack above.

Then I removed some of the _tail optimizations and added counters
to these llists.
To my surprise
map_perf_test 4 1 16348 1000000
was showing ~200k on average in waiting_for_gp when reuse_rcu() is called
and ~400k sitting in reuse_ready_head.

Then noticed that we should be doing:
call_rcu_hurry(&c->rcu, reuse_rcu);
instead of call_rcu(),
but my config didn't have RCU_LAZY, so that didn't help.
Obviously we cannot allow such a huge number of elements to sit
in these link lists.
The whole "reuse-after-rcu-gp" idea for bpf_mem_alloc may not work.
To unblock qp-trie work I suggest to add rcu_head to each inner node
and do call_rcu() on them before free-ing them to bpf_mem_alloc.
Explicit call_rcu would disqualify qp-tree from tracing programs though :(

