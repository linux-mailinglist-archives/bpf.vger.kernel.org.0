Return-Path: <bpf+bounces-59288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19284AC7D5E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 13:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0B91C01C26
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3CB221FBD;
	Thu, 29 May 2025 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkHBnfPP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A08F220F3B
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748519354; cv=none; b=QMpiW8rDcIKCcSKyDNjCUn1YDfW0DRsHwVgzX0c8dY7ZRYAnFQjXH7FyaiM9j/iigAhP0pnC0Gm0wPK2YsT6L1Uo/fiiLx0/pI485Q8y7TzDbQ42g4u8On6AVVhVuMKGRbc16y6S/65dGFuiIwzfRBW7nhCk3eNVdvc1XbRJU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748519354; c=relaxed/simple;
	bh=H/g6G0UUP2aDkMTBwJX39GplxH+iRsfNl0krSoShu58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1XNZpYjgaEoC+7iJPtEr7KfULjvTi0Igkhbw+nMq4l6Cpw3mQsAGnupqTtkUx9FjSCgHbHI5EeH6H74Tr+vfJdZmuaaf8yDdAKi4KSCeuqaE5mUZWkViX/OBmHTckMqAG8EhNm3+x9RhUfxbwzQst4k0qwbWu02achu132s/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkHBnfPP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748519353; x=1780055353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H/g6G0UUP2aDkMTBwJX39GplxH+iRsfNl0krSoShu58=;
  b=FkHBnfPP23FZhbKX4y+U6iX3IdlrgufNeuGbp0FgQ0cR2aU1QtkNtgBA
   5r3TMIm5V4uu/VvUshubvIL266LjE+f4ELq6p03hMYl88xj/uBMS/4ycg
   wowiNc8CeqCtl+n89BmDWaRrXS5qjo9+qzX3ux72BynA+SYxR+4GRX0aU
   ytjNBsHH20c6CSbgM997OEPXtKUIBF1zhCKHLQQswHkBQ/xa5gX62R8v6
   N+5Lx+H5njgkTf1Zz1zFjvH41hcpJi+5e+CQqV0wgFbdBfPiRmQb6qM/i
   rav19TJ+nhGI20g0aqCd4UxL2HPbXS+TzR3k5K6ESZLIShZDQo5BzMNpd
   A==;
X-CSE-ConnectionGUID: uvx8xMQJS2e8s5jSWruDyg==
X-CSE-MsgGUID: s8JGPWW/R2u42wGh7OLQmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50460239"
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; 
   d="scan'208";a="50460239"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:49:12 -0700
X-CSE-ConnectionGUID: r0azC2JsRlSw+C0pHSivfg==
X-CSE-MsgGUID: go+CU1wGQLCTdOmejBtmWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; 
   d="scan'208";a="143880900"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 May 2025 04:49:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKbks-000We8-1x;
	Thu, 29 May 2025 11:49:02 +0000
Date: Thu, 29 May 2025 19:48:17 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Pingfan Liu <piliu@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	kexec@lists.infradead.org, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCHv3 3/9] bpf: Introduce bpf_copy_to_kernel() to buffer the
 content from bpf-prog
Message-ID: <202505291926.IPUSqCEj-lkp@intel.com>
References: <20250529041744.16458-4-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529041744.16458-4-piliu@redhat.com>

