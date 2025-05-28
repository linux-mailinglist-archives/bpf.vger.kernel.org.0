Return-Path: <bpf+bounces-59087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DA6AC603C
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6F87B0EAE
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6F91EF363;
	Wed, 28 May 2025 03:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSNX0yNv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20B1EB193
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 03:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404089; cv=none; b=n0yJdD2KbnXVbnqOtyZrGV2No3Jb1qKjCzngqXpwGSEtHKIkKxtfsObww2L/U1cXQL3zRPV1P7dzB9sVvqaGXYa5EKgbuw53LHYPrMHRtnPnxo+5mkg9TWI1+d7Z2H0djbDfQno3+SNnwYMvyOVL6aXNBoEhHs1Hot8SvZU0S+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404089; c=relaxed/simple;
	bh=WRdWk5k0DzvC0IqnH5+irBEy6lu1z+vAHhkMr1DodwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0r05uFCuiLg9QpiivgxnP1Yx38GHSyCZI7dTT80FIRBdIWe1xwVEg9fgar6RnF9Ki9zWW0typntzdBRarf6EtTHfsEJH+Wls/uusJmnc2hTCMu4SAHjPdSK46qeRxGpbtRCq2xrI2Nz2tySIBz7HGyFQocjvyBBPpj2PjJqatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OSNX0yNv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2348ac8e0b4so74465ad.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 20:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748404087; x=1749008887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77lpftD4KhYJa03QspdPV4v3SobsW6lQYU4wBXhrxZo=;
        b=OSNX0yNvPRjVJbv8rriH2T4DpqMb/MAuqtue1V8P+dEBLnhf+CHdnkdWEsriB98G+W
         /C2k3anpWf42PhuX1ufIk7vv+19duXyAVIOp8bxTy6VdgizOrh7FLrJnyDBIcrqyNwb2
         ygUnYiXGXxrlPhqkNAKNrAxuTXeskI0RyLB1XdPK42hXRHGjsyM2rUsQoipOvFXqhcjj
         FbXTffR+BBMuymiMkwgclaeRGD/hcBxQfDo46KMIONu2gExpUSUX8LP0PLGmqePlrayO
         J6Q8M0lB+IuKIBSFTAXZe5ZosSUbjU+Iqv37hcv1YpsmcPJcBCIEVFk1Q0DUSNE9t0pD
         tUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404087; x=1749008887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77lpftD4KhYJa03QspdPV4v3SobsW6lQYU4wBXhrxZo=;
        b=Ex3QBd5I7lSYs1ZDpyUt8jKMoV/PEqv261+EO3dMWdquASHpkB2lFEI0yL72cVYYHO
         52u88YdDQxf5kLsngcMf16gouscI2Ny8eCXaf3nnBcflyJBgGK7mnGl+f17AEzMcYdkP
         KlPWN/FY6ZYyjhhIDBcwfFFuJkCquGhFQHe5tCzBZIzg0DLy/3so1CxM+vH5142LUaY6
         MLTD4twKDDFLX5bPU0ggOjAib5d+mHO2govkLfT6K/5t5ym1EY1sCpR47KSc0SE5lH5g
         gysPV7ImpZMk27GWts8wVAwCL3gQxV5lPRgU2rfx0XPQur1MAr90bvttCz3BWJj+sBIm
         lXgg==
X-Forwarded-Encrypted: i=1; AJvYcCWN7esrcENyUmtBkKgWHaG+E64EwckUovjESbJR8I1/hLneIgkdBiWB8qEk1lYoPlnvvmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbu5o9NSdowaFA/DSEboG2DVE47w8BVT1SLYt2sqsQQw3xbJg
	0ebcrrLyaJm4X2qODpRkZAoHawGUCNMVBSL9pRbrsiBnDVTua7gjzC9xkWP97puTNPXqd8AdLMn
	pnQRNlmJ4i9sr0d6/OypUkRxzHTa5tVjO87bQRwlR
X-Gm-Gg: ASbGncspal6I9QhSsrS6N6Dj3olnRS2zTQnu5Ld9SYmdo3iNgIQ2Jim4UZpV4x9IPR3
	NdqN4SgMm+2t2QP8TPZ7+limOEiQB1tNLQyA4PGaKqx8r14ebnpiXuQQcxboIN+p1QnxTOq19KR
	Wrkwi2CDmuMNEJmEoiAsOg4+sNd2ts6+pO6tv9bfBRTcK53X4l0a5T20A=
X-Google-Smtp-Source: AGHT+IELYX3baDhkEuyXGmGEeTAzQv2FBMw+rcqLgCf+Ug/FNV2eDBLVmigKMRQ56cVnnFtdrOccuMw8Li7FXvRWEmY=
X-Received: by 2002:a17:902:cf12:b0:231:f3a3:17c6 with SMTP id
 d9443c01a7336-234c55ab59fmr1800515ad.20.1748404086759; Tue, 27 May 2025
 20:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-2-byungchul@sk.com>
 <20250527025047.GA71538@system.software.com> <CAHS8izOJ6BEhiY6ApKuUkKw8+_R_pZ7kKwE9NqzCyC=g_2JGcA@mail.gmail.com>
 <20250528012152.GA2986@system.software.com>
