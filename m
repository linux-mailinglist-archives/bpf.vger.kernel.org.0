Return-Path: <bpf+bounces-27020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B4F8A7BB7
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 07:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03511C211B0
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 05:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5A524B7;
	Wed, 17 Apr 2024 05:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khXBeIev"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3090E51C3E;
	Wed, 17 Apr 2024 05:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713330873; cv=none; b=f0HMN6c56HkCEO2m0taGODnpkBjPkw9XjRWSa4kXSgfy5aS8Rx9FrzpHwUEjVusV8A9MllrIHcKFUqR+sLWPbMB/+C/rmB+9hkvoTkJeiJ8U/9h1u3WaJvegxjb5kDPVD69b45WarClFdKdL+76xvQHWxSiI0H1WKdpCb8TszME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713330873; c=relaxed/simple;
	bh=Z3HpJ8IYUGTkVom/ohfj7qRrJYFYTS/R6RZzYjiFuCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrAayFEfRN0rDniAeSTei6UqTBtWXM/pkpvKuWoGtiZH3anVtAKpICS9lswsDgRe3GuiPjGinqsuUk/nBND7/aRdRyqRS+p2jbgUV9+Cq0VpZwfntVQQb8++4LYNRNjYfKvZNTBGAuDXKvSFKSrLl+yzGTpJlTcigFXumQ/ENHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khXBeIev; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713330871; x=1744866871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z3HpJ8IYUGTkVom/ohfj7qRrJYFYTS/R6RZzYjiFuCs=;
  b=khXBeIevc59UWdsaWChyDxI7/r1rFSQoxZcPl9SvwXF9Ru/oSUTCZ+gG
   8slxGm1KiGY7f3kObUK6R5p0Wv8giJpIDcifLqG92N51tgemuO80njN74
   vx/gx+o2FgV+faluiIFIbT3da7uo2DFaqIHrB8iYg6RbdJbEkO/UIr6+h
   bMIMSlwqMq5q/k/w5i0cGWLEk5uGFe4IFHkbd1bcKoArlMAWUX778Q4pV
   866XLh0h1t9Z93AxMz1qLyLvadVP7WzAFE0ExlbatDha/2a6n/xbhh9PN
   LnBfE5v41cFeC88AI2jS3RN7uLj34KGhnIli8s6ASdXUa9hgTFMDwEIK6
   Q==;
X-CSE-ConnectionGUID: yNUfbWjpQASFjl6yXug6OQ==
X-CSE-MsgGUID: P0Mg406MSpSZ8BzW7xWPsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="31286265"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="31286265"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 22:14:31 -0700
X-CSE-ConnectionGUID: 39blF0/AQKyU1zfVKuAFJA==
X-CSE-MsgGUID: zN5HxNgBQMySQ56wmbgRVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22371986"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 22:14:23 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwxci-000696-31;
	Wed, 17 Apr 2024 05:14:20 +0000
Date: Wed, 17 Apr 2024 13:14:00 +0800
From: kernel test robot <lkp@intel.com>
To: Maxwell Bland <mbland@motorola.com>,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Maxwell Bland <mbland@motorola.com>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Baoquan He <bhe@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryo Takakura <takakura@valinux.co.jp>,
	James Morse <james.morse@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, bpf@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: mm: code and data partitioning for aslr
Message-ID: <202404171355.jlsKaUGf-lkp@intel.com>
References: <20240416122254.868007168-3-mbland@motorola.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416122254.868007168-3-mbland@motorola.com>

Hi Maxwell,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0bbac3facb5d6cc0171c45c9873a2dc96bea9680]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxwell-Bland/mm-allow-arch-refinement-skip-for-vmap-alloc/20240417-032149
base:   0bbac3facb5d6cc0171c45c9873a2dc96bea9680
patch link:    https://lore.kernel.org/r/20240416122254.868007168-3-mbland%40motorola.com
patch subject: [PATCH 2/5] arm64: mm: code and data partitioning for aslr
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20240417/202404171355.jlsKaUGf-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404171355.jlsKaUGf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404171355.jlsKaUGf-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: arch/arm64/kernel/setup.o: in function `setup_arch':
>> setup.c:(.init.text+0x694): undefined reference to `module_init_limits'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

