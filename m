Return-Path: <bpf+bounces-59994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5B3AD0C1E
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 11:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08E07A8DC7
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6CD20C492;
	Sat,  7 Jun 2025 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3KYT5CS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663672080C1;
	Sat,  7 Jun 2025 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749288455; cv=none; b=XNa0mfDLZi9voUtMurHQYbH5kItn/Oc2EpXTluUmQRYT86MvOJK2EU9+OGG4nebNJ5YjONy65LyBq0hK90OhITUNAUNtrMyn/w/SjQYkKGdirVHPzNTVMYTVfdk3UzUq2Ts4MrENTeRzIVwUMidZZcwnUXmeX+4Dj2KJO7fylbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749288455; c=relaxed/simple;
	bh=KwlFk+eTqnenejKew/WrKTQbxas+2O1dcqt7GtJkX4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkzvdpCxK6O6zSMIU+svFHXD+ogG6G/gS/IL9/reIX9fdxuV0hOr0OmedTwn5MJKZRx0pmCdpkJYTX+58D05hcJVqBAelRJIGkTWZ+RShPUMkNJzm5aUc3SrWMZbHCnhVwsUnrJpR0LGQeHK3Abx3VQ8mmgKttTpOaDCYpZGWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3KYT5CS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749288454; x=1780824454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KwlFk+eTqnenejKew/WrKTQbxas+2O1dcqt7GtJkX4E=;
  b=c3KYT5CSSz5JWXIyVu73C0ebu596hL4FTQ8NbV33lG7TwJ8vnRCiViAA
   AUXBtT+MHk6tZ442EqTqpOqN+bc6ExSiGIyHSxR2bpSIoQ78jBwSr3t5V
   Mqsq8D+mJA/omNxQmiPcMss0UVLLxObthkL3JHSsZa9Lg5HfTx46j5wOi
   5qVOlQMuGIfvAb9AZ0myrxbLO1P0Hi8ZCCIvi3gjld+MWgv6JOgCO7+Gi
   v6nmaQFCp/7lMJlWTnQf1XRHdsc996W7lcj9mXPCKLyTrWvxD9g3WLdDP
   tICQulk7HaDvXi3Jv5utG6HR0dAt/pGzjCS1QW5/uTa0nv1YL+Qv40BYA
   w==;
X-CSE-ConnectionGUID: VXYJC0wUT36ZojtmkZd0MA==
X-CSE-MsgGUID: Qd5h417gTjeQz7KWPIRdgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51528824"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="51528824"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 02:27:33 -0700
X-CSE-ConnectionGUID: Fl2Uz7DPQ0aq9MskZ5dlfg==
X-CSE-MsgGUID: PxT8sDgfQJGWQvoLVmzSzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="146984835"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Jun 2025 02:27:30 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNppo-0005af-25;
	Sat, 07 Jun 2025 09:27:28 +0000
Date: Sat, 7 Jun 2025 17:26:39 +0800
From: kernel test robot <lkp@intel.com>
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bboscaccy@linux.microsoft.com,
	paul@paul-moore.com, kys@microsoft.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH 07/12] bpf: Return hashes of maps in
 BPF_OBJ_GET_INFO_BY_FD
Message-ID: <202506071738.5MZFjRuA-lkp@intel.com>
References: <20250606232914.317094-8-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606232914.317094-8-kpsingh@kernel.org>

Hi KP,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master linus/master next-20250606]
[cannot apply to v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/bpf-Implement-an-internal-helper-for-SHA256-hashing/20250607-073052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250606232914.317094-8-kpsingh%40kernel.org
patch subject: [PATCH 07/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
config: x86_64-buildonly-randconfig-005-20250607 (https://download.01.org/0day-ci/archive/20250607/202506071738.5MZFjRuA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250607/202506071738.5MZFjRuA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506071738.5MZFjRuA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/arraymap.c:15:10: fatal error: crypto/sha256_base.h: No such file or directory
      15 | #include <crypto/sha256_base.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +15 kernel/bpf/arraymap.c

  > 15	#include <crypto/sha256_base.h>
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

