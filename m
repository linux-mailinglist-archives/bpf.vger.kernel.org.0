Return-Path: <bpf+bounces-65312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C235B1FD73
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 03:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AD8188F522
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 01:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19C019F111;
	Mon, 11 Aug 2025 01:09:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DA22E401;
	Mon, 11 Aug 2025 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754874578; cv=none; b=nTyX1Jfp9HFmtdCI6ZOndHiAWGToH1eH4Sdp4Gi6cfZlckcFo9inO4/NX6gov5vKJGkc0cXr+P9R5H/d6UJIgmGEqplMefBjJBqiTITOe1jeNAYfDbQxXfT+/cknBw7rIlzwurVw0ZcNWQOColkQApCFzUWjzrDK5QzUqa7pY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754874578; c=relaxed/simple;
	bh=edK6wfe82+a1zI95IT4725tatobF5C9KlGS4WvUMtzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOQ1jri43BGhRkFowd0ZaSW08ZC7L1rubyEb0XfFPmOPwOB/kFGMIzGua5QrcUgDIWtf1nkKahTNXJqm39BoFsjIRNlDWdj2VPY7YeTPW9wWWBwqtNGQHsdUXpDtgu7pV4EdRLHNX9jXqq+AqTKSbTbXaHITcJPvMtQZntfjm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f7-689942c2df79
Date: Mon, 11 Aug 2025 10:09:17 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: [PATCH linux-next v3] mm, page_pool: introduce a new page type
 for page pool in page type
Message-ID: <20250811010917.GB28363@system.software.com>
References: <20250729110210.48313-1-byungchul@sk.com>
 <757b3268-43ab-41bf-88fa-4730089721f3@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757b3268-43ab-41bf-88fa-4730089721f3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z9zds5xOTotzX8GfViUYHSl4A1Kutr/SxEUBRrUcic3mlrT
	vHSBaXbTZmLXLQvLMnWSMO+XSW3LS7EuRrUsnVlJstS8JN6oNkXq2/P+3pfneT68PC2vkwTz
	mtgEURer1CpYKSPt9b+3zL7ZqF5Z7pRAbmkJC+bRZHjYWe2diisRDI995OCPtRHBkKOJBY99
	EEH+3REacl+mM/CrdJyGb41dHJgtO8Bd0M1A/fkqGrouN7NgSJ+gwTrWx0FadSEFuWV6Dl5V
	Zkng6vgDGqr0nRy8qc1loaPkjwS6bQYGWkxFDPy85qDBnbURGvPmwcjzHwgcpVUUjFy6zcJb
	Yy0FFda3HFxpzWPhS7obQau9i4FrkxdYuJWahWBi1GvZlz0sgVtPO7iNS0mqy8US+49+mpQX
	faCIq+EZRWpM7RzJsxwnZYWhJMPVShNL8UWWWAZzOPLpXT1Lmm9OMKTm8zpSUz1EEcOZPpYM
	fGtjdgVESNerRK0mUdStCDsoVRsqJyRHW2clN9l7OT3q5zOQH4+FNdj5vYOd0e7757gMxPOM
	sBi/NCf4MCuEYJdrjPbpAGEp9ry3eU+kPC2UcNj4IgP5FnMFNS6784XyaZkAONvTw/i03Mvf
	nC2STPM5uMX4dYrTQih2/e6hfFm0sAA//D1Vx0/YgB1DDVNZgcIi/LiyifJlYeErjwusPdR0
	z/n4SaGLyUaC6T9b03+2pn+2eYguRnJNbGKMUqNds1ydEqtJXh4VF2NB3pcqOD0ZWY0GX+22
	IYFHCn9Z54ObarlEmRifEmNDmKcVAbJu9Q21XKZSppwQdXEHdMe1YrwNLeAZRZBs9UiSSi5E
	KxPEI6J4VNTNbCneL1iP7mTLQ+K25ndcD3tdnunZdCr6UE7vnKQoZ1qtJku7Ihzr98iMpuGg
	oDZb2d4tH5dlUmReWEXiWPPkbEf5vpz9SdZHgcau9UERhWu3UeK4s31Wt8ps1sSVslrDsfpI
	D7ezPXq77GRE2lV7xEDkFpuzbdvwQvfBlNkF4YfriGqJUcHEq5WrQmldvPIvSa6EKU4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTcRTG+b93V4u3qfmiXWBRgZVlJB27IUH1J7p9CIoIdeiLG84pm4oG
	habdrJndKNcMrTQvC2Oam6YSm01NyFDMmeVMTTAvZV5oahdnRH17+D3nOc/5cDhSlkf7cypN
	oqjVKNRyRkJJDu/I2Gjbk6vcnFG4GYzlJgbKvqfA414rDcbSKgST7m4WftU5EEw0NDIwbP+G
	4GHBNAnG1kwKpspnSPjk6GOhzHwIXEWDFNRetJDQd62JAX3mLAl17jEWzlmLCTBWpLFgz2um
	4U1VNg23ZgpJsKT1stBeY2Sgx/SLhkGbnoJmQwkFX283kODKDgNH/jKYbhlB0FBuIWD6ah4D
	Hbk1BDyr62DhZls+A/2ZLgRt9j4Kbs9dYuBeejaC2e/zK8dyJmm497KHDduA051OBttHvpC4
	sqSLwM76VwSuNnxgcb45CVcUB+IsZxuJzaWXGWz+doPF79/WMrjp7iyFqz+G4mrrBIH1GWMM
	Hv/0jjrqe1KyM1pUq5JF7abdkRKlvmqWTmhblNJoH2XT0BcuC3lxAr9VcD26wGYhjqP4NUJr
	WaIHM/w6wel0kx7tw68Xhjtt8yMSjuRNrJD7Ogt5DG9eKVTc7yc8WsqDkDM8RHm0bJ63ny+h
	//ClQnPuwAIn+UDB+XOI8HSRfIDw+OfCCV78LqFhon6hy5dfLbyoaiRykNTwX9rwX9rwL52P
	yFLko9IkxylU6pAgXawyVaNKCYqKjzOj+acpOjN33Yom2/fbEM8h+WJpb+FdpYxWJOtS42xI
	4Ei5j3RQeUcpk0YrUk+L2vgIbZJa1NlQAEfJ/aQHjouRMj5GkSjGimKCqP3rEpyXfxrSdq7C
	jugmvzsPHk6dq4hypY9WBv+QrWjRHywb6DxyP+SzumhskHN5q84mbWskhsb7R5rrVh4zFew9
	sSRi35WnYeNXmrbv9dKGJjrGwy17YgItGVu63N3WA6clcTPPTaHhr1KiAlpifPffmjbHXpKc
	Gjnsq3EPrHXt3rSrMuhJumK5nNIpFcGBpFan+A1UN4MuMAMAAA==
