Return-Path: <bpf+bounces-73044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 723D6C21156
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 17:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2E4188680F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DEB3644B5;
	Thu, 30 Oct 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGQi3H7I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83C312801
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839969; cv=none; b=EsbB+0ZoA0vThMFHblQ6i9jyk99dCbWBDPNc4WFKfc04tin92/gcpgzlLr+ssQMUDR3kYcD17y8kP+G+wVP/zQ3UszRgAOwjztSdlWF6VDc1ygz26IKOeR/TLncXJwOKfGx8f+3GL0NNDJgDXUOdt6KMfJqY4rOCpd/IKVfOygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839969; c=relaxed/simple;
	bh=GVsbUlHFWCq7tqkotWM97De3YjcY6mfm4lT5ylPlQUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VABpZ3Nl9j9H3Euq3MAXcjeipMsg4JPRL3nAlPP22+keJcsw10bQ5HmL6ExCyAZuwGdF6X0MmzEqThlkoSuuwB1B20vQOp6iEKanoV1wSOASSsf8oWR81p2GwWTqtVJJedbxJUWRKZvwvF70/BzMZyz22OinD+3RFmoB6061nCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGQi3H7I; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d5b756284so314093266b.1
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761839966; x=1762444766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtYLD87/tbnWpFhxZoXLkwutGQwHC9HiwVV2d797j9U=;
        b=RGQi3H7IFoxhCzU/HF95NMXxkBovMbulkcj8PMIlGC28yKrn3eDgfMxJwjhqqY385P
         7YF2jmhEY43qeWz3NR4g4w+Aaq4VqbErHIc+GOLs4Xs5UBO4GuNUI+IK4ijCiakTVvRJ
         S3uvnnAmFMzIFpLsfYX9CJ1YokxdMGQU/dyV7zHPf3xHE/eCVhwTVC2mT+RsR4yjy2Bq
         MPMTcBhZCz35OaCtopWD+wgkAKVwolhiMIN0dYwUYBmLB5NzVOmST2FCFO2cf4GiopSz
         iopJM+jcE8i9azZRQgPvJrQeiC82aMu9RfjtqgIhAUZSXKFiZTIUz5IRhMQsKYeSJxYf
         438A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839966; x=1762444766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtYLD87/tbnWpFhxZoXLkwutGQwHC9HiwVV2d797j9U=;
        b=SKHqUnw6Z+muxV8UtozwLOKv63anZArJ+eD2cb76Cll7MttPrQSAjids5gUFXbcRQE
         LmlVZDxuXQ2vopGaSlK/WghWmVHMEs2i7nsgU4XjUx4Us7ZjfimQ8zdC/7pmIlrOlBrH
         Llb6VClJ+f/kJe/mdsaznXnT8tNFLUXem0brerfpmWtSKce8O4xnnPXmD51fGLevh8FU
         BFJIhI6lOVsEjS/a5F5it4M2B18JBBX8gEFZ/V3ZcPkDfKYDj46mqZQeJYlgLDek4/Ll
         4kib8WmHG9RMCGzaoB7ywlXgfUyewWwcGCFGCQ7P7hKAuvbQF1smXpEoXRAFNp1oxaeO
         h21Q==
X-Forwarded-Encrypted: i=1; AJvYcCX68dSBjco9UT1os7bZkprXL90N9uQCnnZnv8S1JdnuyHe3LsW+kUaKFZICT8rYksVgG5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94fz7hiVufl+zmeZlbqeo39dAvD5nGoTyoQ6f9SaaWjtd5xPw
	OWkqIqj1a0/TDZ52+BNEHDaP/1Vkp/Ofdc0/JmaLp+ESG1PPBoK5t/vTlE2F43OrMSqjKyy3EsB
	Wi8Bt/TKH68C3qwoK6I+aAGTO2WUC8vY=
X-Gm-Gg: ASbGncsVx/f1ta0QzldhtNmuJAwOkzNQKCTc7T+JopHGkwpHAhfXJ8J3jv919Os1F7X
	erh1d2oNhmNs4yMMF9LhhC0K/IiAnDiHtAPnFD9IZi8yprcA3FVk0WvYRPoaXUzU2lP5Z/lwX3z
	58wG9964xBeNTndNxoabQD8ztrX/IhKxMGalHggK094DrfQUybEMqXuBVLg5qigpKd0IePChhfB
	j9zSZEizOn8qdaUTo8dlstjuj+1ByyR+Lsp7fuMkKKtDr1i8DFpjZaPjUJYzWVzxC+L5c2VIsM9
	R84gcuEavR8=
X-Google-Smtp-Source: AGHT+IGNEehD/IbzmT/eYnqMidws6XqejIuodVpG5l4cgolJSh8b964GFDYeXBLMdMY3NgBpsNfX2tZZfLZTiPrySFg=
X-Received: by 2002:a17:907:7f22:b0:b0c:b51b:81f6 with SMTP id
 a640c23a62f3a-b7053e45459mr371911866b.43.1761839965702; Thu, 30 Oct 2025
 08:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-10-6ffa2c9941c0@suse.cz> <aQLqZjjq1SPD3Fml@hyeyoo>
 <06241684-e056-40bd-88cc-0eb2d9d062bd@suse.cz> <CAADnVQ+K-gWm6KKzKZ0vVwfT2H1UXSoaD=eA1aRUHpA5MCLAvA@mail.gmail.com>
 <5e8e6e92-ba8f-4fee-bd01-39aacdd30dbe@suse.cz>
