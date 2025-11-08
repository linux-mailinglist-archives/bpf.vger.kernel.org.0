Return-Path: <bpf+bounces-73994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EF3C424B8
	for <lists+bpf@lfdr.de>; Sat, 08 Nov 2025 03:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D7B3B3DD5
	for <lists+bpf@lfdr.de>; Sat,  8 Nov 2025 02:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99DF2BF3CC;
	Sat,  8 Nov 2025 02:29:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265A28B4FE;
	Sat,  8 Nov 2025 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762568955; cv=none; b=X5iKgoeEWhhW6T1923VPhjypNl8wIetoXorEi66fC8i/C9YM5UtNK30xL/yLj0CzlaKcODoOOcJFYTqVBN3BgKejfMLTc8tAdixZv8iJNqRmBSNX6JlIVHXEbQCJUkGYu0qhjoCbwPucRD75ZzS1w0SxSdlSQaubA90DLmKUwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762568955; c=relaxed/simple;
	bh=d3cd2e2zOzGJ/JCo/adSfw76IOVpiFTn13cAcJlWmEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/+0m0hYA9BoppiPNR7v4qaDgwfkPt04s6qkxhoAU330gPihmKSTWybGxqn9b1rIkxwRPJoS1SjmcscOIlkuGdjRyb76/YHVTkm4x4K1vhEkF7B70V6zlb0I1WnCJRmZrGvQwm1UI63/WviShtvl/nzjx/hP2YXn4zO3mzFrK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-cc-690eaaf5facf
Date: Sat, 8 Nov 2025 11:29:04 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
Message-ID: <20251108022904.GA1450@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-2-byungchul@sk.com>
 <20251106173320.2f8e683a@kernel.org>
 <20251107015902.GA3021@system.software.com>
 <20251106180810.6b06f71a@kernel.org>
 <20251107044708.GA54407@system.software.com>
 <20251107174129.62a3f39c@kernel.org>
 <20251108022458.GA65163@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108022458.GA65163@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0wTdxjH/d39enc0dDkLyM8/mbOamKCCMyw+JmPRVztMTMwW4zJeyIVe
	pArVFGRgQnK4mjEczG0QSikGYrSloMSilDaiUhChxlgBzRkQFJVuU6EBV4U6WQsx890n3+/z
	fPK8eDhae1u1ijMYCyWTUczTMWqsfhXftCXs/MSw9ZmDBltbKwMtb4vB/rhTBXOtQQpszg4E
	r+dGWFjo6kMw23uLgRc9MwjONoWjC3fNGP5pm6fB4w0i+NtygYHnfRMstLj2wPj5SQxXf3LT
	MPFrPwOV5ggNXXNTLJzodETF7TILgY4qFVTPn6PBLT9mYchrY2CsdUEFk75KDAPWZgyhml4a
	xqt2Ql/jCgjffomgt81NQfiXBgbu13kpuNJ1n4U/BhsZeGoeRzDYM4Gh5l05A/VlVQgib6PK
	qdOvVVB/c4zdmSqUKQoj9LycpoXLzQ8p4YHlNywo1/yU4LE+YoVG1zGh3ZEiVCiDtOBy/swI
	rpnfWWH0wVVG6LdEsOB5skPwdM5SQuWPU8zepO/VX+qlPEORZEr7KludO2TTHz21pri6qoyS
	kT2hAsVxhE8nwx4P9YFH/T4mxpjfQLrknkVm+I1EUeboGCdGc3N7Ha5Aao7mQyyxKGOqWJHA
	F5LQtLw4pOG3k+nue4tDWn6CItfuBKmlYjkZqHuGY0zzKUR5/1c056K8mtjfc7E4jt9BZocf
	oRgn8evJjY5bVMxD+D85Io9Y8NKlK0m3Q8GnEW/9SGv9SGv9X9uIaCfSGoxF+aIhLz01t8Ro
	KE7NOZLvQtEXO1/6LqsTzQS+9SGeQ7p4TXZEY9CqxKKCknwfIhytS9R8YYw3aDV6seS4ZDpy
	wHQsTyrwodUc1iVrtoV/0Gv5g2KhdFiSjkqmDy3Fxa2SUXmtsUG94emk3dtw5jtv7Vp8cd0y
	dDgjPfgmIJ1MDmatGEAPt8mfDTVBWmg0y71vCDtzvqn0Z0Tk44fuWYwBc+mdzF2zFdf1AW9o
	937byCVxOFFs3pTWrx1pmPYnafh6de3a8jPu5My0hTUO92Zk9Z/aZV6esvfT/H9Xlp79WocL
	csXPU2hTgfgflLVW+l4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUiTcRzH+z+3s8XTtHrQDlpFIHTS8ZMifBH1EBW96AB7kQ/5kA/pkk1F
	O2DWKFt5dMFcCyZhzrklTNPNUmpT08wOzVqkrjS1C5U2ralUmxH57sP3evVlcIWdjGEkVYao
	VgmpSkpGyPZuObdqzDpHWvu0eyWYKm0UVPzMhrL3ThKCtiEMTNYaBIHgOxp+1zcj8Dc+puCr
	5zuC2yXjOJie6wgYq5zAwVU3hOCLwU7BQHMfDRWOPeC7M0jAgwu1OPQVtlCQr5vEoT44TMNZ
	pyU0XKWlwXOrlYQXNQUkXJ8oxaFW+56GzjoTBb223yQMuvMJaDWWEzB6oxEHX0ECNJvnw3jb
	NwSNlbUYjF++RUFXcR0G9+q7aLjWYaagX+dD0OHpI+DGVB4FN3MLEEz+DE0OFwVIuNnUSyes
	4XO9Xor3fBvB+erytxj/2nCF4L0NTzDeZeyhebMjk6+yxPF6bwfOO6wXKd7x/SrNd79+QPEt
	hkmCd32I511OP8bnnxum9s1PlG1NFlOlLFG9ZluSLKXTlJx+aWH29YJcTIvKovQoguHYDVz3
	EzcVZoJdztVrPdNMsSs5rzeIhzk6pOuqigk9kjE4O0pzBm8vGTai2AxudEQ7HZKzm7mRRy+n
	Qwq2D+Ma2oewv8ZcrrX4IxFmnI3jvL8+h3QmxLFc2S8mLEew8Zz/VQ8K8zx2Gfew5jFWhOTG
	GW3jjLbxf9uMcCuKllRZaYKUunG15nhKjkrKXn30RJoDhU5058zUFScKdO50I5ZBytnypEm5
	pCCFLE1OmhtxDK6Mlm9UzZYU8mQh56SoPnFEnZkqatwoliGUC+S7DolJCvaYkCEeF8V0Uf3P
	xZiIGC26u3uxb3uU+tPeZ4m+FsUPMnJWQ6m1+oD+uceh3b+j48se5tQZC1Z4+LTQdD5xoqhd
	78y8bB+oQFDVX9S0uF0Rqdu2Itjfg4wLZE93JyxZtOnsCNIzNnNXep5tvf/g0pLAQLnksLRl
	oEfpbaWG2yahxG5XqOSDS+6/6Y11BZSEJkVYF4erNcIfMczgx0ADAAA=
