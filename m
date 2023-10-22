Return-Path: <bpf+bounces-12936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AEB7D2199
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 09:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BA9281736
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA115CA;
	Sun, 22 Oct 2023 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+WVY5f0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DFF10F8
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 07:08:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A60B4
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 00:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697958528; x=1729494528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ll7bRRqLyPUhWZh2tiYfTL8g4ebpLG8Pby/XEA8Wp9M=;
  b=h+WVY5f0aOt2VBXNs+YHFEFCZNuvZ1a4O6jRqXa/AYyunQhl6SNsqiWZ
   c+HUhc+ecGHnxJ8Nu7iU1wwW60eyDuaNGNPK4zx0tbt/zx6H1gl1zBk9F
   lgsj6Mfi5bCJ5sSeq68X0+/qCtT14MWzS2Yc1i4SIaDhkv+60IMeLvG4x
   m6hK2moNQOV9HaiQN08yRYymBwZR95zs7aWGESbidJjFiSlaW06hRM49S
   zL6OmxtPGAp6VfAe4kdb4+RLyFAdMSNGp7dTv7KU7NC8BhR1SazGN1y3c
   iThcyZOElCzIw/c8PGcbwR3e0AujI9x4LUA/jVONoHoYq4pp4P3MVMvff
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="385568144"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="385568144"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 00:08:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="1089138648"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="1089138648"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Oct 2023 00:08:45 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1quSZn-0005gS-0X;
	Sun, 22 Oct 2023 07:08:43 +0000
Date: Sun, 22 Oct 2023 15:08:26 +0800
From: kernel test robot <lkp@intel.com>
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
	andrii@kernel.org, drosen@google.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf-next v6 10/10] selftests/bpf: test case for
 register_bpf_struct_ops().
Message-ID: <202310221417.1kZi6WXz-lkp@intel.com>
References: <20231022050335.2579051-11-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022050335.2579051-11-thinker.li@gmail.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/thinker-li-gmail-com/bpf-refactory-struct_ops-type-initialization-to-a-function/20231022-131121
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231022050335.2579051-11-thinker.li%40gmail.com
patch subject: [PATCH bpf-next v6 10/10] selftests/bpf: test case for register_bpf_struct_ops().
reproduce: (https://download.01.org/0day-ci/archive/20231022/202310221417.1kZi6WXz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310221417.1kZi6WXz-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:LINE_SPACING: Missing a blank line after declarations
#239: FILE: tools/testing/selftests/bpf/testing_helpers.c:390:
+	long gp_seq;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

