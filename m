Return-Path: <bpf+bounces-58822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D87CEAC1DE8
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 09:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D271C0247E
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 07:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E33283CBE;
	Fri, 23 May 2025 07:48:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6C11547F2;
	Fri, 23 May 2025 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986480; cv=none; b=UkVQsD49IKRQJdgAvGeSY9bz5NpC0jk2Eh7nqTu/GlKq6lMQZJt8WvAgc76RGtCWDykzV/Z7F7p3d+SBB2HcN9BxL/trPiqRSl1oPh3+/P9tbn0kxlnxNg/u2NrgqlcI2FHbFJd3MAXQgDBGcbPLlB3WbSwsfByp010m8x7tIhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986480; c=relaxed/simple;
	bh=g7Gdg+0qWBaRAZcaKXMUtBidxCgzsXqlP6QraOrKnVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAbtM6ryxkDZlf23yUhnjdrPcIo7xitDsy6yVy9L1XfsG9vcleOlwf2nc3TtnKI2CVfCdFqVQPkCeC8VaFohVTjGlV1OmXhNsgBaMdpMWqDzmRuDB4KiHaL7Ux17AMQhgBwQQ5mfZiG5ziMHvUtGPQm4gXYdViF4xagWRa9gNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-83-6830282111e6
Date: Fri, 23 May 2025 16:47:40 +0900
From: Byungchul Park <byungchul@sk.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
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
	vishal.moola@gmail.com
Subject: Re: [PATCH 00/18] Split netmem from struct page
Message-ID: <20250523074740.GA8205@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <CAMArcTWx+8GFzk4=A2-DCUZkMtyYRaDZSqf+HvOf2KyC80BqsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMArcTWx+8GFzk4=A2-DCUZkMtyYRaDZSqf+HvOf2KyC80BqsA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe97bXoeLt2X6qJA4u2GkVkIHUjP68kJfiqCggrbypS2vbGoa
	FaaiNNMiLW1NmZZmJg6WuRlDaplTDLSVsbw0MW9FF2pqznVzSuS3H//z5/zOh8OS0gY6hFWl
	ZQrqNEWKjBFT4s/+tdvCt8QoYxoqIkBvbGbgwXwO3Bu10OBpniJA39SGYMYzJAJ3p52BO7Vz
	JOj7CimYNS6QMNE1JgJXwyQF1mIzCWNXuxkoLfSSkG9pJKC/rYyGioV6Esx5oyJ49VjPwLvm
	PzRM2kop6NHdp8BVlghdhkCY6/2EoNNoJmDuSjUD5Q4DA+8LXQgcz8YouH2pDIGxw0mDd17P
	JMr41vtvCb5dNyLiDaYs/mFjJK91Okje1HSZ4U3fr4v44TdWhu+u8lJ8u8VN8KUFXxj+28Qg
	xX/tGGB4Y+sAxb8wdIp4t2n9Ae6oOC5JSFFlC+roBLlY6R0eoDMcu3OK7Y1UHqqO1iKWxVws
	9pRu0CK/Jeyvd5E+priNuEVXi3zMcJux0+khffUALgJrO/ZqkZgluR80/uQuJnydtRzgKWs7
	5WMJtwvXWT+IfCzlzuO82RJyOV+De26NL3XIxZ0/axxLO0kuFN/7zS7HYbjg0e2luh93EFcZ
	jLSP1y1qn7TZCZ8Xc09YbHrtYpZvDsZPG53UNbRGt0KhW6HQ/VfoVigMiGpCUlVadqpClRIb
	pcxNU+VEnUpPNaHF72m48POYBX3vP2RDHItk/hKLOFoppRXZmtxUG8IsKQuQPJ+MUkolSYrc
	c4I6/YQ6K0XQ2FAoS8mCJDvmziZJudOKTCFZEDIE9b8pwfqF5KHYmcB8r51I2qcJrTsQcWPP
	lcqx2LjKhfjAnjDn4LydCC8y+Wsjras/juOy2a3xblKekNqdOTM/2DyOHW2D0xNBQ8pf5qxN
	0lUT+2+2vCo+GdBbdeaY/O5spSggudx2ePry0J3gTm/By/7w+J3y3otMSQ038rzo+Lr9IdVH
	+jokMkqjVGyPJNUaxV+dWULZOQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGe895z9nZaHGcVicNqoVpX2pR9IBaRj966UfUjygiylWnNpym
	m8pMg9Ukazr7JGxtMbP8ppGaH2UW01IrKCbGNGtmaRr2aVqmWM6I/HdxPzfX/efhaIWZCeQ0
	CcmiLkGlVbIyLNsaaVq5KDRCHfHOxYPNWc5C2U8DFHXXMjBa/p4CW2k1gu+jLyUw1NTMQkH+
	CA22Z5kYhp2/aOh91CMBb2EfhvqsGhp6zrSwYMkco+FEbTEFjfZWBp5X5zJw8dcNGmqM3RJo
	u2Nj4XX5bwb6XBYMrdYSDN7cGHjkmAMjTwYRNDlrKBjJsbNwwe1g4W2mF4G7sQfDleO5CJwN
	HgbGftrYmMWkqqSDInXWVxLiqEghlcXLiNnjpklF6WmWVHw7LyFdL+pZ0pI3hkld7RBFLKZP
	LPna24nJ54Z2lhT0f6GIs6odk6eOJsk2v92yqIOiVpMq6sLXx8rUY13tTKI70pDVXIyNyB5u
	RlJO4NcIz294aR9jPli4ac1HPmb5EMHjGZ3MOS6AXyyYGzaakYyj+R+MMDiURfk6/jwI7+vr
	sI/l/DrhWv2AxMcKPkMwDmfTf3M/ofXyu6kOPekcv+qectJ8kFA0wf2NFwim21em6lJ+u5Dn
	cDI+nj05+6C6mTqLZlmnmazTTNb/Jus0kwPhUhSgSUiNV2m0a8P0ceq0BI0h7MCR+Ao0+SGF
	x8bP1aLvbZtdiOeQcqY8ND5crWBUqfq0eBcSOFoZIH/YF6ZWyA+q0o6KuiP7dClaUe9CQRxW
	zpVv2SnGKvjDqmQxThQTRd2/K8VJA40o5eOKSwGne1+E8tr0oUrTXVP21ZPSxjP3Ooi3sPdZ
	UnrZdf/5OePj9KE7ndLPu66nhxurFprc+YXRm+8vnGcoKdsxmBF17tbEqX7Pkv2Rb/zW22Nc
	ewvagpenGCJsM+y/UzeU4uGkvO7Vi8pzB3YIluhNDz0fDuNTiY8ztoZYlu6ZocR6tWrVMlqn
	V/0B0MxHWB0DAAA=
