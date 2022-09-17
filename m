Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD55BB9E3
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 20:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIQSaL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Sep 2022 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIQSaK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 14:30:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDFF1EC54
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663439408; x=1694975408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ELwPJT7af7BjaCS6LhxRg0QKlDekTfwIuWnjVzbHU8s=;
  b=NtMr6gdBkoyskVURt2uSdinc/ggZhbaXq9AIKsO3iaFf5RD3ideWaQD8
   lTU816Qw5+aPeoDpgiePHOxfgg4poPnq0V7Fze0yb2cIer1KzlWXUgh3w
   jLMkduLxz1Teeb2GDpDFgU0Jbwe997pHZb5hmEgM4xzMAekVBh9X+EIFp
   aHKmBHAaTva0DfCH97EUM5QrMqXxdkSY2hTVzKMk21liyB1odk2H+qSjZ
   d1yLHcG3CJVZGMoZG/ynTV+nE0eLJtwYFEkNvA4XJava1fEGGkE8lyvFD
   9cErSjbSDy7FAYTVPpicRvkeyOxexqENxQf91w2Lw/r3NTXQ3iCIHnt+Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="300543417"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="300543417"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 11:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="618035924"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 Sep 2022 11:30:04 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZcZn-0000Vz-1h;
        Sat, 17 Sep 2022 18:30:03 +0000
Date:   Sun, 18 Sep 2022 02:29:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kbuild-all@lists.01.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next 03/10] bpf: Support bpf_dynptr-typed map key for
 bpf syscall
Message-ID: <202209180207.PvS9ya46-lkp@intel.com>
References: <20220917153125.2001645-4-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917153125.2001645-4-houtao@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hou,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Hou-Tao/Add-support-for-qp-trie-map/20220917-231450
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: arm-randconfig-r002-20220917 (https://download.01.org/0day-ci/archive/20220918/202209180207.PvS9ya46-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1995ae6874ef9089b4eee12c00ba9c5af264b8bc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hou-Tao/Add-support-for-qp-trie-map/20220917-231450
        git checkout 1995ae6874ef9089b4eee12c00ba9c5af264b8bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: kernel/bpf/syscall.o: in function `bpf_copy_to_dynptr_ukey':
>> kernel/bpf/syscall.c:1368: undefined reference to `__get_user_bad'
   pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized


vim +1368 kernel/bpf/syscall.c

  1361	
  1362	static int bpf_copy_to_dynptr_ukey(struct bpf_dynptr_user __user *uptr,
  1363					   struct bpf_dynptr_kern *kptr)
  1364	{
  1365		unsigned int size;
  1366		u64 udata;
  1367	
> 1368		if (get_user(udata, &uptr->data))
  1369			return -EFAULT;
  1370	
  1371		/* Also zeroing the reserved field in uptr */
  1372		size = bpf_dynptr_get_size(kptr);
  1373		if (copy_to_user(u64_to_user_ptr(udata), kptr->data + kptr->offset, size) ||
  1374		    put_user(size, &uptr->size) || put_user(0, &uptr->size + 1))
  1375			return -EFAULT;
  1376	
  1377		return 0;
  1378	}
  1379	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
