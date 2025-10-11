Return-Path: <bpf+bounces-70778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A7BCF713
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 16:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 310ED34AC05
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369BA27C872;
	Sat, 11 Oct 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+phDwQB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A8C27B335
	for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760192705; cv=none; b=EHFpMtog5VNVmAKTym4ezUQO2qTz9Jn0m/R72L8fUOxkvJMEcJCOePvCJd5qh4WMgwOSxfQXevnSML8epjscHWiAvTu6VvoFt3VDUuWjjzILgG6L+sTiOhljabKDzFhIDw7e9pHG4ff2qj6I4XHGTOivEhN7nc+Znhbua79oq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760192705; c=relaxed/simple;
	bh=EfnPezzGCuDtc5pA23YbvB1YQJ9u9y7zLGi2HjZ2fv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAlNIpGTmiyzsifNTqKruZyhSqoHAzl1Xhej/tXMWFWiKuiQdpptnWZxz1dPNoa0+D6OJ19OcDq16t0NgGbD801dmleGGcX6ZwqRSLixjDteUxJ0+r86k8MLOjV0gtSzT15q+iSH6VwytgDCX7teguFYtgaCKK2hL4TFsv1Fyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+phDwQB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760192704; x=1791728704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EfnPezzGCuDtc5pA23YbvB1YQJ9u9y7zLGi2HjZ2fv8=;
  b=M+phDwQBGmjy9bwryzEtOGV9TVmskYljSk9kiTJa7gdFcFXmBePZ+J+W
   Vp+g70kHz7RZtgjSqhHk2wvIN1U8YF5vCb0oCIQiL9S50WHUryc3HCHAQ
   JCRn78wDsLv9jrewMoCHzG9aq0YrNpqaKRCvcE217XFGnkgwzC3rRIF80
   t8KO26RF3hWdOzSszwkNTzKpHcrLXqkM6JvTRccPMkJ6E1eM8HiGmXc1e
   S6kdFLTRUEO64Yh3jKCrUClIdt4vP5SSaqJb9OwDfyVQGJAuEQOPM8+7P
   aXSI0hVIigQyTDC4kXZHLFZ1gg65ca/szOzpLjD92dLeZZMgTgKGTebeq
   Q==;
X-CSE-ConnectionGUID: z/rR7UScQgKJ8ko42etlxg==
X-CSE-MsgGUID: S7aCA0SxTjygHaN+oWIbpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11579"; a="85016389"
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="85016389"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 07:25:03 -0700
X-CSE-ConnectionGUID: FQXNO099TE2Lp+3P92lOdg==
X-CSE-MsgGUID: pjSEXfoVRgCQA07sLEryfg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Oct 2025 07:25:01 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7aWo-0003oN-2e;
	Sat, 11 Oct 2025 14:24:58 +0000
Date: Sat, 11 Oct 2025 22:24:41 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] bpf: consistently use bpf_rcu_lock_held()
 everywhere
