Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8415BB9DC
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiIQSTK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Sep 2022 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIQSTJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 14:19:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC642ED5E
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663438748; x=1694974748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DUa9obSGuiTqCP4Sfkc1Ji7qDShjKrPwVtjC8KTjhJg=;
  b=loMfMNH5YKi4/thSt/dnaL6G23vmNgVJH10NBXpOmehbFCsYczU6phKt
   uuu3P9TNRwa71v6NTowPYb95OG83b3sUwz/LrsyLJQMID7XGrLG82+H+n
   nMxwpBqJcXNdSiQz0MNdJlSFVJPPdmRgmhWD2+DS6XTd9GiFqe4oQ6kIt
   k9RO4mNoemqBk57AYCEbnWQl64GSUNOCDe76sxsv3/qNzzNB5Nj/8U5to
   D8b0D/uAgbaGesnEwnIdjnA3bUD1spZzjDnq/BsQ4c5adGLxGavTw+5hM
   2jYP17U7cKb3f7+daFaqLFSsHLeYE7rzQqyghnjhK2N3vw3kuC3erxvU5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="296761003"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="296761003"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 11:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="743671881"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Sep 2022 11:19:04 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZcP9-0000Vn-1N;
        Sat, 17 Sep 2022 18:19:03 +0000
Date:   Sun, 18 Sep 2022 02:18:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
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
Message-ID: <202209180234.jN58ZaBL-lkp@intel.com>
References: <20220917153125.2001645-4-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917153125.2001645-4-houtao@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: arm-randconfig-r016-20220917 (https://download.01.org/0day-ci/archive/20220918/202209180234.jN58ZaBL-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/1995ae6874ef9089b4eee12c00ba9c5af264b8bc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hou-Tao/Add-support-for-qp-trie-map/20220917-231450
        git checkout 1995ae6874ef9089b4eee12c00ba9c5af264b8bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __get_user_bad
   >>> referenced by syscall.c:1368 (kernel/bpf/syscall.c:1368)
   >>>               bpf/syscall.o:(bpf_copy_to_dynptr_ukey) in archive kernel/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
