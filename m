Return-Path: <bpf+bounces-21960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC23785440F
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 09:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76591B23662
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 08:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0CC4C6E;
	Wed, 14 Feb 2024 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ia2Ojjg9"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0878C64D
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899477; cv=none; b=uI+yBmmGerkXaNoejbM5MEgbwC6Jtozu5EtOzZQmWlSbgsssrH2yZuGf0SKUIYUKt+fvCV4pBSZlIpGFgYKRk9HIsTSFiIllla482MSszUSV9JWDd2awQwP5yMU3XiR8cmwdUt9LkCZFBZo3/evZGA4WZ83dnpk9S+9iWWRK5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899477; c=relaxed/simple;
	bh=m5P8193PpH7Qm3Papgh9jh9cFDyVT0g6AHD380+Qrm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZTpHZSFm912TeUgteS6h3G19knuGU1o1Ik7TJipdC1bM9iLJk0Bre5kaVVxCCaJ8gSip2TSgX1B4qaaccXN6A3HXxBxl5kRp0SiJM/xVf1zK/UR6qeDd2LnjeQdEPcGACYMcBjILcSX5IE0T+/jnN9hzuDdoa7UEMq0OxkqdD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ia2Ojjg9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IRQIBozged261rwkkkVGGiVN1CesemYgoVID/Sc+Mrs=; b=ia2Ojjg9yxaVw4MvxwuyvgCz49
	OhaNuu708nBZziRYAC2QrpbzKhhfp7btsCyzBMWbg12MPenSWhWt5ZS8luEeq/rmgaMtJqa52JKZl
	ZOr+cdSJR10/Lt0Epbkrj/tA+XU7VWant/+ymOOaKB7sOMMvUW78YC9tGoTRRBdve5TXPKV0APpJb
	NjgVCLWTJNhHm7k8EptFLJH/EVXXv6FCARrN45lgvX8EkP6K1jmAUUy1NvuSp2wSz/u26tqLB8Wv5
	WvhuZ+cyU0w51LoPfal3BIX8Kag5jukofH4PzlDudw78XfhDYecy36hUsE/XPQFw5rVOcMNoX8OVf
	aBKGjGcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raAfh-0000000C9Um-1zn5;
	Wed, 14 Feb 2024 08:31:13 +0000
Date: Wed, 14 Feb 2024 00:31:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com,
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@fb.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH bpf-next 03/16] mm: Expose vmap_pages_range() to the rest
 of the kernel.
Message-ID: <Zcx6UaSRCZQsUyvq@infradead.org>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-4-alexei.starovoitov@gmail.com>
 <30a722f3-dbf5-4fa3-9079-6574aae4b81d@lucifer.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a722f3-dbf5-4fa3-9079-6574aae4b81d@lucifer.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 07, 2024 at 09:07:51PM +0000, Lorenzo Stoakes wrote:
> > memory region between bpf program and user space process.
> > It will function similar to vmalloc()/vm_map_ram():
> > - get_vm_area()
> > - alloc_pages()
> > - vmap_pages_range()
> 
> This tells me absolutely nothing about why it is justified to expose this
> internal interface. You need to put more explanation here along the lines
> of 'we had no other means of achieving what we needed from vmalloc because
> X, Y, Z and are absolutely convinced it poses no risk of breaking anything'.
> 
> I mean I see a lot of checks in vmap() that aren't in vmap_pages_range()
> for instance. We good to expose that, not only for you but for any other
> core kernel users?

And as someone who has reviewed these same thing before:

hard NAK.  We need to keep vmalloc internals internal and not start
poking holes into the abstractions after we've got them roughly into
shape.


