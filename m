Return-Path: <bpf+bounces-41023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C1A99117B
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9551F23D67
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02398146D76;
	Fri,  4 Oct 2024 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU+xSg0z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE0748D;
	Fri,  4 Oct 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077802; cv=none; b=ItlKEqKv/9oiF0dSoLukXdPa1N7xs+dfS787n7lIpb2f2nF/ZF3WvI4ejOTR1JmW6+kuFTuO4VqL73VMWI3ctUr4Sv54xc9Xr/kKEB7Zgc13vfwNmZ39JP3d1hXkO/C8U013rNaY5mPbp2THnYsRPG/S707e75D0jaibLDqizSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077802; c=relaxed/simple;
	bh=tLVzY+4cfIDGv/DqkfAQeMn1mAqp55H2GITgeqvm/bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gG4bIplk7P2Saj51ztX2oHjUDcxKdOsecZguyTymgPbsiV9QTA1coLMADAArMLA645m2G0mmbCDi+4M6yi3J4CkprQ13Np/2ocSOdtmqikka7XYy2TExDCO8+WxTgQz/H+x7ARB5G6KQNYx8Yf+W4WCAHNa2eZ9dpr/Pb+mnzKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU+xSg0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F5EC4CECE;
	Fri,  4 Oct 2024 21:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728077802;
	bh=tLVzY+4cfIDGv/DqkfAQeMn1mAqp55H2GITgeqvm/bw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KU+xSg0z0ZWdLmz31EvdCa/rBMmUl3fUTiIurEjQKM57uSkjVIyjqIrP2qv19t8WQ
	 y2d1aP1UAqW8l/qSaaywNWl6MKYbDrRUpQwOrXIlV4xy+vfIN51TP22lRO9i+dH3JL
	 VN11s8McJNCflwCkehWeHX7cJur07Tugpna10jmYfVAhqV6ZRAuobbgECSiZr1rvVb
	 HxzAkf0a7XCqwRlFf6eu4o23M0CfUu0kplkg9309BpbQv8f1kx5/xZUSod4Yjcaaao
	 QP3fLJB5L8u/caFSMx9iHAZ5qqm3uZb5YwHValXi2CDrfgygCV2esDVu4cbJJxwOz3
	 hve4dkGXBGK7g==
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83493f2dda4so121977939f.1;
        Fri, 04 Oct 2024 14:36:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUs/txxNeArKPdphDa2XmQnfjA82pSvwu0e79LLO03c6JORlWfLtWFOg6cJekXzAXWkFVns4rslokeE2Vai@vger.kernel.org, AJvYcCVkrFHaugwjAgwBMEwBdaAJlaoZqGHpkJ+uyFoHEbvoOb3IjgeVeIPrzE4wu7gXM3OSxUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGNvxLm95rXmYPwlWOSztMgy07p4FY3qF//Y4bvswBCBPsyEWr
	IIxwtJRTt9cEMoGdf9KgZyDf+EiMKhaak/aY8ghi4uFXjsN7DJGpn0TuSEtzkJEarDkOfXyU2kd
	VHvdmba1CE/OWmE6Yhses0QUNCBo=
X-Google-Smtp-Source: AGHT+IHwuU8Ytfh6/vkTZ4Bu0hIeg5mmvs6MtkEM320QDJhcaGmiislzSh0eFAXqWr8AuOwNmgeksYD2rTn1Fqqj6as=
X-Received: by 2002:a92:c264:0:b0:3a2:463f:fd86 with SMTP id
 e9e14a558f8ab-3a375c4ae02mr35495085ab.4.1728077801367; Fri, 04 Oct 2024
 14:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002180956.1781008-1-namhyung@kernel.org> <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com> <ZwBdS86yBtOWy3iD@google.com>
In-Reply-To: <ZwBdS86yBtOWy3iD@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 4 Oct 2024 14:36:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6AhfG7Xv2izDYnMM+z03X29peZfmWNy0rf98aEaAUfVg@mail.gmail.com>
Message-ID: <CAPhsuW6AhfG7Xv2izDYnMM+z03X29peZfmWNy0rf98aEaAUfVg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:25=E2=80=AFPM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
> On Fri, Oct 04, 2024 at 01:10:58PM -0700, Song Liu wrote:
> > On Wed, Oct 2, 2024 at 11:10=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > The bpf_get_kmem_cache() is to get a slab cache information from a
> > > virtual address like virt_to_cache().  If the address is a pointer
> > > to a slab object, it'd return a valid kmem_cache pointer, otherwise
> > > NULL is returned.
> > >
> > > It doesn't grab a reference count of the kmem_cache so the caller is
> > > responsible to manage the access.  The intended use case for now is t=
o
> > > symbolize locks in slab objects from the lock contention tracepoints.
> > >
> > > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> > > Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  kernel/bpf/helpers.c |  1 +
> > >  mm/slab_common.c     | 19 +++++++++++++++++++
> > >  2 files changed, 20 insertions(+)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 4053f279ed4cc7ab..3709fb14288105c6 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_N=
EW)
> > >  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> > >  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> > >  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> > > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
> > >  BTF_KFUNCS_END(common_btf_ids)
> > >
> > >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > index 7443244656150325..5484e1cd812f698e 100644
> > > --- a/mm/slab_common.c
> > > +++ b/mm/slab_common.c
> > > @@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
> > >  }
> > >  EXPORT_SYMBOL(ksize);
> > >
> > > +#ifdef CONFIG_BPF_SYSCALL
> > > +#include <linux/btf.h>
> > > +
> > > +__bpf_kfunc_start_defs();
> > > +
> > > +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> > > +{
> > > +       struct slab *slab;
> > > +
> > > +       if (!virt_addr_valid(addr))
> > > +               return NULL;
> > > +
> > > +       slab =3D virt_to_slab((void *)(long)addr);
> > > +       return slab ? slab->slab_cache : NULL;
> > > +}
> >
> > Do we need to hold a refcount to the slab_cache? Given
> > we make this kfunc available everywhere, including
> > sleepable contexts, I think it is necessary.
>
> It's a really good question.
>
> If the callee somehow owns the slab object, as in the example
> provided in the series (current task), it's not necessarily.
>
> If a user can pass a random address, you're right, we need to
> grab the slab_cache's refcnt. But then we also can't guarantee
> that the object still belongs to the same slab_cache, the
> function becomes racy by the definition.

To be safe, we can limit the kfunc to sleepable context only. Then
we can lock slab_mutex for virt_to_slab, and hold a refcount
to slab_cache. We will need a KF_RELEASE kfunc to release
the refcount later.

IIUC, this limitation (sleepable context only) shouldn't be a problem
for perf use case?

Thanks,
Song

