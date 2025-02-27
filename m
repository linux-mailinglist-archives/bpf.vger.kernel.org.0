Return-Path: <bpf+bounces-52773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0CDA4857B
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5418F17C3C6
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1936F1CAA96;
	Thu, 27 Feb 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLcsGKrX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC51B982C;
	Thu, 27 Feb 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673987; cv=none; b=VFV4MpX5hEH+N9aSktGfciPaDH5qra6HPjyhI9CQTd8jHr94lS7nISWz8P7KDYLsHkiCifyFRvVysOaV2h9/2rSQWnpWd9f2AnTuzMQ01OZm8bsdGAgPXzeJQYXLYUbSRgaWIsXHhpPrcDLo0xofYHbJTx6ATPh/347NmZzDyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673987; c=relaxed/simple;
	bh=BD4f1tzirgqPmQ5M6W5JBi3601o80CXVHLpgb/NNKms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hvexu96sJ5h0lU+ZkAd2UzBi4GTpR2w8GuPqLla/1p20jdKTzK6Rd/Kscng3fsKhw0ap6SOQ4AgaPfJVLFMrSNoDN3IHqjNK8CZ91hxPyyuI7Y0h6lzSxZPwqnc9btW6Ip1ZLKlLMN3GrE8SGpfXKVivHxdl9ZcaviB2x15vPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLcsGKrX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740673986; x=1772209986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BD4f1tzirgqPmQ5M6W5JBi3601o80CXVHLpgb/NNKms=;
  b=iLcsGKrXspp6+KiNjBPJztHgsl6eupNwioCUdqnNWFaP687yC2KpY5rx
   D6GiBMyPDBUymFiiCAlRiHSFx8hF+1CKMETXY+WUNG+RxU7kVMKHBaO2H
   TTolUGJZuR6BI5aDQTnqUSjyfTM0uHZYbAPlc21KrxPRnaaeeNMhtSsm+
   7JuA8LJxc+WO7gzselP7mqnSb1nyNcKxbNMihNsEupjbqUZ/k3YAlK6iC
   dCMFaLtzISuxDJqjt/MguqJ3b8CFn9qaHF7YFKZP99EVhnHU7tRjNfMBz
   okdTcuwasbTUWlFv9nZZcyFs1anKy4/tW50eLmNOugC3Bcm7b8LnbTJv4
   w==;
X-CSE-ConnectionGUID: yB87Gu95QYer00NOsFyYNg==
X-CSE-MsgGUID: 0F9WsLj8QZO9h7/aJc/AWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52985974"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52985974"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 08:33:06 -0800
X-CSE-ConnectionGUID: MWXNu6UFS3qVgsk7wMMXFQ==
X-CSE-MsgGUID: Ykyo5a2lRQ6WUsTSyMn8Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="140304005"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 27 Feb 2025 08:33:00 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tngoj-000Dhm-2B;
	Thu, 27 Feb 2025 16:32:57 +0000
Date: Fri, 28 Feb 2025 00:32:28 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, rostedt@goodmis.org,
	mark.rutland@arm.com, alexei.starovoitov@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org,
	mhiramat@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, mathieu.desnoyers@efficios.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	dongml2@chinatelecom.cn, akpm@linux-foundation.org, rppt@kernel.org,
	graf@amazon.com, dan.j.williams@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2] add function metadata support
Message-ID: <202502280004.QmU2zIb5-lkp@intel.com>
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
config: x86_64-randconfig-r112-20250227 (https://download.01.org/0day-ci/archive/20250228/202502280004.QmU2zIb5-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280004.QmU2zIb5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280004.QmU2zIb5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/kfunc_md.c:12:23: sparse: sparse: symbol 'kfunc_mds' redeclared with different type (different address spaces):
   kernel/trace/kfunc_md.c:12:23: sparse:    struct kfunc_md [noderef] __rcu *[addressable] [toplevel] kfunc_mds
   kernel/trace/kfunc_md.c: note: in included file:
   include/linux/kfunc_md.h:16:24: sparse: note: previously declared as:
   include/linux/kfunc_md.h:16:24: sparse:    struct kfunc_md *extern [addressable] [toplevel] kfunc_mds
>> kernel/trace/kfunc_md.c:186:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct kfunc_md *md @@     got struct kfunc_md [noderef] __rcu * @@
   kernel/trace/kfunc_md.c:186:20: sparse:     expected struct kfunc_md *md
   kernel/trace/kfunc_md.c:186:20: sparse:     got struct kfunc_md [noderef] __rcu *

vim +186 kernel/trace/kfunc_md.c

   169	
   170	/* Get a exist metadata by the function address, and NULL will be returned
   171	 * if not exist.
   172	 *
   173	 * NOTE: rcu lock should be held during reading the metadata, and
   174	 * kfunc_md_lock should be held if writing happens.
   175	 */
   176	struct kfunc_md *kfunc_md_find(void *ip)
   177	{
   178		struct kfunc_md *md;
   179		u32 index;
   180	
   181		if (kfunc_md_arch_exist(ip)) {
   182			index = kfunc_md_get_index(ip);
   183			if (WARN_ON_ONCE(index >= kfunc_md_count))
   184				return NULL;
   185	
 > 186			md = &kfunc_mds[index];
   187			return md;
   188		}
   189		return NULL;
   190	}
   191	EXPORT_SYMBOL_GPL(kfunc_md_find);
   192	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

