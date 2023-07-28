Return-Path: <bpf+bounces-6267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6493767762
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 23:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66641C2158B
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 21:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC3D1FB24;
	Fri, 28 Jul 2023 21:02:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC41F18F;
	Fri, 28 Jul 2023 21:02:46 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C654490;
	Fri, 28 Jul 2023 14:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690578165; x=1722114165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TEuzJH5k9NjiUQxxhE7uZppNJs34BvDLFgeNAlEl6/4=;
  b=MdAFllPDc3Xj0WCd4t/t4dGGII2LZQcyf5gg6N+JKARmeCG7beELGqyW
   5t5XHRIm7tl53PoBbmSHk5zfleGhE44Y8F1i/qclnKuCTL05gl5r2TuNz
   iuol7EUbwd7rxMOHw8WJPVEuENJJLEDF15rbqlgTevUoYQjIiwsWw9L3k
   e++8WF/BTavECnEWMK9z2rSo51EVMhI96ac4yHc+M40vorIHBcz8CbCEB
   skRS64pa1xORxwi1UNA9JzeCPXviTvxzFMdV/66rR0QuoBvzaJI0rAB8p
   +Jt49SHpdNf6+sRCkSxThSupWC1M+0ugCCAldbdxUNgoQHZA2fpFpSd9p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="353588604"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="353588604"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 14:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="817634323"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="817634323"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2023 14:02:35 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qPUba-0003Zk-1M;
	Fri, 28 Jul 2023 21:02:34 +0000
Date: Sat, 29 Jul 2023 05:02:25 +0800
From: kernel test robot <lkp@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Subject: Re: [PATCH bpf-next v4 13/21] ice: Implement checksum hint
Message-ID: <202307290459.rfUV5NZw-lkp@intel.com>
References: <20230728173923.1318596-14-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728173923.1318596-14-larysa.zaremba@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Larysa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Larysa-Zaremba/ice-make-RX-HW-timestamp-reading-code-more-reusable/20230729-023952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230728173923.1318596-14-larysa.zaremba%40intel.com
patch subject: [PATCH bpf-next v4 13/21] ice: Implement checksum hint
config: i386-randconfig-i012-20230728 (https://download.01.org/0day-ci/archive/20230729/202307290459.rfUV5NZw-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290459.rfUV5NZw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307290459.rfUV5NZw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_txrx_lib.c:674: warning: expecting prototype for ice_xdp_rx_csum_lvl(). Prototype was for ice_xdp_rx_csum() instead


vim +674 drivers/net/ethernet/intel/ice/ice_txrx_lib.c

   662	
   663	/**
   664	 * ice_xdp_rx_csum_lvl - Get level, at which HW has checked the checksum
   665	 * @ctx: XDP buff pointer
   666	 * @csum_status: destination address
   667	 * @csum_info: destination address
   668	 *
   669	 * Copy HW checksum level (if was checked) to the destination address.
   670	 */
   671	static int ice_xdp_rx_csum(const struct xdp_md *ctx,
   672				   enum xdp_csum_status *csum_status,
   673				   union xdp_csum_info *csum_info)
 > 674	{
   675		const struct ice_xdp_buff *xdp_ext = (void *)ctx;
   676		const union ice_32b_rx_flex_desc *eop_desc;
   677		enum ice_rx_csum_status status;
   678		u16 ptype;
   679	
   680		eop_desc = xdp_ext->pkt_ctx.eop_desc;
   681		ptype = ice_get_ptype(eop_desc);
   682	
   683		status = ice_get_rx_csum_status(eop_desc, ptype);
   684		if (status & ICE_RX_CSUM_NONE)
   685			return -ENODATA;
   686	
   687		*csum_status = XDP_CHECKSUM_VALID_LVL0 + ice_rx_csum_lvl(status);
   688		return 0;
   689	}
   690	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

