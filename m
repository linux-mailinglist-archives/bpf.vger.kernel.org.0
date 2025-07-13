Return-Path: <bpf+bounces-63138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEFAB0336A
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 01:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23F13B5BB2
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 23:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C62046BA;
	Sun, 13 Jul 2025 23:22:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ABF1F2382;
	Sun, 13 Jul 2025 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752448947; cv=none; b=oAILIZ2hBZK+BKUgbDrGB+9I2Q1DCXlIB3oiGEwRkRpa/CSbihF/5TK+F8juwpvjHrZlxVnLK7DpoLnvPorqqJ1BaWPtQ53alEKdGsja6wkDRZoJSWCFrL1WsupoJDrzEIixlQU1btO8dsZuzm203piYc0afEe3uGaTcwehWqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752448947; c=relaxed/simple;
	bh=dtFvN8IIsFkOruHzoFJ3V6U6s18S36ih/STH2XF1yNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9MJ3hnxzUHFNMFRV2MOS4omRMHjZj+5/dgOlNyjvA3V9FUQC4t8rWPhoHIwPc3BXAjVSYsQ8UotRybCR9jIgBeEE/Zb3zlBuLiq4Aw4xL1Cj4Bp/5eV07Kj01/XXZR+kmpk458KE6m0/WnLmOJ0NuV9RqZoNYyJ3PRpB0OJNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-d1-68743fab9764
Date: Mon, 14 Jul 2025 08:22:14 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	"willy@infradead.org" <willy@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
Message-ID: <20250713232214.GA13576@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-4-byungchul@sk.com>
 <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
 <20250711011435.GC40145@system.software.com>
 <582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com>
 <3acd967e-30b3-4e76-9e1b-41c1e19d4f31@redhat.com>
 <7c8b9d7f-545c-4e37-8d0e-39b1d525a949@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8b9d7f-545c-4e37-8d0e-39b1d525a949@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHfe69u/c6Gjyut6f8IlMRLLPC6EAv+iluHwKlV+x15aUtdcmm
	pkG5zAxNTVSo5gvXQrNNGCzRWWY1zQqjF8uclVnWKsvUtMxprpwh9e3HOf/zO+fD4WnlBdli
	XqtLFvU6dYKKlTPyr3MqwyyRyZrlj/qCocxay4JlPA0uv7HLoMxcj+C7+yUHo613WbhUOUZD
	2aMsBn5YJ2hwtfVxYLFtgt7qDww0nW6goe/sPRbysyZpuOEe5CDTXkPB4/oCGZRMVNHQYHzD
	wdNrZSy8rv0tgw+OfAbum64w0FsQBW3SAhhrH0DQam2gYCyvnIXiDomFd1m9CDpa+hgoPVGA
	wNrslMHk+LSj9M5rLipIaBkYooW6K92U0Gjq4QTJliJcrQkVcp0dtGAz57CCbaSIE149b2KF
	e+cnGaHRPkoJ+ScHWeGb6wUjDDV3soK1rpMRHkitXLRfrHxtnJigTRX14ev3yTUt/afYpEG/
	tFPdEmdEdkUu8uUJjiDXzBXcLEvtmZSXGRxM8qa6kJdZHEKcTjft5Xl4CfnS5ZjOy3kad7Fk
	6Hq/LBfx/FycRsztrDejwECG257NOJX4G0XaixV/637k/oX3jJdpHEqcnn7KO0pjf3LZw3vL
	vngd6fVcnVk7HweSW/V3Ke8qgu08cVcMUH/vXERu1ziZQoRN/2lN/2lN/7QSos1IqdWlJqq1
	CRHLNOk6bdqyA4cTbWj6YaqP/dppRyOPNzsQ5pFqjsJZZ9AoZepUQ3qiAxGeVs1TfO7Ra5SK
	OHX6UVF/eK8+JUE0OJA/z6gWKlaOHYlT4oPqZDFeFJNE/WyX4n0XG9GBovB9ITsMbtcz88me
	ilWHmmN2FU3ksFXG5tjyJ9StlIzVF0l8zPLxjDNhN8M/al/taUwcDgvYFO1TKEXuDhreFtDt
	ydr+PvthvDic4vqoy17zdn+TJer4uZd5/rwUvyHyXe3WAKN/RMsWn08lPwNcgRlfLPXnlm4c
	9GTinJWRU2YVY9CoV4TSeoP6DzrhuPIsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRiH+Z9zds5xdOK4rI5WBCsRrMyg4I0u7kt1ChIjIro79NRG87bp
	mIGktQqH2vVDzYkL8W4tlugsFZ02swXJvM3MC6aSKTPTNF1aroj69vB73+d9v/xoXOIlgmhl
	fLKgjperpKSYEEfuub6tPCJZEd5VwILJUkFC+XcdFA/aRGAqq0IwM99LwXRzCwkFj2dxML3T
	E/DNsoDDiGOIgnLrURgoGiWg9lY1DkO3X5OQrffiUDfvoeCarQSDprxWEbRV5YjgwUIhDtXp
	gxS0vzCR0F/xUwSj9mwCWo2lBAzkyMBhXgOzzgkEzZZqDGaz8ki47zKT8FE/gMDVNERAbkYO
	Aku9WwTe78s3cl/1U7JgvmliEucrS3swvsbYR/Fmawr/vCSUN7hdOG8tyyR569d7FP+hq5bk
	Xz/0EnyNbRrjs697SH5q5D3BT9Z3knzBpy8Yb6nsJKIkp8V7YwWVUiuot++PFiuaxm6QiR5/
	3Y0eM5WObIwB+dEcu5MzO69hPibYYC5rsRv5mGRDOLd7HvdxALuFG++2UwYkpnG2m+QmX46J
	DIimV7E6rsxJ+nYYFrgvjg7KxxJ2CuOc95k/uT/X+miY8DHOhnLupTHMp+LsOq54ifbFfuw+
	bmDp+e+3q9lNXENVC3YHMcb/bON/tvGfbUZ4GQpQxmvj5ErVrjDNZUVqvFIXFpMQZ0XLlShK
	+3HXhmbaD9kRSyPpCsZdqVFIRHKtJjXOjjgalwYwn/vUCgkTK0+9IqgTLqhTVILGjtbRhHQt
	c+SkEC1hL8mThcuCkCio/04x2i8oHZ06J13PHm90hMg65mrlRQeSn5zIbrRlMLk228bze58G
	ZrVph5KSMhoYWVCaKVI9N9jZ8aaQiomMlAa2Zx3ObKm7uJs8coyaOTsuiK9WO85otuqmb0ZJ
	emW3VXRDXVrshe78DS6rd5jWPivKX5SEhL+lPBsNeku952DEZv3wSimhUch3hOJqjfwXyiGK
	mg4DAAA=
