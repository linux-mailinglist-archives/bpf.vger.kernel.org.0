Return-Path: <bpf+bounces-64765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE71B16BEC
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 08:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1191AA5F8E
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 06:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4E5243374;
	Thu, 31 Jul 2025 06:13:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600C22C9A;
	Thu, 31 Jul 2025 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753942425; cv=none; b=jnwEG1Eshr2yXDKgkUrTeYhoQYE4kwo4J2Z999YAl6sIkDdIQLSNPpctSkHnQq5seTtNH/YvLWe5HTJEzbYvpaI1Qol83V6OG1uborCjTa5TAXWhZNpqVe+N7uBW2ovKl7Wjsa7CvsTRLhCAW+LzlHu+AriAXO79gOQxhVCOtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753942425; c=relaxed/simple;
	bh=IsjWducqh9E8FGAln5tPMk1H3bRnG9Ny//2neVCPm48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0fldj77Qpi5uaH4NyzKqfMCGdLuZZ438QUqtdY7+18q6bokTIgdjofFQ7YVGSYABKUhARB1tByC3pi5LTC5A1l5f8V3cfcf76oHo6PzxJ8EYAPbiJHXfPjAwohEwrlkcdC+4E7E0SjLGOsrOgfe0N2XP7HK1NRym7KmjTCS2o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-2a-688b0989ff45
Date: Thu, 31 Jul 2025 15:13:23 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page
 pool in page type
