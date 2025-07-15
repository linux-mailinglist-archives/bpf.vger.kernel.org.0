Return-Path: <bpf+bounces-63284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B54B04D90
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 03:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346347ABADA
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 01:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D97E2C08CE;
	Tue, 15 Jul 2025 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtetpuWC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79A2BEFEF;
	Tue, 15 Jul 2025 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752544065; cv=none; b=F3OcI5C9IpxJPyQ6k+IitaFoDMxxpsB2/5Sq8XU1u/zYg6fbACpQRaMt0m/vWbKtO4KCWBwEad/TTBk5i7zy59hD5ZUMJRr5ucm6lS0b+KkyWOvNd+4YY/tx6JNWK7JTlpyg4dQ6Kphwmnmih2wjpIBkI3Lk5XzjByVIJSmTrHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752544065; c=relaxed/simple;
	bh=lFcq4wxGSvsVKN4bYe8ysyML0S4XmhUy9tpWtp9XPeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4USkdcU3vxh3NAzLLm3cD9gEKS+qr0q4DF43c81Q2ulvvQ9fmaBdm7e96E18Kp8U7cN+sJp3Ef9ZeLWv/8ZuJBrbmTIZNz0+5YIALaV3k7u9JSbQ5srB8poRPdLFWJmeOaYUZjAEzTGR5NyQ/b2sX0ZMi4n+bLfi9SE1vu8Dks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtetpuWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D36DC4CEED;
	Tue, 15 Jul 2025 01:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752544065;
	bh=lFcq4wxGSvsVKN4bYe8ysyML0S4XmhUy9tpWtp9XPeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MtetpuWCASEnnObzSkOaxLtEAqc4VJzz07xLYongI+ZgJ/xbYKu3n0Qlqi2A2nCeb
	 DMUGqf8WLg+txwHuOtARf8vYZjhrrE16BjWDoAA1ZwEs0nVcmlOmf/0BDKcCnoPCyK
	 BSz4iN4fIsvAMPWkg5XKUvVcY0lmLJg14s2Md41RmFJswdH7jaDfGNGseqQ8wnJTwy
	 tU2jolZzc1yP0hF+q8rhsh32bUaG11On/r7d2W/SxmAws/Oh8S6YTl5HdVvT16pfuU
	 gueXwAPvxcUpoWxsyBGoX3OwaEuVHZmVTuXd6TRgZvxjWJrP/SA1fJuKCNsHfNe3uF
	 mVMGCUIDmY73A==
Date: Mon, 14 Jul 2025 18:47:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Byungchul Park <byungchul@sk.com>,
 willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, almasrymina@google.com,
 ilias.apalodimas@linaro.org, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Subject: Re: [PATCH net-next v7 1/7] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250714184743.4acd7ead@kernel.org>
In-Reply-To: <aHUMwHft71cB8PFY@hyeyoo>
References: <20250625043350.7939-1-byungchul@sk.com>
	<20250625043350.7939-2-byungchul@sk.com>
	<20250626174904.4a6125c9@kernel.org>
	<20250627035405.GA4276@system.software.com>
	<20250627173730.15b25a8c@kernel.org>
	<aGHNmKRng9H6kTqz@hyeyoo>
	<20250701164508.0738f00f@kernel.org>
	<aHTQrso2Klvcwasf@hyeyoo>
	<92073822-ab60-40ca-9ff5-a41119c0ad3d@suse.cz>
	<aHUMwHft71cB8PFY@hyeyoo>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 22:58:31 +0900 Harry Yoo wrote:
> > > Could you please share your thoughts on why it's hard to judge them and
> > > what's missing from the series, such as in the comments, changelog, or
> > > the cover letter?  

My main concern (as shared on earlier revisions) is the type hierarchy
exposed to the drivers. Converting things back and forth or blindly
downcasting to netmem and upcasting back to the CPU-readable type is
no good.

