Return-Path: <bpf+bounces-73995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB71C424FA
	for <lists+bpf@lfdr.de>; Sat, 08 Nov 2025 03:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500023AE711
	for <lists+bpf@lfdr.de>; Sat,  8 Nov 2025 02:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362F82BEFE4;
	Sat,  8 Nov 2025 02:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1eDVBuy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AC28507B;
	Sat,  8 Nov 2025 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569435; cv=none; b=qpmS0flzEsJqquTpYozqwHFLCZxIcv4b5VKl7adu2eHLJJml9nQHGLjyxp3kUv9/kLE7FEt4xxaqywybyb7M1mnzs20uwv+lPqb243tjv7qmKfNYtdErxcQ1c7icFKku+b/EnNjkenc/UVPingKCAQb4E4sJDiAC6WFL2l055Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569435; c=relaxed/simple;
	bh=Ou3u7Vf6165AwGz1NI7XrAGwfnZWVMEdqoH1Q7dBYYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqWJrqHeFSKRg5Yri/c5atqp+OF9UBbyryTzwyQh2GTPaFQnzUAG3MhXGjeeJJrb1i0sv67N/5OWKrLtNsISMZUvW0d4Strtb+olz8UHJGqmv289FhkL1+ZYtdu2NdB6aWsbyt6r/HMT/zZYtyWDplTn/vpsZrvuYsnD4y+3A2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1eDVBuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07224C19422;
	Sat,  8 Nov 2025 02:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762569435;
	bh=Ou3u7Vf6165AwGz1NI7XrAGwfnZWVMEdqoH1Q7dBYYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u1eDVBuyluzoT6wpUlZ1bNsISDdrnxrud/MWHNRrWneUQUSr0tLuPmnvHaGQ4xM4N
	 //QJVSvXi9HicgXpdx9lhmTzGfyQd1bxAmnkwgqJd4+HcNQjvlaqLETmjHzDwMocZG
	 8VBtwlLx06pOqPlDEr20kSSpYKH6ZdUF4BnNlcvHfDy2+SaerJT4o0RKUNtzkA3de2
	 RDvboLOVpWoce0ylhnS/eztY27WUcAML5hVi3DM2XGkcgXhW2UE1gkvicQXHNY4GoN
	 dXUHNw5MJNUrRv6j79+MScwp6ZAzr0iGyf4P1L4ym85uTBntzQGq+IZTRkJHrnBc40
	 AZ06qf8B8xzzA==
Date: Fri, 7 Nov 2025 18:37:12 -0800
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
Message-ID: <20251107183712.36228f2a@kernel.org>
In-Reply-To: <20251108022458.GA65163@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
	<20251103075108.26437-2-byungchul@sk.com>
	<20251106173320.2f8e683a@kernel.org>
	<20251107015902.GA3021@system.software.com>
	<20251106180810.6b06f71a@kernel.org>
	<20251107044708.GA54407@system.software.com>
	<20251107174129.62a3f39c@kernel.org>
	<20251108022458.GA65163@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Nov 2025 11:24:58 +0900 Byungchul Park wrote:
> On Fri, Nov 07, 2025 at 05:41:29PM -0800, Jakub Kicinski wrote:
> > On Fri, 7 Nov 2025 13:47:08 +0900 Byungchul Park wrote:  
> > > The offset of page_type in struct page cannot be used in struct net_iov
> > > for the same purpose, since the offset in struct net_iov is for storing
> > > (struct net_iov_area *)owner.  
> > 
> > owner does not have to be at a fixed offset. Can we not move owner
> > to _pp_mapping_pad ? Or reorder it with type, enum net_iov_type
> > only has 2 values we can smoosh it with page_type easily.  
> 
> I'm still confused.  I think you probably understand what this work is
> for.  (I've explained several times with related links.)  Or am I
> missing something from your questions?
> 
> I've answered your question directly since you asked, but the point is
> that, struct net_iov will no longer overlay on struct page.
> 
> Instead, struct netmem_desc will be responsible for keeping the pp
> fields while struct page will lay down the resonsibility, once the pp
> fields will be removed from struct page like:

I understand the end goal. I don't understand why patch 1 is a step 
in that direction, and you seem incapable of explaining it. So please
either follow my suggestion on how to proceed with patch 2 without
patch 1 in current form. Or come back when have the full conversion
ready.

