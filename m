Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089A05A3F3D
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 21:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiH1TEb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH1TEa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 15:04:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F12018E21
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661713469; x=1693249469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PC+dSnw9cgmrjdtbWq+88KGaaocDnbHS3m+MTnS/joQ=;
  b=OqSco89Ul3ovb0OJjL8+pJb3aTI6Uf5VzBBQU/oXPAeXLCTemSzgaVzB
   yh4ih7MS83OSzFEKS4s0SEprtA2ihpkyAQEI8NqzwmR2yJaPRbKsJ6BRP
   areyYodsR2qF3IqBbctcoL7Jpg3aChkqYPkT52r6bQrP1AnoswZgNveyP
   vSDu+eKb8/NBllMpwEww1LmYVex7P4e0eodVBfQy2TcqfigSgTCs5/nq8
   AzsItub37Ki3t4edrHPQ+nNNSEe+bQRw5UL+UUUeMbuTRtYyxzZk8gah0
   Lx7WHpEcTUL0+5bQcdfmFe9T7sjXGrquwPChZ6310eNCE8t+4I5tTD1o+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="295537490"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="295537490"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 12:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="644194578"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Aug 2022 12:04:27 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSNa6-0001VJ-1Q;
        Sun, 28 Aug 2022 19:04:26 +0000
Date:   Mon, 29 Aug 2022 03:03:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Reboredo <yakoyoku@gmail.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add config for skipping BTF enum64s
Message-ID: <202208290218.ZY8JJWnv-lkp@intel.com>
References: <20220828165124.20261-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828165124.20261-1-yakoyoku@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Martin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Reboredo/bpf-Add-config-for-skipping-BTF-enum64s/20220829-005156
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: csky-randconfig-r005-20220828 (https://download.01.org/0day-ci/archive/20220829/202208290218.ZY8JJWnv-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f3a761ad9050394b31ca80192708bea109c5e536
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Reboredo/bpf-Add-config-for-skipping-BTF-enum64s/20220829-005156
        git checkout f3a761ad9050394b31ca80192708bea109c5e536
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 ARCH=csky 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> grep: include/config/auto.conf: No such file or directory
>> grep: include/config/auto.conf: No such file or directory
>> grep: include/config/auto.conf: No such file or directory

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