X-CFilter-Loop: Reflected

On Fri, May 23, 2025 at 03:20:27PM +0900, Taehee Yoo wrote:
> On Fri, May 23, 2025 at 12:36 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> 
> Hi Byungchul,
> Thanks a lot for this work!
> 
> > The MM subsystem is trying to reduce struct page to a single pointer.
> > The first step towards that is splitting struct page by its individual
> > users, as has already been done with folio and slab.  This patchset does
> > that for netmem which is used for page pools.
> >
> > Matthew Wilcox tried and stopped the same work, you can see in:
> >
> >    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/
> >
> > Mina Almasry already has done a lot fo prerequisite works by luck, he
> > said :).  I stacked my patches on the top of his work e.i. netmem.
> >
> > I focused on removing the page pool members in struct page this time,
> > not moving the allocation code of page pool from net to mm.  It can be
> > done later if needed.
> >
> > My rfc version of this work is:
> >
> >    https://lore.kernel.org/all/20250509115126.63190-1-byungchul@sk.com/
> >
> > There are still a lot of works to do, to remove the dependency on struct
> > page in the network subsystem.  I will continue to work on this after
> > this base patchset is merged.
> 
> There is a compile failure.

Thanks a lot.  I will fix it.

	Byungchul
> 
> In file included from drivers/net/ethernet/intel/libeth/rx.c:4:
> ./include/net/libeth/rx.h: In function ‘libeth_rx_sync_for_cpu’:
> ./include/net/libeth/rx.h:140:40: error: ‘struct page’ has no member named ‘pp’
>   140 |         page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len);
>       |                                        ^~
> drivers/net/ethernet/intel/libeth/rx.c: In function ‘libeth_rx_recycle_slow’:
> drivers/net/ethernet/intel/libeth/rx.c:210:38: error: ‘struct page’
> has no member named ‘pp’
>   210 |         page_pool_recycle_direct(page->pp, page);
>       |                                      ^~
> make[7]: *** [scripts/Makefile.build:203:
> drivers/net/ethernet/intel/libeth/rx.o] Error 1
> make[6]: *** [scripts/Makefile.build:461:
> drivers/net/ethernet/intel/libeth] Error 2
> make[5]: *** [scripts/Makefile.build:461: drivers/net/ethernet/intel] Error 2
> make[5]: *** Waiting for unfinished jobs....
> 
> There are page->pp usecases in drivers/net
> ./drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:1574:
>  } else if (page->pp) {
> ./drivers/net/ethernet/freescale/fec_main.c:1046:
>                  page_pool_put_page(page->pp, page, 0, false);
> ./drivers/net/ethernet/freescale/fec_main.c:1584:
>  page_pool_put_page(page->pp, page, 0, true);
> ./drivers/net/ethernet/freescale/fec_main.c:3351:
>          page_pool_put_page(page->pp, page, 0, false);
> ./drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:370:
> page_pool_recycle_direct(page->pp, page);
> ./drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:395:
> page_pool_recycle_direct(page->pp, page);
> ./drivers/net/ethernet/ti/icssg/icssg_common.c:111:
> page_pool_recycle_direct(page->pp, swdata->data.page);
> ./drivers/net/ethernet/intel/idpf/idpf_txrx.c:389:
> page_pool_put_full_page(rx_buf->page->pp, rx_buf->page, false);
> ./drivers/net/ethernet/intel/idpf/idpf_txrx.c:3254:     u32 hr =
> rx_buf->page->pp->p.offset;
> ./drivers/net/ethernet/intel/idpf/idpf_txrx.c:3286:     dst =
> page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
> ./drivers/net/ethernet/intel/idpf/idpf_txrx.c:3287:     src =
> page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
> ./drivers/net/ethernet/intel/idpf/idpf_txrx.c:3305:     u32 hr =
> buf->page->pp->p.offset;
> ./drivers/net/ethernet/intel/libeth/rx.c:210:
> page_pool_recycle_direct(page->pp, page);
> ./drivers/net/ethernet/intel/iavf/iavf_txrx.c:1200:     u32 hr =
> rx_buffer->page->pp->p.offset;
> ./drivers/net/ethernet/intel/iavf/iavf_txrx.c:1217:     u32 hr =
> rx_buffer->page->pp->p.offset;
> ./drivers/net/wireless/mediatek/mt76/mt76.h:1800:
> page_pool_put_full_page(page->pp, page, allow_direct);
> ./include/net/libeth/rx.h:140:  page_pool_dma_sync_for_cpu(page->pp,
> page, fqe->offset, len);
> 
> Thanks a lot!
> Taehee Yoo
> 
> >
> > ---
> >
> > Changes from rfc:
> >         1. Rebase on net-next's main branch
> >            https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
> >         2. Fix a build error reported by kernel test robot
> >            https://lore.kernel.org/all/202505100932.uzAMBW1y-lkp@intel.com/
> >         3. Add given 'Reviewed-by's, thanks to Mina and Ilias
> >         4. Do static_assert() on the size of struct netmem_desc instead
> >            of placing place-holder in struct page, feedbacked by Matthew
> >         5. Do struct_group_tagged(netmem_desc) on struct net_iov instead
> >            of wholly renaming it to strcut netmem_desc, feedbacked by
> >            Mina and Pavel
> >
> > Byungchul Park (18):
> >   netmem: introduce struct netmem_desc struct_group_tagged()'ed on
> >     struct net_iov
> >   netmem: introduce netmem alloc APIs to wrap page alloc APIs
> >   page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
> >   page_pool: rename __page_pool_alloc_page_order() to
> >     __page_pool_alloc_large_netmem()
> >   page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
> >   page_pool: rename page_pool_return_page() to page_pool_return_netmem()
> >   page_pool: use netmem put API in page_pool_return_netmem()
> >   page_pool: rename __page_pool_release_page_dma() to
> >     __page_pool_release_netmem_dma()
> >   page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
> >   page_pool: rename __page_pool_alloc_pages_slow() to
> >     __page_pool_alloc_netmems_slow()
> >   mlx4: use netmem descriptor and APIs for page pool
> >   page_pool: use netmem APIs to access page->pp_magic in
> >     page_pool_page_is_pp()
> >   mlx5: use netmem descriptor and APIs for page pool
> >   netmem: use _Generic to cover const casting for page_to_netmem()
> >   netmem: remove __netmem_get_pp()
> >   page_pool: make page_pool_get_dma_addr() just wrap
> >     page_pool_get_dma_addr_netmem()
> >   netdevsim: use netmem descriptor and APIs for page pool
> >   mm, netmem: remove the page pool members in struct page
> >
> >  drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  46 ++++----
> >  drivers/net/ethernet/mellanox/mlx4/en_tx.c    |   8 +-
> >  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
> >  drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
> >  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  18 ++--
> >  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |   2 +-
> >  .../net/ethernet/mellanox/mlx5/core/en_main.c |  15 ++-
> >  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  66 ++++++------
> >  drivers/net/netdevsim/netdev.c                |  18 ++--
> >  drivers/net/netdevsim/netdevsim.h             |   2 +-
> >  include/linux/mm.h                            |   5 +-
> >  include/linux/mm_types.h                      |  11 --
> >  include/linux/skbuff.h                        |  14 +++
> >  include/net/netmem.h                          | 101 ++++++++++--------
> >  include/net/page_pool/helpers.h               |  11 +-
> >  net/core/page_pool.c                          |  97 +++++++++--------
> >  16 files changed, 221 insertions(+), 201 deletions(-)
> >
> >
> > base-commit: f44092606a3f153bb7e6b277006b1f4a5b914cfc
> > --
> > 2.17.1
> >
> >

