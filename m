Return-Path: <bpf+bounces-66364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90323B3279D
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 10:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DADA1C80D01
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2264F2367CE;
	Sat, 23 Aug 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkJhiFb3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E888230BDF
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755937503; cv=none; b=X9VSsOI5hoZlVAV+0wdxKoMQYxfb3EIzwEDIP2fesJ6DYOXyoLvAOy3V3Zly/jkXCszXLOB5NAFjpA704sTQAqrwhUMwQylnsvoM+3Q8CK/xto6rQ513+zrjScJzDVTFuZKWrBsFSqgy8JsC6npllrf4oMnGv2zpVFVyVeFJ7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755937503; c=relaxed/simple;
	bh=Tj0MwpjrmkDMyN/PejBxX20UwcXdoevREPgcIBHxocw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slbFt7oV3xa7ACafovr8zGFX3EA+o1pb/8y6/Bf5HqDwFC9G/eVa82cXWmq3NJNBdW4f+kenLrITM2mY4GB6VrA4F6VBEDXewK2CXBiDUqTPLHYBoYlV2LTeNzYpb/erwdpHG6SMn0D8zGfRPNvUJfRfU/4+yoPMShoQSrOJqjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkJhiFb3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755937501; x=1787473501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tj0MwpjrmkDMyN/PejBxX20UwcXdoevREPgcIBHxocw=;
  b=UkJhiFb31DzllSZHlh1+TjykWrkyk1u22gILwKzOEA19BGD0UZl2s7Tv
   RaQi72mesGNPoOlgUSmK18IJUaTvel54fod8iG3cR5BF7lfpK99j5upwM
   /m3LB+L0CefmcZxvjG3ptzAdeA9Lie6AkuMAFi6AkgvZZHi1RA49G1T05
   vRxsmE0roiENHSsvRg3sE0+aIbHvAh7VPUah0+pAkp8zY7Yi2vGFELM8+
   cDM7NhaErwRH4lmUMzk31o3OYpmTRtwv4srlZ2fRJvOCYpjQBknEvY/mt
   kmCMxPjia8SpdDa0atpQXIb1K8L712GX6nrlh67bXf1w5xs3Oue10O/7f
   A==;
X-CSE-ConnectionGUID: jxH2UDFZSOmxWib25Q/7rw==
X-CSE-MsgGUID: 7gwnXOfcTtuCt/5Ijfezhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="83643423"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="83643423"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 01:25:01 -0700
X-CSE-ConnectionGUID: 8o24JJgYSluZL43/Sq7Z/A==
X-CSE-MsgGUID: 2Oj2ieQ5T9mWbxQYuIQiHA==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 23 Aug 2025 01:24:58 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upjYJ-000MCV-2j;
	Sat, 23 Aug 2025 08:24:49 +0000
Date: Sat, 23 Aug 2025 16:24:07 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_in_interrupt kfunc
Message-ID: <202508231629.nrRSoIUD-lkp@intel.com>
References: <20250822141722.25318-2-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822141722.25318-2-leon.hwang@linux.dev>

Hi Leon,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Introduce-bpf_in_interrupt-kfunc/20250822-222727
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250822141722.25318-2-leon.hwang%40linux.dev
patch subject: [PATCH bpf-next 1/2] bpf: Introduce bpf_in_interrupt kfunc
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20250823/202508231629.nrRSoIUD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250823/202508231629.nrRSoIUD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508231629.nrRSoIUD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bpf_verifier.h:9,
                    from kernel/bpf/verifier.c:13:
   kernel/bpf/verifier.c: In function 'fixup_kfunc_call':
>> kernel/bpf/verifier.c:21980:77: error: '__preempt_count' undeclared (first use in this function); did you mean 'preempt_count'?
   21980 |                 insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&__preempt_count);
         |                                                                             ^~~~~~~~~~~~~~~
   include/linux/filter.h:211:26: note: in definition of macro 'BPF_MOV64_IMM'
     211 |                 .imm   = IMM })
         |                          ^~~
   kernel/bpf/verifier.c:21980:77: note: each undeclared identifier is reported only once for each function it appears in
   21980 |                 insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&__preempt_count);
         |                                                                             ^~~~~~~~~~~~~~~
   include/linux/filter.h:211:26: note: in definition of macro 'BPF_MOV64_IMM'
     211 |                 .imm   = IMM })
         |                          ^~~


