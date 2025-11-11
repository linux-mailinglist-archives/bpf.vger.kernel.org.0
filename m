Return-Path: <bpf+bounces-74123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4584CC4B226
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 03:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA62188462E
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 01:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B6301025;
	Tue, 11 Nov 2025 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxmfBm0N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E62D9798;
	Tue, 11 Nov 2025 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826213; cv=none; b=RgRA+bRAkAkAkAvJ6sN+PeWAgv7EYUB0a9Z3MBlVJlgHeNkgC1T8vh8T/RFoDXKtokBQiDC8yGHH3c3JDaVrOI+uJyiTCKhySV+Hgqtc9IiumlH6oKKr1FxpyBIAgGfCa8xL/JxRk6JbxHS2QcXX/vzHcmUSmiUlNCa+OZV2s+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826213; c=relaxed/simple;
	bh=VphCyfEENd4whxy5okj5882S0gPkjzD1ljXyJrlri9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPQc7MyLroXHFQlKjeFEmwCJMgtH0IbgCAebRm29yRJn10hUEBiss/ykpZFtMsCPt3jvcUklh9ZtPgo50sWSixAe9xpejjMveFw28Q3ouwrgjI4H+OICNMsCFCb5+GsOMRCxw4v1+b2aiG4MEiw1it1VB3m77Za3V+7d7wnOp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxmfBm0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144B3C4CEFB;
	Tue, 11 Nov 2025 01:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762826213;
	bh=VphCyfEENd4whxy5okj5882S0gPkjzD1ljXyJrlri9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MxmfBm0Ny+/qaYrVoKT8KL7lULyFehtAg0TdX4XqyEc+9es2IDPHvHCx4C6uCwk0a
	 Ib7IYu4m1w1smWVD7J3nk8quEpNaGhXhbdRwzluMlPTdBcJfe6FXKa4vYOWL0phV2w
	 D+fC70IqzAMfxZU8P2OKQhqWVAc2awoSCKrnZY3Psmdo1u70CTxFWvQdpI4hwfD9uL
	 vkQj0YeeA6ljP8cUrT744/MzSdSaqx23yaHxXyxbtdbAoBE/Dikmys1367mPyLQPBo
	 Thrkszyvq6fFt0zf2+ImdIgb6iVrGUgaq9JxTpRebsfYHNHQY4FVQImA3SyXlaX1HD
	 N0skyOf3a0Hrw==
Date: Mon, 10 Nov 2025 17:56:50 -0800
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
Message-ID: <20251110175650.78902c74@kernel.org>
In-Reply-To: <20251111014052.GA51630@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
	<20251103075108.26437-2-byungchul@sk.com>
	<20251106173320.2f8e683a@kernel.org>
	<20251107015902.GA3021@system.software.com>
	<20251106180810.6b06f71a@kernel.org>
	<20251107044708.GA54407@system.software.com>
	<20251107174129.62a3f39c@kernel.org>
	<20251108022458.GA65163@system.software.com>
	<20251107183712.36228f2a@kernel.org>
	<20251110010926.GA70011@system.software.com>
	<20251111014052.GA51630@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 10:40:52 +0900 Byungchul Park wrote:
> > > I understand the end goal. I don't understand why patch 1 is a step
> > > in that direction, and you seem incapable of explaining it. So please
> > > either follow my suggestion on how to proceed with patch 2 without  
> > 
> > struct page and struct netmem_desc should keep difference information.
> > Even though they are sharing some fields at the moment, it should
> > eventually be decoupled, which I'm working on now.  
> 
> I'm removing the shared space between struct page and struct net_iov so
> as to make struct page look its own way to be shrinked and let struct
> net_iov be independent.
> 
> Introduing a new shared space for page type is non-sense.  Still not
> clear to you?

I've spent enough time reasoning with out and suggesting alternatives.
If you respin this please carry:

Nacked-by: Jakub Kicinski <kuba@kernel.org>

Until I say otherwise.

