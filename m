Return-Path: <bpf+bounces-48499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D174A08483
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 02:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4F1167C28
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 01:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0F3FB0E;
	Fri, 10 Jan 2025 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfXLh2w3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E915E90;
	Fri, 10 Jan 2025 01:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471551; cv=none; b=UIeGP28UaShgGXzuN/wNnEC4K7V/eS58X5e3GFeUKmTmtQ+0uI/N+PKXJYNHhODPJ5/YD1xTgWRBOWyolMmdLQ/4rOPIUcklJyvtroQDRupqsEHCWVtbscgb0uQqDHA5GAN1GrY5Yz8sgw1CrepruHcQOD1Fny3hYEJvvoJrMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471551; c=relaxed/simple;
	bh=vjexu1mT9W1eLEOmhn3inpLGySks99CpH6FlBTtuR98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzbqUpTgVTTRj9mdlrlKeV15lpe5l3u0WBxYuaYbFoaGgZV9wfbbVTyCRw6CCk2bjAn+zaRAz5raWtlFGbBTWVplWNWRQjs/gJ8b0CYCv6HTbPcH67fcW3kmaGV1PFgHk02wrJJKVaSrZK+DrkfIGdIQMFwGNvUVV1dJmGD4nBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfXLh2w3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736471548; x=1768007548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vjexu1mT9W1eLEOmhn3inpLGySks99CpH6FlBTtuR98=;
  b=nfXLh2w3HuN24U4H1uopQpuER+LZQXRudgpUBL05DTqwUP7oBqhbRVlB
   fQVxuhaU991JzBJOlC52ZqgO5xBas6zw9lmdHy66WaXqWTtaP3qF8qhhe
   gngStcmTOmJ9zOQu6SLwc9BoRrFrts2GWagwTWlHBJsPfImo8frSm7vYb
   QucsqFxmQuWiYsTkLUvPcZu0WdkU8SHOoMZTkgECqP0j3EjQqI5OhTk7o
   9TLeX0Bx0gKwMxft8BLks26OqBGTDunSzhGzgw0OiCqQVySHgEExDRmFe
   xqlLpEbusGdnvx/8zeLorjpn5vIwpEoTz2Pcb7HqonEgb+CVHz9ifefn7
   g==;
X-CSE-ConnectionGUID: zwbYzMVaTOmUgPRqJTsIaw==
X-CSE-MsgGUID: CIXkg4ZWQZaR8cwxmMWXsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="62128868"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="62128868"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 17:12:27 -0800
X-CSE-ConnectionGUID: IaKmUwS/QES25NRMQVYeUA==
X-CSE-MsgGUID: gDq6kHs5ToGu0kep+yLtWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134481745"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Jan 2025 17:12:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tW3ZU-000IN3-1L;
	Fri, 10 Jan 2025 01:12:20 +0000
