Return-Path: <bpf+bounces-52764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74D0A482D1
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 16:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AA61887CE8
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5033326AAB8;
	Thu, 27 Feb 2025 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKLV04MR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB724E004;
	Thu, 27 Feb 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669633; cv=none; b=jb8Oxn53nDYaejo7hrnKJVBW5ClqmtjUEm+ztHVxz8VprJQ6Njt1v7b7a5tdC80h8REsZjMppGZb9X7tx70upt/Hqr+Jh9sUhXW3ww4YVwNtNryF6tf9zpC73q/xKsWBm0iNp+Pa8gS9ESEQeKFWSaa6n8e1AR1wgs9MMfzprZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669633; c=relaxed/simple;
	bh=O2RSGihEUeZucdzzlTWlLZ5f5Ojwj25KIj+Cw9BroWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4MucIfRhXq1Owm3jBW0t8CBIXM/zbTpRf57TuT4EOOYYsUieEYskb+FPLnMGfZYxXFTJ8l4sts0/hlHn4nOThWXysHDH4HuXaKpIk4o/m5N2iFxYuqDUJA2QH6RKs2XoUdgpCxKQ9BJwS0R2tf99ibwKLIQu+dkVVuFbxSfPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKLV04MR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740669632; x=1772205632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O2RSGihEUeZucdzzlTWlLZ5f5Ojwj25KIj+Cw9BroWs=;
  b=FKLV04MRYYb7b6aXwpHrfElsZjmra+KifLCD9npobdPcD6XJ+PTnz8f8
   BRO0ec2GprKE4W+RlWeca1D1GXHrG+Mb1pwyqk8LQr694wRmx+VPzISLD
   A/CHUEwzfLQWIx7jZH59NOq3+pEME+lINtvK9p6WV3mvkSaFDt2UedETM
   iNL9zLs3oJ8AO2e4NHxSuAnozxtNelGgeqATD9UOcg87aqtrTGZWOui+0
   t1C1+zxPB2j5gqAEnywl962TNVD+upBjEuAr3d2KAoDiMcIfc7j63A9zw
   HGYQxK3OQ5gr2IG5noLmRg9N61wc4V9WrBfeUvzRGocDyx6ZWz+mpNW+9
   g==;
X-CSE-ConnectionGUID: moKvmkB4RRKSyEy+frWgGA==
X-CSE-MsgGUID: VcAKaJoeRYqyEZSB5xZIqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="59100823"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="59100823"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:20:31 -0800
X-CSE-ConnectionGUID: tghChrLAT3uZcFB1OG6MDw==
X-CSE-MsgGUID: fJ23NbXIRqK8v79NrO9hEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121177193"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 27 Feb 2025 07:20:25 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnfgR-000DYs-2D;
	Thu, 27 Feb 2025 15:20:23 +0000
Date: Thu, 27 Feb 2025 23:18:40 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, rostedt@goodmis.org,
	mark.rutland@arm.com, alexei.starovoitov@gmail.com
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, catalin.marinas@arm.com,
	will@kernel.org, mhiramat@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, mathieu.desnoyers@efficios.com,
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, dongml2@chinatelecom.cn,
	akpm@linux-foundation.org, rppt@kernel.org, graf@amazon.com,
	dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2] add function metadata support
Message-ID: <202502272339.DtueAali-lkp@intel.com>
References: <20250226121537.752241-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226121537.752241-1-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/add-function-metadata-support/20250226-202312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250226121537.752241-1-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next v2] add function metadata support
config: i386-kismet-CONFIG_CALL_PADDING-CONFIG_FUNCTION_METADATA-0-0 (https://download.01.org/0day-ci/archive/20250227/202502272339.DtueAali-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250227/202502272339.DtueAali-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502272339.DtueAali-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for CALL_PADDING when selected by FUNCTION_METADATA
   WARNING: unmet direct dependencies detected for CALL_PADDING
     Depends on [n]: CC_HAS_ENTRY_PADDING [=y] && OBJTOOL [=n]
     Selected by [y]:
     - FUNCTION_METADATA [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

