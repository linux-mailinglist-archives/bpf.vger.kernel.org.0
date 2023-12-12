Return-Path: <bpf+bounces-17606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD61080FB14
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0962B1C20DCA
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEDD64717;
	Tue, 12 Dec 2023 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jpv3krVS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CACAAA;
	Tue, 12 Dec 2023 15:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422676; x=1733958676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kd4RqJif4k/V976t9s7NhBzcyfdHKz5t8C7L6lzC9BM=;
  b=Jpv3krVS9bTnlrKW6VCDi1zd0HC8FD9GPLsq9FeIXM4pw/FN/3xCuvjl
   lrGUpsVeMXRuKNf/vFsVIZV+HTc9HzqWaW+7xcnShUX3D2umu25bz7xHq
   ltFlHrJPyaTC+wiZPgjOuqEnq7nyuBovBZzEN7OW/FupY6Nn+CCgcTLzD
   S87bnCSBatuh8bojCHPL6tu+0tK/coFjgMmk7IuLvOw9X2M4gEYKbNcUX
   ODyH3mcBQ9ivvwslh4glP/WbxLHHgEDWYIsYJ89DEQKOwDVOU5ZuNQkIA
   DHfFOZ1wxvNSVTPv4SSxJJtKC6avJ9Q+Bxjg35+bN4gIz0cTJqr9rwGXG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="426007631"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="426007631"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:11:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="766990162"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="766990162"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2023 15:11:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDBu9-000JqF-17;
	Tue, 12 Dec 2023 23:11:09 +0000
Date: Wed, 13 Dec 2023 07:10:51 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, hawk@kernel.org,
	toke@redhat.com, willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com, sdf@google.com
Subject: Re: [PATCH v4 net-next 3/3] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <202312130625.4PfR5846-lkp@intel.com>
References: <2d0f9388c6509192d88e359a402517a73124b50e.1702375338.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d0f9388c6509192d88e359a402517a73124b50e.1702375338.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/net-introduce-page_pool-pointer-in-softnet_data-percpu-struct/20231212-181103
base:   net-next/main
patch link:    https://lore.kernel.org/r/2d0f9388c6509192d88e359a402517a73124b50e.1702375338.git.lorenzo%40kernel.org
patch subject: [PATCH v4 net-next 3/3] xdp: add multi-buff support for xdp running in generic mode
config: sh-edosk7760_defconfig (https://download.01.org/0day-ci/archive/20231213/202312130625.4PfR5846-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312130625.4PfR5846-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130625.4PfR5846-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: net/core/dev.o: in function `netif_skb_segment_for_xdp':
>> net/core/dev.c:5003:(.text+0x2860): undefined reference to `page_pool_alloc_frag'
>> sh4-linux-ld: net/core/dev.c:5003:(.text+0x28fc): undefined reference to `page_pool_alloc_pages'
   sh4-linux-ld: net/core/dev.o: in function `net_dev_init':
   net/core/dev.c:11882:(.init.text+0x198): undefined reference to `page_pool_create'


vim +5003 net/core/dev.c

  4932	
  4933	static int netif_skb_segment_for_xdp(struct sk_buff **pskb)
  4934	{
  4935		struct softnet_data *sd = this_cpu_ptr(&softnet_data);
  4936		u32 size, truesize, len, max_head_size, off;
  4937		struct sk_buff *skb = *pskb, *nskb;
  4938		int err, i, head_off;
  4939		void *data;
  4940	
  4941		max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - XDP_PACKET_HEADROOM);
  4942		if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
  4943			return -ENOMEM;
  4944	
  4945		size = min_t(u32, skb->len, max_head_size);
  4946		truesize = SKB_HEAD_ALIGN(size) + XDP_PACKET_HEADROOM;
  4947		data = page_pool_dev_alloc_va(sd->page_pool, &truesize);
  4948		if (!data)
  4949			return -ENOMEM;
  4950	
  4951		nskb = napi_build_skb(data, truesize);
  4952		if (!nskb) {
  4953			page_pool_free_va(sd->page_pool, data, true);
  4954			return -ENOMEM;
  4955		}
  4956	
  4957		skb_reserve(nskb, XDP_PACKET_HEADROOM);
  4958		skb_copy_header(nskb, skb);
  4959		skb_mark_for_recycle(nskb);
  4960	
  4961		err = skb_copy_bits(skb, 0, nskb->data, size);
  4962		if (err) {
  4963			consume_skb(nskb);
  4964			return err;
  4965		}
  4966		skb_put(nskb, size);
  4967	
  4968		head_off = skb_headroom(nskb) - skb_headroom(skb);
  4969		skb_headers_offset_update(nskb, head_off);
  4970	
  4971		off = size;
  4972		len = skb->len - off;
  4973		for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
  4974			struct page *page;
  4975			u32 page_off;
  4976	
  4977			size = min_t(u32, len, PAGE_SIZE);
  4978			truesize = size;
  4979	
  4980			page = page_pool_dev_alloc(sd->page_pool, &page_off,
  4981						   &truesize);
  4982			if (!data) {
  4983				consume_skb(nskb);
  4984				return -ENOMEM;
  4985			}
  4986	
  4987			skb_add_rx_frag(nskb, i, page, page_off, size, truesize);
  4988			err = skb_copy_bits(skb, off, page_address(page) + page_off,
  4989					    size);
  4990			if (err) {
  4991				consume_skb(nskb);
  4992				return err;
  4993			}
  4994	
  4995			len -= size;
  4996			off += size;
  4997		}
  4998	
  4999		consume_skb(skb);
  5000		*pskb = nskb;
  5001	
  5002		return 0;
> 5003	}
  5004	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

