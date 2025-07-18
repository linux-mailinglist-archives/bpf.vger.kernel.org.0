Return-Path: <bpf+bounces-63681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EDDB09915
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 03:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CD61AA3C41
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 01:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BDE14D283;
	Fri, 18 Jul 2025 01:14:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA47143756;
	Fri, 18 Jul 2025 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752801260; cv=none; b=n64JH+SUVo7ofnbRere4N/z4Hb6jVqKTh3tqHOyf+0VhJgeXy+VHOxNiGO98S6Gp89UmPZl5zsI8PFSW8q/4ZxJGDTfoyDGOdPyEEFdKlcx17J7EEI2y46rZSRQVfoHOjHVI60AK60jArvSVB3z59KBveCLz/CpNbMPnv4IahWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752801260; c=relaxed/simple;
	bh=0y9iQTUyFtdmYe9Loisns/6jI5jMfVc/yKfvcepCy4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEwolVfskCCt0CUyL4xFLxyfJd2pjpswFZmU2rwiDaV6kOBtDvkfY5vA3ChNRzQ1AO9pC1JJ+XLfREKmGGAu1BNKHIJ2lhB1CEWXILNaO9pfVUDnWpHjQbR0xsg8/48rM2381Bx3a3qPFVi29T6C4vlUwYWMt6+f2pSRulUHpho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-84-68799fe50406
Date: Fri, 18 Jul 2025 10:14:07 +0900
From: Byungchul Park <byungchul@sk.com>
To: kernel test robot <lkp@intel.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
	akpm@linux-foundation.org, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, david@redhat.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org,
	ziy@nvidia.com, jackmanb@google.com, wei.fang@nxp.com,
	shenwei.wang@nxp.com, xiaoning.wang@nxp.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net-next v11 12/12] libeth: xdp: access
 ->pp through netmem_desc instead of page
