Return-Path: <bpf+bounces-71668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA838BFA0C5
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 07:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE90401A17
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 05:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6498F2E8B7C;
	Wed, 22 Oct 2025 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kL47dD2C"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9A2E8B79;
	Wed, 22 Oct 2025 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761110619; cv=none; b=Llxv/NOcxiD/+6rklsW4/nlCa5fsrly1gHrdmVZ+6xrLiRLb9Ie77kd3dK8saP2QqOyxwcRIkcfxKpJu7DNWPGqt69mZUhuYINHDr8jkQM7bwBTDjH94cq/Sh5pusB5jnhb190qHdLJWEo/q+N5fYtY7XLzVrHenvaBdWqpjbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761110619; c=relaxed/simple;
	bh=IKsOux+oTKRhG9nhvHDUaZW+YWofmlYM+IARQXs21ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYEhTQeJ3HyJaRU5U9upzoPLy/u2NcwL6yF+wdAfaWlWdQD0FRjOzGH4jW6qu7U429H+XbvcNMNzqrz2xswaTxOXR0/eQiodsgwQY2pXodNxqEsVe1MEhHHukkuSYyPDyPnZUBZONoAIDMB3wCJzNY6iUMmfjY6zxS+nOeIFgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kL47dD2C; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761110619; x=1792646619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IKsOux+oTKRhG9nhvHDUaZW+YWofmlYM+IARQXs21ZQ=;
  b=kL47dD2CxM0FbzU/pDs9xVmzhlM0VtkFQgfnxpcQ8Tvr0m2zcaz7EQqY
   HnmKxnsDo66QRXN5rz08u9qABd3kJFNleHWDKcujIiDRW+QYonCUQeQUf
   gDcOMBnLysqyMm+kKkLEzzC7BYuTKIAxOrUQ40CtCUCR+i3eV6Q6KWxnq
   nZL/PxZxyRxMAXXyYBXkdb/NlV5jz/jUfkD9g72Oqht9Zc8ir7L2i+X1N
   aspeaRRW7Ghra5y60+fmULJ/DuBHzuP0wizjfx66d0XOqISpj/mVp4CZ5
   gsnxrKFVlcSHdom72ao3dyikIi/XzhUP/gb/+9cJZvKRTn/VprHRndjbw
   w==;
X-CSE-ConnectionGUID: Et5OTiwNSo2qD73AlvporQ==
X-CSE-MsgGUID: cVxuKlm4T7Wf2Js+XjpsHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85872228"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="85872228"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 22:23:38 -0700
X-CSE-ConnectionGUID: wr7p2DKAS3Wc+XBIss1Luw==
X-CSE-MsgGUID: kDneEjmIQg+2AHHW/9pHxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183715493"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 21 Oct 2025 22:23:35 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBRJs-000C1B-2x;
	Wed, 22 Oct 2025 05:23:32 +0000
Date: Wed, 22 Oct 2025 13:23:06 +0800
From: kernel test robot <lkp@intel.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, csmate@nop.hu,
	kerneljasonxing@gmail.com, maciej.fijalkowski@intel.com,
	bjorn@kernel.org, sdf@fomichev.me, jonathan.lemon@gmail.com,
	bpf@vger.kernel.org, Fernando Fernandez Mancera <fmancera@suse.de>
Subject: Re: [PATCH net] xsk: avoid data corruption on cq descriptor number
Message-ID: <202510221337.KR7g9eX0-lkp@intel.com>
References: <20251021150656.6704-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021150656.6704-1-fmancera@suse.de>

