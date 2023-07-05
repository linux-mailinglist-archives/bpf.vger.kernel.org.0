Return-Path: <bpf+bounces-4080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7897D748A02
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 19:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3684A281083
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154EF134AB;
	Wed,  5 Jul 2023 17:17:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C97D2E8;
	Wed,  5 Jul 2023 17:17:08 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648BF173E;
	Wed,  5 Jul 2023 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688577427; x=1720113427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Dw+QDQUJHMAT3bZNG/T7PvNSKyBjgzzz7A5MOKCsdI=;
  b=HPnd0F9T2NXsLN8KBhamwj+ODLxQjhGMsMv6AmQhv92QFeFaiYnjBtMr
   Y0E0fGFKhyPnNIP7DvG5gdqLKHF/oWh3h9nc7a4J8UxOhyU69Zaudt8T+
   BCPUrlObdV72pIyhStkJzxJnuWFo2RuIWQ9jf4REvSeSjQrI2uz09zokn
   eoQ9dhdL9qwFev8ViCO30Oz3jP1hm+jQLedliw28p+neBXOi4gnJZnxP4
   dYvBjiwyrZhI4Fm6gn1AlcUTgBoxuL/IohHaBGf1N5hfAJg+Mbt0nD0Cp
   2yWzJnw/bSrJ+BRpShVhA+0nFh/GWVcnjoKiMM2MwVtqlUKc2vJEpiMAx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362267421"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="362267421"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 10:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="713260175"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="713260175"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Jul 2023 10:17:03 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qH67h-0000jy-39;
	Wed, 05 Jul 2023 17:17:01 +0000
Date: Thu, 6 Jul 2023 01:16:31 +0800
From: kernel test robot <lkp@intel.com>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: oe-kbuild-all@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: Re: [PATCH 3/4] igb: add AF_XDP zero-copy Rx support
Message-ID: <202307060154.LjqekYIL-lkp@intel.com>
References: <20230704095915.9750-4-sriram.yagnaraman@est.tech>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704095915.9750-4-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Sriram,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]
[also build test WARNING on tnguy-net-queue/dev-queue horms-ipvs/master linus/master v6.4 next-20230705]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sriram-Yagnaraman/igb-prepare-for-AF_XDP-zero-copy-support/20230704-180613
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20230704095915.9750-4-sriram.yagnaraman%40est.tech
patch subject: [PATCH 3/4] igb: add AF_XDP zero-copy Rx support
config: openrisc-randconfig-r093-20230705 (https://download.01.org/0day-ci/archive/20230706/202307060154.LjqekYIL-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230706/202307060154.LjqekYIL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307060154.LjqekYIL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/igb/igb_main.c:2016:32: sparse: sparse: incompatible types in conditional expression (different base types):
>> drivers/net/ethernet/intel/igb/igb_main.c:2016:32: sparse:    bool
>> drivers/net/ethernet/intel/igb/igb_main.c:2016:32: sparse:    void
   drivers/net/ethernet/intel/igb/igb_main.c:4920:27: sparse: sparse: incompatible types in conditional expression (different base types):
   drivers/net/ethernet/intel/igb/igb_main.c:4920:27: sparse:    bool
   drivers/net/ethernet/intel/igb/igb_main.c:4920:27: sparse:    void

vim +2016 drivers/net/ethernet/intel/igb/igb_main.c

  1984	
  1985	/**
  1986	 *  igb_configure - configure the hardware for RX and TX
  1987	 *  @adapter: private board structure
  1988	 **/
  1989	static void igb_configure(struct igb_adapter *adapter)
  1990	{
  1991		struct net_device *netdev = adapter->netdev;
  1992		int i;
  1993	
  1994		igb_get_hw_control(adapter);
  1995		igb_set_rx_mode(netdev);
  1996		igb_setup_tx_mode(adapter);
  1997	
  1998		igb_restore_vlan(adapter);
  1999	
  2000		igb_setup_tctl(adapter);
  2001		igb_setup_mrqc(adapter);
  2002		igb_setup_rctl(adapter);
  2003	
  2004		igb_nfc_filter_restore(adapter);
  2005		igb_configure_tx(adapter);
  2006		igb_configure_rx(adapter);
  2007	
  2008		igb_rx_fifo_flush_82575(&adapter->hw);
  2009	
  2010		/* call igb_desc_unused which always leaves
  2011		 * at least 1 descriptor unused to make sure
  2012		 * next_to_use != next_to_clean
  2013		 */
  2014		for (i = 0; i < adapter->num_rx_queues; i++) {
  2015			struct igb_ring *ring = adapter->rx_ring[i];
> 2016			ring->xsk_pool ?
  2017				igb_alloc_rx_buffers_zc(ring, igb_desc_unused(ring)) :
  2018				igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
  2019		}
  2020	}
  2021	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