Message-ID: <20250718011407.GB38833@system.software.com>
References: <20250717070052.6358-13-byungchul@sk.com>
 <202507180111.jygqJHzk-lkp@intel.com>
 <20250718004346.GA38833@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718004346.GA38833@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0iTcRjG+X9nh8Ovdfo3L4JpBEKWKfFPQiS6+C4swq7KC1v51VZuyqZr
	ywJFC5SU0pRmiyaKh2mJ8zTDQy7bNMPjkpWmU5zYwYmKpWnapkje/Xie533e9+JlcFEGKWbk
	yhRepZQmSigBIZjzLznmfqmTnbD3BiBDbQ2Fqle0qMJlIZHB1ATQUpedQob+LAIt1/7Bkds2
	RaNq83k0UT5DoNysNRy1rXpoNNCUR6LmdBeNht8YKDRes0miGWsugb5nTlFoIi8a2YwHkLXK
	gaGu2mYMjWyuY6hgyEihoXdTBHqekQdQbbuTRAut3lVrK94Ou8PtNd6P09GHuXc/53Guoeoz
	xrUUf6U5ozmVq68M4Upbv2Gc2ZRNcebFfJobG2mluO5nawQ3W68HXItlCeNyMz0UV+exYNyC
	+wvBzbd/oi7uvSI4k8AnyjW86njUVYGsaHmWTu4L0xr7C7F0MBuUA/wYyEbArOkOaofNT4q2
	mGCPwJnhh7SPKfYodDpXcR/v8+qWyXIsBwgYnO0k4XyXw2swzF5WC9cNGl9GyCK44uoFvoyI
	fQRgXUYrtW3sgT36acLHOBsCnRvfMN8szgbCig3GJ/uxp6HetbEV388GwbdN9q1dkNUz8Ivn
	L7l96CHYWekkHgO2eFdt8a7a4v+1RoCbgEiu1Cik8sSIUJlOKdeGXk9SmIH3Mcrvr8dZwOLA
	JStgGSDxF751a2UiUqpR6xRWABlcsk9YMKSRiYQJUt1dXpUUr0pN5NVWEMgQkoPCk7/uJIjY
	m9IU/jbPJ/OqHRdj/MTpwEhbYpXX+tKWY+PVjgMNUc44XePT4Ch7anR3QsfZtPumbP3vjiJb
	bADjedHWolgSVpeFBXWqxQE3Ymziy67XWeKUksHSyKl5sqRnMjIoP+Zc+GhZjbPOZmoMdw95
	Phb2vL41loc/+KD4cUHTF9ftDH0VXLYyd+qeY7Smix6slBBqmTQsBFeppf8AxWAMyxQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RbUhTYRiGec85OzuOVse56qQQOpNgoSUUvGKEUdBLpPSjD6gfOvLQltsc
	m66tKDUtSVIz0dIWDkJNJ6zNmjOW6NSZRVpqssJ0jjb8KMVMmGnaVkT+u3mu+3qeHw+FC7xE
	JCVT5rBqpUQuInkELy25MN5Xp5fum9wCDeYWEpoCOtjosXOgodkG4GJPHwkNg0UEXDL/xKHP
	5eVCkzUVTjT4CVhatILDl8tzXNj9qJ8D39nKOLAt38OFwy8MJBxvWedAv7OUgDOFXhJOlKVA
	l3EbdDaNYLDH3IbB0fVVDFYOGUk41O0l4MOCMgDNHW4OXHAE760Egjv6RnxB0DvOTYlG3V/n
	cfSs6SOG2ms/c5HRmotan4jRY8c0hqzNt0lk/X6Pi8ZGHSR69WCFQFOtNQC12xcxVFo4RyLL
	nB1DC75PBJrv+ECeFJ7jHcxk5TItq957KIMnrV6a4qoGEnXGwSosH0zFloAwiqH3M9aKajKU
	CTqO8Q/f4oYySe9m3O5lPJSFwbl9sgErATwKp7s4zHzPSBBQVAStY1YN2lCHT0Mm4HkDQh0B
	fQcwlgIH+ReEM/01X4hQxmkx416bxkIuTkcxjWtUaBxGJzE1nrU/9a10LNNp68PuAn7tBrt2
	g1373zYCvBkIZUqtQiKTH0jQZEn1Spku4UK2wgqCn2+4tlphBz+GjzkBTQHRJn6nTycVcCRa
	jV7hBAyFi4T8yiGtVMDPlOivsOrsdHWunNU4QRRFiLbzj59lMwT0RUkOm8WyKlb9j2JUWGQ+
	2NOatLMuZkmFO0cvhfcHDJG959NNrOr6LlNE0dH6+CH8hOv52unyTjjfxXpfn7E5ytZ70iYU
	T8cs7tnU5R28kpuxp0rzbsTNLIav+3+Nu5EsJs8s/uYasJh4R3I6rhYZJtnkzW9na6JNh4vf
	KxK0xYOwPCGlboa87Gmsqr8vIjRSSaIYV2skvwEOxxX/9QIAAA==
X-CFilter-Loop: Reflected

