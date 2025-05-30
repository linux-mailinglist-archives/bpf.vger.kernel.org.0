Return-Path: <bpf+bounces-59338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BC9AC85E4
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 03:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3CD3B5CDD
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 01:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92141465B4;
	Fri, 30 May 2025 01:10:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F410E4;
	Fri, 30 May 2025 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748567417; cv=none; b=FGadZmwXIcvMXtcCPn8dckPs5Q28H1GDAR+08J6PFgg/uASBIkiPKyKO2VJw6vJLX/FG2ptQEVzuBDwWfT0VKmLrhi0Fwns3R/Gxbmp1+o7DDQbrhL0ZH8bqItfvCCqewJ3Rkil73TdkDl8O2bwcpohgBCNa3jBXdP0RKGdFP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748567417; c=relaxed/simple;
	bh=JTWoZYMV/sBS4/+ns9GwXgeHnkr4jGPNv48ZkJkgXjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxEMH1ii0S0Aj4ZatvZaenMD7HRa2ZM/HXeI64G02dC8yk/hVoOjul3qzO6yI0EvuqN696ESVNFAPGXdsVzXYNdt9UOflHTqs03kvOmdhFyhPiwoh1SwLXWEDhsdkSkRehox4c7HZpltyGNaGPbG3I/o/vAM6N7HHOGShLrO7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-eb-6839056f5554
Date: Fri, 30 May 2025 10:10:02 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [RFC v3 01/18] netmem: introduce struct netmem_desc mirroring
 struct page
