Return-Path: <bpf+bounces-67693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171A6B483D2
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 08:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F8C17A506
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 06:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A91C54AF;
	Mon,  8 Sep 2025 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAJ80v+/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90FC258A
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757311325; cv=none; b=XFQbX/QPsthLnXuDzQKL265M99ItfHG3PC14w1Ev7rLoibUyVdR4fAuD68aMotcdPqwTV98A8tPaPjp+i4Km5tx3XEYPpjX8Xr5W28hPrioqLvpUJlnO3E4qXmWrndBJue3gzi6LO4Jg6D9I808XTjzeGbOLgVctAYPyh9l10as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757311325; c=relaxed/simple;
	bh=sH0WZEnxdnBAewzDMUttPsrct8hCNH/1iOAEVJV9/m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMRLfRAaLjHHgWqeo3bFajnlQ0PPKSJNyeF46co+fLoeqHVpzLXO1IUY+E5TwTcja0njs1xS1Q93GcgnVdyCpFYuKnq0hqfGTcMdZ+a17WBzR+SuVhYpDdCD2h3L7BZtzIu3MybYuWKZ4BSoPZpQGpnOHIU59Dtyb/vpHScwvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAJ80v+/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757311323; x=1788847323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sH0WZEnxdnBAewzDMUttPsrct8hCNH/1iOAEVJV9/m0=;
  b=mAJ80v+/vHwt5s1I2eEQ7REeayBLIRccQE59iZlNlHQ+A0bJR6xzxuJP
   RHifZBcvldXmb9pAw0GEQVCIyciAr7lAAAB8sDwqSCp5xuNS38lwHpAyL
   /UpTdl7dA36Vrih5+w2Gad9lCmAesOhFGiwUDYJvlGKWxp4lcu+6ttTR7
   WM5ru/fFMlPygWog6KlbjMcOgZAIj8cSuon0sNE2JFIwDhmu1j2PQu+JE
   gs7UHAzpxosyW0EX9spB1Hm6b2y/LU0P6RspldvpZmyoGyLgEYQyOpPYJ
   2/6iA3MSnrmLMzpiObGBzD0jaWkP2MN7StmPMjY/ihMyGczvQzmkccHcO
   w==;
X-CSE-ConnectionGUID: TQh2lR18TSGNBmj7m5bg7w==
X-CSE-MsgGUID: XQMAdXHPQLS5GyjTzfNLPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="85001536"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="85001536"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 23:02:01 -0700
X-CSE-ConnectionGUID: Xds/YYeyQji+Rluyc+GJPw==
X-CSE-MsgGUID: 4FbbuXRhRLuGqGguDcrMAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="173067090"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Sep 2025 23:01:55 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvUwq-0003YF-1i;
	Mon, 08 Sep 2025 06:01:52 +0000
Date: Mon, 8 Sep 2025 14:01:36 +0800
From: kernel test robot <lkp@intel.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, miloc@vt.edu,
	ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu,
	jinghao7@illinois.edu, sidchintamaneni@gmail.com, memxor@gmail.com,
	egor@vt.edu, sairoop10@gmail.com, rjsu26@gmail.com
Subject: Re: [PATCH 3/4] bpf: runtime part of fast-path termination approach
Message-ID: <202509081350.yqptixjh-lkp@intel.com>
References: <20250907230415.289327-4-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907230415.289327-4-sidchintamaneni@gmail.com>

Hi Siddharth,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master linus/master v6.17-rc5 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Chintamaneni/bpf-Introduce-new-structs-and-struct-fields-for-fast-path-termination/20250908-070655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250907230415.289327-4-sidchintamaneni%40gmail.com
patch subject: [PATCH 3/4] bpf: runtime part of fast-path termination approach
config: s390-randconfig-001-20250908 (https://download.01.org/0day-ci/archive/20250908/202509081350.yqptixjh-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7fb1dc08d2f025aad5777bb779dfac1197e9ef87)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250908/202509081350.yqptixjh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509081350.yqptixjh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/core.c:109:13: warning: no previous prototype for function 'in_place_patch_bpf_prog' [-Wmissing-prototypes]
     109 | void __weak in_place_patch_bpf_prog(struct bpf_prog *prog)
         |             ^
   kernel/bpf/core.c:109:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     109 | void __weak in_place_patch_bpf_prog(struct bpf_prog *prog)
         | ^
         | static 
>> kernel/bpf/core.c:114:13: warning: no previous prototype for function 'bpf_die' [-Wmissing-prototypes]
     114 | void __weak bpf_die(struct bpf_prog *prog)
         |             ^
   kernel/bpf/core.c:114:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     114 | void __weak bpf_die(struct bpf_prog *prog)
         | ^
         | static 
>> kernel/bpf/core.c:119:13: warning: no previous prototype for function 'bpf_prog_termination_deferred' [-Wmissing-prototypes]
     119 | void __weak bpf_prog_termination_deferred(struct work_struct *work)
         |             ^
   kernel/bpf/core.c:119:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     119 | void __weak bpf_prog_termination_deferred(struct work_struct *work)
         | ^
         | static 
>> kernel/bpf/core.c:124:13: warning: no previous prototype for function 'bpf_softlockup' [-Wmissing-prototypes]
     124 | void __weak bpf_softlockup(u32 dur_s)
         |             ^
   kernel/bpf/core.c:124:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     124 | void __weak bpf_softlockup(u32 dur_s)
         | ^
         | static 
   4 warnings generated.


vim +/in_place_patch_bpf_prog +109 kernel/bpf/core.c

   107	
   108	
 > 109	void __weak in_place_patch_bpf_prog(struct bpf_prog *prog)
   110	{
   111		return;
   112	}
   113	
 > 114	void __weak bpf_die(struct bpf_prog *prog)
   115	{
   116		return;
   117	}
   118	
 > 119	void __weak bpf_prog_termination_deferred(struct work_struct *work)
   120	{
   121		return;
   122	}
   123	
 > 124	void __weak bpf_softlockup(u32 dur_s)
   125	{
   126		return;
   127	}
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

