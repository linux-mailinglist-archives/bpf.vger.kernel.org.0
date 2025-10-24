Return-Path: <bpf+bounces-72003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA8CC05031
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 10:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7443408223
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 08:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8FD2FDC5D;
	Fri, 24 Oct 2025 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivwmwOoU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5395C2FDC44;
	Fri, 24 Oct 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293286; cv=none; b=pla9ynO2FI2mJmwnC0wIeSVDrjtV0AvM/aVUFGd/JPoHc32D4/nxpcqECG89BshAPnBk95RtPNKRXz39B2Yryl+zZYjjmrLRqWeusXdT5IvYK/wE1+Y31naI6QpsDpcmUcDvlMigFWFtMJrNKSFJhlWQOSj+oBO3WgVfkvckgu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293286; c=relaxed/simple;
	bh=UTt/Q0XaE240mGhbyc0GBR+vGT+S8mXRNkiX+CKXR2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjxIeiI5OkcABR3xgVcbPGDsLcPF2liKgshEIOK/sxNHDttgn/XtPEUWqMjuembZpgelvmginvULQHr26yNFM0OJxTWC4Y9jBoyd0IePhr0aSQA9ExDYcMgrrNAIHGsqeSYrNCMemZV2GDsXGHnCqm8CKsEOh24R6svYDhUmiCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivwmwOoU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761293284; x=1792829284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTt/Q0XaE240mGhbyc0GBR+vGT+S8mXRNkiX+CKXR2g=;
  b=ivwmwOoU9Bd/cH4Wf+HuCtuJGRkesBmqZwiIy2UQgfGPPy8+6r+YtrlX
   iNlXfqntenWLEPbywW5OxklGbeZwntSbWf3WocDLF+FbzIPU8qokMsdAO
   8acOSeG37kdJFpoCP7c6hQaUUvGhctXia9RuXk/q0V+vOUYWwxsq7QjfB
   CsDaI8FkUvfqxinxlnOQpI7DPVjg3jy1yH2iJp20blbwCgzzGN6NsiTDP
   LTPg5hT3JLiGLxQm+g+1YEK9kyyZQ0kzlTji7b8zZX6KtCrgGbhDwGLgh
   eVYnH9gzkwS1Cg5alp9txDqbW3QJqnvC8ETnPlfTpD0Tmr+nxz2J/fJkb
   Q==;
X-CSE-ConnectionGUID: /4TprjiHTwGvQ/kc6GCxoQ==
X-CSE-MsgGUID: v9ejTz52TDqDF/FNxhp66Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63620713"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="63620713"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 01:08:03 -0700
X-CSE-ConnectionGUID: cCFN/iBWRGahFx9FoHfx9Q==
X-CSE-MsgGUID: zqkBOcvTQa22Dhk4feXAcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="184441717"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 24 Oct 2025 01:08:00 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCCq5-000EJv-16;
	Fri, 24 Oct 2025 08:07:57 +0000
Date: Fri, 24 Oct 2025 16:07:43 +0800
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
Message-ID: <202510241549.mWZqm0BR-lkp@intel.com>
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
config: sh-randconfig-r111-20251024 (https://download.01.org/0day-ci/archive/20251024/202510241549.mWZqm0BR-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510241549.mWZqm0BR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510241549.mWZqm0BR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/dev.c:4164:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
   net/core/dev.c:5188:9: sparse: sparse: context imbalance in 'kick_defer_list_purge' - different lock contexts for basic block
   net/core/dev.c:5290:22: sparse: sparse: context imbalance in 'enqueue_to_backlog' - different lock contexts for basic block
   net/core/dev.c: note: in included file (through include/trace/events/xdp.h, include/linux/bpf_trace.h):
>> include/net/xdp.h:398:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] pkt_len @@     got unsigned char * @@
   include/net/xdp.h:398:17: sparse:     expected unsigned int [usertype] pkt_len
   include/net/xdp.h:398:17: sparse:     got unsigned char *
   net/core/dev.c:5678:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block
   net/core/dev.c:6373:9: sparse: sparse: context imbalance in 'flush_backlog' - different lock contexts for basic block
   net/core/dev.c:6520:9: sparse: sparse: context imbalance in 'process_backlog' - different lock contexts for basic block

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

