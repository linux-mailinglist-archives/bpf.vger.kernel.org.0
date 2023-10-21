Return-Path: <bpf+bounces-12896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B797E7D1B85
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 09:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254092826F8
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C6BD26B;
	Sat, 21 Oct 2023 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TL52Rjkq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC215D5
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 07:31:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12D7D70
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697873457; x=1729409457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ejvklo04DBkvBCX4PM66PVMkqEvTtBI4S9R88xEMMNQ=;
  b=TL52RjkqCdIh9XCnQs7+4etqGWycMwtkvxGENvfwkx0srmPn/W1OhUgQ
   FHpyXLtWioLLL4+D4G535OseBwIsVWclt59ODrrrFDKwZqCCg8t+gPaLI
   2F6dJhI8x0vcrskzToNpK2TRFHZ+rOIOD5tpHw6yZh0gHe3pa1pDti8YS
   dp0338ndkCNln74HQlRFjNZfpGoz3en4wYnaOmTghGgqD371re+qI25BH
   W/mWcYj3fpsBJJOZjigPqpUMz/brtmI+h+uZojtagm9Arx2bMOKwWEdrW
   Ga5MEydfSzAhKAx5gL2JozWyWk3sXixH4k1CDgWf8RDlotlGAqlZIANUN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="5235706"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="5235706"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 00:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="874148831"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="874148831"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Oct 2023 00:30:55 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qu6Rh-0004ZG-1f;
	Sat, 21 Oct 2023 07:30:53 +0000
Date: Sat, 21 Oct 2023 15:30:16 +0800
From: kernel test robot <lkp@intel.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: test if state loops are
 detected in a tricky case
Message-ID: <202310211512.s2yiOSnL-lkp@intel.com>
References: <20231021005939.1041-5-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021005939.1041-5-eddyz87@gmail.com>

Hi Eduard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf-exact-states-comparison-for-iterator-convergence-checks/20231021-090213
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231021005939.1041-5-eddyz87%40gmail.com
patch subject: [PATCH bpf-next 4/5] selftests/bpf: test if state loops are detected in a tricky case
reproduce: (https://download.01.org/0day-ci/archive/20231021/202310211512.s2yiOSnL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310211512.s2yiOSnL-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:SPLIT_STRING: quoted string split across lines
#122: FILE: tools/testing/selftests/bpf/progs/iters.c:1078:
+	"j_loop_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#136: FILE: tools/testing/selftests/bpf/progs/iters.c:1092:
+	"i_loop_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#141: FILE: tools/testing/selftests/bpf/progs/iters.c:1097:
+	"check_one_r6_%=:"
+		"if r6 != 1 goto check_zero_r6_%=;"

WARNING:SPLIT_STRING: quoted string split across lines
#146: FILE: tools/testing/selftests/bpf/progs/iters.c:1102:
+	"check_zero_r6_%=:"
+		"if r6 != 0 goto i_loop_%=;"

WARNING:SPLIT_STRING: quoted string split across lines
#152: FILE: tools/testing/selftests/bpf/progs/iters.c:1108:
+	"check_one_r7_%=:"
+		"if r7 != 1 goto i_loop_%=;"

WARNING:SPLIT_STRING: quoted string split across lines
#166: FILE: tools/testing/selftests/bpf/progs/iters.c:1122:
+	"i_loop_end_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#179: FILE: tools/testing/selftests/bpf/progs/iters.c:1135:
+	"i2_loop_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#184: FILE: tools/testing/selftests/bpf/progs/iters.c:1140:
+	"check2_one_r6_%=:"
+		"if r6 != 1 goto check2_zero_r6_%=;"

WARNING:SPLIT_STRING: quoted string split across lines
#189: FILE: tools/testing/selftests/bpf/progs/iters.c:1145:
+	"check2_zero_r6_%=:"
+		"if r6 != 0 goto i2_loop_%=;"

WARNING:SPLIT_STRING: quoted string split across lines
#195: FILE: tools/testing/selftests/bpf/progs/iters.c:1151:
+	"check2_one_r7_%=:"
+		"if r7 != 1 goto i2_loop_%=;"

WARNING:SPLIT_STRING: quoted string split across lines
#200: FILE: tools/testing/selftests/bpf/progs/iters.c:1156:
+	"i2_loop_end_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#208: FILE: tools/testing/selftests/bpf/progs/iters.c:1164:
+	"j_loop_end_%=:"
+		"r1 = r10;"

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

