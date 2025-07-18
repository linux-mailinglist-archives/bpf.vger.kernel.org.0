Return-Path: <bpf+bounces-63679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC5EB098FD
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 02:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB7F4A0FC3
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 00:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F143E80BEC;
	Fri, 18 Jul 2025 00:44:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1233D2AD2C;
	Fri, 18 Jul 2025 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752799440; cv=none; b=V1g3nzaFQ/A2zQsdzDXykpMZpEvBDtHdB4UEAgOxskfljXwRs6qAQm1snU14FhJCZwjgoilqrmYttotJ9JI3bPfLoGyVLR2upFvIPz7wEUPfnDDjeV4uevxWSDIC0CWB1RBLgUN1qQnaIr8rWQi3/RIoS1fIA1465MTufWnfp9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752799440; c=relaxed/simple;
	bh=Ox2D1goCtlPhcg2S8wC1ZqhkF53ndLC5sNkhZmMWolw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwIJ2BVE6bu20i9cl8OXxOhGHChNoAF1Ti4DiirosG+L0kJO45VvtefFh+cNgSg5KY7kZlqzyWYtt3c6vcB+asQYU3yx+lMHM0/H+d01idoGDm8OB83CMYoUXa/S3zQRty6r61nT8+LSBMxUk5q9v0PsfA9yYcv6iIg+tDM159U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-41-687998c8062f
Date: Fri, 18 Jul 2025 09:43:46 +0900
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
Message-ID: <20250718004346.GA38833@system.software.com>
References: <20250717070052.6358-13-byungchul@sk.com>
 <202507180111.jygqJHzk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507180111.jygqJHzk-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTUQCGOffe3V3Hlrf5ddKgmGghqSn+OELEfvTjQhiGRJBFjXZxK50y
	dU2hslT6UjMlmDZwUsxPsKbN+ZHpZjorTHTpEtMpzjJKmZr4MbRNkfz38L7nPO/5cShcmMcJ
	puSKLFapkKSKSB7B+8OvjrRqcmQnOywBSNvUSKKGNTWqcZg4SFtvBGi5t59E2i8FBPrbtIEj
	Z98MFzUYEtCUfo5AxQWbOHq3vsBFQ8YSDmrNc3DRSLuWRJON2xw0Zy4m0K/8GRJNlYhRny4Q
	metsGOptasXQ6LYbQ+XDOhINW2YI9OJeCUBNXXYOcnV6pjbXPI5+m9NTfJjkio8wlt+LONNS
	9w1j2iq/cxmdIZtpro1gXnbOY4yh/hHJGJbKuMzEaCfJWDWbBPOzuQIwbaZljCnOXyCZNwsm
	jHE5xwlmsesrmeh3iXdKyqbKVawy+vQ1nqzVbuZmfD6hrh97jecB/dHHwIeCdBysKJ0l9/ip
	xQq8TNBh0Gktw7xM0seg3b6Oe9nfk5um9Z6cR+F0Dwcu9to8BUX50Wro1qq8ZwQ0gkXm9h2n
	kL4CjVVj+G5+EA5UzBJexukIaN+ax7xXcToE1mxR3tiHjoXu6dWd2QA6FHYb+3emIP2cggOa
	Wu7uOw/Bnlo7UQroyn3ayn3ayv9aHcDrgVCuUKVJ5KlxUbIchVwddT09zQA8/0J/251sAktD
	SWZAU0DEF3Q71TIhR6LKzEkzA0jhIn9B+bBKJhRIJTm5rDL9qjI7lc00gxCKEAUJYldvSYV0
	iiSLvcmyGaxyr8Uon+A8IF9yiJP75RdtHYcj+a67LUkNuYNFZxwSDeipi48ZW9wg3W5954/A
	ovigAzOF4eLLGfE3REu9xpXRwXMJiZ/moG0l1OU7ckE4COzSs5EptskwpAi3uHlvX02Mnx+V
	PyicCruvcUdbw5/4vx/nG47f+egzrqpSSp89rPWNL60WEZkySUwErsyU/APdXmvcEwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUhTYRTGe++9u7sOR7c566IEsojKylSK3rBEEOqtKEqEwIocenHDOW3T
	tUWBoYVZ01QyPxZqwdQpTafplGW6mc4IEj9n5NdollGamaH51VZE/vc7z3Oe8/xxKFzgJPwo
	qTyVVcjFMhHJI3hnwzL224s0kuA7ZRyoM9aSsGZRDSsnzO7J0ATgfGc3CXVvMwm4YPyFQ1eX
	kwtrTGfguH6KgNrMZRy+WJrhQtvjHg7sbcrhwOb0CS7sb9WRcKx2nQOnrFoCfs5wknA8JwJ2
	lW+F1uoBDHYamzE4tL6CwYK+chL22ZwELL2VA6CxzcGBcxZ33/Ki+0b3gMttvBrjRgQg25dZ
	HDVWj2CopWSUi8pNaaihKhA9tUxjyGS4SyLT93wuej9kIZG9aJlAnxqKAWoxz2NImzFDovoZ
	M4bmXO8INNs2SJ4TxvCOxrMyqYpVHAiP5UmaHVZuypt9asNwHZ4O9AHZwIti6INMrs0OPEzQ
	OxmXPR/zMEnvYhyOJdzDQrduntS7dR6F0x0cZrZzwG1QlA+tZlZ0Ks8On4bMfWsr6WEBfZlp
	KhvG/+pbmJ7iD4SHcTqQcaxNY54oTvszlWuUR/aiQ5mVyZ9/an3pHUx7Uzf2APBLNqRLNqRL
	/qfLAW4AQqlclSSWyg4FKRMlGrlUHRSXnGQC7s/rb67kmcGP/hNWQFNA5M1vd6klAo5YpdQk
	WQFD4SIhv6BPJRHw48Wa66wi+YoiTcYqrcCfIkTb+KcusLECOkGcyiaybAqr+OdilJdfOoio
	/1blbckasEfffqZ5Xvo6anvQkZPh1cLlPXU3tLqQ0MAs78ZNE4qLX01LCUXc1eNEYVG2yQxH
	e9dkIoM9Lmavein1YeQl39yP+vNy67HI04+mF3yqS9HVsSe2em1hMHBZOq6JczfnrQ7uvlch
	a6yoqjn8csQYFR22ViuyFeIiQikRhwTiCqX4N/Q2WRj1AgAA
