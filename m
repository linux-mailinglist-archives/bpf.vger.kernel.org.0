Return-Path: <bpf+bounces-12915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E227A7D20CB
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 05:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D518E1C209B6
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 03:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D0BA57;
	Sun, 22 Oct 2023 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9knUWSG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1AA28
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 03:00:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2CCAC
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 20:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697943641; x=1729479641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F2KFyW2zRP7iwFHHL9CauBQO4ZZx8Zvv92Jh1T0IEK4=;
  b=c9knUWSGXhINusxX9V2KvUQ9ihsRi+sYXuvazcNFfoLT/XRbSHixyjjE
   UqfOIYqFi08UIpWMUDwvSh5Z+MXUedlTFchAy35HHYTJpRq/E7Nc2zdeA
   4vlbIppxH9rxOAXkcozREx5YInKQz6zRe0njCb4ylUnkUYp8nAP2g9dqU
   wYcEGnLgRsjcZO3nWlJ06Re+6W83hJls/qCNExoojCcAGrzwf2sL5T7vc
   Mh5kmrlM240yMe9/mLAxh2ZB4LpAd93BpuViOUykiICSSuOzBBARcpS4g
   1mcgWvMkiEepHndqxrrHD8FGPWHmYJ/TZhUtF5bfy+EljPNJa05AIm5li
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="385560485"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="385560485"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 20:00:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="787150241"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="787150241"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Oct 2023 20:00:39 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1quOhg-0005Vy-2f;
	Sun, 22 Oct 2023 03:00:36 +0000
Date: Sun, 22 Oct 2023 11:00:27 +0800
From: kernel test robot <lkp@intel.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 4/7] selftests/bpf: tests with delayed
 read/precision makrs in loop body
Message-ID: <202310221039.YDfIS2hn-lkp@intel.com>
References: <20231022010812.9201-5-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022010812.9201-5-eddyz87@gmail.com>

Hi Eduard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf-move-explored_state-closer-to-the-beginning-of-verifier-c/20231022-091124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231022010812.9201-5-eddyz87%40gmail.com
patch subject: [PATCH bpf-next v2 4/7] selftests/bpf: tests with delayed read/precision makrs in loop body
reproduce: (https://download.01.org/0day-ci/archive/20231022/202310221039.YDfIS2hn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310221039.YDfIS2hn-lkp@intel.com/

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

WARNING:REPEATED_WORD: Possible repeated word: 'to'
#404: FILE: tools/testing/selftests/bpf/progs/iters.c:1089:
+	 * to to avoid comparing current state with too many explored

WARNING:SPLIT_STRING: quoted string split across lines
#427: FILE: tools/testing/selftests/bpf/progs/iters.c:1112:
+	"loop_%=:"
+		"r1 = r10;"

WARNING:SPLIT_STRING: quoted string split across lines
#462: FILE: tools/testing/selftests/bpf/progs/iters.c:1147:
+	"loop_end_%=:"
+		"r1 = r10;"

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

