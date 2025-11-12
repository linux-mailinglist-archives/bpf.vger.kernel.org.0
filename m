Return-Path: <bpf+bounces-74331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A54FC549B7
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 22:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8293BA53A
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 21:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F32DECC5;
	Wed, 12 Nov 2025 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g84iIzu7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8A2DE6F8
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982105; cv=none; b=QC3eT4eS1O1LCL6iachRcG8svbAXh+sle/BMJkqkvZOjXBxGvH3QjF7UYFDJl55nnQsNbOVjKMz0kXTYfwy2cb+xdnHKGNJn6m+q/U8S0XUFDKw20AOj9guwb8jU77XBO59eTn9Q2ex/9F+VrjRvER8riKPbwuCclmEgQXcR8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982105; c=relaxed/simple;
	bh=n3f4HWZPOFNW0Esz//T/Kay4Yn+zJwokTI5vJ+JwBiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fru10RbwQ42szoE8Zp4AAm7X3tHk5w8ZGvvgRS1gr0o4jTJNiR9Ylk/sjDvnsxCblJV+RezDI5gviY9lm/lrMi6WdDMbtIGTCKzJqRQCkKtvMuhNS0cE9q0kFLVZ7zEFrHJl+H7rDrEo/27jzHB5hl6EfPV91BgD37ecL/m5bUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g84iIzu7; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63bc1aeb427so76645d50.3
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 13:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762982102; x=1763586902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSxx8TQJuyqJmpWHS687wtXhuaiwB0qu3NOyp9VRHq4=;
        b=g84iIzu7iJyOHDDn8S+ffiibBC20pr3A2ChPO8bWuuOe6ifsEkLfZffggWYrxRKeC6
         ZaueQmn8eppNA5D0OarsCmgbUisO8XfyRpjrhcNBXPLyUa8dSaRsQTMFP32jvoErndjx
         o6aRbjWgD/Tz4WoqsL0pTrA2qsG4tLW9ghkevItGDMUpCDJzskfa2VNzdF+2sY96ueHk
         +d9ku0iY1DAJdobFdrQDF8IJ3+TkpilwPRqvB64CXFPBeYwUPdN8FMdNwuAximbicAor
         mXA+lYh5rB6iod+z038FoZhVczWZjTI3hTnwNK6d0xtuQSUzJHs7TnyAQBp3LFZt2Z8j
         riRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762982102; x=1763586902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YSxx8TQJuyqJmpWHS687wtXhuaiwB0qu3NOyp9VRHq4=;
        b=dPIdQIoHjdRAyPxFqD6U1t9gwKFRjmdhF6wlWU47DzwL+l9zo0QSQzx1qizq66pFas
         KbiJOxjyYzlpoau8Jtlqxhb5FrGwI3G3JcScR0MbD+dmAryIf6vCvCd/DdZTUS+Zt+9u
         VTYIxc6dheEI4AdqY1MIqj5ZZ2nWZJf+Yaxw2ddAXZ3/bGsquj7U/ZM26Qdn0WpNNyod
         nO/KETnP00CNmcGsG7KQyYen33eXBmUuwmBW3uREm4NMgBX0Jv9xy0wTF4ITJtxjSQ+5
         zHZrMFKAvBenkfJb8GnR1VXsJstn5n4tA5U55JEi9zupHLC38giaFEr87KSswuXT/ZiV
         wW1g==
X-Gm-Message-State: AOJu0YzHb4rYvhYR7nqA3zr9UxpdNS+3t/eyTQoQ7GQnjYXwJm2/p64M
	tqbkUnvJh4UvT+D71kRonLF1BchPZ9bv9sfHtoC5309skXjZqoEUY/nPauuIghsGYKg3oImgzQp
	UIqOCYeZUsBlhSHGLw9rRY42llMp5WbFJr/qI
X-Gm-Gg: ASbGncsUitgmu2xkfhpmY1Gp/9vZVaJ1Z7htOiXP7ZOc+0rSnK8Vcz6lUf5qfycSDqK
	F1WN8lHKqj1/IK6WfgLWlTvxFUyWrZ7p4K5IsHnFbz/OD5ePCZjo01PcbPk0qO5EgUmPPYBB2zq
	RaJEVFb+1rhrOtZXrtZBQBVUMWDiC2mdj8cazwwexx61UvJ8b/lqpDwJ1J9No3ApgFDg3yFSgr/
	L7IMjQqmRJETLuxvAIEpt624/70Ivy/jM51VaoOO7p/vjLJG7vMQ/uPrL/4
X-Google-Smtp-Source: AGHT+IEj9MWU8FX0gimdh9L/S/QDhTr82ZkgzJjHFZjMFkTY0snmbuO2jEKKQUPpksqIp+ahbcz0pWUhOnHCR/Vjcfg=
X-Received: by 2002:a05:690e:418b:b0:641:718:8a17 with SMTP id
 956f58d0204a3-64107188c64mr2047078d50.53.1762982102458; Wed, 12 Nov 2025
 13:15:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112175939.2365295-1-ameryhung@gmail.com> <20251112175939.2365295-3-ameryhung@gmail.com>
 <CAADnVQ+2OXNo99B2krjwOb5XeFhi6GUagotcyf36xvLDoHqmjw@mail.gmail.com>
 <CAMB2axM0-NF5F=O6Lq1WPbb8PJtdZrQaOTFKWApWEhfT7MD4hw@mail.gmail.com> <CAADnVQKWKC3oh6ycxE+tstYupwVsdbhYHOncnfTOFWLL2DmJjw@mail.gmail.com>
