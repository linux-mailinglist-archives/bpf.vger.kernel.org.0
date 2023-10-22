Return-Path: <bpf+bounces-12916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659477D20D4
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 05:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EDACB20E40
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 03:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F58EBF;
	Sun, 22 Oct 2023 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fwy6cJ+S"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55163A5A
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 03:12:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991051A3
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 20:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697944361; x=1729480361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lWmeYS76Eb/UCpKjpYadpYZn7phw/jStW+B3l4BFzl0=;
  b=Fwy6cJ+SDf5AcHUiugfoTZtFL38WEjZemOfTo8rzUfHiodkHz6I4rncb
   mqaP+SI19Zdzgy6sw1z7ky2kRSMZbd6FcTRIepysL4QtHOrpfLNp052AB
   pWUtfypkNhIRF43MWy7c3ySh+77GHIOYaSuU1Si/7VmZ12Hg0a6bK6khR
   r0Xi428Z5y0OJiprejrWd8k4oz7TO4vQqZkaQ5nuQTwZ8oh/oDy0lyJgq
   iFLdUnzKiwTfQjhYJ+RTqnqB6hmQZgjSFfkD2Uia6EJoXYA+wED5dVn5E
   JsAulNs1AErILS42hdqwRiqDYipbe9vjWUoCTcbAtFg7W6AgMk5xxsYTx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="366016469"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="366016469"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 20:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="848458298"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="848458298"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Oct 2023 20:12:39 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1quOtJ-0005WU-0T;
	Sun, 22 Oct 2023 03:12:37 +0000
Date: Sun, 22 Oct 2023 11:11:48 +0800
From: kernel test robot <lkp@intel.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 6/7] selftests/bpf: test if state loops are
 detected in a tricky case
Message-ID: <202310221141.vepbw7v8-lkp@intel.com>
References: <20231022010812.9201-7-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022010812.9201-7-eddyz87@gmail.com>

Hi Eduard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf-move-explored_state-closer-to-the-beginning-of-verifier-c/20231022-091124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231022010812.9201-7-eddyz87%40gmail.com
patch subject: [PATCH bpf-next v2 6/7] selftests/bpf: test if state loops are detected in a tricky case
reproduce: (https://download.01.org/0day-ci/archive/20231022/202310221141.vepbw7v8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310221141.vepbw7v8-lkp@intel.com/

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

