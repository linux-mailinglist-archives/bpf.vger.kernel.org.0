Return-Path: <bpf+bounces-5574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D76C75BC4D
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 04:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42293282110
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 02:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72062397;
	Fri, 21 Jul 2023 02:31:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DBB7F
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 02:31:38 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80119268E
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 19:31:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so2362986e87.3
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 19:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689906695; x=1690511495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrB28zrM2mzNSW0Drjg8ctDkmKFDil1Dy5FWlx3fxe8=;
        b=eeGs3M53tx68GNOhPFGXeW+pLuYyW6Bk9tU4hWay0Os2gAg96JeGphWH3ptjs/he21
         bjmSW5FnCSl4m0pZiv+cx527Vyrh7CEpf2RfoTJl1EBL/M2BhDL7Nl8n8Bn4ZR5S+uVo
         dM+1frFUQc2V1RApvsiRBC63oLYC+zqmFq/a6ADyDV24o7NojPF5/IOpw1l1JK7/Frfd
         ROiNKo6TbUEn5ipC41hf5tiHcCzJrjSbUyYKt+oo2EodeOIp561Q2sBTrdz9ZZJIXVCq
         +qdlULG/lsvJjKUe/kbJXv9tTpE819a1X0xh9q0zG5BaTgKyJE5IzPU9szSerr0y+p5d
         249g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689906695; x=1690511495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrB28zrM2mzNSW0Drjg8ctDkmKFDil1Dy5FWlx3fxe8=;
        b=kp9sxaz0OEq99jsr04zKWY6oGak1GbFOEJZH7Jd468qLaCzo0MmI0c2l38+Gf62Ztm
         Mo07OIaad4tCCrVzLlg56obikj7gAEvr3pkRRw9kG654VtLMUVQ4Qiz8FSk1HNLdrQdD
         g2rg5vdDLd85ESXx2gKPWDiwIaQ+9h1ouEuxyEpF72o2F6Wz7QHCpXJQwYkk9mx5tQsD
         F0mtdv878OKzbhrXjEH0CfyCa06kvdRbR61G4cNq8x2Qw3NYmxO6Fk2PgmTQDBi8le1E
         WeJZh3vR7xaeQ7RAF4qnJfx1PqWH7g+auMkS+gEvirvKSIqeF195cjDLW8uosiyfyoka
         A11Q==
X-Gm-Message-State: ABy/qLYDfkh+F/Gp3p9xRQrAIfUgmXJSFXI2ePbSO2B6fp3rPO3xKGRR
	vacXdffnIvuCcoCHIivxbwtJTcLEH0YLAArexK/Mkg==
X-Google-Smtp-Source: APBJJlFKDj6lvc98n8r/yWMDjTzfi//upOy9N8nt71v8FCirtJVAY0M55WPs5LoUrSHDgHBHVfI56Zpb3L4gnPjoPgE=
X-Received: by 2002:a2e:9b94:0:b0:2b9:344c:a214 with SMTP id
 z20-20020a2e9b94000000b002b9344ca214mr446531lji.42.1689906694629; Thu, 20 Jul
 2023 19:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689885610.git.zhuyifei@google.com> <d47f7d1c80b0eabfee89a0fc9ef75bbe3d1eced7.1689885610.git.zhuyifei@google.com>
 <0f90694e-308c-65e6-5360-a3d5dc7337b1@huaweicloud.com>
In-Reply-To: <0f90694e-308c-65e6-5360-a3d5dc7337b1@huaweicloud.com>
From: YiFei Zhu <zhuyifei@google.com>
Date: Thu, 20 Jul 2023 19:31:23 -0700
Message-ID: <CAA-VZPmhm3SoD+tX-xPSj6wuOvFg=uZoar0b=sgAyLRz=5n+2A@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf/memalloc: Non-atomically allocate freelist
 during prefill
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 6:45=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
> On 7/21/2023 4:44 AM, YiFei Zhu wrote:
> > Sometimes during prefill all precpu chunks are full and atomic
> > __alloc_percpu_gfp would not allocate new chunks. This will cause
> > -ENOMEM immediately upon next unit_alloc.
> >
> > Prefill phase does not actually run in atomic context, so we can
> > use this fact to allocate non-atomically with GFP_KERNEL instead
> > of GFP_NOWAIT. This avoids the immediate -ENOMEM. Unfortunately
> > unit_alloc runs in atomic context, even from map item allocation in
> > syscalls, due to rcu_read_lock, so we can't do non-atomic
> > workarounds in unit_alloc.
> >
> > Fixes: 4ab67149f3c6 ("bpf: Add percpu allocation support to bpf_mem_all=
oc.")
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>
> Make sense to me, so
>
> Acked-by: Hou Tao <houtao1@huawei.com>
>
> But I don't know whether or not it is suitable for bpf tree.

I don't mind either way :) If changing to bpf-next requires a resend I
can do that too.

YiFei Zhu

> > ---
> >  kernel/bpf/memalloc.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index 0668bcd7c926..016249672b43 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -154,13 +154,17 @@ static struct mem_cgroup *get_memcg(const struct =
bpf_mem_cache *c)
> >  }
> >
> >  /* Mostly runs from irq_work except __init phase. */
> > -static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
> > +static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, boo=
l atomic)
> >  {
> >       struct mem_cgroup *memcg =3D NULL, *old_memcg;
> >       unsigned long flags;
> > +     gfp_t gfp;
> >       void *obj;
> >       int i;
> >
> > +     gfp =3D __GFP_NOWARN | __GFP_ACCOUNT;
> > +     gfp |=3D atomic ? GFP_NOWAIT : GFP_KERNEL;
> > +
> >       memcg =3D get_memcg(c);
> >       old_memcg =3D set_active_memcg(memcg);
> >       for (i =3D 0; i < cnt; i++) {
> > @@ -183,7 +187,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int=
 cnt, int node)
> >                        * will allocate from the current numa node which=
 is what we
> >                        * want here.
> >                        */
> > -                     obj =3D __alloc(c, node, GFP_NOWAIT | __GFP_NOWAR=
N | __GFP_ACCOUNT);
> > +                     obj =3D __alloc(c, node, gfp);
> >                       if (!obj)
> >                               break;
> >               }
> > @@ -321,7 +325,7 @@ static void bpf_mem_refill(struct irq_work *work)
> >               /* irq_work runs on this cpu and kmalloc will allocate
> >                * from the current numa node which is what we want here.
> >                */
> > -             alloc_bulk(c, c->batch, NUMA_NO_NODE);
> > +             alloc_bulk(c, c->batch, NUMA_NO_NODE, true);
> >       else if (cnt > c->high_watermark)
> >               free_bulk(c);
> >  }
> > @@ -367,7 +371,7 @@ static void prefill_mem_cache(struct bpf_mem_cache =
*c, int cpu)
> >        * prog won't be doing more than 4 map_update_elem from
> >        * irq disabled region
> >        */
> > -     alloc_bulk(c, c->unit_size <=3D 256 ? 4 : 1, cpu_to_node(cpu));
> > +     alloc_bulk(c, c->unit_size <=3D 256 ? 4 : 1, cpu_to_node(cpu), fa=
lse);
> >  }
> >
> >  /* When size !=3D 0 bpf_mem_cache for each cpu.
>

