Return-Path: <bpf+bounces-65520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A397B24C8A
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22131BC5B01
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2272ED159;
	Wed, 13 Aug 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXSRoY4F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A1DF71;
	Wed, 13 Aug 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096735; cv=none; b=kZMywdWU1sg7YfXuHAH1DeQ2jsQD6+Wgr3MJcettk1vhr0Sl+YDU3yM/50mUWlWkzQsJrrCOG6foLE9k94NMEOWrviIvyz1Bp06faBJi5Ufw38gVq51VKvnZFhtrPzQBOuipKN0vZZLUQXT/dDuTyMp4+nH+NKJDJaESzXSrgkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096735; c=relaxed/simple;
	bh=yF8iCt4IcxBj81Mp1kvQhhC5dKj1tFO3WDbfBuoASjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGnKdr8JCQpA8tRwqqVKdSbZRQdYZB2tEoRgE7e3pVIjjOyaEqSKhHi4smbMl4ISh+cdj7TlYo3m3wePb+I6HxR7sAynUM2/xV8jP6CVU1IPNLP07T6flnomYzy4mnNQEed6/n9dZ0QU0+3jhg4JZmN7EKreyyxprULuteFwwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXSRoY4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4F7C4CEF1;
	Wed, 13 Aug 2025 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096734;
	bh=yF8iCt4IcxBj81Mp1kvQhhC5dKj1tFO3WDbfBuoASjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HXSRoY4FX97/bGSoskS9rX3kbLNHbhMECHrpExOw3SjAhO+sutt0wNIt+hXguYqFz
	 acOrnwIq662t2uH/Pkk+7zDE8qZpdbkHmHHAOfqQwBcKJJyCXYPBsuQso8zFZkC8wc
	 erGdkydwLPI2kjby/RJhn2Ues8nq7SX9WGDBoI3FpERRf1p1vq/7Gg6L9vYkY8r3yv
	 /UTzDE2v+NTni4xTqnaSIoDLmtE+MWUd4MJgORxpfzwpU05jPd/97lVDP2xRhtyicu
	 kd6cGBBqNP8JClWYuCW6Zn6N1Kg15PCa2VQb8UCi/ux4QHe6NCO7XLvlVcwo0EiNp3
	 Pe3CylL1s7ueg==
Date: Wed, 13 Aug 2025 07:52:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, linux-mm@kvack.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH linux-next v3] mm, page_pool: introduce a new page type
 for page pool in page type
Message-ID: <20250813075212.051b5178@kernel.org>
In-Reply-To: <6bbf6ca2-0c46-43b7-82d8-b990f01ae5dd@gmail.com>
References: <20250729110210.48313-1-byungchul@sk.com>
	<20250813060901.GA9086@system.software.com>
	<6bbf6ca2-0c46-43b7-82d8-b990f01ae5dd@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 12:18:56 +0100 Pavel Begunkov wrote:
> It should go to net, there will be enough of conflicts otherwise.
> mm maintainers, do you like it as a shared branch or can it just
> go through the net tree?

Looks like this is 100% in mm, and the work is not urgent at all.
So I'm happy for Andrew to take this, and dependent patches (if any)
can come in the next cycle.

> @@ -1379,9 +1376,11 @@ __always_inline bool free_pages_prepare(struct page *page,
>   		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>   		folio->mapping = NULL;
>   	}
> -	if (unlikely(page_has_type(page)))
> +	if (unlikely(page_has_type(page))) {
> +		WARN_ON_ONCE(PageNet_pp(page));

I guess my ask to add a comment here got ignored?

>   		/* Reset the page_type (which overlays _mapcount) */
>   		page->page_type = UINT_MAX;

