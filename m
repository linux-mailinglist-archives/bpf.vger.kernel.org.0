Return-Path: <bpf+bounces-58919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D18AC382B
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 05:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2CC1891FA2
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 03:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2204198E81;
	Mon, 26 May 2025 03:09:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98BE13A41F;
	Mon, 26 May 2025 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748228952; cv=none; b=Es2Davy/Nk2xSyKAf+3MngDxr3i543PrT+fkaVYTWZ5Zc168Pi2IuY/g/aB91/EeHLw4RJ/aaxcHn2WPzR5cKttb6XzOmuYAW2jj9e79tmZK0cLREje9lZhJi+Ej1CoSq6vE5yjGL/DrCSG8MVT1bfiRQCSxw6mEkMruigX3d1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748228952; c=relaxed/simple;
	bh=n2R/XKA+q3Xd+D2urEIVEv0qpf0OjXPZ7JL3kfzUtCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF9jT0MgfmnSDykTcH2GpOQ+Ufew9k++oPb/kR44qfkV8DtHnjCd5uaqToYwmY5r3BdoRgIKQZdUiTKA/vCkChNcSDGb/Si/ZQp1HinKFt6DQU+p9d72rSbtj+EgeN7ze5Y8GNgB424+UAuCwr1UwgKs28wMYfKS01mxrxA4/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-42-6833db5079af