In-Reply-To: <5e8e6e92-ba8f-4fee-bd01-39aacdd30dbe@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 08:59:14 -0700
X-Gm-Features: AWmQ_bkWAOmvQoKcQyr_zcqHDGMRrBlm9dDGveiPgB0Mj-QwDfGlE8jGMTlojF0
Message-ID: <CAADnVQJ_yzOGAT__EG=eBTHbWeiFgEZ--fHFQNprsX9o0vEQkA@mail.gmail.com>
Subject: Re: [PATCH RFC 10/19] slab: remove cpu (partial) slabs usage from
 allocation paths
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/30/25 16:27, Alexei Starovoitov wrote:
> > On Thu, Oct 30, 2025 at 6:09=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 10/30/25 05:32, Harry Yoo wrote:
> >> > On Thu, Oct 23, 2025 at 03:52:32PM +0200, Vlastimil Babka wrote:
> >> >> diff --git a/mm/slub.c b/mm/slub.c
> >> >> index e2b052657d11..bd67336e7c1f 100644
> >> >> --- a/mm/slub.c
> >> >> +++ b/mm/slub.c
> >> >> @@ -4790,66 +4509,15 @@ static void *___slab_alloc(struct kmem_cach=
e *s, gfp_t gfpflags, int node,
> >> >>
> >> >>      stat(s, ALLOC_SLAB);
> >> >>
> >> >> -    if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> >> >> -            freelist =3D alloc_single_from_new_slab(s, slab, orig_=
size, gfpflags);
> >> >> -
> >> >> -            if (unlikely(!freelist))
> >> >> -                    goto new_objects;
> >> >> -
> >> >> -            if (s->flags & SLAB_STORE_USER)
> >> >> -                    set_track(s, freelist, TRACK_ALLOC, addr,
> >> >> -                              gfpflags & ~(__GFP_DIRECT_RECLAIM));
> >> >> -
> >> >> -            return freelist;
> >> >> -    }
> >> >> -
> >> >> -    /*
> >> >> -     * No other reference to the slab yet so we can
> >> >> -     * muck around with it freely without cmpxchg
> >> >> -     */
> >> >> -    freelist =3D slab->freelist;
> >> >> -    slab->freelist =3D NULL;
> >> >> -    slab->inuse =3D slab->objects;
> >> >> -    slab->frozen =3D 1;
> >> >> -
> >> >> -    inc_slabs_node(s, slab_nid(slab), slab->objects);
> >> >> +    freelist =3D alloc_single_from_new_slab(s, slab, orig_size, gf=
pflags);
> >> >>
> >> >> -    if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin))=
 {
> >> >> -            /*
> >> >> -             * For !pfmemalloc_match() case we don't load freelist=
 so that
> >> >> -             * we don't make further mismatched allocations easier=
.
> >> >> -             */
> >> >> -            deactivate_slab(s, slab, get_freepointer(s, freelist))=
;
> >> >> -            return freelist;
> >> >> -    }
> >> >> +    if (unlikely(!freelist))
> >> >> +            goto new_objects;
> >> >
> >> > We may end up in an endless loop in !allow_spin case?
> >> > (e.g., kmalloc_nolock() is called in NMI context and n->list_lock is
> >> > held in the process context on the same CPU)
> >> >
> >> > Allocate a new slab, but somebody is holding n->list_lock, so tryloc=
k fails,
> >> > free the slab, goto new_objects, and repeat.
> >>
> >> Ugh, yeah. However, AFAICS this possibility already exists prior to th=
is
> >> patch, only it's limited to SLUB_TINY/kmem_cache_debug(s). But we shou=
ld fix
> >> it in 6.18 then.
> >> How? Grab the single object and defer deactivation of the slab minus o=
ne
> >> object? Would work except for kmem_cache_debug(s) we open again a race=
 for
> >> inconsistency check failure, and we have to undo the simple slab freei=
ng fix
> >>  and handle the accounting issue differently again.
> >> Fail the allocation for the debug case to avoid the consistency check
> >> issues? Would it be acceptable for kmalloc_nolock() users?
> >
> > You mean something like:
> > diff --git a/mm/slub.c b/mm/slub.c
> > index a8fcc7e6f25a..e9a8b75f31d7 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4658,8 +4658,11 @@ static void *___slab_alloc(struct kmem_cache
> > *s, gfp_t gfpflags, int node,
> >         if (kmem_cache_debug(s)) {
> >                 freelist =3D alloc_single_from_new_slab(s, slab,
> > orig_size, gfpflags);
> >
> > -               if (unlikely(!freelist))
> > +               if (unlikely(!freelist)) {
> > +                       if (!allow_spin)
> > +                               return NULL;
> >                         goto new_objects;
> > +               }
> >
> > or I misunderstood the issue?
>
> Yeah that would be the easiest solution, if you can accept the occasional
> allocation failures.

yeah. not worried about the slub debug case.
Let's reassess when sheav conversion is over.

