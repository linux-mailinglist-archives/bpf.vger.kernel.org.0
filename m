Return-Path: <bpf+bounces-21583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B584EF64
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E121F24EF5
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0B24C90;
	Fri,  9 Feb 2024 03:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wdcy3yLo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF84C89
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707449359; cv=none; b=YLZNxJFGDPDMjJZoeMwD+zJCWTnOsdXtd0ELOlmRDg8XlMgNbDoh/o15t6/4wQIOgcYW09y9oMe0dF4XWLi/tlwRHivjN9xskJdZyZ9ogyL2upFBCNgo9IZwd85xcYdWhZhqGPi5LAK9WmMb7CZBCP+bVJtATPm8vv9641G/mk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707449359; c=relaxed/simple;
	bh=2DUaRib+tNUB/asNb4vB4P49u+cpzOyMtGinC6pI7gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8KNidtkcNc0/gf92r2cdxvDZBbOoOdsFC+8JxVCXuzXiUdulMOe7j1DOr5xs65LoOC0/KfzMoYTrTcQvgC86dfuGXPDBIGkiyNeSxvwTr+2tBiy1Evl7/N+C4L6+A5X3/qvkukEZMPhRdIWcVRVNTG84OUi8aZ6tykJLUNbp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wdcy3yLo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707449357; x=1738985357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2DUaRib+tNUB/asNb4vB4P49u+cpzOyMtGinC6pI7gQ=;
  b=Wdcy3yLoJgsek/7S2KepBIQVT2RxxIU3HMgZDc5ZIhSOpAVB8tZtKNTs
   CgluQuoNfrcYohLGc29ofVpAxhcCjALZWFrQmYGR4y7IHwSGcsif+4inA
   aUmWmXiXO79WiNpzjbAQWPxJzSRKdo/x/hSq7npENhZCK8+LA2hrbS76e
   35y0yWCfKrPiZT7wJUFlj/DLday4E/W4wWKdL67AGu9qFGgZ1WfPCD0La
   cedQAP/WST63iesHgC/ZEeQS1SItpSuJYc2Xq7FDG8zBU0uAjtwSC0rm+
   aYT1E6GEnzTIVL4u17paoBaDl0ozocQ3B6Cfbi4UqBQ92oOSv9wg1UPxE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1259223"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1259223"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:29:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="6610135"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Feb 2024 19:29:11 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYHZd-0004MM-2q;
	Fri, 09 Feb 2024 03:29:09 +0000
Date: Fri, 9 Feb 2024 11:28:13 +0800
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
Subject: Re: [PATCH bpf-next v3 1/2] bpf, btf: Add register_check_missing_btf
 helper
Message-ID: <202402091146.VUsU5iPl-lkp@intel.com>
References: <6dfe28c4045e1a3d31b3ba60dde31c7650ac66df.1707029682.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dfe28c4045e1a3d31b3ba60dde31c7650ac66df.1707029682.git.tanggeliang@kylinos.cn>

Hi Geliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Geliang-Tang/bpf-btf-Add-register_check_missing_btf-helper/20240204-150130
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/6dfe28c4045e1a3d31b3ba60dde31c7650ac66df.1707029682.git.tanggeliang%40kylinos.cn
patch subject: [PATCH bpf-next v3 1/2] bpf, btf: Add register_check_missing_btf helper
config: x86_64-buildonly-randconfig-004-20240209 (https://download.01.org/0day-ci/archive/20240209/202402091146.VUsU5iPl-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240209/202402091146.VUsU5iPl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402091146.VUsU5iPl-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/btf.c: In function 'btf_seq_show':
   kernel/bpf/btf.c:7287:22: warning: function 'btf_seq_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7287 |  seq_vprintf((struct seq_file *)show->target, fmt, args);
         |                      ^~~~~~~~
   kernel/bpf/btf.c: In function 'btf_snprintf_show':
   kernel/bpf/btf.c:7324:2: warning: function 'btf_snprintf_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7324 |  len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
         |  ^~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from arch/x86/include/asm/paravirt.h:19,
                    from arch/x86/include/asm/cpuid.h:62,
                    from arch/x86/include/asm/processor.h:19,
                    from include/linux/sched.h:13,
                    from include/linux/ptrace.h:6,
                    from include/uapi/asm-generic/bpf_perf_event.h:4,
                    from ./arch/x86/include/generated/uapi/asm/bpf_perf_event.h:1,
                    from include/uapi/linux/bpf_perf_event.h:11,
                    from kernel/bpf/btf.c:6:
   kernel/bpf/btf.c: In function 'register_check_missing_btf':
>> kernel/bpf/btf.c:7751:11: error: dereferencing pointer to incomplete type 'const struct module'
    7751 |     module->name, msg);
         |           ^~
   include/linux/printk.h:427:19: note: in definition of macro 'printk_index_wrap'
     427 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |                   ^~~~~~~~~~~
   include/linux/printk.h:508:2: note: in expansion of macro 'printk'
     508 |  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~
   kernel/bpf/btf.c:7750:4: note: in expansion of macro 'pr_warn'
    7750 |    pr_warn("allow module %s BTF mismatch, skip register %s\n",
         |    ^~~~~~~


vim +7751 kernel/bpf/btf.c

  7741	
  7742	static int register_check_missing_btf(const struct module *module, const char *msg)
  7743	{
  7744		if (!module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
  7745			pr_err("missing vmlinux BTF, cannot register %s\n", msg);
  7746			return -ENOENT;
  7747		}
  7748		if (module && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
  7749			if (IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
  7750				pr_warn("allow module %s BTF mismatch, skip register %s\n",
> 7751					module->name, msg);
  7752				return 0;
  7753			}
  7754			pr_err("missing module %s BTF, cannot register %s\n", module->name, msg);
  7755			return -ENOENT;
  7756		}
  7757		return 0;
  7758	}
  7759	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