Message-ID: <20250530011002.GA3093@system.software.com>
References: <20250529031047.7587-1-byungchul@sk.com>
 <20250529031047.7587-2-byungchul@sk.com>
 <CAHS8izNBjkMLbQsP++0r+fbkW2q7gGOdrbmE7gH-=jQUMCgJ1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNBjkMLbQsP++0r+fbkW2q7gGOdrbmE7gH-=jQUMCgJ1g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefZe9jodva7bo5LRouxqGWJHCrUger5kdvkgCtVLvrTlnDEv
	aRGstJs5u2iSc8Yq71mLZTqtpJaYYmooxeyislQIynCapXZziuS3H+f8z/mdD4ejFLcZX06t
	TRZ1WkGjZGW07KvXrfWJTKhqY/3vUDBZqli4+zMNyvpsDJgqaxCMjr+XwkjjSxbu3BqjwNSR
	ScN3ywQFA01OKfSWDtLw5HwtBc7LzSwYMicpOGMrl8DrmhwG8iZKKKjV90mhq97EQk/VXwYG
	7QYaWowVNPTmRECTeRGMtX5B0GiplcBYdhELuZ1mFj5l9iLofOGkofB0DgJLg4OByZ8mNmIZ
	qa7olpA640cpMVtTyMPyNSTL0UkRa+VFllhd16Tkw9snLGm+MUmTOtuIhBgyhlgyPPCOJt8a
	3rDEUv2GJq/MjVIyYvWP4mNkW+NEjTpV1G0IOyRTvejQHrOtSmt53kbp0We/LOTBYT4YXyqw
	U7Pc1vOUdjPNr8Alj/Klbmb5AOxwjE9nFvCrcXHDVcbNFN/L4HbTUTfP56Nx+b0miZvl/Gbs
	KrRN5WWcgi9F2Pp5QjrT8MYtBf30zHAA/nWzcyrETbEfLvvDzZSX4oxHhdMuD34Ptrqyp10L
	+eX4Wc1LiXsn5m0cLmqfRDNH++Dn5Q76CvI2zlEY5yiM/xXGOQozoiuRQq1NTRDUmuBAVbpW
	nRZ4ODHBiqY+p/TUr1gbcr3eZ0c8h5Re8o1hoFIwQmpSeoIdYY5SLpCfCQ9RKeRxQvoJUZd4
	UJeiEZPsyI+jlYvlm8aOxyn4I0KyGC+Kx0TdbFfCefjq0bb761KcOdcHi5/GdwVt8onJ3am3
	eD+uDzKEh+tlkRmyisie5A5yLcu//lxzyKK84bVOWXdU06Et6q2Bu5O9YrdUMuNn8+t+1HSz
	e1dFR/kSLni0df+urnzPofuaEGHljowHrnPD/T0+88RtIYFhQtHJt8uN1Z4HLhicPkdCfbcv
	UdJJKiFoDaVLEv4BTbFk7DUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX9P9+t0/FzJV9lsZ6SM0jx80Oif+M0wxjCz1eHHna7L7up2
	sSwVpnVXyYxfl46USpydHq6WxpXUUFZK5SFKxmah0no4D13N9N9rn/f78/r882FJ+Vnal1Vr
	YwWdVqlRMFJKumND8vIYep0q+J55CVhsJQzcHjHCrfcOGizF5QiGRl9LYLDuCQN514dJsDSn
	UPDTNkZCX32PBLoLPlFQfb6ChJ70BgZMKeMkJDkKCajNaaThRbmZhktj+SRUJL6XQGuVhYF3
	JX9o+OQ0UdAoFlHQbQ6DeqsPDD/9iqDOVkHAcFoOA1ktVgZ6U7oRtNT2UJB9xozAVtNBw/iI
	hQlT8KVFnQRfKb6V8FZ7HH+/MJBP7WgheXvxBYa3D1yU8G/aqxm+4co4xVc6BgnelNzP8D/6
	uij+W00bw+d9/k7wttI2in9mrZPsnHNAGnpE0KgNgi5oY6RUVdusPeFYamx89JxMRF/8UpEH
	i7lV+Pm7B5SbKW4xzi+7LHEzw/njjo5R0s3eXAC+WZNJu5nkumncZDnuZi9uPy68U0+4Wcat
	xQPZjom+lJVzBQjbv4xJpoI5uPHqR2pq2R+7rrVMlNgJ9sO3frNT44U4uSx78pYHtwvbB9Im
	b83lFuGH5U+IDDRLnGYSp5nE/yZxmsmKqGLkrdYaopVqzeoV+ihVvFZtXHE4JtqOJp6jIMGV
	6UBDrVuciGORwlMG4aCS00qDPj7aiTBLKrxlSZvWqOSyI8r4k4IuJkIXpxH0TuTHUop5sq37
	hEg5d0wZK0QJwglB9y8lWA/fRBTR1Ls399eCsLejLmUT2fU4tdaQn5Lt5/XhXHq7cdjHvnQr
	cWNPVnjn7uvHjVnr++9eFtWmbbnkK2f9o7iEgwtjc+dXJfzyDNpzNNi8rqgrLvNQqKs4ZM3m
	GZtnhseHzY7WZVTKxaFFP1+K27FnW1p6yLaADZq1rlLDjGWnvKpMp6MUlF6lXBlI6vTKvx4l
	hL8YAwAA
X-CFilter-Loop: Reflected

