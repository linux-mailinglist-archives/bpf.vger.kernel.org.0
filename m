Return-Path: <bpf+bounces-60026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1136AD17BA
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF877A3AA1
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0FD27FB3E;
	Mon,  9 Jun 2025 04:23:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8130178F4B;
	Mon,  9 Jun 2025 04:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749442995; cv=none; b=JIgyhzw6D6Lsm/PZDdJgWWtAUC2FodZhQzuTLcol05RymMb9L9DeECy2bMqdsy+QE9yqn5MwBjlH/PIZ1+Vz5wKHZPYz5BeKJJJ7cCtrcCmLA7DGXrGwGzGLThqlirNIszZxDQYY1nI3GYZveLFrH47Xa2wEDoP4LW21P8CivWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749442995; c=relaxed/simple;
	bh=YC+zjw6n8n/NQRRoweMSWXo90JS3zk4d+5aO2WE3LsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jbd42cPq+Bs5KJf1IrUV9mMcM1P9pXRL3SKoi3lBoEKyKN4QoArnYo6GUWL2wCZovLMcaAUKEOpB4GJODhpO/w7EE4yvRMYL0b0Rgquom6P/UemnEjmBpH7mrPQo45v/gJHvo+0S1NDzPaWw5dkcZnRGgsEZcHiH9NYRfmqfHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e8-684661a490e1
Date: Mon, 9 Jun 2025 13:22:55 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, netdev@vger.kernel.org
Subject: Re: [RFC v4 00/18] Split netmem from struct page
Message-ID: <20250609042255.GA43325@system.software.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604032319.GA69870@system.software.com>
 <CAHS8izPNKe+3A9HAk13idouEzvePnp5Tih0GmSQNzEcsxuvoPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPNKe+3A9HAk13idouEzvePnp5Tih0GmSQNzEcsxuvoPA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfenR2Hq+O0elMoWokkZFfoKSJEsV6IosuXLpAuPbSlrjgr
	L5GwVAhFl2WhzVUrLa8xW6YzxHJT00oyw1qlGWZFkYWay5xYTpH89uP/XH7Ph4djlMXSQE6r
	OymIOnWCipVj+aDvzVUl6m2aNZ2/VoPZWsVC5VgKlH6wS8FcUYvg1593MhhpfsxC8Q03A+bn
	mRhGreMMfGrtl0Hf7c8YGs7VMdB/vo2F3EwPA+n2Mgl01hqlcGn8FgN1hg8yePnAzML7qr9S
	+OzIxdBuKsfQZwyHVstCcD/9jqDZWicBd85VFvK7LCx8zOxD0OXsx1B01ojA2uiSgmfMzIYv
	ozXlbyS03tQroxbbKXqvLJRmu7oYaqvIYqlt+KKM9rxqYGlboQfTevuIhOZm/GDp0Ke3mP5s
	7GaptaYb02eWZhkdsS3ZzR+Ub4kTErRJgrh6a4xck9/zmznR4Z+S/7pAYkB587ORD0f4DWTA
	MYpmubv6K+NlzK8g1SUm7GWWDyEu15/pPIBfSUoaL0i9zPC9UjJ+a6+X/flNpKPyjszLCh5I
	6bf0qR45p+QrEal+mCWZKfiR9isDeGY4hExc65payk1xECmd5GbipSTjftG0y4ffQ5z9X6Z5
	Ab+cPKp9LPHuJHwNRwpvjuGZoxeTpjIXzkN+pjkK0xyF6b/CNEdhQbgCKbW6pES1NmFDmCZV
	p00Jiz2eaENTr3M7beKQHQ137nMgnkMqX0VMQZRGKVUn6VMTHYhwjCpAwfdFapSKOHXqaUE8
	Hi2eShD0DhTEYdUixTp3cpySP6o+KcQLwglBnK1KOJ9AA4pYcNcVWmqnecHVg7JvN5zm+qiA
	wpdrhybxiwMxRckdTeL2w5ojT66E7U9fcc2o2BErMsEtmyf9nT2eRUxaLHnlyJu3NW1nVjAj
	Duq7Q6PjWXdOZNSw38am9vUe4+vnQRHXGzcVPmudn1ypGWqBVOOAY3HZsV0ORTK5vN/3jEGF
	9Rr12lBG1Kv/AX9vHBY2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+93XrqPVdVr+sEhYgiTYAwpOKSaEdXtSERkF5UVvbTinbCaa
	VKaSFKkzi2quWmgttdpY5rTEYkopZYmirdKU+Sp7p5k6sTYl8r8P3+85n/PPYUn5aTqQVWlS
	RK1GUCsYKSXdEZ4dVipsVK6ceh8ERssdBirG0sDcU02DsbwKwcj4OwkMNzxjoOTGKAnGVzkU
	/LJMkND/1CWB7lsDFNTm2klwFTQykJfjJiGr+jYB9VebaGipyqfhwsRNEuyZPRJoe2hk4P2d
	PzQMOPIoaDKUUdCdHwVPTQth9PlnBA0WOwGj564yUNRqYqA3pxtBa72LguJT+QgsdU4a3GNG
	JkrBV5a9IfgaQ5eEN9mO8vdvh/Jnna0kbys/w/C2n+clfGdHLcM3XnZTfE31MMHnZX9l+B/9
	byn+W107w5d8+E7wlsp2in9hapDs9N0vjYgX1apUUbsiMlaqLOr8TSY3+6UVvb5EZCL9/LPI
	h8Xcatxu/Uh6meKCsbXUQHmZ4UKw0zk+nftzy3BpXSHtZZLrovHEzd1e9uPW4uaKuxIvyzjA
	5qEsz4yUlXMVCFsfnyFmCl/cdKWPmlkOwZPXWj1S1sOLsHmKnYmDcPaD4ulbPtwuXO8anOYF
	3FL8pOoZoUfzDLNMhlkmw3+TYZbJhKhy5K/SpCYKKvWa5boEZbpGlbY8LinRhjzfcev4ZGE1
	Gmnb5EAcixRzZbGXopVyWkjVpSc6EGZJhb+M696glMvihfRjojbpkPaoWtQ50CKWUgTItsSI
	sXLuiJAiJohisqj91xKsT2AmuqavDTl5gjOlqC1tne7ei32DEdah6C9L+/dtj3ub7hrPXlOB
	e3zDyPBCMr7Ab9vwdXfLHnuSZB1Rd+Bd5EFtxvirvbG5BUvMGqc5PMMevHJPNKHaOrm4fri5
	oSMgVxiMObC+dE5H3+S9kUfFCoj7tDnI1qU/nKK3bkoceDlmdyoonVJYFUpqdcJfF+hmQxkD
	AAA=
