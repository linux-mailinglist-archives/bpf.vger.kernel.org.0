Return-Path: <bpf+bounces-72985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1811EC1F847
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F28A4E8F3E
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB22F3546F3;
	Thu, 30 Oct 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+jzHI/3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C13546E4;
	Thu, 30 Oct 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819921; cv=none; b=Xes2FigcOGRI1Dva1I0b2lTBHnvaZgYTTy+H4/FhWP9gaVN0D4xP3ap5bVef/PaW4ZJl60+pZ3I6oPJHSDJFByb1w668VISf+9fhDWzUBKQc/uvjUulPPfnirUw/RjTAWMumylhh9dMKP/SryBrRNsiTLfjtnda0mNrzAoH+XBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819921; c=relaxed/simple;
	bh=f2lx/MhFQYSKhUR31WYWuqc0AYVs7PutTou05pAc9Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh7lg7WLa+8ujl71Y529DKf2Pke/vlezoMFqMeXVyGfD4brD5qDGGAFW7ubC/fEk8UkNDq0CKnS6ar6zEN2is9A5wg3GJ4capz0D2jYNrn14ROlprGdDfNu0ea/uDEbCiP4OtEF0Zym4pJPvxPrlh5t3ftl2xMYck0abe2B1bKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+jzHI/3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761819918; x=1793355918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f2lx/MhFQYSKhUR31WYWuqc0AYVs7PutTou05pAc9Og=;
  b=k+jzHI/3bTLCu3oqRaQFHoyNDaHj+3VN3cqPEA5fE/Qqxi7SYRR3BtJc
   7+xX7OWKgwm3y1ZFjIc0oDt0Aniq9SrNO46peIIT37Cg5MM2I+z5K98Sn
   04Izh8Zpns+rpLyskvXKXy0TVSNvJfQhIyZVRTPyj4PxVoqWoEvlcYmAD
   dp1GRrlQ/3sM23yPaXeaA4L1qpzDaRpg94jp4etfYtdfiQ+s7imfs6flb
   52Zecb48s9ProeebMtU3FQmoSiDWSe+Z/wa7JKHyy0rFtDX6wBbGOaX67
   Ul0p6s31F3t42sU0kbsIfG8WomvMUkcUKIIGsmiiUlxh6YyAVFuXLqldb
   g==;
X-CSE-ConnectionGUID: 11OF3SUxTn6KOJxZpRS+pA==
X-CSE-MsgGUID: A8Sm9KSzSyO4OrtMjOf4Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81377012"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81377012"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 03:25:18 -0700
X-CSE-ConnectionGUID: UnfdYnT4R8ScBpZHHrl7mA==
X-CSE-MsgGUID: p0aQ7k8iS0y4aWaETccOpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="209499657"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 30 Oct 2025 03:25:15 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEPqD-000Lou-0J;
	Thu, 30 Oct 2025 10:25:13 +0000
Date: Thu, 30 Oct 2025 18:24:19 +0800
From: kernel test robot <lkp@intel.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
	andrii@kernel.org, ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dwarves@vger.kernel.org,
	alan.maguire@oracle.com, acme@kernel.org, eddyz87@gmail.com,
	tj@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with
 KF_MAGIC_ARGS
Message-ID: <202510301811.fP0doUEk-lkp@intel.com>
References: <20251029190113.3323406-4-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029190113.3323406-4-ihor.solodrai@linux.dev>

