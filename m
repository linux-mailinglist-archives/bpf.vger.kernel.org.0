Return-Path: <bpf+bounces-50758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB11A2C1C1
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 12:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6653AA2BA
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6381DEFCC;
	Fri,  7 Feb 2025 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+3Ktxd6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA31A83F5;
	Fri,  7 Feb 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928463; cv=none; b=bNCCMwe1A72NwymtWQbe11shwXJom0/lWs4w2n5KU6EeATZBEWmlngNW4zgDjdCyNk591MxZpUt+MAADF7eqv74X/cue+bTxt45koaKdAUEyTs7aFnqdkT6zHnK03iqS5+HOPUeSjx6Lq+ppNSXUk4wTl4bEj0u4PHywRL2601I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928463; c=relaxed/simple;
	bh=Kr3VE9NUyZO8hS9QqWqW3tBkPoYkI+NxTJxvWVkvBkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=At1e8l77Um540pNmXO/N7Cmqouy3khTM+ruvgy8iCGnWXpX/MNmAFw2SeMzK0FO6uF7O5qYh4hVQ3IjtKG1PPZmmKp8I+ovCdXeQmpkukspqxnFD9vy9FX5Ra0a44It/6RITWcAIpkGFU8DPS0/Ilsfz2eiwKpcCyAO/2B2abAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+3Ktxd6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738928462; x=1770464462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kr3VE9NUyZO8hS9QqWqW3tBkPoYkI+NxTJxvWVkvBkA=;
  b=E+3Ktxd6ld7bk0PZqL1XlsaV/l1FDW/wJDBjvjip+lY7m4mjNZ4TQL8B
   Cytb2XuwFlUqkMrPS35M9H8fngyL5cNNew2EonMHjeCzfBtsmtqz56kwe
   JFakJ5Nl2OH4aK/Fz4lfz0iC6w+LWnw5PtHMdL3xZOPn00V3w0yYqoj7z
   rauFCMQ3UdWUcmpf51GcJKG4XsxX16z4tDZCrdI8h3yiFDodBCM15EXxS
   d5M61J02J+jbenrBJssgW3cbrF8GgOHsbYO6AkUkpaSs63918KQrYpd5V
   T7S/4U85c7PJJ9jEFd3J6CPGrcpoD6Xr6wSkhSpkiHk+/WVmjRQZL5Zss
   A==;
X-CSE-ConnectionGUID: a5Z5cfmsQSCal/R5udKozw==
X-CSE-MsgGUID: Jef3ZS/KQCK3lujza3IRSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50204716"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="50204716"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 03:41:01 -0800
X-CSE-ConnectionGUID: KPH5yCU9QtuhzEinvrTVsw==
X-CSE-MsgGUID: LxkwO1UyTTKjfONVxwkKqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="111290324"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 Feb 2025 03:40:56 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgMj6-000yF9-36;
	Fri, 07 Feb 2025 11:40:52 +0000
Date: Fri, 7 Feb 2025 19:40:10 +0800
From: kernel test robot <lkp@intel.com>
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
	hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, larysa.zaremba@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Suman Ghosh <sumang@marvell.com>
Subject: Re: [net-next PATCH v5 6/6] octeontx2-pf: AF_XDP zero copy transmit
 support
Message-ID: <202502071925.3T93J9MM-lkp@intel.com>
References: <20250206085034.1978172-7-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206085034.1978172-7-sumang@marvell.com>

Hi Suman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Suman-Ghosh/octeontx2-pf-use-xdp_return_frame-to-free-xdp-buffers/20250206-165634
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250206085034.1978172-7-sumang%40marvell.com
patch subject: [net-next PATCH v5 6/6] octeontx2-pf: AF_XDP zero copy transmit support
config: x86_64-buildonly-randconfig-006-20250207 (https://download.01.org/0day-ci/archive/20250207/202502071925.3T93J9MM-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250207/202502071925.3T93J9MM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502071925.3T93J9MM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:112:6: warning: variable 'iova' set but not used [-Wunused-but-set-variable]
     112 |         u64 iova;
         |             ^
   1 warning generated.


vim +/iova +112 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c

   104	
   105	static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
   106					     struct otx2_snd_queue *sq,
   107					     struct nix_cqe_tx_s *cqe,
   108					     int *xsk_frames)
   109	{
   110		struct nix_send_comp_s *snd_comp = &cqe->comp;
   111		struct sg_list *sg;
 > 112		u64 iova;
   113	
   114		sg = &sq->sg[snd_comp->sqe_id];
   115	
   116		if (sg->flags & OTX2_AF_XDP_FRAME) {
   117			(*xsk_frames)++;
   118			return;
   119		}
   120	
   121		iova = sg->dma_addr[0];
   122		if (sg->flags & OTX2_XDP_REDIRECT)
   123			otx2_dma_unmap_page(pfvf, sg->dma_addr[0], sg->size[0], DMA_TO_DEVICE);
   124		xdp_return_frame((struct xdp_frame *)sg->skb);
   125		sg->skb = (u64)NULL;
   126	}
   127	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

