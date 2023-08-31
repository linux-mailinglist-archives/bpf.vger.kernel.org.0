Return-Path: <bpf+bounces-9044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E9878EBA6
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 13:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB17B281476
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A48F75;
	Thu, 31 Aug 2023 11:11:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097488F5D;
	Thu, 31 Aug 2023 11:11:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E278E63;
	Thu, 31 Aug 2023 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693480295; x=1725016295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O3UskZztiSHiG62oxbXUlE5RV3C35EYtv8AyacANeBw=;
  b=MXP5XDGiXv8AykbV7re4ZeIY+hL0ssvb4awmtPdznjkFnvXATN/NAjzJ
   K6DeK+ib3j+C/G4tnugkWoGOuuP8HvVPTjalfGXydmUK2hrf14nrp1PpN
   NzC6cwTdxZ7cMrT8xloT/sYXCXTa+S+1q61GQM4h2bNeApghqHNQhHJ1M
   ZqasdFDAO1z+gVWgiF40SQ1tFEcdrRmcToouYHNSL6ORxLTXbb5/BZ6M+
   m6xRD0FuWkVLhV0wS4wAWDHf47vBk9FwPcMwYWIkzc0mh8aJIME7fR5x0
   jhaKCj6I5EDSXSuZ7ESB1QSk/Ek3lS4zz6HZRKBL6w07+vLiSFQ01aCm2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="366099750"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="366099750"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="854136946"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="854136946"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2023 04:10:46 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qbfZU-00004N-0A;
	Thu, 31 Aug 2023 11:10:44 +0000
Date: Thu, 31 Aug 2023 19:10:07 +0800
From: kernel test robot <lkp@intel.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf-next] bpf, sockmap: Rename sock_map_get_from_fd to
 sock_map_prog_attach
Message-ID: <202308311959.Snzn4Unt-lkp@intel.com>
References: <20230831014346.2931397-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831014346.2931397-1-xukuohai@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Xu,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Kuohai/bpf-sockmap-Rename-sock_map_get_from_fd-to-sock_map_prog_attach/20230831-094551
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230831014346.2931397-1-xukuohai%40huaweicloud.com
patch subject: [PATCH bpf-next] bpf, sockmap: Rename sock_map_get_from_fd to sock_map_prog_attach
config: parisc-randconfig-r012-20230831 (https://download.01.org/0day-ci/archive/20230831/202308311959.Snzn4Unt-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308311959.Snzn4Unt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308311959.Snzn4Unt-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_prog_attach':
>> kernel/bpf/syscall.c:3825:23: error: implicit declaration of function 'sock_map_prog_attach'; did you mean 'sock_map_prog_detach'? [-Werror=implicit-function-declaration]
    3825 |                 ret = sock_map_prog_attach(attr, prog);
         |                       ^~~~~~~~~~~~~~~~~~~~
         |                       sock_map_prog_detach
   cc1: some warnings being treated as errors


vim +3825 kernel/bpf/syscall.c

  3782	
  3783	#define BPF_F_ATTACH_MASK_BASE	\
  3784		(BPF_F_ALLOW_OVERRIDE |	\
  3785		 BPF_F_ALLOW_MULTI |	\
  3786		 BPF_F_REPLACE)
  3787	
  3788	#define BPF_F_ATTACH_MASK_MPROG	\
  3789		(BPF_F_REPLACE |	\
  3790		 BPF_F_BEFORE |		\
  3791		 BPF_F_AFTER |		\
  3792		 BPF_F_ID |		\
  3793		 BPF_F_LINK)
  3794	
  3795	static int bpf_prog_attach(const union bpf_attr *attr)
  3796	{
  3797		enum bpf_prog_type ptype;
  3798		struct bpf_prog *prog;
  3799		u32 mask;
  3800		int ret;
  3801	
  3802		if (CHECK_ATTR(BPF_PROG_ATTACH))
  3803			return -EINVAL;
  3804	
  3805		ptype = attach_type_to_prog_type(attr->attach_type);
  3806		if (ptype == BPF_PROG_TYPE_UNSPEC)
  3807			return -EINVAL;
  3808		mask = bpf_mprog_supported(ptype) ?
  3809		       BPF_F_ATTACH_MASK_MPROG : BPF_F_ATTACH_MASK_BASE;
  3810		if (attr->attach_flags & ~mask)
  3811			return -EINVAL;
  3812	
  3813		prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
  3814		if (IS_ERR(prog))
  3815			return PTR_ERR(prog);
  3816	
  3817		if (bpf_prog_attach_check_attach_type(prog, attr->attach_type)) {
  3818			bpf_prog_put(prog);
  3819			return -EINVAL;
  3820		}
  3821	
  3822		switch (ptype) {
  3823		case BPF_PROG_TYPE_SK_SKB:
  3824		case BPF_PROG_TYPE_SK_MSG:
> 3825			ret = sock_map_prog_attach(attr, prog);
  3826			break;
  3827		case BPF_PROG_TYPE_LIRC_MODE2:
  3828			ret = lirc_prog_attach(attr, prog);
  3829			break;
  3830		case BPF_PROG_TYPE_FLOW_DISSECTOR:
  3831			ret = netns_bpf_prog_attach(attr, prog);
  3832			break;
  3833		case BPF_PROG_TYPE_CGROUP_DEVICE:
  3834		case BPF_PROG_TYPE_CGROUP_SKB:
  3835		case BPF_PROG_TYPE_CGROUP_SOCK:
  3836		case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
  3837		case BPF_PROG_TYPE_CGROUP_SOCKOPT:
  3838		case BPF_PROG_TYPE_CGROUP_SYSCTL:
  3839		case BPF_PROG_TYPE_SOCK_OPS:
  3840		case BPF_PROG_TYPE_LSM:
  3841			if (ptype == BPF_PROG_TYPE_LSM &&
  3842			    prog->expected_attach_type != BPF_LSM_CGROUP)
  3843				ret = -EINVAL;
  3844			else
  3845				ret = cgroup_bpf_prog_attach(attr, ptype, prog);
  3846			break;
  3847		case BPF_PROG_TYPE_SCHED_CLS:
  3848			ret = tcx_prog_attach(attr, prog);
  3849			break;
  3850		default:
  3851			ret = -EINVAL;
  3852		}
  3853	
  3854		if (ret)
  3855			bpf_prog_put(prog);
  3856		return ret;
  3857	}
  3858	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

