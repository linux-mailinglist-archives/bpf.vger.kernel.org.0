Return-Path: <bpf+bounces-64848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1520B1791B
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 00:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6602E4E5E78
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 22:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EAA27815F;
	Thu, 31 Jul 2025 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOpjLkMx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240602777E8;
	Thu, 31 Jul 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000981; cv=none; b=EiXFW/3RHFShDnEj5m2j/ELx5Cn4yaPNaPCNy2JwcMb+fHLgv9JeMlY4vLx69TXKd9kbLWA5uoDjFbQPLjGaSJ1E7cHZ20KwSytDYnKD2W3LgEmzf/3216zJFoRB8teNCImJIJsoKsh2Cuc8InEN0YBUZz0mRPuYsm1GYWrD8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000981; c=relaxed/simple;
	bh=KzlZ+JTGzDjXQzM1ODwtEYqyZ+h/YI+hr6FqovTMq+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEg9nKulqT0CfWDEJoyLCMDGb0eqe90PTucCQGnKmSeS8y6EhKOPNVbL9tbgntIOGBG+Da0ccisMRuGt7XNHPJ1BenKL75Fqw6PSdTIlZdNmFKk4MGwEuEOqS5gWQIgMg+CCFfQUbEuKHlNj6RCuSexTpg4ikmgNXN9uhS6ssrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOpjLkMx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754000980; x=1785536980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KzlZ+JTGzDjXQzM1ODwtEYqyZ+h/YI+hr6FqovTMq+w=;
  b=kOpjLkMxOPYRVPjBhc2knG1M2nVi9opW6isYI1bIA2Wi4GlT6sDyuIOW
   8+ju4LsISMwusb3g5ib10gt401T6RW2h0uY8DIxW45ftjucwgFerGcXi7
   QGL4A7AWDorCU4L3cOVfomw/hnl6Hg0uHnU8eGvkZ87WPrvZTqLQZborB
   hB+slhC/5Znsmd6VHyKuGD60sBjRK45Rze+MTkwD+SUWNIoeyJAVxdCDt
   LxqkyeWiGO9HDq72fFv7Uv9BxyYmlLlks6AMR+abGcs9H79x+XR+WLdvl
   f0JXKew5KIXphJ+oM1+0xpYXz4OgKtRDSG8l0Y3Yy4MFjDVPzTUB08Re0
   Q==;
X-CSE-ConnectionGUID: 9gcWIbbtQIuG+TFpMT3EGg==
X-CSE-MsgGUID: X3D2bkInTqSXpRrHfp7hRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56038121"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56038121"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 15:29:40 -0700
X-CSE-ConnectionGUID: aqcDJqGhSxCRX/RaGhNRVQ==
X-CSE-MsgGUID: ss1G1ZHQR9ycKIDy0XgIDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163301179"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 31 Jul 2025 15:29:38 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhbmK-00049G-08;
	Thu, 31 Jul 2025 22:29:36 +0000
Date: Fri, 1 Aug 2025 06:28:47 +0800
From: kernel test robot <lkp@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2 3/3] bpf: eliminate the allocation of an intermediate
 struct bpf_key
Message-ID: <202508010803.nlVVIZ7G-lkp@intel.com>
References: <20250730172745.8480-4-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730172745.8480-4-James.Bottomley@HansenPartnership.com>

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master linus/master v6.16 next-20250731]
[cannot apply to bpf-next/net]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/bpf-make-bpf_key-an-opaque-type/20250731-013040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250730172745.8480-4-James.Bottomley%40HansenPartnership.com
patch subject: [PATCH v2 3/3] bpf: eliminate the allocation of an intermediate struct bpf_key
config: i386-randconfig-141-20250731 (https://download.01.org/0day-ci/archive/20250801/202508010803.nlVVIZ7G-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508010803.nlVVIZ7G-lkp@intel.com/

smatch warnings:
kernel/trace/bpf_trace.c:1337 bpf_key_put() warn: always true condition '(key != BUILTIN_KEY) => (0-u32max != u64max)'

vim +1337 kernel/trace/bpf_trace.c

  1324	
  1325	/**
  1326	 * bpf_key_put - decrement key reference count if key is valid and free bpf_key
  1327	 * @bkey: bpf_key structure
  1328	 *
  1329	 * Decrement the reference count of the key inside *bkey*, if the pointer
  1330	 * is valid, and free *bkey*.
  1331	 */
  1332	__bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
  1333	{
  1334		struct key *key = (struct key *)bkey;
  1335	
  1336		if (system_keyring_id_check((unsigned long)key) < 0 &&
> 1337		    (unsigned long)key != BUILTIN_KEY)
  1338			key_put(key);
  1339	}
  1340	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

