Return-Path: <bpf+bounces-77269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AECCD3F28
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 12:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E22D5300526B
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF45428C854;
	Sun, 21 Dec 2025 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrdv534r"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9AE21FF4C;
	Sun, 21 Dec 2025 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766315415; cv=none; b=jBnqcPKB3eELxnGrzZ0oUxVFFouJvsl6W91QHlf94M9BVbIETdzE6UxBVLwGZ30a9YDWmg/e+hg1wBDwu8HM6iZQWLxkqSOxK0FTumkonYlVs+1T+3ZDVz2hoWYiiT45+syEP28OYHQdC1+MERGKnJ6LdMFygsPEO9qSVqgp9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766315415; c=relaxed/simple;
	bh=+NPJn+Uf5wC2z6UBaOnYqECBNjAFZPmQkyUZemGCPe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6iUuijhDMfCSTNPPTCy9iGr/UUw/EbaePW79GJqlxUdGVUFvoji9pSxD6VKCAgPDUanO1FppuuTNCaqRUjfGJxCT+S+RVjOeWsx4E6q+SSQcKvEYYszhTzrx4QnvdRFJFuF3jXFD7hb85YGXdcQEjTPjqBvV9nYsLufn3P0uTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrdv534r; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766315414; x=1797851414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+NPJn+Uf5wC2z6UBaOnYqECBNjAFZPmQkyUZemGCPe0=;
  b=mrdv534rlmiKcwgCjZ7OJJiY6bF+Pr2bmegtRZlChWyoa8SzroIy+Ajs
   dShugVOhgWB1AuhDYuGBGE8HbMlbm/3Ql6N8yePJ6FGHk3dmk084bHLxy
   gbupgoAidm3DqanYx64Cqxp6xcqA8RPn3JWjrQJa3zWvwO6hgH3c7AiUT
   UV+w3cVc79OjfwHQqXbD44spkgpXUMSxrhR0CfHbg5fpFttqrcGkaLPGD
   5c067Lx9q7z0xiyHyY37qxdNZbCANKByNy/HRTQzjI4MBwoCTAa8LqdFb
   X08HUzB7TF6axnGU5+OofaDLDwvA/0Qe/bjoCJVXQ6yLggeMw/hRYsJNh
   Q==;
X-CSE-ConnectionGUID: NX/U0mXWRNG5U13fS6d92Q==
X-CSE-MsgGUID: qSAh3P6+QoWeD3BQ+0L8qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="70775855"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="70775855"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 03:10:13 -0800
X-CSE-ConnectionGUID: ybjirWJBTPmBN9WhcoaNmQ==
X-CSE-MsgGUID: ucpH1pf2T8KJGgjLFu6D+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="198916761"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 21 Dec 2025 03:10:09 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXHKB-000000005aj-1NhU;
	Sun, 21 Dec 2025 11:10:07 +0000
Date: Sun, 21 Dec 2025 19:09:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 9/9] bpf,x86: Use single ftrace_ops for direct
 calls
Message-ID: <202512211826.gtdm52TX-lkp@intel.com>
References: <20251215211402.353056-10-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215211402.353056-10-jolsa@kernel.org>

Hi Jiri,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/ftrace-bpf-Remove-FTRACE_OPS_FL_JMP-ftrace_ops-flag/20251216-052916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251215211402.353056-10-jolsa%40kernel.org
patch subject: [PATCHv5 bpf-next 9/9] bpf,x86: Use single ftrace_ops for direct calls
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20251221/202512211826.gtdm52TX-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512211826.gtdm52TX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512211826.gtdm52TX-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/trampoline.c: In function 'unregister_fentry':
>> kernel/bpf/trampoline.c:367:23: error: implicit declaration of function 'direct_ops_del'; did you mean 'direct_ops_free'? [-Wimplicit-function-declaration]
     367 |                 ret = direct_ops_del(tr, old_addr);
         |                       ^~~~~~~~~~~~~~
         |                       direct_ops_free
   kernel/bpf/trampoline.c: In function 'modify_fentry':
>> kernel/bpf/trampoline.c:381:23: error: implicit declaration of function 'direct_ops_mod'; did you mean 'direct_ops_free'? [-Wimplicit-function-declaration]
     381 |                 ret = direct_ops_mod(tr, new_addr, lock_direct_mutex);
         |                       ^~~~~~~~~~~~~~
         |                       direct_ops_free
   kernel/bpf/trampoline.c: In function 'register_fentry':
>> kernel/bpf/trampoline.c:404:23: error: implicit declaration of function 'direct_ops_add'; did you mean 'direct_ops_free'? [-Wimplicit-function-declaration]
     404 |                 ret = direct_ops_add(tr, new_addr);
         |                       ^~~~~~~~~~~~~~
         |                       direct_ops_free


vim +367 kernel/bpf/trampoline.c

   360	
   361	static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
   362				     void *old_addr)
   363	{
   364		int ret;
   365	
   366		if (tr->func.ftrace_managed)
 > 367			ret = direct_ops_del(tr, old_addr);
   368		else
   369			ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, NULL);
   370	
   371		return ret;
   372	}
   373	
   374	static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
   375				 void *old_addr, void *new_addr,
   376				 bool lock_direct_mutex)
   377	{
   378		int ret;
   379	
   380		if (tr->func.ftrace_managed) {
 > 381			ret = direct_ops_mod(tr, new_addr, lock_direct_mutex);
   382		} else {
   383			ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
   384							   new_addr);
   385		}
   386		return ret;
   387	}
   388	
   389	/* first time registering */
   390	static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
   391	{
   392		void *ip = tr->func.addr;
   393		unsigned long faddr;
   394		int ret;
   395	
   396		faddr = ftrace_location((unsigned long)ip);
   397		if (faddr) {
   398			if (!tr->fops)
   399				return -ENOTSUPP;
   400			tr->func.ftrace_managed = true;
   401		}
   402	
   403		if (tr->func.ftrace_managed) {
 > 404			ret = direct_ops_add(tr, new_addr);
   405		} else {
   406			ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
   407		}
   408	
   409		return ret;
   410	}
   411	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

