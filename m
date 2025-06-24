Return-Path: <bpf+bounces-61332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3DCAE5933
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250F3173587
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 01:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CACF15748F;
	Tue, 24 Jun 2025 01:28:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807E1FC8;
	Tue, 24 Jun 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728493; cv=none; b=jxot5J4/3f9jwA8WE8now7DO+KVRSVBEimOogxV8g6jrU4MN9CtQLdm65RC65tUryWUHEjitK+u61uE8HlZ63MX1e11cQO4g/L73l4gz/8gc4gBGjHU6qrAZdkSk4FQjGpljV4dGGbvVz/CtmluDDs2CsKTh6heCzV5tsjmMI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728493; c=relaxed/simple;
	bh=7M5F+tnyHw2aNxVJNRF8Yv3zFrx8xv99dxlE0Z+p52U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxBpK691aupW/ICGcVDsYLyayhxtkS32W/pVMsSx/HO5RDs2a+lFBEpmdqdSfZ4fjSXzNp5VAHguNxxvEQrWact6LWVNuR32rPsvXCHfNcMad8j/RwTUhV/PSeuI2Uk63IW5HvHnkcHEcdwaDZmpFyHa9gJ6j94E/VlSJGsl7To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-52-6859ff24dc19
Date: Tue, 24 Jun 2025 10:27:59 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, almasrymina@google.com,
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
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v6 6/9] netmem: remove __netmem_get_pp()
Message-ID: <20250624012759.GB5820@system.software.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-7-byungchul@sk.com>
 <20250623043207.GA31962@system.software.com>
 <20250623171706.3bb10482@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623171706.3bb10482@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfe/73PM8nW77Or++8k87Ygv5segzP5qx+BpGIgsbNz3czRUu
	UmHCTVhdhU2uzNNMrmRnJ3W1Y7kSjbAzdomy82NroxBHP8hdZvrvtff7vdc+f3xErClWhomG
	1H2SKVVn1PIqTvUptHRGxGCSfpbn7UgosVfycO1nBlx941RCSUU1gm+9bQL0NN7n4XKpH0PJ
	EzMH3+19GN43+QS45lgNHWUfOHDl1GDw5T/gIc/cj+F2b5cAx5w2BTyttijhXN8VDDXZbwR4
	VlfCQ3vloBI+uPM4aLaWc9BhWQxN8jjwP/yIoNFeowB/7kUeznpkHt6aOxB4GnwcFB+1ILDf
	8Sqh/2fAUXyvXVg8mTV87MasqrxVwWqtrwUmO/azm7ZIdtrrwcxRcYpnjq9nBPbqhYtnD4r6
	OVbr7FGwvONdPPvy/iXHuu8855m96jnHHsmNwtpRm1QLkyWjIV0yzYzdptLLNwqUe1pxxi9H
	nzIbfVacRiEiJdG00JaH/vGgs22IORJBmwuLuSDzZCr1entxkMeQydR880IgV4mYlPJUPu8S
	gsVoEkdbbLl8kNUkhp58/QMHRxpSg+iX5mzF32IUbb7wbsiKSST1/u4M5GKAJ9Krv8VgHEJm
	U79sGZqPJZNoffV9RdBDiUuknb/a8d9LJ9C7Ni9XgIh1mNY6TGv9r5URrkAaQ2p6is5gjI7S
	Z6YaMqK2705xoMDLlB0e2OxEX58muBERkTZU7ZyfpNcodelpmSluREWsHaN2L0nUa9TJusws
	ybR7q2m/UUpzo4kipx2vnuM/kKwhO3X7pF2StEcy/WsVYkhYNpoXe6tp5JbwS0kxW9lj38Uc
	GtdjKorfuxZZpkXPXXTQXphQRuT4mN6EgtEL9Sm5XcfDcwguqs0fG7qtLZEbWLphg3FCXP7B
	CNP0LMcO667W+NuR9Z4VVS0jDoWVf1q+YFlHiy9mzXpzA8n/fsyWdaRlSuj1les+16+r2+La
	uOrbiQNaLk2vmx2JTWm6Pzh/9t8uAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUiTcRzH/T/Ps+d5XC2eptWDhS9WdqwyBasfJTHC8qkw7UWHIeWwpza8
	YsulgbRyYIdnCuVUnJhHs1pMmSvs2iwdIoVizMwjOzAQ75bO1LYi6t2H7/XqS+PieSKAVqZc
	4FUp8iQJKSSEh3dnbV23GKsIqc+XQpnpPgn1M+lQO2gVQJnRgmB6tpeCqZZWEqoqXTiUvdER
	8N3kxuHL6yEK6s1RMFDzlYDm7CYchvLbSMjVzeHwdHaUgqvWOgzs5Q4BvLXkCaDYXY1Dk3aQ
	gq4nZST0318UwFdbLgEO/T0CBvJk8NqwElztIwhaTE0YuHLKSSjqNJDwSTeAoNM+REDplTwE
	pmdOAczNeDZKX/VTsiDOPjKGc433ejDusb6P4gzmNK6hTsrdcHbinNl4neTMk7co7sO7ZpJr
	uzNHcI+tUxiXmzVKchNf3hPc2LNukqsaHsc4U2M3ESM+KQw/wycpNbxq2554ocLwqEBwvgdP
	nze7BVo0jt1AvjTLhLGL1l7kZYIJYh2FpYSXSWYD63TO4l72Z9axuoYSjy6kcaaSZA23mymv
	4cfsYzvqckgvi5id7LW+H7g3JGaaEDvh0GJ/jOWso+Tz71WckbLOhW8enfbwarZ2gfbKvkwo
	6zLk/Y6vYNayLyytWAES6f9r6/9r6/+1DQg3In9liiZZrkzaHqxOVGSkKNODE1KTzchziprM
	n4VWNN0VaUMMjSRLRdZdsQqxQK5RZyTbEEvjEn+Rbe8xhVh0Rp5xiVelnlalJfFqG1pNE5JV
	ooPH+Xgxc05+gU/k+fO86q+L0b4BWhRx5OPkp2jtIeMBi+/+9lVxVzqMJRVhTyxdZv1dn3G9
	z4jmVHBmVtFw7OajURePzkfHuOtQj/jOZEXlFk1qYODLsU1+J4obJt6WRyYsy344ZM+/XC2y
	Pw2fPxtScGSi27WEehAf0b1xx1nDc+vgZpn7ZkS7X1p9x5r1p+NkunNLS1ZICLVCHirFVWr5
	LyI+d5oQAwAA
X-CFilter-Loop: Reflected

On Mon, Jun 23, 2025 at 05:17:06PM -0700, Jakub Kicinski wrote:
> On Mon, 23 Jun 2025 13:32:07 +0900 Byungchul Park wrote:
> > In the meantime, libeth started to use __netmem_get_pp() again :(
> >
> > Discard this patch please.  Do I have to resend this series with this
> > excluded?
> 
> You'll need to repost, unfortunately. If there's a build failure
> the CI doesn't execute any functional testing nodes.

I will.  Thanks.

	Byungchul
> --
> pw-bot: cr

