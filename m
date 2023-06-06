Return-Path: <bpf+bounces-1928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE95724209
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 14:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AD41C20D60
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C82A9DB;
	Tue,  6 Jun 2023 12:26:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF62A9C6
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 12:26:29 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9720710C7;
	Tue,  6 Jun 2023 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686054388; x=1717590388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rjRBgamwSeRSfHezoWT0bmvktJ8N6eyh4nvQHsFNuDQ=;
  b=fhfvs9MEvSU7P5uTfW+4YJwKRPX73M6vMEt3T5btWxmxMl67XuA9JUoE
   DdO77wx5r6xJuSc+W9iwPE9DkU/31o9Q3Y5N/wqA3v0ETLtQNQj3xMfgU
   Y2Lt0LZFYfZzSyuDysTadtFOkk72TivxpIsv/6Dm0TUNR7JL+s9OBHn4n
   7WCXb0OWxfr9gOcXC58VD0Ggcr83YePYJxqfXvGIE2tzBo4l1GTavu3R7
   Ma2ufr3s+JHOTi3nWpahC9fxc7bZHsZ5nHchx+HcVe3WfZAPkatS1bMPA
   sOq3IWx2DfahYuXKB7QfzJSDcyq0HZvGdsvBSAJ9V/y20Ssyyud2VVfMe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="443031643"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="443031643"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 05:26:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="883321208"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="883321208"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Jun 2023 05:26:23 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q6VlW-0005Dv-21;
	Tue, 06 Jun 2023 12:26:22 +0000
Date: Tue, 6 Jun 2023 20:26:13 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 1/4] perf build: Add ability to build with a generated
 vmlinux.h
Message-ID: <202306062005.DdBIyoSS-lkp@intel.com>
References: <20230605202712.1690876-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605202712.1690876-2-irogers@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on acme/perf/core]
[also build test WARNING on tip/master tip/auto-latest linus/master v6.4-rc5 next-20230606]
[cannot apply to tip/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-build-Add-ability-to-build-with-a-generated-vmlinux-h/20230606-043106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
patch link:    https://lore.kernel.org/r/20230605202712.1690876-2-irogers%40google.com
patch subject: [PATCH v2 1/4] perf build: Add ability to build with a generated vmlinux.h
config: i386-randconfig-i052-20230605 (https://download.01.org/0day-ci/archive/20230606/202306062005.DdBIyoSS-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add acme https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
        git fetch acme perf/core
        git checkout acme/perf/core
        b4 shazam https://lore.kernel.org/r/20230605202712.1690876-2-irogers@google.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306062005.DdBIyoSS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> tools/perf/util/bpf_skel/vmlinux/vmlinux.h: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

