Return-Path: <bpf+bounces-40150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD997DB2E
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 03:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5CB0B209A4
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 01:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5425227;
	Sat, 21 Sep 2024 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bE3Q2YIT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDD823D7;
	Sat, 21 Sep 2024 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726881747; cv=none; b=UMjGSteeQfL5hprfSuiiQ7LKt2QV/UNV9+hVO+eHeL2Xkd5jUJ1O8RFzcILElcjhZYxjOEx0YaIOJrH4xmZOPBNQoT8HnMuFbIwobVEUnxTCdo+ujAN3V+Fxz8BHdeBhKEat6v1lOnZl+U6vxK5TLZzxJNt+Pl6CWo1Q6Ykdfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726881747; c=relaxed/simple;
	bh=KtakCcC2qdSEMD5iIVCn5JcCYsCNY/eSfJ41UJSWcUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnK3voyqzxMzLzwVB7rJDbRH7pzFbJf11DWGIUpBJimX3uWUVGRxLmUtRYbU0IlYzj4wa9XYey7mJO0JgSiBffxzPzE+sGsfBI7HfYaCLYChzbF3+6HMlfyk6TAS18/DGVVD+wFxDjN572m18APXl8C9rBVNH34v6WJNEu6pl6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bE3Q2YIT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726881746; x=1758417746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KtakCcC2qdSEMD5iIVCn5JcCYsCNY/eSfJ41UJSWcUM=;
  b=bE3Q2YITTUzJWvccKt+U7sWRfN9fGZnSdcynqmXqzS4gjBgoh5NGe7wS
   Gl/wG0sP/beTzOCwLZSaJkuBfws75nwmhj3bA9GfulpM9+BwRhziO9UTs
   g76Yt2JDWmDBDT1QDPT0TatSQjbqYZRKbYnqI+7APtmLHcA6dTdsG8bUS
   oxGnYkwDLozbihdxtfcM1WtVIugcyZ/3wUGNGLgzz03OlV/pPoRdO0b2+
   yNhutIfdht0BnsQa1eu0yE8DHgwmHXHUaRvjPln2u5K5oc/K2fCtX98pc
   5G0pyAh6X/WAoflUQI4kMIZl8/NqxJNzUvvekBtttDhG2Y76kE9pPh0XB
   g==;
X-CSE-ConnectionGUID: aCjp79nLQ7OoEXheowol3g==
X-CSE-MsgGUID: iX7aoUMYR7K+XYJ9Mn0jcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="37276764"
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="37276764"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 18:22:25 -0700
X-CSE-ConnectionGUID: m0vQv04lRSeYrzZoNsQZtQ==
X-CSE-MsgGUID: FdnzwO0zSYK0lqdXGTlIqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="93810647"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Sep 2024 18:22:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sropG-000F1C-2D;
	Sat, 21 Sep 2024 01:22:18 +0000
Date: Sat, 21 Sep 2024 09:21:36 +0800
From: kernel test robot <lkp@intel.com>
To: Tao Chen <chen.dylane@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Add BPF_CALL_FUNC* to simplify code
Message-ID: <202409210926.ErxhBmi5-lkp@intel.com>
References: <20240920153706.919154-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920153706.919154-1-chen.dylane@gmail.com>

Hi Tao,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Chen/bpf-Add-BPF_CALL_FUNC-to-simplify-code/20240920-233936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240920153706.919154-1-chen.dylane%40gmail.com
patch subject: [PATCH bpf-next 2/2] bpf: Add BPF_CALL_FUNC* to simplify code
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240921/202409210926.ErxhBmi5-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240921/202409210926.ErxhBmi5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409210926.ErxhBmi5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/core.c:21:
   kernel/bpf/core.c: In function '___bpf_prog_run':
>> include/linux/filter.h:464:38: error: called object is not a function or function pointer
     464 | #define BPF_CALL_FUNC(x)        ((x) + (u8 *)__bpf_call_base)
         |                                 ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:2010:26: note: in expansion of macro 'BPF_CALL_FUNC'
    2010 |                 BPF_R0 = BPF_CALL_FUNC(insn->imm)(BPF_R1, BPF_R2, BPF_R3,
         |                          ^~~~~~~~~~~~~
   include/linux/filter.h:466:38: error: called object is not a function or function pointer
     466 | #define BPF_CALL_FUNC_ARGS(x)   ((x) + (u8 *)__bpf_call_base_args)
         |                                 ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:2015:26: note: in expansion of macro 'BPF_CALL_FUNC_ARGS'
    2015 |                 BPF_R0 = BPF_CALL_FUNC_ARGS(insn->imm)(BPF_R1, BPF_R2,
         |                          ^~~~~~~~~~~~~~~~~~


vim +464 include/linux/filter.h

   463	
 > 464	#define BPF_CALL_FUNC(x)	((x) + (u8 *)__bpf_call_base)
   465	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

