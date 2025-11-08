Return-Path: <bpf+bounces-73991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8A3C4240A
	for <lists+bpf@lfdr.de>; Sat, 08 Nov 2025 02:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD58188D0B7
	for <lists+bpf@lfdr.de>; Sat,  8 Nov 2025 01:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D2029BD95;
	Sat,  8 Nov 2025 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4EA2HN1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3734D382;
	Sat,  8 Nov 2025 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762566092; cv=none; b=In6h+OaaSPuJWJV19fE+fZVYDO7xXXn+PouWwF0r+tcu0JK23Fg81sLjoBobgZ+O5viZPZkWiTKCIVT/ByOg4Q4SnYx7h6/UnE4Q6hXlGhaz2S7TEPj4izTwJcLawKbv+AELOVYoUhtc2wpzpnZ6JCxiya/I/bLNbQb1RQVtY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762566092; c=relaxed/simple;
	bh=bZZGPo2E0msSloBOkeFeACpuzgCC3k9FCP1TtsatxaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpMny9JIwi9mB21/lSlLSVqDUiM1J4g/95dCR11aKuhwrCt4lO/f3ovTEDbNg3zIxXFJDKXRELOWjhvnO600hOJgaCU6fI7cgT8Bn2shwD0xKZ2vdnG7CGlH7T3d6yTz3KKj2TAlA6wfFjxSaOXlZLyjcX3u/+RibP4QPbRfQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4EA2HN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EEBC113D0;
	Sat,  8 Nov 2025 01:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762566092;
	bh=bZZGPo2E0msSloBOkeFeACpuzgCC3k9FCP1TtsatxaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I4EA2HN1xggEwDDY+EXXjeuTilUUVALnglQLg5zXBbhd1yvhPoCdwFWeQubJDPAfD
	 y3NuOuh15eivOqBrC5NW9R/erOX2PrG5kdAphHgZAJKLP+tlz7mdlRksYtvMzMJu2X
	 MgvuHswuuxhuknZuovUsvwbX1K0ZS1iaIdOTGnknf0YLeig+4uroSN5muMwksb5JF2
	 A2f094CKNKnI0a1QHYkgu0hGk7MzhAhRLaFd/TYCSkMsvVcUy7kFVeqROi1LFqezJl
	 M+ZgXQoAm7PEINoyJGzndzB3iHFArwOaWzWRQE/94FXzdWhJ3zwanQ1y/k1CeEVzeu
	 Cc9MjX6Hk5dww==
Date: Fri, 7 Nov 2025 17:41:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
 dtatulea@nvidia.com
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
Message-ID: <20251107174129.62a3f39c@kernel.org>
In-Reply-To: <20251107044708.GA54407@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
	<20251103075108.26437-2-byungchul@sk.com>
	<20251106173320.2f8e683a@kernel.org>
	<20251107015902.GA3021@system.software.com>
	<20251106180810.6b06f71a@kernel.org>
	<20251107044708.GA54407@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 13:47:08 +0900 Byungchul Park wrote:
> The offset of page_type in struct page cannot be used in struct net_iov
> for the same purpose, since the offset in struct net_iov is for storing
> (struct net_iov_area *)owner.

owner does not have to be at a fixed offset. Can we not move owner 
to _pp_mapping_pad ? Or reorder it with type, enum net_iov_type 
only has 2 values we can smoosh it with page_type easily.

> Yeah, you can tell 'why don't we add the field, page_type, to struct
> net_iov (or struct netmem_desc)' so as to be like:
> 
>   struct net_iov {
> 	union {
> 		struct netmem_desc desc;
> 		struct
> 		{
> 			unsigned long _flags;
> 			unsigned long pp_magic;
> 			struct page_pool *pp;
> 			unsigned long _pp_mapping_pad;
> 			unsigned long dma_addr;
> 			atomic_long_t pp_ref_count;
> +			unsigned int page_type; // add this field newly
> 		};
> 	};
> 	struct net_iov_area *owner; // the same offet of page_type
> 	enum net_iov_type type;
>   };
> 
> I think we can make it anyway but it makes less sense to add page_type
> to struct net_iov, only for PGTY_netpp.
> 
> It'd be better to use netmem_desc->pp for that purpose, IMO.

