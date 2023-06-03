Return-Path: <bpf+bounces-1757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70D6720E28
	for <lists+bpf@lfdr.de>; Sat,  3 Jun 2023 08:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632BF1C212BA
	for <lists+bpf@lfdr.de>; Sat,  3 Jun 2023 06:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30038833;
	Sat,  3 Jun 2023 06:38:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC4881F
	for <bpf@vger.kernel.org>; Sat,  3 Jun 2023 06:38:28 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA98C6
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685774307; x=1717310307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n++bioKmaR5f+rXXN73UPEhbqgbqm9htWdFWdI6DvHg=;
  b=IezvkYH1OCDDRVXA8xdIEOPVvpY5NiTIfXfMnTzIMiH/a3RCTZygRFNn
   JBwz4NiEiNiHwnIJ6yOURleGRfXFsC7nQbVyL/pBsGiav0SgqdsNaIuKn
   b57PnaI4KRkTxQVCKgR+o9B1ummBuxUUTu335FVfZ57bSuqNDn+OyZ7mp
   505uF/HkuiAGJxlWh1vyA4rtOfmTFiy8jq18/Ky3LbxxnszwSK5g2/hGs
   3tmDh864zND3vKxPTnnuxl4Jc6XXtL+xAgMb7mJKO+JWXv7EvWYO/c6S5
   ElWA6QUUdM8sqYZ7qVlDoWQuyf4wQBFNYyoqSKRqrdLTHmDSaBtf3cNJX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="356055834"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="356055834"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 23:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="882310743"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="882310743"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Jun 2023 23:38:23 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q5Ku6-0001O1-1M;
	Sat, 03 Jun 2023 06:38:22 +0000
Date: Sat, 3 Jun 2023 14:38:02 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, quentin@isovalent.com
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Support ->fill_link_info for
 kprobe_multi
Message-ID: <202306031438.0X2HPFQl-lkp@intel.com>
References: <20230602085239.91138-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602085239.91138-2-laoar.shao@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Yafang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/bpf-Support-fill_link_info-for-kprobe_multi/20230602-165455
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230602085239.91138-2-laoar.shao%40gmail.com
patch subject: [PATCH bpf-next 1/6] bpf: Support ->fill_link_info for kprobe_multi
config: i386-randconfig-s002-20230601 (https://download.01.org/0day-ci/archive/20230603/202306031438.0X2HPFQl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/270f3eb6c142f1f0ec7d800b8ecaab1b101682a0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yafang-Shao/bpf-Support-fill_link_info-for-kprobe_multi/20230602-165455
        git checkout 270f3eb6c142f1f0ec7d800b8ecaab1b101682a0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306031438.0X2HPFQl-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/bpf_trace.c:2554:24: sparse: sparse: cast removes address space '__user' of expression
>> kernel/trace/bpf_trace.c:2571:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long [usertype] *uaddrs @@
   kernel/trace/bpf_trace.c:2571:26: sparse:     expected void [noderef] __user *to
   kernel/trace/bpf_trace.c:2571:26: sparse:     got unsigned long long [usertype] *uaddrs
   kernel/trace/bpf_trace.c:2492:21: sparse: sparse: dereference of noderef expression
   kernel/trace/bpf_trace.c:2496:66: sparse: sparse: dereference of noderef expression

vim +/__user +2554 kernel/trace/bpf_trace.c

  2550	
  2551	static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
  2552							struct bpf_link_info *info)
  2553	{
> 2554		u64 *uaddrs = (u64 *)u64_to_user_ptr(info->kprobe_multi.addrs);
  2555		struct bpf_kprobe_multi_link *kmulti_link;
  2556		u32 ucount = info->kprobe_multi.count;
  2557	
  2558		if (!uaddrs ^ !ucount)
  2559			return -EINVAL;
  2560	
  2561		kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
  2562		if (!uaddrs) {
  2563			info->kprobe_multi.count = kmulti_link->cnt;
  2564			return 0;
  2565		}
  2566	
  2567		if (!ucount)
  2568			return 0;
  2569		if (ucount != kmulti_link->cnt)
  2570			return -EINVAL;
> 2571		if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)))
  2572			return -EFAULT;
  2573		return 0;
  2574	}
  2575	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

