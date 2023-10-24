Return-Path: <bpf+bounces-13089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC2F7D4517
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 03:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFAD1C20B30
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 01:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74046ADF;
	Tue, 24 Oct 2023 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9PgbuHM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B056AB0
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 01:43:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38477D78
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 18:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698111816; x=1729647816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KVoj2Om8bCNOUEAaS1cea1Kwc+yI3yTZ1goF/EnPb10=;
  b=Q9PgbuHMzMK+X+ORuvf3YEptE+CxQT5SCfrcVz/vOUiKUE0NU1OsT1id
   hPBYSrTFbulsMRBig6riOn3JiWpO0C9UPltb6UNKb+OOZpSYe0LhNl53M
   zPWSRRIBGUA5H2flO0s7Cx5D0DAy/1mb8AIQGYtLq3pvCTLCAKY53rBmS
   6ffkuYKdNGdosfFjwm3oTne8ZzmLyWyOVAjp1GtAgWIQdzYwVRqcShRet
   ktLl1gsbtNLGEuDpzK5oDi6lGOgy9dOEVoRo/qpw7JSTkdk0JcM1XIomF
   lkjvMyx0tihZH1sc69Q5x/h5duFnkHRIOxxLCsox+mdRwjRtBXe4aD6Ef
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="418090187"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="418090187"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 18:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="881962230"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="881962230"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2023 18:43:34 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qv6SB-0007SZ-2z;
	Tue, 24 Oct 2023 01:43:31 +0000
Date: Tue, 24 Oct 2023 09:43:19 +0800
From: kernel test robot <lkp@intel.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 4/7] selftests/bpf: tests with delayed
 read/precision makrs in loop body
Message-ID: <202310240902.mvutnvcZ-lkp@intel.com>
References: <20231024000917.12153-5-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024000917.12153-5-eddyz87@gmail.com>

Hi Eduard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf-move-explored_state-closer-to-the-beginning-of-verifier-c/20231024-081049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231024000917.12153-5-eddyz87%40gmail.com
patch subject: [PATCH bpf-next v3 4/7] selftests/bpf: tests with delayed read/precision makrs in loop body
reproduce: (https://download.01.org/0day-ci/archive/20231024/202310240902.mvutnvcZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310240902.mvutnvcZ-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:SPLIT_STRING: quoted string split across lines
#82: FILE: tools/testing/selftests/bpf/progs/iters.c:767:
+	"1:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#91: FILE: tools/testing/selftests/bpf/progs/iters.c:776:
+	"3:"
+		"r1 = r7;"

WARNING:SPLIT_STRING: quoted string split across lines
#97: FILE: tools/testing/selftests/bpf/progs/iters.c:782:
+	"2:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#159: FILE: tools/testing/selftests/bpf/progs/iters.c:844:
+	"1:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#169: FILE: tools/testing/selftests/bpf/progs/iters.c:854:
+	"3:"
+		"r0 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#176: FILE: tools/testing/selftests/bpf/progs/iters.c:861:
+	"2:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#252: FILE: tools/testing/selftests/bpf/progs/iters.c:937:
+	"j_loop_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#264: FILE: tools/testing/selftests/bpf/progs/iters.c:949:
+	"i_loop_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#269: FILE: tools/testing/selftests/bpf/progs/iters.c:954:
+	"check_one_r6_%=:"
+		"if r6 != 1 goto check_zero_r6_%=;"

WARNING:SPLIT_STRING: quoted string split across lines
#274: FILE: tools/testing/selftests/bpf/progs/iters.c:959:
+	"check_zero_r6_%=:"
+		"if r6 != 0 goto i_loop_%=;"

WARNING:SPLIT_STRING: quoted string split across lines
#280: FILE: tools/testing/selftests/bpf/progs/iters.c:965:
+	"check_one_r7_%=:"
+		"if r7 != 1 goto i_loop_%=;"

WARNING:SPLIT_STRING: quoted string split across lines
#294: FILE: tools/testing/selftests/bpf/progs/iters.c:979:
+	"i_loop_end_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#302: FILE: tools/testing/selftests/bpf/progs/iters.c:987:
+	"j_loop_end_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#346: FILE: tools/testing/selftests/bpf/progs/iters.c:1031:
+	"loop_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#359: FILE: tools/testing/selftests/bpf/progs/iters.c:1044:
+	"loop_end_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#400: FILE: tools/testing/selftests/bpf/progs/iters.c:1085:
+	"loop_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#409: FILE: tools/testing/selftests/bpf/progs/iters.c:1094:
+	"loop_end_%=:"
+		"r1 = r10;"

WARNING:REPEATED_WORD: Possible repeated word: 'to'
#454: FILE: tools/testing/selftests/bpf/progs/iters.c:1139:
+	 * to to avoid comparing current state with too many explored

WARNING:SPLIT_STRING: quoted string split across lines
#476: FILE: tools/testing/selftests/bpf/progs/iters.c:1161:
+	"loop_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#537: FILE: tools/testing/selftests/bpf/progs/iters.c:1222:
+	"loop_end_%=:"
+		"r1 = r10;"

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

