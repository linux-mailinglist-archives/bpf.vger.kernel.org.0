Return-Path: <bpf+bounces-74122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E1C4B06C
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FCB1897E37
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 01:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7C346E46;
	Tue, 11 Nov 2025 01:41:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC92261B8D;
	Tue, 11 Nov 2025 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825275; cv=none; b=Ut9a09+Bp+UVRoeShq0LJnmg2834bEEmhiKMo2Q4bA19DhWIwPiJy77To5qfGtYX3FL5Gtz/BWDBY4RXeHLVVs2wzbD0bG+HrxB1p9Hx7moS7XC8njSkrGly87DiQ4ukKs+7HT4B0jGHpEA5O/COvuf1yIrwJ725JxL+rDFYM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825275; c=relaxed/simple;
	bh=TDgrKCtvuRXiIZq5xR+wrXkse/TzZt+1GBUKp3x1+kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drswW5ZoJwP4E3/HeE7Q+3E0wSthC9H3/1Pliiozt93VJx5nQQWfyMyG4S5RL/nQOSpdDIriAaCOeReEj507rlX3L4MsXeVprcQ+XK4BgbyVQhLrtrCPhOjsS7ETaQbJdPSxp3eJMv5ys3uzqmL4/0KoRxvHIm3g3N5KZto8k+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-a1-691294292662
Date: Tue, 11 Nov 2025 10:40:52 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
Message-ID: <20251111014052.GA51630@system.software.com>
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
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110010926.GA70011@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjHfc97bjR2eTmT7UXjklWdGU7UhSwPxOu3dx9MlswZs5lsdZxI
	I1RyQASNWcUalQzGpsZSOoN3bgbTTmgZEIVahCWzQ8DjVKh4YWPchpVYQZHWLPPbL8/l9/w/
	PDJWOoX5ssWaq2pWc6ZJNPCGkbmnln94TLGsfBRZAa66WhFqnuXDhZBXgEjtIAeu6noE4cgd
	CWaaAwie+NtF+KdtAsGZU5MYXDfsPDyte47B1ziIYMhxUYRHgQEJatwbof/8Yx6aDjVgGPjh
	ugjF9ikMzZFRCQq9lbNij02CYH2JAMeen8PQYAtJcLPRJUJf7YwAj1uLeehwVvEwftyPob9k
	PQQq3oHJ34YR+OsaOJj8/mcResoaObjc3CPB0a4KER7Y+xF0tQ3wcHz6sAjl+0sQTD2bVY6W
	hgUov9YnrU9m+3VdZG3DY5j9UnWbY72OH3mmt3RyzOe8J7EK9y7mqUxiRXoXZu7qIyJzT/wk
	sbu9TSK77pjime9+KvN5n3Cs+MCo+FnCl4bV6WqmJU/VVqz9xpBxuv2wkD2i5L84+BDZ0O23
	ipAsU5JCLzWxIhQXw75QgxBlniyhp8vPoiiLZCnV9QiO8jyymNo9ZXwRMsiYjEvUoffFFt4m
	uXR8zBYbMhKgnuCJGCvEi2l3Dbyux9OOsod8lDFJovrLv7loBkwW0Asv5Wg5jqTSsONQbCSB
	LKJX6tu56C1KhmUauO8RXwdNpFcrdb4UEecbWucbWuf/2gqEq5FiseZlmS2ZKckZBVZLfvK3
	O7PcaPbDzu+b/sqLJoKftyIiI9Nco/5XvEURzHk5BVmtiMrYNM84vY1YFGO6uWCPqu38WtuV
	qea0ogUyb3rX+PHk7nSFbDfnqjtUNVvV/utyctx8G1rdmfZdtk/7IuXBnJWlC0+yxuDGQfum
	2vghznFpyxH+mit8udL9adzmhUMJNwql8B+fDH70InxiU6JNP7jmdyXNWa/t092hFs3Q371j
	rGXJ+8Eeg2FVWsfa7gkX88/8mnqysHeD3+T98+qy5SOJW5sCtwTXlZD133Xrqkb2vrcl5QMT
	n5NhXpWEtRzzK8Hu1ERdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z+7w8VxmR3yU+s+MA0KXi0iguggFX1YBFHkqpMudcqmokkw
	S7FGmprSnKvMSk0n0lY6TbvMtWlX0axjmZqZ3W2ZmUutnBH57cfzPr/n08vgshpyAaPWJAla
	jSpOTkkIyba1x0JWFMrUYfmPODDXWiioHk+Fin47CV7LWwzMVXUIRr0vaPjd7ELwzemm4GPL
	CIKLF8ZwMD/OJOB77U8cGhrfIvhgrKHgjWuAhmrrVugrHyKgKbseh4FTrRTkZE7g0OwdpuGo
	vXJ62KanoeVsGwntdbkkFP68jEO9vp+GzkYzBb2W3yQMOXIIaDNdIcBT5MShL3cDuEqDYOz+
	JwTO2noMxk6epaCruBGD681dNJzuKKXgdWYfgo6WAQKKJo9TUJKRi2BifHpyOG+UhJK7vfSG
	UD5DFCm+5dMXnL92pRvjnxrzCV68eQ/jG0wvab7UmszbKhW8QezAeWvVCYq3jhTQfM/TJopv
	NU4QfMOrcL7B/g3jc44NU9uDdknWHRDi1CmCNnR9lCSmzH2cTPwsS53KGkR61D3HgPwYjl3N
	9fbXkz4m2CVcWckl5GOKXcaJohf3cSC7mMu0FRMGJGFw1kNzRrF3RpjLJnGeL/qZkpQFztZ+
	ZoZlrB3nnlTD3zyAayseJHyMswpO/PUeMyBmmoO5il+ML/Zjw7lRY/ZMZR67iLtd58bykNQ0
	yzbNsk3/7VKEV6FAtSYlXqWOW7NSFxuTplGnrtyfEG9F009UfmQy345GOzc7EMsgub9UfBeg
	lpGqFF1avANxDC4PlE7uY9Uy6QFV2mFBm7BXmxwn6BwomCHk86WRO4UoGRutShJiBSFR0P67
	YozfAj06/ybAGP3Qu/SIQ1EUaQ3/euhCcXCh4Uf6DVltyC1lkyWddY4/u+NiNAfd6QVZp8Js
	63qYjORX0Z5z1X3BO4rEjVNy7wPVrk0hVqsyqOZ6EPHifOdu5fCQ/xblnJJ3ka9zni/Udkft
	Pm0fWU9ltx2sVCy/6tnjXBQxpYywuNzmo3JCF6NapcC1OtUfc8wNCkADAAA=
