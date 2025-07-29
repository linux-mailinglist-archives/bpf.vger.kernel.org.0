Return-Path: <bpf+bounces-64608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D35C4B14C1A
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F8D7ADA56
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680B289358;
	Tue, 29 Jul 2025 10:23:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237632BCFB;
	Tue, 29 Jul 2025 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784581; cv=none; b=X1VIMbNgESWXT9g0D9mWphWbm9/YKh77Q8HdsES8VwF+baVNcjFd9KdPCYzSonvL0oQ76agnvbwHFcfe1Lg2mIyjhrIcpngAkajRlhvPqAjBI9slVWrid5GHMavZt3C14L8IMjxXu8VLSHHNVc0l+Vcxdw2W4dJ71fBS8JQ1IAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784581; c=relaxed/simple;
	bh=AaIZeRVIYZnyQ6QSUnkNThjJq9rsIZmrYYaAhc3P5UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3haUSDlirlobPKZURNqVOOs6WIOLWzqspVIGHrcjsQFS+bG3/mvJusUuHDvXju5my91NxWVFI6NgJpMa74iuhoT7rjgSqZlhotjmKipIn1jnZY5ouKbuVBzdWyVy0b9jAMoetbHL3u6lXTg1skebXPTULDs90BLf7CcWeWDoj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-68-6888a0f71497
Date: Tue, 29 Jul 2025 19:22:41 +0900
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
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page
 pool in page type
