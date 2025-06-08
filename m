Return-Path: <bpf+bounces-60009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F00AD1263
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 15:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B37188BE67
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431821170D;
	Sun,  8 Jun 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqQWzJgj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0020487E;
	Sun,  8 Jun 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749388324; cv=none; b=qgnGdMIYFNWNAZj1ih+HMebNo3mQWpC42FbYai+PUvizW5kOlBpBpWmY+B+r76O/sDif81+trWzxH8ihPwtfwg/i9xYHC70xPylbknM0n2utJ5YNudjS6Hk6itS3QJnMVxEOFeM9U4m62QJSfjMz6CNXMQ1DWhlPjFi6HgoqIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749388324; c=relaxed/simple;
	bh=wrO1ESxuRXFSXjf9lc54DVBy2J0N2Jif+td4i4yK6ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkpn3KSccH9gWLrTrEQCj27nUu//3rzBO5xf7dqRCJ9MRr93U/kziVWXVXdWGAYPGSEg3wyACEkaoJ58iaAYAcGNj+dbJQ2QsJ0dX842EvbS53ARXzPHi6M2FMrubw/n/lQXiHsr2gb4gZs1s5H964oUF5WYpJ8aW1/n6V/AsOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqQWzJgj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749388323; x=1780924323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wrO1ESxuRXFSXjf9lc54DVBy2J0N2Jif+td4i4yK6ZU=;
  b=gqQWzJgj+UCDxX1aBg6Cu4Cq5DabUYUUevRpmBNmZE1kzXnrlgQgbaZK
   /MwEtcsi/kzgva7DUTRyqyrftwOdGD0OgZX+3skLcuok1MMpb5ao6vb6/
   KUEnBWxFKGuHypseQqIoEjsSZDkyaL2GfVeMi2qhrmKD/YAIYTlMTjZjT
   P8DGa7TYgu23baluOTq1C++3l8t2hwG4IRXxwOhHJ/48IkMvTZC8ZlOHB
   J5szrjUi6zp1+JN3DivDJgZzzIo1zh4SB/7t3gDPHBzPqJdmpzK8stmlE
   NXqO4JCqpXBM1P6KrdmIOSnc0Z11j4F4smjxqEta3JsYEt0q7yQk7QCzP
   Q==;
X-CSE-ConnectionGUID: GwDLVWC3RW+gHX2XggYqgw==
X-CSE-MsgGUID: RiXTMetITKWo2+ElTX1y7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="55268875"
X-IronPort-AV: E=Sophos;i="6.16,220,1744095600"; 
   d="scan'208";a="55268875"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 06:12:03 -0700
X-CSE-ConnectionGUID: 3f/w7udRQB64NVW1tHOILA==
X-CSE-MsgGUID: yg2Q7v47QvKVt6abiJR8dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,220,1744095600"; 
   d="scan'208";a="146788564"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Jun 2025 06:12:00 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOFoc-0006M9-12;
	Sun, 08 Jun 2025 13:11:58 +0000
Date: Sun, 8 Jun 2025 21:11:34 +0800
From: kernel test robot <lkp@intel.com>
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bboscaccy@linux.microsoft.com,
	paul@paul-moore.com, kys@microsoft.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH 07/12] bpf: Return hashes of maps in
 BPF_OBJ_GET_INFO_BY_FD
Message-ID: <202506082011.6Tejyd72-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master linus/master next-20250606]
[cannot apply to v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/bpf-Implement-an-internal-helper-for-SHA256-hashing/20250607-073052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250606232914.317094-8-kpsingh%40kernel.org
patch subject: [PATCH 07/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506082011.6Tejyd72-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> include/linux/bpf.h: crypto/sha2.h is included more than once.

vim +10 include/linux/bpf.h

     9	
  > 10	#include <crypto/sha2.h>
    11	#include <linux/workqueue.h>
    12	#include <linux/file.h>
    13	#include <linux/percpu.h>
    14	#include <linux/err.h>
    15	#include <linux/rbtree_latch.h>
    16	#include <linux/numa.h>
    17	#include <linux/mm_types.h>
    18	#include <linux/wait.h>
    19	#include <linux/refcount.h>
    20	#include <linux/mutex.h>
    21	#include <linux/module.h>
    22	#include <linux/kallsyms.h>
    23	#include <linux/capability.h>
    24	#include <linux/sched/mm.h>
    25	#include <linux/slab.h>
    26	#include <linux/percpu-refcount.h>
    27	#include <linux/stddef.h>
    28	#include <linux/bpfptr.h>
    29	#include <linux/btf.h>
    30	#include <linux/rcupdate_trace.h>
    31	#include <linux/static_call.h>
    32	#include <linux/memcontrol.h>
    33	#include <linux/cfi.h>
    34	#include <asm/rqspinlock.h>
  > 35	#include <crypto/sha2.h>
    36	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

