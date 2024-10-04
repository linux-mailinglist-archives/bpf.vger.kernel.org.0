Return-Path: <bpf+bounces-41029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535CB991291
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 00:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5ADDB212AE
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B77814D439;
	Fri,  4 Oct 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAcVqJTb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067214BF92;
	Fri,  4 Oct 2024 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082658; cv=none; b=P/Hl8VYZmMKebUqLwRUGmZDSMnzjRiP57tpKj2w9fYqPiw0MRnhQJMKEWDj0oX5knpTM8dOl9Yl/71adVEmCIGCoR3fZ76u+3zlq3OVz0vnnU+UBLAezrDvIdc4/JtFdQ/BG1eDmT0C/5F5XyDgaRDXh2AegjNybeYukiBB1cQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082658; c=relaxed/simple;
	bh=qVjDmqSZwjw9opZT+5TeJEUEe/n3oLyxDf4L24muHzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFkAV5mpJEWlC+kljPQX0WyW9lulnepUjwS2O1w92SveymB6vkudHgc55mE5lfH8fYNH1/PH3yXJ5DeBt/WoTg2lOCF9a1hr9CvnmdRzgYUI+P+6CLTDhvH2MNkCoHXf2ep+HxA6NiQx27KMxsNUFLG+dT9ti3PrB0TvVvdoiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAcVqJTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4DEC4CED2;
	Fri,  4 Oct 2024 22:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728082658;
	bh=qVjDmqSZwjw9opZT+5TeJEUEe/n3oLyxDf4L24muHzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IAcVqJTbpoSqWwg6W7hK2MFIU8Ijvon0F3DYu9FVRhDWnOAZ7tpai5CDPmZ6GESfm
	 5k4UfJRAZf1M1Qgs/CoDKUI+/j0t+hVrAfmXz7CN4yNjVD0/9AIiGsg1SWksyDUTkY
	 q97lltyPUj/FDep7HpfIHy3bDo3rwRuyJqh0YjFrkXFaQqPagVqDFE5jD6Z7NqXYLK
	 u8+7iOwhOTEY6OM2HRtFSOQWfPpANogTptch092aSauSzzhY08DAH3J1rcul7ttiBB
	 dWOaH/0QVPGfrVEi24v4rqVT1Hm4OzFDUWBNXI/ajRYkqPn3qYs+5YhrYC9gEShly1
	 Ff4pWyeyB4zxA==
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a1a412638fso11022695ab.1;
        Fri, 04 Oct 2024 15:57:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2f7+RvAX1hk3CoaEvy/PizsUQUTfnMTUYmmOiBp+SJVoUK1fZt/QluQODIuBWdU64+JY8xnpauFyPQ3xA@vger.kernel.org, AJvYcCUyL53XwJFRKmj7O059rdndfazdO5eD862BCEPo3fN8Q7qvaD7EOigQIUUd9mHShI2Im+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNzZDvx0XVctW1De1UA+OU5fAzvuMYpBirgnRmuju7e7l6BtfE
	swMvAsR1CI59FfrFwMRxGnNn0yS8XUc0I5YqmrGfCNAmPoEQ2CFSzD4TK4+ebfhcYTC2kIaLLQk
	+9cXT1RN1RZD7ZYIWsJaWMaIJLIE=
X-Google-Smtp-Source: AGHT+IFxRndEcVq6a0ZjsKN35u+f0Bwc6BGCMWePGg+IW0DnMklxekOyLQfc291uwPNil47MRqUyEBZPrNFtxWwugsc=
X-Received: by 2002:a05:6e02:1fcf:b0:3a0:533e:3c0a with SMTP id
 e9e14a558f8ab-3a3759925c7mr47646525ab.7.1728082657742; Fri, 04 Oct 2024
 15:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002180956.1781008-1-namhyung@kernel.org> <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
 <ZwBdS86yBtOWy3iD@google.com> <CAPhsuW6AhfG7Xv2izDYnMM+z03X29peZfmWNy0rf98aEaAUfVg@mail.gmail.com>
 <ZwBk8i23odCe7qVK@google.com>
In-Reply-To: <ZwBk8i23odCe7qVK@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 4 Oct 2024 15:57:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4AjZMQxCbqYmEgbnkP0gWenKo4wVi8tW1zYcsaF5h7iQ@mail.gmail.com>
Message-ID: <CAPhsuW4AjZMQxCbqYmEgbnkP0gWenKo4wVi8tW1zYcsaF5h7iQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
To: Namhyung Kim <namhyung@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
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

On Fri, Oct 4, 2024 at 2:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Oct 04, 2024 at 02:36:30PM -0700, Song Liu wrote:
> > On Fri, Oct 4, 2024 at 2:25=E2=80=AFPM Roman Gushchin <roman.gushchin@l=
inux.dev> wrote:
> > >
> > > On Fri, Oct 04, 2024 at 01:10:58PM -0700, Song Liu wrote:
> > > > On Wed, Oct 2, 2024 at 11:10=E2=80=AFAM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > The bpf_get_kmem_cache() is to get a slab cache information from =
a
> > > > > virtual address like virt_to_cache().  If the address is a pointe=
r
> > > > > to a slab object, it'd return a valid kmem_cache pointer, otherwi=
se
> > > > > NULL is returned.
> > > > >
> > > > > It doesn't grab a reference count of the kmem_cache so the caller=
 is