In-Reply-To: <20250528012152.GA2986@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:47:54 -0700
X-Gm-Features: AX0GCFuLfWYjOWpLxh-E2UEV1XJgFAUhM-h1hCiR1nhwAiLxgjKaWTaZkFY7k1w
Message-ID: <CAHS8izMvRrG2wpE7HEyK3t544-wN_h3SC8nGabCoPWj1qCv_ag@mail.gmail.com>
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 6:22=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Tue, May 27, 2025 at 01:03:32PM -0700, Mina Almasry wrote:
> > On Mon, May 26, 2025 at 7:50=E2=80=AFPM Byungchul Park <byungchul@sk.co=
m> wrote:
> > >
> > > On Fri, May 23, 2025 at 12:25:52PM +0900, Byungchul Park wrote:
> > > > To simplify struct page, the page pool members of struct page shoul=
d be
> > > > moved to other, allowing these members to be removed from struct pa=
ge.
> > > >
> > > > Introduce a network memory descriptor to store the members, struct
> > > > netmem_desc, reusing struct net_iov that already mirrored struct pa=
ge.
> > > >
> > > > While at it, relocate _pp_mapping_pad to group struct net_iov's fie=
lds.
> > > >
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > ---
> > > >  include/linux/mm_types.h |  2 +-
> > > >  include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++---=
----
> > > >  2 files changed, 37 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > > index 56d07edd01f9..873e820e1521 100644
> > > > --- a/include/linux/mm_types.h
> > > > +++ b/include/linux/mm_types.h
> > > > @@ -120,13 +120,13 @@ struct page {
> > > >                       unsigned long private;
> > > >               };
> > > >               struct {        /* page_pool used by netstack */
> > > > +                     unsigned long _pp_mapping_pad;
> > > >                       /**
> > > >                        * @pp_magic: magic value to avoid recycling =
non
> > > >                        * page_pool allocated pages.
> > > >                        */
> > > >                       unsigned long pp_magic;
> > > >                       struct page_pool *pp;
> > > > -                     unsigned long _pp_mapping_pad;
> > > >                       unsigned long dma_addr;
> > > >                       atomic_long_t pp_ref_count;
> > > >               };
> > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > index 386164fb9c18..08e9d76cdf14 100644
> > > > --- a/include/net/netmem.h
> > > > +++ b/include/net/netmem.h
> > > > @@ -31,12 +31,41 @@ enum net_iov_type {
> > > >  };
> > > >
> > > >  struct net_iov {
> > > > -     enum net_iov_type type;
> > > > -     unsigned long pp_magic;
> > > > -     struct page_pool *pp;
> > > > -     struct net_iov_area *owner;
> > > > -     unsigned long dma_addr;
> > > > -     atomic_long_t pp_ref_count;
> > > > +     /*
> > > > +      * XXX: Now that struct netmem_desc overlays on struct page,
> > > > +      * struct_group_tagged() should cover all of them.  However,
> > > > +      * a separate struct netmem_desc should be declared and embed=
ded,
> > > > +      * once struct netmem_desc is no longer overlayed but it has =
its
> > > > +      * own instance from slab.  The final form should be:
> > > > +      *
> > > > +      *    struct netmem_desc {
> > > > +      *         unsigned long pp_magic;
> > > > +      *         struct page_pool *pp;
> > > > +      *         unsigned long dma_addr;
> > > > +      *         atomic_long_t pp_ref_count;
> > > > +      *    };
> > > > +      *
> > > > +      *    struct net_iov {
> > > > +      *         enum net_iov_type type;
> > > > +      *         struct net_iov_area *owner;
> > > > +      *         struct netmem_desc;
> > > > +      *    };
> > > > +      */
> > > > +     struct_group_tagged(netmem_desc, desc,
> > >
> > > So..  For now, this is the best option we can pick.  We can do all th=
at
> > > you told me once struct netmem_desc has it own instance from slab.
> > >
> > > Again, it's because the page pool fields (or netmem things) from stru=
ct
> > > page will be gone by this series.
> > >
> > > Mina, thoughts?
> > >
> >
> > Can you please post an updated series with the approach you have in
> > mind? I think this series as-is seems broken vis-a-vie the
> > _pp_padding_map param move that looks incorrect. Pavel and I have also
> > commented on patch 18 that removing the ASSERTS seems incorrect as
> > it's breaking the symmetry between struct page and struct net_iov.
>
> I told you I will fix it.  I will send the updated series shortly for
> *review*.  However, it will be for review since we know this work can be
> completed once the next works have been done:
>
>    https://lore.kernel.org/all/20250520205920.2134829-2-anthony.l.nguyen@=
intel.com/
>    https://lore.kernel.org/all/1747950086-1246773-9-git-send-email-tariqt=
@nvidia.com/
>
> > It's not clear to me if the fields are being removed from struct page,
> > where are they going... the approach ptdesc for example has taken is
>
> They are going to struct net_iov.

Oh. I see. My gut reaction is I'm not sure moving the page_pool fields
to struct net_iov will work.

struct net_iov shares some fields with struct page, but abstractly
it's very different.

struct page is allocated by the mm stack via things like alloc_pages
and can be passed to mm apis such as put_page() (called from
skb_frag_ref) and vm_insert_batch (called from
tcp_zerocopy_vm_insert_batch_error).

struct net_iov is kvmalloced by networking code (see
net_devmem_bind_dmabuf for example), and *must not* be passed to any
mm apis as it's not a struct page at all. Accidentally calling
vm_insert_batch on a struct net_iov will cause a kernel crash or some
memory corruption.

Thus abstractly different things maybe should not share the same
in-kernel struct.

One thing that maybe could work is if struct net_iov has a field in it
which tells us whether it's actually a struct page that can be passed
to mm apis, or not a struct page which cannot be passed to mm apis.

> Or I should introduce another struct

maybe introducing another struct is the answer. I'm not sure. The net
stack today already supports struct page and struct net_iov, with
netmem_ref acting as an abstraction over both. Adding a 3rd struct and
adding more checks to test if page or net_iov or something new will
add overhead.

An additional problem is that there are probably hundreds or thousands
of references to 'page' in the net stack and drivers. I'm not sure
what you're going to do about those. Are you converting all those to
netmem or netmem_desc?

--=20
Thanks,
Mina

