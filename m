Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1EA6972A9
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 01:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjBOA0b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 19:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjBOA0a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 19:26:30 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC9A2E0E5
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 16:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676420788; x=1707956788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CzNKNpDpsPp9Q6X5ZRGUEKmuoVnRfG09vhZj53z3rlY=;
  b=FryLC5Da6+4vgeaJPHUJoQjG79aaDbarjAmOdlo296i+j9xBxa06KLPM
   xRKu7p9Lj87xtWs6JOP2+26T+6PxDdrFK5kFBPXt4njXBAlTxxQHijgzs
   UtOgKqwYSPRo3Qy1Rr0Cytoj5v6vzy0yKqj/U+a/bfPKZ8I3jyi6Rq1X7
   16R+QDU/TibY098OT0mNn/Vo1Sih4NvlM+b/2gdh4YLTPP3TqEOfS37ZW
   tvEDxV5eeNXwk0paOWPRmY6ziEHIUHEx2QWNH4epVaeP+3c2K8tZKZLuJ
   Pd+rbmlTifXuVhoA2Xpz6kM4jxXM2t0LCmetZLUGhhngIeTvMq5ZLL+Wd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="310938430"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="310938430"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 16:26:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="998269639"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="998269639"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2023 16:26:26 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pS5cv-0008se-2Q;
        Wed, 15 Feb 2023 00:26:25 +0000
Date:   Wed, 15 Feb 2023 08:26:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Kui-Feng Lee <kuifeng@meta.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Create links for BPF struct_ops maps.
Message-ID: <202302150809.TbWg3iN6-lkp@intel.com>
References: <20230214221718.503964-2-kuifeng@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214221718.503964-2-kuifeng@meta.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kui-Feng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kui-Feng-Lee/bpf-Create-links-for-BPF-struct_ops-maps/20230215-061816
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230214221718.503964-2-kuifeng%40meta.com
patch subject: [PATCH bpf-next 1/7] bpf: Create links for BPF struct_ops maps.
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230215/202302150809.TbWg3iN6-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c186fe88190559d4872279724d598b8d45ba3092
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kui-Feng-Lee/bpf-Create-links-for-BPF-struct_ops-maps/20230215-061816
        git checkout c186fe88190559d4872279724d598b8d45ba3092
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302150809.TbWg3iN6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/bpf_struct_ops.c:736:5: warning: no previous prototype for 'link_create_struct_ops_map' [-Wmissing-prototypes]
     736 | int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/link_create_struct_ops_map +736 kernel/bpf/bpf_struct_ops.c

   735	
 > 736	int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
   737	{
   738		struct bpf_link_primer link_primer;
   739		struct bpf_map *map;
   740		struct bpf_link *link = NULL;
   741		int err;
   742	
   743		map = bpf_map_get(attr->link_create.prog_fd);
   744		if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS)
   745			return -EINVAL;
   746	
   747		link = kzalloc(sizeof(*link), GFP_USER);
   748		if (!link) {
   749			err = -ENOMEM;
   750			goto err_out;
   751		}
   752		bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL);
   753		link->map = map;
   754	
   755		err = bpf_link_prime(link, &link_primer);
   756		if (err)
   757			goto err_out;
   758	
   759		return bpf_link_settle(&link_primer);
   760	
   761	err_out:
   762		bpf_map_put(map);
   763		kfree(link);
   764		return err;
   765	}
   766	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
