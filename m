Return-Path: <bpf+bounces-62372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FEAAF8A09
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 09:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5122758807D
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 07:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375772857E2;
	Fri,  4 Jul 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNsGA9/w"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DE2853F2;
	Fri,  4 Jul 2025 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615609; cv=none; b=NoHysn7yOQ6CZoSibj+Vuv3Q2ktZR6EfFn7NulY2CfLrqVkgq8WC5MqAqhbwB8DashQoD8GO1I4dyG1vw14V14bcSRFFdzTWA8aKhLTHWqsx5kaCiNKEUq7JGot2Mlv3MJBgwXD/j+mzZTR7XrwYABk9+B5DUcPGmQhiVZHwpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615609; c=relaxed/simple;
	bh=ZdZeDvwAdfj+H2jUqMsIQrpXt8OaXU7cK/xIUwt15G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkNCcLLmnOBJATH5z+LXT77gEXI58SsPAmPyBs4QfZXyOj/7azSa8KjknjnEC7ynnR6fbXQC7cmCbzKe5xdOujQ6zMzRztGzjAq4WRN6adjMdHgnEROKZKtCl2OZhD+PXTJHnBzt1H7mZTZdR2/YKIgiRelYiIS23GEaRiMfTqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNsGA9/w; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615608; x=1783151608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZdZeDvwAdfj+H2jUqMsIQrpXt8OaXU7cK/xIUwt15G8=;
  b=PNsGA9/wYClFeAzlm2pjyy71EaXcWorrUQffGXVdH6V2Eixmgz9zZQeU
   8sTn9bLjOmMqlGj6KGenI4K0oyn9Yl0aXHwKBiqW119VXVESocKfp73fw
   I/CKkUAC3Zf2cZdxJQEyzN7V78CiK0pwLtmLvJ+AomdWibSEOELDCoEw5
   TS7TeG5AyfPif7Qj+hpdigIp1fWzt01XwB7nbN7Ck1HRTuczpsrTM0Gsl
   CWrKRVTFctRZV61rC35M0CIYY3sxpildpkLM+YsJX5w9e4HafqOIeZysJ
   LAHbOgW0OdV50eRtHLKZAPsxDmpeCFdCPZ0uD6vBu+T1lN/LfgvVnV+oA
   w==;
X-CSE-ConnectionGUID: +DnNvACRSM2rgw2prEPxaA==
X-CSE-MsgGUID: J0B56VyYShCaJoR6xBscVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53170629"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="53170629"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:53:27 -0700
X-CSE-ConnectionGUID: sNkwmTg4SHGk5NEM04z2WA==
X-CSE-MsgGUID: rXw/kqZySimgsnN+J2s+NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="160259243"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 Jul 2025 00:53:23 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXbEW-0003Sp-2t;
	Fri, 04 Jul 2025 07:53:20 +0000
Date: Fri, 4 Jul 2025 15:52:40 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
	rostedt@goodmis.org, jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 05/18] bpf: introduce bpf_gtramp_link
Message-ID: <202507041510.pXgjmaZP-lkp@intel.com>
References: <20250703121521.1874196-6-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703121521.1874196-6-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/bpf-add-function-hash-table-for-tracing-multi/20250703-203035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250703121521.1874196-6-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next v2 05/18] bpf: introduce bpf_gtramp_link
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20250704/202507041510.pXgjmaZP-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507041510.pXgjmaZP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507041510.pXgjmaZP-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: init/do_mounts.o: in function `bpf_gtrampoline_link_prog':
>> (.text+0x30): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: init/do_mounts.o: in function `bpf_gtrampoline_unlink_prog':
>> (.text+0x40): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: init/noinitramfs.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x0): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: init/noinitramfs.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x10): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: arch/alpha/kernel/osf_sys.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x1190): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: arch/alpha/kernel/osf_sys.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x11a0): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: arch/alpha/kernel/signal.o: in function `bpf_gtrampoline_link_prog':
   (.text+0xb90): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: arch/alpha/kernel/signal.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0xba0): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: arch/alpha/kernel/ptrace.o: in function `bpf_gtrampoline_link_prog':
   (.text+0xe0): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: arch/alpha/kernel/ptrace.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0xf0): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: arch/alpha/kernel/pci.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x1a0): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: arch/alpha/kernel/pci.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x1b0): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: arch/alpha/mm/fault.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x1c0): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: arch/alpha/mm/fault.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x1d0): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/fork.o: in function `bpf_gtrampoline_link_prog':
   (.text+0xd30): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/fork.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0xd40): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/exec_domain.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x40): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/exec_domain.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x50): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/cpu.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x890): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/cpu.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x8a0): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/exit.o: in function `bpf_gtrampoline_link_prog':
   (.text+0xac0): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/exit.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0xad0): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/resource.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x1560): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/resource.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x1570): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/sysctl.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x24c0): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/sysctl.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x24d0): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/capability.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x770): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/capability.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x780): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/ptrace.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x460): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/ptrace.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x470): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/signal.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x2270): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/signal.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x2280): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/sys.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x18e0): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/sys.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x18f0): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/umh.o: in function `bpf_gtrampoline_link_prog':
   (.text+0xb40): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/umh.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0xb50): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/pid.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x890): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/pid.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x8a0): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/extable.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x0): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/extable.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x10): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/params.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x1240): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/params.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x1250): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/nsproxy.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x530): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/nsproxy.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x540): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/cred.o: in function `bpf_gtrampoline_link_prog':
   (.text+0xb10): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/cred.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0xb20): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/reboot.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x1860): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/reboot.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x1870): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/ksyms_common.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x0): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/ksyms_common.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x10): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here
   alpha-linux-ld: kernel/groups.o: in function `bpf_gtrampoline_link_prog':
   (.text+0x460): multiple definition of `bpf_gtrampoline_link_prog'; init/main.o:(.text+0x0): first defined here
   alpha-linux-ld: kernel/groups.o: in function `bpf_gtrampoline_unlink_prog':
   (.text+0x470): multiple definition of `bpf_gtrampoline_unlink_prog'; init/main.o:(.text+0x10): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

