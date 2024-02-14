Return-Path: <bpf+bounces-22008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B31B855046
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E762B284EC3
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060A84FDF;
	Wed, 14 Feb 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUxh5Nat"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF284FC9
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931466; cv=none; b=gjVHP5oe8kwryGVMDfbs2XVB72LF2nEoB59hGH2ZnWdQJf8zSm4sLHNN25nvOd0/rHLAEtFe1JPryowLxrW38zF+1ZtrvHn84s/ORDwLdkOTjoGMYO6ke6L2E5uzTrx3/3GnfEYQ74IfIFhPEhJ4mxC2aOJwWhiJ2bq2cAT5oN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931466; c=relaxed/simple;
	bh=7MKIm+BZFGarc08fO9i5p4oGbPfnH1oOrTTEk1DU3gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dt1Pzg5sFmsY7Iteqtt0FoZKGAMUFyA6nHjOy/QpSyT/i66WvSy67l6VUx9FI4eAHtZJSKhxbUWfrD57xhd7xyPKoSGRmxu48TgXclI6FDNkkDld1OHdLpOkSEPxJYl0Q6/bV7y1PaJkXph4jczhqp/WcuenrJDk5m7nYMrTcBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUxh5Nat; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e10746c6f4so13415b3a.2
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 09:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707931464; x=1708536264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6qAbhUtem/s1YgKm360zEs1FN7y6mvxL+lYin6s8rw=;
        b=QUxh5NatpsEGa/ATKDJesngtemjo0286esDmyXMko72601Z2mQv0ep63uuKOyfJf7x
         JMog6o3zZ86Ssw7LhlBvNcWXyGrkY+mOGgl/O4EsUZ7RjXs3SSZwY/LamIeuDVGty5KX
         QQpN7KLMIuZkmF3Z19EqKVBG16YYnfK6ruioacHbuqo2//x/CFz/SRdAjZDomyzFRy8p
         IuGPRYWZbFNZgXL9q+uxI52hhKPIDJtsSayEUXkXjAqQ5ZtGcxDuJu3+IIl5/JosyF6W
         6yOyiSh82hLer+VsajvLv+nkJw3qSbqJbj7lYgbINIzI0dHM8em93kgxCcE94/77HLVX
         urlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931464; x=1708536264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6qAbhUtem/s1YgKm360zEs1FN7y6mvxL+lYin6s8rw=;
        b=crRalOaXtuvhwcsMCNMv5n2BQL5neyRc/miCQkX7YyQehRsmqfQSyPdG9TAXWG0GFd
         eJg+FKbe89Lat0lUCg2K8XAcZdFZgaK4sF/X2YCRfn+1zbKI3j8WSscmwQSYcmawOqRn
         Y3K/dUt8U2camCpmXG5oVIUcPYt1D8WNWlmdVGwVvCmN8BooDelY+ApXscFpielhV46r
         36X+6uUyXxFZQfz/4VWmbtAOfndlMbhdONFKu7ekKamU7gSTD0/0ydu30gkFfbLDHsOO
         2L5+46JTHZ+VcvxYBtzgB7BZQf4KqYTgojAqwQdMbF0pbRelaxjRzozhLDFPHwo+tXlF
         yL+w==
X-Forwarded-Encrypted: i=1; AJvYcCU/G5YGVT4lPtiK0ijHUM3Not7mW1yvwGy/gNHcdpEkICBRb5vmPh4S91iRHLxhhmTHaKsuJ2JAQagkVQLnRk/t/cI1
X-Gm-Message-State: AOJu0Ywtmeqs5xPr2P7gk11H7u9ez6HGUx3LEz2pYOYmvuff9MD3qbXV
	MyP8MwixDwk13ldY8vwTe4kpQtJ/H/vnvPMt5QNvObZrRhRq1+OVbgjWKPP70MvzFg6z+vM3zqc
	78LMw1q+nInoNXnPFSzm/zirERhQ=
X-Google-Smtp-Source: AGHT+IGwGGW7d+E2Ow0+w4Z2OiiBv3qgTxH7Wd3Ycop1PVBco9owHvyGcMfM/zsGNspZhGCVjiyWgo3IsSv+hbpu8CM=
X-Received: by 2002:a05:6a20:e68c:b0:19e:b96e:e6b with SMTP id
 mz12-20020a056a20e68c00b0019eb96e0e6bmr4228071pzb.19.1707931463713; Wed, 14
 Feb 2024 09:24:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-15-alexei.starovoitov@gmail.com> <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
 <CAEf4BzYbkqhrPCY1RfyHHY1nq-fmpxP2O-n0gMzWoDFe4Msofw@mail.gmail.com>
 <7af0d2e0cc168eb8f57be0fe185d7fa9caf87824.camel@gmail.com>
 <CAEf4BzZyPDdtV8xyFxpLmPQpKrtO-affGrEfyDkodr_BDHVZcA@mail.gmail.com> <CAADnVQKY0UKYRUBmUZ8BPUrcx-t-v6iMz7u0AaBUKLB1-CS0qg@mail.gmail.com>