In-Reply-To: <CAADnVQKWKC3oh6ycxE+tstYupwVsdbhYHOncnfTOFWLL2DmJjw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 12 Nov 2025 13:14:51 -0800
X-Gm-Features: AWmQ_bmzsOHzTZ6ufxz1ivFzx1AQCvdWVNQiLoxhMXVG-_tD4QdPQq6TFyfYMAI
Message-ID: <CAMB2axOEauSyi13-acjDJUB--8+V7ZUG+r2V=fATwZHDQjFH4w@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/2] bpf: Use kmalloc_nolock() in local
 storage unconditionally
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 12:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 12, 2025 at 11:51=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > On Wed, Nov 12, 2025 at 11:35=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Nov 12, 2025 at 9:59=E2=80=AFAM Amery Hung <ameryhung@gmail.c=
om> wrote:
> > > >
> > > > @@ -80,23 +80,12 @@ bpf_selem_alloc(struct bpf_local_storage_map *s=
map, void *owner,
> > > >         if (mem_charge(smap, owner, smap->elem_size))
> > > >                 return NULL;
> > > >
> > > > -       if (smap->bpf_ma) {
> > > > -               selem =3D bpf_mem_cache_alloc_flags(&smap->selem_ma=
, gfp_flags);
> > > > -               if (selem)
> > > > -                       /* Keep the original bpf_map_kzalloc behavi=
or
> > > > -                        * before started using the bpf_mem_cache_a=
lloc.
> > > > -                        *
> > > > -                        * No need to use zero_map_value. The bpf_s=
elem_free()
> > > > -                        * only does bpf_mem_cache_free when there =
is
> > > > -                        * no other bpf prog is using the selem.
> > > > -                        */
> > > > -                       memset(SDATA(selem)->data, 0, smap->map.val=
ue_size);
> > > > -       } else {
> > > > -               selem =3D bpf_map_kzalloc(&smap->map, smap->elem_si=
ze,
> > > > -                                       gfp_flags | __GFP_NOWARN);
> > > > -       }
> > > > +       selem =3D bpf_map_kmalloc_nolock(&smap->map, smap->elem_siz=
e, gfp_flags, NUMA_NO_NODE);
> > >
> > >
> > > Pls enable CONFIG_DEBUG_VM=3Dy then you'll see that the above trigger=
s:
> > > void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> > > {
> > >         gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_fla=
gs;
> > > ...
> > >         VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
> > >                                       __GFP_NO_OBJ_EXT));
> > >
> > > and benchmarking numbers have to be redone, since with
> > > unsupported gfp flags kmalloc_nolock() is likely doing something wron=
g.
> >
> > I see. Thanks for pointing it out. Currently the verifier determines
> > the flag and rewrites the program based on if the caller of
> > storage_get helpers is sleepable. I will remove it and redo the
> > benchmark.
>
> yes. that part of the verifier can be removed too.
> First I would redo the benchmark numbers with s/gfp_flags/0 in the above =
line.

Here are the new numbers after setting gfp_flags =3D __GFP_ZERO and
removing memset(0). BTW, the test is done on a physical machine. The
numbers for sk local storage can change =C2=B11-2. I will try to increase
the test iteration or kill other unnecessary things running on the
machine to see if the number fluctuates less.

Socket local storage
memory alloc     batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
kzalloc           16    104.217 =C2=B1 0.974k/s  4.15 kmallocs/create
(before)          32    104.355 =C2=B1 0.606k/s  4.13 kmallocs/create
                  64    103.611 =C2=B1 0.707k/s  4.15 kmallocs/create

kmalloc_nolock    16    100.402 =C2=B1 1.282k/s  1.11 kmallocs/create  -3.7=
%
(after)           32    101.592 =C2=B1 0.861k/s  1.07 kmallocs/create  -2.6=
%
                  64     98.995 =C2=B1 0.868k/s  1.07 kmallocs/create  -4.6=
%

Task local storage
memory alloc     batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
BPF memory        16     24.668 =C2=B1 0.121k/s  2.54 kmallocs/create
allocator         32     22.899 =C2=B1 0.097k/s  2.67 kmallocs/create
(before)          64     22.559 =C2=B1 0.076k/s  2.56 kmallocs/create

kmalloc_nolock    16     25.659 =C2=B1 0.108k/s  2.51 kmallocs/create  +4.0=
%
(after)           32     23.723 =C2=B1 0.082k/s  2.54 kmallocs/create  +3.6=
%
                  64     23.359 =C2=B1 0.236k/s  2.48 kmallocs/create  +3.5=
%

