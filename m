Return-Path: <bpf+bounces-67247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828C2B41253
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 04:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6223A3781
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F81F2222A7;
	Wed,  3 Sep 2025 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apuNg1dw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9012CD8B;
	Wed,  3 Sep 2025 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866592; cv=none; b=osIvC9BvHZl82I11ycOheOJihqF0aipVCf7UGLlKfhM7ATo8mvhRJbR7lDqzJIMJgzRZR2Hd9i8lPV+n3rOMNTgZ8gRhdNiqbCAkPdYDpbjQD3drKWrkcjJOVSaulsTyDaLAJ5792/vHXI0i2YjTvVbGnp5z4019zj0Uwa10lK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866592; c=relaxed/simple;
	bh=cMJk8XDura2jwFwIq4nHCXtOUCFn9WeInWpuFuAjFoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpMc6epYHAj/UObxb1+7XEn8oI5V8II10D1hLELl6stwZ8OUA1X7g+fvgyVdR43K/bbPkcBi7wZ49yYFlm7m50Hua4tVK84Qkc91JWQVeJcUbtIC2MCnl/jWnpqEKj45hBL5TnWdHFFbCwMUOXAQ8A+RNHdBdjenhah+eujMZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apuNg1dw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866592; x=1788402592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cMJk8XDura2jwFwIq4nHCXtOUCFn9WeInWpuFuAjFoo=;
  b=apuNg1dwmNIMHPzPBihNt5AUJh7gOmXoE/AIv/+xIIdMV0I4kIdP40X7
   GYRSg1sjEWMtloNlZKbFkM8PQEjJzkTTTAIm6QHOBQca+2+Qycwhy0C9k
   PKHle2euRj3uGppO0oS14bsbkbTO/8Pp6IRm3Pj8qHiB0t4xaBJZ355GF
   TGlPfpVDKh7oZXeQwx4yyvgr2fBjYDlh0tSa0saMu2blKXfXWTZmH5By+
   Gj3dUfWRnx08B39GNyL0ss9uBSTo+N658QFA/gecYGKeLfUqSVEz83gd2
   oUiTv+3V3ovc/zZl4SyFhbardopN5PCEdbCrkfoTSBEwBmdP/nx/Mft3W
   A==;
X-CSE-ConnectionGUID: s3LZP3xQTWKwJT1o3TNuig==
X-CSE-MsgGUID: llW/FfVLQrqlRoJv0O3fFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="70266549"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="70266549"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:29:51 -0700
X-CSE-ConnectionGUID: tr3x36N2T8SX9nfyKJSAtQ==
X-CSE-MsgGUID: 5QQI7eWbTfq4JbgdHWjfDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="175812902"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 02 Sep 2025 19:29:47 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utdFK-0003GR-06;
	Wed, 03 Sep 2025 02:29:19 +0000
Date: Wed, 3 Sep 2025 10:29:02 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, stfomichev@gmail.com,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Eryk Kubanski <e.kubanski@partner.samsung.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v8 bpf] xsk: fix immature cq descriptor production
Message-ID: <202509031029.iL7rCVvQ-lkp@intel.com>
References: <20250902220613.2331265-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902220613.2331265-1-maciej.fijalkowski@intel.com>

Hi Maciej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/xsk-fix-immature-cq-descriptor-production/20250903-060850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20250902220613.2331265-1-maciej.fijalkowski%40intel.com
patch subject: [PATCH v8 bpf] xsk: fix immature cq descriptor production
config: riscv-randconfig-001-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031029.iL7rCVvQ-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031029.iL7rCVvQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509031029.iL7rCVvQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/xdp/xsk.c: In function 'xsk_cq_submit_addr_locked':
>> net/xdp/xsk.c:572:38: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     xskq_prod_write_addr(pool->cq, idx, (u64)skb_shinfo(skb)->destructor_arg);
                                         ^
   net/xdp/xsk.c: In function 'xsk_set_destructor_arg':
>> net/xdp/xsk.c:625:36: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     skb_shinfo(skb)->destructor_arg = (void *)addr;
                                       ^


vim +572 net/xdp/xsk.c

   560	
   561	static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
   562					      struct sk_buff *skb)
   563	{
   564		struct xsk_addr_node *pos, *tmp;
   565		u32 descs_processed = 0;
   566		unsigned long flags;
   567		u32 idx;
   568	
   569		spin_lock_irqsave(&pool->cq_lock, flags);
   570		idx = xskq_get_prod(pool->cq);
   571	
 > 572		xskq_prod_write_addr(pool->cq, idx, (u64)skb_shinfo(skb)->destructor_arg);
   573		descs_processed++;
   574	
   575		if (unlikely(XSKCB(skb)->num_descs > 1)) {
   576			list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
   577				xskq_prod_write_addr(pool->cq, idx + descs_processed,
   578						     pos->addr);
   579				descs_processed++;
   580				list_del(&pos->addr_node);
   581				kmem_cache_free(xsk_tx_generic_cache, pos);
   582			}
   583		}
   584		xskq_prod_submit_n(pool->cq, descs_processed);
   585		spin_unlock_irqrestore(&pool->cq_lock, flags);
   586	}
   587	
   588	static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
   589	{
   590		unsigned long flags;
   591	
   592		spin_lock_irqsave(&pool->cq_lock, flags);
   593		xskq_prod_cancel_n(pool->cq, n);
   594		spin_unlock_irqrestore(&pool->cq_lock, flags);
   595	}
   596	
   597	static void xsk_inc_num_desc(struct sk_buff *skb)
   598	{
   599		XSKCB(skb)->num_descs++;
   600	}
   601	
   602	static u32 xsk_get_num_desc(struct sk_buff *skb)
   603	{
   604		return XSKCB(skb)->num_descs;
   605	}
   606	
   607	static void xsk_destruct_skb(struct sk_buff *skb)
   608	{
   609		struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
   610	
   611		if (compl->tx_timestamp) {
   612			/* sw completion timestamp, not a real one */
   613			*compl->tx_timestamp = ktime_get_tai_fast_ns();
   614		}
   615	
   616		xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
   617		sock_wfree(skb);
   618	}
   619	
   620	static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
   621	{
   622		BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
   623		INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
   624		XSKCB(skb)->num_descs = 0;
 > 625		skb_shinfo(skb)->destructor_arg = (void *)addr;
   626	}
   627	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

