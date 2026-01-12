Return-Path: <bpf+bounces-78614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 622C2D14E62
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 20:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB86530388A7
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 19:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7DC31B812;
	Mon, 12 Jan 2026 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMc2VYzS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6C311C17;
	Mon, 12 Jan 2026 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245767; cv=none; b=PoZtR1j3bdfJw55KXkT8mnGWCf2DPt25KFUPuyu8zzNZcOQCVZZ9ld3MSMLg8P+PFptaIWcFgUxVE7pGA41yFG57Aqz4kpEPLtgrbZmJCb4E3jhJF1wRweBoK7MF1dQ5I7NwUJVQq3VmJvNg0vZaUBwWhWt/RVWhdOSPj6FaVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245767; c=relaxed/simple;
	bh=gy3vUzeNs/9BwKXtMR4uniH68yQHA+hJ41Jnz6faEIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUdIc3Z3B+utFvoVnYVOK5U3Tk/OrY/7heVycXv0xHbUCTGZc5UFlzaL5lFU7il+RdaC0RHT71sSSvMc2Db6JBXuT96U1I3tuISr3DU63l2SO38LBMFh8wuWBhko1IzAzfBIOSHNy/y2ROnmg4DFqi9SyN2sEX1g2beuvegXTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMc2VYzS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768245766; x=1799781766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gy3vUzeNs/9BwKXtMR4uniH68yQHA+hJ41Jnz6faEIM=;
  b=ZMc2VYzSquSajN6kv1927+5UfrI12PNR7To/VfrurD/W1STSoH36TWr3
   v13giALa9e9vzUTR0N6c6xeZaF7feKH8bOMzXl/s1ofyEHp12m3B1xc0i
   pGyINlwiaShF70RMA7siAbQPX77c2rveBmBxjJVcTHGOXdSMQwRejaGnF
   01fLtCNFJKczPjtSSFTYpASmByWkkEhD0pCtzMxfK8Gi8J7AFLYPB0KHp
   Zp69V9E7UtHEoK5950/GJjqTPveGdxwqM5hN6DlaG1CG1cELFPJvuCC+M
   yXKBELwTK7yTfR40/btjmIeD0+7aU8OeV+u4ZDOnth+OSGOu7ePblQclV
   g==;
X-CSE-ConnectionGUID: iuBLUA5TQN2VbdU4j5CfyA==
X-CSE-MsgGUID: XOG1mdt3SziU7q191vypPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69259621"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="69259621"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:22:45 -0800
X-CSE-ConnectionGUID: CjsHXDcET8G3zdx532W5jQ==
X-CSE-MsgGUID: Et1a2lnCR3m3hPhoCRr6cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="235411831"
Received: from igk-lkp-server01.igk.intel.com (HELO 8581b2e2a62c) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 12 Jan 2026 11:22:39 -0800
Received: from kbuild by 8581b2e2a62c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfNUq-000000000yP-3Vw4;
	Mon, 12 Jan 2026 19:22:36 +0000
Date: Mon, 12 Jan 2026 20:22:22 +0100
From: kernel test robot <lkp@intel.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Leon Hwang <leon.hwang@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf: Introduce BPF_BRANCH_SNAPSHOT_F_COPY
 flag for bpf_get_branch_snapshot helper
Message-ID: <202601122013.hmoeIXXs-lkp@intel.com>
References: <20260109153420.32181-3-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109153420.32181-3-leon.hwang@linux.dev>

Hi Leon,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-x64-Call-perf_snapshot_branch_stack-in-trampoline/20260109-234435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260109153420.32181-3-leon.hwang%40linux.dev
patch subject: [PATCH bpf-next 2/3] bpf: Introduce BPF_BRANCH_SNAPSHOT_F_COPY flag for bpf_get_branch_snapshot helper
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260112/202601122013.hmoeIXXs-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601122013.hmoeIXXs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601122013.hmoeIXXs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: bpf_branch_snapshot
   >>> referenced by bpf_trace.c:1182 (kernel/trace/bpf_trace.c:1182)
   >>>               vmlinux.o:(bpf_get_branch_snapshot)
   >>> referenced by bpf_trace.c:0 (kernel/trace/bpf_trace.c:0)
   >>>               vmlinux.o:(bpf_get_branch_snapshot)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

