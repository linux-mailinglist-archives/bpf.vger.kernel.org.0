Return-Path: <bpf+bounces-64327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C68B118AF
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 08:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3657AAC04
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 06:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41223289809;
	Fri, 25 Jul 2025 06:50:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98AD1DED4A;
	Fri, 25 Jul 2025 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426252; cv=none; b=Qqje8qKtu7ZPeihvA1vNVyj4s4sk1330Jut7D+3PbO4m7C4eTvTxujkaO/2fwWaV9SWFFgFsJvWl1hlJugRbwVuUEwa0S76egAXet1xjKLVMSWFDjDPf1HfJtSz3vM9Ewtf8p1Qz9DCPjGHtyWDBMYR/TWHkKIq3G84itexoPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426252; c=relaxed/simple;
	bh=OO3pXYvp4Ujbu5BgmfsSaLZ7wyst5VWJXR1l2BfHnTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wdh28ry0BxmfwmhYsYu4yzMGa+jTcMhr8GS6DNhI4J/vUccqmn3SUGqX1x4VwfDyrXIgQmmV8wH8oZpMMf3fv+ln29KAnkrd0YIHNhb97OsZQumqseLS0txx0/UQ+KxQtvJMp23/YN4DyjHhXhrGgYXpdWUUr44+xF2zcL5pUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-64-68832943f8b9
Date: Fri, 25 Jul 2025 15:50:38 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
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
	toke@redhat.com, asml.silence@gmail.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool
 in page type
Message-ID: <20250725065038.GA58004@system.software.com>
References: <20250721054903.39833-1-byungchul@sk.com>
 <CAHS8izM11fxu6jHZw5VJsHXeZ+Tk+6ZBGDk0vHiOoHyXZoOvOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM11fxu6jHZw5VJsHXeZ+Tk+6ZBGDk0vHiOoHyXZoOvOg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH9/09dzr73YW+5Kkza7V5yMP2sRltZr5/ME9jHv7gpt/czZXc
	KWXMcS0xF3nuOhwpqba4qCtqVCLWLkcc4Ti6eUhStJ7IXTH999r7+/m+X58/PgKtbGDHCdr4
	nZI+Xq1TcTJG9jX40rRFkSbNzDNZs8FaXMRBYXcyXHnrYMFaUIrgR08zDwOVdQg6a+9z8KWm
	A0HOxS4arM5UBn4W99LQUuflodC+DDx5PgZuHyyjwXv0AQfm1D4aKnvaeDjgyKfAWmLkobE0
	g4WTvbk0lBnf8vCkwsrBm6IBFnzVZgbqLVcZaD9VS4MnIwbqbGOg61ErgtriMgq6jpzjoCmr
	goITLhsH71M9CFw1XgZO9adzkL0/A0Fft7+t7dgPFrLvveFjokhN6zea3Lj6giLuqocUKbe8
	5onNnkhK8qPIYbeLJvaCQxyxdxznyatntzny4GwfQ8rfzSPljk6KmE1tHPne8pIh36qauBUh
	G2TzYyWdNknSz1iwWaZxfPaxCU3jk2+dbWeMyBZ6GAUJWJyDvXWF/D82PXShADPiVGx0ltAB
	5sQI7Hb3DPIoMRJfrspkA0yLp3mckzYywCHiBtxorKQCLBcBP2347O8RBKW4B183zx2KFbg+
	6wMz9DUC95930YERWgzDV34LQ/EkbLqZPWgKEldiz9cTg+OjxSn4Tul9f7vMv+UHATszq/6u
	PBbfzXczx5DCMkxhGaaw/FdYhilsiClASm18Upxaq5szXZMSr02evmV7nB35jyxvb/9GB+po
	XF2NRAGpguUk4oBGyaqTDClx1QgLtGqUvPmaP5LHqlN2S/rtm/SJOslQjcIERhUqn9W1K1Yp
	blXvlLZJUoKk//dKCUHjjCjXULCmYh+bkNJIpw9cszY1+DY/VbWuc1gOvtM7cfhAWr7pV8v6
	pRMuUN57nSNX/WrY7eoOjVwyOc1zWhUthRelj/ieo5z7WDErsyesnvsUs1C5vELxfMF1+6v3
	USG9itypoBsfvtVswNHznzsX+3Yk3gxbsiLn46K1Y4Ineprb96oYg0YdHUXrDeo/3knTkmAD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH9/09d1x+Ev1WNnZYymOj7eOZMb6zeZ6H2Zpu+nG37o7dVTq0
	HZc8Vqgs12VncaVMuqiLHuxKlFG7RESX0B9JkqRck65m+u+19+f9eX3++XCkTz7tzyk1UaJW
	I1fJGAkl2bzMOG9tkFGxsCJhOpjzbzOQ1x8L2a12Gsy5RQh6B5pZGCqrRvCj6gkDXyp7EGRd
	7yPBXBdPwc/83yR8rm5jIc+2CVzWdgpKTxeT0Jb8lIHEeDcJZQNdLJy05xBgLjSwUJlZQ0N9
	URINqb9vklBsaGWh4YGZgZbbQzS0OxIpqDHdoqA7rYoEV9JqqLZMgb5nnQiq8osJ6LuQyUDj
	1QcEpDgtDHyMdyFwVrZRkDZ4hoGME0kI3P3Dtq6LvTRkPG5hV8/BlZ3fSHzv1hsCN5XXErjE
	9J7FFls0LswJxueanCS25Z5lsK3nMovfvSpl8NN0N4VLPizBJfYfBE40djH4++e3FP5W3shs
	9d0rWR4hqpQxonbBynCJwt7RTh9unBr7ML2bMiCL3znkxQn8YsFY60QepvhZgqGukPQwwwcK
	TU0DI+zLBwk3yi/RHib5K6yQleDt4Un8XqHeUEZ4WMqD8PJ5x7CH43z440JBYuhoPFGoufqJ
	Gl0NFAavOUlPheQDhOw/3Gg8TTDezxi55MVvE1xfU0bqk/kZwqOiJ8RF5G0aYzKNMZn+m0xj
	TBZE5SJfpSZGLVeqQufrIhV6jTJ2/v5DahsafiNr3OAlO+pt2OBAPIdk46U48KTCh5bH6PRq
	BxI4UuYrbb47HEkj5PqjovbQPm20StQ5UABHyfykG3eL4T78QXmUGCmKh0XtvynBefkbkP+W
	9XXWzdv73Sd6HAUxCdaObevUEluC3ntXryv1V9aiAI3sV05ryzP1UdbUrg0Ln41I1dyUNSHs
	jj3JElf2uInXl67q335/3ql66864irDyIfexlBUz7xyJOA9X+LDkG1sOdIbUvp5amBk04cW0
	g+5Jj6eb9Kq5X1JnqVx+4sy8NBmlU8hDgkmtTv4XDIkYeUIDAAA=
