Return-Path: <bpf+bounces-74040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793A3C44B5A
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 02:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B133B06EB
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 01:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2E4217705;
	Mon, 10 Nov 2025 01:09:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE71A58D;
	Mon, 10 Nov 2025 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736987; cv=none; b=fyeM4p78VsU4Kesps1UmH//+zZBkZIw9xng4rdUkarrUx8NC5w62jWKnoH4bDxAik4Bq+VxlL2CurRcOgfoF/YE0BHcSFGqMqPLdZRyKoonUoYrGArpK3/+14bSiPmpEUqZMlXR/u7ycnvMJxfU7MRRtYhiSvlkvcDWibevHCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736987; c=relaxed/simple;
	bh=6lBX/PQAGMpxyYl0SnTFFRgoUlmWnhp6tbfnUe4KM5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X281fVe7sJFmXHiBfJXoTkSo0BDgahSlchpHWVl7mx2GGanIWsRr+52GI/0g4kmUxWIRBHDqH01Jc04yDMLh0r7AQGsSF5jQ9HqI3A1XfT3pxNwSt7UP0Cw2LDknjHaCe3YqeTZG6OgzU9XKqeiWhpbrg3Uh3KbQ2cZaXYUV1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-52-69113b4c406e
Date: Mon, 10 Nov 2025 10:09:26 +0900
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
Message-ID: <20251110010926.GA70011@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-2-byungchul@sk.com>
 <20251106173320.2f8e683a@kernel.org>
 <20251107015902.GA3021@system.software.com>
 <20251106180810.6b06f71a@kernel.org>
 <20251107044708.GA54407@system.software.com>
 <20251107174129.62a3f39c@kernel.org>
 <20251108022458.GA65163@system.software.com>
 <20251107183712.36228f2a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107183712.36228f2a@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA03Se0hUaRjHcd7znpuDQ2fG2t50o2W6gZVdttinCxVFcLCCwCK6N+UhD40a
	42QaFWMNlFNa7eY2jhOZUV5raCx1poy8rE5FOegaJ7Ydy7ba7WKDNxoddGeKqP8+8Pz48v7x
	8ljrZWJ5Oc0kGdP0Bh2rolUfoktmrVmskecUdWjA4axiofJTFpQ+r2MgWPWGAkdFDYL+4F8c
	jNa3IOhrbmXhXVMvgsuXBjE42iw0DDiHMLg9bxC8tV1j4VVLNweVrrXQdfU1DXeO12LoPu1l
	Ic8yjKE+2MPB0bqycLjazIGvJp+Bc0NXMNSan3PQ4XGw4K8aZeB1Yx4N9+3lNAQKmjF05S+H
	luIfYPDhewTNzloKBk9dYKGz0EPBrfpODn5rL2bhpaULQXtTNw0FoRMsFOXkIxj+FE72nOln
	oOgPP7c8QcxRFFZsev8RizfLn1LiE9tZWlTuPqBEt/1vTix27Rery+JFq9KORVdFLiu6en/l
	xGdP7rCi1zZMi+4XC0V3XR8l5h3rYdeN26xakiwZ5EzJOHvpTlWKJ1TC7Hs8Jst//QJjRuXR
	VhTFE2E+Od1Qhr7aUnCCi5gWppJe79Bns8J0oihBHPFYYQqxVBfSVqTisRDgiE3xM5FDjGAi
	gY/m8Ijj1QKQG6bIRCvkYmK1Vn/uqAUNuV/4Dx0xFuKJMvIfZUV82HGkdISPMEqYS8w3f4os
	xgmTyb2aVurLywI8abi9/osnkIYyhT6DBPt3Uft3Ufu3aDHCFUgrp2Wm6mXD/ISU7DQ5K2F3
	eqoLhf/X1cOhLXWo15fUiAQe6aLVCqeRtYw+MyM7tRERHuvGqkO7BFmrTtZnH5SM6TuM+w1S
	RiOK42ndePW8wQPJWmGP3iTtlaR9kvHrleKjYs3IdKSId46G/BP5xH9jfC99Jeka77pfJv3Y
	zjEzAsscizyznbV/rh7N3rYkCa+vXHWp85Xthudp4YEj3dM2l5zPfzTG8IJKXNmWm9gx8CzY
	3+k+OW9VQexF+dzZmZ4FkzZmxW0f2MQv3epKMve1/jz+9742+90pK7oOjhyKU6X6cnx7Nujo
	jBT93HhszND/D1lxqNNbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRyG+c53bg5Hx2V10KBYSmGUCgW/UsQg6KM7SQlC2cxTjrzEprIF
	wcyFtdIsE3RpWZHltLRp3sioaV4KLBTjRKVmZRfNli3zsrItiPzvgfd93r9eHqsqmQBem5ou
	6VI1yWpWQSu2R2Sv2hLhpw3r+wVQUl3FQuWkAW4MNjIwVfWBghJbPQLX1EsOZlvaEXxv62Bh
	pHUcwbUrExhKnppp+FE9jaGp+QOCz0W3WHjfPsRBpX0bDJQP03AvpwHD0NlOFnLNMxhapsY4
	ON540zNca+KgtbSLgWf1eQxcmL6OocE0yEFvcwkL/VWzDAw7cmnoslbQ4CxswzCQFw3tZQth
	4skogrbqBgomzpSy0FfcTMHdlj4OCnrKWHhrHkDQ0zpEQ6H7JAsXs/IQzEx6JsfyXQxcfNTP
	RYeSLFlmSevoV0zqKl5Q5HnROZrI9x9TpMn6miNl9gxSezOEWOQeTOy2Uyyxj5/nyKvn91jS
	WTRDk6Y360hT43eK5GaPsTsXxikiE6VkbaakC43ar0hqdl9ljnTPM/TfLmVMqMLXgnx4UVgj
	mgtPcl6mhWBxvHP6L7PCclGWp7CX/YUg0VxbTFuQgseCkxOL5H7GG8wX0kXnV5OnxPFKAcQ7
	6d6KSjiFRYul9u+OUvATu4rf0V7GQogo//5EWRDv4UDxxm/eiz5CuGiqW+ptLBCWiQ/qO6h8
	pLTOka1zZOt/uQxhG/LXpmamaLTJa1frDycZU7WG1QfSUuzIc6HyY+5zjcjVu8mBBB6pfZUy
	56dVMZpMvTHFgUQeq/2V7gRBq1ImaoxHJV1avC4jWdI7UCBPqxcpN8dK+1XCIU26dFiSjki6
	fynF+wSYEA7W/3wQtSdkfKNzxjia9m393kD3/Wj7pcT8rQldMb07bo+scuhiEwtWmg2+xbaY
	2d0Ng5FLvix+aHg5FPRRrbgc52rbVZMhhy8Ocp0e7tzXHWPM2lP3o/v0qzUpX6btJxKWqzpQ
	QQAJXGu31WzYFr/i4Gw5ziERH8mvOh9n2F6lmtYnacJDsE6v+QPGyCplPgMAAA==
