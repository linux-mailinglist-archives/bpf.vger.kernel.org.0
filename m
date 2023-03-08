Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECB26B0CED
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 16:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCHPe7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 10:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjCHPej (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 10:34:39 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18714B78AF
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 07:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678289607; x=1709825607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NkR0W7o9uX/z8jZ3uUOg7UWWR+boKEcYvcbmJp3Otq4=;
  b=MBKnUXEDlZ54TpP9nFHf6UhCpDNv7sk1aU7Ek5c4ZT0/VwK8y49nM3Ik
   UypckmmFDz0KoG1kyxQ3qAAg7SV7BjNb3JfT8rho+tKCgZaX3S7FtOvMM
   +fagcF6ew5xjc2iA8DL6pkiROiwdMjT0O6/tCdPjAZrhBV08CdIhLsBCS
   Pk4l3pvjvRlCVALfhHU+bHlvkAXe0z172fZ/lxJNa5FsA6OG4VjFjqUNn
   g3tPV6O6ciiPewMZT5mKWUwYBavNgc6iO9VMUtrAaiRJ4y+Dicdc28uKQ
   23uOUJM+TRkDiilRO3hP8S/iHnVFC/66/GKnBODy3Ia4flVO2m06EzRBr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="320014599"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="320014599"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:32:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="766018491"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="766018491"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2023 07:32:49 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZvma-0002Dj-0j;
        Wed, 08 Mar 2023 15:32:48 +0000
Date:   Wed, 8 Mar 2023 23:32:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Kui-Feng Lee <kuifeng@meta.com>
Subject: Re: [PATCH bpf-next v5 3/8] bpf: Create links for BPF struct_ops
 maps.
Message-ID: <202303082344.mxuydKat-lkp@intel.com>
References: <20230308005050.255859-4-kuifeng@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308005050.255859-4-kuifeng@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kui-Feng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kui-Feng-Lee/bpf-Retire-the-struct_ops-map-kvalue-refcnt/20230308-085434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230308005050.255859-4-kuifeng%40meta.com
patch subject: [PATCH bpf-next v5 3/8] bpf: Create links for BPF struct_ops maps.
config: i386-randconfig-a012-20230306 (https://download.01.org/0day-ci/archive/20230308/202303082344.mxuydKat-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/de9e43a5ac82dde718d80d8347e867a8fc935e0a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kui-Feng-Lee/bpf-Retire-the-struct_ops-map-kvalue-refcnt/20230308-085434
        git checkout de9e43a5ac82dde718d80d8347e867a8fc935e0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/intel/fm10k/ drivers/net/ethernet/intel/ixgbe/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303082344.mxuydKat-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/fm10k/fm10k_main.c:8:
   In file included from include/net/tcp.h:35:
   In file included from include/net/sock_reuseport.h:5:
   In file included from include/linux/filter.h:9:
   include/linux/bpf.h:2388:19: error: redefinition of 'bpf_struct_ops_link_create'
   static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
                     ^
   include/linux/bpf.h:1592:19: note: previous definition is here
   static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
                     ^
>> drivers/net/ethernet/intel/fm10k/fm10k_main.c:886:16: warning: division by zero is undefined [-Wdivision-by-zero]
           desc_flags |= FM10K_SET_FLAG(tx_flags, FM10K_TX_FLAGS_CSUM,
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/fm10k/fm10k_main.c:878:26: note: expanded from macro 'FM10K_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.
--
   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:27:
   include/linux/bpf.h:2388:19: error: redefinition of 'bpf_struct_ops_link_create'
   static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
                     ^
   include/linux/bpf.h:1592:19: note: previous definition is here
   static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
                     ^
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8223:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_HW_VLAN,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8213:26: note: expanded from macro 'IXGBE_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8227:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_TSO,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8213:26: note: expanded from macro 'IXGBE_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8231:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_TSTAMP,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8213:26: note: expanded from macro 'IXGBE_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8235:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type ^= IXGBE_SET_FLAG(skb->no_fcs, 1, IXGBE_ADVTXD_DCMD_IFCS);
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8213:26: note: expanded from macro 'IXGBE_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8246:19: warning: division by zero is undefined [-Wdivision-by-zero]
           olinfo_status |= IXGBE_SET_FLAG(tx_flags,
                            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8213:26: note: expanded from macro 'IXGBE_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8251:19: warning: division by zero is undefined [-Wdivision-by-zero]
           olinfo_status |= IXGBE_SET_FLAG(tx_flags,
                            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8213:26: note: expanded from macro 'IXGBE_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8256:19: warning: division by zero is undefined [-Wdivision-by-zero]
           olinfo_status |= IXGBE_SET_FLAG(tx_flags,
                            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8213:26: note: expanded from macro 'IXGBE_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8264:19: warning: division by zero is undefined [-Wdivision-by-zero]
           olinfo_status |= IXGBE_SET_FLAG(tx_flags,
                            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8213:26: note: expanded from macro 'IXGBE_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:10807:46: warning: shift count >= width of type [-Wshift-count-overflow]
           err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
                                                       ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   9 warnings and 1 error generated.


vim +886 drivers/net/ethernet/intel/fm10k/fm10k_main.c

76a540d4728a37 Alexander Duyck 2014-09-20  874  
76a540d4728a37 Alexander Duyck 2014-09-20  875  #define FM10K_SET_FLAG(_input, _flag, _result) \
76a540d4728a37 Alexander Duyck 2014-09-20  876  	((_flag <= _result) ? \
76a540d4728a37 Alexander Duyck 2014-09-20  877  	 ((u32)(_input & _flag) * (_result / _flag)) : \
76a540d4728a37 Alexander Duyck 2014-09-20  878  	 ((u32)(_input & _flag) / (_flag / _result)))
76a540d4728a37 Alexander Duyck 2014-09-20  879  
76a540d4728a37 Alexander Duyck 2014-09-20  880  static u8 fm10k_tx_desc_flags(struct sk_buff *skb, u32 tx_flags)
76a540d4728a37 Alexander Duyck 2014-09-20  881  {
76a540d4728a37 Alexander Duyck 2014-09-20  882  	/* set type for advanced descriptor with frame checksum insertion */
76a540d4728a37 Alexander Duyck 2014-09-20  883  	u32 desc_flags = 0;
76a540d4728a37 Alexander Duyck 2014-09-20  884  
76a540d4728a37 Alexander Duyck 2014-09-20  885  	/* set checksum offload bits */
76a540d4728a37 Alexander Duyck 2014-09-20 @886  	desc_flags |= FM10K_SET_FLAG(tx_flags, FM10K_TX_FLAGS_CSUM,
76a540d4728a37 Alexander Duyck 2014-09-20  887  				     FM10K_TXD_FLAG_CSUM);
76a540d4728a37 Alexander Duyck 2014-09-20  888  
76a540d4728a37 Alexander Duyck 2014-09-20  889  	return desc_flags;
76a540d4728a37 Alexander Duyck 2014-09-20  890  }
76a540d4728a37 Alexander Duyck 2014-09-20  891  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
