Return-Path: <bpf+bounces-57856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448EBAB17EF
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD1E7ADFB3
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5CF235049;
	Fri,  9 May 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBgTtqHK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A80234973;
	Fri,  9 May 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803193; cv=none; b=K7mG4OQ/VJnJ3fCZeD9wsWY+OhX5Nleyua6WMtwHBgIvDYoBI6ubeFC0lRsj3UlVBGqdA+LVF45iQg4vneAFxG8CKECy3o/6wCSSxBJ/9fsAvIU4vEl2AFxfjOBCXkG2vt/t6WNesHXx/N8JEernzY4n0kaHv/JbV7WFFj+Diz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803193; c=relaxed/simple;
	bh=JoIDgD0S6T2e9q3bDT8bPLgLZ5T/mqW0t2TfhJCE0Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8r2TZFQ07nxaIiVR3K/IJ5txUCwOLkSyZEkHYRGS/rSeAZTL2yJ1J67HdwYEcB5zvY4r9lCNGK9gMa4nuVsGeXJNMzgmXnjk+VKh+lfJMbzlwNB9NC+wLaJ76SEnUxWp1eB5s7oc1lTG7v6jCzEyJ8canyyE+XEnxxmIggIFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBgTtqHK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746803191; x=1778339191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JoIDgD0S6T2e9q3bDT8bPLgLZ5T/mqW0t2TfhJCE0Wc=;
  b=JBgTtqHKQTKUXflXvdf/3nhIY0gVCmzLSA4ECQy1hna6RhuTIxfLkbBf
   r29JtLLPNVfEOa9cRN3K8Wg9pWQSVtFh/uSFoVwFaM7oyc2M4t+5xZu6l
   2wj9dkwZjKQ2qAslWj2skLVJxFoT0Jsxz2t0SAifJRWyRXdStjJzh8G75
   dIPduklsXwAS05ZMOlSg/deebEmjLYsEH3MNPOB8IjiJfE6x0TyDtqP+B
   x4KWkWpxBtVP3v+LYs3VH3oO7bK7c97f8X54dxubJ5C19Sm+Jyb1vVztf
   euNiMxh5aTwDasCFVH+6iwd00fi2NNi7yUeG8XcLNXXQG30Yw4oQfhTQC
   g==;
X-CSE-ConnectionGUID: y7WuqohDRBuOmZtPH3yKnA==
X-CSE-MsgGUID: 4Z9qCb6eTsO5hGxvd3Vl0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="51291235"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="51291235"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 08:06:30 -0700
X-CSE-ConnectionGUID: ns9eJFUzTKWrtL7EE7VCMQ==
X-CSE-MsgGUID: NMUKjx8hR/6TW9MLj0M2ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="140703319"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 May 2025 08:06:25 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDPIs-000CBX-33;
	Fri, 09 May 2025 15:06:22 +0000
Date: Fri, 9 May 2025 23:06:01 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 4/5] bpf: Add kfunc to scrub SCM_RIGHTS at
 security_unix_may_send().
Message-ID: <202505092221.8wrWSFI7-lkp@intel.com>
References: <20250505215802.48449-5-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505215802.48449-5-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/af_unix-Call-security_unix_may_send-in-sendmsg-for-all-socket-types/20250506-060219
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250505215802.48449-5-kuniyu%40amazon.com
patch subject: [PATCH v1 bpf-next 4/5] bpf: Add kfunc to scrub SCM_RIGHTS at security_unix_may_send().
config: csky-randconfig-001-20250509 (https://download.01.org/0day-ci/archive/20250509/202505092221.8wrWSFI7-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505092221.8wrWSFI7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505092221.8wrWSFI7-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: net/core/filter.o: in function `bpf_unix_scrub_fds':
>> filter.c:(.text+0xc796): undefined reference to `unix_scrub_fds'
   csky-linux-ld: net/core/filter.o: in function `bpf_sock_destroy':
   filter.c:(.text+0xc7dc): undefined reference to `unix_scrub_fds'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

