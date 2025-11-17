Return-Path: <bpf+bounces-74798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B03FC6627C
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 21:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 8BFA62422F
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B160336EEE;
	Mon, 17 Nov 2025 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMspME9s"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16C931B806;
	Mon, 17 Nov 2025 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412957; cv=none; b=hyI8nPYTiqqyvkQm7XB5EmpintFRrz5eW+Zr3MGhloqMj2J2oHXJ+nxVcAbZTceZkJzXlhp4eni1FB/Qc6bY+ChzR2O5dW6qLCs1BOP6mLtNlP3L21cFhW1xoYXeuJNAxxkUKKn82VwJ0rTjwnhwa5jOMmdcuEFQAOv1BXUucR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412957; c=relaxed/simple;
	bh=m5P0OzHBclwYQ7+YAhGBJVg7rUnhxb+qErrdS2VpHEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0XvSAg2ihdLp6J9SVW0tBSv79jJ0tCb9zcuW5V9LEjPJz8hJvPHa3RJZXu7qytJGAelHtETRA16nRkYgorZjZ+KMfpJvZJQMW0qCPq8AoSftjGADbMxe81zyI/VhyPwS3rOC+tRX9o7KFzL57uRb1gkd2c3SWqYtZSr+dhwqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMspME9s; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763412956; x=1794948956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m5P0OzHBclwYQ7+YAhGBJVg7rUnhxb+qErrdS2VpHEY=;
  b=VMspME9sA3me6fnNZ323mh2XowVZK60ANyx+CnHmbdrnG/m96Hr3dI6k
   WyqWFgTDOXMjVmJUh0zzvjBhFwA/Kk/odnQKMZr3A8/HgHIwLevOOn1Fb
   txPPkEWTfJvd6b4ijl/ugeZmaveFjyNmezjJx2oC98B+kzDgkuqQFtShd
   i/8IFc0xiohcQq0qmYlwSfmZri3hoHXqhyVbSWRJc+oB4xqjEv755m2/B
   L0rqLNDPqiKH9X4eWj2mB0+FPdglaYiT/GFxLIgMD0kryAUUEKlqB/Ef5
   OMs4ryL6lvSLJ4kj9lwwbOHEhTJIXaHY8pp/5RsSpkLs8aE3uTMwIOYOZ
   w==;
X-CSE-ConnectionGUID: DD6q+tgWR6eEf3BnA9YTuw==
X-CSE-MsgGUID: anE/LaGjQsKhygAGYIcM7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76885644"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="76885644"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 12:55:56 -0800
X-CSE-ConnectionGUID: N2g+eL86QUqQwnn58rmTcA==
X-CSE-MsgGUID: n0nqUYAJTJemV62oGRF00g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="195692589"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Nov 2025 12:55:51 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vL6GK-00013n-0m;
	Mon, 17 Nov 2025 20:55:48 +0000
Date: Tue, 18 Nov 2025 04:55:06 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
	rostedt@goodmis.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, jiang.biao@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 5/6] bpf: specify the old and new poke_type
 for bpf_arch_text_poke
Message-ID: <202511180431.JVOEm6SO-lkp@intel.com>
References: <20251117034906.32036-6-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117034906.32036-6-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/ftrace-introduce-FTRACE_OPS_FL_JMP/20251117-115243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251117034906.32036-6-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next v2 5/6] bpf: specify the old and new poke_type for bpf_arch_text_poke
config: powerpc64-randconfig-002-20251118 (https://download.01.org/0day-ci/archive/20251118/202511180431.JVOEm6SO-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511180431.JVOEm6SO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511180431.JVOEm6SO-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/net/bpf_jit_comp.c: In function 'bpf_arch_text_poke':
>> arch/powerpc/net/bpf_jit_comp.c:1135:7: error: 'poke_type' undeclared (first use in this function); did you mean 'probe_type'?
      if (poke_type != BPF_MOD_JUMP) {
          ^~~~~~~~~
          probe_type
   arch/powerpc/net/bpf_jit_comp.c:1135:7: note: each undeclared identifier is reported only once for each function it appears in


vim +1135 arch/powerpc/net/bpf_jit_comp.c

d243b62b7bd3d5 Naveen N Rao  2024-10-30  1070  
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1071  /*
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1072   * A 3-step process for bpf prog entry:
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1073   * 1. At bpf prog entry, a single nop/b:
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1074   * bpf_func:
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1075   *	[nop|b]	ool_stub
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1076   * 2. Out-of-line stub:
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1077   * ool_stub:
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1078   *	mflr	r0
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1079   *	[b|bl]	<bpf_prog>/<long_branch_stub>
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1080   *	mtlr	r0 // CONFIG_PPC_FTRACE_OUT_OF_LINE only
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1081   *	b	bpf_func + 4
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1082   * 3. Long branch stub:
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1083   * long_branch_stub:
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1084   *	.long	<branch_addr>/<dummy_tramp>
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1085   *	mflr	r11
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1086   *	bcl	20,31,$+4
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1087   *	mflr	r12
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1088   *	ld	r12, -16(r12)
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1089   *	mtctr	r12
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1090   *	mtlr	r11 // needed to retain ftrace ABI
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1091   *	bctr
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1092   *
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1093   * dummy_tramp is used to reduce synchronization requirements.
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1094   *
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1095   * When attaching a bpf trampoline to a bpf prog, we do not need any
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1096   * synchronization here since we always have a valid branch target regardless
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1097   * of the order in which the above stores are seen. dummy_tramp ensures that
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1098   * the long_branch stub goes to a valid destination on other cpus, even when
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1099   * the branch to the long_branch stub is seen before the updated trampoline
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1100   * address.
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1101   *
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1102   * However, when detaching a bpf trampoline from a bpf prog, or if changing
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1103   * the bpf trampoline address, we need synchronization to ensure that other
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1104   * cpus can no longer branch into the older trampoline so that it can be
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1105   * safely freed. bpf_tramp_image_put() uses rcu_tasks to ensure all cpus
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1106   * make forward progress, but we still need to ensure that other cpus
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1107   * execute isync (or some CSI) so that they don't go back into the
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1108   * trampoline again.
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1109   */
7cc5910294285d Menglong Dong 2025-11-17  1110  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
7cc5910294285d Menglong Dong 2025-11-17  1111  		       enum bpf_text_poke_type new_t, void *old_addr,
7cc5910294285d Menglong Dong 2025-11-17  1112  		       void *new_addr)
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1113  {
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1114  	unsigned long bpf_func, bpf_func_end, size, offset;
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1115  	ppc_inst_t old_inst, new_inst;
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1116  	int ret = 0, branch_flags;
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1117  	char name[KSYM_NAME_LEN];
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1118  
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1119  	if (IS_ENABLED(CONFIG_PPC32))
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1120  		return -EOPNOTSUPP;
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1121  
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1122  	bpf_func = (unsigned long)ip;
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1123  
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1124  	/* We currently only support poking bpf programs */
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1125  	if (!__bpf_address_lookup(bpf_func, &size, &offset, name)) {
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1126  		pr_err("%s (0x%lx): kernel/modules are not supported\n", __func__, bpf_func);
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1127  		return -EOPNOTSUPP;
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1128  	}
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1129  
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1130  	/*
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1131  	 * If we are not poking at bpf prog entry, then we are simply patching in/out
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1132  	 * an unconditional branch instruction at im->ip_after_call
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1133  	 */
d243b62b7bd3d5 Naveen N Rao  2024-10-30  1134  	if (offset) {
d243b62b7bd3d5 Naveen N Rao  2024-10-30 @1135  		if (poke_type != BPF_MOD_JUMP) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

