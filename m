Return-Path: <bpf+bounces-27112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E698A92D7
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 08:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000501C20F3B
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 06:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B17657D4;
	Thu, 18 Apr 2024 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gz5vXu78"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDDD3399B
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420852; cv=none; b=gtO6htgyI0j2c5yRNKW+3e+IWmaDgv53f4AE7nGHl4WAdxv5Pc/IsOzBrB4J8K0My8e9o35M9Lf+aKJRhwaz/+9lqFimHuVsbk7ApC/5pniPD7Spx/su6R3tZu46WML/Xz9jmQEJU+SaDKNJPCXoPOUGHq8RpXHX4ShhgthPceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420852; c=relaxed/simple;
	bh=nBP7IipwE4KR0FuX5N6zhQhnH2sZcTiQNqwb2VIc028=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsPtI6EIbV9HJKCo9mLt8pOnZkyzVe3ZMv+b85gvMGGNBjXPQoT5bbaVK2ghaZQBYD8E476gIQXuP3meyZzeDMU3Pm/+rkDGlHO4oAHSUn/VUjaOGsn/hptntMAqF7a7ue0b1s9msmcEwTfdduuIQfhRZB8dYFa9j8LmdCsi/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gz5vXu78; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713420851; x=1744956851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBP7IipwE4KR0FuX5N6zhQhnH2sZcTiQNqwb2VIc028=;
  b=gz5vXu78a0+u4KVBTvJPru1W8tBA40/4bSiuhXhpV5pd6/FIwDFM1yL9
   26Owr4YWqTe8vQTYc5D3FCnid2lTmaW2fC4y8FvlMfGhEwsk0MVQQA+5R
   qjB+l+C6TrRIrN0O1rtbQSVBq1aTC6nHo/pxWPslmPu4W6sUTch3nnjkI
   meEPgR8ccUbpbDogduE+xIgAHkkYgnfND0LvVe3Zx788JhvuJsai1oz4j
   r/hd1uKR4d3yB7ECKAFj7+AelqcbAhSJ/Cb7ucdpkpE+JOMDjw0ehkcvG
   Fjy9ESjHtASh3CS9RVTUPadysjPiKO0ZWTeWDkY0/pEQ4VOuJ8qAtL7Rc
   Q==;
X-CSE-ConnectionGUID: G9WPspJiSmSMIFpsphOFlw==
X-CSE-MsgGUID: mYaMjEnHQm2/AmPEdjWceA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="11887197"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="11887197"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 23:14:10 -0700
X-CSE-ConnectionGUID: na0IERKYQ8Gwar49+uQ+Bw==
X-CSE-MsgGUID: rsi9ef0KRcChbywrB13bzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22949720"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 17 Apr 2024 23:14:06 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxL22-0007My-0w;
	Thu, 18 Apr 2024 06:14:03 +0000
Date: Thu, 18 Apr 2024 14:13:26 +0800
From: kernel test robot <lkp@intel.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
	kernel-team@meta.com, andrii@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sinquersw@gmail.com, kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: enable the "open" operator on a pinned
 path of a struct_osp link.
Message-ID: <202404181413.1uMDy1xi-lkp@intel.com>
References: <20240417002513.1534535-2-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417002513.1534535-2-thinker.li@gmail.com>

Hi Kui-Feng,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kui-Feng-Lee/bpf-enable-the-open-operator-on-a-pinned-path-of-a-struct_osp-link/20240417-082736
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240417002513.1534535-2-thinker.li%40gmail.com
patch subject: [PATCH bpf-next 1/2] bpf: enable the "open" operator on a pinned path of a struct_osp link.
config: arm-aspeed_g5_defconfig (https://download.01.org/0day-ci/archive/20240418/202404181413.1uMDy1xi-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404181413.1uMDy1xi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404181413.1uMDy1xi-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: kernel/bpf/syscall.o: in function `bpf_link_open':
>> kernel/bpf/syscall.c:3117:(.text+0xb70): undefined reference to `bpffs_struct_ops_link_open'


vim +3117 kernel/bpf/syscall.c

  3110	
  3111	/* Support opening pinned links */
  3112	static int bpf_link_open(struct inode *inode, struct file *filp)
  3113	{
  3114		struct bpf_link *link = inode->i_private;
  3115	
  3116		if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
> 3117			return bpffs_struct_ops_link_open(inode, filp);
  3118	
  3119		return -EOPNOTSUPP;
  3120	}
  3121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