X-CFilter-Loop: Reflected

On Sat, Jul 12, 2025 at 04:09:13PM +0100, Pavel Begunkov wrote:
> On 7/12/25 15:52, David Hildenbrand wrote:
> > On 12.07.25 15:58, Pavel Begunkov wrote:
> > > On 7/11/25 02:14, Byungchul Park wrote:
> > > ...>>> +#ifdef CONFIG_PAGE_POOL
> > > > > > +/* XXX: This would better be moved to mm, once mm gets its way to
> > > > > > + * identify the type of page for page pool.
> > > > > > + */
> > > > > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > +{
> > > > > > +       struct netmem_desc *desc = page_to_nmdesc(page);
> > > > > > +
> > > > > > +       return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > > > +}
> > > > > 
> > > > > pages can be pp pages (where they have pp fields inside of them) or
> > > > > non-pp pages (where they don't have pp fields inside them, because
> > > > > they were never allocated from the page_pool).
> > > > > 
> > > > > Casting a page to a netmem_desc, and then checking if the page was a
> > > > > pp page doesn't makes sense to me on a fundamental level. The
> > > > > netmem_desc is only valid if the page was a pp page in the first
> > > > > place. Maybe page_to_nmdesc should reject the cast if the page is not
> > > > > a pp page or something.
> > > > 
> > > > Right, as you already know, the current mainline code already has the
> > > > same problem but we've been using the werid way so far, in other words,
> > > > mm code is checking if it's a pp page or not by using ->pp_magic, but
> > > > it's ->lur, ->buddy_list, or ->pcp_list if it's not a pp page.
> > > > 
> > > > Both the mainline code and this patch can make sense *only if* it's
> > > > actually a pp page.  It's unevitable until mm provides a way to identify
> > > > the type of page for page pool.  Thoughts?
> > > Question to mm folks, can we add a new PGTY for page pool and use
> > > that to filter page pool originated pages? Like in the incomplete
> > > and untested diff below?
> > 
> > https://lore.kernel.org/all/77c6a6dd-0e03-4b81-a9c7-eaecaa4ebc0b@redhat.com/
> 
> Great, then it'll be the right thing to do here. I somehow missed
> the post, will add your suggested-by.

It'd be the ideal.  I will wait and work on top of your patch then.

	Byungchul
> 
> --
> Pavel Begunkov

