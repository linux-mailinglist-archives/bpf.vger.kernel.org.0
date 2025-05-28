Return-Path: <bpf+bounces-59141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2033DAC6454
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 10:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B713A3B124B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 08:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CAF26D4E2;
	Wed, 28 May 2025 08:17:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466E2242D98;
	Wed, 28 May 2025 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420268; cv=none; b=ZwabuFmPSpMC7m6gRqexAOq3p36Bl5iZMsolz54ODfOi2+4kmmUNYKbRUUeNNRAnn2WLrs/zt0ljwaBhsukAeuSgjXeDXGBvrEvFMZnFaahWjKzKXDHK91b/CgEcKOpOzZvF2XhQ3mSmhlWtc/zRTZBKBsDcj8cedhzBPouuSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420268; c=relaxed/simple;
	bh=3mNsnGzG6uUwa8ptFauGd0YKJXwEUMSFZsODR54wFjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYcm8RQyYtvSZlu2BEmAZ6h4fzzx3KfebeiXt50cN7yWng8y8pWGa4SNRxjanIMmBuqFvtT39Kh9V67N5ORJa1wzgrBuhi3+VS74+g93QtOJJi2W/PYVorvXtkcA65mXeEMfu9BL5wKiNgRyAnJTLuHIiIcURDwe1N0IORnmZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-a1-6836c6a6c04e
Date: Wed, 28 May 2025 17:17:37 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
Message-ID: <20250528081737.GC28116@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-2-byungchul@sk.com>
 <20250527025047.GA71538@system.software.com>
 <CAHS8izOJ6BEhiY6ApKuUkKw8+_R_pZ7kKwE9NqzCyC=g_2JGcA@mail.gmail.com>
 <20250528012152.GA2986@system.software.com>
 <CAHS8izMvRrG2wpE7HEyK3t544-wN_h3SC8nGabCoPWj1qCv_ag@mail.gmail.com>
 <20250528050346.GA59539@system.software.com>
 <4d7a307f-d595-4020-8060-f3bc2f8f72ca@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d7a307f-d595-4020-8060-f3bc2f8f72ca@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHed7nvW04elq3J6OiRURadpcTdIOCHiooqL50f8m3Npoa05Ya
	hZpQrVwXo8taNLPyUrRYMi+I5BS1G9rCXGkaVlZUCzNF026vEfXtx/9/+J3z4cjYeEyIlC0J
	yaotQbGaRD2v/xSROyO/NtY8a/COCG7vTRFu9KVA/stSAdxFfgRf+1sk6K6pEyEvtxeDuyGL
	hx7vNwxvajskaL/eyUPF4RIMHSfqRcjOGsCQWVrAQaPfKcCZb9cwlKS/lOBJuVuEtps/BegM
	ZPNwz1XIQ7tzKdR6RkPvg48IarwlHPQevyRCTtAjwqusdgTB6g4eLmY4EXgrQwIM9LnFpZNY
	ceEzjpW5XkjM49vL7hREMUcoiJmv6KjIfF9OS6z1aYXI6s8P8KystJtj2YfCIut685xnnyub
	ROYtbuLZQ0+NxLp9E9aSjfqFcarVYldtMxdv15u7Tp7Fex5FpFRXXkXp6KrOgXQyJfOo84WD
	dyB5iL/3LNRinkyhF2u7OI1FMpWGQv1Y45Ekmn5oDkgOpJcx+ShQ72E/rxUjiJVeyRkcYgMB
	mtHgFrQhI7mFaV/nO/FPMZzeu/B6aAiTKBr68Z7TFmMyjub/kLVYRxbRnodupPEoMpne9ddx
	moeSQpkeaakW/hw9llYVhPiTiLj+07r+07r+aT0IFyGjJcEer1is82LMqQmWlJgdifE+9PtF
	rh8Y3FSKvjSuCyAiI1OEgd2ebzYKij0pNT6AqIxNIw2ZS2LNRkOckpqm2hK32fZa1aQAGifz
	pjGGOb374oxkl5Ks7lbVPartb8vJush0FFsX32yP3LGS6IMOHUsLTYuskNfmWZqLHqxudZYP
	lrWd+Jqj2E/Pd6esn4i3HJtcVXVAWrZ/FT33+T73NiNDWnV51vSd4eeXmwyNdftal4f9QWtD
	+OClzv5D4VD0mu7sxw5pWeaCysDWDeP9wz5tzt04tzr51GKl5vaKqQVRW/MTTXySWZkdhW1J
	yi/HgA13HgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z/bjsPFcZkdlD60LMN7mvFCZhKUfwykixDVh1x5aMs5ZTPT
	IFBTpJFaWVJzxvKu2VbLvISITfFSiuEy18U0UzEy07xgalYror79eJ7nx/vlZUnpFOXOKtVJ
	gkYtV8kYMSWO2nnRr7x9hyIw72ogGMw1DNxdTIGK4QYaDNV1COa+vRHBbFsHAyV3Fkgw9GZS
	MG9eImGsfUQEQ+XjFDRl15MwktfJQE7mMgkZDZUEtBZ10fC8LpeG60tlJNSnDYvA9tjAwLua
	HzSMW3Mo6NJXUTCUGw7tRjdYeDaJoM1cT8DC5SIG8vuMDHzIHELQ1zpCQWF6LgJzs52G5UUD
	Ey7DtVWvCNyoHxRho+UsfljpjXX2PhJbqi8x2PL1mgi/fdnE4M6byxRubJglcM7FKQbPjL2m
	8JfmfgaXTEwT2FzbT+FuY5vogMsxcWisoFImC5qAsBixYuZKAZnY45zS2lyK0lCpkw6xLM9t
	57/Ph+qQE0txm/nC9hnCwQznxdvt30gHu3I+/KcBq0iHxCzJTdK8ObuOchRrORVfnL/ymyUc
	8Om9BtoxknImkl8cn2D+FC58163R3yOS8+btqx8Jx2GS8+ArVllH7MTt4ue7DcjB67hNfEtd
	B3EFSfT/2fr/bP0/24jIauSqVCfHy5WqEH9tnCJVrUzxP5UQb0G/vqD8wsrVBjRni7AijkUy
	Zwm+H6KQ0vJkbWq8FfEsKXOVZOzeoZBKYuWp5wVNwgnNWZWgtSIPlpKtl0QeEWKk3Gl5khAn
	CImC5m9LsE7uaSg6DdzPeVCmBKX0QfCLzGcn8/LfW0Y8C4KittiykgZbgw9HuNnCZ72yA47a
	7pXt1T7JimxKmDjDHt93UH6jJ3L/oWxdccmesK1Ta6oCXa557I4YnaT9fC3K2xk+ps++LUGD
	j+iKxLLoMuTjt8E6FzStfmpLXhrwzJ8rpU0bn843yyitQr7Nm9Ro5T8B9lLpoQEDAAA=