Message-ID: <202510112101.pygcEmGf-lkp@intel.com>
References: <20251010173021.3952776-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010173021.3952776-1-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-consistently-use-bpf_rcu_lock_held-everywhere/20251011-013430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251010173021.3952776-1-andrii%40kernel.org
patch subject: [PATCH bpf-next] bpf: consistently use bpf_rcu_lock_held() everywhere
config: i386-buildonly-randconfig-001-20251011 (https://download.01.org/0day-ci/archive/20251011/202510112101.pygcEmGf-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510112101.pygcEmGf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510112101.pygcEmGf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/workqueue.h:17,
                    from include/linux/bpf.h:11,
                    from include/linux/bpf_verifier.h:7,
                    from net/core/filter.c:21:
   include/linux/bpf_local_storage.h: In function 'bpf_local_storage_lookup':
>> include/linux/bpf_local_storage.h:149:39: error: implicit declaration of function 'bpf_rcu_lock_held'; did you mean 'rcu_read_lock_held'? [-Werror=implicit-function-declaration]
     149 |                                       bpf_rcu_lock_held());
         |                                       ^~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:399:53: note: in definition of macro 'RCU_LOCKDEP_WARN'
     399 |                 if (debug_lockdep_rcu_enabled() && (c) &&               \
         |                                                     ^
   include/linux/rcupdate.h:680:9: note: in expansion of macro '__rcu_dereference_check'
     680 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf_local_storage.h:148:17: note: in expansion of macro 'rcu_dereference_check'
     148 |         sdata = rcu_dereference_check(local_storage->cache[smap->cache_idx],
         |                 ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +149 include/linux/bpf_local_storage.h

450af8d0f6be2e KP Singh         2020-08-25  129  
c83597fa5dc6b3 Yonghong Song    2022-10-25  130  struct bpf_map *
c83597fa5dc6b3 Yonghong Song    2022-10-25  131  bpf_local_storage_map_alloc(union bpf_attr *attr,
08a7ce384e33e5 Martin KaFai Lau 2023-03-22  132  			    struct bpf_local_storage_cache *cache,
08a7ce384e33e5 Martin KaFai Lau 2023-03-22  133  			    bool bpf_ma);
450af8d0f6be2e KP Singh         2020-08-25  134  
68bc61c26cacf1 Marco Elver      2024-02-07  135  void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
68bc61c26cacf1 Marco Elver      2024-02-07  136  				      struct bpf_local_storage_map *smap,
68bc61c26cacf1 Marco Elver      2024-02-07  137  				      struct bpf_local_storage_elem *selem);
68bc61c26cacf1 Marco Elver      2024-02-07  138  /* If cacheit_lockit is false, this lookup function is lockless */
68bc61c26cacf1 Marco Elver      2024-02-07  139  static inline struct bpf_local_storage_data *
450af8d0f6be2e KP Singh         2020-08-25  140  bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
450af8d0f6be2e KP Singh         2020-08-25  141  			 struct bpf_local_storage_map *smap,
68bc61c26cacf1 Marco Elver      2024-02-07  142  			 bool cacheit_lockit)
68bc61c26cacf1 Marco Elver      2024-02-07  143  {
68bc61c26cacf1 Marco Elver      2024-02-07  144  	struct bpf_local_storage_data *sdata;
68bc61c26cacf1 Marco Elver      2024-02-07  145  	struct bpf_local_storage_elem *selem;
68bc61c26cacf1 Marco Elver      2024-02-07  146  
68bc61c26cacf1 Marco Elver      2024-02-07  147  	/* Fast path (cache hit) */
68bc61c26cacf1 Marco Elver      2024-02-07  148  	sdata = rcu_dereference_check(local_storage->cache[smap->cache_idx],
68bc61c26cacf1 Marco Elver      2024-02-07 @149  				      bpf_rcu_lock_held());
68bc61c26cacf1 Marco Elver      2024-02-07  150  	if (sdata && rcu_access_pointer(sdata->smap) == smap)
68bc61c26cacf1 Marco Elver      2024-02-07  151  		return sdata;
68bc61c26cacf1 Marco Elver      2024-02-07  152  
68bc61c26cacf1 Marco Elver      2024-02-07  153  	/* Slow path (cache miss) */
68bc61c26cacf1 Marco Elver      2024-02-07  154  	hlist_for_each_entry_rcu(selem, &local_storage->list, snode,
68bc61c26cacf1 Marco Elver      2024-02-07  155  				  rcu_read_lock_trace_held())
68bc61c26cacf1 Marco Elver      2024-02-07  156  		if (rcu_access_pointer(SDATA(selem)->smap) == smap)
68bc61c26cacf1 Marco Elver      2024-02-07  157  			break;
68bc61c26cacf1 Marco Elver      2024-02-07  158  
68bc61c26cacf1 Marco Elver      2024-02-07  159  	if (!selem)
68bc61c26cacf1 Marco Elver      2024-02-07  160  		return NULL;
68bc61c26cacf1 Marco Elver      2024-02-07  161  	if (cacheit_lockit)
68bc61c26cacf1 Marco Elver      2024-02-07  162  		__bpf_local_storage_insert_cache(local_storage, smap, selem);
68bc61c26cacf1 Marco Elver      2024-02-07  163  	return SDATA(selem);
68bc61c26cacf1 Marco Elver      2024-02-07  164  }
450af8d0f6be2e KP Singh         2020-08-25  165  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

