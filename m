Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA926D0DF9
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 20:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjC3Slz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 14:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjC3Slo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 14:41:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36466B47F
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680201681; x=1711737681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7ZI6tYUOLL42nXliii/rWjGqkPnchA4L215IgGbSVmE=;
  b=lRJA1kGUxuRStO71/UBAfDbxau/8iwHrNAkRe8A70Peq6APnX3tkWzFo
   yVxIGHs9rUmTX38TZBk/Gb/BshS9TcT9JcWz87sM4L0Xe3ARTb4QxtggF
   e+1KbaZP++kpbJWNR20x5ne9ZJrZhEdUhdppGymrubpB/lqS8Oh4uspje
   I4kUB8sut2jpaqFju/mPMLSaZbyV0mhXUAxhIWbbuSuZ1eVJ5vSexF99Q
   BtPpxCFJuHhf1Wm8DdbDsm/7OSY9rMN5s0Dh5wPDoQpbSMBPrt2Jixl8p
   FV1zPXRi7eIL3NdiPI4MH0H5O1IdyIrdICPvMFXWUqnOk0zE3ddmBNbfj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="320910224"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="320910224"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 11:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="774104766"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="774104766"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2023 11:41:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phxCr-000L6a-15;
        Thu, 30 Mar 2023 18:41:05 +0000
Date:   Fri, 31 Mar 2023 02:40:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kafai@fb.com, sdf@google.com,
        edumazet@google.com, aditi.ghag@isovalent.com
Subject: Re: [PATCH v5 bpf-next 3/7] udp: seq_file: Helper function to match
 socket attributes
Message-ID: <202303310212.8DXGg50J-lkp@intel.com>
References: <20230330151758.531170-4-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330151758.531170-4-aditi.ghag@isovalent.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Aditi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditi-Ghag/bpf-tcp-Avoid-taking-fast-sock-lock-in-iterator/20230330-232137
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230330151758.531170-4-aditi.ghag%40isovalent.com
patch subject: [PATCH v5 bpf-next 3/7] udp: seq_file: Helper function to match socket attributes
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20230331/202303310212.8DXGg50J-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/66cc617bebf6cb3d2162587d6e248d86bc59c1c2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aditi-Ghag/bpf-tcp-Avoid-taking-fast-sock-lock-in-iterator/20230330-232137
        git checkout 66cc617bebf6cb3d2162587d6e248d86bc59c1c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303310212.8DXGg50J-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: net/ipv4/udp.o: in function `udp_get_first':
>> net/ipv4/udp.c:3015: undefined reference to `seq_sk_match'
   net/ipv4/udp.c:3015:(.text+0x4a8): relocation truncated to fit: R_NIOS2_CALL26 against `seq_sk_match'
   nios2-linux-ld: net/ipv4/udp.o: in function `udp_get_next':
   net/ipv4/udp.c:3036: undefined reference to `seq_sk_match'
   net/ipv4/udp.c:3036:(.text+0x55c): relocation truncated to fit: R_NIOS2_CALL26 against `seq_sk_match'


vim +3015 net/ipv4/udp.c

  2993	
  2994	static struct sock *udp_get_first(struct seq_file *seq, int start)
  2995	{
  2996		struct udp_iter_state *state = seq->private;
  2997		struct net *net = seq_file_net(seq);
  2998		struct udp_seq_afinfo *afinfo;
  2999		struct udp_table *udptable;
  3000		struct sock *sk;
  3001	
  3002		afinfo = pde_data(file_inode(seq->file));
  3003	
  3004		udptable = udp_get_table_afinfo(afinfo, net);
  3005	
  3006		for (state->bucket = start; state->bucket <= udptable->mask;
  3007		     ++state->bucket) {
  3008			struct udp_hslot *hslot = &udptable->hash[state->bucket];
  3009	
  3010			if (hlist_empty(&hslot->head))
  3011				continue;
  3012	
  3013			spin_lock_bh(&hslot->lock);
  3014			sk_for_each(sk, &hslot->head) {
> 3015				if (seq_sk_match(seq, sk))
  3016					goto found;
  3017			}
  3018			spin_unlock_bh(&hslot->lock);
  3019		}
  3020		sk = NULL;
  3021	found:
  3022		return sk;
  3023	}
  3024	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
