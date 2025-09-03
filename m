Return-Path: <bpf+bounces-67250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D23BB41303
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 05:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3990C7AD2BE
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 03:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807932D0275;
	Wed,  3 Sep 2025 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPt9Xjh3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F152222A7;
	Wed,  3 Sep 2025 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756870456; cv=none; b=SXKfBi6zXydaL3s7oLMhEEIecU/2rSFVkswa1epiqgoyVSl/L2utNrdm0mWMXs9Z/QJSkQfss7cbE9sqq+jp+L/EvPljowA3Uk4QjKXdmGqOT+yS3O0ReKy/JKYHpEwn7oh/rHkQvOoNnTjtVB0mtzvEjN/u7zpfDY7Fhxbs51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756870456; c=relaxed/simple;
	bh=GT+w7R53TN4U82IK7+ynC/kbDyjPCW364v+r7Rfy3v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NASdLxPrXtKcv4uFRu6agJTa2ZaUJIIrp/lbvGov5xk6pnQNg0soK9f4RMUcTO9B2Z4p2ZWOrubokIDIPb2p2wbZMYApMc0sMyueGaX2x/+o0ZkVNold+xwDn39xiyqOzjwZ5oY+++fvTpXSFREfW294/Q7VFVGoca7zPzxQJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPt9Xjh3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756870454; x=1788406454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GT+w7R53TN4U82IK7+ynC/kbDyjPCW364v+r7Rfy3v4=;
  b=QPt9Xjh3PszdCO7IC43tfdEaFFXgXPC8XHw/MPWmzsWlswn2LMwwEaoy
   kdTSWOg6ga0NLvuQXlt0Pav3fLcIrvrDnm4N/0KQiF8kvPBB5N9EKj05s
   vREu2AokB1lc+Gd0fFXS042Lv2L58Va1ASuf5qkcazSAYHWF3WGwhgNBI
   xIvSKYIZ3mkJSgBgwvpg9r1+RPPztjWG41/1ORmJKnIYLzu36o+xIFnUH
   IJ9l1spJCjtCspeMxkAPCSFXZ6bPW/wUMH1cLGX5O9/nXGH98Fp1VcVy8
   COzH8jbzofqrWAB5hlBGrmqvRqGVamXsxv9B6yjPIPSnktH9V/49va1ED
   A==;
X-CSE-ConnectionGUID: ZOjCVR7NSPOKIFXAHhrfdw==
X-CSE-MsgGUID: ATU4pd0ESOmhbjkZ8TIUWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="62991728"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="62991728"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:34:14 -0700
X-CSE-ConnectionGUID: rSEFnjZCQ/WoXAeL+LEOgg==
X-CSE-MsgGUID: f4EMu7MwShavow9v4fRk7A==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 02 Sep 2025 20:34:10 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uteFV-0003Jd-3C;
	Wed, 03 Sep 2025 03:33:41 +0000
Date: Wed, 3 Sep 2025 11:32:22 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 03/11] perf: Add support to attach standard
 unique uprobe
Message-ID: <202509031116.yIcyjvUx-lkp@intel.com>
References: <20250902143504.1224726-4-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902143504.1224726-4-jolsa@kernel.org>

Hi Jiri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on next-20250902]
[cannot apply to bpf-next/net bpf-next/master bpf/master perf-tools-next/perf-tools-next perf-tools/perf-tools trace/for-next linus/master acme/perf/core v6.17-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/uprobes-Add-unique-flag-to-uprobe-consumer/20250902-224356
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/20250902143504.1224726-4-jolsa%40kernel.org
patch subject: [PATCH perf/core 03/11] perf: Add support to attach standard unique uprobe
config: x86_64-randconfig-001-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031116.yIcyjvUx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031116.yIcyjvUx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509031116.yIcyjvUx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:95,
                    from kernel/events/core.c:34:
>> include/linux/perf_event.h:2073:32: warning: 'format_attr_unique' defined but not used [-Wunused-variable]
    2073 | static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
         |                                ^~~~~~~~~~~~
   kernel/events/core.c:11055:1: note: in expansion of macro 'PMU_FORMAT_ATTR'
   11055 | PMU_FORMAT_ATTR(unique, "config:1");
         | ^~~~~~~~~~~~~~~


vim +/format_attr_unique +2073 include/linux/perf_event.h

b6c00fb9949fbd0 Kan Liang 2023-01-04  2069  
b6c00fb9949fbd0 Kan Liang 2023-01-04  2070  #define PMU_FORMAT_ATTR(_name, _format)					\
b6c00fb9949fbd0 Kan Liang 2023-01-04  2071  	PMU_FORMAT_ATTR_SHOW(_name, _format)				\
641cc938815dfd0 Jiri Olsa 2012-03-15  2072  									\
641cc938815dfd0 Jiri Olsa 2012-03-15 @2073  static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
641cc938815dfd0 Jiri Olsa 2012-03-15  2074  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

