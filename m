Return-Path: <bpf+bounces-21143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB55848A1C
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 02:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5317282A90
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 01:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DAEDE;
	Sun,  4 Feb 2024 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZz8iyKj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C5E17F7
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009597; cv=none; b=oWuyxrPZVpbMqwmq8nfDojQ21gVUWsRn8ABrDg8kQXWgnXPppUuJmBsPngT4MDFLLqnLa9MeDAX69pyisbOLYE/e3qZnpR8be0T7Jg66bUNTFs+1XW3JphLveyRn8NIRLDuhlwhjyMOGZc6aFOFwbayhispn+cWvoZeZANmBnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009597; c=relaxed/simple;
	bh=gynVH3mnYBen4IZImceAFmZdt7Oj+QDmyHtWJsldE9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5Zkfo3/K/41aOcWqwfGmCZLUIlqbnsJxjW5SP6pwrgBEM3Ue2JBNmJigupCyQi7PwncihneYu/jfqrnE1Ehx7X8T1H1c2Bf7XQbk8V1m1t/7s54lJYPtEaYFS2WOrpv7lGUqqLL0V+4QfxkNC4XlYXMK6c7qa33gSqzv4Z+HDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZz8iyKj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707009595; x=1738545595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gynVH3mnYBen4IZImceAFmZdt7Oj+QDmyHtWJsldE9k=;
  b=dZz8iyKjCQ2Qdr7pTTjzyboSegOiAEH5EWMvqriOeyQVCjlzlRjkNT/U
   xs5QSqz1uhdfvILfIIBzCFdv1gs0rXxgKvcn6XVMlQvwR5DYL88kbpzIj
   pE6qr6fTUO4CM+U1wFgOYVQhX/MJbGXPeDS0cvpxgj1jo+UJWkdgmhRdd
   m1WlUlEQkXj7AqAEPwcBdJj4stKPgayf0fCxe8jjVweemQ8HoPQs8M5+i
   Mi5iZVfhFyyNqJ23/wgpkteq6rVrZnvL1zdDS/w5ZMHqXqY7lfVZ/wkyW
   m9HFBRANd67bKIT4eYvoLx0ePhTpvMFaPrpJu3nGQP6CSAOA2zsGw1d1K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="273037"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="273037"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 17:19:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="5028400"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 03 Feb 2024 17:19:50 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWRAf-0005pu-0E;
	Sun, 04 Feb 2024 01:19:47 +0000
Date: Sun, 4 Feb 2024 09:19:31 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 1/2] bpf, btf: Add register_check_missing_btf
 helper
Message-ID: <202402040934.Fph0XeEo-lkp@intel.com>
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
config: arm-imxrt_defconfig (https://download.01.org/0day-ci/archive/20240204/202402040934.Fph0XeEo-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7dd790db8b77c4a833c06632e903dc4f13877a64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402040934.Fph0XeEo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402040934.Fph0XeEo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/btf.c:7750:11: error: incomplete definition of type 'struct module'
    7750 |                                 module->name, msg);
         |                                 ~~~~~~^
   include/linux/printk.h:508:37: note: expanded from macro 'pr_warn'
     508 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                            ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
     455 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:348:8: note: forward declaration of 'struct module'
     348 | struct module;
         |        ^
   kernel/bpf/btf.c:7753:63: error: incomplete definition of type 'struct module'
    7753 |                 pr_err("missing module %s BTF, cannot register %s\n", module->name, msg);
         |                                                                       ~~~~~~^
   include/linux/printk.h:498:33: note: expanded from macro 'pr_err'
     498 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
     455 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:348:8: note: forward declaration of 'struct module'
     348 | struct module;
         |        ^
   2 errors generated.


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

