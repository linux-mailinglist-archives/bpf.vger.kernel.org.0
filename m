Return-Path: <bpf+bounces-78790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFB0D1BDCA
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C758300462C
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DC4225403;
	Wed, 14 Jan 2026 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkIyRCOb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93D1459FA
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351744; cv=none; b=pQeXo4vFUE4M26cFICD0PMsqRhIJvWaiRpX+GREZgCg0ZaE8paNCjnZB3c1F4JEdukmUdaXlZmB2s9wlmdaGZh74WHG2MickdOixrXfVJLVQx6v7qWalBUoDsvUmbCsB4HiSFUM9VS9YsbOpQCnrGIrilyELW0CXFR8QiKPx7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351744; c=relaxed/simple;
	bh=ViXufsRZqxQh85LrDvRUXF2zt+YlRQ5QfjlXKSKwZ5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP/2qeKFpGvrajcu1dzAu5NY/9wSoyUsCPKih57quovbY7de7wXsDj/QRAHeRIpOYxtX4GwkUAqnulJl8IL+IypFXwDYmpaVGquK139MU7cpLtd5gGd6xYCqQ053L0S3BGWO4ABaV6JoMOLbk4MCxRV7l5NhGNC6CSTIFpjycoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkIyRCOb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768351742; x=1799887742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ViXufsRZqxQh85LrDvRUXF2zt+YlRQ5QfjlXKSKwZ5g=;
  b=RkIyRCObhwoMl+gnI3HtZm/38gsQxW2tLpfbi+jUc8rFEYjFIxAbhXpx
   Km4TscmczPEXGwGy2VkiOSMEy4IeXcqNaLsJ9c7ZFbY1cBCS0bfGJ04fb
   y5e8dXoFJmbQ3KgRbvyuxe1N8nkXVqj78DfG12NJX/diWi2jhEuNZZh9T
   lcwSKWjm0Vt5iXo60Sn0q2XSXZ8n8aFpTWWAT63bKFYMFJBPH+kMTozXb
   OjyfzYzkFjMhxMVg+3lXFI+pzZG66xV6nzn8gy0ZGLdFMxZVOIQ2ijEf9
   p5/ZwrW/OLV8B0PKge+gttFfyZp7DhQK1CKwIgFejXf6owbTDQCRL4FKG
   Q==;
X-CSE-ConnectionGUID: dn6sCuWlTpmHcLnJ47hY5w==
X-CSE-MsgGUID: fD0EOElETAC8jOM9nh0+mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="68654902"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="68654902"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 16:49:02 -0800
X-CSE-ConnectionGUID: CCE04uXlSSKLqEhO+iecfw==
X-CSE-MsgGUID: pDtjo18ASByQN62QNbfSCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="209583527"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Jan 2026 16:48:57 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfp4A-00000000FZQ-1RER;
	Wed, 14 Jan 2026 00:48:54 +0000
Date: Wed, 14 Jan 2026 08:48:06 +0800
From: kernel test robot <lkp@intel.com>
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com, ziye@zju.edu.cn,
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add range tracking for BPF_DIV and
 BPF_MOD
Message-ID: <202601140812.rsul8sPI-lkp@intel.com>
References: <20260113103552.3435695-2-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113103552.3435695-2-tangyazhou@zju.edu.cn>

