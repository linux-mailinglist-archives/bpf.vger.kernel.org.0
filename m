Return-Path: <bpf+bounces-55865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8CDA88828
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5E317D777
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E41D284660;
	Mon, 14 Apr 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVMZrJCr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2B27990D;
	Mon, 14 Apr 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646975; cv=none; b=HE7XJNZhvjqMPAQdP8FA435kfUvpjEwKCNVqZ6PxSwFK4abjyqNlh+NglsQ/4nKRUJBRaUAi1QHm/PinaOL/BaMKvspUBVeF2+Q2+Bj1mmgzRoIEFSp94JUQ1yn6/e6DzQkS8jm4a75FD9+jxmGnb+4m+MeEofloHCFRvO1WV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646975; c=relaxed/simple;
	bh=o098pNY1KIdzMyd0dCjsn6jbyXgc1lerA3ii2JKfdFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O10DVgDxXl/WgqKRiS0lfyzII7G7CUsf8EL54tWCADxz4rGWWdbXWO4JkK9DFAMNrtOYaWFAaufcs/kczhacat1MLQLLSiMDSXkAZGGyAQxbzu6AyWJiq6LjuCphqFQAVrwF6zJHvej5FxNV3QpdNB+GbcmMADdgSp5bfS1d5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVMZrJCr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744646974; x=1776182974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o098pNY1KIdzMyd0dCjsn6jbyXgc1lerA3ii2JKfdFw=;
  b=NVMZrJCr47sW/2QD/HualWcnhfbUl/T45lblRYJGI8fhoJiXEwQgO6ba
   md2tAQFrl2zY0rl7B1eAFpkbhKLGQiQDwx1q9kXG3eXBMABoXpFHlGhXd
   9J5JsWKD7hLyMGuVFSDhgix66EVe1pjenIFnlU9b2SjKVS10dA1j9WFFh
   ZV+MDkQW1dozWEV5WT1LuIPz/S5DEBzC1hiWGCKq07vffGZEwWT2QNSXq
   qPg04jh+3i9flFoThedDWovXCZmz63AmGENRzWXcfCjWY8bqkc1LMP1Bl
   HcCsYyiQNrJduYVuffbXLDukr5FVJkMGX66Bi9Pd9rVU+VN1FNL/57wxU
   g==;
X-CSE-ConnectionGUID: LUGI8wkKR7yRrXdoAa7r4A==
X-CSE-MsgGUID: UTknH2NcSR6ySoKDWx3cNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="49782700"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="49782700"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:09:33 -0700
X-CSE-ConnectionGUID: CnMxJUlmSIiTzbm9YFg+pA==
X-CSE-MsgGUID: 9cu2Bq3oQ4CxIuDdss/0dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130836760"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 Apr 2025 09:09:26 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4MN9-000ER0-2g;
	Mon, 14 Apr 2025 16:09:23 +0000
Date: Tue, 15 Apr 2025 00:08:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf, sockmap: Introduce tracing capability
 for sockmap
Message-ID: <202504142349.tfXMGMOg-lkp@intel.com>
References: <20250411091634.336371-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411091634.336371-1-jiayuan.chen@linux.dev>

Hi Jiayuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiayuan-Chen/bpf-sockmap-Introduce-tracing-capability-for-sockmap/20250414-093146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250411091634.336371-1-jiayuan.chen%40linux.dev
patch subject: [PATCH bpf-next v2] bpf, sockmap: Introduce tracing capability for sockmap
config: csky-randconfig-001-20250414 (https://download.01.org/0day-ci/archive/20250414/202504142349.tfXMGMOg-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250414/202504142349.tfXMGMOg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504142349.tfXMGMOg-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: kernel/bpf/core.o: in function `trace_event_raw_event_sockmap_redirect':
>> core.c:(.text+0x15e0): undefined reference to `sock_i_ino'
   csky-linux-ld: kernel/bpf/core.o: in function `trace_event_raw_event_sockmap_strparser':
   core.c:(.text+0x1684): undefined reference to `sock_i_ino'
>> csky-linux-ld: core.c:(.text+0x1688): undefined reference to `init_net'
>> csky-linux-ld: core.c:(.text+0x16a8): undefined reference to `sock_i_ino'
   csky-linux-ld: kernel/bpf/core.o: in function `___bpf_prog_run':
   core.c:(.text+0x1838): undefined reference to `sock_i_ino'
   csky-linux-ld: core.c:(.text+0x183c): undefined reference to `init_net'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

