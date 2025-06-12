Return-Path: <bpf+bounces-60428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB3DAD654C
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206241BC2718
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 01:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035D1991C9;
	Thu, 12 Jun 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr4N25lZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6752A1C9;
	Thu, 12 Jun 2025 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749693345; cv=none; b=kgOKQK1zJ2zJd9E5942NYfOYRfqKi4CNq+/63Abe4U68LTxTLzmufsnVXgVywBvHZVn32B7VLTCVCCKyM/wWLpZLufOFwQn62VXFxg3cP4v2LLpzFjCOaWFtQggORDUPUFO9w8pys58Xj5rZYhapFQvWe5C870pQrVcRNHC1s9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749693345; c=relaxed/simple;
	bh=/Z9gnkbErpmzSSGG757Uw928GIcAdBgrdkNeI0TZYYE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5BblGH6e08/bjHkdexl6rHbYSZZ6rC4jpEbTPS7znfeWPi644ah2vzu8QH3goJob1ESd3X5qwLfdrU1YjiXxHywE8k4jdghRe/xHkKFS4zWpyara0OnaflHMxt07lzgTOEjOfJGY87eTIWDWDiFEB3qqW5CBiv17gKNlF2rRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr4N25lZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CB6C4CEE3;
	Thu, 12 Jun 2025 01:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749693344;
	bh=/Z9gnkbErpmzSSGG757Uw928GIcAdBgrdkNeI0TZYYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hr4N25lZ/oEeSGftkotNZkm8IvShXojbQQmt4vAiXiQ6w28OzyeM6PqUEl+TOvoEx
	 PqyNWIQXe0nf1UeMJwUbf9+HKHR1+Km1mhH7/QYsModYvu+ECP1UIz53D8NbYgkjNE
	 7gWA5xhFlHJWPHcPTYgmpJCObUcrOag0oOexDt2l9p3RHa5f1pElBJ9NJ48TdSjaIb
	 mFRaFWelGov5E1gRsshY6RdQ/31ecBkrueieMBNJqS/Mh8mVsyhh9xHxBJ8Y2KXElK
	 ANIHzv8NUJKt0zao7kX0RYWqkgjnsJtZGqR4uOZhJEs4GCdRfqKqJ8bijflblv1kvp
	 GNkiV+itjUEkw==
Date: Wed, 11 Jun 2025 18:55:42 -0700
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
Message-ID: <20250611185542.118230c1@kernel.org>
In-Reply-To: <20250610013001.GA65598@system.software.com>
References: <20250609043225.77229-1-byungchul@sk.com>
	<20250609043225.77229-2-byungchul@sk.com>
	<20250609123255.18f14000@kernel.org>
	<20250610013001.GA65598@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 10:30:01 +0900 Byungchul Park wrote:
> > What's the intended relation between the types?  
> 
> One thing I'm trying to achieve is to remove pp fields from struct page,
> and make network code use struct netmem_desc { pp fields; } instead of
> sturc page for that purpose.
> 
> The reason why I union'ed it with the existing pp fields in struct
> net_iov *temporarily* for now is, to fade out the existing pp fields
> from struct net_iov so as to make the final form like:

I see, I may have mixed up the complaints there. I thought the effort
was also about removing the need for the ref count. And Rx is
relatively light on use of ref counting. 

> > netmem_ref exists to clearly indicate that memory may not be readable.
> > Majority of memory we expect to allocate from page pool must be
> > kernel-readable. What's the plan for reading the "single pointer"
> > memory within the kernel?
> > 
> > I think you're approaching this problem from the easiest and least  
> 
> No, I've never looked for the easiest way.  My bad if there are a better
> way to achieve it.  What would you recommend?

Sorry, I don't mean that the approach you took is the easiest way out.
I meant that between Rx and Tx handling Rx is the easier part because 
we already have the suitable abstraction. It's true that we use more
fields in page struct on Rx, but I thought Tx is also more urgent
as there are open reports for networking taking references on slab
pages.

In any case, please make sure you maintain clear separation between
readable and unreadable memory in the code you produce.

