Return-Path: <bpf+bounces-27075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F398A8F47
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 01:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE5A2832BA
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A75685643;
	Wed, 17 Apr 2024 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wv1ScXz0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEFC80614
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395994; cv=none; b=L3vx4i5HBUN22GyMLWdNaP7AZUiAeusXVpWkcMTSZZOUat6ELJuF4MCYDSdWiwR9E3i3dwBjGZ75J8gbOeTmj8N6ilHoJ5Frw76UFsHScZ8dZE91rXrqpxFLTCtUUkPTLC5sEjh08fsfi728keYVQKyp4bu+u8ixp6G2cNFDhw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395994; c=relaxed/simple;
	bh=taNf4Y8ioB/0kj4QfBY8A1a56xCMRkFv8KW9HjM7YXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2xtolsaObHrwPobYJrVqOBX3u4PqjWZpJ17YQBW7khL+EBTMCZe+mmULKk1KBEC+bLWRGRGiIhbYsMsQoxTlbRJUnkt7+7lz76JEa44IkHljus++7wKt7FOuaB8F0FiEg4CG27pHOx4QY/erIumzBQl+rEzFfmt/O9Kgfav0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wv1ScXz0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713395993; x=1744931993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=taNf4Y8ioB/0kj4QfBY8A1a56xCMRkFv8KW9HjM7YXk=;
  b=Wv1ScXz0pO+mrLXzrM+GQN9kJ6MDW7nxoCzQdMiGHJ47bgqHgrzqOC0r
   e4wCJtZB84DZns9GyVC9hQSGOLsuIsz9e83J0+OpZ0yjHJ78bt4m3UZcg
   kkkqwSSe0lnEqgvTvAjIcpcnXv68qR6+QPeo23NxGOHtlZYL0osyitK4b
   6Ov1XdtYxmLXcdCxVEho48DKcCXdu+x17+YcXbM6MnplJmDzreVBnckH8
   KI4wxsoMYQmT7BVVESBpZ6No1vrVGyUgICJiegI4+y+lTGoJSrfx44mYo
   B8oNhN8l6/m8lU15ojdCPwwq86LFp+2PzJnfvmhqouj7lIQraSvOugHBS
   g==;
X-CSE-ConnectionGUID: sIrQyY6TQZG15HMQP7Rdaw==
X-CSE-MsgGUID: 82tX/06VQBiDMDvOyaxadg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8776324"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="8776324"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 16:19:52 -0700
X-CSE-ConnectionGUID: BMF9BY7cTwmKS5nT4t7XHw==
X-CSE-MsgGUID: q9UuPT4GT1W0ZDkb4Lbmfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="22663364"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 17 Apr 2024 16:19:49 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxEZ8-00075C-13;
	Wed, 17 Apr 2024 23:19:46 +0000
Date: Thu, 18 Apr 2024 07:19:20 +0800
From: kernel test robot <lkp@intel.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
	kernel-team@meta.com, andrii@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	sinquersw@gmail.com, kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: enable the "open" operator on a pinned
 path of a struct_osp link.
Message-ID: <202404180747.NXWUtZTG-lkp@intel.com>
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
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240418/202404180747.NXWUtZTG-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7089c359a3845323f6f30c44a47dd901f2edfe63)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404180747.NXWUtZTG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404180747.NXWUtZTG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: bpffs_struct_ops_link_open
   >>> referenced by syscall.c
   >>>               kernel/bpf/syscall.o:(bpf_link_open) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

