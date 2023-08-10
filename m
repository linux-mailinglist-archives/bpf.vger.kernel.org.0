Return-Path: <bpf+bounces-7416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0051E776F8C
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 07:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384DF1C21365
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 05:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE091110;
	Thu, 10 Aug 2023 05:27:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1810FC;
	Thu, 10 Aug 2023 05:27:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A395E1704;
	Wed,  9 Aug 2023 22:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691645226; x=1723181226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lCVeWoMyQTxuqpGgn0HoLMkQF9mHo7uxDAG5FBN4KXo=;
  b=BqbAch1wZDKN1orpM5S051jND10beFvaWbkXfCnpzyztT8JXB6Vab5f1
   4Znx3wUROVydgHOsX0FYLI8eOb3gNFsiltdSvDROVdrCGcZdkZTTsF2OT
   cyD94hQmGx2eUkCaJJ2/fBnbTPfG8SLYMTzFl4/ggmAKSRTO8/hO/Chnm
   JyCwU0MQFVBxPEmdv2Qv9I3bXT5Cr8XbRHE8l3u4KntRC/9hthDb9qcli
   xJIseZz1yX/gPLjK2ro2LoHOyewf82EZjiZthfU3OjGZtqPdJezrFWbN/
   Jpwv2ykkY87trn8a07f9dZLmROTpnPkHZgvTqzWfe2mV33FPjuFA+EhDG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="356269948"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="356269948"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 22:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="708994353"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="708994353"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Aug 2023 22:27:00 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qTyCJ-0006kI-2Y;
	Thu, 10 Aug 2023 05:26:59 +0000
Date: Thu, 10 Aug 2023 13:26:49 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	kuba@kernel.org, toke@kernel.org, willemb@google.com,
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, hawk@kernel.org,
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next 2/9] xsk: add TX timestamp and TX checksum
 offload support
Message-ID: <202308101302.nwabzxuw-lkp@intel.com>
References: <20230809165418.2831456-3-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809165418.2831456-3-sdf@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/xsk-Support-XDP_TX_METADATA_LEN/20230810-010031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230809165418.2831456-3-sdf%40google.com
patch subject: [PATCH bpf-next 2/9] xsk: add TX timestamp and TX checksum offload support
config: arc-randconfig-r043-20230809 (https://download.01.org/0day-ci/archive/20230810/202308101302.nwabzxuw-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230810/202308101302.nwabzxuw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308101302.nwabzxuw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/net/xdp_sock_drv.h:10,
                    from net/ethtool/ioctl.c:31:
>> include/net/xsk_buff_pool.h:237:49: error: unknown type name 'xdp_buff_xsk'
     237 | static inline bool xp_tx_metadata_enabled(const xdp_buff_xsk *xskb)
         |                                                 ^~~~~~~~~~~~
   include/net/xsk_buff_pool.h: In function 'xp_tx_metadata_enabled':
>> include/net/xsk_buff_pool.h:239:16: error: 'sq' undeclared (first use in this function); did you mean 'rq'?
     239 |         return sq->xsk_pool->tx_metadata_len > 0;
         |                ^~
         |                rq
   include/net/xsk_buff_pool.h:239:16: note: each undeclared identifier is reported only once for each function it appears in


vim +/xdp_buff_xsk +237 include/net/xsk_buff_pool.h

   236	
 > 237	static inline bool xp_tx_metadata_enabled(const xdp_buff_xsk *xskb)
   238	{
 > 239		return sq->xsk_pool->tx_metadata_len > 0;
   240	}
   241	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

