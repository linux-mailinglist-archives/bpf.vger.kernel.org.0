Return-Path: <bpf+bounces-40067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC6197BE26
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 16:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E75D1F220EF
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041CD1BB6B2;
	Wed, 18 Sep 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nb04d4PT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BC1BAEE6;
	Wed, 18 Sep 2024 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670550; cv=none; b=VvI2LxV2N4lQHRPuhenu3i6EY3+k3KP25iIDkBwDRCb2qCJ5Q9CwtThFxQctbCbJ5JVjzhx8q3dhbY8RgkDFTV5yd1ZQixAGU9XCs47rXz5HBkGaJGZlU5IONwYj6MFDbymyTjDBi/PccwA0LQZ7I/UgVJF0HG2HA0dIz9zFfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670550; c=relaxed/simple;
	bh=f6DO9H9tbPadLV/AmMWoIvT7LPqXcop24V18dsnD8vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQegAAWmHErJO70EtXZW6w/98bNEswbsYXfU/6vU0ELreebW+CRDcnqeOgpa5KMOerKxFEu0veKvzdb6HtPcsN0rWUMZvhtOA+7i2h4LzlxZ+6Lp51vh2B3xjpVufBegMSbPjwUi8BU3phtC6x3/CaKDyrOBF2Qi1HFnP9t+imY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nb04d4PT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726670549; x=1758206549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f6DO9H9tbPadLV/AmMWoIvT7LPqXcop24V18dsnD8vo=;
  b=Nb04d4PT/EFuRd22htC3110pJV12b0sP4okNNA/tU8M86F2UpCsJSNtd
   V29Gnw1c2JR1AzXMTlUlQyeUm1az5JffCP07628uh/yoNr+NGshq6LthB
   9W2ZEpDhAN96IIoCDhwVj3EG7i4P7K0fFpzy37+TslKpryx6k+WPPCm6K
   lEFL4RUTT4XF6ZDhlfoRV1hRjKBlGfc9TahQ05u/QzNiW6SdFd0iE0cpg
   oOiaPot+3R6vBl8SJbiyDfxA4jWRU/qa/4FQ6pWr33pxsVHmWLIMoyQcB
   YSuCx1DIXuktVBviH6BZf6R6v9PLNj4QIrs5t83+aEl4JAbslYyBXz973
   Q==;
X-CSE-ConnectionGUID: 1Nqbf2+wTR+mvS8BVAYn/Q==
X-CSE-MsgGUID: wQTfSd89SFuKHITLs5ztOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="36255024"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="36255024"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 07:42:27 -0700
X-CSE-ConnectionGUID: 4A/Qk+DiRdul4OYr8AZigA==
X-CSE-MsgGUID: 6d1nul30RZG2Lo5fGPjqjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="100312619"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Sep 2024 07:42:22 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqvsp-000CJe-18;
	Wed, 18 Sep 2024 14:42:19 +0000
Date: Wed, 18 Sep 2024 22:41:43 +0800
From: kernel test robot <lkp@intel.com>
To: Liao Chang <liaochang1@huawei.com>, mhiramat@kernel.org,
	oleg@redhat.com, andrii@kernel.org, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] uprobes: Improve the usage of xol slots for better
 scalability
Message-ID: <202409182246.UMkGsMXl-lkp@intel.com>
References: <20240918012752.2045713-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918012752.2045713-1-liaochang1@huawei.com>

Hi Liao,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/perf/core]
[cannot apply to perf-tools-next/perf-tools-next perf-tools/perf-tools linus/master acme/perf/core v6.11 next-20240918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liao-Chang/uprobes-Improve-the-usage-of-xol-slots-for-better-scalability/20240918-093915
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/20240918012752.2045713-1-liaochang1%40huawei.com
patch subject: [PATCH] uprobes: Improve the usage of xol slots for better scalability
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240918/202409182246.UMkGsMXl-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240918/202409182246.UMkGsMXl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409182246.UMkGsMXl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/probes/uprobes/actions-arm.c:10:
>> include/linux/uprobes.h:81:2: error: unknown type name 'refcount_t'
           refcount_t                      slot_ref;
           ^
   1 error generated.


vim +/refcount_t +81 include/linux/uprobes.h

    58	
    59	/*
    60	 * uprobe_task: Metadata of a task while it singlesteps.
    61	 */
    62	struct uprobe_task {
    63		enum uprobe_task_state		state;
    64	
    65		union {
    66			struct {
    67				struct arch_uprobe_task	autask;
    68				unsigned long		vaddr;
    69			};
    70	
    71			struct {
    72				struct callback_head	dup_xol_work;
    73				unsigned long		dup_xol_addr;
    74			};
    75		};
    76	
    77		struct uprobe			*active_uprobe;
    78		unsigned long			xol_vaddr;
    79	
    80		struct list_head		gc;
  > 81		refcount_t			slot_ref;
    82		int				insn_slot;
    83	
    84		struct arch_uprobe              *auprobe;
    85	
    86		struct return_instance		*return_instances;
    87		unsigned int			depth;
    88	};
    89	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

