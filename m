Return-Path: <bpf+bounces-48492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D800AA083B6
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 00:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014823A89E4
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 23:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E722A2063EE;
	Thu,  9 Jan 2025 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIoS+L5d"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D718132A;
	Thu,  9 Jan 2025 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736466974; cv=none; b=W54a7+FA01RO3cClDeTVCI4diEVkRvzCyuxThtUcpxxfpldLqbds47WZH8hoMf5fGdL0BwnlIKb1pFTTcwA7Ztsesskp1wyXQvrH7ndPA5MlsY4v0xiy2DSzVoT3v9MoYH9xEMkfq13qGx863MDs38htYwXCCHtWEcaquIRblYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736466974; c=relaxed/simple;
	bh=p7qCU+/cOdfLJlNXjYBcrD89ca8a/7IKizVUQ95Xn04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnA3gg5pL4btcSnHJ687X+JawHGeIaR5gouCiF+Z0r/ziRDVyTfdLHdCsSy47Ab665n5Z45PX2WTjLUoiy+ruKGGczsn8XvV7w/zX4gQxpf3cF303zPOmkPhKhpIJkUS8CVK2bATDxop7YQXCmtF4HGpJ9waMNd6eDXIkOZHObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIoS+L5d; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736466972; x=1768002972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p7qCU+/cOdfLJlNXjYBcrD89ca8a/7IKizVUQ95Xn04=;
  b=DIoS+L5dhooUY702wM5ta+KmXRqfdbYpRHUc6MWJ35/a/LfAgCpfD/1D
   Q5X+AqRjvHXB3oNUy0ViY7ym2lXX4XESGoKE0tUkRAquGLmm5HkD1J+9b
   SyF3aiiQdR+CQofr557gLVJ+z1Pq0Z6smQHHK1CLOm7+PFYmV7t8Me+lJ
   tbiwQra3e1PhHdR8PfNPuL9n4QEgVQYnvmlkR+FuK1SC8vA+Q74QmWo75
   xYzTt7qMBCthxg+rD10uJ51+OZEn1j7FwdiHaiDLAlC+1gmm6r2vesQ8G
   EfIj0dtl5gFr3tWLjKqGgUjwu1mXqKHoJCmnweyp6wEVOsJ5UuaoX5ffZ
   Q==;
X-CSE-ConnectionGUID: kZulk1WhQmqmDSHdd+qXXg==
X-CSE-MsgGUID: Hmf2ilYYT5yPy9ZahM9sNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47418040"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="47418040"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:56:11 -0800
X-CSE-ConnectionGUID: B5/RRRIWRRWx4Q8Z5UjJOQ==
X-CSE-MsgGUID: 3eL9ugR5T2i1SYvuKsxZHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="108555338"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 Jan 2025 15:56:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tW2Ng-000IJH-2I;
	Thu, 09 Jan 2025 23:56:04 +0000
Date: Fri, 10 Jan 2025 07:55:22 +0800
From: kernel test robot <lkp@intel.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kernel-team@meta.com, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	kpsingh@kernel.org, mattbobrowski@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, memxor@gmail.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH v8 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic
 for bpf_dynptr_from_skb
Message-ID: <202501100757.HDb5slrv-lkp@intel.com>
References: <20250108225140.3467654-6-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108225140.3467654-6-song@kernel.org>

