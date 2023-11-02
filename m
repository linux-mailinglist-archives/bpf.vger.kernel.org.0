Return-Path: <bpf+bounces-13936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B647DEFD2
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 11:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6921B21279
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B6D13AE7;
	Thu,  2 Nov 2023 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vg1STkov"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2676AAC;
	Thu,  2 Nov 2023 10:23:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACAD131;
	Thu,  2 Nov 2023 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698920633; x=1730456633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ul+y/18WagJSHQulwZHXgrLTb0s4wOtHHZDQsVdwvM=;
  b=Vg1STkov9pu9AU4o4GGfQUA93H6NgzJCAhd9AF52XrHwUKuNsYTbOOLV
   fTdl38WlsbF4sdsZ9FJY5meyjwB6+aJ67/jBrMXq9g6Dbina/1FNV5Qnl
   ZB7PBUFwZRxqtM5/8sZwwX1AjJqjsLswFn6a7p8fmn7uAMXZhDNXhxTGT
   2zv5S85oLXMTx9S8u36zr3hz+ZPHbIWdb9tuutvDUFyGTsYv8PXiNx12K
   AJFzbxasdtZqPpLGsKt7KL0oHfMw1uhgAfDfOMgnwSdCyGvDaf0BCxuV+
   3ntxPxckUijjxiEwsZEXIU94CyLnc559UJpn/IZgOnibhqENKwaGQmCik
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="379074844"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="379074844"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:23:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="934742036"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="934742036"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Nov 2023 03:23:49 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qyUrb-0001Oh-0K;
	Thu, 02 Nov 2023 10:23:47 +0000
Date: Thu, 2 Nov 2023 18:23:38 +0800
From: kernel test robot <lkp@intel.com>
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
	andrii@kernel.org, drosen@google.com
Cc: oe-kbuild-all@lists.linux.dev, sinquersw@gmail.com, kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 09/12] bpf, net: switch to dynamic
 registration
Message-ID: <202311021810.n3qVl5OS-lkp@intel.com>
References: <20231101204519.677870-10-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101204519.677870-10-thinker.li@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/thinker-li-gmail-com/bpf-refactory-struct_ops-type-initialization-to-a-function/20231102-044820
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231101204519.677870-10-thinker.li%40gmail.com
patch subject: [PATCH bpf-next v9 09/12] bpf, net: switch to dynamic registration
config: x86_64-randconfig-013-20231102 (https://download.01.org/0day-ci/archive/20231102/202311021810.n3qVl5OS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021810.n3qVl5OS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021810.n3qVl5OS-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/bpf/btf.o: in function `btf_add_struct_ops':
>> kernel/bpf/btf.c:8662: undefined reference to `bpf_struct_ops_desc_init'


vim +8662 kernel/bpf/btf.c

  8619	
  8620	static int
  8621	btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops,
  8622			   struct bpf_verifier_log *log)
  8623	{
  8624		struct btf_struct_ops_tab *tab, *new_tab;
  8625		int i, err;
  8626	
  8627		if (!btf)
  8628			return -ENOENT;
  8629	
  8630		/* Assume this function is called for a module when the module is
  8631		 * loading.
  8632		 */
  8633	
  8634		tab = btf->struct_ops_tab;
  8635		if (!tab) {
  8636			tab = kzalloc(offsetof(struct btf_struct_ops_tab, ops[4]),
  8637				      GFP_KERNEL);
  8638			if (!tab)
  8639				return -ENOMEM;
  8640			tab->capacity = 4;
  8641			btf->struct_ops_tab = tab;
  8642		}
  8643	
  8644		for (i = 0; i < tab->cnt; i++)
  8645			if (tab->ops[i].st_ops == st_ops)
  8646				return -EEXIST;
  8647	
  8648		if (tab->cnt == tab->capacity) {
  8649			new_tab = krealloc(tab,
  8650					   offsetof(struct btf_struct_ops_tab,
  8651						    ops[tab->capacity * 2]),
  8652					   GFP_KERNEL);
  8653			if (!new_tab)
  8654				return -ENOMEM;
  8655			tab = new_tab;
  8656			tab->capacity *= 2;
  8657			btf->struct_ops_tab = tab;
  8658		}
  8659	
  8660		tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;
  8661	
> 8662		err = bpf_struct_ops_desc_init(&tab->ops[btf->struct_ops_tab->cnt], btf, log);
  8663		if (err)
  8664			return err;
  8665	
  8666		btf->struct_ops_tab->cnt++;
  8667	
  8668		return 0;
  8669	}
  8670	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

