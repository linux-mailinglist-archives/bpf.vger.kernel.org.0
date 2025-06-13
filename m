Return-Path: <bpf+bounces-60560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E4AD8022
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 03:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8AC7AE76F
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 01:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B91DB13A;
	Fri, 13 Jun 2025 01:13:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6537F1D5175;
	Fri, 13 Jun 2025 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749777205; cv=none; b=qPkVOtyyjtOMtlk8TCl5kn0EwspoFm0whWeFvVJ4+Yp6h9SSjcQDFFddNXc5v+zVW4RxW6TPRtl9rlhkVuHE3KNA/ezR1cVfHU09R/LcJV48KO6MgFVTIVa/BS0IjDahXjf3THxf4BDXGSePK94qLVF3K7Tot61To8Z855YHVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749777205; c=relaxed/simple;
	bh=8TekB/D+4/8UhrQsSM7eVVZa5ko+rsGTZDp4E3X4Ssk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB3OXdatwUHr8wpE/U3JqXUGQd8urjprXeKABfaTRiOfsz21FJklOZZ8J+qOpU2nMMqacuAYRUOPlHBBM6yq5Ip2QNd9RXgYX/HkuIZM7P7jDlOdS1xBcINEfssWt1u7gzuAkYlP/y8bq1n6RkUdA6hhvGFKoB24je+eyw/fqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-cc-684b7b275ae5
