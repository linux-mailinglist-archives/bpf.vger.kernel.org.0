Return-Path: <bpf+bounces-58960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F45FAC45EB
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 03:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72124189AF4F
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 01:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDD13D8A3;
	Tue, 27 May 2025 01:31:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397C88F58;
	Tue, 27 May 2025 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748309489; cv=none; b=HQRF03dTym5aJeICQi3AY/8L/JBWeib5pjgFkMQ3wpb8cJsZx24M1KJhsKai7ilqhx9q1IKv+Ad1ZHXnJrbP5HZxaHqE+J5FkJJ3wWR+4Bl3mi6eBtT/dS7Ax5AYA2r3ME3ZFx1ojH3ECL8XCWCE2sW5YiUYzK7UM8eF+KJFIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748309489; c=relaxed/simple;
	bh=pm3Pc32Zf4LoF+JccJiR/o/mHSX4HrNhTRUfRVe+RHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjOXV+EnVn0Q3Ssp/dbVYEmmuUUOddEq/TgIWRXEFIDP+n5NxfspkZdqo/WUpJR9ArEHqrNXubuyqhT196gbowKroJO/2bp1AayMYaOtYGCMDpjKJYIW78SgWFcNGrc2+VT0EVwuhgJmf+eNphB0awAmdGvWr7rutyt3wAf80Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-dc-683515e91fbd
Date: Tue, 27 May 2025 10:31:16 +0900
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
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct
 page
Message-ID: <20250527013116.GA37906@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-19-byungchul@sk.com>
 <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
 <20250526013744.GD74632@system.software.com>
 <cae26eaa-66cf-4d1f-ae13-047fb421824a@gmail.com>
 <20250527010226.GA19906@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527010226.GA19906@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX/PHWdfh3w9jDkzW1YeVvNB0sbmN6OhZsOGW/3W3XQnV1Ia
	OzQPTQnN6hy7hh5OHCfXSaITMm2uQ64HHaXGlKe49WDFjxn/vfd6vz/vz+ePj0CrjrFTBJ0h
	VTIaNElqTsEoescUhb6fGKGdX5u3GCz2cg4u96dDyWsXCxabE8G3gVYe+uoecXChKECD5WkW
	A9/tgzR0PezgwV/czUD1kUoaOk7Uc5CTNUTDQVcpBR5nLgv5g5doqDS95uFZlYWD9vIRFrrd
	OQw8Npcx4M+NhofWYAg86UFQZ6+kIHD8HAenvVYOOrP8CLz3Oxg4eyAXgb3Gx8JQv4WLnilW
	lDVT4i3zK160OnaLN0pDxGyflxYdtmOc6Ph6ihfbmqo5sb5giBFvufooMefQR0780tXCiJ9q
	XnCiveIFIzZY63ixzzF9Hd6siEyQknRpknFe1HaF1tv1jk8+ODa9p6WVM6ECRTYKEggOJx6T
	g/6rXfmNKBsJAoNnk6rueBlzeA7x+QZ+RybgueTDSzefjRQCjXtYYj/iZGRjPI4jz98U8vKs
	EgN52TlJxipcRZGTz1bLWonHkceFb3/HaRxCfMPvKTlO46mkZFiQcRBeTPxfrlGynohnkXvO
	R5S8iuAygdy2nWP/nDmZ1Jb6mDyEzf/Vmv+rNf+rtSLahlQ6Q5peo0sKD9NmGHTpYfE79Q70
	60GK9/3Y4kJfPbFuhAWkHqP0SOFaFatJS8nQuxERaPUEpTPvF1ImaDL2Ssad24y7k6QUN5oq
	MOpJyoWBPQkqnKhJlXZIUrJk/OtSQtAUE8rt71iUHHq1qLOeWw8bYjwRnRvHVZx5Hhdt6L9T
	aDilDH41eobfuSTqYtPdFdfDE1d1bz0/EvM5ZAE3LWxtvu16cGZ7E7MrbfNN7/5lzcMx+uTY
	4Ss7apT32xoyFx1tPTr28Nrm6KVsVuiam/wWZk3jHp4Ki2wctSnSsfxBIK7h7cpeNZOi1SwI
	oY0pmp98m5tjHAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGe885O+e4nLya1sGCYt01rcjqH4pYBL34IRICTSJdemijeWkz
	06AwlURT06zQtWIlZS5jsWROEaklXkjQNGtlNdPUiVLZxWqa1gmivj38nuf37eFpv0kmkNek
	Zoi6VJVWycoZ+d7wvJDxgK3qTZWzQWC01LFw53sW1AzaZWA02xB8+THAwefWdhaqr0/TYOzO
	Z+CrxUPDSNsQB65boww0FzTQMHS+g4WS/Bkacu23KXh0tVMGPbZSGVz03KShIWeQg74mIwtv
	6uZlMOooYaDTUMuAqzQK2kyLYfrxJIJWSwMF08VXWajoNbEwnO9C0PtoiIErZ0oRWFqcMpj5
	bmSjlKS+9gVFGg2vOWKyHif3bweRImcvTazmQpZYP13gyKtnzSzpqJxhSKP9M0VK8t6zZGrk
	JUM+tPSzpNr9kSKW+n6GdJlauX2+8fKIZFGryRR1GyMT5ereETeXnuuTNflygM1BlfIi5MUL
	OEywX3yCihDPM3i10DSaJGEWrxWczh+0lP1xsDDx3MEVITlP40mZYCmwMVKxCO8Xnr6t4iRX
	gUF4PrxEwn64iRLK+6KlrMC+QmfVuz9zGgcJzrlxSprTeKlQM8dL2AvvEFxT9ygpB+CVwgNb
	O1WGFIb/bMN/tuGfbUK0GflrUjNTVBrt1lD9UXV2qiYrNCktxYp+f+DWqdlyO/rSt8eBMI+U
	3ooeMUztJ1Nl6rNTHEjgaaW/wlb2GymSVdknRV1agu64VtQ70FKeUS5RRMeKiX74iCpDPCqK
	6aLub0vxXoE5qLu9Yx0T820ivC0mPinMa316hPemhws+1B4ez9f3b/vp9ozvOqZNDunJqVm+
	/dyaWX/vhupY7PmadmPKThIix2Kjg6sqggfVyV3vWqoPHpk3R3iu+caNXfZ5srtwC05bZU+w
	3l3sCkiRxw2c3nCoeNlY+E732UsrWFn9AfeJXJ+JhUpGr1ZtDqJ1etUvF08Tpf8CAAA=