> > > > > responsible to manage the access.  The intended use case for now =
is to
> > > > > symbolize locks in slab objects from the lock contention tracepoi=
nts.
> > > > >
> > > > > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> > > > > Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  kernel/bpf/helpers.c |  1 +
> > > > >  mm/slab_common.c     | 19 +++++++++++++++++++
> > > > >  2 files changed, 20 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > index 4053f279ed4cc7ab..3709fb14288105c6 100644
> > > > > --- a/kernel/bpf/helpers.c
> > > > > +++ b/kernel/bpf/helpers.c
> > > > > @@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_IT=
ER_NEW)
> > > > >  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NUL=
L)
> > > > >  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> > > > >  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> > > > > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
> > > > >  BTF_KFUNCS_END(common_btf_ids)
> > > > >
> > > > >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > > index 7443244656150325..5484e1cd812f698e 100644
> > > > > --- a/mm/slab_common.c
> > > > > +++ b/mm/slab_common.c
> > > > > @@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
> > > > >  }
> > > > >  EXPORT_SYMBOL(ksize);
> > > > >
> > > > > +#ifdef CONFIG_BPF_SYSCALL
> > > > > +#include <linux/btf.h>
> > > > > +
> > > > > +__bpf_kfunc_start_defs();
> > > > > +
> > > > > +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> > > > > +{
> > > > > +       struct slab *slab;
> > > > > +
> > > > > +       if (!virt_addr_valid(addr))
> > > > > +               return NULL;
> > > > > +
> > > > > +       slab =3D virt_to_slab((void *)(long)addr);
> > > > > +       return slab ? slab->slab_cache : NULL;
> > > > > +}
> > > >
> > > > Do we need to hold a refcount to the slab_cache? Given
> > > > we make this kfunc available everywhere, including
> > > > sleepable contexts, I think it is necessary.
> > >
> > > It's a really good question.
> > >
> > > If the callee somehow owns the slab object, as in the example
> > > provided in the series (current task), it's not necessarily.
> > >
> > > If a user can pass a random address, you're right, we need to
> > > grab the slab_cache's refcnt. But then we also can't guarantee
> > > that the object still belongs to the same slab_cache, the
> > > function becomes racy by the definition.
> >
> > To be safe, we can limit the kfunc to sleepable context only. Then
> > we can lock slab_mutex for virt_to_slab, and hold a refcount
> > to slab_cache. We will need a KF_RELEASE kfunc to release
> > the refcount later.
>
> Then it needs to call kmem_cache_destroy() for release which contains
> rcu_barrier. :(
>
> >
> > IIUC, this limitation (sleepable context only) shouldn't be a problem
> > for perf use case?
>
> No, it would be called from the lock contention path including
> spinlocks. :(
>
> Can we limit it to non-sleepable ctx and not to pass arbtrary address
> somehow (or not to save the result pointer)?

I hacked something like the following. It is not ideal, because we are
taking spinlock_t pointer instead of void pointer. To use this with void
'pointer, we will need some verifier changes.

Thanks,
Song


diff --git i/kernel/bpf/helpers.c w/kernel/bpf/helpers.c
index 3709fb142881..7311a26ecb01 100644
--- i/kernel/bpf/helpers.c
+++ w/kernel/bpf/helpers.c
@@ -3090,7 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL | KF_TRUSTED_ARGS
| KF_RCU_PROTECTED)
 BTF_KFUNCS_END(common_btf_ids)

 static const struct btf_kfunc_id_set common_kfunc_set =3D {
diff --git i/mm/slab_common.c w/mm/slab_common.c
index 5484e1cd812f..3e3e5f172f2e 100644
--- i/mm/slab_common.c
+++ w/mm/slab_common.c
@@ -1327,14 +1327,15 @@ EXPORT_SYMBOL(ksize);

 __bpf_kfunc_start_defs();

-__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
+__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(spinlock_t *addr)
 {
        struct slab *slab;
+       unsigned long a =3D (unsigned long)addr;

-       if (!virt_addr_valid(addr))
+       if (!virt_addr_valid(a))
                return NULL;

-       slab =3D virt_to_slab((void *)(long)addr);
+       slab =3D virt_to_slab(addr);
        return slab ? slab->slab_cache : NULL;
 }

@@ -1346,4 +1347,3 @@ EXPORT_TRACEPOINT_SYMBOL(kmalloc);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
-
diff --git i/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
w/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
index 3f6ec15a1bf6..8238155a5055 100644
--- i/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
+++ w/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
@@ -16,7 +16,7 @@ struct {
        __uint(max_entries, 1024);
 } slab_hash SEC(".maps");

-extern struct kmem_cache *bpf_get_kmem_cache(__u64 addr) __ksym;
+extern struct kmem_cache *bpf_get_kmem_cache(spinlock_t *addr) __ksym;

 /* result, will be checked by userspace */
 int found;
@@ -46,21 +46,23 @@ int slab_info_collector(struct bpf_iter__kmem_cache *ct=
x)
 SEC("raw_tp/bpf_test_finish")
 int BPF_PROG(check_task_struct)
 {
-       __u64 curr =3D bpf_get_current_task();
+       struct task_struct *curr =3D bpf_get_current_task_btf();
        struct kmem_cache *s;
        char *name;

-       s =3D bpf_get_kmem_cache(curr);
+       s =3D bpf_get_kmem_cache(&curr->alloc_lock);
        if (s =3D=3D NULL) {
                found =3D -1;
                return 0;
        }

+       bpf_rcu_read_lock();
        name =3D bpf_map_lookup_elem(&slab_hash, &s);
        if (name && !bpf_strncmp(name, 11, "task_struct"))
                found =3D 1;
        else
                found =3D -2;
+       bpf_rcu_read_unlock();

        return 0;
 }

