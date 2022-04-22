Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C3250B3BB
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 11:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiDVJQu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 05:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445853AbiDVJKg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 05:10:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B4051E6E;
        Fri, 22 Apr 2022 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650618464; x=1682154464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jaQBEI9gtWcbNllBCZ+EzKEbzFVZLPK+E0m9hNofpRY=;
  b=YR2X6rt1AQnleu6VY5mvgmY1lLrj7CKiDbwEguf4eqPq3zQjVXlGh/u4
   6UUXAZoyTnLCtaD+fp8jEkc9P96jlM+uPTSa3lxbbV6RLmurP5tmHrYfG
   PrWM/JupFv3dJRU6R7dM4WHK7rtIbCDi4ejcC8IeLu7cqXyuliD2H3Fr1
   XeMV0CmeZRim28OEjk1A5bYOLi8981gm80uRVqy3/0ulB7EoIvRESd6hy
   eYbBbsgE23SVox3E8tY/n2RtwIM8+Kn1cxnwI9VxYbWhgr1UbH1BIOv3g
   UlBWnTXrWYIsDJlVAKzup8IBAt97md8IbB/BgoawJppqNE8Y+rx2mXTx/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="251953460"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="251953460"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 02:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="867315839"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Apr 2022 02:07:38 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhpGL-0009xW-LC;
        Fri, 22 Apr 2022 09:07:37 +0000
Date:   Fri, 22 Apr 2022 17:06:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, hch@infradead.org,
        imbrenda@linux.ibm.com, mcgrof@kernel.org,
        Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH bpf 2/4] page_alloc: use vmalloc_huge for large system
 hash
Message-ID: <202204221628.82Qczjsq-lkp@intel.com>
References: <20220422051813.1989257-3-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422051813.1989257-3-song@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/bpf_prog_pack-and-vmalloc-on-huge-page-fixes/20220422-133605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220422/202204221628.82Qczjsq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/239fb9ca743cf33db8d56df7957726e19aea87d5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Song-Liu/bpf_prog_pack-and-vmalloc-on-huge-page-fixes/20220422-133605
        git checkout 239fb9ca743cf33db8d56df7957726e19aea87d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   mm/page_alloc.c: In function 'alloc_large_system_hash':
>> mm/page_alloc.c:8921:33: error: implicit declaration of function 'vmalloc_huge'; did you mean 'vmalloc_no_huge'? [-Werror=implicit-function-declaration]
    8921 |                         table = vmalloc_huge(size, gfp_flags);
         |                                 ^~~~~~~~~~~~
         |                                 vmalloc_no_huge
>> mm/page_alloc.c:8921:31: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    8921 |                         table = vmalloc_huge(size, gfp_flags);
         |                               ^
   cc1: some warnings being treated as errors


vim +8921 mm/page_alloc.c

  8876	
  8877			/* limit to 1 bucket per 2^scale bytes of low memory */
  8878			if (scale > PAGE_SHIFT)
  8879				numentries >>= (scale - PAGE_SHIFT);
  8880			else
  8881				numentries <<= (PAGE_SHIFT - scale);
  8882	
  8883			/* Make sure we've got at least a 0-order allocation.. */
  8884			if (unlikely(flags & HASH_SMALL)) {
  8885				/* Makes no sense without HASH_EARLY */
  8886				WARN_ON(!(flags & HASH_EARLY));
  8887				if (!(numentries >> *_hash_shift)) {
  8888					numentries = 1UL << *_hash_shift;
  8889					BUG_ON(!numentries);
  8890				}
  8891			} else if (unlikely((numentries * bucketsize) < PAGE_SIZE))
  8892				numentries = PAGE_SIZE / bucketsize;
  8893		}
  8894		numentries = roundup_pow_of_two(numentries);
  8895	
  8896		/* limit allocation size to 1/16 total memory by default */
  8897		if (max == 0) {
  8898			max = ((unsigned long long)nr_all_pages << PAGE_SHIFT) >> 4;
  8899			do_div(max, bucketsize);
  8900		}
  8901		max = min(max, 0x80000000ULL);
  8902	
  8903		if (numentries < low_limit)
  8904			numentries = low_limit;
  8905		if (numentries > max)
  8906			numentries = max;
  8907	
  8908		log2qty = ilog2(numentries);
  8909	
  8910		gfp_flags = (flags & HASH_ZERO) ? GFP_ATOMIC | __GFP_ZERO : GFP_ATOMIC;
  8911		do {
  8912			virt = false;
  8913			size = bucketsize << log2qty;
  8914			if (flags & HASH_EARLY) {
  8915				if (flags & HASH_ZERO)
  8916					table = memblock_alloc(size, SMP_CACHE_BYTES);
  8917				else
  8918					table = memblock_alloc_raw(size,
  8919								   SMP_CACHE_BYTES);
  8920			} else if (get_order(size) >= MAX_ORDER || hashdist) {
> 8921				table = vmalloc_huge(size, gfp_flags);
  8922				virt = true;
  8923				if (table)
  8924					huge = is_vm_area_hugepages(table);
  8925			} else {
  8926				/*
  8927				 * If bucketsize is not a power-of-two, we may free
  8928				 * some pages at the end of hash table which
  8929				 * alloc_pages_exact() automatically does
  8930				 */
  8931				table = alloc_pages_exact(size, gfp_flags);
  8932				kmemleak_alloc(table, size, 1, gfp_flags);
  8933			}
  8934		} while (!table && size > PAGE_SIZE && --log2qty);
  8935	
  8936		if (!table)
  8937			panic("Failed to allocate %s hash table\n", tablename);
  8938	
  8939		pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
  8940			tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
  8941			virt ? (huge ? "vmalloc hugepage" : "vmalloc") : "linear");
  8942	
  8943		if (_hash_shift)
  8944			*_hash_shift = log2qty;
  8945		if (_hash_mask)
  8946			*_hash_mask = (1 << log2qty) - 1;
  8947	
  8948		return table;
  8949	}
  8950	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
