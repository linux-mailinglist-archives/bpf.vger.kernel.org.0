Return-Path: <bpf+bounces-37269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C90952EB4
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 15:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E0DB27553
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 13:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E7C1DFFB;
	Thu, 15 Aug 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCUgXCBB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1591714A8;
	Thu, 15 Aug 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726945; cv=none; b=QFKLH9s8zS34nd0URmdjB4UVwj6xjs+iCppjDfKxWsXmIBhxPEUysFA76TxuaJ6v7i/jZ+YcjQx1efMx9xyNquTO6jgKo5PXiy5o9mRHdS8IciJrLPg6llAE259W8ux5i+eEDcc+L+yiaFnQKxJwNmlD+ZXxfrvVZ/rX6q+6n14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726945; c=relaxed/simple;
	bh=ruw0kR6QL67m9p5ATfOebNl04pXe+HMJSF12N15As44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5d39blLBMMzc9ZfzMxpokUhkOwdenNcPXwMqs1jrO3cxTFVTIo5nEAmuMtYOGboFn5il4uIaY7aXLJy/4IuOSkeBy1K7WoOBSYyf1aButi5u7b5PdMsFYzcQQGRo2OI5Rz5izmYk1Hh/6tJAUI7TUjbBKMlpNkwx9CrWxZ1p2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCUgXCBB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723726943; x=1755262943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ruw0kR6QL67m9p5ATfOebNl04pXe+HMJSF12N15As44=;
  b=MCUgXCBBkzdwuwUlxdeyNw+s1fVFdJlZEcGxcMQFfa0QQPKtvJ0xlct2
   FLVS82gOFxgMAAyDw+2fpkePPTrftHGHPXJjJEUPDcOU4qg5whxQn1wSD
   faz7OOFAB8uhf2gKvBGmKJmGxzhfOeCpmRG3nt93ECOoxBSgqRUX2QtS2
   7uHKVBJOnMD9phADQUceRYyaHS+qQOEY3pwZdqmvyd1gnZg/NukBS98JR
   TGCp7V1rz9YDEW0EWO58PDVXoyU9OTtZNel89cokrgYOa+NfVLcw6qbYK
   XBGs5S7oNZBEUNDnkNHRfIIJ6MAagxaRz3ba4Vc8U5cr5oab59IeQYXf3
   w==;
X-CSE-ConnectionGUID: gsb13RZaQSW2/Dhr97nAKA==
X-CSE-MsgGUID: czB9Y0u4Rd2EiWfr7BiP7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33370189"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="33370189"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 06:02:22 -0700
X-CSE-ConnectionGUID: nrr5JKJqS02OWSBwyb1GOg==
X-CSE-MsgGUID: Esz7EGA9RoGTZElslC6VyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="60110901"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Aug 2024 06:02:20 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sea7N-0003bW-0I;
	Thu, 15 Aug 2024 13:02:17 +0000
Date: Thu, 15 Aug 2024 21:01:42 +0800
From: kernel test robot <lkp@intel.com>
To: Matteo Croce <technoboy85@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH bpf-next v5 2/2] bpf: allow
 bpf_current_task_under_cgroup() with BPF_CGROUP_*
Message-ID: <202408152026.xtFpPaaI-lkp@intel.com>
References: <20240813132831.184362-3-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813132831.184362-3-technoboy85@gmail.com>

Hi Matteo,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Matteo-Croce/bpf-enable-generic-kfuncs-for-BPF_CGROUP_-programs/20240815-000517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240813132831.184362-3-technoboy85%40gmail.com
patch subject: [PATCH bpf-next v5 2/2] bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*
config: arm-randconfig-003-20240815 (https://download.01.org/0day-ci/archive/20240815/202408152026.xtFpPaaI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408152026.xtFpPaaI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408152026.xtFpPaaI-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: kernel/trace/bpf_trace.o: in function `bpf_tracing_func_proto':
>> bpf_trace.c:(.text+0x41bc): undefined reference to `bpf_current_task_under_cgroup_proto'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

