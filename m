Return-Path: <bpf+bounces-58442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B17ABA8F2
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 10:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E381BA3249
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85981DE2CF;
	Sat, 17 May 2025 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCf1TawM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306C18FDD2
	for <bpf@vger.kernel.org>; Sat, 17 May 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747471584; cv=none; b=sQwwDKqM965ia1oM9qEEFWFO40PIkP8H88GeWaNgr4Nf5hYmdtQicBbHKh+M3lvMtRb8OSQDBvCuadn0bau+sMYWT877cFER6fji0SQ6pMHH/NZ7LS1NpVduXbB5vnfxHjckkES5hW3X7P2djOdNrOGsgcggZhvXib3NRrPNfsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747471584; c=relaxed/simple;
	bh=wHgkQSozsggwC73ZHGsr2Wk1ujVsRhl93W4Fm8t6gVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKrUJob1uj+5fVfTG4VcF1afS2o2sDgpZfk8Jjbkhl9lyyWtFqF4EjeyisMtvlavm8uo6uo2FlKjZKk+foI13YsQnffYXwZUsITkD694i9EnaggREokHMgRwLXfe+q6LRlcy/1n6zJ8448wJN+os/9rtL/JJT2cA85Uo1M+7/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCf1TawM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747471582; x=1779007582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wHgkQSozsggwC73ZHGsr2Wk1ujVsRhl93W4Fm8t6gVw=;
  b=OCf1TawMFLoNQjwdTAJL9K+g5tXA58MuG5rCTPRwBhIiniitzUN3GSRi
   JsvpJhDoyF2fusLpePLYxTrmhDWvQVuytKAQPrlIy4wcW0ImcWSjnYrWe
   B+NxkFHilj5M4sBfvL+1AUAtQEtbTr+roIfu64aJOtuCNx0s+W4HEFmq5
   5JxhRijigMCJgWSb2M8i1Tajez8gxsYMltzLGmbvafgz9V26p3cFwsmZ6
   AlrJpYhZdaLjCE5jrTOt4NyXGaRIgpOEELW2F6Mcbu0QBiwrMu6EJYotk
   x53eBllbyOrmTb9LJjnk6tuLUsL0ZFiVoT73YMG9xfA0uadclkWXfc7tb
   w==;
X-CSE-ConnectionGUID: v/HPFiFXQNuauwfoBG8bjg==
X-CSE-MsgGUID: 04vN6/oTSgmB40O+0piO0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49579831"
X-IronPort-AV: E=Sophos;i="6.15,296,1739865600"; 
   d="scan'208";a="49579831"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2025 01:46:21 -0700
X-CSE-ConnectionGUID: Sw2a6q0qQfar3Gkh1UP8jg==
X-CSE-MsgGUID: YhriPRWnRKiDH/XGjmn7Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,296,1739865600"; 
   d="scan'208";a="139925722"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 May 2025 01:46:20 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGDBR-000K1z-1d;
	Sat, 17 May 2025 08:46:17 +0000
Date: Sat, 17 May 2025 16:45:49 +0800
From: kernel test robot <lkp@intel.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add a test with
 bpf_unreachable() kfunc
Message-ID: <202505171650.f5nomWW4-lkp@intel.com>
References: <20250515200640.3428248-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515200640.3428248-1-yonghong.song@linux.dev>

Hi Yonghong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/selftests-bpf-Add-a-test-with-bpf_unreachable-kfunc/20250516-040928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250515200640.3428248-1-yonghong.song%40linux.dev
patch subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add a test with bpf_unreachable() kfunc
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505171650.f5nomWW4-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> tools/testing/selftests/bpf/progs/verifier_uninit_var.c: linux/in.h is included more than once.

vim +4 tools/testing/selftests/bpf/progs/verifier_uninit_var.c

   > 4	#include <linux/in.h>
     5	#include <linux/ip.h>
     6	#include <linux/ipv6.h>
     7	#include <linux/udp.h>
     8	#include <linux/tcp.h>
     9	#include <stdbool.h>
    10	#include <linux/icmpv6.h>
  > 11	#include <linux/in.h>
    12	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

