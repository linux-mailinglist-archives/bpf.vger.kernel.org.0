Return-Path: <bpf+bounces-15436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C535A7F2093
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0013A1C215BF
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248103985E;
	Mon, 20 Nov 2023 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSELGBH+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2C7C1;
	Mon, 20 Nov 2023 14:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700520497; x=1732056497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gu5CAlJh/aJ4B/630tgSu0ejTqaDqLe8njttTc3hrYY=;
  b=XSELGBH+5YSM9ixmzxcv6dw00l7mw5xIWRH9S+wdW+lVfQ6BPBM8FAGv
   scbH8/tWI8VbJFdokAbx42tYy18ZoMp8IjsI7TrbhJdzEnh3fD8piIWuw
   O3raUV+E02RsODRg/oSuucFCDOWQcFaNuoU5D75aqMBzq4o+AP0x2zBtA
   BbWWpM/hw75aRGxlA33JEOe13xOCw2kDvwrpa7ULdAa6nfBgTPo3X1Iar
   Sm7K4vQZyBTnIR9Ze6lVtvRtGLhNlpxhkc3kDAlXkzYy7wRTrJVSZy8wD
   +/HSc89TIXBG8AK/hecwiotwBv2Dgafq5+KEX1ScdFPtdFc2tPyaix/CA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4912990"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="4912990"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:48:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="939914937"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="939914937"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2023 14:48:12 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5D3q-00071G-04;
	Mon, 20 Nov 2023 22:48:10 +0000
Date: Tue, 21 Nov 2023 06:47:26 +0800
From: kernel test robot <lkp@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Paul Moore <paul@paul-moore.com>,
	Kees Cook <keescook@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 4/4] LSM: Add a LSM module which handles dynamically
 appendable LSM hooks.
Message-ID: <202311210651.Bs3e5XsM-lkp@intel.com>
References: <34be5cd8-1fdd-4323-82a3-40f2e7d35db3@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34be5cd8-1fdd-4323-82a3-40f2e7d35db3@I-love.SAKURA.ne.jp>

Hi Tetsuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]
[also build test ERROR on pcmoore-audit/next pcmoore-selinux/next linus/master v6.7-rc2]
[cannot apply to bpf-next/master next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/LSM-Auto-undef-LSM_HOOK-macro/20231120-214522
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/34be5cd8-1fdd-4323-82a3-40f2e7d35db3%40I-love.SAKURA.ne.jp
patch subject: [PATCH 4/4] LSM: Add a LSM module which handles dynamically appendable LSM hooks.
config: csky-randconfig-002-20231121 (https://download.01.org/0day-ci/archive/20231121/202311210651.Bs3e5XsM-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210651.Bs3e5XsM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210651.Bs3e5XsM-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: kernel/bpf/syscall.o: in function `__bpf_prog_put_rcu':
>> syscall.c:(.text+0x844): undefined reference to `security_bpf_prog_free'
>> csky-linux-ld: syscall.c:(.text+0x87c): undefined reference to `security_bpf_prog_free'
   csky-linux-ld: kernel/bpf/syscall.o: in function `__bpf_prog_put_noref':
   syscall.c:(.text+0x13a4): undefined reference to `security_bpf_prog_free'
   csky-linux-ld: syscall.c:(.text+0x13fc): undefined reference to `security_bpf_prog_free'
   csky-linux-ld: kernel/bpf/syscall.o: in function `bpf_map_free_deferred':
>> syscall.c:(.text+0x3c0e): undefined reference to `security_bpf_map_free'
   csky-linux-ld: kernel/bpf/syscall.o: in function `map_check_btf':
   syscall.c:(.text+0x3ccc): undefined reference to `security_bpf_map_free'
   csky-linux-ld: kernel/bpf/syscall.o: in function `map_create':
>> syscall.c:(.text+0x448a): undefined reference to `security_bpf_map_alloc'
>> csky-linux-ld: syscall.c:(.text+0x4590): undefined reference to `security_bpf_map_alloc'
>> csky-linux-ld: syscall.c:(.text+0x46d0): undefined reference to `security_bpf_map_free'
   csky-linux-ld: syscall.c:(.text+0x4724): undefined reference to `security_bpf_map_free'
   csky-linux-ld: kernel/bpf/syscall.o: in function `bpf_prog_load':
>> syscall.c:(.text+0x4836): undefined reference to `security_bpf_prog_alloc'
>> csky-linux-ld: syscall.c:(.text+0x48c4): undefined reference to `security_bpf_prog_alloc'
   csky-linux-ld: syscall.c:(.text+0x497e): undefined reference to `security_bpf_prog_free'
   csky-linux-ld: syscall.c:(.text+0x49f0): undefined reference to `security_bpf_prog_free'
   mm/zsmalloc.o: in function `__zs_compact':
   zsmalloc.c:(.text+0x2142): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   zsmalloc.c:(.text+0x214a): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/zsmalloc.o: in function `zs_compact':
   zsmalloc.c:(.text+0x218a): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   zsmalloc.c:(.text+0x21ca): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   zsmalloc.c:(.text+0x21d8): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/zsmalloc.o: in function `zs_shrinker_scan':
   zsmalloc.c:(.text+0x21e4): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/zsmalloc.o: in function `zs_page_migrate':
   zsmalloc.c:(.text+0x2234): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   zsmalloc.c:(.text+0x224c): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   zsmalloc.c:(.text+0x2278): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   zsmalloc.c:(.text+0x22a2): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   zsmalloc.c:(.text+0x22b0): additional relocation overflows omitted from the output

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

