Return-Path: <bpf+bounces-9599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A20DD7997A4
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 13:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B641C20BC3
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 11:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9CF2105;
	Sat,  9 Sep 2023 11:24:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E4D1FD7;
	Sat,  9 Sep 2023 11:24:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC10DCF2;
	Sat,  9 Sep 2023 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694258658; x=1725794658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lzrI8p99jf5EW/XFvyz0LvPZxlnvgQAHoPR1ihbSpIc=;
  b=YagF8wIAJoQCWA0hl1FI29hXBRchepyfSnJM/1mz242Ci3ZUKQIUtMqH
   I6yxE+Lu9VlamQlvafzc/TJn183kwQo/WwN1ZOKtekAWX1e6a5PH7Hw2h
   uHw2ITdbwsUJ2WNq1YTul8dpCe/QuhPke2/FyeJmtW44jZM19NaHKiwqc
   cEaiXiC824QaOoPmfDsgo4x/mQtUdDV4/mXpNrxVflYf1Uf3WqR7BBIwj
   LLjcrcYYd2dns5Arjf/hGRWY5Ur/GAZIwD6EXMLPikVddz2i9rjMs+tyX
   fvO5bYZkT130q40+KKL5FiORGhuY9IalimsfVx+Ao7N7YbBXypqauob0H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="377724652"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="377724652"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 04:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="742796870"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="742796870"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Sep 2023 04:24:15 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qew4S-0003PV-2c;
	Sat, 09 Sep 2023 11:24:12 +0000
Date: Sat, 9 Sep 2023 19:23:14 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: expose information about supported xdp
 metadata kfunc
Message-ID: <202309091923.UTfYFF4J-lkp@intel.com>
References: <20230908225807.1780455-3-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908225807.1780455-3-sdf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/bpf-make-it-easier-to-add-new-metadata-kfunc/20230909-070017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230908225807.1780455-3-sdf%40google.com
patch subject: [PATCH bpf-next 2/3] bpf: expose information about supported xdp metadata kfunc
config: i386-randconfig-141-20230909 (https://download.01.org/0day-ci/archive/20230909/202309091923.UTfYFF4J-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230909/202309091923.UTfYFF4J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091923.UTfYFF4J-lkp@intel.com/

smatch warnings:
net/core/netdev-genl.c:26 netdev_nl_dev_fill() warn: inconsistent indenting

vim +26 net/core/netdev-genl.c

    11	
    12	static int
    13	netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
    14			   const struct genl_info *info)
    15	{
    16		u64 xdp_rx_meta = 0;
    17		void *hdr;
    18	
    19		hdr = genlmsg_iput(rsp, info);
    20		if (!hdr)
    21			return -EMSGSIZE;
    22	
    23	#define XDP_METADATA_KFUNC(_, flag, __, xmo) \
    24		if (netdev->xdp_metadata_ops->xmo) \
    25			xdp_rx_meta |= flag;
  > 26	XDP_METADATA_KFUNC_xxx
    27	#undef XDP_METADATA_KFUNC
    28	
    29		if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
    30		    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XDP_FEATURES,
    31				      netdev->xdp_features, NETDEV_A_DEV_PAD) ||
    32		    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XDP_RX_METADATA_FEATURES,
    33				      xdp_rx_meta, NETDEV_A_DEV_PAD)) {
    34			genlmsg_cancel(rsp, hdr);
    35			return -EINVAL;
    36		}
    37	
    38		if (netdev->xdp_features & NETDEV_XDP_ACT_XSK_ZEROCOPY) {
    39			if (nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
    40					netdev->xdp_zc_max_segs)) {
    41				genlmsg_cancel(rsp, hdr);
    42				return -EINVAL;
    43			}
    44		}
    45	
    46		genlmsg_end(rsp, hdr);
    47	
    48		return 0;
    49	}
    50	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