Hi Fernando,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Fernando-Fernandez-Mancera/xsk-avoid-data-corruption-on-cq-descriptor-number/20251021-231144
base:   net/main
patch link:    https://lore.kernel.org/r/20251021150656.6704-1-fmancera%40suse.de
patch subject: [PATCH net] xsk: avoid data corruption on cq descriptor number
config: x86_64-buildonly-randconfig-001-20251022 (https://download.01.org/0day-ci/archive/20251022/202510221337.KR7g9eX0-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510221337.KR7g9eX0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510221337.KR7g9eX0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/xdp/xsk.c:815:17: warning: variable 'page' is uninitialized when used here [-Wuninitialized]
     815 |                                 __free_page(page);
         |                                             ^~~~
   include/linux/gfp.h:385:41: note: expanded from macro '__free_page'
     385 | #define __free_page(page) __free_pages((page), 0)
         |                                         ^~~~
   net/xdp/xsk.c:780:19: note: initialize the variable 'page' to silence this warning
     780 |         struct page *page;
         |                          ^
         |                           = NULL
   1 warning generated.


vim +/page +815 net/xdp/xsk.c

   774	
   775	static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
   776					     struct xdp_desc *desc)
   777	{
   778		struct net_device *dev = xs->dev;
   779		struct sk_buff *skb = xs->skb;
   780		struct page *page;
   781		int err;
   782	
   783		if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
   784			skb = xsk_build_skb_zerocopy(xs, desc);
   785			if (IS_ERR(skb)) {
   786				err = PTR_ERR(skb);
   787				skb = NULL;
   788				goto free_err;
   789			}
   790		} else {
   791			u32 hr, tr, len;
   792			void *buffer;
   793	
   794			buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
   795			len = desc->len;
   796	
   797			if (!skb) {
   798				struct xsk_addr_node *head_addr;
   799	
   800				hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
   801				tr = dev->needed_tailroom;
   802				skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
   803				if (unlikely(!skb))
   804					goto free_err;
   805	
   806				skb_reserve(skb, hr);
   807				skb_put(skb, len);
   808	
   809				err = skb_store_bits(skb, 0, buffer, len);
   810				if (unlikely(err))
   811					goto free_err;
   812	
   813				head_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
   814				if (!head_addr) {
 > 815					__free_page(page);
   816					err = -ENOMEM;
   817					goto free_err;
   818				}
   819				xsk_skb_init_misc(skb, xs, head_addr, desc->addr);
   820				if (desc->options & XDP_TX_METADATA) {
   821					err = xsk_skb_metadata(skb, buffer, desc,
   822							       xs->pool, hr);
   823					if (unlikely(err))
   824						goto free_err;
   825				}
   826			} else {
   827				int nr_frags = skb_shinfo(skb)->nr_frags;
   828				struct xsk_addr_node *xsk_addr;
   829				u8 *vaddr;
   830	
   831				if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
   832					err = -EOVERFLOW;
   833					goto free_err;
   834				}
   835	
   836				page = alloc_page(xs->sk.sk_allocation);
   837				if (unlikely(!page)) {
   838					err = -EAGAIN;
   839					goto free_err;
   840				}
   841	
   842				xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
   843				if (!xsk_addr) {
   844					__free_page(page);
   845					err = -ENOMEM;
   846					goto free_err;
   847				}
   848	
   849				vaddr = kmap_local_page(page);
   850				memcpy(vaddr, buffer, len);
   851				kunmap_local(vaddr);
   852	
   853				skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
   854				refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
   855	
   856				xsk_addr->addr = desc->addr;
   857				list_add_tail(&xsk_addr->addr_node, &XSK_TX_HEAD(skb)->addr_node);
   858			}
   859		}
   860	
   861		xsk_inc_num_desc(skb);
   862	
   863		return skb;
   864	
   865	free_err:
   866		if (skb && !skb_shinfo(skb)->nr_frags)
   867			kfree_skb(skb);
   868	
   869		if (err == -EOVERFLOW) {
   870			/* Drop the packet */
   871			xsk_inc_num_desc(xs->skb);
   872			xsk_drop_skb(xs->skb);
   873			xskq_cons_release(xs->tx);
   874		} else {
   875			/* Let application retry */
   876			xsk_cq_cancel_locked(xs->pool, 1);
   877		}
   878	
   879		return ERR_PTR(err);
   880	}
   881	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