Message-ID: <20250731061323.GA10743@system.software.com>
References: <20250728052742.81294-1-byungchul@sk.com>
 <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
 <20250729011941.GA74655@system.software.com>
 <18eb9e6c-1d60-4db1-81e1-6bce22425afe@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18eb9e6c-1d60-4db1-81e1-6bce22425afe@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0yTZxjH837nVqrvKpuveGFWM0lK5oGY5dlwmxe7eBNjmDFysWXRTr7R
	xlJYCwwMxOq6KB2nFE+UqkU3QcCUFAeFQdUWOTmDgcC6jYEyMRAVtoJMDtHxacy8++X5/59f
	notHYrVX+TjJZMmSrRaDWSeoOfXjmAvvFqq+N25x+DF4fPUC1D3Nheq7AR48tU0IZuf/EOF5
	eyeCmY4uAR6GowguVs2x4OlzcPDEt8DCeOeYCHX+XTB66QEHbceaWRgr7Rag2LHIQvv8lAhH
	AzUMeBrtItxpKuHhxMKPLDTb74ow0OoRYKT+OQ8PQsUc9Lgvc/D3yQ4WRkt2QKf3LZi79QhB
	h6+ZgbmiswIMVrQyUN7vFeAvxyiC/vAYByeXjgtQeaQEweLTZdtU2SwPlTdHxB16Gn40zdKr
	l39jaCTYy9AW958i9fqzaWONnjoj/Sz11xYK1B91iXR4qE2g3WcWOdpy733aEphhaPG3UwL9
	Z/x3jk4HB4VPV3+m3p4qm005snXzR/vVxp/8azMjYu53E7/wdrTEO5EkEbyNnO5JeYUTt95z
	IpXE4XeIa+I0r7CA40kkMs8qHIsTyMNfQ6ITqSUWnxLJMV+boOyuxl+QhmtJSkeDgTQUF/FK
	R4t7EbnWMCi+DN4gPRX3OYVZrCeRZ5OMssvidaT6maSMVfhDMl5XJCj8Jt5Arjd1MYqH4IhE
	zo1WvTiI4LXkRk2EK0PY/ZrW/ZrW/b/Wi9hapDVZctINJvO2TcY8iyl304GMdD9a/qVLBUuf
	B1D0zp4QwhLSxWgodhq1vCHHlpceQkRidbEacC+PNKmGvEOyNWOfNdss20JoncTp1mgS575J
	1eI0Q5Z8UJYzZeurlJFUcXZ0MaX5gyMxQd51fGB3eep4SnJpNL/PKUZV0Y2anN3Vw+G8yZ+d
	K+7VfvmVK/zv4fvds5XB/A51WX3y+fYER8D1g7c1qTxkwwdWraQNzknzbbvv5hDZGZd/pcJt
	yrpdWj9L98boDyY+4ZO//uTjxKHMxuy+zIFD6+Njo2+nZRRcj9dxNqNhq5612gz/AeksZTpH
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUiTcRjH+b23o8Gbab0q/TM7wHBZWjxhF0T0I1gHdlFkrnxpyys2NS0C
	Syubtx3m3MKMUmegrTzRkmneHWjWOq2VYXh0aObUNF8i6r8P3+/38/z1cKRrDu3JaSOjRV2k
	OlzByCjZlsBE32SXFI2fYzwQTKW3GCgZi4PCd1U0mCwVCEacr1iYrmtCMNzYzEB/w3cE16+N
	kmB6nETBj9JxEnqbHCyUWFXQc/MTBbXnKklwZLQwkJY0QUKdc4iF01VFBJjuJLDQYG6l4UlF
	Og0Xx2+QUJnwjoWuGhMDb29N0/DJlkZBq7GYgq+XGknoSV8PTflzYbR9AEFjaSUBo6lmBrpz
	awi40JnPwIekHgSdDQ4KLk0mM5B3Kh3BxNjMtaHMERryHrxl1y/BDQNfSHy3+AWB7ffaCFxt
	fMPifGsMvlPkgw32ThJbLecZbP2ezeLXz2oZ3HJlgsLV71fh6qphAqclDjH4W+9LCn+5181s
	c9srWx0qhmtjRd3StSEyTbnV46idjTvT10EnoEnagDhO4AOEvvaVBuTCUfxCIbsvh5aY4RcL
	druTlNiNXyL0P7exBiTjSP4yK5wrrWUkdw6/Xyi7Hyht5DwIZWmptLRx5duQcL+sm/1TzBZa
	cz9SEpO8j2Cf+kxILsl7CYVTnBS78GuE3pJURmJ33luor2gmMpHc+J9t/M82/rPzEWlBbtrI
	2Ai1NnyFUh+miY/UxikPRUVY0cy73Dw5mVWFRro22RDPIcUsOeYNGldaHauPj7AhgSMVbnIw
	zkTyUHX8cVEXdUAXEy7qbciLoxTz5Jt3iyGu/GF1tBgmikdF3d+W4Fw8E9CVoIAxcYgfWKf8
	tStDeSwmRRVszv6pmk/sMJ8I3jBY7t9Chck6zvqy/nv81pyFAlwUeJveWaby7HTmpHxs/2qx
	7AzOemTeajg4XOAe6u0c72OVKo9frYtSErUFI/X9V+fXROQNTrdRT595J+u3Jxc+XF7Pma37
	dgcdeX9hwUZ3BaXXqJf5kDq9+jeGdsXvKgMAAA==
X-CFilter-Loop: Reflected

On Tue, Jul 29, 2025 at 10:22:30AM +0100, Pavel Begunkov wrote:
> On 7/29/25 02:19, Byungchul Park wrote:
> > On Mon, Jul 28, 2025 at 07:36:54PM +0100, Pavel Begunkov wrote:
> > > On 7/28/25 06:27, Byungchul Park wrote:
> > > > Changes from v1:
> > > >        1. Rebase on linux-next.
> > > 
> > > net-next is closed, looks like until August 11.
> > 
> > Worth noting, this is based on linux-next, not net-next :-)
> 
> It doesn't matter, you're still sending it to be merged into
> the net tree. Please read

I've never worked aiming at linux-next, so I was wondering if there's
a process for that.  I've been searching for the process if any, but
nothing special was found.

I still have no idea how to deal with this case.  However, at least, I'd
better send the patch once net-next is open.  I will.

	Byungchul

> https://docs.kernel.org/process/maintainer-netdev.html
> 
> Especially the "git-trees-and-patch-flow" section.
> 
> --
> Pavel Begunkov

