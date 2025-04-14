Return-Path: <bpf+bounces-55856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01027A87FD1
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 13:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0483165841
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 11:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9785229AB18;
	Mon, 14 Apr 2025 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hq/DHZAO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721371684AE;
	Mon, 14 Apr 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631701; cv=none; b=VX8+8OS37RbKVWuxqP7F0lNaFilfgwf6+TnXecBhKr/nuvYVM4jHq+UIN6uFtdO493fmSD2Y0VgKW0vIRISUYs/0gNjQficpkPKTiOMgmvDJZ3PFsuSHx9Hc6vhhaQ1KDjRr4tisIgPWTFeLjjqcCSLc753ICmagYKMl1hYK+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631701; c=relaxed/simple;
	bh=jUon0xsIAf39XK7R0f7zGH5y3a+2qTlsy3SgS8J3sp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZXmFlOEOM6wneAXG9/13MywpRA+LO+Zf6rPv4IWd9lmJzzBDBCe6WzTwCKsvu+SjpIdqkYVDeBq2e4dWGzWpbbHrIRyJOpP47TfUFyF5yVSD+v6EYoJpZAb41hmGBWIVDZGbl3NoYK6l1f8UX6j7c1cBnPqleqflHo4uSXIswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hq/DHZAO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744631700; x=1776167700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jUon0xsIAf39XK7R0f7zGH5y3a+2qTlsy3SgS8J3sp0=;
  b=hq/DHZAODAX8egwulkvStoNLZqUFcBp3s6cX1fqYCtP2yz5qogPGSQEH
   5OEbvtPJCK6WcBgtSHeuMpo47zSDtVQDxOrPsNmr4xMVQpFlrd2aClThk
   oXTde+QkAIJuzuoznEQtA47gePHP885cEiaDA9+zTYlGpxD4iyTC0Xair
   n6DdvFKveYvActpdlhHFjt2uS3uSX46yY9TFTdxndbtXzzNFWMvjpDdxL
   AF87wCD1Gegzx21Z5FBDZOj2PBuR+wbksj4IqDWavvKNlu/tAiYlV+ZpL
   +zzMCtN+/xN2HaPuzmU9zrvszHBw8o44g5ccoER3FhTLxg4h6PqpYBiEg
   Q==;
X-CSE-ConnectionGUID: KoGoaPLQRROdH40bQYzvdw==
X-CSE-MsgGUID: MrJnkncBTQ6WxpdRR3E20w==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46186516"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="46186516"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 04:54:59 -0700
X-CSE-ConnectionGUID: eJd6RnMmTU2XFtQmnOQqBQ==
X-CSE-MsgGUID: u8qeO+m7SXGY03+CMkeYWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="134638722"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Apr 2025 04:54:52 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4IOn-000E98-2k;
	Mon, 14 Apr 2025 11:54:49 +0000
Date: Mon, 14 Apr 2025 19:54:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, mrpre@163.com,
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
Message-ID: <202504141925.PFNOfZzb-lkp@intel.com>
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
config: arm64-randconfig-001-20250414 (https://download.01.org/0day-ci/archive/20250414/202504141925.PFNOfZzb-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250414/202504141925.PFNOfZzb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504141925.PFNOfZzb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: sock_i_ino
   >>> referenced by sockmap.h:70 (include/trace/events/sockmap.h:70)
   >>>               kernel/bpf/core.o:(trace_event_raw_event_sockmap_redirect) in archive vmlinux.a
   >>> referenced by sockmap.h:121 (include/trace/events/sockmap.h:121)
   >>>               kernel/bpf/core.o:(trace_event_raw_event_sockmap_strparser) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

