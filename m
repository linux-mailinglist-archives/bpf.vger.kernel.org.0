Return-Path: <bpf+bounces-63429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE562B07566
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 14:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC57B6868
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 12:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8262F4A08;
	Wed, 16 Jul 2025 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOrj/5vI"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5272C326B;
	Wed, 16 Jul 2025 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668121; cv=none; b=nSZJPDTlZvQBS9xlWPP8lcH1BEmya+5eMahF+SlhJy71/LnwxZFvlfo5cWSlfEM+IBnIca/6lb5l9m0DKg4HuaIvGKS8rzN6RiIh5N1NnD7Y9nfTD34T2wRBAZqskmllyEHktIkxsNHCl5Bm14lhBBqKRCvJnL8s5ZrRGjE4NIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668121; c=relaxed/simple;
	bh=AdTCjyoYthmJF0tNb39i1JvmHw/jhnzoFM+rmCHkjMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbxu+bIlRoEcm4NPoXyV8iUwnGhPsD3mAuDFTypBYI6QrSJyiHhMJHubSEZ/sYKJbGNou8D5G/Pn6bIcpqvcKbPREpOQXyMwf4nNYKjZWKHtBw+Ylqd1WvnHZqqDMRWoq1Ghkd2ZoVubHK+TWwZWN+MVNBjCaRtDXw9M6sAFwqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOrj/5vI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752668118; x=1784204118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AdTCjyoYthmJF0tNb39i1JvmHw/jhnzoFM+rmCHkjMA=;
  b=GOrj/5vIV+0OJUOtOkaxHWdSenVnEWnG7eFHXfqz69oKQuihy8qtlowk
   TJkyelFY0jBYoXtnIF0dwvhP3HyrGdlEvtU5oM1lRbSHMrIK2kaa6wTH3
   W49ZqIRay/FEY+IIipsOAH2S+0TSE7jEN6qlMUZ9N6nEF/JQkIsvAmI3J
   cjV4OwhI8bjhMkv5oRhWyxKi/vp/ZD1W2dksJvERnU9VOgOCs3AGXNYH2
   fI9aRNXgBTIZrEoS47ecyne0fRs/n8sgWHK6IDJJFU8O/dS8eSV3PDRqR
   wNmmgNV8ccXatBaCKlNNjNu4Pu1g9E923AKweUzfWLSITh4jt+Y8gG0+6
   w==;
X-CSE-ConnectionGUID: kThxH8TyRyeIWoosPfd39A==
X-CSE-MsgGUID: VpZEYpzNTcuFK1lUtkYQ8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80361442"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="80361442"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 05:15:18 -0700
X-CSE-ConnectionGUID: EmmNPO7IR+SpvleOnSb+uQ==
X-CSE-MsgGUID: 5zwc3n4jQ2O1XoCH+q7TgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="157150648"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jul 2025 05:15:14 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc12W-000CLj-0z;
	Wed, 16 Jul 2025 12:15:12 +0000
Date: Wed, 16 Jul 2025 20:14:26 +0800
From: kernel test robot <lkp@intel.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] lsm,selinux: Add LSM blob support for BPF objects
Message-ID: <202507161903.ToApi2Jk-lkp@intel.com>
References: <20250715222655.705241-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715222655.705241-1-bboscaccy@linux.microsoft.com>

Hi Blaise,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pcmoore-selinux/next]
[also build test WARNING on linus/master v6.16-rc6 next-20250715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Blaise-Boscaccy/lsm-selinux-Add-LSM-blob-support-for-BPF-objects/20250716-062844
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20250715222655.705241-1-bboscaccy%40linux.microsoft.com
patch subject: [PATCH] lsm,selinux: Add LSM blob support for BPF objects
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250716/202507161903.ToApi2Jk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507161903.ToApi2Jk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507161903.ToApi2Jk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/security.c:896:12: warning: 'lsm_bpf_token_alloc' defined but not used [-Wunused-function]
     896 | static int lsm_bpf_token_alloc(struct bpf_token *token)
         |            ^~~~~~~~~~~~~~~~~~~
>> security/security.c:874:12: warning: 'lsm_bpf_prog_alloc' defined but not used [-Wunused-function]
     874 | static int lsm_bpf_prog_alloc(struct bpf_prog *prog)
         |            ^~~~~~~~~~~~~~~~~~
>> security/security.c:852:12: warning: 'lsm_bpf_map_alloc' defined but not used [-Wunused-function]
     852 | static int lsm_bpf_map_alloc(struct bpf_map *map)
         |            ^~~~~~~~~~~~~~~~~


vim +/lsm_bpf_token_alloc +896 security/security.c

   843	
   844	/**
   845	 * lsm_bpf_map_alloc - allocate a composite bpf_map blob
   846	 * @map: the bpf_map that needs a blob
   847	 *
   848	 * Allocate the bpf_map blob for all the modules
   849	 *
   850	 * Returns 0, or -ENOMEM if memory can't be allocated.
   851	 */
 > 852	static int lsm_bpf_map_alloc(struct bpf_map *map)
   853	{
   854		if (blob_sizes.lbs_bpf_map == 0) {
   855			map->security = NULL;
   856			return 0;
   857		}
   858	
   859		map->security = kzalloc(blob_sizes.lbs_bpf_map, GFP_KERNEL);
   860		if (!map->security)
   861			return -ENOMEM;
   862	
   863		return 0;
   864	}
   865	
   866	/**
   867	 * lsm_bpf_prog_alloc - allocate a composite bpf_prog blob
   868	 * @prog: the bpf_prog that needs a blob
   869	 *
   870	 * Allocate the bpf_prog blob for all the modules
   871	 *
   872	 * Returns 0, or -ENOMEM if memory can't be allocated.
   873	 */
 > 874	static int lsm_bpf_prog_alloc(struct bpf_prog *prog)
   875	{
   876		if (blob_sizes.lbs_bpf_prog == 0) {
   877			prog->aux->security = NULL;
   878			return 0;
   879		}
   880	
   881		prog->aux->security = kzalloc(blob_sizes.lbs_bpf_prog, GFP_KERNEL);
   882		if (!prog->aux->security)
   883			return -ENOMEM;
   884	
   885		return 0;
   886	}
   887	
   888	/**
   889	 * lsm_bpf_token_alloc - allocate a composite bpf_token blob
   890	 * @token: the bpf_token that needs a blob
   891	 *
   892	 * Allocate the bpf_token blob for all the modules
   893	 *
   894	 * Returns 0, or -ENOMEM if memory can't be allocated.
   895	 */
 > 896	static int lsm_bpf_token_alloc(struct bpf_token *token)
   897	{
   898		if (blob_sizes.lbs_bpf_token == 0) {
   899			token->security = NULL;
   900			return 0;
   901		}
   902	
   903		token->security = kzalloc(blob_sizes.lbs_bpf_token, GFP_KERNEL);
   904		if (!token->security)
   905			return -ENOMEM;
   906	
   907		return 0;
   908	}
   909	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

