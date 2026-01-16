Return-Path: <bpf+bounces-79309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B8ED339D9
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 18:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AF37303D36A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 16:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A6539A7E7;
	Fri, 16 Jan 2026 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsYZ0/XI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2D389463
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582773; cv=pass; b=jcAcJ+S/nhRxXX8DBPnQFUc29Zg0TvyK6CphHS0SiDl2BSvtPRRefNIlUtNPlA2J9MZQPocwTtg3yMbF/fjDglIvOAg7wIMicCdXmhdb2QroCqhxFXprl6l6e8rPtLxk/S4V6liw1Dr/J9u8u5gNuknROfRqs97zyNvO9Jhvs2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582773; c=relaxed/simple;
	bh=KyyqyVl5S3DjX/Y/TAbdf3ewJUO7HkhUFESxlLUupeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkIFxakVZVK99c5/3rgVF4epCGOIicok+hC5vn1J05VR1X+8q2ZpGctq+dTn88lat91nhAin+Q2zP/wHsQhJVs+qRU7LquqILLfemguG/Z3D1pFewlcICebczk9z0IT/+dXrXAjiRp1jpl3lD7fvXYMVzBz2Hpvxy0izHi99Pqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsYZ0/XI; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5014b5d8551so534661cf.0
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 08:59:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768582770; cv=none;
        d=google.com; s=arc-20240605;
        b=hYFVXkEFAisJMOho8ykTZxUyt77Nc9ftL+xUfJlPSYL3g8bCZnlMIm6nMM2xvwS+Ja
         VsBZc9kkwMT7a402ZDyhLWC0NKf/vV9ZfyWlzCgjqwPPpZBuQAFsotQ+yiLlgcJrWm/I
         YOczSsMwcPuH6GNKw7regk6l7CC7r/fbck2jwBzN44nmQ3TBb0VbefJo+5dq5nFQx836
         1v+YdvT1CCw37ar3NIEq43bqW2WdoFNRTtn/8YJVNnUyao+6wdRdavSTJ/W7G4GUoVcC
         qqt1gLSlINPMtQH/6FVYEccBhM0WSaD+1d9TGEexeFCiyFBSSkz+EEdJyLFIpMB4nuT9
         K1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s1BTvLdErVOVTXbojE/mp4bn56MJT1unyCMZ/1mKqI8=;
        fh=Osawb+V42/Bm4qP91oNBThVjzRaASdb02RiqAiNTC88=;
        b=YJ6zi4Sx9DqVUImU7FXOpxAOmQB26jBo4WdPhUgZ5Dinyj3qVQpvppO+JfcJ/A2cea
         AqsSlmGqTsiuwOHgoRzdloIZpmBxS6/o1KamlLSVBoiGr6Hxkc29Bcmhib1egLhZDmX0
         cdsUY0FwyP7KIeJTIEwhLI72hvPJn/sHjfmWkyg6Yk7MI5ZZwEkwCs/E3huLwKlMatIp
         TaAShroWZjNgZVMCG8R41Q8YoIpjhM0eeusVx9CHbH7HuZglk7Wglsr9mFuNoZwOj9E4
         ys1QfrDsNCSFsMQ/vmLRGZKLy/2wIT7K6c9of2atby/2NhoRMbNx9T8NlSItuStXZulK
         Rfgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768582770; x=1769187570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1BTvLdErVOVTXbojE/mp4bn56MJT1unyCMZ/1mKqI8=;
        b=KsYZ0/XITMMWcwXkR0Aw2SjcGLlANkug28c/2yzRur5N5/B1/I/cEPMPJ7P+fiBtax
         MSFlEtvEJKlZFnEIXR7cERwkiNyiUIKMJBTnM6bWwzWQFpjHxXsE5ubI9PjRd+mKnVak
         QT8jZC0WMvhJV8hnnG/D26O0jf4j28dZ9gNsmfsTfk63XXbOao1NO9o9Br2sROXGlftP
         bRHlgIyBwGkhItvITFFIdn9gHQVv88osOzz+7Crqh3M6hSNyq8znL+HbfvRcv3HUwlZ3
         0yMKJBvZayk59VsbFdgu4fx+nKUIWvtDqiKTxGDVcP3SH9ISEhC86ZE3dCiCXOhWp/pB
         nBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768582770; x=1769187570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s1BTvLdErVOVTXbojE/mp4bn56MJT1unyCMZ/1mKqI8=;
        b=KZFiny/LLCsxS6hC/WCp0C2og6dJqriHv8s5J5actkXjGVajjCVc2UR7ma+ItzJfJh
         Yfm2KGR4P6Y9iK5rJhLd1D5qoixyHGDf/UU+nU5txvr6kp7Vo37KFYKJ+HxfPitZVBvn
         Wl/VUYhhc/eZfStTbfwygBgxxxdgG+uzfsAK32Jh9ZOtfSUEvB2gWD0AEhWM07gEYM4M
         7bcykDwBNSTqrokZ6v4szX/HJr1rW33nw+MHKghyDHMz/s1cmErbQySgTs3fw8sk2xB5
         DtzcOmgFU2r6sjP5oSOMljDN4vDrztvBkI+MhKtONJHRES/RVYQ0TJvCHkoKY9XCe78U
         fydg==
