Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26810591C5F
	for <lists+bpf@lfdr.de>; Sat, 13 Aug 2022 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiHMS4e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 13 Aug 2022 14:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiHMS4d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 13 Aug 2022 14:56:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E618014D19
        for <bpf@vger.kernel.org>; Sat, 13 Aug 2022 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660416991; x=1691952991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZBPDfSeBK9w+B+8JdjaWQ3ncVRB2cbox7kKTBR+j8R4=;
  b=U2clF9qrE/EVPWPFhcSB+PZCTB+br3ZXDCQSVLXrlHjwjufMmXR0upiH
   ofVqW40JnVtWAvmtMdrwDr6KBN9sZ9ekTGARXb77iCweQd6GXxxtv+0yg
   4MaTbfvs8riDSi0dSgyM2YQKqd0K7e8JGwk6q4cDr0gn8xTCw5IKxaZbk
   yms8N/Ch6XTpgKs76Z52NBfLRyjkDciaNI9ZnChWpNE35RjJeg0kWEip4
   2t0MV4U6L0+GEOpgylfGjB1cAC3kXRO9laOrxNg0Q9MLFccm/Wo7PZIzT
   9lSZScKIJeMIOP0tTfEr0mNGBqxo++EZKnhuQzkX0O90KpR971PoPYJo9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="378061747"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="378061747"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 11:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="709345965"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2022 11:56:28 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMwJ9-00020D-1R;
        Sat, 13 Aug 2022 18:56:27 +0000
Date:   Sun, 14 Aug 2022 02:55:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf: use cgroup_{common,current}_func_proto
 in more hooks
Message-ID: <202208140239.yjzPuMmv-lkp@intel.com>
References: <20220812190241.3544528-3-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812190241.3544528-3-sdf@google.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Stanislav,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/bpf-expose-bpf_-g-s-et_retval-to-more-cgroup-hooks/20220813-030615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220814/202208140239.yjzPuMmv-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2f79185bafd678f310fafadba2a8c76d2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0429824054f7a843ee976d48432e825e493a0a7e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stanislav-Fomichev/bpf-expose-bpf_-g-s-et_retval-to-more-cgroup-hooks/20220813-030615
        git checkout 0429824054f7a843ee976d48432e825e493a0a7e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/bpf/helpers.c:1817:11: error: use of undeclared identifier 'bpf_get_cgroup_classid_curr_proto'
                   return &bpf_get_cgroup_classid_curr_proto;
                           ^
   1 error generated.


vim +/bpf_get_cgroup_classid_curr_proto +1817 kernel/bpf/helpers.c

  1797	
  1798	/* Common helpers for cgroup hooks with valid process context. */
  1799	const struct bpf_func_proto *
  1800	cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
  1801	{
  1802		switch (func_id) {
  1803	#ifdef CONFIG_CGROUPS
  1804		case BPF_FUNC_get_current_uid_gid:
  1805			return &bpf_get_current_uid_gid_proto;
  1806		case BPF_FUNC_get_current_pid_tgid:
  1807			return &bpf_get_current_pid_tgid_proto;
  1808		case BPF_FUNC_get_current_comm:
  1809			return &bpf_get_current_comm_proto;
  1810		case BPF_FUNC_get_current_cgroup_id:
  1811			return &bpf_get_current_cgroup_id_proto;
  1812		case BPF_FUNC_get_current_ancestor_cgroup_id:
  1813			return &bpf_get_current_ancestor_cgroup_id_proto;
  1814	#endif
  1815	#ifdef CONFIG_CGROUP_NET_CLASSID
  1816		case BPF_FUNC_get_cgroup_classid:
> 1817			return &bpf_get_cgroup_classid_curr_proto;
  1818	#endif
  1819		default:
  1820			return NULL;
  1821		}
  1822	}
  1823	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
