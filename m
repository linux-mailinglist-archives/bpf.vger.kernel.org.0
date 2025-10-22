Return-Path: <bpf+bounces-71751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1991EBFCB9A
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08AF1891E95
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B49280318;
	Wed, 22 Oct 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDKAUvYS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BBD342151;
	Wed, 22 Oct 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145006; cv=none; b=A32VapSm/vNPySuCdlyqFnw+49EpHDnOhHULd92LNT6/f6nLmyG0c/WB5RGgOtrzFrHYuMfUOl7e/47QbhCKpn4Cbr1OjWwRFIIqAa1yT6ElfyYetGy5z0O9b2N9Dhk9hA5cnEn/9nsucheJA4UkaHeD41wL+3YSh0LL+8iP5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145006; c=relaxed/simple;
	bh=f+Zhm8dYGc3fdkPfymIVc9xO+TABLwXVW7BSUFDM0Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk+rEFXQTnyj3MyqXIlF1nDZYYPaN8ZDy9yGbTkThLVYP5a/4wlsTrusnOtGc0vFNDOM33kXYiWcHzd44iZdFstdjKd+mmXzxCAGGsQL9aYj9a171V/Mnp11CSEw8GT4Efwt6wvvJIcRFOMpQuIyLxjiFUmViLlhpKafB2ZbyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDKAUvYS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761145004; x=1792681004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f+Zhm8dYGc3fdkPfymIVc9xO+TABLwXVW7BSUFDM0Qk=;
  b=FDKAUvYSzVBqR67jMAVDTxtSWJORmEJ3qmkK5Ml2KJmGWMjJ6Uy6a631
   8jR6QAhGxP0WAAsKcrAt3nFDhfBWnV6Ef/V3zjZ+AjFQijJqjdyYBzTzf
   ur8llVOB58mXInL/oMoUG7lcVXxuQgswUrbPBvLH1LgXNYgh2kuaSQ6Kv
   M60Js89PxLKr9M/Uson14Xh/Bswb6qBRy/qugBxGxduyMPicobEMnZgNr
   8vjL8sRnkIvTAJgFtSqtwrVA0t1+rkIyAmaEHsUr1wPsrDY1ZnlTwzap5
   GAFv2iF0QbhnMa8+1hiJ8Dq6nhh2QwP19hpmDRbmTIlb6ReNU366sHVYN
   Q==;
X-CSE-ConnectionGUID: SgaWE2SsSguQlmPucR2nOg==
X-CSE-MsgGUID: BqHse7+sQFu6SVYyrZXn/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73965598"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="73965598"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 07:56:44 -0700
X-CSE-ConnectionGUID: afcYus0FRve/MmqhQSFGDg==
X-CSE-MsgGUID: FESkkNLVTiCki2zrc+sYBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="214541379"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 22 Oct 2025 07:56:40 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBaFo-000CRX-1Q;
	Wed, 22 Oct 2025 14:56:07 +0000
Date: Wed, 22 Oct 2025 22:53:38 +0800
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
Message-ID: <202510222254.hbsPvf4c-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/xdp-introduce-xdp_convert_skb_to_buff/20251022-210958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20251022125209.2649287-2-maciej.fijalkowski%40intel.com
patch subject: [PATCH v3 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
config: i386-buildonly-randconfig-003-20251022 (https://download.01.org/0day-ci/archive/20251022/202510222254.hbsPvf4c-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510222254.hbsPvf4c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510222254.hbsPvf4c-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/net/busy_poll.h:19,
                    from io_uring/napi.h:8,
                    from io_uring/io_uring.c:97:
   include/net/xdp.h: In function 'xdp_convert_skb_to_buff':
>> include/net/xdp.h:398:17: error: assignment to 'u32' {aka 'unsigned int'} from 'sk_buff_data_t' {aka 'unsigned char *'} makes integer from pointer without a cast [-Wint-conversion]
     398 |         pkt_len =  skb->tail - skb->mac_header;
         |                 ^


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