Message-ID: <20250729102241.GA62940@system.software.com>
References: <20250728052742.81294-1-byungchul@sk.com>
 <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
 <20250729011941.GA74655@system.software.com>
 <18eb9e6c-1d60-4db1-81e1-6bce22425afe@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18eb9e6c-1d60-4db1-81e1-6bce22425afe@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHee5zd+91NLxNq6eCgkUUiyzD4EhvIgRPH6KgD4W9jry0kS7Z
	0jQIVkqmNDPTyjlrvZimwmSGmzat5svSgsSw1qtmU3oxS63VVCxnRX37cc7//M75cASsdMrm
	CTr9Ycmg1ySpODkr/zTjyvLvtlPalUUlSrDaqzmo+pEO5b0uGVgr6xB8Db7g4WdjG4LRFi8H
	H5tHEFy7EsBgfZTFwjf7GIb+tj4eqhyboefGAAvubCeGvjP3OTBnjWNoDA7xcMJVwYC11sRD
	Z12eDArHyjA4Tb08PG6wcvC6+qcMBjxmFtotN1n4UtSCoScvDtpssyHwYBBBi93JQOB0KQfd
	xQ0MnOuycfA2qwdBV3MfC0UTpzgoOZ6HYPzHlG0o/6sMSlpf83Fq2jz4GdNbN58x1NfUwdB6
	yyue2hyptLZCTXN9XZg6KnM46hgp4OnLJ26O3r84ztL6N7G03jXKUHPmEEeH+5+z9HNTN7c1
	IkG+NlFK0qVJhhXr98m13vMX+ZRcefobay9rQkE+F4UJRIwh+SV29i9/KM6ZZlZcTL5fmMQh
	5sQlxOcLTnOkuIx8fOqZmpULWDzPk2y7m8tFghAh7iY1d9aEMgoRyED/xHRGKXYgcqemm//d
	mEnai/3TC7CoJr7J90xoFovzSfmkECqHietIf9VpLsSzxEXkbp2XCXmI2CuQYND75+i55F6F
	j81HouU/reU/reWf1oZwJVLq9GnJGl1STJQ2Q69Lj9p/KNmBpt7pxrGJnS400rnNg0QBqWYo
	tDnZWqVMk2bMSPYgImBVpCKl7KRWqUjUZByVDIf2GlKTJKMHzRdY1RzFqsCRRKV4QHNYOihJ
	KZLhb5cRwuaZ0LF3x+Miw1afNW9Z4B686/VdHX1Y1xcRe/1a4hb1DpN7veN2d1TBpYLouTXV
	ta2L/OtSF1ueunHZrNKFu+LOdTwcmyyPlw3648MvWRK+dfqp3v8hM+oAn7BxzDjMCzGFw5uc
	HfrowlYpfkdpjsscPnN3ZvieDe1LT6wwN2y/HIhdpmKNWk20GhuMml/XZ8JjSgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85e89xtDgts4MS1bqRmjcKnrDbJzsEZZEU3aiVhzaaJmdp
	GhWzJHOk2UVzc9LKTHPCZJp3M+bdoIumrpuapVGZdjHvaM6I/Pbj+f9/z/PlYUi5QeLOqMNP
	CWK4UqPAUkq6I/DimiHzZZVf4tUNYLLmYbCMREN2V4kETLlFCAZH39AwVVmH4FdNPYav1T8R
	ZN4ZIsH0LI6C39YxEnrqummw2LZD5/1eCirii0novtqAITFunITK0X4aLpTkEGAq0NFQndEo
	gedFSRK4OZZFQrGui4aWMhOGjrwpCfTaEyloND6g4HtKDQmdSVugzuwGQ0/6ENRYiwkYupKB
	odVQRsCNZjOGD3GdCJqruylImbiMIT02CcH4yPS2/uRBCaTXdtBbvPjqvgGSL3zwiuAdj5oI
	vtT4jubNtki+IMeT1zuaSd6Wm4B528/rNP+2rQLzDWnjFF/6fj1fWvKL4BMv9mP+R89rih94
	1Ip3uu6XbggVNOooQfTddESqqk9NoyP00uj3pi5Kh0ZpPXJhOHYt98WQQDmZYldww7cmSSdj
	dhXncIzOsCvrxX1tt0/3pQzJptJcvLUC6xHDzGcPcflVgc6OjAWut2dipiNnmxBXld9K/w3m
	cY2GjzMHSNaTc0x+JpwuyXpw2ZOMc+zCbuR6LFewkxewy7jHRfVEMpIZZ9nGWbbxv21GZC5y
	VYdHhSnVmnU+2hOqmHB1tM+xk2E2NP0w989NXCtBgy1b7YhlkGKOTJUQr5JLlFHamDA74hhS
	4SqLyLqkkstClTFnBPHkYTFSI2jtyIOhFAtl2/YKR+TsceUp4YQgRAjiv5RgXNx1KO209N4z
	zwNjDnePbfoB79UvA+XJWf6ix+azU5mTxkr5wdhr5VuHPz3NOLbnVWTMy9dsRu0iv+vbdXnL
	z6+UVIyd37ubwxNLcfDDo2KzefGLAF9LyFzfQv+7he3lblntmqAlAa1BsePByd5NeubGbU3d
	PvFbzvw+RwfVdjgkO3CXQUFpVUp/T1LUKv8AoYlxAiwDAAA=
X-CFilter-Loop: Reflected

On Tue, Jul 29, 2025 at 10:22:30AM +0100, Pavel Begunkov wrote:
> On 7/29/25 02:19, Byungchul Park wrote:
> > On Mon, Jul 28, 2025 at 07:36:54PM +0100, Pavel Begunkov wrote:
> > > On 7/28/25 06:27, Byungchul Park wrote:
> > > > Changes from v1:
> > > >        1. Rebase on linux-next.
> > > 
> > > net-next is closed, looks like until August 11.
> > 
> > Worth noting, this is based on linux-next, not net-next :-)
> 
> It doesn't matter, you're still sending it to be merged into
> the net tree. Please read

I'm sending it to be merged into *linux-next* tree since this's about
both mm and network.

However, if you are not talking about a specific tree to merge but you
are referring to 'Do not send *new* net-next *content* to netdev *during
the period*' in the link you shared, what should I do?

As for a network patch, I already tagged 'RFC net-next' as the guide:

   https://lore.kernel.org/all/20250728042050.24228-1-byungchul@sk.com/

For a patch aiming at linux-next like this, what should I do?  Should I
remove netdev@vger.kernel.org from the reciever list?  I'm not used to
this case.

	Byungchul
> 
> https://docs.kernel.org/process/maintainer-netdev.html
> 
> Especially the "git-trees-and-patch-flow" section.
> 
> --
> Pavel Begunkov