X-CFilter-Loop: Reflected

On Sat, Nov 08, 2025 at 11:24:58AM +0900, Byungchul Park wrote:
> On Fri, Nov 07, 2025 at 05:41:29PM -0800, Jakub Kicinski wrote:
> > On Fri, 7 Nov 2025 13:47:08 +0900 Byungchul Park wrote:
> > > The offset of page_type in struct page cannot be used in struct net_iov
> > > for the same purpose, since the offset in struct net_iov is for storing
> > > (struct net_iov_area *)owner.
> > 
> > owner does not have to be at a fixed offset. Can we not move owner
> > to _pp_mapping_pad ? Or reorder it with type, enum net_iov_type
> > only has 2 values we can smoosh it with page_type easily.
> 
> I'm still confused.  I think you probably understand what this work is
> for.  (I've explained several times with related links.)  Or am I
         ^
Please don't mind.  It's not a blame.

	Byungchul

> missing something from your questions?
> 
> I've answered your question directly since you asked, but the point is
> that, struct net_iov will no longer overlay on struct page.
> 
> Instead, struct netmem_desc will be responsible for keeping the pp
> fields while struct page will lay down the resonsibility, once the pp
> fields will be removed from struct page like:
> 
> <before> (the current form is:)
> 
>    struct page {
>  	memdesc_flags_t flags;
>  	union {
>  		...
>  		struct {
>  			unsigned long pp_magic;
>  			struct page_pool *pp;
>  			unsigned long _pp_mapping_pad;
>  			unsigned long dma_addr;
>  			atomic_long_t pp_ref_count;
>  		};
>  		...
>  	};
>  	unsigned int page_type;
>  	...
>    };
>  
>    struct net_iov {
>  	union {
>  		struct netmem_desc desc;
>  		struct
>  		{
>  			unsigned long _flags;
>  			unsigned long pp_magic;
>  			struct page_pool *pp;
>  			unsigned long _pp_mapping_pad;
>  			unsigned long dma_addr;
>  			atomic_long_t pp_ref_count;
>  		};
>  	};
>  	struct net_iov_area *owner;
>  	enum net_iov_type type;
>    };
> 
> <after> (the final form should be, just around the corner:)
> 
>    struct page {
>  	memdesc_flags_t flags;
>  	union {
>  		...
> 		/* pp fields are gone. */
>  		...
>  	};
>  	unsigned int page_type;
>  	...
>    };
>  
>    struct net_iov {
>  	struct netmem_desc desc;
>  	struct net_iov_area *owner;
>  	enum net_iov_type type;
>    };
> 
> After that, struct page and struct net_iov(or struct netmem_desc) will
> not share any fields with each other, probably they will be connected
> e.i. through some ways between struct page and netmem_desc tho.
> 
> 	Byungchul
>  
> > > Yeah, you can tell 'why don't we add the field, page_type, to struct
> > > net_iov (or struct netmem_desc)' so as to be like:
> > >
> > >   struct net_iov {
> > >       union {
> > >               struct netmem_desc desc;
> > >               struct
> > >               {
> > >                       unsigned long _flags;
> > >                       unsigned long pp_magic;
> > >                       struct page_pool *pp;
> > >                       unsigned long _pp_mapping_pad;
> > >                       unsigned long dma_addr;
> > >                       atomic_long_t pp_ref_count;
> > > +                     unsigned int page_type; // add this field newly
> > >               };
> > >       };
> > >       struct net_iov_area *owner; // the same offet of page_type
> > >       enum net_iov_type type;
> > >   };
> > >
> > > I think we can make it anyway but it makes less sense to add page_type
> > > to struct net_iov, only for PGTY_netpp.
> > >
> > > It'd be better to use netmem_desc->pp for that purpose, IMO.