X-Forwarded-Encrypted: i=1; AJvYcCVjxrTLPZ+KMc954X3FcwYqGDB2jZnxNlEFpvTpC/NiRihN9nfmDpnNTt1jMgb1TGpQtug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaPykbBQoFplsYGjuYV41HOfJUJyStNH5OrmqO0q2cd97vFX6C
	p0L1JMeU+nwe4JU9CuAFDHlzwlPQoJN820nEjQb5dGLNnwnn9TcMFKqPtjSvXRioFlRAxHzHLNi
	oM/1JvSa1ihw8cRdLFf3YcoWxsJmKM6f/MSoZ5yTH
X-Gm-Gg: AY/fxX7ZvmdZMrPxTcTSeRklj3mRxDepGLilTNGB80wSA7adFCM+eJXmJROqtCFahp4
	WKAGtHueQ3rRx6OtLQY/W3Y9zlElndi/Sfsd2QQrhQx4HLRI5E9fh0ZvFG8yIZtd8/aA/lNCYpO
	wKzAbpddGnzdjDN74LRnNH6lH3vFAkXCPHdx6+1BAat7Q7+wvaoD+ihbcJSA5wBhmcjJusczlkT
	03rvJ1L2t63ySmz1km8BfLAhA13QRmxv/wsJrtQza4cxT524hs1wIgWwL17VPS1439v6A==
X-Received: by 2002:a05:622a:4c:b0:4f3:7b37:81b with SMTP id
 d75a77b69052e-502a23a54c0mr4530661cf.18.1768582769172; Fri, 16 Jan 2026
 08:59:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-4-98225cfb50cf@suse.cz> <CAJuCfpFKKtxB2mREuOSa4oQu=MBGkbQRQNYSSnubAAgPENcO-Q@mail.gmail.com>
 <d310d788-b6df-47dc-9557-643813351838@suse.cz>
In-Reply-To: <d310d788-b6df-47dc-9557-643813351838@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 08:59:18 -0800
X-Gm-Features: AZwV_QgPp527tGrUgX7CIcyuFqzTixlPtSEyPVxRBLdI9BmrU9Axe1wzPof38j0
Message-ID: <CAJuCfpEqZwgB65y3zbm0Pwb_sVLjMbmHbTmJY6SdiVvvOPq+2A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/20] slab: add sheaves to most caches
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 3:24=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/16/26 06:45, Suren Baghdasaryan wrote:
> > On Mon, Jan 12, 2026 at 3:17=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> In the first step to replace cpu (partial) slabs with sheaves, enable
> >> sheaves for almost all caches. Treat args->sheaf_capacity as a minimum=
,
> >> and calculate sheaf capacity with a formula that roughly follows the
> >> formula for number of objects in cpu partial slabs in set_cpu_partial(=
).
> >>
> >> This should achieve roughly similar contention on the barn spin lock a=
s
> >> there's currently for node list_lock without sheaves, to make
> >> benchmarking results comparable. It can be further tuned later.
> >>
> >> Don't enable sheaves for bootstrap caches as that wouldn't work. In
> >> order to recognize them by SLAB_NO_OBJ_EXT, make sure the flag exists
> >> even for !CONFIG_SLAB_OBJ_EXT.
> >>
> >> This limitation will be lifted for kmalloc caches after the necessary
> >> bootstrapping changes.
> >>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >
> > One nit but otherwise LGTM.
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks.
>
> >> ---
> >>  include/linux/slab.h |  6 ------
> >>  mm/slub.c            | 51 +++++++++++++++++++++++++++++++++++++++++++=
++++----
> >>  2 files changed, 47 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/include/linux/slab.h b/include/linux/slab.h
> >> index 2482992248dc..2682ee57ec90 100644
> >> --- a/include/linux/slab.h
> >> +++ b/include/linux/slab.h
> >> @@ -57,9 +57,7 @@ enum _slab_flag_bits {
> >>  #endif
> >>         _SLAB_OBJECT_POISON,
> >>         _SLAB_CMPXCHG_DOUBLE,
> >> -#ifdef CONFIG_SLAB_OBJ_EXT
> >>         _SLAB_NO_OBJ_EXT,
> >> -#endif
> >>         _SLAB_FLAGS_LAST_BIT
> >>  };
> >>
> >> @@ -238,11 +236,7 @@ enum _slab_flag_bits {
> >>  #define SLAB_TEMPORARY         SLAB_RECLAIM_ACCOUNT    /* Objects are=
 short-lived */
> >>
> >>  /* Slab created using create_boot_cache */
> >> -#ifdef CONFIG_SLAB_OBJ_EXT
> >>  #define SLAB_NO_OBJ_EXT                __SLAB_FLAG_BIT(_SLAB_NO_OBJ_E=
XT)
> >> -#else
> >> -#define SLAB_NO_OBJ_EXT                __SLAB_FLAG_UNUSED
> >> -#endif
> >>
> >>  /*
> >>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 8ffeb3ab3228..6e05e3cc5c49 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -7857,6 +7857,48 @@ static void set_cpu_partial(struct kmem_cache *=
s)
> >>  #endif
> >>  }
> >>
> >> +static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
> >> +                                            struct kmem_cache_args *a=
rgs)
> >> +
> >> +{
> >> +       unsigned int capacity;
> >> +       size_t size;
> >> +
> >> +
> >> +       if (IS_ENABLED(CONFIG_SLUB_TINY) || s->flags & SLAB_DEBUG_FLAG=
S)
> >> +               return 0;
> >> +
> >> +       /* bootstrap caches can't have sheaves for now */
> >> +       if (s->flags & SLAB_NO_OBJ_EXT)
> >> +               return 0;
> >> +
> >> +       /*
> >> +        * For now we use roughly similar formula (divided by two as t=
here are
> >> +        * two percpu sheaves) as what was used for percpu partial sla=
bs, which
> >> +        * should result in similar lock contention (barn or list_lock=
)
> >> +        */
> >> +       if (s->size >=3D PAGE_SIZE)
> >> +               capacity =3D 4;
> >> +       else if (s->size >=3D 1024)
> >> +               capacity =3D 12;
> >> +       else if (s->size >=3D 256)
> >> +               capacity =3D 26;
> >> +       else
> >> +               capacity =3D 60;
> >> +
> >> +       /* Increment capacity to make sheaf exactly a kmalloc size buc=
ket */
> >> +       size =3D struct_size_t(struct slab_sheaf, objects, capacity);
> >> +       size =3D kmalloc_size_roundup(size);
> >> +       capacity =3D (size - struct_size_t(struct slab_sheaf, objects,=
 0)) / sizeof(void *);
