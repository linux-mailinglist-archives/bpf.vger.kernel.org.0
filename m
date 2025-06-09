Return-Path: <bpf+bounces-60085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90240AD26C8
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CFAD7A9447
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 19:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47C821FF23;
	Mon,  9 Jun 2025 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuNIprlM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8BA20C480;
	Mon,  9 Jun 2025 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497578; cv=none; b=pfuP3iXm3AL4fkAHNGvkWe2QYRdJy6xPUtDQealw3EhSiQEBxBnSzWLrRbUAIDa5GwezNxw5Z6G46fSxhAxY2IwnD2X7gZHn01M89Oi4Z1cTMWKvntcI+opQqL7J+ZGOAY/viwxVYWCLLQFXuta/1O5t1ITtRjGqiAoy0w616Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497578; c=relaxed/simple;
	bh=HcZIjrW0jm/JSJd6+mO+/i0r77unJFHWKpYgNW70c7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bhb4EaUDlaEDHBvSl/K2zJAWRnJQcGGzyKpIJS4AE1hS7pnneMALf6iSRcx1Yi3kSv18FotwGoZXNVZw1LGp/FooIu9HcARSaIoYwlQAB7iTF4kKtj/jvNvbLKJ4yY1WZPJ+OrtZYl9/lKWw1B0DJooePpCQ6ZmZ9b98HLzO/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuNIprlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFD2C4CEEB;
	Mon,  9 Jun 2025 19:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749497577;
	bh=HcZIjrW0jm/JSJd6+mO+/i0r77unJFHWKpYgNW70c7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RuNIprlM/03pt2+kYdMFiMNcIZSFuPeIyIPGB7plON7IfYmTJRVJihkaLTtq3yJKL
	 9pmGhnKOP19kgIq5HWf36qw9Lh1E/QuJMPzzvh/o4JtNLxbLy/G6ljHu353ZFtJQhy
	 erbCFN2FgZpwoB18x/oAKYO7eVeQW67nOfNXNaxYU0chKv8fflMyLx4ubKbDejXdkm
	 ZM1aYGrS2xKvFhhGNejpdXRAJtd999N9o13wWSvuMWm83rKhjWLJNR7F8NhwOxyYVV
	 jkBp9POInlPrEo0gIfo+v4Q0pbEVYuQYGvVLgDp1l6ES5F82adY4GpeuTE3K4IIYki
	 PzOOSB8NqOwuQ==
Date: Mon, 9 Jun 2025 12:32:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
Subject: Re: [PATCH net-next 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250609123255.18f14000@kernel.org>
In-Reply-To: <20250609043225.77229-2-byungchul@sk.com>
References: <20250609043225.77229-1-byungchul@sk.com>
	<20250609043225.77229-2-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Jun 2025 13:32:17 +0900 Byungchul Park wrote:
> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
> 
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, and make it union'ed with the existing fields in struct
> net_iov, allowing to organize the fields of struct net_iov.

What's the intended relation between the types?

netmem_ref exists to clearly indicate that memory may not be readable.
Majority of memory we expect to allocate from page pool must be
kernel-readable. What's the plan for reading the "single pointer"
memory within the kernel?

I think you're approaching this problem from the easiest and least
relevant direction. Are you coordinating with David Howells?

