Return-Path: <bpf+bounces-59122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32316AC618A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 08:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D0A17D26D
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 06:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BE2210185;
	Wed, 28 May 2025 06:04:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BED81C7009;
	Wed, 28 May 2025 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412270; cv=none; b=Ru4F60pztkGCWHZ9ls07E5yaKmARuW3ScK/KX+Y5hBFAduFDsaytrQTtsthc0HMvnK5uatTLygXABHzb0smUfWzBbYm8kCpWehLDLlUD3PJRb9dDAWauxznJc7j5NW1JkjRjcmqGGWPnVyl+O5QgXRE35qvp3MJ12QDYeZu6xOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412270; c=relaxed/simple;
	bh=7IvHI2yD3Ow1/HEpiyk6jSpf6fV/MSVK/eSw5hHlsV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tu5rLpbb6/Df44Ey6GtEkDpWTKEoO1Wz9VqBQiH5AfYqEP7tlmbneibcEno24L3Hi6uF/HtQpWgMVWlqwQfTr9I4n3y+8dCjEThDg6r7isItNz4rSbLeAhMj1Nh7z7et/IOK/kYR7PgfSzJ5W/GEHDuWtCgr+X2NfFC87zsQp2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-a1-6836a765b53f
Date: Wed, 28 May 2025 15:04:16 +0900
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
Subject: Re: [PATCH v2 15/16] netdevsim: use netmem descriptor and APIs for
 page pool
Message-ID: <20250528060416.GD9346@system.software.com>
References: <20250528022911.73453-1-byungchul@sk.com>
 <20250528022911.73453-16-byungchul@sk.com>
 <CAHS8izMwUvLYZipvj+0gcK4Ch8EqGu3g00aP488563VD3d9N9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMwUvLYZipvj+0gcK4Ch8EqGu3g00aP488563VD3d9N9g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGczvTmaGhZqyIVzQaa1wgERURT1zRB71xiSgPJm5QZbSVUqAs
	gokGEaJWC+KSYCmm4sKaVKtCUSCKCBgJNhihrFUUeHCLoBUoAS1o5O3L/+fk+x8OR8lMYh9O
	pYkXtBqFWs5IaMkXz7wlR/KDlMvqakVgNJcwUDyYBPnvrGIwFpUi+DHUzsJATR0Dt246KTC+
	TqPhp3mYgp7abhYcd3tpqDhbRkF3Zj0D+jQXBanWAhHYSjPEcHX4DgVlKe9YePPYyEBXyZgY
	eqv1NLw0FNLgyAiGWpM3OF99RlBjLhOB82IuA1eaTAx8SHMgaHreTUPO6QwE5iq7GFyDRiZ4
	HnlY2Coi5YZOlpgsCeRBgR/R2ZsoYik6zxBL/2WWdDRXMKQ+20WTcuuAiOjPfGXI9542mnyr
	essQ88O3NGkw1bBkwDInhN8rWRshqFWJgnbp+nCJsvJTOhuTJUtqsVxnU5BeqkMeHOYDceW5
	XJEOceN8p8/XHdP8ApzrGmXczPCLsN0+RLnZi/fFt6uyxG6meIcYNxqPuXkavwc35P+i3Szl
	V+GWS51IhyScjC9E+EVmq2iimIpfXv9ITxwvwiM3mii3l+Jn4fxRbiKei888yhl3efC7cEe7
	cXzDdH4+flpa93emlcNZmybWz8TPCuz0JTTVMElgmCQw/BcYJglMiC5CMpUmMUqhUgf6K5M1
	qiT/w9FRFvTnb+6eHNlnRf220GrEc0juKSX3ViplYkViXHJUNcIcJfeSpm4IUsqkEYrkE4I2
	OkyboBbiqtEsjpbPkAY4j0fI+KOKeCFSEGIE7b9WxHn4pKCQdsfqxddWjNjA2a9bmNRmVI1t
	D9b0Xgi2mdccrPnal3021pTwpNR7SnpBJoRemzI7cm36lvdbY/DnzQnbjr84kB053KPJCWp+
	ZTqUp15wdMf7oE0X7+/OCO866dpfri+Zu9X2IDm0b0N01Rz/4pDdsdkep8ICKkvWNep2/mTz
	NuIxOR2nVCz3o7Rxit8vwvoEMwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUiTcRjH+b3XXker12n5ln9E65CM1kHaAx32l/0SigpEiKLe8qWt3LRN
	RYPCPMhG8+iAXDMWplMLVsszD8TbLmNqaZoTKxudlrczqyWR/314vjyf7/PHw5LyNHoZq9bG
	ijqtEKVgpJR037aU9aI1WLWxoEQJZts9Bu5OJoB1oIIGc3EZgtGpXgmMNLYwkHd7nARzeyoF
	Y7ZpEt43D0rAWTBEQfXFchIGM1sZMKa6SUiuKCSgIbeNhhdlGTRcm84noTxpQAIdj8wM9N/7
	RcNQvZGCNlMRBc6MXdBsWQLjTz4jaLSVEzB+OZeBqw4LA29TnQgcDYMU3LyQgcBW202De9LM
	7FLgkqIeAlea3kiwxR6HHxYGYkO3g8T24ksMtv+4IsF9L6sZ3HrDTeHKihECG1O+Mvj7+9cU
	/lbbxeA81zCBbSVdFH5qaZTs9z4k3R4pRqnjRd2GncekqppPaZKYbHnCK3uOJAkZZQbEsjy3
	hc//sNaAvFiKW83numcZDzNcAN/dPUV62Jdby9+pzaY9THJOmn9uPuVhHy6Cf2qdoDws47by
	r7LeIAOSsnKuCPFNmT3EXODNt+W8o+aWA/iZWw7S00ty/rx1lp0bL+dTSm/+7fLiDvB9vea/
	NyzmVvJ1ZS1EFlpommcyzTOZ/ptM80wWRBUjX7U2XiOoo4KU+tOqRK06QXkiWmNHf56j4NxM
	dgUa7dhdjzgWKRbI8P0glZwW4vWJmnrEs6TCV5YcEqySyyKFxLOiLvqoLi5K1Ncjf5ZS+MnC
	IsRjcu6kECueFsUYUfcvJVivZUnoQfhL1+aWhnVf2/uBc9Q4t+WFBuwtTu+JWbqUYwt27BcX
	7Vse61R+6Ty8Z827qsIVbkHN5FR19Zp1LmFr+pFSQ+vuODgzE54coDEOcaGhlUkPf7gel3b6
	he09eJ1pekY03Zj5uVh7nfSxj31sHxbGX4ccd5Wcn1hV9yQi/EzYBQWlVwmbAkmdXvgNM57y
	KhgDAAA=
