Return-Path: <bpf+bounces-64438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3313B12A69
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 14:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8231D3A31EC
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED36A203706;
	Sat, 26 Jul 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZVjZwVP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC2C21B1BC;
	Sat, 26 Jul 2025 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753532202; cv=none; b=ldnCLdQ86DqZy/9hXy2XfUKZLPghCu1TciORjZOrQApbVjhOa8TM8uiJyRj6x5XM+vVScdVUx+sRHeCcA0oSkAjpJ04gKJ5jWqPpP4DTcqllt5BSsWiGkCQM52Ac0mxan/1lXxV0n0lfyjH5nxLQWdNOMGuVewEEgA7OX6DVZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753532202; c=relaxed/simple;
	bh=FGgVTnl76TJcRwb29ehO7zC6zieQl2jZzI6k8/izKi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAEcjWJ+6/Bvb2c0yFS4q6r+0DgmVxoql4UqN46Q0EkxjulYTzD5xYqP/d59Sp4Q5V4k+krZXJ8Uxax/3kfACUuaE4u7TQWTaCLimy2UmysYFRrIaN179vVRpfpOgwIqG+nu0ZQ/4wxR6vjdlJYS0wevrHkatH5yb4le/8He7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZVjZwVP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753532201; x=1785068201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FGgVTnl76TJcRwb29ehO7zC6zieQl2jZzI6k8/izKi4=;
  b=fZVjZwVPY2s92fPs38gVUPSn+ZoC38WiKfa/n+RWu1NfXrue1mUWCtMU
   gHbr7wNC4MITx/g6zCSDJtIEWSpNltIRWJB3lJQeiC+oyxy1oK3IHZOMJ
   wUiGQY+vNdTQbvQD09LAOtLINsGHvmm21Vu72zEeZyNnH4yrf41Hxq6Zc
   xP5WeH6JVCtob6xaje1ydhV3xv2kbsh6BBy6MWug7x5+zcwCy3DwH0mUv
   aEjCFVOTD2pnJkRQ4MDh3d65d/j5YuYq3y/x6F6EZxTNKWVuvHA3JGz7U
   f4oMgmHEox2RTdmaMel3xzeltyaGeDbVaopaIhlzMsuwucqyOAb6N/8JG
   A==;
X-CSE-ConnectionGUID: //cfD8/cT5e+OAzObKxPJA==
X-CSE-MsgGUID: 1Qy0oZ2HQky5Zw/EMhJLtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55707250"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55707250"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 05:16:40 -0700
X-CSE-ConnectionGUID: jABjgCCHRMevHHKpgmcTAQ==
X-CSE-MsgGUID: yi6q9dL5SCG/rFF6/deEDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="160809401"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Jul 2025 05:16:39 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufdpM-000LyZ-26;
	Sat, 26 Jul 2025 12:16:36 +0000
Date: Sat, 26 Jul 2025 20:16:26 +0800
From: kernel test robot <lkp@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 2/3] bpf: remove bpf_key reference
Message-ID: <202507262040.o1RZHQvf-lkp@intel.com>
References: <20250724143428.4416-3-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724143428.4416-3-James.Bottomley@HansenPartnership.com>

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master linus/master v6.16-rc7 next-20250725]
[cannot apply to bpf-next/net]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/bpf-make-bpf_key-an-opaque-type/20250724-224304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250724143428.4416-3-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH 2/3] bpf: remove bpf_key reference
config: i386-randconfig-002-20250725 (https://download.01.org/0day-ci/archive/20250726/202507262040.o1RZHQvf-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507262040.o1RZHQvf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507262040.o1RZHQvf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
   kernel/trace/bpf_trace.c:378:9: warning: function '____bpf_trace_printk' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     378 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
         |         ^~~
   kernel/trace/bpf_trace.c: In function '____bpf_trace_vprintk':
   kernel/trace/bpf_trace.c:434:9: warning: function '____bpf_trace_vprintk' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     434 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
         |         ^~~
   kernel/trace/bpf_trace.c: In function '____bpf_seq_printf':
   kernel/trace/bpf_trace.c:476:9: warning: function '____bpf_seq_printf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     476 |         seq_bprintf(m, fmt, data.bin_args);
         |         ^~~~~~~~~~~
   kernel/trace/bpf_trace.c: In function 'bpf_key_put':
>> kernel/trace/bpf_trace.c:1349:37: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1349 |         if (system_keyring_id_check((u64)bkey->key) < 0)
         |                                     ^


vim +1349 kernel/trace/bpf_trace.c

  1339	
  1340	/**
  1341	 * bpf_key_put - decrement key reference count if key is valid and free bpf_key
  1342	 * @bkey: bpf_key structure
  1343	 *
  1344	 * Decrement the reference count of the key inside *bkey*, if the pointer
  1345	 * is valid, and free *bkey*.
  1346	 */
  1347	__bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
  1348	{
> 1349		if (system_keyring_id_check((u64)bkey->key) < 0)
  1350			key_put(bkey->key);
  1351	
  1352		kfree(bkey);
  1353	}
  1354	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

