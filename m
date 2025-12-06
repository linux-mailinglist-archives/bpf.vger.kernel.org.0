Return-Path: <bpf+bounces-76208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47827CAA0F8
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 06:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B655B31B4D1F
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 05:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445AA279DAB;
	Sat,  6 Dec 2025 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2YMKR7I"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232926D4EF;
	Sat,  6 Dec 2025 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764997726; cv=none; b=OpN7aWS2ZouT6NYaWA4njMEtm2uHSzbpBRFge8IJ7DgoyQfC9dUc8FDjArumT7J2qTYa/ufAXI+Pjv2Uw3kcAY6WvVR24onoEsTxy5IUG0wSEzE4/Ev52zdZCH3kPxpjGK9kzZpx6eSbhaPOJw5FvRou8MBYicWgmmfb4b0zKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764997726; c=relaxed/simple;
	bh=j/QZd/4kMu55XIBOPMe09h9lbHWk2lk9IH8f+xSQTMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opA6l1D+jyq5WmEBWUs3kwoIESpB0LvXhV7pxnNv3s180OC2CJxmxmtiojqfiFXSBiMs5JFrdkJZuAANwaG8f/rGQDoAYXVhiKFJLF3D99Vys0OVWOxM194E/R9aM2uxiKRGgg2+n2MxzUqXsjWpU1eN8iutXzwa2AL5IiCaUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2YMKR7I; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764997726; x=1796533726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j/QZd/4kMu55XIBOPMe09h9lbHWk2lk9IH8f+xSQTMI=;
  b=m2YMKR7I53NYnAl3mzHUGgGVDNwjCRufAS6WAUtunjo/pV+J8JaQG/rd
   cAlkALCL5KjP4DUW22yYlVo9XTsEjbfbOszG60FzAHG6imm/e8Chl0LJ7
   w4iWwJ3cmhweOFd06FAAm1veVc4Um3TrVQT3CETps0Ae9p4fHcuLSHXLp
   /8xk/SjhE1vnqUlMzESAHd/GkiWAxzJVxO+UYFYlDWLx26UkGP2evdLfd
   KeTgcpGTSx5tmMMlt6/2UGcSkBfxqLPBnvSad1ZadFtTNW/GzZaSb8LqM
   4UpJNeZb+0awPsriyA/2B4GCVN3cRLVoYm1TJIiWDrAX1NNyRzLfg6H8y
   g==;
X-CSE-ConnectionGUID: mXY5B8F0QjSjwb13KBF9Eg==
X-CSE-MsgGUID: T6MzgMbsRHSNCDxYnIh8+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="78495344"
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="78495344"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 21:08:45 -0800
X-CSE-ConnectionGUID: 5NkFzyigRJCQ95sxGNR5lQ==
X-CSE-MsgGUID: laItp1lsTTyzFqCULrsegA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="199911934"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Dec 2025 21:08:39 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRkX6-00000000FsB-45ha;
	Sat, 06 Dec 2025 05:08:36 +0000
Date: Sat, 6 Dec 2025 13:08:11 +0800
From: kernel test robot <lkp@intel.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
Message-ID: <202512061213.85NHVN2W-lkp@intel.com>
References: <20251127185242.3954132-5-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127185242.3954132-5-ihor.solodrai@linux.dev>

Hi Ihor,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Ihor-Solodrai/resolve_btfids-rename-object-btf-field-to-btf_path/20251128-025645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251127185242.3954132-5-ihor.solodrai%40linux.dev
patch subject: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update with raw binary output
config: arm64-randconfig-004-20251205 (https://download.01.org/0day-ci/archive/20251206/202512061213.85NHVN2W-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 14bf95b06a18b9b59c89601cbc0e5a6f2176b118)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251206/202512061213.85NHVN2W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512061213.85NHVN2W-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: .tmp_vmlinux1.btf.o is incompatible with aarch64elf

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

