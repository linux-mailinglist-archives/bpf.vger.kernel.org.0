Return-Path: <bpf+bounces-73938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22CCC3E792
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 05:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8714E3ACEB4
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 04:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2926F2B3;
	Fri,  7 Nov 2025 04:47:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD764315E;
	Fri,  7 Nov 2025 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490843; cv=none; b=KG4uMGT3lcZJBGfpyHsYVEL0mdg1T9cngO5OT/VwNfE6SctNa1AI4mrCVlcMtn+jIT9ED17RCdOpVEYjhqZh2PVHNqjPBsih/mSha96pw/DbsnldJYHJ+K5nelYneu6pWhmHebOLcfh2NKdtcC+HMZZIEiLwykVfRXiojNM6sS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490843; c=relaxed/simple;
	bh=VCJ59lycIri74X1yqvv8ek1VO/VNrs0puBEdc9NZc2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftGa31RkJNVIm6SCKJaQhJRHuYAkEujoUKuWIGHFbEOUZhY/pt1/qWUo7eI9zC4spiSrdad/opZXg4aTCF9k/1XS677LzvXHArmCy2d8XCzjYuCCIMlog5z52imWm9hCbvzhFQWLGt5FDSTnbvk1iwxO3fTPFIkw7UksoX44IpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-0a-690d79d21061
Date: Fri, 7 Nov 2025 13:47:08 +0900
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
Message-ID: <20251107044708.GA54407@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-2-byungchul@sk.com>
 <20251106173320.2f8e683a@kernel.org>
 <20251107015902.GA3021@system.software.com>
 <20251106180810.6b06f71a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106180810.6b06f71a@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGe885e8/ZcHVat7dEi3URhOxCwT+o6Et0IKKiD0UFdciDDnXG
	vKTRZZZgSdrVnNNqEdVSYzjzMnGr5l2JxCiPlK5WuUpTcbU0pdqsqG8/nufh938/vByt6VAs
	4HT6VMmgFxO1WMWoPofdXN6Vqdat7OjWQImtHEPZWAbcfV2rgPFyHwUlpdUIvoy/ZOGnsxmB
	v7EFw0DDKIJbNwM0lDzNZuCr7TsNjjofgk+m+xjeN3tZKLNvA8+dfgbqc2po8J5vxZCXPUGD
	c3yIhVO11qC40shCZ3W+Aq58v01DjfE1C8/qSjD0lf9UQL87j4E28z0GRgoaafDkb4Jmy1wI
	dAwiaLTVUBA4dw3D86I6Cqqcz1m43GXB8Dbbg6CrwctAweQZDMVZ+QgmxoLKoQtfFFDc1Mdu
	ihGyZBkLDYPDtPDgXg8lvDBdZATZ1U4JDnMvK1jsaUKlNVrIlbtowV56Fgv20Uus8OpFPRZa
	TROM4HizTnDU+ikh7/QQ3jFnr2p9rJSoS5cMKzYeVMX3D6gPv5yX8fFyIWNEuTNzkZIj/BrS
	5rxK/eWehxVMiBl+CWnvLqJDjPkoIsvjUzw7mGdXFgU3Ko7mR1hikvsUoWIWn0pGho1TIzUP
	5LqlkA6NNHwvIib/efy7mEnait5NXaD5aCL/+Bi8zAU5nNz9wYViJb+KWF1NU845/GLyqLqF
	CnkIP8iRG9eMf146nzy2yswFxJv/05r/05r/aS2ILkUanT49SdQlromJz9TrMmIOJSfZUfCL
	3Tk+ua8WjXbuciOeQ9ow9ZgrTKdRiOkpmUluRDhaO1u9Vh+M1LFi5lHJkHzAkJYopbhROMdo
	56lXB47Eavg4MVVKkKTDkuFvS3HKBUbEiMXmyA23FAVHF3nTjrk7E7SWnoRIl7g10u+pcuyP
	ODu4sPXch5Nvc6aTirhhr8fRNIuLudS5R2XzIay/7XqVvNu/eWfOk27biWWRvoj1vsKWJQcM
	08pm1E8eG4j6NtkevvaEckuE0bk0C/eWKRvrt6+8aC3VLo8bC1TEgtGmZVLixVXRtCFF/AWh
	HQ69XgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0hTcRzH+Z9zds5xeOJ4KQ/W04qCkZpU9utCWBD9CYp6inqxUx5ypFM2
	E9fFZo4ukmZZuK0Zi6jMnOY03aSpODMvD8XKmpaXrIzSlqiZU7M2I+rtw/f2e/mxZHiFLJpV
	qTMljVpMVdBySr5nc16MR8ep1tg2gKWqgoYH09lwb9AhA3/FJwIs5XUIJv1vGPjlakMw0fqU
	hhH3OILbt6ZIsDwzUPC9aoYEZ8MnBF+MNho+tg0x8MC+GwbuDlPw+Hw9CUOX22koMMyS4PL7
	GDjrKAsM1+gZcJd2yOB5XaEMrs3cIaFeP8jAiwYLDf0Vv2Qw3FJAQYf5PgVj11tJGChMhDbr
	EpjqGkXQWlVPwNSlUhq6TQ0EPHJ1M1DssdLw3jCAwOMeouD63AUabuQWIpidDkz6iiZlcONJ
	P5MYh3O9Xhq7R7+RuPZ+D4FfGa9Q2NvYSWCnuY/BVvtxXFOmxPleD4nt5RdpbB+/yuC3rx7T
	uN04S2Hnu43Y6ZggcEGej9675KB8S7KUqsqSNHFbD8lThke4jDdR2Z+LSyg9yg/LRyGswK8T
	epqqqSBT/Aqh87WJDDLNrxK8Xv8CRwZ0Q40pkJGzJD/GCEZvvyxoRPCZwtg3/UKI40G4aS0h
	g6Fwvg8JxonL9B8jTOgwfVi4QPJKwTv/mchHbICXCvfm2aAcwscLZY1PFjYX88uF5rqnRBHi
	zP+1zf+1zf/aVkSWo0iVOitNVKWuj9UeS9GpVdmxR9LT7CjwQ3dPz11xoMkXO1sQzyJFKDfd
	GKoKl4lZWl1aCxJYUhHJrVcHJC5Z1J2QNOlJmuOpkrYFLWUpRRS3a790KJw/KmZKxyQpQ9L8
	dQk2JFqPNuiKlkX3FCe6T0bGxOWs3H42t2vbNs+ZRQlrdcrakpIcZ+0m7Do82rzHsCbeUDnz
	tbpL6LI1p4eNvPRx9nbT7I9dlYsP+iLW7Ssd/MmGnVY6bEmrhvy3qeaUS5acn2L5w8SEuaRT
	ved6Vy9aFn8yxHegf2VGk+jqGNvh7rZ0NtkUlDZFjFeSGq34G6w0CIU/AwAA
X-CFilter-Loop: Reflected

On Thu, Nov 06, 2025 at 06:08:10PM -0800, Jakub Kicinski wrote:
> On Fri, 7 Nov 2025 10:59:02 +0900 Byungchul Park wrote:
> > > > page-backed, the identification cannot be based on the page_type.
> > > > Instead, nmdesc->pp can be used to see if it belongs to a page pool, by
> > > > making sure nmdesc->pp is NULL otherwise.
> > >
> > > Please explain why. Isn't the type just a value in a field?
> > > Which net_iov could also set accordingly.. ?
> >
> > page_type field is in 'struct page', so 'struct page' can check the type.
> >
> > However, the field is not in 'struct net_iov', so 'struct net_iov' that
> > is not backed by page, cannot use the type checking to see if it's page
> > pool'ed instance.
> >
> > I'm afraid I didn't get your questions.  I will try to explain again
> > properly if you give me more detail and example about your questions or
> > requirement.
> 
> net_iov has members in the same place as page. page_type is just
> a field right now.

The current layout is:

  struct page {
	memdesc_flags_t flags;
	union {
		...
		struct {
			unsigned long pp_magic;
			struct page_pool *pp;
			unsigned long _pp_mapping_pad;
			unsigned long dma_addr;
			atomic_long_t pp_ref_count;
		};
		...
	};
	unsigned int page_type;
	...
  };

  struct net_iov {
	union {
		struct netmem_desc desc;
		struct
		{
			unsigned long _flags;
			unsigned long pp_magic;
			struct page_pool *pp;
			unsigned long _pp_mapping_pad;
			unsigned long dma_addr;
			atomic_long_t pp_ref_count;
		};
	};
	struct net_iov_area *owner; // the same offet of page_type
	enum net_iov_type type;
  };

The offset of page_type in struct page cannot be used in struct net_iov
for the same purpose, since the offset in struct net_iov is for storing
(struct net_iov_area *)owner.

Yeah, you can tell 'why don't we add the field, page_type, to struct
net_iov (or struct netmem_desc)' so as to be like:

  struct net_iov {
	union {
		struct netmem_desc desc;
		struct
		{
			unsigned long _flags;
			unsigned long pp_magic;
			struct page_pool *pp;
			unsigned long _pp_mapping_pad;
			unsigned long dma_addr;
			atomic_long_t pp_ref_count;
+			unsigned int page_type; // add this field newly
		};
	};
	struct net_iov_area *owner; // the same offet of page_type
	enum net_iov_type type;
  };

I think we can make it anyway but it makes less sense to add page_type
to struct net_iov, only for PGTY_netpp.

It'd be better to use netmem_desc->pp for that purpose, IMO.

Thoughts?

	Byungchul

> static __always_inline int Page##uname(const struct page *page)         \
> {                                                                       \
>         return data_race(page->page_type >> 24) == PGTY_##lname;        \
> }                                                                       \
> 
> The whole thing works right now by overlaying one struct on top of
> another, and shared members being in the same places.
> 
> Is this clear enough?

