Return-Path: <bpf+bounces-58926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BF5AC3B45
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 10:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCEF1679F3
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B65F1E520D;
	Mon, 26 May 2025 08:13:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ED03595E;
	Mon, 26 May 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247181; cv=none; b=dmXK3s0juWMx5/Qmu2aQ1aIG8g7RM3oxZfcmxksUqblCjNJYgE0jpoo3IOCkA4BKubUL5QcA6xk5XmS9tPoPLX3ABgD6S49VeyvFHk23iiXmsvxe2JL+YE0VpdwE/THV89+fVLZFnEChcYKAbv/K27OPqogW/j2RTo0KfvrjqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247181; c=relaxed/simple;
	bh=oIu84pilcqVfrxlqB16Lsl++65M0QoEeHgcBWV9nGgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqWPtL4qhNpHRklQNBAFsP1secfzd09etjjIVRBASoROhpf++f8Gt2OeufEq8S6gwFsR/qYaXCS/jIceIOQLdMWezj7XQ/dWl78OmnYkG8Ig6ZRrdJHXqdaUqkaWsbueiw1pa06zDD7/j6QdVfRNQZCUnEOXkESCeFXkvFzeQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-61-683422858314
Date: Mon, 26 May 2025 17:12:47 +0900
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
Message-ID: <20250526081247.GA47983@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-14-byungchul@sk.com>
 <CAHS8izOX0j04=KB-=_kpyR+_HZHk+4hKK-xTEtsGNNHzZFvhKQ@mail.gmail.com>
 <20250526030858.GA56990@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250526030858.GA56990@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzo7TwXFavZkVzkwSNUvDJ+j6Jd6oyPBDoR9q5amt5rRZ
	poFgzagktTRT50lmmvcaLHMzQmx5iy7apFqlzbwhZUZpkhe6TIn89uO5/f4fHpaSl4p9WLX2
	FK/TKjUKRkpLv3jcCrmgiFCFteq9QDDVMVD7MwUq+6xiEGoaEExMvZfAeEs7A2WlkxQInRk0
	/DBNUzDU1i8BZ8UwDQ8vWijoz+lgICtjhoLz1ioRdDVki+H69G0KLOl9Euh+IDDwoe63GIZt
	WTQ8MVTT4MzeBm3GxTD5dBRBi8kigskrNxnIsxsZGMhwIrA/7qeh+Fw2AlOTQwwzPwVmmx+p
	r34rIo2GXgkxmk+Te1VBJNNhp4i55jJDzN9zJaTn9UOGdBTO0KTROi4iWfoxhnwbekeTr02v
	GGKqf0WTZ8YWCRk3r4jiYqSb4niNOpnXrd1ySKoayxuhEu+6p4x8DkxHo2wmYlnMRWBDmzYT
	uc1hWV4G42KaC8B953LmmOECscMxRbnYm1uDy5uuiV1McU4xfiEcd7EXtwdbckZFLpZxgJ3V
	BX9npKyccyDc22yTzDc88ZOiQXp+ORDPltgpVwaKW4Yrf7Hz5ZVYf794zuXGbcTZE/o51yLO
	Hzc3tItcNzFXz+LO/FxmPvRS/KjKQV9FnoYFCsMCheG/wrBAYUR0DZKrtcnxSrUmIlSVqlWn
	hB5JiDejv49TkTYba0Xfu6JtiGORwkN2SBGukouVyUmp8TaEWUrhLfMVwlRyWZwy9SyvSzio
	O63hk2xoGUsrlsjWT56Jk3PHlKf4EzyfyOv+dUWsm086yqkMDvCtGui4F3xwC8cOkonlhVub
	Wt+9uRO68xLsW3WDzi0/7IBNQ/c7Nfnba93KE/yMJW/X1OPN0Zb8/oZE7/zdkWkwE2jf8TFZ
	7/tyOrbYXYiMiovv3pBSEDNxV1HXc9Ta7rVXMIfsejp9snv/p9Xh/iKtx4Min7qYA0s6Ep4r
	6CSVcl0QpUtS/gHQPK7/NAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe97b3i0Xr0vtTYNgIZKQFl040QUpqKcoCewC9aGNfGnLOceW
	NiVL2ySynJZd16yVprnE0bRthojMlUpRoRnrOtMUoWU3k0qxnBL57cf5n/P7fzksKSuiY1m1
	9rCg1yo1ckZCSVLXmJYUyVeolnaPI7A56xi489MINb1eGmwON4KRX69F8N3fzkDljVESbE/N
	FPxw/iZh4GGfCILVgxQ0n/SQ0FfawUCJeYyEE97bBLRVdNLwzG2h4fzvWyR4CnpF0H3fxsC7
	uj80DPpKKOi01lIQtKTAQ3sMjD4KIfA7PQSMnqlgoLzLzkC/OYigq62PgquFFgTOlgANYz9t
	TIocN9a+JHCT9a0I213ZuOF2Ii4OdJHY5TjFYNe3cyL85kUzgzsuj1G4yfudwCWmYQZ/HXhF
	4c8tPQyuHPpCYGdjD4Uf2/2iHZF7JWvTBY06R9Anr1dIVMPlQ6SufrZx6GNCAQqxxUjM8twK
	vrLczISZ4uL53sLSKWa4BD4Q+EWGOYpbzFe1nKXDTHJBmn9iOxTmudx23lMaIsIs5YAP1l6a
	3JGwMi6A+LetPtF0EMl3XvlATR8n8OPXuial7CTH8TUT7PR4IW+6d3WqS8yt5i0jpqmuaG4R
	3+puJ8rQHOsMk3WGyfrfZJ1hsiPKgaLU2pxMpVqzMsmQocrVqo1JB7IyXWjyOarzx8960Uj3
	Zh/iWCSPkCrky1UyWpljyM30IZ4l5VHSBbalKpk0XZmbJ+iz9uuzNYLBh+JYSj5PunWPoJBx
	B5WHhQxB0An6fynBimMLUNbstu4N7iPR7k951y84zHcmds4dOG43pl00tTxa0Fxd5b25JfX5
	6YOrlkVsG+8sTpxv9CelvNreHkG8MG40iDVHd+2eo6uKb3+ALbHa/h42dCHeoduXJpJ6oxdZ
	6vNxdtvCjNS03PvHNlUkNCg+v1+/LnlW5LHjvdSlmCGizH93nZwyqJTLEkm9QfkXuwxA+xgD
	AAA=
