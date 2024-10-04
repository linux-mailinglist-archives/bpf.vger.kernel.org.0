Return-Path: <bpf+bounces-41034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6578991342
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 01:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7669428510A
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8548154BE0;
	Fri,  4 Oct 2024 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUsjML9t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695DC14A4C6;
	Fri,  4 Oct 2024 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085499; cv=none; b=I4ccp6AFr3Bk61A+/E5WWeNUDICm3tHgYzetrGUXAnCUgaob3JZYTuDC/AfBUyvrh/T0FiqC3bsyBubctqf/Dz6LZR5sIYJVDl5sE35vtTs6DP7FJs/Ivmzq1NusrAamb4bRvCCbxvTVU3pDd+haJjO52vhmPwC6tNh+3XaCISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085499; c=relaxed/simple;
	bh=a5vwiUufTCuomlBbz4uTs4lXfy4cwYHks/EzUqUnzSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpsIg/rwn2KpmoFAElVdk2IJO8hb+Z+7C7gc+1AmfhY5A5i6ukEKiHp93L1fFG01Ys/IJjHdW0qb+oOwDYhIwc9wH+uwNHlYxX0faPZm/Uk6fUhGbtcRjeBD6VEYU2GmA7xRLcFK5G9QXf1Bl6e8mUYAKjtRDq/M8ECkknbBKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUsjML9t; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso26621635e9.2;
        Fri, 04 Oct 2024 16:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728085496; x=1728690296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ES3vmRb4BxIBJ2wMtB9RFOQn+fn7LZl8p42EnlOXCo=;
        b=BUsjML9t1X+LjhKQQTgjenazKpkrvUPWvSvfBiulDlKOPfYlDD7zmS4SRx7WtmDvpt
         kb34Fpn9EYxY3imJ78uJOVK+Q+WWyovEw80jutPaXv+QMtIniSPbMVzxn4cU8jFHmfd1
         IM5QxLa+b+xO/GCG0WblreVG1Qc34Up7VXk00pdLRAwfNHRh4qVo7xDwDVPPvnk+5du6
         kvb5eZ6zTsFMhw17HJtUUi09RXgUR88THVUuNJjgsNKR5FGshOSmcbasX3Y+Sqejmf7I
         9hUBNk52WGDYnEieTDL2V5hgzvMbP94W5k64ihB1tZHuwqnwIHeIQaGcrUQDM6qxVPpx
         L9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085496; x=1728690296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ES3vmRb4BxIBJ2wMtB9RFOQn+fn7LZl8p42EnlOXCo=;
        b=Ts8YHbtileD9Mw4MUIFEaUoy37mV36YKlE8mEACqaE6J8CKchsb3mYdZNhQIfajTjR
         WU6PXVBleLxfSArydZpNaYXeBwI0s2nQcaU0tqZgB7/qJJol5S8aVS7OmjYE4VVw270X
         9gV49/+AkmgV4yuchHzsFcgrOT/AoJP6cElNx2Kqyif09rBYXe8aVCAu3eS2S08Hq7DS
         dzbvKKK990Bq/pBqkvMAqSy9nGxesy4ciFsgbUYCVVO+5i563/p/eTlL7xb1KW64/bAM
         tuu584kNpTV0fr1IBLMF5hgQWBlAvuACjbDGvBoDGrjRJkpm+JKcaMGrijcZBF3UsM9I
         Sczw==
X-Forwarded-Encrypted: i=1; AJvYcCVG7TviGjx748Zl81UsfIgzV+3tXagenFLAmfNXB03Sv38DSviieZM08XVb4V0vcfksJCpM17lKkU2EsHKn@vger.kernel.org, AJvYcCXXoAQfGmo0ZcmL+oYbxEnJnvXKRvoavEC0vpw7LibYgaf67CgT1pvW8IQfQwHykRxyS7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8eG9ShCX4f4Cl1kVgrWyr6PthZt9kfp/MYgC7Vho39BlnkCv
	B45wnNzzneoeDZyMTxdLAVAO1FuHFU/j/nWwJkvl94kUdAehKtViIAnurf2vLbDywQW/hAU/Q+E
	E3HsgEfXHLQF0JSMudosZVdZKaaw=
X-Google-Smtp-Source: AGHT+IHfxt6TLvINC8Y20uR6Lt8dMWMnQaEXox3ax49DYOVcNCUuRWrJCEwfOwbZxxLH3Kp2UDT4HdCSB2NR0AdUjz0=
X-Received: by 2002:a05:6000:1acc:b0:37c:d179:2f73 with SMTP id
 ffacd0b85a97d-37d0e6f8efamr3505932f8f.13.1728085495517; Fri, 04 Oct 2024
 16:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002180956.1781008-1-namhyung@kernel.org> <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
 <ZwBdS86yBtOWy3iD@google.com> <CAPhsuW6AhfG7Xv2izDYnMM+z03X29peZfmWNy0rf98aEaAUfVg@mail.gmail.com>
 <ZwBk8i23odCe7qVK@google.com> <CAPhsuW4AjZMQxCbqYmEgbnkP0gWenKo4wVi8tW1zYcsaF5h7iQ@mail.gmail.com>