In-Reply-To: <CAADnVQKY0UKYRUBmUZ8BPUrcx-t-v6iMz7u0AaBUKLB1-CS0qg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 14 Feb 2024 09:24:11 -0800
Message-ID: <CAEf4BzY8grOqDUOAuvyBw+t1oZh6x_6xubHePv3byxV3sC9uVg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 5:24=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 13, 2024 at 4:09=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Feb 13, 2024 at 3:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2024-02-13 at 15:17 -0800, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > > So, at first I thought that having two maps is a bit of a hack.
> > > >
> > > > yep, that was my instinct as well
> > > >
> > > > > However, after trying to make it work with only one map I don't r=
eally
> > > > > like that either :)
> > > >
> > > > Can you elaborate? see my reply to Alexei, I wonder how did you thi=
nk
> > > > about doing this?
> > >
> > > Relocations in the ELF file are against a new section: ".arena.1".
> > > This works nicely with logic in bpf_program__record_reloc().
> > > If single map is used, we effectively need to track two indexes for
> > > the map section:
> > > - one used for relocations against map variables themselves
> > >   (named "generic map reference relocation" in the function code);
> > > - one used for relocations against ".arena.1"
> > >   (named "global data map relocation" in the function code).
> > >
> > > This spooked me off:
> > > - either bpf_object__init_internal_map() would have a specialized
> > >   branch for arenas, as with current approach;
> > > - or bpf_program__record_reloc() would have a specialized branch for =
arenas,
> > >   as with one map approach.
> >
> > Yes, relocations would know about .arena.1, but it's a pretty simple
> > check in a few places. We basically have arena *definition* sec_idx
> > (corresponding to SEC(".maps")) and arena *data* sec_idx. The latter
> > is what is recorded for global variables in .arena.1. We can remember
> > this arena data sec_idx in struct bpf_object once during ELF
> > processing, and then just special case it internally in a few places.
>
> That was my first attempt and bpf_program__record_reloc()
> became a mess.
> Currently it does relo search either in internal maps
> or in obj->efile.btf_maps_shndx.
> Doing double search wasn't nice.
> And further, such dual meaning of 'struct bpf_map' object messes
> assumptions of bpf_object__shndx_is_maps, bpf_object__shndx_is_data
> and the way libbpf treats map->libbpf_type everywhere.
>
> bpf_map__is_internal() cannot really say true or false
> for such dual use map.
> Then skeleton gen gets ugly.
> Needs more public libbpf APIs to use in bpftool gen.
> Just a mess.

It might be easier for me to try implement it the way I see it than
discuss it over emails. I'll give it a try today-tomorrow and get back
to you.

>
> > The "fake" bpf_map for __arena_internal is user-visible and requires
> > autocreate=3Dfalse tricks, etc. I feel like it's a worse tradeoff from =
a
> > user API perspective than a few extra ARENA-specific internal checks
> > (which we already have a few anyways, ARENA is not completely
> > transparent internally anyways).
>
> what do you mean 'user visible'?

That __arena_internal (representing .area.1 data section) actually is
separate from actual ARENA map (represented by variable in .maps
section). And both have separate `struct bpf_map`, which you can look
up by name or through iterating all maps of bpf_object. And that you
can call getters/setters on __arena_internal, even though the only
thing that actually makes sense there is bpf_map__initial_value(),
which would just as much make sense on ARENA map itself.

> I can add a filter to avoid generating a pointer for it in a skeleton.
> Then it won't be any more visible than other bss/data fake maps.

bss/data are not fake maps, they have corresponding BPF map (ARRAY) in
the kernel. Which is different from __arena_internal. And even if we
hide it from skeleton, it's still there in bpf_object, as I mentioned
above.

Let me try implementing what I have in mind and see how bad it is.

> The 2nd fake arena returns true out of bpf_map__is_internal.
>
> The key comment in the patch:
>                 /* bpf_object will contain two arena maps:
>                  * LIBBPF_MAP_ARENA & BPF_MAP_TYPE_ARENA
>                  * and
>                  * LIBBPF_MAP_UNSPEC & BPF_MAP_TYPE_ARENA.
>                  * The former map->arena will point to latter.
>                  */

Yes, and I'd like to not have two arena maps because they are logically one=
.

