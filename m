Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9894C5360
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 03:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiBZCeQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 21:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiBZCeM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 21:34:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8447190B48;
        Fri, 25 Feb 2022 18:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645842817; x=1677378817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BVLclhNw0PC2QXbhzFkl59rdBrw4CM2n4+zDU93oWUg=;
  b=RNVJUyw2sIrrFCX3/11XoDECw4DXBPvbYzrGFl/WEMWeW7WSsaaVS+A/
   qn2yAA48G1ev27T3kVWif2b3DNqlOruLodgiVZIKS8UbiTIknC7o67Bg0
   ehx1bogg3drzCYsSuStXAGsCzs4zymUe1JqT4Wz79q68ynTEyYmQSjxap
   uF6H7VCDd8v6XuNO8ty6SXHd5TMqVSYhShY+ecyNHoOKDdfEqzmUoB+qy
   mhroYyLfXmWL06ZGIg9FWgSKMMM/FX8SPq6w0YH+UiGnKUYOun5T3jOp+
   eVVCEROnDnUaKHAfEbF6wCYjAdq4Czy3ij3+7z9HAH6A5GjH58yC+sSAK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="232594764"
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="232594764"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 18:33:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="574789079"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2022 18:33:33 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNmto-0004yB-O0; Sat, 26 Feb 2022 02:33:32 +0000
Date:   Sat, 26 Feb 2022 10:32:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
Message-ID: <202202261010.IU59MxY8-lkp@intel.com>
References: <20220225234339.2386398-9-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225234339.2386398-9-haoluo@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Hao-Luo/Extend-cgroup-interface-with-bpf/20220226-074615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: hexagon-randconfig-r023-20220226 (https://download.01.org/0day-ci/archive/20220226/202202261010.IU59MxY8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ee74423719e2efb4efa7a4491920c78b60024ec7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Hao-Luo/Extend-cgroup-interface-with-bpf/20220226-074615
        git checkout ee74423719e2efb4efa7a4491920c78b60024ec7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/cgroup_iter.c:107:39: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
           seq_printf(seq, "cgroup_id:\t%lu\n", aux->cgroup_id);
                                        ~~~     ^~~~~~~~~~~~~~
                                        %llu
>> kernel/bpf/cgroup_iter.c:101:6: warning: no previous prototype for function 'bpf_iter_cgroup_show_fdinfo' [-Wmissing-prototypes]
   void bpf_iter_cgroup_show_fdinfo(const struct bpf_iter_aux_info *aux,
        ^
   kernel/bpf/cgroup_iter.c:101:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_iter_cgroup_show_fdinfo(const struct bpf_iter_aux_info *aux,
   ^
   static 
>> kernel/bpf/cgroup_iter.c:111:5: warning: no previous prototype for function 'bpf_iter_cgroup_fill_link_info' [-Wmissing-prototypes]
   int bpf_iter_cgroup_fill_link_info(const struct bpf_iter_aux_info *aux,
       ^
   kernel/bpf/cgroup_iter.c:111:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int bpf_iter_cgroup_fill_link_info(const struct bpf_iter_aux_info *aux,
   ^
   static 
   3 warnings generated.


vim +107 kernel/bpf/cgroup_iter.c

   100	
 > 101	void bpf_iter_cgroup_show_fdinfo(const struct bpf_iter_aux_info *aux,
   102					 struct seq_file *seq)
   103	{
   104		char buf[64] = {0};
   105	
   106		cgroup_path_from_kernfs_id(aux->cgroup_id, buf, sizeof(buf));
 > 107		seq_printf(seq, "cgroup_id:\t%lu\n", aux->cgroup_id);
   108		seq_printf(seq, "cgroup_path:\t%s\n", buf);
   109	}
   110	
 > 111	int bpf_iter_cgroup_fill_link_info(const struct bpf_iter_aux_info *aux,
   112					   struct bpf_link_info *info)
   113	{
   114		info->iter.cgroup.cgroup_id = aux->cgroup_id;
   115		return 0;
   116	}
   117	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