X-CFilter-Loop: Reflected

On Fri, Jul 18, 2025 at 01:42:38AM +0800, kernel test robot wrote:
> Hi Byungchul,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on c65d34296b2252897e37835d6007bbd01b255742]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/netmem-introduce-struct-netmem_desc-mirroring-struct-page/20250717-150253
> base:   c65d34296b2252897e37835d6007bbd01b255742
> patch link:    https://lore.kernel.org/r/20250717070052.6358-13-byungchul%40sk.com
> patch subject: [Intel-wired-lan] [PATCH net-next v11 12/12] libeth: xdp: access ->pp through netmem_desc instead of page
> config: arm-randconfig-r072-20250717 (https://download.01.org/0day-ci/archive/20250718/202507180111.jygqJHzk-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250718/202507180111.jygqJHzk-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507180111.jygqJHzk-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/container_of.h:5,
>                     from include/linux/list.h:5,
>                     from include/linux/timer.h:5,
>                     from include/linux/netdevice.h:24,
>                     from include/trace/events/xdp.h:8,
>                     from include/linux/bpf_trace.h:5,
>                     from include/net/libeth/xdp.h:7,
>                     from drivers/net/ethernet/intel/libeth/tx.c:6:
>    include/net/libeth/xdp.h: In function 'libeth_xdp_prepare_buff':
> >> include/net/libeth/xdp.h:1295:23: warning: passing argument 1 of 'page_pool_page_is_pp' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>         pp_page_to_nmdesc(page)->pp->p.offset, len, true);
>                           ^~~~
>    include/linux/build_bug.h:30:63: note: in definition of macro 'BUILD_BUG_ON_INVALID'
>     #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
>                                                                   ^
>    include/net/netmem.h:301:2: note: in expansion of macro 'DEBUG_NET_WARN_ON_ONCE'
>      DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));  \
>      ^~~~~~~~~~~~~~~~~~~~~~
>    include/net/libeth/xdp.h:1295:5: note: in expansion of macro 'pp_page_to_nmdesc'
>         pp_page_to_nmdesc(page)->pp->p.offset, len, true);
>         ^~~~~~~~~~~~~~~~~
>    In file included from arch/arm/include/asm/cacheflush.h:10,
>                     from include/linux/cacheflush.h:5,
>                     from include/linux/highmem.h:8,
>                     from include/linux/bvec.h:10,
>                     from include/linux/skbuff.h:17,
>                     from include/net/net_namespace.h:43,
>                     from include/linux/netdevice.h:38,
>                     from include/trace/events/xdp.h:8,
>                     from include/linux/bpf_trace.h:5,
>                     from include/net/libeth/xdp.h:7,
>                     from drivers/net/ethernet/intel/libeth/tx.c:6:
>    include/linux/mm.h:4176:54: note: expected 'struct page *' but argument is of type 'const struct page *'
>     static inline bool page_pool_page_is_pp(struct page *page)
>                                             ~~~~~~~~~~~~~^~~~

Oh.  page_pool_page_is_pp() in the mainline code already has this issue
that the helper cannot take const struct page * as argument.

How should we resolve the issue?  Changing page_pool_page_is_pp() to
macro and using _Generic again looks too much.  Or should we?  Any idea?

	Byungchul

> vim +1295 include/net/libeth/xdp.h
> 
>   1263
>   1264  bool libeth_xdp_buff_add_frag(struct libeth_xdp_buff *xdp,
>   1265                                const struct libeth_fqe *fqe,
>   1266                                u32 len);
>   1267
>   1268  /**
>   1269   * libeth_xdp_prepare_buff - fill &libeth_xdp_buff with head FQE data
>   1270   * @xdp: XDP buffer to attach the head to
>   1271   * @fqe: FQE containing the head buffer
>   1272   * @len: buffer len passed from HW
>   1273   *
>   1274   * Internal, use libeth_xdp_process_buff() instead. Initializes XDP buffer
>   1275   * head with the Rx buffer data: data pointer, length, headroom, and
>   1276   * truesize/tailroom. Zeroes the flags.
>   1277   * Uses faster single u64 write instead of per-field access.
>   1278   */
>   1279  static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
>   1280                                             const struct libeth_fqe *fqe,
>   1281                                             u32 len)
>   1282  {
>   1283          const struct page *page = __netmem_to_page(fqe->netmem);
>   1284
>   1285  #ifdef __LIBETH_WORD_ACCESS
>   1286          static_assert(offsetofend(typeof(xdp->base), flags) -
>   1287                        offsetof(typeof(xdp->base), frame_sz) ==
>   1288                        sizeof(u64));
>   1289
>   1290          *(u64 *)&xdp->base.frame_sz = fqe->truesize;
>   1291  #else
>   1292          xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
>   1293  #endif
>   1294          xdp_prepare_buff(&xdp->base, page_address(page) + fqe->offset,
> > 1295                           pp_page_to_nmdesc(page)->pp->p.offset, len, true);
>   1296  }
>   1297
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