X-CFilter-Loop: Reflected

On Sun, Aug 10, 2025 at 09:21:45PM +0100, Pavel Begunkov wrote:
> On 7/29/25 12:02, Byungchul Park wrote:
> > Changes from v2:
> >       1. Rebase on linux-next as of Jul 29.
> >       2. Skip 'niov->pp = NULL' when it's allocated using __GFP_ZERO.
> >       3. Change trivial coding style. (feedbacked by Mina)
> >       4. Add Co-developed-by, Acked-by, and Reviewed-by properly.
> >          Thanks to all.
> > 
> > Changes from v1:
> >       1. Rebase on linux-next.
> >       2. Initialize net_iov->pp = NULL when allocating net_iov in
> >          net_devmem_bind_dmabuf() and io_zcrx_create_area().
> >       3. Use ->pp for net_iov to identify if it's pp rather than
> >          always consider net_iov as pp.
> >       4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
> > 
> > ---8<---
> >  From 88bcb9907a0cef65a9c0adf35e144f9eb67e0542 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Tue, 29 Jul 2025 19:49:44 +0900
> > Subject: [PATCH linux-next v3] mm, page_pool: introduce a new page type for page pool in page type
> 
> That will conflict with "netmem: replace __netmem_clear_lsb() with
> netmem_to_nmdesc()", it'll need some coordination.

Indeed.  It'd better work on top of "netmem: replace __netmem_clear_lsb()
with netmem_to_nmdesc()" then.  You said you are going to take the patch.
Please lemme know the progress so that I can track and re-work on this.

	Byungchul

> --
> Pavel Begunkov
> 