Hi Yazhou,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yazhou-Tang/bpf-Add-range-tracking-for-BPF_DIV-and-BPF_MOD/20260113-184035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260113103552.3435695-2-tangyazhou%40zju.edu.cn
patch subject: [PATCH bpf-next v3 1/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
config: riscv-randconfig-002-20260114 (https://download.01.org/0day-ci/archive/20260114/202601140812.rsul8sPI-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601140812.rsul8sPI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601140812.rsul8sPI-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/verifier.c: In function 'adjust_scalar_min_max_vals':
>> kernel/bpf/verifier.c:15865:3: error: a label can only be part of a statement and a declaration is not a statement
   15865 |   bool changed = true;
         |   ^~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CAN_DEV
   Depends on [n]: NETDEVICES [=n] && CAN [=y]
   Selected by [y]:
   - CAN [=y] && NET [=y]


vim +15865 kernel/bpf/verifier.c

 15781	
 15782	/* WARNING: This function does calculations on 64-bit values, but the actual
 15783	 * execution may occur on 32-bit values. Therefore, things like bitshifts
 15784	 * need extra checks in the 32-bit case.
 15785	 */
 15786	static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 15787					      struct bpf_insn *insn,
 15788					      struct bpf_reg_state *dst_reg,
 15789					      struct bpf_reg_state src_reg)
 15790	{
 15791		u8 opcode = BPF_OP(insn->code);
 15792		s16 off = insn->off;
 15793		bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 15794		int ret;
 15795	
 15796		if (!is_safe_to_compute_dst_reg_range(insn, &src_reg)) {
 15797			__mark_reg_unknown(env, dst_reg);
 15798			return 0;
 15799		}
 15800	
 15801		if (sanitize_needed(opcode)) {
 15802			ret = sanitize_val_alu(env, insn);
 15803			if (ret < 0)
 15804				return sanitize_err(env, insn, ret, NULL, NULL);
 15805		}
 15806	
 15807		/* Calculate sign/unsigned bounds and tnum for alu32 and alu64 bit ops.
 15808		 * There are two classes of instructions: The first class we track both
 15809		 * alu32 and alu64 sign/unsigned bounds independently this provides the
 15810		 * greatest amount of precision when alu operations are mixed with jmp32
 15811		 * operations. These operations are BPF_ADD, BPF_SUB, BPF_MUL, BPF_ADD,
 15812		 * and BPF_OR. This is possible because these ops have fairly easy to
 15813		 * understand and calculate behavior in both 32-bit and 64-bit alu ops.
 15814		 * See alu32 verifier tests for examples. The second class of
 15815		 * operations, BPF_LSH, BPF_RSH, and BPF_ARSH, however are not so easy
 15816		 * with regards to tracking sign/unsigned bounds because the bits may
 15817		 * cross subreg boundaries in the alu64 case. When this happens we mark
 15818		 * the reg unbounded in the subreg bound space and use the resulting
 15819		 * tnum to calculate an approximation of the sign/unsigned bounds.
 15820		 */
 15821		switch (opcode) {
 15822		case BPF_ADD:
 15823			scalar32_min_max_add(dst_reg, &src_reg);
 15824			scalar_min_max_add(dst_reg, &src_reg);
 15825			dst_reg->var_off = tnum_add(dst_reg->var_off, src_reg.var_off);
 15826			break;
 15827		case BPF_SUB:
 15828			scalar32_min_max_sub(dst_reg, &src_reg);
 15829			scalar_min_max_sub(dst_reg, &src_reg);
 15830			dst_reg->var_off = tnum_sub(dst_reg->var_off, src_reg.var_off);
 15831			break;
 15832		case BPF_NEG:
 15833			env->fake_reg[0] = *dst_reg;
 15834			__mark_reg_known(dst_reg, 0);
 15835			scalar32_min_max_sub(dst_reg, &env->fake_reg[0]);
 15836			scalar_min_max_sub(dst_reg, &env->fake_reg[0]);
 15837			dst_reg->var_off = tnum_neg(env->fake_reg[0].var_off);
 15838			break;
 15839		case BPF_MUL:
 15840			dst_reg->var_off = tnum_mul(dst_reg->var_off, src_reg.var_off);
 15841			scalar32_min_max_mul(dst_reg, &src_reg);
 15842			scalar_min_max_mul(dst_reg, &src_reg);
 15843			break;
 15844		case BPF_DIV:
 15845			if (alu32) {
 15846				if (off == 1)
 15847					scalar32_min_max_sdiv(dst_reg, &src_reg);
 15848				else
 15849					scalar32_min_max_udiv(dst_reg, &src_reg);
 15850				__mark_reg64_unbounded(dst_reg);
 15851			} else {
 15852				if (off == 1)
 15853					scalar_min_max_sdiv(dst_reg, &src_reg);
 15854				else
 15855					scalar_min_max_udiv(dst_reg, &src_reg);
 15856				__mark_reg32_unbounded(dst_reg);
 15857			}
 15858			/* Since we don't have precise tnum analysis for division yet,
 15859			 * we must reset var_off to unknown to avoid inconsistency.
 15860			 * Subsequent reg_bounds_sync() will rebuild it from scalar bounds.
 15861			 */
 15862			dst_reg->var_off = tnum_unknown;
 15863			break;
 15864		case BPF_MOD:
 15865			bool changed = true;
 15866			if (alu32)
 15867				changed = (off == 1) ? scalar32_min_max_smod(dst_reg, &src_reg)
 15868							: scalar32_min_max_umod(dst_reg, &src_reg);
 15869			else
 15870				changed = (off == 1) ? scalar_min_max_smod(dst_reg, &src_reg)
 15871							: scalar_min_max_umod(dst_reg, &src_reg);
 15872			/* Similar to BPF_DIV, we need to reset var_off and 32/64 range
 15873			 * to unknown (unbounded). But if the result is equal to dividend
 15874			 * (due to special cases in BPF_MOD analysis), we can also keep
 15875			 * them unchanged.
 15876			 */
 15877			if (changed) {
 15878				if (alu32)
 15879					__mark_reg64_unbounded(dst_reg);
 15880				else
 15881					__mark_reg32_unbounded(dst_reg);
 15882				dst_reg->var_off = tnum_unknown;
 15883			}
 15884			break;
 15885		case BPF_AND:
 15886			dst_reg->var_off = tnum_and(dst_reg->var_off, src_reg.var_off);
 15887			scalar32_min_max_and(dst_reg, &src_reg);
 15888			scalar_min_max_and(dst_reg, &src_reg);
 15889			break;
 15890		case BPF_OR:
 15891			dst_reg->var_off = tnum_or(dst_reg->var_off, src_reg.var_off);
 15892			scalar32_min_max_or(dst_reg, &src_reg);
 15893			scalar_min_max_or(dst_reg, &src_reg);
 15894			break;
 15895		case BPF_XOR:
 15896			dst_reg->var_off = tnum_xor(dst_reg->var_off, src_reg.var_off);
 15897			scalar32_min_max_xor(dst_reg, &src_reg);
 15898			scalar_min_max_xor(dst_reg, &src_reg);
 15899			break;
 15900		case BPF_LSH:
 15901			if (alu32)
 15902				scalar32_min_max_lsh(dst_reg, &src_reg);
 15903			else
 15904				scalar_min_max_lsh(dst_reg, &src_reg);
 15905			break;
 15906		case BPF_RSH:
 15907			if (alu32)
 15908				scalar32_min_max_rsh(dst_reg, &src_reg);
 15909			else
 15910				scalar_min_max_rsh(dst_reg, &src_reg);
 15911			break;
 15912		case BPF_ARSH:
 15913			if (alu32)
 15914				scalar32_min_max_arsh(dst_reg, &src_reg);
 15915			else
 15916				scalar_min_max_arsh(dst_reg, &src_reg);
 15917			break;
 15918		default:
 15919			break;
 15920		}
 15921	
 15922		/* ALU32 ops are zero extended into 64bit register */
 15923		if (alu32)
 15924			zext_32_to_64(dst_reg);
 15925		reg_bounds_sync(dst_reg);
 15926		return 0;
 15927	}
 15928	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