vim +21980 kernel/bpf/verifier.c

 21885	
 21886	static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 21887				    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 21888	{
 21889		const struct bpf_kfunc_desc *desc;
 21890	
 21891		if (!insn->imm) {
 21892			verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
 21893			return -EINVAL;
 21894		}
 21895	
 21896		*cnt = 0;
 21897	
 21898		/* insn->imm has the btf func_id. Replace it with an offset relative to
 21899		 * __bpf_call_base, unless the JIT needs to call functions that are
 21900		 * further than 32 bits away (bpf_jit_supports_far_kfunc_call()).
 21901		 */
 21902		desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
 21903		if (!desc) {
 21904			verifier_bug(env, "kernel function descriptor not found for func_id %u",
 21905				     insn->imm);
 21906			return -EFAULT;
 21907		}
 21908	
 21909		if (!bpf_jit_supports_far_kfunc_call())
 21910			insn->imm = BPF_CALL_IMM(desc->addr);
 21911		if (insn->off)
 21912			return 0;
 21913		if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
 21914		    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 21915			struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
 21916			struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
 21917			u64 obj_new_size = env->insn_aux_data[insn_idx].obj_new_size;
 21918	
 21919			if (desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl] && kptr_struct_meta) {
 21920				verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
 21921					     insn_idx);
 21922				return -EFAULT;
 21923			}
 21924	
 21925			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_1, obj_new_size);
 21926			insn_buf[1] = addr[0];
 21927			insn_buf[2] = addr[1];
 21928			insn_buf[3] = *insn;
 21929			*cnt = 4;
 21930		} else if (desc->func_id == special_kfunc_list[KF_bpf_obj_drop_impl] ||
 21931			   desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl] ||
 21932			   desc->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl]) {
 21933			struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
 21934			struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
 21935	
 21936			if (desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl] && kptr_struct_meta) {
 21937				verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
 21938					     insn_idx);
 21939				return -EFAULT;
 21940			}
 21941	
 21942			if (desc->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&
 21943			    !kptr_struct_meta) {
 21944				verifier_bug(env, "kptr_struct_meta expected at insn_idx %d",
 21945					     insn_idx);
 21946				return -EFAULT;
 21947			}
 21948	
 21949			insn_buf[0] = addr[0];
 21950			insn_buf[1] = addr[1];
 21951			insn_buf[2] = *insn;
 21952			*cnt = 3;
 21953		} else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 21954			   desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 21955			   desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 21956			struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
 21957			int struct_meta_reg = BPF_REG_3;
 21958			int node_offset_reg = BPF_REG_4;
 21959	
 21960			/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
 21961			if (desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 21962				struct_meta_reg = BPF_REG_4;
 21963				node_offset_reg = BPF_REG_5;
 21964			}
 21965	
 21966			if (!kptr_struct_meta) {
 21967				verifier_bug(env, "kptr_struct_meta expected at insn_idx %d",
 21968					     insn_idx);
 21969				return -EFAULT;
 21970			}
 21971	
 21972			__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
 21973							node_offset_reg, insn, insn_buf, cnt);
 21974		} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
 21975			   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 21976			insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 21977			*cnt = 1;
 21978		} else if (desc->func_id == special_kfunc_list[KF_bpf_in_interrupt]) {
 21979	#ifdef CONFIG_X86_64
 21980			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&__preempt_count);
 21981			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 21982			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
 21983			insn_buf[3] = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, NMI_MASK | HARDIRQ_MASK |
 21984						    (IS_ENABLED(CONFIG_PREEMPT_RT) ? 0 : SOFTIRQ_MASK));
 21985			*cnt = 4;
 21986	#endif
 21987		}
 21988	
 21989		if (env->insn_aux_data[insn_idx].arg_prog) {
 21990			u32 regno = env->insn_aux_data[insn_idx].arg_prog;
 21991			struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(regno, (long)env->prog->aux) };
 21992			int idx = *cnt;
 21993	
 21994			insn_buf[idx++] = ld_addrs[0];
 21995			insn_buf[idx++] = ld_addrs[1];
 21996			insn_buf[idx++] = *insn;
 21997			*cnt = idx;
 21998		}
 21999		return 0;
 22000	}
 22001	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