X-CFilter-Loop: Reflected

On Thu, Jun 05, 2025 at 12:55:30PM -0700, Mina Almasry wrote:
> On Tue, Jun 3, 2025 at 8:23 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > On Wed, Jun 04, 2025 at 11:52:28AM +0900, Byungchul Park wrote:
> > > The MM subsystem is trying to reduce struct page to a single pointer.
> > > The first step towards that is splitting struct page by its individual
> > > users, as has already been done with folio and slab.  This patchset does
> > > that for netmem which is used for page pools.
> > >
> > > Matthew Wilcox tried and stopped the same work, you can see in:
> > >
> > >    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/
> > >
> > > Mina Almasry already has done a lot fo prerequisite works by luck.  I
> > > stacked my patches on the top of his work e.i. netmem.
> > >
> > > I focused on removing the page pool members in struct page this time,
> > > not moving the allocation code of page pool from net to mm.  It can be
> > > done later if needed.
> > >
> > > The final patch removing the page pool fields will be submitted once
> > > all the converting work of page to netmem are done:
> > >
> > >    1. converting of libeth_fqe by Tony Nguyen.
> > >    2. converting of mlx5 by Tariq Toukan.
> > >    3. converting of prueth_swdata (on me).
> > >    4. converting of freescale driver (on me).
> > >
> > > For our discussion, I'm sharing what the final patch looks like the
> > > following.
> >
> > To Willy and Mina,
> >
> > I believe this version might be the final version.  Please check the
> > direction if it's going as you meant so as to go ahead convinced.
> >
> > As I mentioned above, the final patch should be submitted later once all
> > the required works on drivers are done, but you can check what it looks
> > like, in the following embedded patch in this cover letter.
> >
> 
> We need this tested with at least 1 of devmem TCP and io_uring zc to
> make sure the net_iov stuff isn't broken (I'll get to that when I have
> time).
> 
> And we need page_pool benchmark numbers before/after this series,
> please run those yourself, if at all possible:

I'm trying but it keeps conflicting on several steps..  Please share a
better manual.

	Byungchul

> https://lore.kernel.org/netdev/20250525034354.258247-1-almasrymina@google.com/
> 
> This series adds a bunch of netmem/page casts. I expect them not to
> affect fast-path perf, but making sure would be nice.
> 
> -- 
> Thanks,
> Mina

