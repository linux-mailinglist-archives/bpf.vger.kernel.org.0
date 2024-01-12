Return-Path: <bpf+bounces-19405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45182B9BD
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 03:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196961F23EF9
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC9136B;
	Fri, 12 Jan 2024 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EimyvKrb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2C111A
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705027959; x=1736563959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gULOz4wSNw6VRb753Cs6Pq8UhUr772nmVhTnaD2EZIc=;
  b=EimyvKrbAvE0F9hB+Jf1dmYXvI5nzVesr4sLo/iAQm8L9KnIOeSsFDNT
   q98awfafVaVflCUpBh8DjZIxx7/8vWJCwavAsE2EOe0Jn3Kq5RPhtXr7I
   c7OP5omkkq95GCGDx1V7AkJj99A/9kkxmX/JHC1v1TvZ+1Edxpq7qrtu+
   Rkuu78fRH+4GILEhZd5qW4WbiJfUsO9gK9ezRYFSvjUw6SMFDVvsjDi0r
   m2Vxy3uGxuENh3SlAaXIOaiz34CuccnX5450oqr6/WVfZVl/pk0Mvoo7w
   cSIGPfsmfeKaKzqYjZvBMfNwo9ju2QZ9/rfB2Mmq0jSHqBudeMW4XHZmV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6433971"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="6433971"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 18:52:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="31235980"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 11 Jan 2024 18:52:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO7er-0008yq-1G;
	Fri, 12 Jan 2024 02:52:33 +0000
Date: Fri, 12 Jan 2024 10:52:04 +0800
From: kernel test robot <lkp@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>
Cc: oe-kbuild-all@lists.linux.dev, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH] bpftool: Add missing libgen.h for basename()
Message-ID: <202401121009.hCPmwMe6-lkp@intel.com>
References: <ZZYgMYmb_qE94PUB@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZYgMYmb_qE94PUB@kernel.org>

Hi Arnaldo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master linus/master v6.7 next-20240111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaldo-Carvalho-de-Melo/bpftool-Add-missing-libgen-h-for-basename/20240104-110542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/ZZYgMYmb_qE94PUB%40kernel.org
patch subject: [PATCH] bpftool: Add missing libgen.h for basename()
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121009.hCPmwMe6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121009.hCPmwMe6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Makefile.config:1153: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev
     PERF_VERSION = 6.7.rc6.ge6bdf4fd535b
   gen.c: In function 'get_obj_name':
>> gen.c:61:32: warning: passing argument 1 of '__xpg_basename' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      61 |         strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
         |                                ^~~~
   In file included from gen.c:10:
   /usr/include/libgen.h:34:36: note: expected 'char *' but argument is of type 'const char *'
      34 | extern char *__xpg_basename (char *__path) __THROW;
         |                              ~~~~~~^~~~~~
--
   gen.c: In function 'get_obj_name':
>> gen.c:61:32: warning: passing argument 1 of '__xpg_basename' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      61 |         strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
         |                                ^~~~
   In file included from gen.c:10:
   /usr/include/libgen.h:34:36: note: expected 'char *' but argument is of type 'const char *'
      34 | extern char *__xpg_basename (char *__path) __THROW;
         |                              ~~~~~~^~~~~~
   gen.c: In function 'get_obj_name':
>> gen.c:61:32: warning: passing argument 1 of '__xpg_basename' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      61 |         strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
         |                                ^~~~
   In file included from gen.c:10:
   /usr/include/libgen.h:34:36: note: expected 'char *' but argument is of type 'const char *'
      34 | extern char *__xpg_basename (char *__path) __THROW;
         |                              ~~~~~~^~~~~~
   gen.c: In function 'get_obj_name':
>> gen.c:61:32: warning: passing argument 1 of '__xpg_basename' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      61 |         strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
         |                                ^~~~
   In file included from gen.c:10:
   /usr/include/libgen.h:34:36: note: expected 'char *' but argument is of type 'const char *'
      34 | extern char *__xpg_basename (char *__path) __THROW;
         |                              ~~~~~~^~~~~~
--
   gen.c: In function 'get_obj_name':
>> gen.c:61:32: warning: passing argument 1 of '__xpg_basename' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      61 |         strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
         |                                ^~~~
   In file included from gen.c:10:
   /usr/include/libgen.h:34:36: note: expected 'char *' but argument is of type 'const char *'
      34 | extern char *__xpg_basename (char *__path) __THROW;
         |                              ~~~~~~^~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

