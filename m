Return-Path: <bpf+bounces-30823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688578D2D49
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 08:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B97A1C21164
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 06:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB918167D81;
	Wed, 29 May 2024 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHjqvt5u"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3715FD1A;
	Wed, 29 May 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964209; cv=none; b=WI/+ssmD2hQ1p+U9NVRIN13ko0/oK6/gm8NKwzVk972XhBujcPqjv6NA6WyibWDRnZ0drGj1+eWSw22HFzSZ6Tq2g+/MZXtCcZLZZmPNXrJZG+BW/Lz+TEcdYPhfFSVa1DSL7oPCohFzxjCHyD/NIMhuJmB4khk2IW4Qc/K8wjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964209; c=relaxed/simple;
	bh=SodOntcXSaYLJA+i4z/XuLZgNlHKB3BxduaH+5A5CpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksu4tG3jr31CZ9i18hVkG9FMpVlQkdMjEYOKJBDIqCz5DoXmrwQv7dH5ecZnyB0Bc231VYzUvCk+wVkQQi1m3c7K5b0G4dY+FXWsdc2MIH08oYhbHNwnoKHsMju6Bz0JN996jahI3XdoZ/PunKQaD7WMexOiGn49XYUpFQLYA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHjqvt5u; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716964207; x=1748500207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SodOntcXSaYLJA+i4z/XuLZgNlHKB3BxduaH+5A5CpI=;
  b=fHjqvt5up1fmwvCzz78n0/Td/YrTfgr9s1dppV8j6Z3GM8SP2/xPcgMj
   9bmBePriJ+Fc/0EwbyR6BjZdsl1BCHuNiBdK+KUa6RuQIGdv2BVWyfM+M
   q0pAkKuXitKX3AajqCcln/MYavJiyNtPiAVPMkpPB0twGQMfqWLkdlTZ3
   ehybjXHQ8KegS9gDuL+BI9UxdqkBDUgHIwMGKaZZw5jlz7c7g0whdpG8d
   5d68x4PruLXxzD0sga4/oO3kZjiVQZSB7zMXhddnQRpxaL3Z/0eqLL1v4
   65xYMh8/gTz1npu3W7kMIPS0GcFqBuujgVPx2TEVsFH+ndQbOhN0V1CXX
   g==;
X-CSE-ConnectionGUID: 9Zys+1dkRSaAQTpB5b/mBg==
X-CSE-MsgGUID: RUjt9WyKR8u7FLWQamlB0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17139905"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="17139905"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 23:30:07 -0700
X-CSE-ConnectionGUID: pH2IyfZ1TvW50xTq2fSNVA==
X-CSE-MsgGUID: o1PXy3HrRRK1SQe+AN/i9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35406851"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 28 May 2024 23:30:03 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCCor-000DCx-0M;
	Wed, 29 May 2024 06:29:55 +0000
Date: Wed, 29 May 2024 14:29:48 +0800
From: kernel test robot <lkp@intel.com>
To: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
	Aleksei Shchekotikhin <alekseis@google.com>,
	Nilay Vaish <nilayvaish@google.com>
Subject: Re: [PATCH] bpf: Allocate bpf_event_entry with node info
Message-ID: <202405291415.6JlTkRMF-lkp@intel.com>
References: <20240528223643.1166776-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528223643.1166776-1-namhyung@kernel.org>

Hi Namhyung,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master linus/master v6.10-rc1 next-20240528]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Namhyung-Kim/bpf-Allocate-bpf_event_entry-with-node-info/20240529-063828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240528223643.1166776-1-namhyung%40kernel.org
patch subject: [PATCH] bpf: Allocate bpf_event_entry with node info
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20240529/202405291415.6JlTkRMF-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405291415.6JlTkRMF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405291415.6JlTkRMF-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/bpf/arraymap.c: In function 'bpf_event_entry_gen':
>> kernel/bpf/arraymap.c:1200:18: error: 'struct perf_event' has no member named 'cpu'
    1200 |         if (event->cpu >= 0)
         |                  ^~
   In file included from ./arch/m68k/include/generated/asm/topology.h:1,
                    from include/linux/topology.h:36,
                    from include/linux/gfp.h:8,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from include/linux/bpf.h:20,
                    from kernel/bpf/arraymap.c:5:
   kernel/bpf/arraymap.c:1201:36: error: 'cpu' undeclared (first use in this function)
    1201 |                 node = cpu_to_node(cpu);
         |                                    ^~~
   include/asm-generic/topology.h:35:41: note: in definition of macro 'cpu_to_node'
      35 | #define cpu_to_node(cpu)        ((void)(cpu),0)
         |                                         ^~~
   kernel/bpf/arraymap.c:1201:36: note: each undeclared identifier is reported only once for each function it appears in
    1201 |                 node = cpu_to_node(cpu);
         |                                    ^~~
   include/asm-generic/topology.h:35:41: note: in definition of macro 'cpu_to_node'
      35 | #define cpu_to_node(cpu)        ((void)(cpu),0)
         |                                         ^~~
>> include/asm-generic/topology.h:35:45: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      35 | #define cpu_to_node(cpu)        ((void)(cpu),0)
         |                                             ^
   kernel/bpf/arraymap.c:1201:24: note: in expansion of macro 'cpu_to_node'
    1201 |                 node = cpu_to_node(cpu);
         |                        ^~~~~~~~~~~


vim +1200 kernel/bpf/arraymap.c

  1192	
  1193	static struct bpf_event_entry *bpf_event_entry_gen(struct file *perf_file,
  1194							   struct file *map_file)
  1195	{
  1196		struct bpf_event_entry *ee;
  1197		struct perf_event *event = perf_file->private_data;
  1198		int node = -1;
  1199	
> 1200		if (event->cpu >= 0)
  1201			node = cpu_to_node(cpu);
  1202	
  1203		ee = kzalloc_node(sizeof(*ee), GFP_KERNEL, node);
  1204		if (ee) {
  1205			ee->event = event;
  1206			ee->perf_file = perf_file;
  1207			ee->map_file = map_file;
  1208		}
  1209	
  1210		return ee;
  1211	}
  1212	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

