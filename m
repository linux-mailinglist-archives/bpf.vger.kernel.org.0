Return-Path: <bpf+bounces-3197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6E73AC45
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64F528168B
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA722256D;
	Thu, 22 Jun 2023 22:00:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266D22566
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 22:00:54 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B111988;
	Thu, 22 Jun 2023 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687471253; x=1719007253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fWYQw7YkqZaC3rzHqhX8WgjjZeuhKInvStJbx+K0+hw=;
  b=Zm41cHNjl7TzJEzDE8UIZI1fFCVQZGbdKnujfOS7XySN5FhX3pxun29O
   jO2k2IUrR1ALO9T1TzmtRC7lGSnjvzPHMZeWXDMPb2DENUfX8GGjmrDjn
   j0NWXQbfpoGKfPcv6uWpIhgsp0AVz2vAkgpQwxQyLvYofH0Fuo0o/j7tm
   UV7HKcJBWUfjh3G2HaXMHrn+01io0CzhtmNRXH539tUztgyh4v/PVrCjC
   /SH8/GvMCh3wVRvB8s2UNUG/cyRPZ5oSeGcuJ/9nKHFP16pnQleFDuj9D
   YjjBimDzp55Q2H+tnP81j9aZYj3SlRM5JpVPL8klNO5/9/c2vN0IF4auN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359490220"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="359490220"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 15:00:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715095781"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="715095781"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2023 15:00:47 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qCSMA-0007mp-31;
	Thu, 22 Jun 2023 22:00:46 +0000
Date: Fri, 23 Jun 2023 06:00:06 +0800
From: kernel test robot <lkp@intel.com>
To: Sumitra Sharma <sumitraartsy@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ira Weiny <ira.weiny@intel.com>,
	Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>,
	Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH v3] lib/test_bpf: Call page_address() on page acquired
 with GFP_KERNEL flag
Message-ID: <202306230559.hU5Aonpl-lkp@intel.com>
References: <20230622080729.GA426913@sumitra.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622080729.GA426913@sumitra.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Sumitra,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master linus/master v6.4-rc7 next-20230622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumitra-Sharma/lib-test_bpf-Call-page_address-on-page-acquired-with-GFP_KERNEL-flag/20230622-160846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230622080729.GA426913%40sumitra.com
patch subject: [PATCH v3] lib/test_bpf: Call page_address() on page acquired with GFP_KERNEL flag
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230623/202306230559.hU5Aonpl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306230559.hU5Aonpl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306230559.hU5Aonpl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/test_bpf.c: In function 'generate_test_data':
>> lib/test_bpf.c:14395:1: warning: label 'err_free_page' defined but not used [-Wunused-label]
   14395 | err_free_page:
         | ^~~~~~~~~~~~~


vim +/err_free_page +14395 lib/test_bpf.c

64a8946b447e41 Alexei Starovoitov 2014-05-08  14358  
10f18e0ba1ea7e Daniel Borkmann    2014-05-23  14359  static void *generate_test_data(struct bpf_test *test, int sub)
64a8946b447e41 Alexei Starovoitov 2014-05-08  14360  {
bac142acb90e95 Nicolas Schichan   2015-08-04  14361  	struct sk_buff *skb;
bac142acb90e95 Nicolas Schichan   2015-08-04  14362  	struct page *page;
bac142acb90e95 Nicolas Schichan   2015-08-04  14363  
10f18e0ba1ea7e Daniel Borkmann    2014-05-23  14364  	if (test->aux & FLAG_NO_DATA)
10f18e0ba1ea7e Daniel Borkmann    2014-05-23  14365  		return NULL;
64a8946b447e41 Alexei Starovoitov 2014-05-08  14366  
f516420f683d14 Xu Kuohai          2022-03-21  14367  	if (test->aux & FLAG_LARGE_MEM)
f516420f683d14 Xu Kuohai          2022-03-21  14368  		return kmalloc(test->test[sub].data_size, GFP_KERNEL);
f516420f683d14 Xu Kuohai          2022-03-21  14369  
10f18e0ba1ea7e Daniel Borkmann    2014-05-23  14370  	/* Test case expects an skb, so populate one. Various
10f18e0ba1ea7e Daniel Borkmann    2014-05-23  14371  	 * subtests generate skbs of different sizes based on
10f18e0ba1ea7e Daniel Borkmann    2014-05-23  14372  	 * the same data.
10f18e0ba1ea7e Daniel Borkmann    2014-05-23  14373  	 */
bac142acb90e95 Nicolas Schichan   2015-08-04  14374  	skb = populate_skb(test->data, test->test[sub].data_size);
bac142acb90e95 Nicolas Schichan   2015-08-04  14375  	if (!skb)
bac142acb90e95 Nicolas Schichan   2015-08-04  14376  		return NULL;
bac142acb90e95 Nicolas Schichan   2015-08-04  14377  
bac142acb90e95 Nicolas Schichan   2015-08-04  14378  	if (test->aux & FLAG_SKB_FRAG) {
bac142acb90e95 Nicolas Schichan   2015-08-04  14379  		/*
bac142acb90e95 Nicolas Schichan   2015-08-04  14380  		 * when the test requires a fragmented skb, add a
bac142acb90e95 Nicolas Schichan   2015-08-04  14381  		 * single fragment to the skb, filled with
bac142acb90e95 Nicolas Schichan   2015-08-04  14382  		 * test->frag_data.
bac142acb90e95 Nicolas Schichan   2015-08-04  14383  		 */
bac142acb90e95 Nicolas Schichan   2015-08-04  14384  		page = alloc_page(GFP_KERNEL);
bac142acb90e95 Nicolas Schichan   2015-08-04  14385  
bac142acb90e95 Nicolas Schichan   2015-08-04  14386  		if (!page)
bac142acb90e95 Nicolas Schichan   2015-08-04  14387  			goto err_kfree_skb;
bac142acb90e95 Nicolas Schichan   2015-08-04  14388  
4a8b1daa0ee566 Sumitra Sharma     2023-06-22  14389  		memcpy(page_address(page), test->frag_data, MAX_DATA);
bac142acb90e95 Nicolas Schichan   2015-08-04  14390  		skb_add_rx_frag(skb, 0, page, 0, MAX_DATA, MAX_DATA);
bac142acb90e95 Nicolas Schichan   2015-08-04  14391  	}
bac142acb90e95 Nicolas Schichan   2015-08-04  14392  
bac142acb90e95 Nicolas Schichan   2015-08-04  14393  	return skb;
bac142acb90e95 Nicolas Schichan   2015-08-04  14394  
bac142acb90e95 Nicolas Schichan   2015-08-04 @14395  err_free_page:
bac142acb90e95 Nicolas Schichan   2015-08-04  14396  	__free_page(page);
bac142acb90e95 Nicolas Schichan   2015-08-04  14397  err_kfree_skb:
bac142acb90e95 Nicolas Schichan   2015-08-04  14398  	kfree_skb(skb);
bac142acb90e95 Nicolas Schichan   2015-08-04  14399  	return NULL;
10f18e0ba1ea7e Daniel Borkmann    2014-05-23  14400  }
10f18e0ba1ea7e Daniel Borkmann    2014-05-23  14401  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

