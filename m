Return-Path: <bpf+bounces-59170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C67AC6901
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 14:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BE24A8281
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 12:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF1284662;
	Wed, 28 May 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyVJfX74"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05B283C9D;
	Wed, 28 May 2025 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748434624; cv=none; b=MOLyu7xQ0bXPG0XQJlA0WrhJsfXyyTUDv87f8M7QP3F+BsDan5w1x8xEbld+whyZPSQPTuTG+Uo3tyceRg+Q7MeQKFQun0KkiTyEOhpPqiZAVf69s0pMJkd6vXQNTxB7wTJ1XCOr2KOyaTUULuaR2v9izU1Wjbr2lajO5aq5tU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748434624; c=relaxed/simple;
	bh=zliaatdZSG3ID75nB4njeI5zRcmiAOD/ZqOPCvHelOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jomh+dpr1Fo9NYoUTrk646lC6hP12bMqiCys/GWxxMWlPrj5OIozVAu03Ft8Fb98H2Sw6U64+G9YSOj80b6GfFpfp352VAgb3min9+HohqC4dymGFEhOPcKHlAmYlvIkiW8xMeE7nXqxy4JESADjdz1rtXl2vv4o28aKNhR+trw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyVJfX74; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748434623; x=1779970623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zliaatdZSG3ID75nB4njeI5zRcmiAOD/ZqOPCvHelOs=;
  b=QyVJfX74mr4CeNPW4oHeF1zq3PsJPZHV1k8CGDPq0yVt30UPuUOFSvzV
   1SibCpVjcHBERq4KClSendu+AYQUx9cLlv5r3IQt2PqaemaEz76PbjTE2
   Ahg9KxAeMr6fGvYj31BXA6tYnyaQDJ+S9kD7ygpH2UZjoh/qzaau68GgC
   mWB61P5FTj+aSEMTdW3Cbe4sbnrc/1zI/uNvN2LGJhcyKfKMwv11P3Yed
   Ra8StP5TMPjrvuAYE0XoI7p/TU6EGlXNJ9Tb2VT5uNqvNRfQioDAe04Nc
   Dcpbq2CGIj/7oikFgl32ysbtF0jPT0dfI9VEGk29kYg65NQYFjs+wrc2O
   g==;
X-CSE-ConnectionGUID: iy6KrfmaQ0ms86CslONP4g==
X-CSE-MsgGUID: TgcGfzKYTDWZa3ZILSc1GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68005234"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="68005234"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 05:17:02 -0700
X-CSE-ConnectionGUID: zfMKmqs0Qnmx7lKJ9Bpfqw==
X-CSE-MsgGUID: TNY0VZEKTUW6+mR/lzVwxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="144192208"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 28 May 2025 05:17:01 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKFiM-000Ve0-1S;
	Wed, 28 May 2025 12:16:58 +0000
Date: Wed, 28 May 2025 20:16:32 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
	rostedt@goodmis.org, jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 03/25] arm64: implement per-function metadata
 storage for arm64
Message-ID: <202505282007.0CscfzXZ-lkp@intel.com>
References: <20250528034712.138701-4-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528034712.138701-4-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/add-per-function-metadata-storage-support/20250528-115819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250528034712.138701-4-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next 03/25] arm64: implement per-function metadata storage for arm64
config: arm64-randconfig-002-20250528 (https://download.01.org/0day-ci/archive/20250528/202505282007.0CscfzXZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250528/202505282007.0CscfzXZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505282007.0CscfzXZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> aarch64-linux-gcc: error: unrecognized command line option '-fpatchable-function-entry=1,1'
   make[3]: *** [scripts/Makefile.build:203: scripts/mod/empty.o] Error 1 shuffle=4239289662
>> aarch64-linux-gcc: error: unrecognized command line option '-fpatchable-function-entry=1,1'
   make[3]: *** [scripts/Makefile.build:98: scripts/mod/devicetable-offsets.s] Error 1 shuffle=4239289662
   make[3]: Target 'scripts/mod/' not remade because of errors.
   make[2]: *** [Makefile:1281: prepare0] Error 2 shuffle=4239289662
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=4239289662
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=4239289662
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

