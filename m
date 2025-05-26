Return-Path: <bpf+bounces-58912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9831AC3781
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 02:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C217A9B92
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 00:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C5D6F53E;
	Mon, 26 May 2025 00:56:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E695F9D9;
	Mon, 26 May 2025 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748221014; cv=none; b=VDSWMKDopDxjlEbdXGC3OkVouuzGAYUV2T0f60GodDHBGmlWAy/clo5kwkmXWpRjS/WyzK2NPkIlFiwy4Y6dZHhDtbifHxEtTnCKos5Yj2TO33en57lTZ9ZGbT/y4ZxVahiDiEW0F37aBlIsaOVoTxPhdvv1jbJjdXbV5rbtKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748221014; c=relaxed/simple;
	bh=K47UkHVob1O4NflDYAefhNTIq7anxymMfXawllReXnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQnAJtJBjHQydwzMjJsjzdpCSL6yge9c6fGp2iRqniMyW7/FpxMYVL3FsjaGr0JM/5IAQ7PjJcIdkop9Ou4i4KpW+GngABILClcedTInoX5dT/P8M2ZtBUOlXMUHp6wOfe2GplemJcx+61MzWMr26EzEIZ5djTuYOiiGN7zdxf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-4f-6833bc4813ec
Date: Mon, 26 May 2025 09:56:34 +0900
From: Byungchul Park <byungchul@sk.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, tariqt@nvidia.com, edumazet@google.com,
	pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
Message-ID: <20250526005634.GA74632@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-2-byungchul@sk.com>
 <87bjrjn1ki.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjrjn1ki.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefZe9rpcvS2zp5SkRRRRZilxPkQURDxdPgQFXSFHvrXpnDGd
	aRR4A2nqshK1tWhqeUsZLZ2zzGqJZjMSzVppaU6toJLUlk27OC3y249z/uf8zofDUbIiZgmn
	0iQIWo1CLWcltOSzf/Fa0hCuDHvfHAQmSxULN8eToKzPzoCp0oZg7Ee3GEabWlgoKfJQYHqW
	QcM3i5eCweZ+MfSWDtHQkFlHQf/5xyzkZExQkGYvF0G7zcBAnvcGBXUpfWLovGNi4W3VbwaG
	HDk0tBoraOg1bIFmcyB4nJ8QNFnqRODJvsrCpQ4zC+6MXgQdj/ppuJJqQGBpdDEwMW5itywj
	NRWvRKTe+EZMzFYduV2+muhdHRSxVp5jiXXkopj0vGhgyePCCZrU20dFJCf9C0u+Dr6myXBj
	F0ssNV00aTM3icmodeke/pBkU5SgViUK2nWbIyXKwt5c6mTVvKSXDzQp6PscPfLjMB+BC/IL
	2H9sSKsW+5jmV+Dah5mMj1l+JXa5flB6xHEB/FbsHD+hRxKO4gcYXPexYjqzgFfj4kuTtI+l
	PODu6+8oH8v4M9imd4tn6vNx6+WB6QzFr8H1tT2sbyfFB+GyX9xMOQSn116ZHvWbOsFtm4kv
	5JfjB7YWkc+LeTuH8/Sdf29ejB+Wu+hcNN84S2GcpTD+VxhnKcyIrkQylSYxVqFSR4QqkzWq
	pNBjcbFWNPU4pWcnD9vRSPteB+I5JPeXRsrDlTJGkRifHOtAmKPkAdJgU5hSJo1SJJ8WtHFH
	tTq1EO9AQRwtXyTd4DkVJeNPKBKEGEE4KWj/dUWc35IUFPi6JexCm+78xbu66GzW6726Zhdp
	zTyeHTmWG/LeGZ7qsGU0t4y6nas6d0x0fT27rG8o/95wTtbBxs7hkYr9Tt3w/aoP/oxKG3Ps
	Qupg+G3Zbs/452uxXT/n7nw5FMxU79sWd2Bge3DNucr7/SXuW4boF/XPF0e7254e8W4MUGTZ
	nsjpeKVi/WpKG6/4A6Zhe4w0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe/Ze9m61el3LXjIKVyJI3srqkF3sQ/QUkUFE0Jdc+uaGc9Wm
	pmVkuqhGrrQCmzNXmres0dRthkg5UYfRxdCWafNORVR28ZLRZUrktx//8z8/zofDEFI9tYRR
	aVJ4rUahltNiUrw7OicUN6xRRhR1iMBsrabhzkQ6lPc5KTBX2RF8m3wthK/NrTSU3BwjwPxU
	T8J36w8ChlsGhOAtGyGh4ZyDgIFLbTTk6qcIyHZWCMBV5Kbgmd1IwdUftwlwZPUJ4cUDMw1v
	qn9TMNKUS4LbVEmC1xgDLRZ/GGv/gKDZ6hDA2MUiGq50WGgY1HsRdLgGSCg8Y0RgbfRQMDVh
	pmPkuLbylQDXm3qF2GJLxTUVIdjg6SCwreoCjW1f8oW4p6uBxm0FUySud34V4NycjzQeHe4m
	8afGThqXvP0swNbaThI/tjQL9/gdEG9M4NWqNF4bvjlOrCzwXiaOVi9If/lQk4XG5xqQiOHY
	KM6YfVfoY5IN4uoenaN8TLPBnMczSRgQw8jYrVz7RKIBiRmCHaI4x7vK6c5CVs3duvKT9LGE
	Be51aT/hYymbydkNg8KZ3I9zXx+a7hDsKq6+rof2OQk2gCv/xczEy7mcusLpVdHfEwbtM/VF
	7Aruob1VcBnNN80ymWaZTP9NplkmCyKrkEylSUtWqNRrw3RJygyNKj0s/kiyDf39jbJTP/Oc
	6NuL7U2IZZB8niROvkYppRRpuozkJsQxhFwmWWqOUEolCYqME7z2yEFtqprXNaEAhpQvluzc
	z8dJ2URFCp/E80d57b+pgBEtyUIXXIP6dcZlwduoTbHF41sELZP+CfN2nTxcY7qW9VL85EZX
	17HnojnxCX3enYtSJZ/khyb6gyhdLLM4e2xfY5lseS831aOku7t3uErXvx0t2TCy0b56iyzk
	fPDp6L0F72Pye8OjeIUzMu94ToDN3T50tv1+RfGx0MAPq1YOB+pM9zLlpE6piAwhtDrFH2vK
	gPgXAwAA
X-CFilter-Loop: Reflected

On Fri, May 23, 2025 at 11:01:01AM +0200, Toke Høiland-Jørgensen wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > To simplify struct page, the page pool members of struct page should be
> > moved to other, allowing these members to be removed from struct page.
> >
> > Introduce a network memory descriptor to store the members, struct
> > netmem_desc, reusing struct net_iov that already mirrored struct page.
> >
> > While at it, relocate _pp_mapping_pad to group struct net_iov's fields.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/linux/mm_types.h |  2 +-
> >  include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++-------
> >  2 files changed, 37 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 56d07edd01f9..873e820e1521 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -120,13 +120,13 @@ struct page {
> >  			unsigned long private;
> >  		};
> >  		struct {	/* page_pool used by netstack */
> > +			unsigned long _pp_mapping_pad;
> >  			/**
> >  			 * @pp_magic: magic value to avoid recycling non
> >  			 * page_pool allocated pages.
> >  			 */
> >  			unsigned long pp_magic;
> >  			struct page_pool *pp;
> > -			unsigned long _pp_mapping_pad;
> >  			unsigned long dma_addr;
> >  			atomic_long_t pp_ref_count;
> >  		};
> 
> The reason that field is called "_pp_mapping_pad" is that it's supposed
> to overlay the page->mapping field, so that none of the page_pool uses
> set a value here. Moving it breaks that assumption. Once struct

Right.  I will fix it.  Thanks.

	Byungchul

> netmem_desc is completely decoupled from struct page this obviously
> doesn't matter, but I think it does today? At least, trying to use that
> field for the DMA index broke things, which is why we ended up with the
> bit-stuffing in pp_magic...
> 
> -Toke
> 