Hi Song,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/fs-xattr-bpf-Introduce-security-bpf-xattr-name-prefix/20250109-065503
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250108225140.3467654-6-song%40kernel.org
patch subject: [PATCH v8 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic for bpf_dynptr_from_skb
config: i386-buildonly-randconfig-005-20250110 (https://download.01.org/0day-ci/archive/20250110/202501100757.HDb5slrv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250110/202501100757.HDb5slrv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501100757.HDb5slrv-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> net/core/filter.c:12071:1: error: return type defaults to 'int' [-Werror=implicit-int]
   12071 | BTF_HIDDEN_KFUNCS_START(bpf_kfunc_check_hidden_set_skb)
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> net/core/filter.c:12071:1: error: function declaration isn't a prototype [-Werror=strict-prototypes]
   In file included from include/linux/btf.h:10,
                    from include/linux/bpf.h:28,
                    from include/linux/bpf_verifier.h:7,
                    from net/core/filter.c:21:
   net/core/filter.c: In function 'BTF_HIDDEN_KFUNCS_START':
>> net/core/filter.c:12075:18: error: storage class specified for parameter 'bpf_kfunc_check_set_xdp'
   12075 | BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:235:73: note: in definition of macro 'BTF_KFUNCS_START'
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                                                         ^~~~
>> include/linux/btf_ids.h:235:46: error: parameter 'bpf_kfunc_check_set_xdp' is initialized
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                              ^~~~~~~~~~~
   net/core/filter.c:12075:1: note: in expansion of macro 'BTF_KFUNCS_START'
   12075 | BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
         | ^~~~~~~~~~~~~~~~
>> net/core/filter.c:12079:18: error: storage class specified for parameter 'bpf_kfunc_check_set_sock_addr'
   12079 | BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:235:73: note: in definition of macro 'BTF_KFUNCS_START'
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                                                         ^~~~
>> include/linux/btf_ids.h:235:46: error: parameter 'bpf_kfunc_check_set_sock_addr' is initialized
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                              ^~~~~~~~~~~
   net/core/filter.c:12079:1: note: in expansion of macro 'BTF_KFUNCS_START'
   12079 | BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
         | ^~~~~~~~~~~~~~~~
>> net/core/filter.c:12083:18: error: storage class specified for parameter 'bpf_kfunc_check_set_tcp_reqsk'
   12083 | BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:235:73: note: in definition of macro 'BTF_KFUNCS_START'
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                                                         ^~~~
>> include/linux/btf_ids.h:235:46: error: parameter 'bpf_kfunc_check_set_tcp_reqsk' is initialized
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                              ^~~~~~~~~~~
   net/core/filter.c:12083:1: note: in expansion of macro 'BTF_KFUNCS_START'
   12083 | BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
         | ^~~~~~~~~~~~~~~~
>> net/core/filter.c:12087:13: error: storage class specified for parameter 'bpf_dynptr_from_skb_list'
   12087 | BTF_ID_LIST(bpf_dynptr_from_skb_list)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:223:53: note: in definition of macro 'BTF_ID_LIST'
     223 | #define BTF_ID_LIST(name) static u32 __maybe_unused name[64];
         |                                                     ^~~~
>> net/core/filter.c:12092:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   12092 | {
         | ^
>> net/core/filter.c:12122:38: error: storage class specified for parameter 'bpf_kfunc_set_skb'
   12122 | static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
         |                                      ^~~~~~~~~~~~~~~~~
>> net/core/filter.c:12122:21: error: parameter 'bpf_kfunc_set_skb' is initialized
   12122 | static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
         |                     ^~~~~~~~~~~~~~~~
>> net/core/filter.c:12125:24: error: 'bpf_kfunc_check_hidden_set_skb' undeclared (first use in this function); did you mean 'bpf_kfunc_check_set_skb'?
   12125 |         .hidden_set = &bpf_kfunc_check_hidden_set_skb,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                        bpf_kfunc_check_set_skb
   net/core/filter.c:12125:24: note: each undeclared identifier is reported only once for each function it appears in
>> net/core/filter.c:12126:19: error: 'bpf_kfunc_set_skb_remap' undeclared (first use in this function); did you mean 'bpf_kfunc_set_skb'?
   12126 |         .remap = &bpf_kfunc_set_skb_remap,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
         |                   bpf_kfunc_set_skb
>> net/core/filter.c:12129:38: error: storage class specified for parameter 'bpf_kfunc_set_xdp'
   12129 | static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
         |                                      ^~~~~~~~~~~~~~~~~
>> net/core/filter.c:12129:21: error: parameter 'bpf_kfunc_set_xdp' is initialized
   12129 | static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
         |                     ^~~~~~~~~~~~~~~~
>> net/core/filter.c:12134:38: error: storage class specified for parameter 'bpf_kfunc_set_sock_addr'
   12134 | static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
>> net/core/filter.c:12134:21: error: parameter 'bpf_kfunc_set_sock_addr' is initialized
   12134 | static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
         |                     ^~~~~~~~~~~~~~~~
>> net/core/filter.c:12139:38: error: storage class specified for parameter 'bpf_kfunc_set_tcp_reqsk'
   12139 | static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
>> net/core/filter.c:12139:21: error: parameter 'bpf_kfunc_set_tcp_reqsk' is initialized
   12139 | static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
         |                     ^~~~~~~~~~~~~~~~
   net/core/filter.c:12145:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   12145 | {
         | ^
   In file included from <command-line>:
   include/linux/compiler.h:189:45: error: storage class specified for parameter '__UNIQUE_ID___addressable_bpf_kfunc_init1505'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:83:23: note: in definition of macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/compiler.h:227:9: note: in expansion of macro '__UNIQUE_ID'
     227 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |         ^~~~~~~~~~~
   include/linux/compiler.h:229:9: note: in expansion of macro '___ADDRESSABLE'
     229 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^~~~~~~~~~~~~~
   include/linux/init.h:256:9: note: in expansion of macro '__ADDRESSABLE'
     256 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:261:9: note: in expansion of macro '__define_initcall_stub'
     261 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '____define_initcall'
     274 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:313:41: note: in expansion of macro '__define_initcall'
     313 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12164:1: note: in expansion of macro 'late_initcall'
   12164 | late_initcall(bpf_kfunc_init);
         | ^~~~~~~~~~~~~
   net/core/filter.c:12164:1: error: parameter '__UNIQUE_ID___addressable_bpf_kfunc_init1505' is initialized
   net/core/filter.c:12164:1: warning: 'used' attribute ignored [-Wattributes]
   include/linux/compiler.h:189:45: error: section attribute not allowed for '__UNIQUE_ID___addressable_bpf_kfunc_init1505'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:83:23: note: in definition of macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/compiler.h:227:9: note: in expansion of macro '__UNIQUE_ID'
     227 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |         ^~~~~~~~~~~
   include/linux/compiler.h:229:9: note: in expansion of macro '___ADDRESSABLE'
     229 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^~~~~~~~~~~~~~
   include/linux/init.h:256:9: note: in expansion of macro '__ADDRESSABLE'
     256 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:261:9: note: in expansion of macro '__define_initcall_stub'
     261 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '____define_initcall'
     274 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:313:41: note: in expansion of macro '__define_initcall'
     313 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12164:1: note: in expansion of macro 'late_initcall'
   12164 | late_initcall(bpf_kfunc_init);
         | ^~~~~~~~~~~~~
   In file included from arch/x86/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from net/core/filter.c:20:
   net/core/filter.c:12164:15: error: 'bpf_kfunc_init' undeclared (first use in this function); did you mean 'bpf_func_info'?
   12164 | late_initcall(bpf_kfunc_init);
         |               ^~~~~~~~~~~~~~
   include/linux/compiler.h:227:72: note: in definition of macro '___ADDRESSABLE'
     227 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;


vim +/int +12071 net/core/filter.c

 12070	
 12071	BTF_HIDDEN_KFUNCS_START(bpf_kfunc_check_hidden_set_skb)
 12072	BTF_ID_FLAGS(func, bpf_dynptr_from_skb_rdonly, KF_TRUSTED_ARGS)
 12073	BTF_KFUNCS_END(bpf_kfunc_check_hidden_set_skb)
 12074	
 12075	BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 12076	BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 12077	BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
 12078	
 12079	BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
 12080	BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 12081	BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
 12082	
 12083	BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
 12084	BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
 12085	BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 12086	
 12087	BTF_ID_LIST(bpf_dynptr_from_skb_list)
 12088	BTF_ID(func, bpf_dynptr_from_skb)
 12089	BTF_ID(func, bpf_dynptr_from_skb_rdonly)
 12090	
 12091	static u32 bpf_kfunc_set_skb_remap(const struct bpf_prog *prog, u32 kfunc_id)
 12092	{
 12093		if (kfunc_id != bpf_dynptr_from_skb_list[0])
 12094			return 0;
 12095	
 12096		switch (resolve_prog_type(prog)) {
 12097		/* Program types only with direct read access go here! */
 12098		case BPF_PROG_TYPE_LWT_IN:
 12099		case BPF_PROG_TYPE_LWT_OUT:
 12100		case BPF_PROG_TYPE_LWT_SEG6LOCAL:
 12101		case BPF_PROG_TYPE_SK_REUSEPORT:
 12102		case BPF_PROG_TYPE_FLOW_DISSECTOR:
 12103		case BPF_PROG_TYPE_CGROUP_SKB:
 12104			return bpf_dynptr_from_skb_list[1];
 12105	
 12106		/* Program types with direct read + write access go here! */
 12107		case BPF_PROG_TYPE_SCHED_CLS:
 12108		case BPF_PROG_TYPE_SCHED_ACT:
 12109		case BPF_PROG_TYPE_XDP:
 12110		case BPF_PROG_TYPE_LWT_XMIT:
 12111		case BPF_PROG_TYPE_SK_SKB:
 12112		case BPF_PROG_TYPE_SK_MSG:
 12113		case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 12114			return kfunc_id;
 12115	
 12116		default:
 12117			break;
 12118		}
 12119		return bpf_dynptr_from_skb_list[1];
 12120	}
 12121	
 12122	static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 12123		.owner = THIS_MODULE,
 12124		.set = &bpf_kfunc_check_set_skb,
 12125		.hidden_set = &bpf_kfunc_check_hidden_set_skb,
 12126		.remap = &bpf_kfunc_set_skb_remap,
 12127	};
 12128	
 12129	static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
 12130		.owner = THIS_MODULE,
 12131		.set = &bpf_kfunc_check_set_xdp,
 12132	};
 12133	
 12134	static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
 12135		.owner = THIS_MODULE,
 12136		.set = &bpf_kfunc_check_set_sock_addr,
 12137	};
 12138	
 12139	static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
 12140		.owner = THIS_MODULE,
 12141		.set = &bpf_kfunc_check_set_tcp_reqsk,
 12142	};
 12143	
 12144	static int __init bpf_kfunc_init(void)
 12145	{
 12146		int ret;
 12147	
 12148		ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb);
 12149		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb);
 12150		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SK_SKB, &bpf_kfunc_set_skb);
 12151		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCKET_FILTER, &bpf_kfunc_set_skb);
 12152		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_skb);
 12153		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_OUT, &bpf_kfunc_set_skb);
 12154		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_IN, &bpf_kfunc_set_skb);
 12155		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT, &bpf_kfunc_set_skb);
 12156		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 12157		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
 12158		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
 12159		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 12160		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 12161						       &bpf_kfunc_set_sock_addr);
 12162		return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
 12163	}
 12164	late_initcall(bpf_kfunc_init);
 12165	
 12166	__bpf_kfunc_start_defs();
 12167	
 12168	/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
 12169	 *
 12170	 * The function expects a non-NULL pointer to a socket, and invokes the
 12171	 * protocol specific socket destroy handlers.
 12172	 *
 12173	 * The helper can only be called from BPF contexts that have acquired the socket
 12174	 * locks.
 12175	 *
 12176	 * Parameters:
 12177	 * @sock: Pointer to socket to be destroyed
 12178	 *
 12179	 * Return:
 12180	 * On error, may return EPROTONOSUPPORT, EINVAL.
 12181	 * EPROTONOSUPPORT if protocol specific destroy handler is not supported.
 12182	 * 0 otherwise
 12183	 */
 12184	__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
 12185	{
 12186		struct sock *sk = (struct sock *)sock;
 12187	
 12188		/* The locking semantics that allow for synchronous execution of the
 12189		 * destroy handlers are only supported for TCP and UDP.
 12190		 * Supporting protocols will need to acquire sock lock in the BPF context
 12191		 * prior to invoking this kfunc.
 12192		 */
 12193		if (!sk->sk_prot->diag_destroy || (sk->sk_protocol != IPPROTO_TCP &&
 12194						   sk->sk_protocol != IPPROTO_UDP))
 12195			return -EOPNOTSUPP;
 12196	
 12197		return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
 12198	}
 12199	
 12200	__bpf_kfunc_end_defs();
 12201	
 12202	BTF_KFUNCS_START(bpf_sk_iter_kfunc_ids)
 12203	BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
 12204	BTF_KFUNCS_END(bpf_sk_iter_kfunc_ids)
 12205	
 12206	static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
 12207	{
 12208		if (btf_id_set8_contains(&bpf_sk_iter_kfunc_ids, kfunc_id) &&
 12209		    prog->expected_attach_type != BPF_TRACE_ITER)
 12210			return -EACCES;
 12211		return 0;
 12212	}
 12213	
 12214	static const struct btf_kfunc_id_set bpf_sk_iter_kfunc_set = {
 12215		.owner = THIS_MODULE,
 12216		.set   = &bpf_sk_iter_kfunc_ids,
 12217		.filter = tracing_iter_filter,
 12218	};
 12219	
 12220	static int init_subsystem(void)
 12221	{
 12222		return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_sk_iter_kfunc_set);
 12223	}
 12224	late_initcall(init_subsystem);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