X-CFilter-Loop: Reflected

On Tue, Jul 22, 2025 at 03:17:15PM -0700, Mina Almasry wrote:
> On Sun, Jul 20, 2025 at 10:49 PM Byungchul Park <byungchul@sk.com> wrote:
> > diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> > index cd95394399b4..39a97703d9ed 100644
> > --- a/net/core/netmem_priv.h
> > +++ b/net/core/netmem_priv.h
> > @@ -8,21 +8,11 @@ static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
> >         return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
> >  }
> >
> > -static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
> > -{
> > -       __netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
> > -}
> > -
> > -static inline void netmem_clear_pp_magic(netmem_ref netmem)
> > -{
> > -       WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
> > -
> > -       __netmem_clear_lsb(netmem)->pp_magic = 0;
> > -}
> > -
> >  static inline bool netmem_is_pp(netmem_ref netmem)
> >  {
> > -       return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> > +       if (netmem_is_net_iov(netmem))
> > +               return true;
> 
> As Pavel alludes, this is dubious, and at least it's difficult to
> reason about it.
> 
> There could be net_iovs that are not attached to pp, and should not be
> treated as pp memory. These are in the devmem (and future net_iov) tx
> paths.
> 
> We need a way to tell if a net_iov is pp or not. A couple of options:
> 
> 1. We could have it such that if net_iov->pp is set, then the
> netmem_is_pp == true, otherwise false.
> 2. We could implement a page-flags equivalent for net_iov.
> 
> Option #1 is simpler and is my preferred. To do that properly, you need to:
> 
> 1. Make sure everywhere net_iovs are allocated that pp=NULL in the
> non-pp case and pp=non NULL in the pp case. those callsites are
> net_devmem_bind_dmabuf (devmem rx & tx path), io_zcrx_create_area

A few seconds reviewing the code, fortunately netmem_set_pp(pool) and
netmem_or_pp_magic(PP_SIGNATURE) are always called paired, and
netmem_set_pp(NULL) and netmem_clear_pp_magic() are always called paired
too.

And there's no code to directly assign a value to ->pp and ->pp_magic,
except in net_devmem_alloc_dmabuf() but that is also safe because always
followed by page_pool_set_pp_info().

Even though I think it's already equivalent between checking
'->pp != NULL' and '->pp_magic == PP_SIGNATURE' with the current code,
more consideration for better code should be always welcome.

As you mentioned, at net_devmem_bind_dmabuf() and io_zcrx_create_area(),
it'd better initialize ->pp and ->pp_magic like:

--
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 00d0064b22a5..8f2051b2c505 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -430,6 +430,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		area->freelist[i] = i;
 		atomic_set(&area->user_refs[i], 0);
 		niov->type = NET_IOV_IOURING;
+		page_pool_clear_pp_info(net_iov_to_netmem(niov));
 	}
 
 	area->free_count = nr_iovs;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index b3a62ca0df65..5d017c9f4986 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -285,6 +285,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			niov = &owner->area.niovs[i];
 			niov->type = NET_IOV_DMABUF;
 			niov->owner = &owner->area;
+			page_pool_clear_pp_info(net_iov_to_netmem(niov));
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
--

Do you think it works for using ->pp to check if a niov is pp?

	Byungchul

