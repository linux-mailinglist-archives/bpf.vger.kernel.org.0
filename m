Return-Path: <bpf+bounces-12468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D254D7CCA4C
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 20:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A88B2120B
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7BE2D7A3;
	Tue, 17 Oct 2023 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRkcUPZC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4112D79A
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 18:03:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9B090
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697565827; x=1729101827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n0WXMU1LY3YnJCNPVuYm8z8u7x9uz7Pxab6t6Xe1I3k=;
  b=fRkcUPZCAMQQcXTI9PtUPYZb0bzqNR6261iXCsbGHuuT44jfG7d9Ojr+
   T1M0Wx1rQC6KbyqBExRlsU1DSaNVZsu70Zy8kJVKkqnmmsqEZqv8gker9
   3TZW0zo/i0juq8VozjiQoL1Oe8y6FEUAfcEsRY0NMaAcNqwzYkGkewvBy
   qjAm0iRlfU1NORTHQPewPeHwO/0XFY9IWfxxFKu2Fa4N4ok5SmRHrRvuA
   6JJqrdyneGeMC0kPSMm9yh5G5YrX54IA8Bh9bevZujDdS2ef2s5Mt92in
   LoZpMdeQ+1UnqmiteY686e7TBqPMGJQHFmON8jd0KrmhzHr83EGJU26ti
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="452326850"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="452326850"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 11:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826550083"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="826550083"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2023 11:03:26 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qsoPc-0009vR-0B;
	Tue, 17 Oct 2023 18:03:24 +0000
Date: Wed, 18 Oct 2023 02:03:01 +0800
From: kernel test robot <lkp@intel.com>
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
	andrii@kernel.org, drosen@google.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf-next v5 9/9] selftests/bpf: test case for
 register_bpf_struct_ops().
Message-ID: <202310180128.xAuYnY3h-lkp@intel.com>
References: <20231017162306.176586-10-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017162306.176586-10-thinker.li@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/thinker-li-gmail-com/bpf-refactory-struct_ops-type-initialization-to-a-function/20231018-002613
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231017162306.176586-10-thinker.li%40gmail.com
patch subject: [PATCH bpf-next v5 9/9] selftests/bpf: test case for register_bpf_struct_ops().
reproduce: (https://download.01.org/0day-ci/archive/20231018/202310180128.xAuYnY3h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310180128.xAuYnY3h-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:LINE_SPACING: Missing a blank line after declarations
#239: FILE: tools/testing/selftests/bpf/testing_helpers.c:390:
+	long gp_seq;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