X-CFilter-Loop: Reflected

On Tue, May 27, 2025 at 08:25:54PM -0700, Mina Almasry wrote:
> On Tue, May 27, 2025 at 7:29 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To simplify struct page, the effort to separate its own descriptor from
> > struct page is required and the work for page pool is on going.
> >
> > Use netmem descriptor and APIs for page pool in netdevsim code.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  drivers/net/netdevsim/netdev.c    | 19 ++++++++++---------
> >  drivers/net/netdevsim/netdevsim.h |  2 +-
> >  2 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> > index af545d42961c..d134a6195bfa 100644
> > --- a/drivers/net/netdevsim/netdev.c
> > +++ b/drivers/net/netdevsim/netdev.c
> > @@ -821,7 +821,7 @@ nsim_pp_hold_read(struct file *file, char __user *data,
> >         struct netdevsim *ns = file->private_data;
> >         char buf[3] = "n\n";
> >
> > -       if (ns->page)
> > +       if (ns->netmem)
> >                 buf[0] = 'y';
> >
> >         return simple_read_from_buffer(data, count, ppos, buf, 2);
> > @@ -841,18 +841,19 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
> >
> >         rtnl_lock();
> >         ret = count;
> > -       if (val == !!ns->page)
> > +       if (val == !!ns->netmem)
> >                 goto exit;
> >
> >         if (!netif_running(ns->netdev) && val) {
> >                 ret = -ENETDOWN;
> >         } else if (val) {
> > -               ns->page = page_pool_dev_alloc_pages(ns->rq[0]->page_pool);
> > -               if (!ns->page)
> > +               ns->netmem = page_pool_alloc_netmems(ns->rq[0]->page_pool,
> > +                                                    GFP_ATOMIC | __GFP_NOWARN);
> 
> Can we add a page_pool_dev_alloc_netmems instead of doing this GFP at
> the callsite? Other drivers will be interested in using
> _dev_alloc_netmems as well.

Sounds good.  I can add it tho, however, Tariq Toukan might also need
the API while working on converting to netmem in mlx5.

Since I will re-work on his work done, why don't we ask him to add the
API so that he, I, and any other drivers can use it?

+cc tariqt@nvidia.com

	Byungchul
> 
> -- 
> Thanks,
> Mina