Hi Pingfan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master arm64/for-next/core linus/master v6.15 next-20250529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250529-122124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250529041744.16458-4-piliu%40redhat.com
patch subject: [PATCHv3 3/9] bpf: Introduce bpf_copy_to_kernel() to buffer the content from bpf-prog
config: riscv-randconfig-001-20250529 (https://download.01.org/0day-ci/archive/20250529/202505291926.IPUSqCEj-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505291926.IPUSqCEj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505291926.IPUSqCEj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/helpers_carrier.c:74:17: warning: no previous prototype for function 'bpf_mem_range_result_put' [-Wmissing-prototypes]
      74 | __bpf_kfunc int bpf_mem_range_result_put(struct mem_range_result *result)
         |                 ^
   kernel/bpf/helpers_carrier.c:74:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
      74 | __bpf_kfunc int bpf_mem_range_result_put(struct mem_range_result *result)
         |             ^
         |             static 
   kernel/bpf/helpers_carrier.c:88:7: warning: variable 'kmalloc' set but not used [-Wunused-but-set-variable]
      88 |         bool kmalloc;
         |              ^
>> kernel/bpf/helpers_carrier.c:82:17: warning: no previous prototype for function 'bpf_copy_to_kernel' [-Wmissing-prototypes]
      82 | __bpf_kfunc int bpf_copy_to_kernel(const char *name, char *buf, int size)
         |                 ^
   kernel/bpf/helpers_carrier.c:82:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
      82 | __bpf_kfunc int bpf_copy_to_kernel(const char *name, char *buf, int size)
         |             ^
         |             static 
>> kernel/bpf/helpers_carrier.c:165:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     165 |         if (!find_listener(item->str)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers_carrier.c:174:9: note: uninitialized use occurs here
     174 |         return ret;
         |                ^~~
   kernel/bpf/helpers_carrier.c:165:2: note: remove the 'if' if its condition is always false
     165 |         if (!find_listener(item->str)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     166 |                 hash_add(str_listeners, &item->node, hash);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     167 |         } else {
         |         ~~~~~~
   kernel/bpf/helpers_carrier.c:149:9: note: initialize the variable 'ret' to silence this warning
     149 |         int ret;
         |                ^
         |                 = 0
   4 warnings generated.


vim +/bpf_mem_range_result_put +74 kernel/bpf/helpers_carrier.c

    73	
  > 74	__bpf_kfunc int bpf_mem_range_result_put(struct mem_range_result *result)
    75	{
    76		return mem_range_result_put(result);
    77	}
    78	
    79	/*
    80	 * Cache the content in @buf into kernel
    81	 */
  > 82	__bpf_kfunc int bpf_copy_to_kernel(const char *name, char *buf, int size)
    83	{
    84		struct mem_range_result *range;
    85		struct mem_cgroup *memcg, *old_memcg;
    86		struct str_listener *item;
    87		resource_handler handler;
    88		bool kmalloc;
    89		char *kbuf;
    90		int id, ret = 0;
    91	
    92		id = srcu_read_lock(&srcu);
    93		item = find_listener(name);
    94		if (!item) {
    95			srcu_read_unlock(&srcu, id);
    96			return -EINVAL;
    97		}
    98		kmalloc = item->kmalloc;
    99		handler = item->handler;
   100		srcu_read_unlock(&srcu, id);
   101		memcg = get_mem_cgroup_from_current();
   102		old_memcg = set_active_memcg(memcg);
   103		range = kmalloc(sizeof(struct mem_range_result), GFP_KERNEL);
   104		if (!range) {
   105			pr_err("fail to allocate mem_range_result\n");
   106			ret = -ENOMEM;
   107			goto err;
   108		}
   109	
   110		kref_init(&range->ref);
   111		if (item->kmalloc)
   112			kbuf = kmalloc(size, GFP_KERNEL | __GFP_ACCOUNT);
   113		else
   114			kbuf = __vmalloc(size, GFP_KERNEL | __GFP_ACCOUNT);
   115		if (!kbuf) {
   116			kfree(range);
   117			ret = -ENOMEM;
   118			goto err;
   119		}
   120		ret = copy_from_kernel_nofault(kbuf, buf, size);
   121		if (unlikely(ret < 0)) {
   122			kfree(range);
   123			if (item->kmalloc)
   124				kfree(kbuf);
   125			else
   126				vfree(kbuf);
   127			ret = -EINVAL;
   128			goto err;
   129		}
   130		range->kmalloc = item->kmalloc;
   131		range->buf = kbuf;
   132		range->buf_sz = size;
   133		range->data_sz = size;
   134		range->memcg = memcg;
   135		mem_cgroup_tryget(memcg);
   136		range->status = 0;
   137		ret = handler(name, range);
   138		mem_range_result_put(range);
   139	err:
   140		set_active_memcg(old_memcg);
   141		mem_cgroup_put(memcg);
   142		return ret;
   143	}
   144	
   145	int register_carrier_listener(struct carrier_listener *listener)
   146	{
   147		struct str_listener *item;
   148		unsigned int hash;
   149		int ret;
   150	
   151		if (!listener->name)
   152			return -EINVAL;
   153		item = kmalloc(sizeof(*item), GFP_KERNEL);
   154		if (!item)
   155			return -ENOMEM;
   156		item->str = kstrdup(listener->name, GFP_KERNEL);
   157		if (!item->str) {
   158			kfree(item);
   159			return -ENOMEM;
   160		}
   161		item->handler = listener->handler;
   162		item->kmalloc = listener->kmalloc;
   163		hash = jhash(item->str, strlen(item->str), 0);
   164		mutex_lock(&str_listeners_mutex);
 > 165		if (!find_listener(item->str)) {
   166			hash_add(str_listeners, &item->node, hash);
   167		} else {
   168			kfree(item->str);
   169			kfree(item);
   170			ret = -EBUSY;
   171		}
   172		mutex_unlock(&str_listeners_mutex);
   173	
   174		return ret;
   175	}
   176	EXPORT_SYMBOL(register_carrier_listener);
   177	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

