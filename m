Return-Path: <bpf+bounces-79324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F7D38492
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 19:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE09230203AE
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C723939BD;
	Fri, 16 Jan 2026 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1QiORz9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39E34E750
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589123; cv=none; b=ccnJvDu81yDpzb/cXvhaZU2vmD1qQ1XVZjBlFgivxPvhrCSjDOzdd4qQ4Usu/v722MNBxk7f+ANhAai0C3HvwwuHfu5mPJP5zlvVVkCTP5gfdOJV8XmiFUZxhNLgsPgMuwNI8pYbiDURleNNnlp2ZF+AVBd7nkEggY4VNBR+yiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589123; c=relaxed/simple;
	bh=KC8vnLFPq9rYf4xjqaRd6OEQOVIX1ylZPY6CeZ3s9Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSJLDRvpvFE/njr1l5tGH+NXz0lCEHAe0ZPdag1c18C+Xh+sidkUl3Bkzl2R9ABNMcprdkcrzKgPFLQpUu0UDlEgY1YIpNWkNF346bymwqOfLXF1+V5g9dbj4DiDWvvoBgf7n5BpUJgG6ujyG7Je4YblPqhDoFh8/dWy0IKo6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1QiORz9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768589122; x=1800125122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KC8vnLFPq9rYf4xjqaRd6OEQOVIX1ylZPY6CeZ3s9Dg=;
  b=V1QiORz9qYlL6lWgrc1ZOhz0IAJDvGVN2iIYmB8q8zQ+Vjc0GKZlYMJ8
   A4ycevYycjqjq6QmyKXHATGYU7ZvlE0rPofMGqhIKktIpPeiN1IBNbdhX
   GfkUAfwBb7ECdv+EPDoPCyYGsSFCxaprdNq/7s9SV8uQp79iMaLmTRwp2
   czDnm5n1iPAsr26KyVVnIZwdYjky9SCy2fgjwvuY2Kxzt/D/x2JcpzOSf
   XEVALO55CdWt0w7/2vBdEQJC2ReXlzAUZxlnEDGhLs2L5ftXtFqkanD2h
   2g23LMghnHbi+vpoA8xD9TMu0WZs+923bP9Pjs34wSOTT8cKRIZmd96Z0
   g==;
X-CSE-ConnectionGUID: vDPE621QQ1G09ej+yLynwA==
X-CSE-MsgGUID: nSql2f6OR8eYJe35O3YeQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="80547159"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="80547159"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 10:45:21 -0800
X-CSE-ConnectionGUID: jn66q7h/Te6r+4mh2tPsgw==
X-CSE-MsgGUID: RuEYMBl6Qxi+PdBW127cNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="209810342"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Jan 2026 10:45:16 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgooq-00000000L8m-3U1x;
	Fri, 16 Jan 2026 18:45:12 +0000
Date: Sat, 17 Jan 2026 02:44:35 +0800
From: kernel test robot <lkp@intel.com>
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com, ziye@zju.edu.cn,
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Add range tracking for BPF_DIV and
 BPF_MOD
Message-ID: <202601170243.MdnGCnsY-lkp@intel.com>
References: <20260116103246.2477635-2-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116103246.2477635-2-tangyazhou@zju.edu.cn>

Hi Yazhou,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yazhou-Tang/bpf-Add-range-tracking-for-BPF_DIV-and-BPF_MOD/20260116-183743
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260116103246.2477635-2-tangyazhou%40zju.edu.cn
patch subject: [PATCH bpf-next v4 1/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
config: sh-randconfig-001-20260116 (https://download.01.org/0day-ci/archive/20260117/202601170243.MdnGCnsY-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260117/202601170243.MdnGCnsY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601170243.MdnGCnsY-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: kernel/bpf/verifier.o: in function `adjust_scalar_min_max_vals':
   verifier.c:(.text+0x1f5d4): undefined reference to `__udivdi3'
>> sh4-linux-ld: verifier.c:(.text+0x1f918): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