X-CFilter-Loop: Reflected

On Fri, Nov 07, 2025 at 06:37:12PM -0800, Jakub Kicinski wrote:
> On Sat, 8 Nov 2025 11:24:58 +0900 Byungchul Park wrote:
> > On Fri, Nov 07, 2025 at 05:41:29PM -0800, Jakub Kicinski wrote:
> > > On Fri, 7 Nov 2025 13:47:08 +0900 Byungchul Park wrote:
> > > > The offset of page_type in struct page cannot be used in struct net_iov
> > > > for the same purpose, since the offset in struct net_iov is for storing
> > > > (struct net_iov_area *)owner.
> > >
> > > owner does not have to be at a fixed offset. Can we not move owner
> > > to _pp_mapping_pad ? Or reorder it with type, enum net_iov_type
> > > only has 2 values we can smoosh it with page_type easily.
> >
> > I'm still confused.  I think you probably understand what this work is
> > for.  (I've explained several times with related links.)  Or am I
> > missing something from your questions?
> >
> > I've answered your question directly since you asked, but the point is
> > that, struct net_iov will no longer overlay on struct page.
> >
> > Instead, struct netmem_desc will be responsible for keeping the pp
> > fields while struct page will lay down the resonsibility, once the pp
> > fields will be removed from struct page like:
> 
> I understand the end goal. I don't understand why patch 1 is a step
> in that direction, and you seem incapable of explaining it. So please
> either follow my suggestion on how to proceed with patch 2 without

struct page and struct netmem_desc should keep difference information.
Even though they are sharing some fields at the moment, it should
eventually be decoupled, which I'm working on now.

> patch 1 in current form. Or come back when have the full conversion
> ready.

This patch set represents the final phase of the full conversion process,
awaiting the next steps. Once this patch is completed, the entire
conversion will be finished, allowing for the final patch that removes
the pp fields from the struct page to be carried out.

	Byungchul