Date: Fri, 10 Jan 2025 09:11:42 +0800
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
Message-ID: <202501100813.5dE7y99c-lkp@intel.com>
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
config: s390-randconfig-002-20250110 (https://download.01.org/0day-ci/archive/20250110/202501100813.5dE7y99c-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250110/202501100813.5dE7y99c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501100813.5dE7y99c-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/filter.c:12071:1: error: return type defaults to 'int' [-Wimplicit-int]
   12071 | BTF_HIDDEN_KFUNCS_START(bpf_kfunc_check_hidden_set_skb)
         | ^~~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:12071:1: error: function declaration isn't a prototype [-Werror=strict-prototypes]
   In file included from include/linux/btf.h:10,
                    from include/linux/bpf.h:28,
                    from include/linux/bpf_verifier.h:7,
                    from net/core/filter.c:21:
   net/core/filter.c: In function 'BTF_HIDDEN_KFUNCS_START':
   net/core/filter.c:12075:18: error: storage class specified for parameter 'bpf_kfunc_check_set_xdp'
   12075 | BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:235:73: note: in definition of macro 'BTF_KFUNCS_START'
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                                                         ^~~~
   include/linux/btf_ids.h:235:46: error: parameter 'bpf_kfunc_check_set_xdp' is initialized
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                              ^~~~~~~~~~~
   net/core/filter.c:12075:1: note: in expansion of macro 'BTF_KFUNCS_START'
   12075 | BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
         | ^~~~~~~~~~~~~~~~
   net/core/filter.c:12079:18: error: storage class specified for parameter 'bpf_kfunc_check_set_sock_addr'
   12079 | BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:235:73: note: in definition of macro 'BTF_KFUNCS_START'
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                                                         ^~~~
   include/linux/btf_ids.h:235:46: error: parameter 'bpf_kfunc_check_set_sock_addr' is initialized
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                              ^~~~~~~~~~~
   net/core/filter.c:12079:1: note: in expansion of macro 'BTF_KFUNCS_START'
   12079 | BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
         | ^~~~~~~~~~~~~~~~
   net/core/filter.c:12083:18: error: storage class specified for parameter 'bpf_kfunc_check_set_tcp_reqsk'
   12083 | BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:235:73: note: in definition of macro 'BTF_KFUNCS_START'
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                                                         ^~~~
   include/linux/btf_ids.h:235:46: error: parameter 'bpf_kfunc_check_set_tcp_reqsk' is initialized
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                              ^~~~~~~~~~~
   net/core/filter.c:12083:1: note: in expansion of macro 'BTF_KFUNCS_START'
   12083 | BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
         | ^~~~~~~~~~~~~~~~
   net/core/filter.c:12087:13: error: storage class specified for parameter 'bpf_dynptr_from_skb_list'
   12087 | BTF_ID_LIST(bpf_dynptr_from_skb_list)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:223:53: note: in definition of macro 'BTF_ID_LIST'
     223 | #define BTF_ID_LIST(name) static u32 __maybe_unused name[64];
         |                                                     ^~~~
   net/core/filter.c:12092:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   12092 | {
         | ^
   net/core/filter.c:12122:38: error: storage class specified for parameter 'bpf_kfunc_set_skb'
   12122 | static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
         |                                      ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12122:21: error: parameter 'bpf_kfunc_set_skb' is initialized
   12122 | static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
         |                     ^~~~~~~~~~~~~~~~
   net/core/filter.c:12125:24: error: 'bpf_kfunc_check_hidden_set_skb' undeclared (first use in this function); did you mean 'bpf_kfunc_check_set_skb'?
   12125 |         .hidden_set = &bpf_kfunc_check_hidden_set_skb,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                        bpf_kfunc_check_set_skb
   net/core/filter.c:12125:24: note: each undeclared identifier is reported only once for each function it appears in
   net/core/filter.c:12126:19: error: 'bpf_kfunc_set_skb_remap' undeclared (first use in this function); did you mean 'bpf_kfunc_set_skb'?
   12126 |         .remap = &bpf_kfunc_set_skb_remap,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
         |                   bpf_kfunc_set_skb
   net/core/filter.c:12129:38: error: storage class specified for parameter 'bpf_kfunc_set_xdp'
   12129 | static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
         |                                      ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12129:21: error: parameter 'bpf_kfunc_set_xdp' is initialized
   12129 | static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
         |                     ^~~~~~~~~~~~~~~~
   net/core/filter.c:12134:38: error: storage class specified for parameter 'bpf_kfunc_set_sock_addr'
   12134 | static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:12134:21: error: parameter 'bpf_kfunc_set_sock_addr' is initialized
   12134 | static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
         |                     ^~~~~~~~~~~~~~~~
   net/core/filter.c:12139:38: error: storage class specified for parameter 'bpf_kfunc_set_tcp_reqsk'
   12139 | static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:12139:21: error: parameter 'bpf_kfunc_set_tcp_reqsk' is initialized
   12139 | static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
         |                     ^~~~~~~~~~~~~~~~
   net/core/filter.c:12145:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   12145 | {
         | ^
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/s390/include/asm/bug.h:69,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from arch/s390/include/asm/cmpxchg.h:11,
                    from arch/s390/include/asm/atomic.h:16,
                    from include/linux/atomic.h:7,
                    from net/core/filter.c:20:
>> include/linux/init.h:218:17: error: storage class specified for parameter '__initcall__kmod_filter__1641_12164_bpf_kfunc_init7'
     218 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:269:27: note: in definition of macro '____define_initcall'
     269 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:218:9: note: in expansion of macro '__PASTE'
     218 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:276:17: note: in expansion of macro '__initcall_name'
     276 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
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
>> net/core/filter.c:12164:1: error: parameter '__initcall__kmod_filter__1641_12164_bpf_kfunc_init7' is initialized
   net/core/filter.c:12164:1: warning: 'used' attribute ignored [-Wattributes]
>> include/linux/init.h:218:17: error: section attribute not allowed for '__initcall__kmod_filter__1641_12164_bpf_kfunc_init7'
     218 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:269:27: note: in definition of macro '____define_initcall'
     269 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:218:9: note: in expansion of macro '__PASTE'
     218 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:276:17: note: in expansion of macro '__initcall_name'
     276 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
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
   net/core/filter.c:12164:15: error: 'bpf_kfunc_init' undeclared (first use in this function); did you mean 'bpf_func_info'?
   12164 | late_initcall(bpf_kfunc_init);
         |               ^~~~~~~~~~~~~~
   include/linux/init.h:270:55: note: in definition of macro '____define_initcall'
     270 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ^~
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
   net/core/filter.c:12164:30: error: expected declaration specifiers before ';' token
   12164 | late_initcall(bpf_kfunc_init);
         |                              ^
   In file included from include/linux/compiler_types.h:174,
                    from <command-line>:
   include/linux/compiler-gcc.h:134:33: error: expected declaration specifiers before '#pragma'
     134 | #define __diag(s)               _Pragma(__diag_str(GCC diagnostic s))
         |                                 ^~~~~~~
   include/linux/compiler_types.h:557:25: note: in expansion of macro '__diag'
     557 | #define __diag_push()   __diag(push)
         |                         ^~~~~~
   include/linux/btf.h:89:9: note: in expansion of macro '__diag_push'
      89 |         __diag_push();                                                         \
         |         ^~~~~~~~~~~
   net/core/filter.c:12166:1: note: in expansion of macro '__bpf_kfunc_start_defs'
   12166 | __bpf_kfunc_start_defs();
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:134:33: error: expected declaration specifiers before '#pragma'
     134 | #define __diag(s)               _Pragma(__diag_str(GCC diagnostic s))
         |                                 ^~~~~~~
   include/linux/compiler-gcc.h:143:9: note: in expansion of macro '__diag'
     143 |         __diag(__diag_GCC_ignore option)
         |         ^~~~~~
   include/linux/btf.h:90:9: note: in expansion of macro '__diag_ignore_all'
      90 |         __diag_ignore_all("-Wmissing-declarations",                            \
         |         ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12166:1: note: in expansion of macro '__bpf_kfunc_start_defs'
   12166 | __bpf_kfunc_start_defs();
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:134:33: error: expected declaration specifiers before '#pragma'
     134 | #define __diag(s)               _Pragma(__diag_str(GCC diagnostic s))
         |                                 ^~~~~~~
   include/linux/compiler-gcc.h:143:9: note: in expansion of macro '__diag'
     143 |         __diag(__diag_GCC_ignore option)
         |         ^~~~~~
   include/linux/btf.h:92:9: note: in expansion of macro '__diag_ignore_all'
      92 |         __diag_ignore_all("-Wmissing-prototypes",                              \
         |         ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12166:1: note: in expansion of macro '__bpf_kfunc_start_defs'
   12166 | __bpf_kfunc_start_defs();
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:89:
   include/linux/compiler_attributes.h:349:41: error: expected declaration specifiers before '__attribute__'
     349 | #define __used                          __attribute__((__used__))
         |                                         ^~~~~~~~~~~~~
   include/linux/btf.h:86:21: note: in expansion of macro '__used'
      86 | #define __bpf_kfunc __used __retain noinline
         |                     ^~~~~~
   net/core/filter.c:12184:1: note: in expansion of macro '__bpf_kfunc'
   12184 | __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
         | ^~~~~~~~~~~
   include/linux/compiler-gcc.h:134:33: error: expected declaration specifiers before '#pragma'
     134 | #define __diag(s)               _Pragma(__diag_str(GCC diagnostic s))
         |                                 ^~~~~~~
   include/linux/compiler_types.h:558:25: note: in expansion of macro '__diag'
     558 | #define __diag_pop()    __diag(pop)
         |                         ^~~~~~
   include/linux/btf.h:95:32: note: in expansion of macro '__diag_pop'
      95 | #define __bpf_kfunc_end_defs() __diag_pop()
         |                                ^~~~~~~~~~
   net/core/filter.c:12200:1: note: in expansion of macro '__bpf_kfunc_end_defs'
   12200 | __bpf_kfunc_end_defs();
         | ^~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:12202:18: error: storage class specified for parameter 'bpf_sk_iter_kfunc_ids'
   12202 | BTF_KFUNCS_START(bpf_sk_iter_kfunc_ids)
         |                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:235:73: note: in definition of macro 'BTF_KFUNCS_START'
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                                                         ^~~~
   include/linux/btf_ids.h:235:46: error: parameter 'bpf_sk_iter_kfunc_ids' is initialized
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                              ^~~~~~~~~~~
   net/core/filter.c:12202:1: note: in expansion of macro 'BTF_KFUNCS_START'
   12202 | BTF_KFUNCS_START(bpf_sk_iter_kfunc_ids)
         | ^~~~~~~~~~~~~~~~
   net/core/filter.c:12207:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   12207 | {
         | ^
   net/core/filter.c:12214:38: error: storage class specified for parameter 'bpf_sk_iter_kfunc_set'
   12214 | static const struct btf_kfunc_id_set bpf_sk_iter_kfunc_set = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:12214:21: error: parameter 'bpf_sk_iter_kfunc_set' is initialized
   12214 | static const struct btf_kfunc_id_set bpf_sk_iter_kfunc_set = {
         |                     ^~~~~~~~~~~~~~~~
   net/core/filter.c:12217:19: error: 'tracing_iter_filter' undeclared (first use in this function)
   12217 |         .filter = tracing_iter_filter,
         |                   ^~~~~~~~~~~~~~~~~~~
   net/core/filter.c:12221:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   12221 | {
         | ^
>> include/linux/init.h:218:17: error: storage class specified for parameter '__initcall__kmod_filter__1642_12224_init_subsystem7'
     218 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:269:27: note: in definition of macro '____define_initcall'
     269 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:218:9: note: in expansion of macro '__PASTE'
     218 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:276:17: note: in expansion of macro '__initcall_name'
     276 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:313:41: note: in expansion of macro '__define_initcall'
     313 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12224:1: note: in expansion of macro 'late_initcall'
   12224 | late_initcall(init_subsystem);
         | ^~~~~~~~~~~~~
>> net/core/filter.c:12224:1: error: parameter '__initcall__kmod_filter__1642_12224_init_subsystem7' is initialized
   net/core/filter.c:12224:1: warning: 'used' attribute ignored [-Wattributes]
>> include/linux/init.h:218:17: error: section attribute not allowed for '__initcall__kmod_filter__1642_12224_init_subsystem7'
     218 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:269:27: note: in definition of macro '____define_initcall'
     269 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:218:9: note: in expansion of macro '__PASTE'
     218 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:276:17: note: in expansion of macro '__initcall_name'
     276 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:313:41: note: in expansion of macro '__define_initcall'
     313 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12224:1: note: in expansion of macro 'late_initcall'
   12224 | late_initcall(init_subsystem);
         | ^~~~~~~~~~~~~
   net/core/filter.c:12224:15: error: 'init_subsystem' undeclared (first use in this function)
   12224 | late_initcall(init_subsystem);
         |               ^~~~~~~~~~~~~~
   include/linux/init.h:270:55: note: in definition of macro '____define_initcall'
     270 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ^~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:313:41: note: in expansion of macro '__define_initcall'
     313 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12224:1: note: in expansion of macro 'late_initcall'
   12224 | late_initcall(init_subsystem);
         | ^~~~~~~~~~~~~
   net/core/filter.c:12224:30: error: expected declaration specifiers before ';' token
   12224 | late_initcall(init_subsystem);
         |                              ^
>> include/linux/init.h:218:17: error: declaration for parameter '__initcall__kmod_filter__1642_12224_init_subsystem7' but no such parameter
     218 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:269:27: note: in definition of macro '____define_initcall'
     269 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:218:9: note: in expansion of macro '__PASTE'
     218 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:276:17: note: in expansion of macro '__initcall_name'
     276 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:313:41: note: in expansion of macro '__define_initcall'
     313 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12224:1: note: in expansion of macro 'late_initcall'
   12224 | late_initcall(init_subsystem);
         | ^~~~~~~~~~~~~
   net/core/filter.c:12214:38: error: declaration for parameter 'bpf_sk_iter_kfunc_set' but no such parameter
   12214 | static const struct btf_kfunc_id_set bpf_sk_iter_kfunc_set = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:12202:18: error: declaration for parameter 'bpf_sk_iter_kfunc_ids' but no such parameter
   12202 | BTF_KFUNCS_START(bpf_sk_iter_kfunc_ids)
         |                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:235:73: note: in definition of macro 'BTF_KFUNCS_START'
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                                                         ^~~~
>> include/linux/init.h:218:17: error: declaration for parameter '__initcall__kmod_filter__1641_12164_bpf_kfunc_init7' but no such parameter
     218 |         __PASTE(__,                                             \
         |                 ^~
   include/linux/init.h:269:27: note: in definition of macro '____define_initcall'
     269 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:218:9: note: in expansion of macro '__PASTE'
     218 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/init.h:276:17: note: in expansion of macro '__initcall_name'
     276 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
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
   net/core/filter.c:12139:38: error: declaration for parameter 'bpf_kfunc_set_tcp_reqsk' but no such parameter
   12139 | static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:12134:38: error: declaration for parameter 'bpf_kfunc_set_sock_addr' but no such parameter
   12134 | static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:12129:38: error: declaration for parameter 'bpf_kfunc_set_xdp' but no such parameter
   12129 | static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
         |                                      ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12122:38: error: declaration for parameter 'bpf_kfunc_set_skb' but no such parameter
   12122 | static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
         |                                      ^~~~~~~~~~~~~~~~~
   net/core/filter.c:12087:13: error: declaration for parameter 'bpf_dynptr_from_skb_list' but no such parameter
   12087 | BTF_ID_LIST(bpf_dynptr_from_skb_list)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:223:53: note: in definition of macro 'BTF_ID_LIST'
     223 | #define BTF_ID_LIST(name) static u32 __maybe_unused name[64];
         |                                                     ^~~~
   net/core/filter.c:12083:18: error: declaration for parameter 'bpf_kfunc_check_set_tcp_reqsk' but no such parameter
   12083 | BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:235:73: note: in definition of macro 'BTF_KFUNCS_START'
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                                                         ^~~~
   net/core/filter.c:12079:18: error: declaration for parameter 'bpf_kfunc_check_set_sock_addr' but no such parameter
   12079 | BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:235:73: note: in definition of macro 'BTF_KFUNCS_START'
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                                                         ^~~~
   net/core/filter.c:12075:18: error: declaration for parameter 'bpf_kfunc_check_set_xdp' but no such parameter
   12075 | BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/btf_ids.h:235:73: note: in definition of macro 'BTF_KFUNCS_START'
     235 | #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
         |                                                                         ^~~~
   net/core/filter.c:12225: error: expected '{' at end of input
   net/core/filter.c:12225: warning: control reaches end of non-void function [-Wreturn-type]
   cc1: some warnings being treated as errors


vim +/__initcall__kmod_filter__1641_12164_bpf_kfunc_init7 +12164 net/core/filter.c

e472f88891abbc Kuniyuki Iwashima 2024-01-15  12143  
b5964b968ac64c Joanne Koong      2023-03-01  12144  static int __init bpf_kfunc_init(void)
b5964b968ac64c Joanne Koong      2023-03-01  12145  {
b5964b968ac64c Joanne Koong      2023-03-01  12146  	int ret;
b5964b968ac64c Joanne Koong      2023-03-01  12147  
b5964b968ac64c Joanne Koong      2023-03-01  12148  	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb);
b5964b968ac64c Joanne Koong      2023-03-01  12149  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb);
b5964b968ac64c Joanne Koong      2023-03-01  12150  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SK_SKB, &bpf_kfunc_set_skb);
b5964b968ac64c Joanne Koong      2023-03-01  12151  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCKET_FILTER, &bpf_kfunc_set_skb);
b5964b968ac64c Joanne Koong      2023-03-01  12152  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_skb);
b5964b968ac64c Joanne Koong      2023-03-01  12153  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_OUT, &bpf_kfunc_set_skb);
b5964b968ac64c Joanne Koong      2023-03-01  12154  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_IN, &bpf_kfunc_set_skb);
b5964b968ac64c Joanne Koong      2023-03-01  12155  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT, &bpf_kfunc_set_skb);
05421aecd4ed65 Joanne Koong      2023-03-01  12156  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
fd9c663b9ad67d Florian Westphal  2023-04-21  12157  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
ffc83860d8c097 Philo Lu          2024-09-11  12158  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
53e380d2144190 Daan De Meyer     2023-10-11  12159  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
e472f88891abbc Kuniyuki Iwashima 2024-01-15  12160  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
53e380d2144190 Daan De Meyer     2023-10-11  12161  					       &bpf_kfunc_set_sock_addr);
e472f88891abbc Kuniyuki Iwashima 2024-01-15  12162  	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
b5964b968ac64c Joanne Koong      2023-03-01  12163  }
b5964b968ac64c Joanne Koong      2023-03-01 @12164  late_initcall(bpf_kfunc_init);
4ddbcb886268af Aditi Ghag        2023-05-19  12165  
391145ba2accc4 Dave Marchevsky   2023-10-31  12166  __bpf_kfunc_start_defs();
4ddbcb886268af Aditi Ghag        2023-05-19  12167  
4ddbcb886268af Aditi Ghag        2023-05-19  12168  /* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
4ddbcb886268af Aditi Ghag        2023-05-19  12169   *
4ddbcb886268af Aditi Ghag        2023-05-19  12170   * The function expects a non-NULL pointer to a socket, and invokes the
4ddbcb886268af Aditi Ghag        2023-05-19  12171   * protocol specific socket destroy handlers.
4ddbcb886268af Aditi Ghag        2023-05-19  12172   *
4ddbcb886268af Aditi Ghag        2023-05-19  12173   * The helper can only be called from BPF contexts that have acquired the socket
4ddbcb886268af Aditi Ghag        2023-05-19  12174   * locks.
4ddbcb886268af Aditi Ghag        2023-05-19  12175   *
4ddbcb886268af Aditi Ghag        2023-05-19  12176   * Parameters:
4ddbcb886268af Aditi Ghag        2023-05-19  12177   * @sock: Pointer to socket to be destroyed
4ddbcb886268af Aditi Ghag        2023-05-19  12178   *
4ddbcb886268af Aditi Ghag        2023-05-19  12179   * Return:
4ddbcb886268af Aditi Ghag        2023-05-19  12180   * On error, may return EPROTONOSUPPORT, EINVAL.
4ddbcb886268af Aditi Ghag        2023-05-19  12181   * EPROTONOSUPPORT if protocol specific destroy handler is not supported.
4ddbcb886268af Aditi Ghag        2023-05-19  12182   * 0 otherwise
4ddbcb886268af Aditi Ghag        2023-05-19  12183   */
4ddbcb886268af Aditi Ghag        2023-05-19  12184  __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
4ddbcb886268af Aditi Ghag        2023-05-19  12185  {
4ddbcb886268af Aditi Ghag        2023-05-19  12186  	struct sock *sk = (struct sock *)sock;
4ddbcb886268af Aditi Ghag        2023-05-19  12187  
4ddbcb886268af Aditi Ghag        2023-05-19  12188  	/* The locking semantics that allow for synchronous execution of the
4ddbcb886268af Aditi Ghag        2023-05-19  12189  	 * destroy handlers are only supported for TCP and UDP.
4ddbcb886268af Aditi Ghag        2023-05-19  12190  	 * Supporting protocols will need to acquire sock lock in the BPF context
4ddbcb886268af Aditi Ghag        2023-05-19  12191  	 * prior to invoking this kfunc.
4ddbcb886268af Aditi Ghag        2023-05-19  12192  	 */
4ddbcb886268af Aditi Ghag        2023-05-19  12193  	if (!sk->sk_prot->diag_destroy || (sk->sk_protocol != IPPROTO_TCP &&
4ddbcb886268af Aditi Ghag        2023-05-19  12194  					   sk->sk_protocol != IPPROTO_UDP))
4ddbcb886268af Aditi Ghag        2023-05-19  12195  		return -EOPNOTSUPP;
4ddbcb886268af Aditi Ghag        2023-05-19  12196  
4ddbcb886268af Aditi Ghag        2023-05-19  12197  	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
4ddbcb886268af Aditi Ghag        2023-05-19  12198  }
4ddbcb886268af Aditi Ghag        2023-05-19  12199  
391145ba2accc4 Dave Marchevsky   2023-10-31  12200  __bpf_kfunc_end_defs();
4ddbcb886268af Aditi Ghag        2023-05-19  12201  
6f3189f38a3e99 Daniel Xu         2024-01-28  12202  BTF_KFUNCS_START(bpf_sk_iter_kfunc_ids)
4ddbcb886268af Aditi Ghag        2023-05-19  12203  BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
6f3189f38a3e99 Daniel Xu         2024-01-28  12204  BTF_KFUNCS_END(bpf_sk_iter_kfunc_ids)
4ddbcb886268af Aditi Ghag        2023-05-19  12205  
4ddbcb886268af Aditi Ghag        2023-05-19  12206  static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
4ddbcb886268af Aditi Ghag        2023-05-19  12207  {
4ddbcb886268af Aditi Ghag        2023-05-19  12208  	if (btf_id_set8_contains(&bpf_sk_iter_kfunc_ids, kfunc_id) &&
4ddbcb886268af Aditi Ghag        2023-05-19  12209  	    prog->expected_attach_type != BPF_TRACE_ITER)
4ddbcb886268af Aditi Ghag        2023-05-19  12210  		return -EACCES;
4ddbcb886268af Aditi Ghag        2023-05-19  12211  	return 0;
4ddbcb886268af Aditi Ghag        2023-05-19  12212  }
4ddbcb886268af Aditi Ghag        2023-05-19  12213  
4ddbcb886268af Aditi Ghag        2023-05-19  12214  static const struct btf_kfunc_id_set bpf_sk_iter_kfunc_set = {
4ddbcb886268af Aditi Ghag        2023-05-19  12215  	.owner = THIS_MODULE,
4ddbcb886268af Aditi Ghag        2023-05-19  12216  	.set   = &bpf_sk_iter_kfunc_ids,
4ddbcb886268af Aditi Ghag        2023-05-19  12217  	.filter = tracing_iter_filter,
4ddbcb886268af Aditi Ghag        2023-05-19  12218  };
4ddbcb886268af Aditi Ghag        2023-05-19  12219  
4ddbcb886268af Aditi Ghag        2023-05-19  12220  static int init_subsystem(void)
4ddbcb886268af Aditi Ghag        2023-05-19  12221  {
4ddbcb886268af Aditi Ghag        2023-05-19  12222  	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_sk_iter_kfunc_set);
4ddbcb886268af Aditi Ghag        2023-05-19  12223  }
4ddbcb886268af Aditi Ghag        2023-05-19 @12224  late_initcall(init_subsystem);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

