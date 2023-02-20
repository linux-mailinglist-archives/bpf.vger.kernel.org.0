Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED6869C4F0
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 06:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBTF3J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 00:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBTF3I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 00:29:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F241DB442
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 21:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676870947; x=1708406947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8bf9iFk5+9dK64rYiv8pcnAkYcrbshioFiVlL55tCIg=;
  b=TBzWyMC5FLGSEQJuMEpQAdFPTltSMWJh27sUqEGxp1xBe4Jr7wN8wTpp
   Ed/dZs9ZCYsnp+yionajfZYGNODQWP9F6WWZGP7eKF3+PAyO+V4Y/YGyw
   KbJDksM+hoIzm7INsKMiPhINwQorddjG5FoK161HyzMCdEwEBi0UBrbpR
   8m2CSxZcpNUf+6J/TLHA6xUl+9WdYjSbvgOYt9d5/8ah8i/6RC3Rx8913
   t2eU/Yd5K+pGTcvKAojW+qHgOidzmAcI7PZl+aZaJWpdiUX+yn6kEoeSN
   pSebjE8xFxW0AXHqWdRjdkZHqc7+FOuIz5uUhMKemrQyCgZKd6+7Y7Q3l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="312691838"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="312691838"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 21:29:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="648716796"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="648716796"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Feb 2023 21:29:04 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTyjX-000Dhl-1G;
        Mon, 20 Feb 2023 05:29:03 +0000
Date:   Mon, 20 Feb 2023 13:28:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 2/7] bpf: Support kptrs in local storage maps
Message-ID: <202302201347.KsT4rWrN-lkp@intel.com>
References: <20230219155249.1755998-3-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219155249.1755998-3-memxor@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kumar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 168de0233586fb06c5c5c56304aa9a928a09b0ba]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/bpf-Support-kptrs-in-percpu-hashmap-and-percpu-LRU-hashmap/20230219-235406
base:   168de0233586fb06c5c5c56304aa9a928a09b0ba
patch link:    https://lore.kernel.org/r/20230219155249.1755998-3-memxor%40gmail.com
patch subject: [PATCH bpf-next v1 2/7] bpf: Support kptrs in local storage maps
config: nios2-randconfig-s043-20230219 (https://download.01.org/0day-ci/archive/20230220/202302201347.KsT4rWrN-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/01f54156de471b78c6355e9aba9860afaf61cedb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kumar-Kartikeya-Dwivedi/bpf-Support-kptrs-in-percpu-hashmap-and-percpu-LRU-hashmap/20230219-235406
        git checkout 01f54156de471b78c6355e9aba9860afaf61cedb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302201347.KsT4rWrN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/bpf_local_storage.c:107:41: sparse: sparse: dereference of noderef expression

vim +107 kernel/bpf/bpf_local_storage.c

   101	
   102	static void bpf_selem_free_rcu(struct rcu_head *rcu)
   103	{
   104		struct bpf_local_storage_elem *selem;
   105	
   106		selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
 > 107		bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem));
   108		kfree(selem);
   109	}
   110	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
