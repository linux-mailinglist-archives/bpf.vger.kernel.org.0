Return-Path: <bpf+bounces-15498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88E7F24FD
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 06:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C919B21909
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 05:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC113AF1;
	Tue, 21 Nov 2023 05:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJZiJgJv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ED4C8
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 21:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700543217; x=1732079217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hORAHsk0+bAUiIBHj8Bzl2B12BklrzmMrZXTNlKZhJE=;
  b=bJZiJgJvDb10HWtidS20EzyN0N1XvtWryvvSxwTkS9qQ6pwWaaBtKZOE
   7RFMV5Q+h6WdXVnW9C16mDA6AcB6cJqncVQfTw4AJfXrUHFySjfM65ynt
   9wrZ9ISl7qgYOdFu2xtpFq/Wc82zmRepXaD8DVi6MTl6dWmmNIbk76TqX
   vfbHH4bj9LigNYa7wIrQ5UqjY3lND2JKQlupIhhwVNPDMfUYGgJcHVdCH
   qynUWxzA8bpH1uW8C5yar/H3MzxkahGmwRnl+JX9sg38RsV7DpW1JkNpr
   2pPlet/olypdz30Zt4SK5yxJaoP9Q2Cb7oI8UBl8J3+K8u/+ufHeu2PFf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="477970311"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="477970311"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 21:06:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="832520457"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="832520457"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Nov 2023 21:06:55 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5IyL-0007KO-0w;
	Tue, 21 Nov 2023 05:06:53 +0000
Date: Tue, 21 Nov 2023 13:06:17 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local
 storage
Message-ID: <202311211247.KBiJyddD-lkp@intel.com>
References: <20231120175925.733167-2-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120175925.733167-2-davemarchevsky@fb.com>

Hi Dave,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marchevsky/bpf-Support-BPF_F_MMAPABLE-task_local-storage/20231121-020345
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231120175925.733167-2-davemarchevsky%40fb.com
patch subject: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local storage
config: i386-buildonly-randconfig-005-20231121 (https://download.01.org/0day-ci/archive/20231121/202311211247.KBiJyddD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211247.KBiJyddD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211247.KBiJyddD-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/bpf/bpf_local_storage.o: in function `alloc_mmapable_selem_value':
   bpf_local_storage.c:(.text+0x207): undefined reference to `bpf_map_get_memcg'
   ld: kernel/bpf/bpf_local_storage.o: in function `bpf_selem_alloc':
   bpf_local_storage.c:(.text+0x410): undefined reference to `bpf_map_get_memcg'
>> ld: bpf_local_storage.c:(.text+0x543): undefined reference to `bpf_map_get_memcg'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