On Thu, May 29, 2025 at 09:31:40AM -0700, Mina Almasry wrote:
> On Wed, May 28, 2025 at 8:11 PM Byungchul Park <byungchul@sk.com> wrote:
> >  struct net_iov {
> > -       enum net_iov_type type;
> > -       unsigned long pp_magic;
> > -       struct page_pool *pp;
> > -       struct net_iov_area *owner;
> > -       unsigned long dma_addr;
> > -       atomic_long_t pp_ref_count;
> > +       union {
> > +               struct netmem_desc desc;
> > +
> > +               /* XXX: The following part should be removed once all
> > +                * the references to them are converted so as to be
> > +                * accessed via netmem_desc e.g. niov->desc.pp instead
> > +                * of niov->pp.
> > +                *
> > +                * Plus, once struct netmem_desc has it own instance
> > +                * from slab, network's fields of the following can be
> > +                * moved out of struct netmem_desc like:
> > +                *
> > +                *    struct net_iov {
> > +                *       struct netmem_desc desc;
> > +                *       struct net_iov_area *owner;
> > +                *       ...
> > +                *    };
> > +                */
> 
> We do not need to wait until netmem_desc has its own instance from
> slab to move the net_iov-specific fields out of netmem_desc. We can do
> that now, because there are no size restrictions on net_iov.

Got it.  Thanks for explanation.

> So, I recommend change this to:
> 
> struct net_iov {
>   /* Union for anonymous aliasing: */
>   union {
>     struct netmem_desc desc;
>     struct {
>        unsigned long _flags;
>        unsigned long pp_magic;
>        struct page_pool *pp;
>        unsigned long _pp_mapping_pad;
>        unsigned long dma_addr;
>        atomic_long_t pp_ref_count;
>     };
>     struct net_iov_area *owner;
>     enum net_iov_type type;
> };

Do you mean?

  struct net_iov {
    /* Union for anonymous aliasing: */
    union {
      struct netmem_desc desc;
      struct {
         unsigned long _flags;
         unsigned long pp_magic;
         struct page_pool *pp;
         unsigned long _pp_mapping_pad;
         unsigned long dma_addr;
         atomic_long_t pp_ref_count;
      };
    };
    struct net_iov_area *owner;
    enum net_iov_type type;
  };

Right?  If so, I will.

> >  struct net_iov_area {
> > @@ -48,27 +110,22 @@ struct net_iov_area {
> >         unsigned long base_virtual;
> >  };
> >
> > -/* These fields in struct page are used by the page_pool and net stack:
> > +/* net_iov is union'ed with struct netmem_desc mirroring struct page, so
> > + * the page_pool can access these fields without worrying whether the
> > + * underlying fields are accessed via netmem_desc or directly via
> > + * net_iov, until all the references to them are converted so as to be
> > + * accessed via netmem_desc e.g. niov->desc.pp instead of niov->pp.
> >   *
> > - *        struct {
> > - *                unsigned long pp_magic;
> > - *                struct page_pool *pp;
> > - *                unsigned long _pp_mapping_pad;
> > - *                unsigned long dma_addr;
> > - *                atomic_long_t pp_ref_count;
> > - *        };
> > - *
> > - * We mirror the page_pool fields here so the page_pool can access these fields
> > - * without worrying whether the underlying fields belong to a page or net_iov.
> > - *
> > - * The non-net stack fields of struct page are private to the mm stack and must
> > - * never be mirrored to net_iov.
> > + * The non-net stack fields of struct page are private to the mm stack
> > + * and must never be mirrored to net_iov.
> >   */
> > -#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
> > -       static_assert(offsetof(struct page, pg) == \
> > +#define NET_IOV_ASSERT_OFFSET(desc, iov)                    \
> > +       static_assert(offsetof(struct netmem_desc, desc) == \
> >                       offsetof(struct net_iov, iov))
> > +NET_IOV_ASSERT_OFFSET(_flags, type);
> 
> Remove this assertion.

I will.

> 
> >  NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> >  NET_IOV_ASSERT_OFFSET(pp, pp);
> > +NET_IOV_ASSERT_OFFSET(_pp_mapping_pad, owner);
> 
> And this one.

I will.

> (_flags, type) and (_pp_mapping_pad, owner) have very different
> semantics and usage, we should not assert they are not the same
> offset. However (pp, pp) and (pp_magic,pp_magic) have the same
> semantics and usage, so we do assert they are at the same offset.
> 
> Code is allowed to access __netmem_clear_lsb(netmem)->pp or
> __netmem_clear_lsb(netmem)->pp_magic without caring what's the
> underlying memory type because both fields have the same semantics and
> usage.
> 
> Code should *not* assume it can access
> __netmem_clear_lsb(netmem)->owner or __netmem_clear_lsb(netmem)->type
> without doing a check whether the underlying memory is
> page/netmem_desc or net_iov. These fields are only usable for net_iov,

Sounds good.  Thanks.

	Byungchul

> so let's explicitly move them to a different place.
> 
> -- 
> Thanks,
> Mina

