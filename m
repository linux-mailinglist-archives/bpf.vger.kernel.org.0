Return-Path: <bpf+bounces-61710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC6FAEABF3
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 02:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF4A16ECD4
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 00:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC2312DDA1;
	Fri, 27 Jun 2025 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhD6dYEI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5B45C14;
	Fri, 27 Jun 2025 00:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750985347; cv=none; b=d3gwNWcGKI5XccS6QpJtH6Xw+LfrlCmbpi3UI38yT5PWOP+GDk5KEMnFkCyE2t26AtmQunsoevcn1oDcln3E7MBwGIN0wPDJEO7ioKMYs3OrVtaJRgouBZoFnJiA7leryANGivYGLxwMWbW3FDyIQVVD1ZAhvpJjwF/tTYHIoW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750985347; c=relaxed/simple;
	bh=EpqjtPVGt04E7RcuSotMKejW6u3yq2ucjguads+7u2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLsYnD9UNPoKMcXiNt7GqQAb0Ia8sg0tMlk1LIJ1/cC5+vs+aHfROJ3Jw5zH49xHOnI+fg7nd+qc0Zjz8ogvVEZbQgGskjDZfZbxJS+O+gktSW7BAuodrncKy1cVdnB8at1zzI+mKdRPsJa8Gwcg35ebbuJzJkOTWYHiaMiFPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhD6dYEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90785C4CEEB;
	Fri, 27 Jun 2025 00:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750985347;
	bh=EpqjtPVGt04E7RcuSotMKejW6u3yq2ucjguads+7u2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JhD6dYEItqr1kEqwbDypImWuwC6DkC//2HpSf/hgwxLYbnhR8EuQdDrRcs9QYZXpL
	 NCOk1Ui6TH1oeylieGVA0AaZpYjG06vWKOUgNQYb5uPEjlAhA4GaIVVVh5MvTCgWbS
	 PmG7wnTnV/4the3QfpV471XKmIZ33YZPjwtHfKr0QMean7TulHtheSS+nwRf/gMP0g
	 VF0THNST7vk0sxscSP/ClnJp5iBAwWIGfVjP/PV/8anoSyJdkah3YyVbeuERLiNIRJ
	 M1452yPuJMakT9SvZoHdVGPZV37wH7NBQp6QlZYsNsJ44lwYi+mpihmoggrA0c7Uie
	 N+XC/kOPDkhFA==
Date: Thu, 26 Jun 2025 17:49:04 -0700
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
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com
Subject: Re: [PATCH net-next v7 1/7] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250626174904.4a6125c9@kernel.org>
In-Reply-To: <20250625043350.7939-2-byungchul@sk.com>
References: <20250625043350.7939-1-byungchul@sk.com>
	<20250625043350.7939-2-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 13:33:44 +0900 Byungchul Park wrote:
> +/* A memory descriptor representing abstract networking I/O vectors,
> + * generally for non-pages memory that doesn't have its corresponding
> + * struct page and needs to be explicitly allocated through slab.

I still don't get what your final object set is going to be.

We have 
 - CPU-readable buffers (struct page)
 - un-readable buffers (struct net_iov)
 - abstract reference which can be a pointer to either of the
   above two (bitwise netmem_ref)

You say you want to evacuate page pool state from struct page
so I'd expect you to add a type which can always be fed into
some form of $type_to_virt(). A type which can always be cast
to net_iov, but not vice versa. So why are you putting things
inside net_iov, not outside.

> + * net_iovs are allocated and used by networking code, and the size of
> + * the chunk is PAGE_SIZE.

FWIW not for long. Patches to make the size of net_iov configurable 
are in progress.

