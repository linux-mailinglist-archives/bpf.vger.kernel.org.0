Return-Path: <bpf+bounces-6334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA2276827A
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 00:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699952820CC
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 22:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CCB17743;
	Sat, 29 Jul 2023 22:14:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A07C;
	Sat, 29 Jul 2023 22:14:04 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ABD2680;
	Sat, 29 Jul 2023 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690668839; x=1722204839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t+Q/8jEEv0+0VdpWX737VkYspVixa02bCw6HqiumW4I=;
  b=Eur7GAaqCD7mh1z7jpKHmZp125cWUtGzCmi1l4XNMFyD7y3XlbRdl95W
   kDBC8OzsQ0am4sWst0S5pRCXb56/8PA19y3tpyDo4QX8/D3DDUJPia9XR
   CmFGx2G6MT+8G7vSN34iXIbPStopMZZCWM+7t6qtmIr6JbfkZBrkGFG0v
   2rKczLI/8GLrV4E+xv+RzPvjNxFLuZ1FZEdaQ+KTWspO3tlMzI5C3eLTl
   Zjm9Fn9N4SZ1atHPeYyq9/kHI9cnvNuTbDt+a/Mesd+epg0/fXYyEtazL
   0xINeFGBeMgu5CTmEoLf9Ooy9d+sk6K7q1ctDsQTEBHR1qBfXEhZCcGEE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="455156353"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="455156353"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 15:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="721631493"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="721631493"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Jul 2023 15:13:52 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qPsBZ-0004JT-0u;
	Sat, 29 Jul 2023 22:13:44 +0000
Date: Sun, 30 Jul 2023 06:13:05 +0800
From: kernel test robot <lkp@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Larysa Zaremba <larysa.zaremba@intel.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next v4 17/21] veth: Implement VLAN tag and checksum
 XDP hint
Message-ID: <202307300639.I0c6g7mz-lkp@intel.com>
References: <20230728173923.1318596-18-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728173923.1318596-18-larysa.zaremba@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Larysa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Larysa-Zaremba/ice-make-RX-HW-timestamp-reading-code-more-reusable/20230729-023952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230728173923.1318596-18-larysa.zaremba%40intel.com
patch subject: [PATCH bpf-next v4 17/21] veth: Implement VLAN tag and checksum XDP hint
config: openrisc-randconfig-r081-20230730 (https://download.01.org/0day-ci/archive/20230730/202307300639.I0c6g7mz-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230730/202307300639.I0c6g7mz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307300639.I0c6g7mz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/veth.c:1771:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] checksum @@     got restricted __wsum [usertype] csum @@
   drivers/net/veth.c:1771:37: sparse:     expected unsigned int [usertype] checksum
   drivers/net/veth.c:1771:37: sparse:     got restricted __wsum [usertype] csum

vim +1771 drivers/net/veth.c

  1752	
  1753	static int veth_xdp_rx_csum(const struct xdp_md *ctx,
  1754				    enum xdp_csum_status *csum_status,
  1755				    union xdp_csum_info *csum_info)
  1756	{
  1757		struct veth_xdp_buff *_ctx = (void *)ctx;
  1758		struct sk_buff *skb = _ctx->skb;
  1759	
  1760		if (!skb)
  1761			return -ENODATA;
  1762	
  1763		if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
  1764			*csum_status = XDP_CHECKSUM_VALID_LVL0 + skb->csum_level;
  1765		} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
  1766			*csum_status = XDP_CHECKSUM_PARTIAL;
  1767			csum_info->csum_start = skb_checksum_start_offset(skb);
  1768			csum_info->csum_offset = skb->csum_offset;
  1769		} else if (skb->ip_summed == CHECKSUM_COMPLETE) {
  1770			*csum_status = XDP_CHECKSUM_COMPLETE;
> 1771			csum_info->checksum = skb->csum;
  1772		} else {
  1773			return -ENODATA;
  1774		}
  1775	
  1776		return 0;
  1777	}
  1778	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