> >> +
> >> +       /*
> >> +        * Respect an explicit request for capacity that's typically m=
otivated by
> >> +        * expected maximum size of kmem_cache_prefill_sheaf() to not =
end up
> >> +        * using low-performance oversize sheaves
> >> +        */
> >> +       return max(capacity, args->sheaf_capacity);
> >> +}
> >> +
> >>  /*
> >>   * calculate_sizes() determines the order and the distribution of dat=
a within
> >>   * a slab object.
> >> @@ -7991,6 +8033,10 @@ static int calculate_sizes(struct kmem_cache_ar=
gs *args, struct kmem_cache *s)
> >>         if (s->flags & SLAB_RECLAIM_ACCOUNT)
> >>                 s->allocflags |=3D __GFP_RECLAIMABLE;
> >>
> >> +       /* kmalloc caches need extra care to support sheaves */
> >> +       if (!is_kmalloc_cache(s))
> >
> > nit: All the checks for the cases when sheaves should not be used
> > (like SLAB_DEBUG_FLAGS and SLAB_NO_OBJ_EXT) are done inside
> > calculate_sheaf_capacity(). Only this is_kmalloc_cache() one is here.
> > It would be nice to have all of them in the same place but maybe you
> > have a reason for keeping it here?
>
> Yeah, in "slab: handle kmalloc sheaves bootstrap" we call
> calculate_sheaf_capacity() from another place for kmalloc normal caches s=
o
> the check has to be outside.

Ok, I suspected the answer will be in the later patches. Thanks!

>
> >> +               s->sheaf_capacity =3D calculate_sheaf_capacity(s, args=
);
> >> +
> >>         /*
> >>          * Determine the number of objects per slab
> >>          */
> >> @@ -8595,15 +8641,12 @@ int do_kmem_cache_create(struct kmem_cache *s,=
 const char *name,
> >>
> >>         set_cpu_partial(s);
> >>
> >> -       if (args->sheaf_capacity && !IS_ENABLED(CONFIG_SLUB_TINY)
> >> -                                       && !(s->flags & SLAB_DEBUG_FLA=
GS)) {
> >> +       if (s->sheaf_capacity) {
> >>                 s->cpu_sheaves =3D alloc_percpu(struct slub_percpu_she=
aves);
> >>                 if (!s->cpu_sheaves) {
> >>                         err =3D -ENOMEM;
> >>                         goto out;
> >>                 }
> >> -               // TODO: increase capacity to grow slab_sheaf up to ne=
xt kmalloc size?
> >> -               s->sheaf_capacity =3D args->sheaf_capacity;
> >>         }
> >>
> >>  #ifdef CONFIG_NUMA
> >>
> >> --
> >> 2.52.0
> >>
>