X-CFilter-Loop: Reflected

On Wed, May 28, 2025 at 08:43:34AM +0100, Pavel Begunkov wrote:
> On 5/28/25 06:03, Byungchul Park wrote:
> ...>> Thus abstractly different things maybe should not share the same
> > > in-kernel struct.
> > > 
> > > One thing that maybe could work is if struct net_iov has a field in it
> > > which tells us whether it's actually a struct page that can be passed
> > > to mm apis, or not a struct page which cannot be passed to mm apis.
> > > 
> > > > Or I should introduce another struct
> > > 
> > > maybe introducing another struct is the answer. I'm not sure. The net
> > 
> > The final form should be like:
> > 
> >     struct netmem_desc {
> >        struct page_pool *pp;
> >        unsigned long dma_addr;
> >        atomic_long_t ref_count;
> >     };
> > 
> >     struct net_iov {
> >        struct netmem_desc;
> >        enum net_iov_type type;
> >        struct net_iov_area *owner;
> >        ...
> >     };
> > 
> > However, now that overlaying on struct page is required, struct
> > netmem_desc should be almost same as struct net_iov.  So I'm not sure if
> > we should introduce struct netmem_desc as a new struct along with struct
> > net_iov.
> 
> Yes, you should. Mina already explained that net_iov is not the same
> thing as the net specific sub-struct of the page. They have common
> fields, but there are also net_iov (memory provider) specific fields
> as well.

Okay then.  I will introduce a separate struct, netmem_desc, that has
similar fields to net_iov, and related static assert for the offsets.

	Byungchul

> 
> -- 
> Pavel Begunkov

