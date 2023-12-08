Return-Path: <bpf+bounces-17212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8647780AB46
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDDE1F21237
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5DD40C1D;
	Fri,  8 Dec 2023 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmWx+1DB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFFF10EB;
	Fri,  8 Dec 2023 09:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702058058; x=1733594058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hGP20Fj9RNd2d6KFOCQyWiyd1zHagCpSAXCFiExoAS0=;
  b=SmWx+1DBV734tv9mto6g2WjyjyQCdPIoo2WOAof3WjdI0wmHGx2QpGII
   RgrIklrufjIqHEPyYObyCvU+N1Pd/KirLpWzN88HCBzMSMOL0OJI0Quzo
   vSnuobQ+Wyqdq+Am1x3U6OCoSmSphhtF+BFl3VQoHEgxd0SjaR4AJrs2Y
   rYTjFTuicygiXn4lwlR5q7pRSXOsRH9o8ut09gZMbFXSehWONNosy5/vC
   iBxzFloCB3uUKi8wbLSeQzoYQqMqPNB4gA3OiwW+4+1BpOYx57k6znQrq
   qWJk/51O1XMLXPsCHkSzQMqcLFABh1jqaYVpH+y2Be8Ll2Ya7Tio3v+4i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="13138167"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="13138167"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="890203486"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="890203486"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2023 09:54:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBf3D-000E9B-3B;
	Fri, 08 Dec 2023 17:54:11 +0000
Date: Sat, 9 Dec 2023 01:53:40 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, echaudro@redhat.com,
	lorenzo@kernel.org
Subject: Re: [PATCH bpf 2/3] net: fix usage of multi-buffer BPF helper for ZC
 AF_XDP
Message-ID: <202312090113.kESWoklw-lkp@intel.com>
References: <20231208112945.313687-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208112945.313687-3-maciej.fijalkowski@intel.com>

Hi Maciej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/xsk-recycle-buffer-in-case-Rx-queue-was-full/20231208-193306
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20231208112945.313687-3-maciej.fijalkowski%40intel.com
patch subject: [PATCH bpf 2/3] net: fix usage of multi-buffer BPF helper for ZC AF_XDP
config: i386-randconfig-014-20231208 (https://download.01.org/0day-ci/archive/20231209/202312090113.kESWoklw-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312090113.kESWoklw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312090113.kESWoklw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/filter.c: In function '__shrink_data':
   net/core/filter.c:4102:3: error: implicit declaration of function 'xsk_buff_get_tail'; did you mean 'xsk_buff_get_frag'? [-Werror=implicit-function-declaration]
    4102 |   xsk_buff_get_tail(xdp)->data_end -= shrink;
         |   ^~~~~~~~~~~~~~~~~
         |   xsk_buff_get_frag
   net/core/filter.c:4102:25: error: invalid type argument of '->' (have 'int')
    4102 |   xsk_buff_get_tail(xdp)->data_end -= shrink;
         |                         ^~
   net/core/filter.c: In function 'shrink_data':
>> net/core/filter.c:4115:12: warning: assignment to 'struct xdp_buff *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    4115 |    zc_frag = xsk_buff_get_tail(xdp);
         |            ^
   net/core/filter.c:4117:4: error: implicit declaration of function 'xsk_buff_tail_del'; did you mean 'xsk_buff_alloc'? [-Werror=implicit-function-declaration]
    4117 |    xsk_buff_tail_del(zc_frag);
         |    ^~~~~~~~~~~~~~~~~
         |    xsk_buff_alloc
   cc1: some warnings being treated as errors


vim +4115 net/core/filter.c

  4097	
  4098	static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
  4099				  skb_frag_t *frag, int shrink)
  4100	{
  4101		if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL)
> 4102			xsk_buff_get_tail(xdp)->data_end -= shrink;
  4103		skb_frag_size_sub(frag, shrink);
  4104	}
  4105	
  4106	static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)
  4107	{
  4108		struct xdp_mem_info *mem_info = &xdp->rxq->mem;
  4109	
  4110		if (skb_frag_size(frag) == shrink) {
  4111			struct page *page = skb_frag_page(frag);
  4112			struct xdp_buff *zc_frag = NULL;
  4113	
  4114			if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> 4115				zc_frag = xsk_buff_get_tail(xdp);
  4116				xdp_buff_clear_frags_flag(zc_frag);
  4117				xsk_buff_tail_del(zc_frag);
  4118			}
  4119	
  4120			__xdp_return(page_address(page), mem_info, false, zc_frag);
  4121			return true;
  4122		}
  4123		__shrink_data(xdp, mem_info, frag, shrink);
  4124		return false;
  4125	}
  4126	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

