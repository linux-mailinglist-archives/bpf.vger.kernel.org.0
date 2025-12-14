Return-Path: <bpf+bounces-76560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EE6CBB5AF
	for <lists+bpf@lfdr.de>; Sun, 14 Dec 2025 02:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D407F300CBA4
	for <lists+bpf@lfdr.de>; Sun, 14 Dec 2025 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AEA2D6E6A;
	Sun, 14 Dec 2025 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jedr6R2R"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293CDA95E;
	Sun, 14 Dec 2025 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765674939; cv=none; b=M1Q5dIlXvxqsIemOqopGC88QOvvGt6tKqBQgHbP7X1xE0SabQqHLKdSn4VsgYFigJzij23C1yKYJehc7ySNs3uKX3ezVxWmK8/MQGnf5uARmOimE1J8BhlB8VNEQ7hc6eMDAXWsV71B9DwkLJrSRJD5dMW8TuKJWu8C9+l/kzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765674939; c=relaxed/simple;
	bh=yaSLe5QESpiy6HbErVQIl+luTlywDCH2A/xhylUbG0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv1BMzdQci3emBP+4TuRPd57gNFRW36eCxSJutVnJH9JqGtetu+/3/n91yve69BTHO36CyleVJN7TY4rqLSVle5SEUA3tUi4JUbmF4eXvBgLvg5jkhs4+DgOieDHXdzg+teGg7BN8gXRYe4iQM4ZiAL92HHFDiX7JWof+Mid+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jedr6R2R; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765674939; x=1797210939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yaSLe5QESpiy6HbErVQIl+luTlywDCH2A/xhylUbG0U=;
  b=Jedr6R2Ro0BGwEZrARkDfIILa0NXrIa97z4r/bl6BkdCJJ+F3bJjDSBD
   sUOzW+LKy8HMY1XnhdVID5b+yZ3dYP2lHBFGwf6/i8ehOk+ez7zhCMjSa
   cI3fTsCtJvsJzHWw5eDxG0YuXG4jzCZavqU+OjTAJN9WLgMlhF+lG8l1A
   KQs/Gkz7RIsFqrXCXHoVh5aIG+T3BPqUWyEYjJArGLbrb43J6DEvlAD45
   ZtR/jSsa4BIdHDP8cAvYy57gnLo2KgLZuxfPhYNh2FgddAHSFWsPvDysR
   VS32KNYA59uyguTaplqaK0BQxf5xp/379uDe1YOXa7fnOJ0ypKbc+dhPS
   Q==;
X-CSE-ConnectionGUID: YLB1c2oqSqazd5gNY9TJyg==
X-CSE-MsgGUID: 2Tdstgu7Tx+Zok85fK45oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11641"; a="67665817"
X-IronPort-AV: E=Sophos;i="6.21,147,1763452800"; 
   d="scan'208";a="67665817"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 17:15:38 -0800
X-CSE-ConnectionGUID: kp07iKH7T26LEFSVgrygrA==
X-CSE-MsgGUID: f5n45W/uQeq/W0Xgs7vS8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,147,1763452800"; 
   d="scan'208";a="197311867"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 Dec 2025 17:15:35 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vUahx-000000008PV-0iSe;
	Sun, 14 Dec 2025 01:15:33 +0000
Date: Sun, 14 Dec 2025 09:14:33 +0800
From: kernel test robot <lkp@intel.com>
To: Donglin Peng <dolinux.peng@gmail.com>, rostedt@goodmis.org
Cc: oe-kbuild-all@lists.linux.dev, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: Re: [PATCH v3 1/2] fgraph: Enhance funcgraph-retval with BTF-based
 type-aware output
Message-ID: <202512140850.JdD1lPmn-lkp@intel.com>
References: <20251209121349.525641-2-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209121349.525641-2-dolinux.peng@gmail.com>

Hi Donglin,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.18 next-20251212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Donglin-Peng/fgraph-Enhance-funcgraph-retval-with-BTF-based-type-aware-output/20251209-201633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20251209121349.525641-2-dolinux.peng%40gmail.com
patch subject: [PATCH v3 1/2] fgraph: Enhance funcgraph-retval with BTF-based type-aware output
config: arm-randconfig-002-20251214 (https://download.01.org/0day-ci/archive/20251214/202512140850.JdD1lPmn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251214/202512140850.JdD1lPmn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512140850.JdD1lPmn-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: kernel/trace/trace_functions_graph.o: in function `trim_retval':
>> kernel/trace/trace_functions_graph.c:888: undefined reference to `btf_find_func_proto'


vim +888 kernel/trace/trace_functions_graph.c

   872	
   873	static void trim_retval(unsigned long func, unsigned long *retval, bool *print_retval,
   874				int *fmt)
   875	{
   876		const struct btf_type *t;
   877		char name[KSYM_NAME_LEN];
   878		struct btf *btf;
   879		u32 v, msb;
   880		int kind;
   881	
   882		if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
   883			return;
   884	
   885		if (lookup_symbol_name(func, name))
   886			return;
   887	
 > 888		t = btf_find_func_proto(name, &btf);
   889		if (IS_ERR_OR_NULL(t))
   890			return;
   891	
   892		t = btf_type_skip_modifiers(btf, t->type, NULL);
   893		kind = t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN;
   894		switch (kind) {
   895		case BTF_KIND_UNKN:
   896			*print_retval = false;
   897			break;
   898		case BTF_KIND_STRUCT:
   899		case BTF_KIND_UNION:
   900		case BTF_KIND_ENUM:
   901		case BTF_KIND_ENUM64:
   902			if (kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION)
   903				*fmt = RETVAL_FMT_HEX;
   904			else
   905				*fmt = RETVAL_FMT_DEC;
   906	
   907			if (t->size > sizeof(unsigned long)) {
   908				*fmt |= RETVAL_FMT_TRUNC;
   909			} else {
   910				msb = BITS_PER_BYTE * t->size - 1;
   911				*retval &= GENMASK(msb, 0);
   912			}
   913			break;
   914		case BTF_KIND_INT:
   915			v = *(u32 *)(t + 1);
   916			if (BTF_INT_ENCODING(v) == BTF_INT_BOOL) {
   917				*fmt = RETVAL_FMT_BOOL;
   918				msb = 0;
   919			} else {
   920				if (BTF_INT_ENCODING(v) == BTF_INT_SIGNED)
   921					*fmt = RETVAL_FMT_DEC;
   922				else
   923					*fmt = RETVAL_FMT_HEX;
   924	
   925				if (t->size > sizeof(unsigned long)) {
   926					*fmt |= RETVAL_FMT_TRUNC;
   927					msb = BITS_PER_LONG - 1;
   928				} else {
   929					msb = BTF_INT_BITS(v) - 1;
   930				}
   931			}
   932			*retval &= GENMASK(msb, 0);
   933			break;
   934		default:
   935			*fmt = RETVAL_FMT_HEX;
   936			break;
   937		}
   938	}
   939	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

