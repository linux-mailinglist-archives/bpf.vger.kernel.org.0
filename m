Return-Path: <bpf+bounces-41070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6775F992081
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 21:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298BC281A4B
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736C18A935;
	Sun,  6 Oct 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzK+NVy7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8718A6D3;
	Sun,  6 Oct 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728241219; cv=none; b=h7MiuVYBsEVbOh6L1OyDTg0GYHEU/IBdosaSfEirjASfGqxt6OTtcAcv4IclYHEup2X+Hs6tU6t1cl8pLAluupg3Z0wCVg7gOa9wHlLSgK+BzatjGlMldIIZdC/WqJkyL69dPm9+/rjO4D4SLnZFSIQmnfe41K2g3G7oN8huRgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728241219; c=relaxed/simple;
	bh=iwFEjW6d6zkYqFBkePAlQ+Q5V3zdYkn/YSKeM+fBUbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klzQtDgaQHyiR6iNracDyS7ZxqQZegorcMVb8nMnPzwwhJQEr22orjUCyyodrHVKl/toXk7pyh9Pwej+a9UuaBCROpZIMHeE/Z0CcEcxfoaeyXkaaV92wYf4y3F7le2Vg+QaY+sLWlTFXYpGcdhw9sxQ6urFPxE1X8c5hJgE13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzK+NVy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1838C4CEC5;
	Sun,  6 Oct 2024 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728241218;
	bh=iwFEjW6d6zkYqFBkePAlQ+Q5V3zdYkn/YSKeM+fBUbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzK+NVy77xMQ8mnIGl5r8YW8+gaIHZFA6eeSX7S+J2wGME1FquMnX2XrvprpuspJ/
	 wWftMSgXu4tb51+8QCqI5+J/FfvpQoK8P/aT32PjEJpKaYVBwq5N6exYbVI960FKf4
	 MuZi4T66F8wsD1e9FJY64FroxojUCkPGziLTseK1oxwQNuM4demxK2/L8H6rq3fmcf
	 zgfgLJLn+s28cs5KgVvtP/nmmMXoGLKIg33u65qtj2P3gyKBgFa6lcZqTrYYAi2V0H
	 9THLt3UC4ktBSh+8huDttITbxGHk2fUbmhf65cP2h5PZtvq3Y6fALp1j9XEp2Z9K98
	 /zbaqJVyWTRug==
Date: Sun, 6 Oct 2024 12:00:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm <linux-mm@kvack.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Message-ID: <ZwLeQO6KxAh7YNvt@google.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
 <ZwBdS86yBtOWy3iD@google.com>
 <CAPhsuW6AhfG7Xv2izDYnMM+z03X29peZfmWNy0rf98aEaAUfVg@mail.gmail.com>
 <ZwBk8i23odCe7qVK@google.com>
 <CAPhsuW4AjZMQxCbqYmEgbnkP0gWenKo4wVi8tW1zYcsaF5h7iQ@mail.gmail.com>
 <CAADnVQK0VQXvxqxm6WudyeLao1L+jMTvmUauciBc8_vcLcR=vQ@mail.gmail.com>
 <CAPhsuW6gB5PaNDQ5x20oRXUtgf7KPNTQpN_WLvtYm=-7CLhn-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6gB5PaNDQ5x20oRXUtgf7KPNTQpN_WLvtYm=-7CLhn-g@mail.gmail.com>

Hello,

On Fri, Oct 04, 2024 at 04:56:57PM -0700, Song Liu wrote:
> On Fri, Oct 4, 2024 at 4:44 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> [...]
> > > diff --git i/kernel/bpf/helpers.c w/kernel/bpf/helpers.c
> > > index 3709fb142881..7311a26ecb01 100644
> > > --- i/kernel/bpf/helpers.c
> > > +++ w/kernel/bpf/helpers.c
> > > @@ -3090,7 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> > >  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> > >  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> > >  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> > > -BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
> > > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL | KF_TRUSTED_ARGS
> > > | KF_RCU_PROTECTED)
> >
> > I don't think KF_TRUSTED_ARGS approach would fit here.
> > Namhyung's use case is tracing. The 'addr' will be some potentially
> > arbitrary address from somewhere. The chance to see a trusted pointer
> > is probably very low in such a tracing use case.
> 
> I thought the primary use case was to trace lock contention, for
> example, queued_spin_lock_slowpath(). Of course, a more
> general solution is better.

Right, my intended use case is the lock contention profiling so probably
it's ok to limit it for trusted pointers if it helps.  But as Song said,
a general solution should be better. :)

> 
> >
> > The verifier change can mainly be the following:
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7d9b38ffd220..e09eb108e956 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12834,6 +12834,9 @@ static int check_kfunc_call(struct
> > bpf_verifier_env *env, struct bpf_insn *insn,
> >                         regs[BPF_REG_0].type = PTR_TO_BTF_ID;
> >                         regs[BPF_REG_0].btf_id = ptr_type_id;
> >
> > +                       if (meta.func_id == special_kfunc_list[KF_get_kmem_cache])
> > +                               regs[BPF_REG_0].type |= PTR_UNTRUSTED;
> > +
> >                         if (is_iter_next_kfunc(&meta)) {
> >                                 struct bpf_reg_state *cur_iter;
> 
> This is easier than I thought.

Indeed!  Thanks for providing the code.

> 
> > The returned 'struct kmem_cache *' won't be refcnt-ed (acquired).
> > It will be readonly via ptr_to_btf_id logic.
> > s->flags;
> > s->size;
> > s->offset;
> > access will be allowed but the verifier will sanitize them
> > with an inlined version of probe_read_kernel.
> > Even KF_RET_NULL can be dropped.

Ok, I'll check this out.  By having PTR_UNTRUSTED, are the callers
still required to check NULL or is it handled by probe_read_kernel()?

Thanks,
Namhyung

