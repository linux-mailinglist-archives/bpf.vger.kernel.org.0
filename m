Return-Path: <bpf+bounces-76374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9276CB08BD
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 17:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEE1830D5CD5
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE58730102B;
	Tue,  9 Dec 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdzMbHUv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4125B311
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765297259; cv=none; b=Ycq2qLncbpOyUTUEpbC0JyaA8x+X6zga4meTrTop2SzXZdpuDUgs+ZUT4cE/GeRo3qgwQwW2in9xHjeXQiIYpcncgwMn1Lle5QexaCEmnYM21aabxYYCYkQifKcC+c0WFBb9s61j0DHXi6r40HfLiu5IQ4WPQTA2IRkqZ4OPX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765297259; c=relaxed/simple;
	bh=eFnW7p1gIUsHCCwTrxWBO2fIlQkmeC4POmm8RvAtuqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cymRfga0wenwapBBMfyu7ciNkcvgR8fUU0Uiy38tHkNvFyuddroxt7gK+Xx4gJRKTYZkE7/xsV8Q81fOJaiG7pR+51R6nuHLc8NJD4YeBHmyJjkQuPjmuIFMsfPHGxQNJ2bNirqW62GR9ccvyNNQqkVZu7vJ7M5PcX4EpEgm22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdzMbHUv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765297258; x=1796833258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eFnW7p1gIUsHCCwTrxWBO2fIlQkmeC4POmm8RvAtuqk=;
  b=QdzMbHUvgL+5b+lpVZsgVDdMhtVroIp/2t/fqIRcBDM6QTB6fV+crj5Y
   NVH2RFto/Q72ki/bhmv0+8M9I7LlVIZpvOSSUXcpX/L9kDNAuILH1JKZ9
   2G0vAxagunQq5m/eNcp2plQPkGGrhk7N9kP1lzR6CXjuQSTWlg+z5v/IR
   3db1mJ75ziZ9ijbOefgI8GOMmTytnc9oDoaUEfO1owOGOkYlZneUzBrVZ
   F9sCx1tZdiji8X0SrOYpZIuZ5mLynEJsK8iu7XCiqPbj/7YiYFpYQspyz
   XHQgfIFPYLKrySxlNMXHUi4TYZ7Cpe7sEyQzTqtcw32PhWIy8o3GepGkM
   Q==;
X-CSE-ConnectionGUID: U0oAW19gQme9JsApZcUL+Q==
X-CSE-MsgGUID: KaIs9ANwSNCZk2DZRd0KoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67427017"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="67427017"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 08:20:55 -0800
X-CSE-ConnectionGUID: Vf4C2iMHTPKon2XDfquiPQ==
X-CSE-MsgGUID: qFp6gLxwQhSHtZkDWQN4LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="200443691"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Dec 2025 08:20:52 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vT0SI-00000000217-1zNY;
	Tue, 09 Dec 2025 16:20:50 +0000
Date: Wed, 10 Dec 2025 00:20:32 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next 3/8] bpf: Create inner oracle maps
Message-ID: <202512092337.v7LrnDbF-lkp@intel.com>
References: <7229111ef814fd10cac9c3a14d38ddb0f39dc376.1765158925.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7229111ef814fd10cac9c3a14d38ddb0f39dc376.1765158925.git.paul.chaignon@gmail.com>

Hi Paul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Chaignon/bpf-Save-pruning-point-states-in-oracle/20251208-102146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/7229111ef814fd10cac9c3a14d38ddb0f39dc376.1765158925.git.paul.chaignon%40gmail.com
patch subject: [PATCH bpf-next 3/8] bpf: Create inner oracle maps
config: sparc-randconfig-r123-20251209 (https://download.01.org/0day-ci/archive/20251209/202512092337.v7LrnDbF-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251209/202512092337.v7LrnDbF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512092337.v7LrnDbF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/oracle.c:137:37: sparse: sparse: non size-preserving pointer to integer cast
   kernel/bpf/oracle.c:138:33: sparse: sparse: non size-preserving pointer to integer cast

vim +137 kernel/bpf/oracle.c

   111	
   112	struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bpf_insn *insn,
   113						 int i, int *cnt)
   114	{
   115		struct bpf_insn ld_addrs[2] = {
   116			BPF_LD_IMM64_RAW(0, BPF_PSEUDO_MAP_ORACLE, 0),
   117		};
   118		struct bpf_insn_aux_data *aux = &env->insn_aux_data[i];
   119		struct list_head *head = aux->oracle_states;
   120		struct bpf_insn *insn_buf = env->insn_buf;
   121		struct bpf_prog *new_prog = env->prog;
   122		int num_oracle_states, err;
   123		struct bpf_map *inner_map;
   124	
   125		if (env->subprog_cnt > 1)
   126			/* Skip the oracle if subprogs are used. */
   127			goto noop;
   128	
   129		num_oracle_states = list_count_nodes(head);
   130		if (!num_oracle_states)
   131			goto noop;
   132	
   133		inner_map = create_inner_oracle_map(num_oracle_states);
   134		if (IS_ERR(inner_map))
   135			return (void *)inner_map;
   136	
 > 137		ld_addrs[0].imm = (u32)(u64)inner_map;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

