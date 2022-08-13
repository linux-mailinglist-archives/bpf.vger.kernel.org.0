Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B119591906
	for <lists+bpf@lfdr.de>; Sat, 13 Aug 2022 08:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiHMG0Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 13 Aug 2022 02:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbiHMG0P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 13 Aug 2022 02:26:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC688E0C0
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 23:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660371974; x=1691907974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9T3K+XG447imZFP6sUMqTXxGh+snQ8KBpvMp3XnnRwM=;
  b=iPfQxWPGS+AZN5EiZPW1RrlPn9iyKt2awvakaxgOlbQWnjHKUcTTWF6y
   ataaopoqnBjEmVAxRNQzHgWiHPOFTlBvqjAUVNeRaMrUJlPQP3IVmebFE
   AKLaRvqBpH+3Rvna7mRptwyWF32OrGR1zZPp922IENTsra+mFFx8bqgW2
   WuMIlsVcT3/Ykiy65JR7zN4MfjDPqbvLQiulUbVzNDNdTN2dpdC1wz/eC
   SOChDqOw25Z1U5J8N5gtXkMBJokrMbqd8GjQV9d4MdzvYyDz7HaeSvQKI
   HlGmmdqwK4SUSqVpVSLDh4mIkSnqqob8exW0KW8lL7nT9AXR41rRDvmvv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="289301966"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="289301966"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 23:26:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="639127027"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2022 23:26:10 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMkb3-0001Nu-2X;
        Sat, 13 Aug 2022 06:26:09 +0000
Date:   Sat, 13 Aug 2022 14:25:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf: use cgroup_{common,current}_func_proto
 in more hooks
Message-ID: <202208131415.CkdRZBrY-lkp@intel.com>
References: <20220812190241.3544528-3-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812190241.3544528-3-sdf@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220813/202208131415.CkdRZBrY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0429824054f7a843ee976d48432e825e493a0a7e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stanislav-Fomichev/bpf-expose-bpf_-g-s-et_retval-to-more-cgroup-hooks/20220813-030615
        git checkout 0429824054f7a843ee976d48432e825e493a0a7e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/helpers.c: In function 'cgroup_current_func_proto':
>> kernel/bpf/helpers.c:1817:25: error: 'bpf_get_cgroup_classid_curr_proto' undeclared (first use in this function)
    1817 |                 return &bpf_get_cgroup_classid_curr_proto;
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1817:25: note: each undeclared identifier is reported only once for each function it appears in


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