X-CFilter-Loop: Reflected

On Mon, May 26, 2025 at 12:08:58PM +0900, Byungchul Park wrote:
> On Fri, May 23, 2025 at 10:13:27AM -0700, Mina Almasry wrote:
> > On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> > >
> > > To simplify struct page, the effort to seperate its own descriptor from
> > > struct page is required and the work for page pool is on going.
> > >
> > > Use netmem descriptor and APIs for page pool in mlx5 code.
> > >
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > 
> > Just FYI, you're racing with Nvidia adding netmem support to mlx5 as
> > well. Probably they prefer to take their patch. So try to rebase on
> > top of that maybe? Up to you.
> > 
> > https://lore.kernel.org/netdev/1747950086-1246773-9-git-send-email-tariqt@nvidia.com/
> > 
> > I also wonder if you should send this through the net-next tree, since
> > it seem to race with changes that are going to land in net-next soon.
> > Up to you, I don't have any strong preference. But if you do send to
> > net-next, there are a bunch of extra rules to keep in mind:
> > 
> > https://docs.kernel.org/process/maintainer-netdev.html

It looks like I have to wait for net-next to reopen, maybe until the
next -rc1 released..  Right?  However, I can see some patches posted now.
Hm..

	Byungchul
> 
> I can send to net-next, but is it okay even if it's more than 15 patches?
> 
> 	Byungchul
> > 
> > -- 
> > Thanks,
> > Mina

