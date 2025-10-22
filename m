Return-Path: <bpf+bounces-71752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE4BBFCBA3
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A15C1A051D9
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B3428031C;
	Wed, 22 Oct 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgJZni8B"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F3343D6E;
	Wed, 22 Oct 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145050; cv=none; b=DNBubgTA6yUjkZy3PPhE08Lr503i9xEPZ33KfxjdQ+ES7lLtnrf0bjWCXutqVDLpGSX/5y0wcjqWwzQpBID7IT7Z4hP8r3dPwoWvxxHF+YTqzME6zi7n0eZskPYaQJFFyrr0IxMYu2d+Ea2QTK8gFhyDHOHWTKtm3hZlNJTQX6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145050; c=relaxed/simple;
	bh=n87zvMOsc286lg161TVq0yPHuXq/y9ttdaxF3Plkanc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvsG7EaWUA+TbrEfBgeqYVq5T8xPwJkhcz5FQro1dI0GeCC9oVosCrtBOTOw1GDNDD3layx2TF+pWJc0GZK0Tr34fucwXacdQU8k1O7cE3/6a2ERex5Ayz7Evrk7hHvcbSJjxIqE5EfN64FmPdSOoVBaPCqzx33b+69BpI+Pb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgJZni8B; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761145049; x=1792681049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n87zvMOsc286lg161TVq0yPHuXq/y9ttdaxF3Plkanc=;
  b=YgJZni8Bg0YK/JRhPW2zPR5Te6xPlPmc7nz6rhoeVYyPGSKPDwEc3+iA
   n/0e9YsZ/njJMDroszakbnDoWbepFJxiVxLpCyhSTjHVg0qQhQPzpysyq
   izAsVsZYi0sutb5blVvWoG/zkVI08jShbSveuy33k6IP7EIKewDEs0ysW
   RXWYorCHi1g8/87I2quGN2F2EVj5rvfkiVwRlCYdjTKYZ1oOi+1AUmVpB
   AFWViI9oCjDr1WkhvzJJPO57fPsjOzkuChQFlAkstjegCBGy51Y4hSdDt
   g7nW04RjovErBxkllDIW6SOnXuIVYD9bihNVbe2smkFsE5fwqbZEDHhCx
   Q==;
X-CSE-ConnectionGUID: y9YQ+wekSmWztJ4RmFD3og==
X-CSE-MsgGUID: jGWfMu5FQ1ymd2DMxa9Z+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63203318"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="63203318"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 07:57:29 -0700
X-CSE-ConnectionGUID: D8R2wurISHWLVAtftmAYfw==
X-CSE-MsgGUID: 4wQEVxTbTPS6ZylEkMfTzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183482514"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 22 Oct 2025 07:57:21 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBaGT-000CRb-0z;
	Wed, 22 Oct 2025 14:56:55 +0000
Date: Wed, 22 Oct 2025 22:54:01 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org, toke@redhat.com, lorenzo@kernel.org,
	kuba@kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v3 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <202510222206.mGdKZo2R-lkp@intel.com>
References: <20251022125209.2649287-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022125209.2649287-2-maciej.fijalkowski@intel.com>

Hi Maciej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/xdp-introduce-xdp_convert_skb_to_buff/20251022-210958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20251022125209.2649287-2-maciej.fijalkowski%40intel.com
patch subject: [PATCH v3 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
config: arm-randconfig-002-20251022 (https://download.01.org/0day-ci/archive/20251022/202510222206.mGdKZo2R-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510222206.mGdKZo2R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510222206.mGdKZo2R-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/net/busy_poll.h:19,
                    from fs/select.c:33:
   include/net/xdp.h: In function 'xdp_convert_skb_to_buff':
>> include/net/xdp.h:398:10: warning: assignment to 'u32' {aka 'unsigned int'} from 'sk_buff_data_t' {aka 'unsigned char *'} makes integer from pointer without a cast [-Wint-conversion]
     398 |  pkt_len =  skb->tail - skb->mac_header;
         |          ^


vim +398 include/net/xdp.h

   386	
   387	static inline
   388	void xdp_convert_skb_to_buff(struct sk_buff *skb, struct xdp_buff *xdp,
   389				     struct xdp_rxq_info *xdp_rxq)
   390	{
   391		u32 frame_sz, pkt_len;
   392	
   393		/* SKB "head" area always have tailroom for skb_shared_info */
   394		frame_sz = skb_end_pointer(skb) - skb->head;
   395		frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
   396	
   397		DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));
 > 398		pkt_len =  skb->tail - skb->mac_header;
   399	
   400		xdp_init_buff(xdp, frame_sz, xdp_rxq);
   401		xdp_prepare_buff(xdp, skb->head, skb->mac_header, pkt_len, true);
   402	
   403		if (skb_is_nonlinear(skb)) {
   404			skb_shinfo(skb)->xdp_frags_size = skb->data_len;
   405			xdp_buff_set_frags_flag(xdp);
   406		} else {
   407			xdp_buff_clear_frags_flag(xdp);
   408		}
   409	
   410		xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_head_page(xdp->data)) ?
   411					MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
   412	}
   413	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

