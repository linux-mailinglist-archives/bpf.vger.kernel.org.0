Return-Path: <bpf+bounces-74325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44DC54450
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 20:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D61193425E5
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 19:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C2F2C0293;
	Wed, 12 Nov 2025 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRlq5pbU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CDE296BB6
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977101; cv=none; b=qRG6Wn1NFKhHtpDpKAS58XSaF9BcFQdf+9HXcEOhLkQ71z2ZZg6+HC0SEnYwYozFYiqmgFUHhWJxBcSj3k5QdWEOubRkWZTHe5VQH/2ZT7IFdR7IMcvAgyShEwvT02rAxTiVGHOkESmVDoN1OYjnnQFU84D3qykb5diXEwGnM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977101; c=relaxed/simple;
	bh=V7wPAPhq8x5M4/YATnSSgKnLhUMD6c5KAFlBJaCrEcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k50JnU4rltupVXbErRWbIxZU+eqTAFSug9s09O+lIyBs0Y5DzNtld/JtHeKqzXMmxxMv6wcFrkuUIqr1hVEpARovfnLAM3oXI1aW8vqpmBduQbauSAZ1QB+0LkhCMjuqlIZM8SLQdHvuToyyl3mgZtrv95AvzUa0RpJJMJHPsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRlq5pbU; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640daf41b19so107498d50.0
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 11:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762977099; x=1763581899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJYfN17bLgWls35SPZiZd6WIyEOIlB4gSdWvVkAzlr0=;
        b=IRlq5pbUznrI3p0eO6q0knA44P/+AiWMoaGFlQwG+SrkMrzBz3TOYyDWfeK6TY3ut/
         iN41IlYjjTWA7K6O1KI3XhyjYmM1bLWLj1mm8mmclKXjxoow1CD78Ac/D8z11bgJOPYt
         dZdWdQ2TwmULfBBzPBMia3VURW1JFUdVMl+3yCfQLVKazdphw4W7tNodJ4syfGvB6Q0C
         rn8ch8f9tHSJ7f3m7YZeVfcDrumeap4Kzc5J+o+kHjuS9tK+m8yp4M34xEqn8rhsjioI
         3d8QDVGWQkSD7V2bU77zKFQ1sOGZMkHft7p91BjiaUsPxmcHGArZwTnQunA7lseKwbKE
         oSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762977099; x=1763581899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJYfN17bLgWls35SPZiZd6WIyEOIlB4gSdWvVkAzlr0=;
        b=g2YDvHsEdFmN64HLDBo3cCTg8uD0tAwDQ6KN2wOWYvEEPgx18r/V/ScAYltLsvFJfZ
         XKiOhofM4fQH6YkJR5EeGFWZ2FsyrhWQ28eDlLk2kAP7U8FoX0GARV6LxLSp0uVOXM34
         fViqve3M50o5xLSCrINO9UkSdlbOLmRh8/BM5rgnQFAC8f1xn0Ni0R7B/yPPT7jPhZJ8
         6VWRmIfmPh6/CN9TYJGEPJt9iJvv/el9TXvuAIcBI00EV49sN0RDV0+uJm5QUfMnCL0a
         pW3o6zdYTHnDIj9GHYo98R6tVDPuXj+VSxb6RV7h6hz8qAcxLNYHAk5GmsGUWU2NkqpU
         I6qg==
X-Gm-Message-State: AOJu0Yw2YBkvNEk4KozjE1DFeymxUhmSmnPUykaMCAUePiQt52bJW9sN
	Mx5DxXzGAdOZiz0E4KWmPa8xTD90E0P09yi+d91QiFdsqTPvJrPZFIG4ZRWxr4zrLF6SS+sarb1
	0CjT8Ki/+LpdKHJdSmu6ghO7eS8n3XaY=
X-Gm-Gg: ASbGncu/GSuPf/OWGYIE46P3jkuIOzPHpWGZFFakQp5/HGCPv8se4ItzjWZIOdDAPwG
	gYTI/5LJPmEZ5ljLHXjZltSnW+F++OoGMBrwG8cvLs3xpiGYVPqHz3nOBVspLQm7KxQfhly1k6Y
	j1cLZsBQ4VZvLaFEb782F554BifED88hxrTG67Ub1pu30ZABi7+foGNUKT6binXxMaTzwLp6kYV
	Kgj6zyZ+OHjEDaVIsc2U0YtTM3gIeTT/8L3NDl9En5y/2g63WK6Oz/Dj7n6
X-Google-Smtp-Source: AGHT+IHDvGelbxCEpK08X9r207VkXnI6e8GlcXrImEfkUYHEMat+XgVVkEQp76J/ax+q5wAadKI+yMtJcBgjHF3gClc=
X-Received: by 2002:a05:690e:1188:b0:63f:ac46:65d8 with SMTP id
 956f58d0204a3-6410d06e1b5mr538850d50.3.1762977098680; Wed, 12 Nov 2025
 11:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112175939.2365295-1-ameryhung@gmail.com> <20251112175939.2365295-3-ameryhung@gmail.com>
 <CAADnVQ+2OXNo99B2krjwOb5XeFhi6GUagotcyf36xvLDoHqmjw@mail.gmail.com>
In-Reply-To: <CAADnVQ+2OXNo99B2krjwOb5XeFhi6GUagotcyf36xvLDoHqmjw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 12 Nov 2025 11:51:28 -0800
X-Gm-Features: AWmQ_bkgyQAPwH2MCTZ9FGX8d6QE2vx9BF5-S96K2YJAQhbC8GqslofJzqi52-k
Message-ID: <CAMB2axM0-NF5F=O6Lq1WPbb8PJtdZrQaOTFKWApWEhfT7MD4hw@mail.gmail.com>
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

On Wed, Nov 12, 2025 at 11:35=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 12, 2025 at 9:59=E2=80=AFAM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > @@ -80,23 +80,12 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap,=
 void *owner,
> >         if (mem_charge(smap, owner, smap->elem_size))
> >                 return NULL;
> >
> > -       if (smap->bpf_ma) {
> > -               selem =3D bpf_mem_cache_alloc_flags(&smap->selem_ma, gf=
p_flags);
> > -               if (selem)
> > -                       /* Keep the original bpf_map_kzalloc behavior
> > -                        * before started using the bpf_mem_cache_alloc=
.
> > -                        *
> > -                        * No need to use zero_map_value. The bpf_selem=
_free()
> > -                        * only does bpf_mem_cache_free when there is
> > -                        * no other bpf prog is using the selem.
> > -                        */
> > -                       memset(SDATA(selem)->data, 0, smap->map.value_s=
ize);
> > -       } else {
> > -               selem =3D bpf_map_kzalloc(&smap->map, smap->elem_size,
> > -                                       gfp_flags | __GFP_NOWARN);
> > -       }
> > +       selem =3D bpf_map_kmalloc_nolock(&smap->map, smap->elem_size, g=
fp_flags, NUMA_NO_NODE);
>
>
> Pls enable CONFIG_DEBUG_VM=3Dy then you'll see that the above triggers:
> void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> {
>         gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
> ...
>         VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
>                                       __GFP_NO_OBJ_EXT));
>
> and benchmarking numbers have to be redone, since with
> unsupported gfp flags kmalloc_nolock() is likely doing something wrong.

I see. Thanks for pointing it out. Currently the verifier determines
the flag and rewrites the program based on if the caller of
storage_get helpers is sleepable. I will remove it and redo the
benchmark.

Thanks,
Amery