Hi Ihor,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Ihor-Solodrai/bpf-Add-BTF_ID_LIST_END-and-BTF_ID_LIST_SIZE-macros/20251030-030608
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251029190113.3323406-4-ihor.solodrai%40linux.dev
patch subject: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with KF_MAGIC_ARGS
config: x86_64-buildonly-randconfig-003-20251030 (https://download.01.org/0day-ci/archive/20251030/202510301811.fP0doUEk-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510301811.fP0doUEk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510301811.fP0doUEk-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                       ^
   include/linux/compiler.h:166:29: note: in expansion of macro '__PASTE'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:166:37: note: in expansion of macro '__PASTE'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/compiler.h:286:9: note: in expansion of macro '__UNIQUE_ID'
     286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |         ^~~~~~~~~~~
   include/linux/compiler.h:289:9: note: in expansion of macro '___ADDRESSABLE'
     289 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^~~~~~~~~~~~~~
   include/linux/init.h:250:9: note: in expansion of macro '__ADDRESSABLE'
     250 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:255:9: note: in expansion of macro '__define_initcall_stub'
     255 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:268:9: note: in expansion of macro '____define_initcall'
     268 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '__unique_initcall'
     274 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:276:35: note: in expansion of macro '___define_initcall'
     276 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:307:41: note: in expansion of macro '__define_initcall'
     307 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:18983:1: note: in expansion of macro 'late_initcall'
   18983 | late_initcall(unbound_reg_init);
         | ^~~~~~~~~~~~~
   In file included from include/uapi/linux/filter.h:9,
                    from include/linux/bpf.h:8:
   kernel/bpf/verifier.c:18983:15: error: 'unbound_reg_init' undeclared (first use in this function); did you mean 'unbound_reg'?
   18983 | late_initcall(unbound_reg_init);
         |               ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:286:72: note: in definition of macro '___ADDRESSABLE'
     286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |                                                                        ^~~
   include/linux/init.h:250:9: note: in expansion of macro '__ADDRESSABLE'
     250 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:255:9: note: in expansion of macro '__define_initcall_stub'
     255 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:268:9: note: in expansion of macro '____define_initcall'
     268 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '__unique_initcall'
     274 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:276:35: note: in expansion of macro '___define_initcall'
     276 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:307:41: note: in expansion of macro '__define_initcall'
     307 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:18983:1: note: in expansion of macro 'late_initcall'
   18983 | late_initcall(unbound_reg_init);
         | ^~~~~~~~~~~~~
   kernel/bpf/verifier.c:18983:15: note: each undeclared identifier is reported only once for each function it appears in
   18983 | late_initcall(unbound_reg_init);
         |               ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:286:72: note: in definition of macro '___ADDRESSABLE'
     286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |                                                                        ^~~
   include/linux/init.h:250:9: note: in expansion of macro '__ADDRESSABLE'
     250 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:255:9: note: in expansion of macro '__define_initcall_stub'
     255 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:268:9: note: in expansion of macro '____define_initcall'
     268 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '__unique_initcall'
     274 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:276:35: note: in expansion of macro '___define_initcall'
     276 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:307:41: note: in expansion of macro '__define_initcall'
     307 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:18983:1: note: in expansion of macro 'late_initcall'
   18983 | late_initcall(unbound_reg_init);
         | ^~~~~~~~~~~~~
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:108,
                    from include/linux/bug.h:5,
                    from include/linux/alloc_tag.h:8,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:11:
>> include/linux/init.h:256:9: error: expected declaration specifiers before 'asm'
     256 |         asm(".section   \"" __sec "\", \"a\"            \n"     \
         |         ^~~
   include/linux/init.h:268:9: note: in expansion of macro '____define_initcall'
     268 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '__unique_initcall'
     274 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:276:35: note: in expansion of macro '___define_initcall'
     276 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:307:41: note: in expansion of macro '__define_initcall'
     307 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:18983:1: note: in expansion of macro 'late_initcall'
   18983 | late_initcall(unbound_reg_init);
         | ^~~~~~~~~~~~~
   In file included from include/linux/init.h:5:
   include/linux/build_bug.h:78:41: error: expected declaration specifiers before '_Static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/init.h:260:9: note: in expansion of macro 'static_assert'
     260 |         static_assert(__same_type(initcall_t, &fn));
         |         ^~~~~~~~~~~~~
   include/linux/init.h:268:9: note: in expansion of macro '____define_initcall'
     268 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '__unique_initcall'
     274 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:276:35: note: in expansion of macro '___define_initcall'
     276 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:307:41: note: in expansion of macro '__define_initcall'
     307 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:18983:1: note: in expansion of macro 'late_initcall'
   18983 | late_initcall(unbound_reg_init);
         | ^~~~~~~~~~~~~
   kernel/bpf/verifier.c:18983:32: error: expected declaration specifiers before ';' token
   18983 | late_initcall(unbound_reg_init);
         |                                ^
   kernel/bpf/verifier.c:18987:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   18987 | {
         | ^
   kernel/bpf/verifier.c:19002:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19002 | {
         | ^
   kernel/bpf/verifier.c:19015:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19015 | {
         | ^
   kernel/bpf/verifier.c:19139:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19139 | {
         | ^
   kernel/bpf/verifier.c:19212:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19212 | {
         | ^
   kernel/bpf/verifier.c:19232:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19232 | {
         | ^
   kernel/bpf/verifier.c:19241:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19241 | {
         | ^
   kernel/bpf/verifier.c:19282:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19282 | {
         | ^
   kernel/bpf/verifier.c:19343:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19343 | {
         | ^
   kernel/bpf/verifier.c:19373:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19373 | {
         | ^
   kernel/bpf/verifier.c:19390:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19390 | {
         | ^
   kernel/bpf/verifier.c:19453:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19453 | {
         | ^
   kernel/bpf/verifier.c:19477:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19477 | {
         | ^
   kernel/bpf/verifier.c:19833:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19833 | {
         | ^
   kernel/bpf/verifier.c:19861:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19861 | {
         | ^
   kernel/bpf/verifier.c:19867:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19867 | {
         | ^
   kernel/bpf/verifier.c:19878:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19878 | {
         | ^
   kernel/bpf/verifier.c:19884:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
   19884 | {
         | ^
   kernel/bpf/verifier.c:19930:1: warning: empty declaration


vim +/asm +256 include/linux/init.h

a8cccdd954732a5 Sami Tolvanen  2020-12-11  252  
1b1eeca7e4c19fa Ard Biesheuvel 2018-08-21  253  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
3578ad11f3fba07 Sami Tolvanen  2020-12-11  254  #define ____define_initcall(fn, __stub, __name, __sec)		\
3578ad11f3fba07 Sami Tolvanen  2020-12-11  255  	__define_initcall_stub(__stub, fn)			\
a8cccdd954732a5 Sami Tolvanen  2020-12-11 @256  	asm(".section	\"" __sec "\", \"a\"		\n"	\
a8cccdd954732a5 Sami Tolvanen  2020-12-11  257  	    __stringify(__name) ":			\n"	\
3578ad11f3fba07 Sami Tolvanen  2020-12-11  258  	    ".long	" __stringify(__stub) " - .	\n"	\
1cb61759d407166 Marco Elver    2021-05-21  259  	    ".previous					\n");	\
1cb61759d407166 Marco Elver    2021-05-21  260  	static_assert(__same_type(initcall_t, &fn));
1b1eeca7e4c19fa Ard Biesheuvel 2018-08-21  261  #else
3578ad11f3fba07 Sami Tolvanen  2020-12-11  262  #define ____define_initcall(fn, __unused, __name, __sec)	\
a8cccdd954732a5 Sami Tolvanen  2020-12-11  263  	static initcall_t __name __used 			\
a8cccdd954732a5 Sami Tolvanen  2020-12-11  264  		__attribute__((__section__(__sec))) = fn;
1b1eeca7e4c19fa Ard Biesheuvel 2018-08-21  265  #endif
1b1eeca7e4c19fa Ard Biesheuvel 2018-08-21  266  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

