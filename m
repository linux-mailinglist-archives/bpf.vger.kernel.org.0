Return-Path: <bpf+bounces-72670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC095C17F42
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 02:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E184D40551C
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D792E5B2E;
	Wed, 29 Oct 2025 01:56:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B572D0C7A;
	Wed, 29 Oct 2025 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702983; cv=none; b=gB6BdnOVcDL0D1rYvYxjHADIDpA6jvgR8UDD4xjQ2Kv9gANCLij0nxJB9SVwtoooeuOdz6LS2m89sOHaP4QiIKpXEygKBGrVqnkPheYkpWmeNJ9XH/ltAxQ4OP4A2VKxsZRq9C3MFDiw38KXL3Nh67SxYv9/+m1dt5+eVnKMnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702983; c=relaxed/simple;
	bh=oNEBHuq2LmK+th/kjOkTgOWVlI8Rc6Yn1bP3zYucX84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUgrdtD2rLDnF5HKNmFK7kIx0uZmPAO2d+9LVGvSi9rSLnVeOyy9gaI+PTMC8fyoWE6NP7hx+rPoO/Qn5kdrFJURLuHwb/Ow9hq6yuXPrKU04LG8tB1kxQgM/Z5eIx/bcfWE2HUfQ1T6oBMCd/9wWKWHxhPmuNpqj1ne8lIEhuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-f7-6901743d1673
Date: Wed, 29 Oct 2025 10:56:08 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: Re: [RFC mm v4 1/2] page_pool: check if nmdesc->pp is !NULL to
 confirm its usage as pp for net_iov
