Return-Path: <bpf+bounces-32374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DDA90C2EA
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 06:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BC71F2391B
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 04:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498EC1586C9;
	Tue, 18 Jun 2024 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MnYKoPac"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E3179BD
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718685817; cv=none; b=EYgpqX8E96oRUoQYAMKmFRsEOGZuCzjWpH/d1aym29Rv/90Kd14ez0M3ZKnwZHkYyvCPFRMVEOHI1d+P2WO8mbVjzAptHtLP5yz8Tx0+8w7c/3L51I/pcj3udr8cD/z8ApDuHpUisnLlQchsCEIf4/HTE7qyw6rj/Gbc6FGWFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718685817; c=relaxed/simple;
	bh=tDedQ8X7Y1WH8Xb2QlbfdiiYLqWjo3JuOKrohHYQSg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYH2Kcid0FEliKyRKNZjPBTkWFyAfrHDuucZDP8Fx1eZm9g31BOCJU9zo+AyovmRjgnR5vdr+jFgxci/IHr4q6A70ENsZRfNvEy1jmB0htHWfv8HszYtseF5hSE53jrHOAdvDoV77EaJ1uPeb4Cda/4l0efw5VI3jnjfnPhIdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MnYKoPac; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718685816; x=1750221816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tDedQ8X7Y1WH8Xb2QlbfdiiYLqWjo3JuOKrohHYQSg0=;
  b=MnYKoPacz1O+yQ9Q6IB8XeEwNszKaNscdYV9C9Ti5fSH7GeNUwGtQmTj
   P6iKUKXg0GZHe9yOz3noMZPBlS4E2Y+Q8mPpy1LDjnzTbHqHpI7zP+m4c
   ivw1hNd0y754Cnd8j2jN2KUwGu1ib7SS8oDA6aUwvydC1nEn+yAl47+2I
   ynAFROS0Y5FntVJ8Pb8VOTl42oBv+JqXZeTmF3+a8LciEHZMviYCRZxyq
   3YHDT//lArgzEFHC31Hv1j5vcoYgpbnJ+bStGbyQo4z2dGSBV01FtsIee
   SQWLkxW8V3wZjLdzId+I+plRYbyzzCOAHPvJYNDfUVc4E5ezwQd9yZvIa
   w==;
X-CSE-ConnectionGUID: eoIlkJIGQwK7smnH2ehDXw==
X-CSE-MsgGUID: kBSurmnmTfGbmfocX5jy3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="18453516"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="18453516"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 21:43:36 -0700
X-CSE-ConnectionGUID: HM08R2CVSPKLj5p8uUAc3A==
X-CSE-MsgGUID: /RBofxslQgOvH0rhb9YgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="72624381"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Jun 2024 21:43:33 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJQgs-0005DR-2i;
	Tue, 18 Jun 2024 04:43:30 +0000
Date: Tue, 18 Jun 2024 12:43:11 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	pengfei.xu@intel.com, brho@google.com, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf] bpf: Fix remap of arena.
Message-ID: <202406181248.u80sRLXy-lkp@intel.com>
References: <20240617171812.76634-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617171812.76634-1-alexei.starovoitov@gmail.com>

Hi Alexei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov/bpf-Fix-remap-of-arena/20240618-012054
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20240617171812.76634-1-alexei.starovoitov%40gmail.com
patch subject: [PATCH v2 bpf] bpf: Fix remap of arena.
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240618/202406181248.u80sRLXy-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240618/202406181248.u80sRLXy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406181248.u80sRLXy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/arena.c: In function 'arena_vm_open':
>> kernel/bpf/arena.c:235:27: warning: unused variable 'arena' [-Wunused-variable]
     235 |         struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
         |                           ^~~~~


vim +/arena +235 kernel/bpf/arena.c

   231	
   232	static void arena_vm_open(struct vm_area_struct *vma)
   233	{
   234		struct bpf_map *map = vma->vm_file->private_data;
 > 235		struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
   236		struct vma_list *vml = vma->vm_private_data;
   237	
   238		atomic_inc(&vml->mmap_count);
   239	}
   240	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

