Return-Path: <bpf+bounces-12959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49507D2757
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 01:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACE11C20983
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 23:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A1010967;
	Sun, 22 Oct 2023 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOMa2NFp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36FD533
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 23:43:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CEFEB;
	Sun, 22 Oct 2023 16:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698018205; x=1729554205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DyT6PnTT/oc9Q+V3yg1tRUU7lgRIJofWae5O90LzgAc=;
  b=ZOMa2NFpQZAG2bMUDOmUdtemkKeWxAskiP3COrRf2B4Gvf3XBC3zAw0Y
   2MLMhv4jC+BdQkm+zeScTI3lamZ+/dslh7N8tY7SLIJJlfoSUUMzRcrjr
   ACnDJbxpfeLOYcwdYj+Qz6YtBo8b73cCybmWMwOLcHwVrXEO3r4tmJeFn
   4Dm4pyqiNXGIdL/kCSnAcYSUYYuUT2SlP5t5gb3eMR7VpbdNwBXrd9mZu
   oilmebgQKum/F4H2TNENU8y4qa/TIB7wv1mfS4WTqWT0KVnrUoqprmOcE
   A+2+cpzdDqiZwYQVK4mh8yXo8ebViWgrhF3GlPxjAGmzblOnKeSbT/sxP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="5361564"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5361564"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 16:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5618519"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Oct 2023 16:42:06 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qui6I-0006NC-0W;
	Sun, 22 Oct 2023 23:43:18 +0000
Date: Mon, 23 Oct 2023 07:42:41 +0800
From: kernel test robot <lkp@intel.com>
To: Hengqi Chen <hengqi.chen@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, keescook@chromium.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, luto@amacapital.net,
	wad@chromium.org, alexyonghe@tencent.com, hengqi.chen@gmail.com
Subject: Re: [PATCH v2 2/5] seccomp, bpf: Introduce SECCOMP_LOAD_FILTER
 operation
Message-ID: <202310230704.Uif0R7cz-lkp@intel.com>
References: <20231015232953.84836-3-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015232953.84836-3-hengqi.chen@gmail.com>

Hi Hengqi,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/seccomp]
[also build test ERROR on bpf-next/master bpf/master linus/master v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hengqi-Chen/seccomp-Refactor-filter-copy-create-for-reuse/20231017-134654
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/seccomp
patch link:    https://lore.kernel.org/r/20231015232953.84836-3-hengqi.chen%40gmail.com
patch subject: [PATCH v2 2/5] seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
config: sh-shx3_defconfig (https://download.01.org/0day-ci/archive/20231023/202310230704.Uif0R7cz-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231023/202310230704.Uif0R7cz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310230704.Uif0R7cz-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/seccomp.c: In function 'seccomp_load_filter':
>> kernel/seccomp.c:2052:15: error: implicit declaration of function 'security_bpf_prog_alloc'; did you mean 'security_msg_msg_alloc'? [-Werror=implicit-function-declaration]
    2052 |         ret = security_bpf_prog_alloc(prog->aux);
         |               ^~~~~~~~~~~~~~~~~~~~~~~
         |               security_msg_msg_alloc
>> kernel/seccomp.c:2062:15: error: implicit declaration of function 'bpf_prog_new_fd'; did you mean 'bpf_prog_get_ok'? [-Werror=implicit-function-declaration]
    2062 |         ret = bpf_prog_new_fd(prog);
         |               ^~~~~~~~~~~~~~~
         |               bpf_prog_get_ok
   cc1: some warnings being treated as errors


vim +2052 kernel/seccomp.c

  2037	
  2038	static long seccomp_load_filter(const char __user *filter)
  2039	{
  2040		struct sock_fprog fprog;
  2041		struct bpf_prog *prog;
  2042		int ret;
  2043	
  2044		ret = seccomp_copy_user_filter(filter, &fprog);
  2045		if (ret)
  2046			return ret;
  2047	
  2048		ret = seccomp_prepare_prog(&prog, &fprog);
  2049		if (ret)
  2050			return ret;
  2051	
> 2052		ret = security_bpf_prog_alloc(prog->aux);
  2053		if (ret) {
  2054			bpf_prog_free(prog);
  2055			return ret;
  2056		}
  2057	
  2058		prog->aux->user = get_current_user();
  2059		atomic64_set(&prog->aux->refcnt, 1);
  2060		prog->type = BPF_PROG_TYPE_SECCOMP;
  2061	
> 2062		ret = bpf_prog_new_fd(prog);
  2063		if (ret < 0)
  2064			bpf_prog_put(prog);
  2065	
  2066		return ret;
  2067	}
  2068	#else
  2069	static inline long seccomp_set_mode_filter(unsigned int flags,
  2070						   const char __user *filter)
  2071	{
  2072		return -EINVAL;
  2073	}
  2074	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