On Fri, Jul 18, 2025 at 09:43:46AM +0900, Byungchul Park wrote:
> On Fri, Jul 18, 2025 at 01:42:38AM +0800, kernel test robot wrote:
> > Hi Byungchul,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on c65d34296b2252897e37835d6007bbd01b255742]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/netmem-introduce-struct-netmem_desc-mirroring-struct-page/20250717-150253
> > base:   c65d34296b2252897e37835d6007bbd01b255742
> > patch link:    https://lore.kernel.org/r/20250717070052.6358-13-byungchul%40sk.com
> > patch subject: [Intel-wired-lan] [PATCH net-next v11 12/12] libeth: xdp: access ->pp through netmem_desc instead of page
> > config: arm-randconfig-r072-20250717 (https://download.01.org/0day-ci/archive/20250718/202507180111.jygqJHzk-lkp@intel.com/config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250718/202507180111.jygqJHzk-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202507180111.jygqJHzk-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    In file included from include/linux/container_of.h:5,
> >                     from include/linux/list.h:5,
> >                     from include/linux/timer.h:5,
> >                     from include/linux/netdevice.h:24,
> >                     from include/trace/events/xdp.h:8,
> >                     from include/linux/bpf_trace.h:5,
> >                     from include/net/libeth/xdp.h:7,
> >                     from drivers/net/ethernet/intel/libeth/tx.c:6:
> >    include/net/libeth/xdp.h: In function 'libeth_xdp_prepare_buff':
> > >> include/net/libeth/xdp.h:1295:23: warning: passing argument 1 of 'page_pool_page_is_pp' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> >         pp_page_to_nmdesc(page)->pp->p.offset, len, true);
> >                           ^~~~
> >    include/linux/build_bug.h:30:63: note: in definition of macro 'BUILD_BUG_ON_INVALID'
> >     #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
> >                                                                   ^
> >    include/net/netmem.h:301:2: note: in expansion of macro 'DEBUG_NET_WARN_ON_ONCE'
> >      DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));  \
> >      ^~~~~~~~~~~~~~~~~~~~~~
> >    include/net/libeth/xdp.h:1295:5: note: in expansion of macro 'pp_page_to_nmdesc'
> >         pp_page_to_nmdesc(page)->pp->p.offset, len, true);
> >         ^~~~~~~~~~~~~~~~~
> >    In file included from arch/arm/include/asm/cacheflush.h:10,
> >                     from include/linux/cacheflush.h:5,
> >                     from include/linux/highmem.h:8,
> >                     from include/linux/bvec.h:10,
> >                     from include/linux/skbuff.h:17,
> >                     from include/net/net_namespace.h:43,
> >                     from include/linux/netdevice.h:38,
> >                     from include/trace/events/xdp.h:8,
> >                     from include/linux/bpf_trace.h:5,
> >                     from include/net/libeth/xdp.h:7,
> >                     from drivers/net/ethernet/intel/libeth/tx.c:6:
> >    include/linux/mm.h:4176:54: note: expected 'struct page *' but argument is of type 'const struct page *'
> >     static inline bool page_pool_page_is_pp(struct page *page)
> >                                             ~~~~~~~~~~~~~^~~~
> 
> Oh.  page_pool_page_is_pp() in the mainline code already has this issue
> that the helper cannot take const struct page * as argument.
> 
> How should we resolve the issue?  Changing page_pool_page_is_pp() to
> macro and using _Generic again looks too much.  Or should we?  Any idea?

option 1. Remove 'const' on declaration of struct page in
	  libeth_xdp_prepare_buff() but maybe bad.

option 2. Use __pp_page_to_nmdesc() instead of pp_page_to_nmdesc() in
	  libeth_xdp_prepare_buff() to skip checking if it's a pp page.

option 3. Change page_pool_page_is_pp() to macro and use _Generic to
	  cover const casting.

More?

	Byungchul

> 	Byungchul
> 
> > vim +1295 include/net/libeth/xdp.h
> > 
> >   1263
> >   1264  bool libeth_xdp_buff_add_frag(struct libeth_xdp_buff *xdp,
> >   1265                                const struct libeth_fqe *fqe,
> >   1266                                u32 len);
> >   1267
> >   1268  /**
> >   1269   * libeth_xdp_prepare_buff - fill &libeth_xdp_buff with head FQE data
> >   1270   * @xdp: XDP buffer to attach the head to
> >   1271   * @fqe: FQE containing the head buffer
> >   1272   * @len: buffer len passed from HW
> >   1273   *
> >   1274   * Internal, use libeth_xdp_process_buff() instead. Initializes XDP buffer
> >   1275   * head with the Rx buffer data: data pointer, length, headroom, and
> >   1276   * truesize/tailroom. Zeroes the flags.
> >   1277   * Uses faster single u64 write instead of per-field access.
> >   1278   */
> >   1279  static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
> >   1280                                             const struct libeth_fqe *fqe,
> >   1281                                             u32 len)
> >   1282  {
> >   1283          const struct page *page = __netmem_to_page(fqe->netmem);
> >   1284
> >   1285  #ifdef __LIBETH_WORD_ACCESS
> >   1286          static_assert(offsetofend(typeof(xdp->base), flags) -
> >   1287                        offsetof(typeof(xdp->base), frame_sz) ==
> >   1288                        sizeof(u64));
> >   1289
> >   1290          *(u64 *)&xdp->base.frame_sz = fqe->truesize;
> >   1291  #else
> >   1292          xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
> >   1293  #endif
> >   1294          xdp_prepare_buff(&xdp->base, page_address(page) + fqe->offset,
> > > 1295                           pp_page_to_nmdesc(page)->pp->p.offset, len, true);
> >   1296  }
> >   1297
> > 
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki

