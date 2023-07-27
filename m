Return-Path: <bpf+bounces-6109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E7C76604C
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333551C2171F
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 23:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DBF1ED43;
	Thu, 27 Jul 2023 23:47:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D8198B8
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:47:08 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D722D71
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 16:47:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31297125334so1034781f8f.0
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 16:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690501625; x=1691106425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KgEnGFr2T55GlVB0I3RbvsVVrS4wBzQAzIxNmwiL7Y=;
        b=hrP6mOKJ6Yaz4HERZWU/Ncau7JTPH6+iUNE1LYZndNP2J59JkebdqSsbQIQqYPYK/O
         rrIajqKwx91NY2/oMay02yEoD3O3LP6UdkoSe54KaSekwiC/Fa5ZB5SzIqIcl9mik8Jh
         kjwIIOKprxJozaQTja89gDqOb/N6p+OZj1WxVM1dsm7V7+QUIfro59O7klY4ZrFDLoNn
         1g0pKgt59RMqg9TT7kCMx5d/TtAUfUY9IospLtHClXzabAUPITVuuUif0ije4/bEhdfw
         ts5Cg4gC3XjPToU1vX3ZF82mpAOPStGdW8zEOArw2JnOl9TkXYqh8KfDSVRA1/SKlbVp
         InuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690501625; x=1691106425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KgEnGFr2T55GlVB0I3RbvsVVrS4wBzQAzIxNmwiL7Y=;
        b=Z2JY5zAXdCLFYWRJGr6vwsyPcJ8WOJCV+HtAZuLIywPRvgG4OJa9g65BjZMjf3HGpR
         /KWKteRqzkN4nHbGh+r/Nc2C6KkG8Gk+EL9YCXSSEe9qp5iwhsTIqt9rJjZlXD1/Jiq6
         OClHpAEinjjgKaWg5OWKcZdoBz6Wg22Oq9K1NWGvxlgdwFjUFJ2zcxgnzpZcaUtV+Tn3
         YVeVKIP1D6pE/5tndCGDt4Ggb3sJBOdvVorITwO7B6c4BSUojAX3QZA2ixJ0SFpyKRSE
         FqET4M8ql+s0934XMCQLVZCvscEXSuTXuRIxtD1TCRn/dvXYO6qoLaQ/wo4gBn8G8v9Y
         Frcg==
X-Gm-Message-State: ABy/qLazPH7nsFJwTDsTtk/wJ/ytEOtztCb2D8HkO+twgsOK8zlKlxDU
	ojr7fC/jsZkFNR7p4UGYBm8wx2qDaLhQHBkDNSE1kA==
X-Google-Smtp-Source: APBJJlHTNghEByNN54G8dCEQ4zSfbOQrZZlkjxwKWUn+NHpuNSRG9fZD55MqSzRMf0sSJ4zOmlMB4i3L/HQAJabDUyA=
X-Received: by 2002:adf:f2c2:0:b0:314:1f0:5846 with SMTP id
 d2-20020adff2c2000000b0031401f05846mr2842239wrp.19.1690501625310; Thu, 27 Jul
 2023 16:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727201809.3232201-1-zhuyifei@google.com> <faf7fbeb-b35f-5b38-2be2-c863f939acb8@linux.dev>
In-Reply-To: <faf7fbeb-b35f-5b38-2be2-c863f939acb8@linux.dev>
From: YiFei Zhu <zhuyifei@google.com>
Date: Thu, 27 Jul 2023 16:46:54 -0700
Message-ID: <CAA-VZPnXzMdufpfkRFWWY5acWgeA+D7mbJ=zduEmMFLu6DfjDQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf/memalloc: Non-atomically allocate
 freelist during prefill
To: yonghong.song@linux.dev
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 2:59=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 7/27/23 1:18 PM, YiFei Zhu wrote:
> > In internal testing of test_maps, we sometimes observed failures like:
> >    test_maps: test_maps.c:173: void test_hashmap_percpu(unsigned int, v=
oid *):
> >      Assertion `bpf_map_update_elem(fd, &key, value, BPF_ANY) =3D=3D 0'=
 failed.
> > where the errno is ENOMEM. After some troubleshooting and enabling
> > the warnings, we saw:
> >    [   91.304708] percpu: allocation failed, size=3D8 align=3D8 atomic=
=3D1, atomic alloc failed, no space left
> >    [   91.304716] CPU: 51 PID: 24145 Comm: test_maps Kdump: loaded Tain=
ted: G                 N 6.1.38-smp-DEV #7
> >    [   91.304719] Hardware name: Google Astoria/astoria, BIOS 0.2023062=
7.0-0 06/27/2023
> >    [   91.304721] Call Trace:
> >    [   91.304724]  <TASK>
> >    [   91.304730]  [<ffffffffa7ef83b9>] dump_stack_lvl+0x59/0x88
> >    [   91.304737]  [<ffffffffa7ef83f8>] dump_stack+0x10/0x18
> >    [   91.304738]  [<ffffffffa75caa0c>] pcpu_alloc+0x6fc/0x870
> >    [   91.304741]  [<ffffffffa75ca302>] __alloc_percpu_gfp+0x12/0x20
> >    [   91.304743]  [<ffffffffa756785e>] alloc_bulk+0xde/0x1e0
> >    [   91.304746]  [<ffffffffa7566c02>] bpf_mem_alloc_init+0xd2/0x2f0
> >    [   91.304747]  [<ffffffffa7547c69>] htab_map_alloc+0x479/0x650
> >    [   91.304750]  [<ffffffffa751d6e0>] map_create+0x140/0x2e0
> >    [   91.304752]  [<ffffffffa751d413>] __sys_bpf+0x5a3/0x6c0
> >    [   91.304753]  [<ffffffffa751c3ec>] __x64_sys_bpf+0x1c/0x30
> >    [   91.304754]  [<ffffffffa7ef847a>] do_syscall_64+0x5a/0x80
> >    [   91.304756]  [<ffffffffa800009b>] entry_SYSCALL_64_after_hwframe+=
0x63/0xcd
> >
> > This makes sense, because in atomic context, percpu allocation would
> > not create new chunks; it would only create in non-atomic contexts.
> > And if during prefill all precpu chunks are full, -ENOMEM would
> > happen immediately upon next unit_alloc.
> >
> > Prefill phase does not actually run in atomic context, so we can
> > use this fact to allocate non-atomically with GFP_KERNEL instead
> > of GFP_NOWAIT. This avoids the immediate -ENOMEM.
> >
> > Unfortunately unit_alloc runs in atomic context, even from map
> > item allocation in syscalls, due to rcu_read_lock, so we can't do
> > non-atomic workarounds in unit_alloc.
>
> The above description is not clear to me. Do you mean
>    GFP_NOWAIT has to be used in unit_alloc when bpf program runs
>    in atomic context. Even if bpf program runs in non-atomic context,
>    in most cases, rcu read lock is enabled for the program so
>    GFP_NOWAIT is still needed.

I actually meant that in syscall BPF_MAP_UPDATE_ELEM, at least in the
case of hashmap_percpu the code path is rcu read locked, so one cannot
do non-atomic allocations even from syscalls. Hmm, shall I I change it
to something like this?

   GFP_NOWAIT has to be used in unit_alloc when bpf program runs
   in atomic context. Even if bpf program runs in non-atomic context,
   in most cases, rcu read lock is enabled for the program so
   GFP_NOWAIT is still needed. This is often also the case for
   BPF_MAP_UPDATE_ELEM syscalls.

> The exception is sleepable bpf program in non-atomic context,
> e.g., sleepable bpf_iter program, sleepable fentry program
> in non-atomic context, and the unit_alloc is not inside
> bpf_rcu_read_lock kfunc. But this is too complicated and
> probably not worthwhile to special-case it.

Ack.

>
> >
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> > v1->v2:
> > - Rebase from bpf to bpf-next
> > - Dropped second patch and edited commit message to include parts
> >    of original cover letter, and dropped Fixes tag
> > ---
> >   kernel/bpf/memalloc.c | 12 ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index 14d9b1a9a4ca..9c49ae53deaf 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -201,12 +201,16 @@ static void add_obj_to_free_list(struct bpf_mem_c=
ache *c, void *obj)
> >   }
> >
> >   /* Mostly runs from irq_work except __init phase. */
> > -static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
> > +static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, boo=
l atomic)
> >   {
> >       struct mem_cgroup *memcg =3D NULL, *old_memcg;
> > +     gfp_t gfp;
> >       void *obj;
> >       int i;
> >
> > +     gfp =3D __GFP_NOWARN | __GFP_ACCOUNT;
> > +     gfp |=3D atomic ? GFP_NOWAIT : GFP_KERNEL;
> > +
> >       for (i =3D 0; i < cnt; i++) {
> >               /*
> >                * For every 'c' llist_del_first(&c->free_by_rcu_ttrace);=
 is
> > @@ -238,7 +242,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int=
 cnt, int node)
> >                * will allocate from the current numa node which is what=
 we
> >                * want here.
> >                */
> > -             obj =3D __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GF=
P_ACCOUNT);
> > +             obj =3D __alloc(c, node, gfp);
> >               if (!obj)
> >                       break;
> >               add_obj_to_free_list(c, obj);
> > @@ -429,7 +433,7 @@ static void bpf_mem_refill(struct irq_work *work)
> >               /* irq_work runs on this cpu and kmalloc will allocate
> >                * from the current numa node which is what we want here.
> >                */
> > -             alloc_bulk(c, c->batch, NUMA_NO_NODE);
> > +             alloc_bulk(c, c->batch, NUMA_NO_NODE, true);
> >       else if (cnt > c->high_watermark)
> >               free_bulk(c);
> >
> > @@ -477,7 +481,7 @@ static void prefill_mem_cache(struct bpf_mem_cache =
*c, int cpu)
> >        * prog won't be doing more than 4 map_update_elem from
> >        * irq disabled region
> >        */
> > -     alloc_bulk(c, c->unit_size <=3D 256 ? 4 : 1, cpu_to_node(cpu));
> > +     alloc_bulk(c, c->unit_size <=3D 256 ? 4 : 1, cpu_to_node(cpu), fa=
lse);
> >   }
> >
> >   /* When size !=3D 0 bpf_mem_cache for each cpu.

