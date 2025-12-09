Return-Path: <bpf+bounces-76332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B45BCAEBB6
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 03:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D070730562F4
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447FF2FE06E;
	Tue,  9 Dec 2025 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9gd5pxg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1FA2ED871
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765247042; cv=none; b=j7NivrcyaudTwZtxyFl7JpJwVOcg2jDZtB9ttwJufdTlOJhwWFOPk6FfcgNYQG3LL4ODdcrUFee2PKMyoK9Jkw1PgZn6aBNAeXstsNo+N2kkDSYJHazjjAiDuH/p35fkU51CDkt+CtbqXFQdJ52IlSHN7RtMVPbZBEqah9F+TVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765247042; c=relaxed/simple;
	bh=YOeRpcpOCXGpuYzmnuP8TGJiikKYmj+qXdLqK/SnoZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnKRprlpilcdXHm33oAXhe38e4YIDNXLsMKHCEu7FNEmN1OPCTDseGXPjpXCtg+quJvaq6ZwVDRudAj/uLRCqClCIYG/wPW6/W366tVMO9bRWqCUKIgL26qC9mqPLNaMZdv7uW4OMZrBIdDVdaqJLl8fElSfhxT1sCe4lqv2Vz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9gd5pxg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765247040; x=1796783040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOeRpcpOCXGpuYzmnuP8TGJiikKYmj+qXdLqK/SnoZ4=;
  b=U9gd5pxgVchLx0QOCwn9tV+pxVd8FASHtAdOMj21CqnPVG0o1X/odlw+
   2ajPBVb6CH/jVl8MdXveTj4u4MzZsHrgwZpOPY9vo6rZYQmtyyqbAMCUI
   fOXMhwcjw/ymqNx1EMVQHFucsTuguuDr1jvhyQ6g17PxmEERr31hjAiae
   lnjkIAvkYISf0RS7VzXeWztvQa6BT4GxqJ02MVXe9biiEBwIVMF8gYL4y
   xcLl9wG2O8vsCLLUoDHGwtVdL/kJPaOvtMSpOyA0u2MkOKJbsJ/NRFrfQ
   mBu6yhVj0B/Ed3qtokdbzNrQXz/U12OOEBZ+/5+lLh6+ZgIayJlUgLXQz
   w==;
X-CSE-ConnectionGUID: s6u6VN/1QQOOo98L/UsJyQ==
X-CSE-MsgGUID: e0gdMJv/QZOBEayYAkpDKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="78662564"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="78662564"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 18:24:00 -0800
X-CSE-ConnectionGUID: fQq71kVfQNeQLkF2wkYAkA==
X-CSE-MsgGUID: cYeyJW3ASAiyq3eybg3o0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="200543683"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Dec 2025 18:23:58 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSnOO-000000001CI-0SdF;
	Tue, 09 Dec 2025 02:23:56 +0000
Date: Tue, 9 Dec 2025 10:23:12 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next 3/8] bpf: Create inner oracle maps
Message-ID: <202512091002.b53du7lS-lkp@intel.com>
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20251209/202512091002.b53du7lS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251209/202512091002.b53du7lS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512091002.b53du7lS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/oracle.c: In function 'patch_oracle_check_insn':
>> kernel/bpf/oracle.c:137:32: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     137 |         ld_addrs[0].imm = (u32)(u64)inner_map;
         |                                ^
   kernel/bpf/oracle.c:138:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     138 |         ld_addrs[1].imm = ((u64)inner_map) >> 32;
         |                            ^


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