Date: Fri, 13 Jun 2025 10:13:05 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, almasrymina@google.com,
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
Subject: Re: [PATCH net-next 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250613011305.GA18998@system.software.com>
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org>
 <20250610013001.GA65598@system.software.com>
 <20250611185542.118230c1@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611185542.118230c1@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH9/093a9bx88JX1o2pxaNSOHzhxkb23dYy5hZVtz0W3dTycXp
	YSZk5ug8lIc7x66ZHq7s7EpdLQ+dQ5HRAztKl9A8JHS5HoWrGf+99n6/9977jzdPy3XsLF6d
	slfUpCiTFJyUkX7xL1gYmrVetVh3dBKYrGUclA6mQ1GnnQWTpRJB/1CbBDzOhxxcLfDSYHqa
	w8AP6zAN7x90ScBd2M1A7bEqGrpO1XOQmzNCw2F7MQXPKvUs5A9fo6Equ1MCLTUmDjrKfrHQ
	7chloMFYwoBbvwoemKeD93EPAqe1igLvycsc5DWbOXib40bQfK+LgUuH9Aist10sjAyauFVz
	SEXJS4pUG19LiNm2j5QXhxGdq5kmNstxjtj6zkpI+4tajtRfHGFItd1DkdwjvRz5/v4VQ77e
	fs4Ra8VzhjSanRLisc2OEWKlKxLEJLVW1CxauUOqGiu8yaR2TE5vu3OMykYmfx3ieSxE4fyK
	WB3yG8f2/CbWx4wQgmv1n2kfc0IodrmGxjlACMY55QZGh6Q8LXSz+MnZUspnTBXisaVtYJxl
	AuCu4WLWF5ILHQifOPRBMmFMwQ2Gd4yPaSEMu8Y+Ur4RtBCIi8Z4n+wnROCnrobxyDRhLr5b
	+ZCaGFfA41Zr+gTPxHXFLuY0Eoz/tRr/azX+azUj2oLk6hRtslKdFBWuykhRp4fv3J1sQ38e
	UnhgdJsd9T3b5EACjxT+MqhZp5KzSm1aRrIDYZ5WBMhQ6x9JlqDMyBQ1u7dr9iWJaQ4UyDOK
	GbIl3v0JciFRuVfcJYqpouavS/F+s7KRuU87smJP7sL5G4ZvmtvWZskHNvZG0MnaJbfYhqH+
	oLhza781LdiapzdEnwuwZUfD6nhDUL/zzckbQe77hvPmC2eu+NW/iwzxdL+e/nOLe5luaeZc
	deNO+5qBPP082fqmzXHx1x+R+5blCcGjLTFT6/T1kQcDLYneQLq/59MPT0WrgklTKSPCaE2a
	8jdXI5EfHQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRyG+Z+7w9FxWR2LPrjKQMosMn5llETQQcuMiKgPtZWHNjanbCra
	BWYONEszU9A1YzHyWo2mqZldWEMdZaZmLe+tlKLQLLU5Q3NG5LeH932fby+DS8aIlYxSkyxo
	NXK1lBIRotjIzI0h52IU4ff7IsBkvUNBtScNyocaSDBV1SGYmO6l4aejhQLLrSkcTO0GAiat
	XhyGm900DJaNENCUVY+D+2orBbmGGRwuNlRg8LzUScLrujwSCr23cajXD9HQ1WiiYODOHAkj
	9lwCnMZKAgbzoqDZvBymXnxD4LDWYzB1pZSC651mCj4aBhF0PncTcCMjD4H1iYuEGY+JipLy
	tZXvMf6hsZ/mzbYUvqYilM9xdeK8reoSxdt+FNB839smim8tniH4hw0/MT43c5Tix4d7CH7s
	STfFWz5/x3hrbTfBvzQ76LiA46Kd8YJamSpoN+2SiRSzZQ+IpIElab1PszA9MvnnID+GY7dy
	fYUdpI8Jdh3XlPcV9zHFrudcrukFDmTXcoaaEiIHiRicHSG5toJqzFcsZU9wVb2/FljMAuf2
	VpC+kYQdQNzljM/03yKAc5Z8InyMs6Gca/bLvMDM8yqufJbxxX7sZq7d5VyYLGPXcM/qWrB8
	JDYuso2LbON/24zwKhSo1KQmyJXqiDCdSpGuUaaFnU5MsKH5G5Rd+H2tAU107bMjlkFSfzE0
	RiskpDxVl55gRxyDSwPF6M18JI6Xp58VtIkntSlqQWdHqxhCukIcfVSQSdgz8mRBJQhJgvZf
	izF+K/XohOPeoWBvWwYdvv1D0YCt27zt/paEwJaD6rjTx+L39K32RH2ynJeVvOtWRQblFIe/
	apnTZ+radvYET3ovDHlqxy1ZNUdKA2RhG+r25g9leLJPxcVoQg47ow/k2nWNvzZij2Odo/07
	PCw9elP0aHr/3SI6eC4z6FVXtko+mN+xe1hK6BTyzaG4Vif/A7IqLGUCAwAA
X-CFilter-Loop: Reflected

On Wed, Jun 11, 2025 at 06:55:42PM -0700, Jakub Kicinski wrote:
> On Tue, 10 Jun 2025 10:30:01 +0900 Byungchul Park wrote:
> > > What's the intended relation between the types?  
> > 
> > One thing I'm trying to achieve is to remove pp fields from struct page,
> > and make network code use struct netmem_desc { pp fields; } instead of
> > sturc page for that purpose.
> > 
> > The reason why I union'ed it with the existing pp fields in struct
> > net_iov *temporarily* for now is, to fade out the existing pp fields
> > from struct net_iov so as to make the final form like:
> 
> I see, I may have mixed up the complaints there. I thought the effort
> was also about removing the need for the ref count. And Rx is
> relatively light on use of ref counting. 
> 
> > > netmem_ref exists to clearly indicate that memory may not be readable.
> > > Majority of memory we expect to allocate from page pool must be
> > > kernel-readable. What's the plan for reading the "single pointer"
> > > memory within the kernel?
> > > 
> > > I think you're approaching this problem from the easiest and least  
> > 
> > No, I've never looked for the easiest way.  My bad if there are a better
> > way to achieve it.  What would you recommend?
> 
> Sorry, I don't mean that the approach you took is the easiest way out.
> I meant that between Rx and Tx handling Rx is the easier part because 
> we already have the suitable abstraction. It's true that we use more
> fields in page struct on Rx, but I thought Tx is also more urgent
> as there are open reports for networking taking references on slab
> pages.
> 
> In any case, please make sure you maintain clear separation between
> readable and unreadable memory in the code you produce.

Do you mean the current patches do not?  If yes, please point out one
as example, which would be helpful to extract action items.

If no, are there things I should do further for this series including
non-controversial patches only?

	Byungchul

