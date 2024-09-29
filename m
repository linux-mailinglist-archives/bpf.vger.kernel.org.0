Return-Path: <bpf+bounces-40500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A3E9895AF
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 15:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1201C21386
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40588748A;
	Sun, 29 Sep 2024 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yz7vyL7Z"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2101779AE
	for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727616874; cv=none; b=UC46II6UjbTES7PZ6ux4vm5Oce1CJKM3NtazyOEtDcjGCeMajixeeeNewlBFNqmb+0KJtZVlRa3VzzaFjUaaTeMrTF2QaA4uzXVouhaDc1FoBhwA9uL4hRK7vaGum1KD6EH+MXZz+IoxMIup0KJgvRHrnzO2I4gCz4Y39f4fmvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727616874; c=relaxed/simple;
	bh=4sgZujSxU+e2b/+0uZr/Pw90nW5t7dufDkyPd50I18g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/uHCYMRdPCmjb7m7D/meNucqGFA0d03hSmNcaToK4WwGPmIyFZZLstJ/YEPc3iQdqalAAri+SIz6iCUBFSmsD/1h2n8bt90o4RsJQsjz6XLy2M87OMCBVpavWc36TIeeU58o/91RfSsfgQDWpj0dMoSTaVU1VFGyJyVVwsd4OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yz7vyL7Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727616873; x=1759152873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4sgZujSxU+e2b/+0uZr/Pw90nW5t7dufDkyPd50I18g=;
  b=Yz7vyL7Zy4FLszxeS88QUXMAoYI7YLgDpASWuhluffKi25kEmYkx7Kti
   Rjz9xzcpWN3zYyGY/EX4riSKNoRNXngIxID1NeCCmR9MgQ1klRccTWnHP
   Z3eGKBeo55yeprBabiUX4FF/l4cKxIRaULY9UlhDh8JT3i7dFmDlnjM6C
   3Fxtk26rwDpT/OwUrODo905vNTOqG+GDwqwBln+vsoje/cBfcM4+KL06w
   Pgmzbe8nnSOcHXQALr3FqH+f/VWLe88bAHksCR8Dis/ADWHsFGgX6d9xy
   bZhUmW7EchrC0926tggewgSzjjp9Q1LioShW9mVp1f6bkNBfPi+9XrVB9
   A==;
X-CSE-ConnectionGUID: oSH5ViCeRLym8EyUxjRaJQ==
X-CSE-MsgGUID: pQq2dgLWTJCfe0zPZwQakA==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26217910"
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="26217910"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 06:34:32 -0700
X-CSE-ConnectionGUID: tr/D1m5xQKiwNxQKqacl+A==
X-CSE-MsgGUID: onOaCJ9IS52KzX6ZV1K3Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="73088122"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 Sep 2024 06:34:31 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suu4C-000OJV-01;
	Sun, 29 Sep 2024 13:34:28 +0000
Date: Sun, 29 Sep 2024 21:34:18 +0800
From: kernel test robot <lkp@intel.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private
 stack
Message-ID: <202409292155.eLJJACtR-lkp@intel.com>
References: <20240926234526.1770736-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926234526.1770736-1-yonghong.song@linux.dev>

Hi Yonghong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Allow-each-subprog-having-stack-size-of-512-bytes/20240927-074744
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240926234526.1770736-1-yonghong.song%40linux.dev
patch subject: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private stack
config: x86_64-buildonly-randconfig-006-20240929 (https://download.01.org/0day-ci/archive/20240929/202409292155.eLJJACtR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409292155.eLJJACtR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409292155.eLJJACtR-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `do_jit':
>> bpf_jit_comp.c:(.text+0xde78a): undefined reference to `this_cpu_off'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

