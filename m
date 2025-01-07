Return-Path: <bpf+bounces-48146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2BCA048A6
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB50C1887FFA
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 17:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83518DF6E;
	Tue,  7 Jan 2025 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h13p80rc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54118C031
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736272385; cv=none; b=m00csai4wALNFFl0Qnn8ZmTzcVT32TqptBmQv/ztA0awm6Gk0MGt0FAHODWyv3Xj/2RQj9SuShraQPoVgmtXM7rn92XYsiPt5AvkUF/1NaNKef6mRNsgLWG3gUK64LuqSp4/En6xW8XvGI0WC8G2XJtbvqiIaEwuDOlnezBcJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736272385; c=relaxed/simple;
	bh=dhWMq+KyKXc69vopJC3ogSDKx6ryRjqvw2MDid7ehVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGGL4AJ7APK2KnWH2KSxK2lEBCxFgpuks42qSin3ID8Ln1VfJXoOR0YvrJ3xiS5FwhzjXltRE5xno/CoK7M70UL/UXZlEKv9uqCDSGZ66BdqB0aWMCthloTnO5r1qB1xqtKxcIwXZexxzVLkHtdreHao/mf3txFWMnuzAH9KAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h13p80rc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736272382; x=1767808382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dhWMq+KyKXc69vopJC3ogSDKx6ryRjqvw2MDid7ehVM=;
  b=h13p80rcQYcDJsY41dWeotGMgtLaxniyVADjA28GSamk1wwCtJ2aSs52
   XVMQdxQU9XsOvrPZz27xQbj5/o/aOLPRycJGRjoJkkYP2M3erNk0BzySx
   nAM4+D4bd6Ys1/xvbOG/hEdudOZ1IIXK4gkaFx1im6xu83Ol841YsP1nH
   Oxp+9vhDT4k29KCAT7H2LF8SXbm9tzq7UWyUgqIcZGzh6DXT6udrXCcm7
   dR2zUE7hzWCa6mwo0beLAlXq2LiOk9A9GdowQNOIQCvfH07Fq2eaapgiG
   2KMFxUkZaccKnaAImwkoQXOGOKX8A+h6SNPgc9guKcU7mp1yCZlB4aGOp
   Q==;
X-CSE-ConnectionGUID: raNwv9ULQHWF3+9p7m6E1A==
X-CSE-MsgGUID: dfK6IWAVQ6ySYKXEbciEbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="40140196"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="40140196"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 09:53:01 -0800
X-CSE-ConnectionGUID: NGvOOsQ9Qseau+Yaos1cEw==
X-CSE-MsgGUID: uQYM9jgiQPu97buUhzmAtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="107888087"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Jan 2025 09:52:59 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVDlB-000F3j-0n;
	Tue, 07 Jan 2025 17:52:57 +0000
Date: Wed, 8 Jan 2025 01:52:18 +0800
From: kernel test robot <lkp@intel.com>
To: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>,
	bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Add bpf command to get number of map
 entries
Message-ID: <202501080123.MlvmZO4I-lkp@intel.com>
References: <20250106145328.399610-3-charalampos.stylianopoulos@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106145328.399610-3-charalampos.stylianopoulos@gmail.com>

Hi Charalampos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Charalampos-Stylianopoulos/bpf-Add-map_num_entries-map-op/20250106-225520
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250106145328.399610-3-charalampos.stylianopoulos%40gmail.com
patch subject: [PATCH bpf-next 2/4] bpf: Add bpf command to get number of map entries
config: nios2-randconfig-r072-20250107 (https://download.01.org/0day-ci/archive/20250108/202501080123.MlvmZO4I-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501080123.MlvmZO4I-lkp@intel.com/

New smatch warnings:
kernel/bpf/syscall.c:5771 bpf_get_num_entries() warn: unsigned 'num_entries' is never less than zero.

Old smatch warnings:
arch/nios2/include/asm/thread_info.h:62 current_thread_info() error: uninitialized symbol 'sp'.

vim +/num_entries +5771 kernel/bpf/syscall.c

  5752	
  5753	static int bpf_get_num_entries(union bpf_attr *attr, union bpf_attr __user *uattr)
  5754	{
  5755		__u32 num_entries = 0;
  5756		struct bpf_map *map;
  5757	
  5758		if (CHECK_ATTR(BPF_MAP_GET_NUM_ENTRIES))
  5759			return -EINVAL;
  5760	
  5761	
  5762		CLASS(fd, f)(attr->map_fd);
  5763		map = __bpf_map_get(f);
  5764		if (IS_ERR(map))
  5765			return PTR_ERR(map);
  5766	
  5767		if (!map->ops->map_num_entries)
  5768			return -EOPNOTSUPP;
  5769	
  5770		num_entries = map->ops->map_num_entries(map);
> 5771		if (num_entries < 0)
  5772			return num_entries;
  5773	
  5774		if (put_user(num_entries, &uattr->map_get_num_entries.num_entries))
  5775			return -EFAULT;
  5776	
  5777		return 0;
  5778	}
  5779	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

