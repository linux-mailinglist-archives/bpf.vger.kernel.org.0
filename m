Return-Path: <bpf+bounces-63126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9605B02BAC
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 17:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B563B173F8F
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E92D287247;
	Sat, 12 Jul 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNiVSRn2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A918D;
	Sat, 12 Jul 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752333537; cv=none; b=Zo9+i0Q7+cp5iORVbvz+Y9MNRZ/cRAvxemMXOPF2J8aQ7WK4wQVW1at2ovBNCzaoiie6p8jl2gSGRYSsLNK9y1k/Gb3U+vJ6qBxMHPiRR6BD0QbVbMCOaYOldKaAMsmgcsPJh+cFmXgwcugeYqvTon0HxTkloNkDQu/mmlJWhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752333537; c=relaxed/simple;
	bh=KccETEUF3nleLE58evAzUVKKZ5W+UHzmRlH4YxKbIdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbsgIPLjmDmaiUljROygufR+riwu3UGZnPAUljED2CmIO9YVTBBkQcD9mfYxEgl/l87LjaUW1qcjWYAvWi3ds/dp8XcyejZgAVMPHMmMfWcVAnz1B339Y9ZQm9Kc+2k1xjCd/gaYngYk7o1Ag+k1VRHVH3BqVKK4pIN9tybptU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNiVSRn2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752333536; x=1783869536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KccETEUF3nleLE58evAzUVKKZ5W+UHzmRlH4YxKbIdY=;
  b=VNiVSRn2bPpJvGBfixB4u4UIyxTKpmPjJ0HTHZdDEKk7I8V4mLPD/uuP
   a9GGqNNjJ5oq0Txmyif1tw/FZzsm9zP8c3uzWMGFzQIt1bmXxJILJKNKZ
   WuaZv7zGPSbEPe5KW6j6oZZpqLMlobOsUdLG6lIzOAxn5SLkcLUrL6BbB
   onS3MonlAYLb3o8kYU3FPoA6LRsJ8CE1DgwXK5CMkD4LnEeu4SAHo+YGM
   pJEWU8BqSxlxhMTGSBGPm/BT7nSYeek6e7b1bJdK/8g0K7T33qH82TCa7
   UinK7S8fEVFaVv4UKpXEVhcc+O80jA3/2t7MZYL+GhKpIC1aLnYnvsQpT
   g==;
X-CSE-ConnectionGUID: UTqqFfDXRTqV1J5fyCK9cg==
X-CSE-MsgGUID: kRnmQoSdRvCqc9iZyvca7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="57213077"
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="57213077"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 08:18:55 -0700
X-CSE-ConnectionGUID: U6Z05NjxQE+zNbgJbcgqJg==
X-CSE-MsgGUID: 0y371HrXTVyRIF0BKCPnLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="187559342"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Jul 2025 08:18:51 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uac01-0007Qd-1m;
	Sat, 12 Jul 2025 15:18:49 +0000
Date: Sat, 12 Jul 2025 23:18:41 +0800
From: kernel test robot <lkp@intel.com>
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, willemb@google.com, kerneljasonxing@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tao Chen <chen.dylane@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add struct bpf_token_info
Message-ID: <202507122257.0a0VYeq4-lkp@intel.com>
References: <20250711094517.931999-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711094517.931999-1-chen.dylane@linux.dev>

Hi Tao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Chen/bpf-selftests-Add-selftests-for-token-info/20250711-175057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250711094517.931999-1-chen.dylane%40linux.dev
patch subject: [PATCH bpf-next 1/2] bpf: Add struct bpf_token_info
config: csky-randconfig-r111-20250712 (https://download.01.org/0day-ci/archive/20250712/202507122257.0a0VYeq4-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce: (https://download.01.org/0day-ci/archive/20250712/202507122257.0a0VYeq4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507122257.0a0VYeq4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/token.c:104:31: sparse: sparse: symbol 'bpf_token_iops' was not declared. Should it be static?
   kernel/bpf/token.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: asm output is not an lvalue
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: generating address of non-lvalue (11)

vim +/bpf_token_iops +104 kernel/bpf/token.c

   103	
 > 104	const struct inode_operations bpf_token_iops = { };
   105	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

