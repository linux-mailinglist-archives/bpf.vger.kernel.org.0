Return-Path: <bpf+bounces-11162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A37B4202
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 18:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 4CC0BB20CE6
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9997A17997;
	Sat, 30 Sep 2023 16:14:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109523D8
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 16:14:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7682FB9;
	Sat, 30 Sep 2023 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696090452; x=1727626452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BBGRDQrt5IKd0oWFR3VNPSBvkxTXjwI0I+Nd1sQeCQg=;
  b=UQYs11bZFatX1yN1HAs6UxZZriyv9ZdzWaufOInvOHgnsEt39f0yQ6fw
   EboMPMK2FqhPsBizg/S4JWand4JaOkGYuxPJVll1RDhgHoG7lpK+WG6ZW
   y2WwAbbAVrJLW7j56qIR2t/RvcuiOTycFQB2FhXkSyVCNnih+meBrB3Hp
   Ty0X5kPgzptH7o2CMn5lHzVRDQ/d1BFic7E6vK+yUbHOVm4lOIiJwJ54f
   IIFYE6JzVZeYYewFv4iYmxb8aXNhZ4/YlRWPjXYJ6cFXAK/IczuYfnOfs
   cCLWs7t1mX8vrwiQOk/IX0q7sCtU10mGBVgdvMELa8pU7qYAi5kkFdsnx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="1050835"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="1050835"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 09:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="1148265"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 30 Sep 2023 09:14:09 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qmcbV-0004Gl-2p;
	Sat, 30 Sep 2023 16:14:05 +0000
Date: Sun, 1 Oct 2023 00:13:06 +0800
From: kernel test robot <lkp@intel.com>
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, paul@paul-moore.com,
	keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, kpsingh@kernel.org,
	renauld@google.com
Subject: Re: [PATCH v5 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202309302332.1mxVwb0U-lkp@intel.com>
References: <20230928202410.3765062-4-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928202410.3765062-4-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi KP,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master pcmoore-selinux/next linus/master v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20230929-042610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230928202410.3765062-4-kpsingh%40kernel.org
patch subject: [PATCH v5 3/5] security: Replace indirect LSM hook calls with static calls
config: i386-randconfig-001-20230930 (https://download.01.org/0day-ci/archive/20230930/202309302332.1mxVwb0U-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309302332.1mxVwb0U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309302332.1mxVwb0U-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/security.c:139:1: error: Only string constants are supported as initializers for randomized structures with flexible arrays
     139 | };
         | ^


vim +139 security/security.c

   118	
   119	/*
   120	 * Initialise a table of static calls for each LSM hook.
   121	 * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CALL_KEY)
   122	 * and a trampoline (STATIC_CALL_TRAMP) which are used to call
   123	 * __static_call_update when updating the static call.
   124	 */
   125	struct lsm_static_calls_table static_calls_table __ro_after_init = {
   126	#define INIT_LSM_STATIC_CALL(NUM, NAME)					\
   127		(struct lsm_static_call) {					\
   128			.key = &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),	\
   129			.trampoline = LSM_HOOK_TRAMP(NAME, NUM),		\
   130			.active = &SECURITY_HOOK_ACTIVE_KEY(NAME, NUM),		\
   131		},
   132	#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
   133		.NAME = {							\
   134			LSM_DEFINE_UNROLL(INIT_LSM_STATIC_CALL, NAME)		\
   135		},
   136	#include <linux/lsm_hook_defs.h>
   137	#undef LSM_HOOK
   138	#undef INIT_LSM_STATIC_CALL
 > 139	};
   140	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