X-CFilter-Loop: Reflected

On Mon, Nov 10, 2025 at 10:09:26AM +0900, Byungchul Park wrote:
> On Fri, Nov 07, 2025 at 06:37:12PM -0800, Jakub Kicinski wrote:
> > On Sat, 8 Nov 2025 11:24:58 +0900 Byungchul Park wrote:
> > > On Fri, Nov 07, 2025 at 05:41:29PM -0800, Jakub Kicinski wrote:
> > > > On Fri, 7 Nov 2025 13:47:08 +0900 Byungchul Park wrote:
> > > > > The offset of page_type in struct page cannot be used in struct net_iov
> > > > > for the same purpose, since the offset in struct net_iov is for storing
> > > > > (struct net_iov_area *)owner.
> > > >
> > > > owner does not have to be at a fixed offset. Can we not move owner
> > > > to _pp_mapping_pad ? Or reorder it with type, enum net_iov_type
> > > > only has 2 values we can smoosh it with page_type easily.
> > >
> > > I'm still confused.  I think you probably understand what this work is
> > > for.  (I've explained several times with related links.)  Or am I
> > > missing something from your questions?
> > >
> > > I've answered your question directly since you asked, but the point is
> > > that, struct net_iov will no longer overlay on struct page.
> > >
> > > Instead, struct netmem_desc will be responsible for keeping the pp
> > > fields while struct page will lay down the resonsibility, once the pp
> > > fields will be removed from struct page like:
> > 
> > I understand the end goal. I don't understand why patch 1 is a step
> > in that direction, and you seem incapable of explaining it. So please
> > either follow my suggestion on how to proceed with patch 2 without
> 
> struct page and struct netmem_desc should keep difference information.
> Even though they are sharing some fields at the moment, it should
> eventually be decoupled, which I'm working on now.

I'm removing the shared space between struct page and struct net_iov so
as to make struct page look its own way to be shrinked and let struct
net_iov be independent.

Introduing a new shared space for page type is non-sense.  Still not
clear to you?

	Byungchul

> > patch 1 in current form. Or come back when have the full conversion
> > ready.
> 
> This patch set represents the final phase of the full conversion process,
> awaiting the next steps. Once this patch is completed, the entire
> conversion will be finished, allowing for the final patch that removes
> the pp fields from the struct page to be carried out.
> 
> 	Byungchul

