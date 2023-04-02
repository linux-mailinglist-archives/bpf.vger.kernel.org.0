Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CC16D35C7
	for <lists+bpf@lfdr.de>; Sun,  2 Apr 2023 08:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjDBGS4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 02:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDBGSz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 02:18:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F92D41
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 23:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680416333; x=1711952333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Np+gEOwOm/rfEcRXcmPVfhSGIs/kFLqBSqz8TTtlT8s=;
  b=Cg2Mfduuuqr8RzB33MMscX1ytPBwgSqSx0JxMFdq32ATWRKrFkg/0r60
   3EVi8HZ172HA5k5JOzBeiIXTyOKJmkIquHWVDl/ymyWj8OwxJqV7I4CLU
   UIDHdVPSc0kejADbQ0qGq5j973l0wwCY0t8Kz0JxJeWB0JtAeX3rrxWPM
   +rLXUennMSAtbK1r3mdl0XgzjodG2bSNDQ99IyKgjFHT0dIaLv0UW4laE
   /LCACsu1R8n9nB/TVN1WBWMP5xMOlckGkWh+5A32N7X88IzI94YlTslAr
   IpAa9MT1rw49qj9PC4M2swmOWdGdMOpm7WQeUysPcivFIZVESf+XMJBHj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="330272260"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="330272260"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 23:18:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="859803287"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="859803287"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Apr 2023 23:18:51 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pir3C-000NGz-32;
        Sun, 02 Apr 2023 06:18:50 +0000
Date:   Sun, 2 Apr 2023 14:18:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kafai@fb.com, sdf@google.com,
        edumazet@google.com, aditi.ghag@isovalent.com
Subject: Re: [PATCH v5 bpf-next 3/7] udp: seq_file: Helper function to match
 socket attributes
Message-ID: <202304021454.snASElSi-lkp@intel.com>
References: <20230330151758.531170-4-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330151758.531170-4-aditi.ghag@isovalent.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Aditi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditi-Ghag/bpf-tcp-Avoid-taking-fast-sock-lock-in-iterator/20230330-232137
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230330151758.531170-4-aditi.ghag%40isovalent.com
patch subject: [PATCH v5 bpf-next 3/7] udp: seq_file: Helper function to match socket attributes
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20230402/202304021454.snASElSi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/66cc617bebf6cb3d2162587d6e248d86bc59c1c2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aditi-Ghag/bpf-tcp-Avoid-taking-fast-sock-lock-in-iterator/20230330-232137
        git checkout 66cc617bebf6cb3d2162587d6e248d86bc59c1c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/ipv4/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304021454.snASElSi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/ipv4/udp.c:1487:28: sparse: sparse: context imbalance in 'udp_rmem_release' - unexpected unlock
   net/ipv4/udp.c:1519:19: sparse: sparse: context imbalance in 'busylock_acquire' - wrong count at exit
   net/ipv4/udp.c:1531:28: sparse: sparse: context imbalance in 'busylock_release' - unexpected unlock
>> net/ipv4/udp.c:2986:32: sparse: sparse: marked inline, but without a definition
>> net/ipv4/udp.c:2986:32: sparse: sparse: marked inline, but without a definition

vim +2986 net/ipv4/udp.c

  2985	
> 2986	static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk);
  2987	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
