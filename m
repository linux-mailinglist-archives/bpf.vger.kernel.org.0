Return-Path: <bpf+bounces-21140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DF18489D8
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 01:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C0428523F
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 00:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52F17F7;
	Sun,  4 Feb 2024 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDIhNGCD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DCD637
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707005720; cv=none; b=Cc5wze+NNleeSrTZEyDFsbddDJwb07hkJW/G/8+3c7OvLkpd8AETnsxcFoRtlmmA2NgUSdqNaT04P2jlAUO3wgdlqqasCjEgaf1pZsKvwoAZOIMSoqMh8gRncf+ouTfbam1MNd0I8GC/mpIWnuLNPTKBfBC0cvubLmjNJylM8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707005720; c=relaxed/simple;
	bh=Qmetxv98oqYTe4Vwuh5lGAp8R2QMprpLFMDJJirpkAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpmOe86cPB4W5dDPNUJTdjaqF+Fvq+12woRbpyHMW95JLy0EVtg7LbMHpCSmYuSbW12zKlAlBQTnQniCba0dBvFr98QhjeN1tNy04PVvmti/smgtWLgEZGAoL5pu6SxiFQro5ir9Tu0sHQr3Ok+HOmwbdUFajc0KWrPIL5npBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDIhNGCD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707005719; x=1738541719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qmetxv98oqYTe4Vwuh5lGAp8R2QMprpLFMDJJirpkAc=;
  b=SDIhNGCDPneRdN7sbb1Nn/5ppaYHtvNFI4PvfNyo/jXfTEmQ17wscSZm
   65d3HBg41euAlrxExSKUsG7ezMEvCn12+kjV/U7HL+iFNP9/YWwSjB0Ry
   eVrC9bTvS9izHkHzAzj1HTWzvBTJ/kXF0AJcNZcPf8iLfhKZX4VcB9p7K
   9S+Qhqr6Igq33Xgncvpz8khZu3U7WYI2A/vRilrDC7bS3AdKP0YTCP/1B
   R5JcwDIsceHKuPuqQXnD/aRQqXHU+dmf+PDVK2+x2xxOgUmZATyxADu1X
   NxRceVPV+ponhYyMKoVCvv0qFFly8BE4lhy4QJD7XZMJ4x2lzXNmLqMYX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="11708711"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="11708711"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 16:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="710111"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 03 Feb 2024 16:15:13 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWQAA-0005mI-2P;
	Sun, 04 Feb 2024 00:15:10 +0000
Date: Sun, 4 Feb 2024 08:14:54 +0800
From: kernel test robot <lkp@intel.com>
To: Geliang Tang <geliang@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 1/2] bpf, btf: Add register_check_missing_btf
 helper
Message-ID: <202402040740.WcfFYJQX-lkp@intel.com>
References: <f4b147ddaa8fe8c07c7ba77a1d61780bffc49bb6.1706946547.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4b147ddaa8fe8c07c7ba77a1d61780bffc49bb6.1706946547.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/bpf-btf-Add-register_check_missing_btf-helper/20240203-155524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/f4b147ddaa8fe8c07c7ba77a1d61780bffc49bb6.1706946547.git.tanggeliang%40kylinos.cn
patch subject: [PATCH bpf-next v2 1/2] bpf, btf: Add register_check_missing_btf helper
config: arm-randconfig-001-20240204 (https://download.01.org/0day-ci/archive/20240204/202402040740.WcfFYJQX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402040740.WcfFYJQX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402040740.WcfFYJQX-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/btf.c: In function 'btf_seq_show':
   kernel/bpf/btf.c:7286:29: warning: function 'btf_seq_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7286 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
         |                             ^~~~~~~~
   kernel/bpf/btf.c: In function 'btf_snprintf_show':
   kernel/bpf/btf.c:7323:9: warning: function 'btf_snprintf_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7323 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
         |         ^~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/linux/sched.h:14,
                    from include/linux/ptrace.h:6,
                    from include/uapi/asm-generic/bpf_perf_event.h:4,
                    from ./arch/arm/include/generated/uapi/asm/bpf_perf_event.h:1,
                    from include/uapi/linux/bpf_perf_event.h:11,
                    from kernel/bpf/btf.c:6:
   kernel/bpf/btf.c: In function 'register_check_missing_btf':
>> kernel/bpf/btf.c:7750:39: error: invalid use of undefined type 'const struct module'
    7750 |                                 module->name, msg);
         |                                       ^~
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:508:9: note: in expansion of macro 'printk'
     508 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   kernel/bpf/btf.c:7749:25: note: in expansion of macro 'pr_warn'
    7749 |                         pr_warn("allow module %s BTF mismatch, skip register %s\n",
         |                         ^~~~~~~
   kernel/bpf/btf.c:7753:77: error: invalid use of undefined type 'const struct module'
    7753 |                 pr_err("missing module %s BTF, cannot register %s\n", module->name, msg);
         |                                                                             ^~
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:498:9: note: in expansion of macro 'printk'
     498 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   kernel/bpf/btf.c:7753:17: note: in expansion of macro 'pr_err'
    7753 |                 pr_err("missing module %s BTF, cannot register %s\n", module->name, msg);
         |                 ^~~~~~


vim +7750 kernel/bpf/btf.c

  7740	
  7741	static int register_check_missing_btf(const struct module *module, const char *msg)
  7742	{
  7743		if (!module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
  7744			pr_err("missing vmlinux BTF, cannot register %s\n", msg);
  7745			return -ENOENT;
  7746		}
  7747		if (module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
  7748			if (IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
  7749				pr_warn("allow module %s BTF mismatch, skip register %s\n",
> 7750					module->name, msg);
  7751				return 0;
  7752			}
  7753			pr_err("missing module %s BTF, cannot register %s\n", module->name, msg);
  7754			return -ENOENT;
  7755		}
  7756		return 0;
  7757	}
  7758	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

