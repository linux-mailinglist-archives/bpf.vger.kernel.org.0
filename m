Return-Path: <bpf+bounces-63141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95912B03524
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 06:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B671893531
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 04:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905161F099A;
	Mon, 14 Jul 2025 04:24:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAAC6FC3;
	Mon, 14 Jul 2025 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752467042; cv=none; b=YeNROScK3gwrRN3NYxhW+1PFE0m33XcUKf14qbVeuFlxi1Cn7R0amA6/Mq0jG809+Gkca8GWYhDQo38XS6Wou9WCs5nZmRSaJVCaJm6T42RP8ltIQCwOfvTsIQpAgbapFHMACAgfSRrGVaCTSi+48nmNxKxGaQUhC3TpVAI0QQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752467042; c=relaxed/simple;
	bh=tVtCeEn2gf6NnRX1UQX7W30NiqyFXes5Xv72AHBhBZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWxVeLtPWzF2lbOH7NzlsRL3TebLrcnt3SQEl8yWgEg+gBcp7AW+F67F6HE1c3+5v8IgRCLD8Db/fewbDdoeU3fU2wl/NJuFu5vYxMs8NShx8E2+ngre4nniIqfZmVixcS2jegjCoLBv0Y5PXw2fB4I8CkF//e/AUHZeOICxvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-54-68748658e11a
Date: Mon, 14 Jul 2025 13:23:46 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 1/8] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250714042346.GA68818@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-2-byungchul@sk.com>
 <b1f80514-3bd8-4feb-b227-43163b70d5c4@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f80514-3bd8-4feb-b227-43163b70d5c4@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe895d85xNnidZW/1oVhJYGRZUs8Hi27Q+VIEfagMrJWHNnKr
	NjUvBJaWNXPdhGwqrZv3HCxzKiY2TbtSGdbpqmlKlhlZDU3b8hhR3378/w+/5/nwCKzWoZoh
	GM2JksWsT9Bxaqz+PPnSgi1HEw2LMqsIFLoqOagYToGSrloVFJbXIPg+8oqHby1tHFy+6GOh
	8FEWhh+unyz0tnbzUOFeD53FfRgasj0sdJ+8w0Fu1igLN0cGeThcW8rA4xq7CvJ+XmXBk9HF
	w9P6Qg7eVgZU0OfNxXDXUYah074SWp1h4Ls/gKDF5WHAd6KIg7PtTg56sjoRtDd3Yyg4ZEfg
	apRVMDo87ii4/ZZfOVdsHvjCitVlLxixzvGGF53uJPF6aYRok9tZ0V1+nBPdQ2d48fWzBk68
	kz+Kxbrab4yYmznIiV97X2LxS2MHJ7qqO7D4wNnCbwyJVcfESwnGZMmycMUOteFrRz7el82n
	ZJ7yoAzUqrKhIIGSaDrYf2SchQl25UQpMSbhNM/hYRTmyDwqyyOswlPIfPrpuZe3IbXAknyO
	Vr0r5pQilOjpvTE7VlhDgPpsP7AypCV5iD58MsD9KULo3fPvJ4ZYEkFlfz+jLGbJTFriF5Q4
	iCynDyrGJpZNJXNoU00bo3goaRLolfN25s/R0+mtUhmfQsTxn9bxn9bxT+tEbDnSGs3JJr0x
	ITrSkGo2pkTu2mtyo/GPKT44tq0WDT3e5EVEQLrJGrnaatCq9MnWVJMXUYHVTdF8fGMxaDXx
	+tQ0ybJ3uyUpQbJ60UwB66ZpFvsOxGvJbn2itEeS9kmWvy0jBM3IQLFturLeUdko5HQNzBnO
	WWYL86e1qH/F8MHxmy4+igtJWxpof7h52qzOY2Aq2BKHV8ecdn4I+aU+11jFRSUFpQvlwV3+
	7FlPXMYiqSgtf8Ok0/Vln0+kr4u40NSz9tzWsWUBc8+a4GvdN2bvXxKqXs+aUgM7A33hq+Sh
	HbHb/ZVuHbYa9FERrMWq/w04IrSdLQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+59zds7ZanRaVicDraUJhnah6KUs/BB0CpLoQ0IUtfLUhtuK
	bYoLQk3JWrluo2xOWFle5miwzM1QkWkzMzMX1rqpWY0uZul0aC7LFVHfHt7f87zPl4fGJWEi
	mlaodbxGLVNKSREhSttQkJR+Uidf2fgoBSwOOwk14zlQ2e8WgMVWh2B04iUFwdY2EsqvhXCw
	dBUSMOb4jsN77wAFNc7t0FcRIKChyIXDwLn7JBQXTuLQODFEwQl3FQYtZe0CeFxnFIDp+00c
	XHn9FDy5ayGh1/5TAAFPMQHt5moC+oyp4LXOh1DHIIJWhwuD0NkyEi75rCS8LexD4GsZIKA0
	34jA0eQXwOT49I/Se71UajzXMvgV52qrn2Ncvfk1xVmdWdztqkTO4PfhnNN2muScIxcp7tXT
	BpK7XzJJcPXuIMYVFwyR3PD7FwT3tamH5Mo/fMM4R20PsUOyW5SSwSsV2bxmxab9IvlwTwlx
	tIjKKTjvQnnIKzAgmmaZNazjzCoDEtIEE8+azC4sokkmgfX7J/CIjmKWs5+feSgDEtE4U0Ky
	t95UkBEwl5GxD8JGIqLFDLAhwxgRMUkYE2I7uwfJP2AO23713W8TziSy/qmPWKQYZxaxlVN0
	5CxkNrIPa8K/y+YxS9nmujbsPBKb/0ub/0ub/6WtCLehKIU6WyVTKNcmazPlerUiJ/ngEZUT
	TW+i4nj4ghuNPtniQQyNpLPE/lqtXCKQZWv1Kg9iaVwaJf70WiOXiDNk+mO85sg+TZaS13rQ
	IpqQLhBvS+f3S5jDMh2fyfNHec1fitHC6DzUtiv4I+3j2i7f1XnGzYdexa3MNX1R5XoCe5Mu
	/5hpmG3TJQ+tS45Z0dq1ZESwemuTeGfM4KlluVfsecw2+z5hmmWDQS62KgsCCRbVrtju8T35
	d8KYVnojOLIzhHVUL4neEpdqK2QWm69P6Y2xWZ0Lk7wzTpuEP63rY45nHGiuOywltHLZqkRc
	o5X9AlsVzYoPAwAA
X-CFilter-Loop: Reflected

On Sat, Jul 12, 2025 at 03:39:59PM +0100, Pavel Begunkov wrote:
> On 7/10/25 09:28, Byungchul Park wrote:
> > To simplify struct page, the page pool members of struct page should be
> > moved to other, allowing these members to be removed from struct page.
> > 
> > Introduce a network memory descriptor to store the members, struct
> > netmem_desc, and make it union'ed with the existing fields in struct
> > net_iov, allowing to organize the fields of struct net_iov.
> 
> FWIW, regardless of memdesc business, I think it'd be great to have
> this patch, as it'll help with some of the netmem casting ugliness and
> shed some cycles as well. For example, we have a bunch of
> niov -> netmem -> niov casts in various places.

If Jakub agrees with this, I will re-post this as a separate patch so
that works that require this base can go ahead.

	Byungchul
> 
> --
> Pavel Begunkov