Message-ID: <20251029015608.GA37879@system.software.com>
References: <20251023074410.78650-1-byungchul@sk.com>
 <20251023074410.78650-2-byungchul@sk.com>
 <20251028183356.29601348@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028183356.29601348@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH99zn9t5LY81dBXmmm3GdZoYEBILmbEHDzBKfDyok+mXMZDb2
	blTbYlpeTVyqYhQjlSEqLSwDjbzWsJWNvgTMVqCAmM1UwetgoPhCVECCiPIi2GrM/PbLOf/z
	O+fDEbC6R7FC0JuyJLNJa9BwSlY5tqQqdlMW0sc/7l4HFY1ODhpe5kHNHY8CZpwjDFTUNyOY
	munnYbE1gOBZeycHT9omEVysmsZQ8U8BC88bZzF4fSMIHpdd5uBBYJiHBtd2GKp+yELLcTeG
	4dNdHBQVzGFonRnn4YinNiRusvJwvdmmgNLZSxjc1js83PBVcDDoXFTAQ38RC92OOhYmzrZj
	GLKlQKByOUz3jCJob3QzMH3qZw567T4G/mjt5eFMsJKDewVDCIJtwyycnT/BQflhG4K5lyHl
	ePGUAso7BvmUOHpYljnaNvoU09/rbjO0r+wnlspXrjLU6/iPp5WubNpUG0NPykFMXfWFHHVN
	lvB0oK+Fo11lcyz13v2Cej3PGFp0dJxLi0pXJuskgz5HMq/fvEeZ8cpn4w4EFXkNVX8jK3Kz
	J1GEQMQkci101Ds+d+T8G2bFtcR3vFQRZk78nMjyDA5zpLiGFDTZQxmlgMUJnpTJg6GQICwT
	jaSj1xjOqEQgiy/qcTijFk8g0ubtZd42PiTd9vtvFmAxhsgLj5jwLBZXkpoFIVyOEBOIvfoC
	F+Yo8TPyZ3MnE/YQcUogo4XX8NtDPyJ/1cpsMRId72kd72kd/2srEa5Har0px6jVG5LiMvJN
	+ry4vZlGFwq9WPWh+W89aPL6Tj8SBaRZooq/8IFerdDmWPKNfkQErIlUjZ4OlVQ6bf5ByZz5
	nTnbIFn8aKXAaqJVidO5OrX4gzZL2i9JByTzuy4jRKywovMls/ZF54ODxbryru9tm+qid3nu
	5+7QrS10zKcNDJiTTQmfXKI/Pi3eMpt3c9mtY6WuuaHUX9PZWNfwwpUNO7Y4X/TYU5N2GwKJ
	W0sDzC8l+RtTsrdZ+hOqc79aerfT/Y1nbNXXp2K/3DdiDc4n7mlUGVb3J+8aW9OS+vHF35pv
	fur/V8NaMrQJMdhs0b4Gq9SA+l4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTcRjG+5//Of9zthyczOxUdtEqpEEfRtHbJ14EHYoiuonqQtc65HBb
	taloFCwbZZbTPiy3ZkwlLbWEWepGVmxmWdGHpp2o1OzDPsSkzHLmbCui7h6e5/c8783L4ehL
	zFROb0qTzCatQU2UtHLD8oNzV6Yh/QJvLg+ummoCVT8yoaK7gYHh6l4KXJV1CAaHn7Mw1tiM
	4GvTbQKfAl8QlJUMYXA9tNHwrSaIwevrRfCx6BKBt809LFR51kNX+Tsarh2ux9CTf4dAnm0E
	Q+NwPwvZDRfCw7VWFgLFLQw8qrMzcCp4HkO9tZuFNp+LQGf1GAPv/Hk0tDgv0jBQ2IShy54I
	ze5YGLrXh6Cppp6CoWPFBNodPgquNrazcLLVTeC1rQtBa6CHhsKfOQTOHrAjGPkRnuwvGGTg
	7K1ONnG+eECWiRjo+4zFKxefUWJH0XFalK/fpUSv8yUruj3pYu0FjZgrt2LRU3mEiJ4vJ1jx
	Rcc1It4pGqFF76ulorfhKyXmHewnG2O3KlfskAz6DMk8f1WyMmXUZye7W5nMqpIHyIrq6Vyk
	4AR+kXA6+8xvTfOzBd/hU0xEEz5ekOVhHNEx/CzBVusIM0oO8wOsUCR3hiGOm8gbhVvtxgij
	4kEY+16JI0w0n4OEgLed+hNMEFocb34fwLxGkEMfqEgX89OEihAXsRV8guAoLyURPYmfKdys
	u00VIJXzv7bzv7bzX9uNcCWK0ZsyjFq9YfE8S2pKlkmfOU+3y+hB4Scq3//zeAMabFvjRzyH
	1FGqBaXj9NGMNsOSZfQjgcPqGFVffthS7dBm7ZXMu5LM6QbJ4kfTOFo9WbV2s5Qcze/Upkmp
	krRbMv9NKU4x1Yq6O3XeMWaKYU1B/uWOwkMz6kYSEzRRtn56TvrCh0/8CteS6Sv7NOMLXsXH
	jeriP0PbfeK4Ejq6ddU5zdOBM8GPul5tRtU63Z4cHbW5efEbU1KNNVNxQ97HrzOPixNWV9i3
	LMl/v6yMCXY8z45NjQps2p6b/DipJy748sXT16Fto2rakqJN0GCzRfsLmdJKBkADAAA=
X-CFilter-Loop: Reflected

On Tue, Oct 28, 2025 at 06:33:56PM -0700, Jakub Kicinski wrote:
> On Thu, 23 Oct 2025 16:44:09 +0900 Byungchul Park wrote:
> > As a preparation, the check for net_iov, that is not page-backed, should
> > avoid using ->pp_magic since net_iov doens't have to do with page type.
> 
> doesn't
> 
> > Instead, nmdesc->pp can be used if a net_iov or its nmdesc belongs to a
> > page pool, by making sure nmdesc->pp is NULL otherwise.
> 
> Please explain in the commit message why the new branch in
> netmem_is_pp() is necessary. We used to identify the pages based
> on PP_SIGNATURE, now we identify them based on page_type.

Yes, I will.  It'd be much better.  Thank you very much for the comment.

	Byungchul

