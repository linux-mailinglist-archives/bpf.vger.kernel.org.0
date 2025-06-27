Return-Path: <bpf+bounces-61712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D86AEAC00
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 02:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041483BE61E
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB382BAF9;
	Fri, 27 Jun 2025 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsa1MWQx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2012E5D;
	Fri, 27 Jun 2025 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750985443; cv=none; b=Mu9IePAuYrhN9dztfyVQzGKCRXEITlB0kpVDKXfHNQiyTIyb7HRlqZr/U17EypsN/zNmrD2FCdwP3bEWOq6pVA5eEg6DSX1us0sh7HgLGndGqCQlpoTs4P56J3AciFj3JSxdTfTANvzV/9PmVcYeR1u6AU49JY6pHKrEiWzeyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750985443; c=relaxed/simple;
	bh=SCTbdzkuj2fHsB3J8DC5cHHKjk2G20HmWFOE3rkHuRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fd+op+Wx6xHw8voJCt/hsKFA9kdneRH6RRQQl1hDp8T0oHWMni5vQdsiYNiPwnbxXQCIEtDhehA1aHX9zH64O2lafZ3psYJAB1CD1i+OeyZ8pPJZ0jh+Bn1dHYwubxeLhcCyzJZYwlrfSpeIGyQv6U9fGKGg+fWIGnFMfqIDmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsa1MWQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F90C4CEEB;
	Fri, 27 Jun 2025 00:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750985442;
	bh=SCTbdzkuj2fHsB3J8DC5cHHKjk2G20HmWFOE3rkHuRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vsa1MWQxqKAyxE2vASroJIq67pMWozebzG0n3jyy7Wy9e8G+sC8WDhykBzALiwfTQ
	 SauODA78m48pxnXG1yiAPX5CabsFy4xc3SMqX+Qu9MRDGs3+Xh/5dHWIWnnUPf370e
	 /xXS36tXayiS2gahkIw93Fr+wJLEEzx6rEDJrXdF+TLXFQniSnzRC9RH5SnHfgZIL5
	 jRxx4SXX3gHP/P62/ykgd6YIM/ecL9ahZHz1BUP9FXpzIhKulUuqsjI7WGn3Ijjr2I
	 GFAOxRxmU586XTdx6G/oI5utSIisvPley4D+CzYvD2EzvBKqZ2zvXa6aQYTvp128ls
	 qv5ZR0ncW9u9w==
Date: Thu, 26 Jun 2025 17:50:40 -0700
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
Subject: Re: [PATCH net-next v7 0/7] Split netmem from struct page
Message-ID: <20250626175040.585ce57e@kernel.org>
In-Reply-To: <20250626064119.GB28653@system.software.com>
References: <20250625043350.7939-1-byungchul@sk.com>
	<20250626064119.GB28653@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 15:41:19 +0900 Byungchul Park wrote:
> To Jakub and net folks,
> 
> I believe v7 doesn't include any controversial patches.  It'd be
> appreciated to lemme know if any.

I'm still a bit lost. But indeed patches 2-6 look fine.
If you were to repost those 5 they'll go right in.