Date: Mon, 26 May 2025 12:08:58 +0900
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
Subject: Re: [PATCH 13/18] mlx5: use netmem descriptor and APIs for page pool
Message-ID: <20250526030858.GA56990@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-14-byungchul@sk.com>
 <CAHS8izOX0j04=KB-=_kpyR+_HZHk+4hKK-xTEtsGNNHzZFvhKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOX0j04=KB-=_kpyR+_HZHk+4hKK-xTEtsGNNHzZFvhKQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfec3Ycro7L6k2zyyoiQ7sY9HTFIOJAFEV9iCLykIe20mUz
	TaXMcmFaajeo1kmWlbeMyTK3wkSneUdNMdZ1YhZ90C5e5ryUOS3y24//c/k9Hx6WUploP1ar
	OynqdUKEmlFgRY/3vaBd70I0K60V00EyFzLwyB0HuR02GqSCEgT9Q+/k0FdVw8D9ey4KpGYD
	hgHzMAWfqzvl4Mz5gqE0xUpBZ2YtA+mGEQrO2/Jk0FKSQcON4YcUWJM65ND2XGLgY+EYDV/s
	6RjqjPkYnBmhUG2aBa6GbgRVZqsMXJfvMnC91cTAJ4MTQWtlJ4Y75zIQmMscNIy4JSZ0IV+c
	/0bGPzN+kPMmSwz/JC+QT3O0UrylIJXhLb3X5Pz716UMX3trBPPPbH0yPj35G8P//PwW89/L
	2hneXNyO+UZTlZzvs8zbxe1XbAwXI7Sxon7F5jCFpqYuD0elecU1FK9NQrflaciLJdwa8tht
	oP6xJdVOpyGWxdwSktK2wxMz3FLicAxNtPhyy8iDsqu0hynOSZMm6aiHZ3A7iDWzW+ZhJQfk
	e08m9rCKy0ekaGz5ZO5D6m534cnZpWQ0q5XyqCjOn+T+Zifj+ST56Z0JlRe3m1R3JU+0z+QW
	kfKSmvH1ivEri1ky3HPp7/lzSEWeA19BPsYpCuMUhfG/wjhFYUK4AKm0uthIQRuxJlgTr9PG
	BR8+HmlB43+Tc2b0gA31tuyxI45Fam9lmDpEo6KF2Oj4SDsiLKX2Vc6VVmpUynAhPkHUHz+k
	j4kQo+3In8Xq2crVrlPhKu6IcFI8JopRov5fVcZ6+SWhXGfbiYD+nqJ8qfbXAmWCwyUkvAi7
	FdXdrrk5mnj6SvO2jvrBmReczkHThjO6gUplrg0HOTourkrQNWc3v5xGbVo842hAouSbfbax
	vOzG9r7Bka17X61bsDPzR+hXQ/1iQ8lBWU7G+uS3bq4/a6it5bK74em+HP8PTdu3CVuq5gUG
	q3G0RlgVSOmjhT8Ja5nvMwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefZe9iotXpfWg0rCQkxLsyw8VIQh1EOhJkGFBTr1zU3nhU1F
	o8CaIY3UrCCdU2amThMny7yEiEzzQmmiGKbVxEuEeSlvaEaXJZHffvzPOb//l8NRUi3jyimT
	UgV1klwlYx1px9BjWt+wsQCFf95AIBjMtSw8XcuAqvFmBgw1jQiW18fEsNTZzUJ52SoFhjfZ
	NKyYv1Mw3TUhBlvlJxpac5oomMjvYSE3e4OCW80mEXSU9DIw0JjHwMPvFRQ0ZY2LYeiFgYWP
	tb8Y+GTNpaFXX02DLS8Iuow7YfXVLIJOc5MIVu+WsPBg0MjCZLYNwWDHBA3FN/MQmNtGGNhY
	M7BBMtJQ/U5EWvQfxMRoSSPPTD5ENzJIEUvNHZZYFu+Lyfu3rSzpKdygSUvzkojkaudZ8m16
	lCYLbcMsKf/8VUTMDcM0eW3sFJ9zinA8HiuolOmC+sCJKEdFd6+JTtE5ZLxqCMxCRWIdcuAw
	fxhb7lgZHeI4mvfEOUMh9pjlvfDIyDplZ2feGz9pK2DsTPE2Bvcb4u28gw/BTfmzIjtLeMAL
	c/m0naV8NcL1v/Zt5k64t2iK3rz1wj9KByl7FcW74aqf3GbsgbXPi/9WOfDhuGtK+3fdhd+D
	2xu7RffQdv0Wk36LSf/fpN9iMiK6Bjkrk9IT5UrVET9NgiIzSZnhF5OcaEF/XqPyxo+CZrQ8
	dNqKeA7JtkmiZAEKKSNP12QmWhHmKJmzxN3gr5BKYuWZ1wR1cqQ6TSVorMiNo2W7JGcuClFS
	Pk6eKiQIQoqg/jcVcQ6uWchUV30quK3e75xb6cuVN0crSuZlA2Vy5Zwm3iN8t278UqFn7B5y
	Ymatx8tpcSai0b21zh1HjxXsP9t35PL24zbTySH2tr9vqsuV+fjgUe+6/vqrU0FxpX0Lpabr
	C+fbY/ojH/c9Ut29UBvWfTpmMnR5aviLom4gfm/chv/Ew0NB0ZkyWqOQH/Sh1Br5b+5GyJYW
	AwAA
X-CFilter-Loop: Reflected

On Fri, May 23, 2025 at 10:13:27AM -0700, Mina Almasry wrote:
> On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To simplify struct page, the effort to seperate its own descriptor from
> > struct page is required and the work for page pool is on going.
> >
> > Use netmem descriptor and APIs for page pool in mlx5 code.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> 
> Just FYI, you're racing with Nvidia adding netmem support to mlx5 as
> well. Probably they prefer to take their patch. So try to rebase on
> top of that maybe? Up to you.
> 
> https://lore.kernel.org/netdev/1747950086-1246773-9-git-send-email-tariqt@nvidia.com/
> 
> I also wonder if you should send this through the net-next tree, since
> it seem to race with changes that are going to land in net-next soon.
> Up to you, I don't have any strong preference. But if you do send to
> net-next, there are a bunch of extra rules to keep in mind:
> 
> https://docs.kernel.org/process/maintainer-netdev.html

I can send to net-next, but is it okay even if it's more than 15 patches?

	Byungchul
> 
> -- 
> Thanks,
> Mina