In-Reply-To: <CAPhsuW4AjZMQxCbqYmEgbnkP0gWenKo4wVi8tW1zYcsaF5h7iQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Oct 2024 16:44:44 -0700
Message-ID: <CAADnVQK0VQXvxqxm6WudyeLao1L+jMTvmUauciBc8_vcLcR=vQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
To: Song Liu <song@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm <linux-mm@kvack.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:57=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Fri, Oct 4, 2024 at 2:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > On Fri, Oct 04, 2024 at 02:36:30PM -0700, Song Liu wrote:
> > > On Fri, Oct 4, 2024 at 2:25=E2=80=AFPM Roman Gushchin <roman.gushchin=
@linux.dev> wrote:
> > > >
> > > > On Fri, Oct 04, 2024 at 01:10:58PM -0700, Song Liu wrote:
> > > > > On Wed, Oct 2, 2024 at 11:10=E2=80=AFAM Namhyung Kim <namhyung@ke=
rnel.org> wrote:
> > > > > >
> > > > > > The bpf_get_kmem_cache() is to get a slab cache information fro=
m a
> > > > > > virtual address like virt_to_cache().  If the address is a poin=
ter
> > > > > > to a slab object, it'd return a valid kmem_cache pointer, other=
wise
> > > > > > NULL is returned.
> > > > > >
> > > > > > It doesn't grab a reference count of the kmem_cache so the call=
er is
> > > > > > responsible to manage the access.  The intended use case for no=
w is to
> > > > > > symbolize locks in slab objects from the lock contention tracep=
oints.
> > > > > >
> > > > > > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > > Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> > > > > > Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > ---
> > > > > >  kernel/bpf/helpers.c |  1 +
> > > > > >  mm/slab_common.c     | 19 +++++++++++++++++++
> > > > > >  2 files changed, 20 insertions(+)
> > > > > >
> > > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > > index 4053f279ed4cc7ab..3709fb14288105c6 100644
> > > > > > --- a/kernel/bpf/helpers.c
> > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > @@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_=
ITER_NEW)
> > > > > >  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_N=
ULL)
> > > > > >  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> > > > > >  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> > > > > > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
> > > > > >  BTF_KFUNCS_END(common_btf_ids)
> > > > > >
> > > > > >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > > > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > > > index 7443244656150325..5484e1cd812f698e 100644
> > > > > > --- a/mm/slab_common.c
> > > > > > +++ b/mm/slab_common.c
> > > > > > @@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(ksize);
> > > > > >
> > > > > > +#ifdef CONFIG_BPF_SYSCALL
> > > > > > +#include <linux/btf.h>
> > > > > > +
> > > > > > +__bpf_kfunc_start_defs();
> > > > > > +
> > > > > > +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> > > > > > +{
> > > > > > +       struct slab *slab;
> > > > > > +
> > > > > > +       if (!virt_addr_valid(addr))
> > > > > > +               return NULL;
> > > > > > +
> > > > > > +       slab =3D virt_to_slab((void *)(long)addr);
> > > > > > +       return slab ? slab->slab_cache : NULL;
> > > > > > +}
> > > > >
> > > > > Do we need to hold a refcount to the slab_cache? Given
> > > > > we make this kfunc available everywhere, including
> > > > > sleepable contexts, I think it is necessary.
> > > >
> > > > It's a really good question.
> > > >
> > > > If the callee somehow owns the slab object, as in the example
> > > > provided in the series (current task), it's not necessarily.
> > > >
> > > > If a user can pass a random address, you're right, we need to
> > > > grab the slab_cache's refcnt. But then we also can't guarantee
> > > > that the object still belongs to the same slab_cache, the
> > > > function becomes racy by the definition.
> > >
> > > To be safe, we can limit the kfunc to sleepable context only. Then
> > > we can lock slab_mutex for virt_to_slab, and hold a refcount
> > > to slab_cache. We will need a KF_RELEASE kfunc to release
> > > the refcount later.
> >
> > Then it needs to call kmem_cache_destroy() for release which contains
> > rcu_barrier. :(
> >
> > >
> > > IIUC, this limitation (sleepable context only) shouldn't be a problem
> > > for perf use case?
> >
> > No, it would be called from the lock contention path including
> > spinlocks. :(
> >
> > Can we limit it to non-sleepable ctx and not to pass arbtrary address
> > somehow (or not to save the result pointer)?
>
> I hacked something like the following. It is not ideal, because we are
> taking spinlock_t pointer instead of void pointer. To use this with void
> 'pointer, we will need some verifier changes.
>
> Thanks,
> Song
>
>
> diff --git i/kernel/bpf/helpers.c w/kernel/bpf/helpers.c
> index 3709fb142881..7311a26ecb01 100644
> --- i/kernel/bpf/helpers.c
> +++ w/kernel/bpf/helpers.c
> @@ -3090,7 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL | KF_TRUSTED_ARGS
> | KF_RCU_PROTECTED)

I don't think KF_TRUSTED_ARGS approach would fit here.
Namhyung's use case is tracing. The 'addr' will be some potentially
arbitrary address from somewhere. The chance to see a trusted pointer
is probably very low in such a tracing use case.

The verifier change can mainly be the following:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d9b38ffd220..e09eb108e956 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12834,6 +12834,9 @@ static int check_kfunc_call(struct
bpf_verifier_env *env, struct bpf_insn *insn,
                        regs[BPF_REG_0].type =3D PTR_TO_BTF_ID;
                        regs[BPF_REG_0].btf_id =3D ptr_type_id;

+                       if (meta.func_id =3D=3D
special_kfunc_list[KF_get_kmem_cache])
+                               regs[BPF_REG_0].type |=3D PTR_UNTRUSTED;
+
                        if (is_iter_next_kfunc(&meta)) {
                                struct bpf_reg_state *cur_iter;

The returned 'struct kmem_cache *' won't be refcnt-ed (acquired).
It will be readonly via ptr_to_btf_id logic.
s->flags;
s->size;
s->offset;
access will be allowed but the verifier will sanitize them
with an inlined version of probe_read_kernel.
Even KF_RET_NULL can be dropped.

