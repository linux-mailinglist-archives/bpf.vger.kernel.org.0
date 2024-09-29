Return-Path: <bpf+bounces-40494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE729989598
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 15:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D67E1F22179
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937A178CDE;
	Sun, 29 Sep 2024 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xfaz+Wz3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0AC14A09A
	for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727615014; cv=none; b=slo5kd79vMOXwoyGJxgZTvtJF9rxAAwMi4XbtmKGt5q0wAAIWew5FVyxmnnLHbLsdp+nyMFUxgL1Zl7mNHv4Fj43f9OOVv2nQQqxh7k8ixNaUO0h4z7/im59jrSNXsnDA8tAEkADq59llg7hVM2gmCSlNaoUonzL3+zayosim2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727615014; c=relaxed/simple;
	bh=0hP0iAXCpUDYZIs5XGNe6MqLBrqzXP8zjR5546kWnx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MowSk6+77Ou4VRwSoPnwEbqjMlyETXaLCFVrQhcnvXKx5ZhIiHmLgWEZg8mQkGPYKe2lvely93y2gd5Y+rQ2dcw1mlI7ZGecvN3t1Klf0mUFDH8K0Bv7TQ+HdRUg5aZiOP14lxp1CxxM5YEiiKDG+F+2STo9zed5uVgnpj1WwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xfaz+Wz3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727615013; x=1759151013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0hP0iAXCpUDYZIs5XGNe6MqLBrqzXP8zjR5546kWnx4=;
  b=Xfaz+Wz3yQaQlbm7Z/A1uNia1ZKeIvvUs/pNll4otLts4Cp7GWtqBl9M
   ablRMb1L5M+DM4zIusOTNkSIecpRaZqQhYrqAPtmE6xYRjVbZWmVcxEUg
   cTXXIxJY5h+E+oKzkvh6h4MOXodhEyR8SN/feGvOX8zy3I1N5/qT9All7
   KYwE40/tFmK+88+ywgY/oF0u3ETyTHIz2vDr7ic5Hd3cyMh0YTSSpkTvg
   RRyyCQYGYJr7/+TKFy/0AxkyrvlN1oRvPzkR9WkcgzttV5uCsIdmQvuGo
   NKolARgGQGRMBM54YRndQuXClEYMentRNn7rtbofTIhBOeuiIMvlh/WIg
   g==;
X-CSE-ConnectionGUID: xthK5yEpS1KFj9RqyxJ+cw==
X-CSE-MsgGUID: Op9YhN83QIa3mOJ9yqz9TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26801875"
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="26801875"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 06:03:33 -0700
X-CSE-ConnectionGUID: 919CiqpQTfyxHy7hhET0Rw==
X-CSE-MsgGUID: 94crT+MtQ+yVlEhiLKT6Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="77788543"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 29 Sep 2024 06:03:30 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sutaB-000OIZ-1y;
	Sun, 29 Sep 2024 13:03:27 +0000
Date: Sun, 29 Sep 2024 21:02:29 +0800
From: kernel test robot <lkp@intel.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private
 stack
Message-ID: <202409292026.oUij9Xvr-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-004-20240929 (https://download.01.org/0day-ci/archive/20240929/202409292026.oUij9Xvr-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409292026.oUij9Xvr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409292026.oUij9Xvr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: this_cpu_off
   >>> referenced by bpf_jit_comp.c:31 (arch/x86/net/bpf_jit_comp.c:31)
   >>>               arch/x86/net/bpf_jit_comp.o:(bpf_int_jit_compile) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