X-CFilter-Loop: Reflected

On Tue, May 27, 2025 at 10:02:26AM +0900, Byungchul Park wrote:
> On Mon, May 26, 2025 at 05:58:10PM +0100, Pavel Begunkov wrote:
> > struct net_iov {
> > 	unsigned long flags_padding;
> > 	union {
> > 		struct {
> > 			// same layout as in page + build asserts;
> > 			...
> > 			struct page_pool *pp;
> > 			...
> > 		};
> > 		struct netmem_desc desc;
> > 	};
> > };
> > 
> > struct netmem_desc *page_to_netmem_desc(struct page *page)
> > {
> > 	return &page->netmem_desc;
> 
> page will not have any netmem things in it after this, that matters.
						   ^
						   this patch series
	Byungchul
> 
> > }
> > 
> > struct netmem_desc *netmem_to_desc(netmem_t netmem)
> > {
> > 	if (netmem_is_page(netmem))
> > 		return page_to_netmem_desc(netmem_to_page(netmem);
> > 	return &netmem_to_niov(netmem)->desc;
> > }
> > 
> > The compiler should be able to optimise the branch in netmem_to_desc(),
> > but we might need to help it a bit.
> > 
> > 
> > Then, patch 2 ... N convert page pool and everyone else accessing
> > those page fields directly to netmem_to_desc / etc.
> > 
> > And the final patch replaces the struct group in the page with a
> > new field:
> > 
> > struct netmem_desc {
> > 	struct page_pool *pp;
> > 	...
> > };
> > 
> > struct page {
> > 	unsigned long flags_padding;
> > 	union {
> > 		struct netmem_desc desc;
> 		^
> 		should be gone.
> 
> 	Byungchul
> > 		...
> > 	};
> > };
> > 
> > net_iov will drop its union in a later series to avoid conflicts.
> > 
> > btw, I don't think you need to convert page pool to netmem for this
> > to happen, so that can be done in a separate unrelated series. It's
> > 18 patches, and netdev usually requires it to be no more than 15.
> > 
> > -- 
> > Pavel Begunkov

