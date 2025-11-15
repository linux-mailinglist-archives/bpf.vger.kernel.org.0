Return-Path: <bpf+bounces-74646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA2C6018A
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 09:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 635BB353639
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335E72550AF;
	Sat, 15 Nov 2025 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQBtd3Y/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A7A22CBF1
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763194724; cv=none; b=Mfgv9UJfMmoO5RMxOEdA16FDTc6vk8+diNdfNFIWdwp6qkD5Bj8XgQN5IFK3DWdiBFVHCU6ghe31Y+V27fe7Vq+ALrPRJKOPyZww/3kiCJXsyFh3nFfTHggTYb2IaRkdSas1nonVbXJ4yamRNh3nNL7dRppzr34Ukuijhoeeq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763194724; c=relaxed/simple;
	bh=2HRUeaBsGDwoPrdTE1QqS1um6KQUzx8WxDTHrQ6N7j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvo1jRUXTM7P0WaZ8E9xQPYBqqQdptE4O4wjj4/8W9qsEpXQOpag59oz9Dj1xl1k2mLOITnow36rjvOO6XN8fsGR6N3SINYAvddx0WbGxXeOXE18962a0mjF4JHfl+yLsuOQIijjV2Ik1jcD3YCcxxBLoUwnVW0Gng1kgXzweyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQBtd3Y/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763194721; x=1794730721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2HRUeaBsGDwoPrdTE1QqS1um6KQUzx8WxDTHrQ6N7j0=;
  b=RQBtd3Y/NH6m6lswYHw9UJjLKFc6k6xN1nnnLi/um6SBmFPvrHitKlnp
   dtvOcL+fN6VVCn4IYadn0yLjovIcW9e4WP8xu4FN5wVBFYPDczrYoyXsC
   coITUlwBEYyj1gCUasf1VUyWerRr6CIBANUrp2uO2bngD+/i8iYqmb7KF
   L4Azv5ipUDPbfpb+7yO1ybm7bdBlMpzej/cZJbHc19T2h5zWVgSxbo5Ca
   NsgLay7Ji8NUzZwp++7NGNIxIM5M/udP5Y9tUia7Q6c6aVCt0PC6TSWpF
   i6j2DyVVB4/srDS3trGRgB4YITLhZZJxuJoWbCDYIQLF+rtSofveUsRyl
   Q==;
X-CSE-ConnectionGUID: byawcvQESAmlD+eCbdUBZw==
X-CSE-MsgGUID: 5XukUgHbT+SPIhPGI92ODg==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="82908888"
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="82908888"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 00:18:41 -0800
X-CSE-ConnectionGUID: an/3oOEASjGq2L0oTjazyA==
X-CSE-MsgGUID: 6JBdaRZ4T6ODCtw7TDdMDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="190026252"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Nov 2025 00:18:39 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKBUR-0007oV-2H;
	Sat, 15 Nov 2025 08:18:35 +0000
Date: Sat, 15 Nov 2025 16:18:03 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 3/4] bpf: arena: make arena kfuncs any
 context safe
Message-ID: <202511151534.L0gsQeTi-lkp@intel.com>
References: <20251114111700.43292-4-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114111700.43292-4-puranjay@kernel.org>

Hi Puranjay,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/bpf-arena-populate-vm_area-without-allocating-memory/20251114-192509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251114111700.43292-4-puranjay%40kernel.org
patch subject: [PATCH bpf-next v2 3/4] bpf: arena: make arena kfuncs any context safe
config: xtensa-randconfig-r132-20251115 (https://download.01.org/0day-ci/archive/20251115/202511151534.L0gsQeTi-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251115/202511151534.L0gsQeTi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511151534.L0gsQeTi-lkp@intel.com/

All errors (new ones prefixed by >>):

   xtensa-linux-ld: kernel/bpf/verifier.o: in function `convert_ctx_accesses':
>> kernel/bpf/verifier.c:21986: undefined reference to `bpf_arena_free_pages_non_sleepable'


vim +21986 kernel/bpf/verifier.c

a4b1d3c1ddf6cb Jiong Wang              2019-05-24  21682  
c64b7983288e63 Joe Stringer            2018-10-02  21683  /* convert load instructions that access fields of a context type into a
c64b7983288e63 Joe Stringer            2018-10-02  21684   * sequence of instructions that access fields of the underlying structure:
c64b7983288e63 Joe Stringer            2018-10-02  21685   *     struct __sk_buff    -> struct sk_buff
c64b7983288e63 Joe Stringer            2018-10-02  21686   *     struct bpf_sock_ops -> struct sock
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21687   */
58e2af8b3a6b58 Jakub Kicinski          2016-09-21  21688  static int convert_ctx_accesses(struct bpf_verifier_env *env)
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21689  {
169c31761c8d7f Martin KaFai Lau        2024-08-29  21690  	struct bpf_subprog_info *subprogs = env->subprog_info;
00176a34d9e27a Jakub Kicinski          2017-10-16  21691  	const struct bpf_verifier_ops *ops = env->ops;
d519594ee2445d Amery Hung              2025-02-25  21692  	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
3df126f35f88dc Jakub Kicinski          2016-09-21  21693  	const int insn_cnt = env->prog->len;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21694  	struct bpf_insn *epilogue_buf = env->epilogue_buf;
6f606ffd6dd758 Martin KaFai Lau        2024-08-29  21695  	struct bpf_insn *insn_buf = env->insn_buf;
6f606ffd6dd758 Martin KaFai Lau        2024-08-29  21696  	struct bpf_insn *insn;
46f53a65d2de3e Andrey Ignatov          2018-11-10  21697  	u32 target_size, size_default, off;
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21698  	struct bpf_prog *new_prog;
d691f9e8d4405c Alexei Starovoitov      2015-06-04  21699  	enum bpf_access_type type;
f96da09473b52c Daniel Borkmann         2017-07-02  21700  	bool is_narrower_load;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21701  	int epilogue_idx = 0;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21702  
169c31761c8d7f Martin KaFai Lau        2024-08-29  21703  	if (ops->gen_epilogue) {
169c31761c8d7f Martin KaFai Lau        2024-08-29  21704  		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog,
169c31761c8d7f Martin KaFai Lau        2024-08-29  21705  						 -(subprogs[0].stack_depth + 8));
169c31761c8d7f Martin KaFai Lau        2024-08-29  21706  		if (epilogue_cnt >= INSN_BUF_SIZE) {
0df1a55afa832f Paul Chaignon           2025-07-01  21707  			verifier_bug(env, "epilogue is too long");
fd508bde5d646f Luis Gerhorst           2025-06-03  21708  			return -EFAULT;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21709  		} else if (epilogue_cnt) {
169c31761c8d7f Martin KaFai Lau        2024-08-29  21710  			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
169c31761c8d7f Martin KaFai Lau        2024-08-29  21711  			cnt = 0;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21712  			subprogs[0].stack_depth += 8;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21713  			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
169c31761c8d7f Martin KaFai Lau        2024-08-29  21714  						      -subprogs[0].stack_depth);
169c31761c8d7f Martin KaFai Lau        2024-08-29  21715  			insn_buf[cnt++] = env->prog->insnsi[0];
169c31761c8d7f Martin KaFai Lau        2024-08-29  21716  			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
169c31761c8d7f Martin KaFai Lau        2024-08-29  21717  			if (!new_prog)
169c31761c8d7f Martin KaFai Lau        2024-08-29  21718  				return -ENOMEM;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21719  			env->prog = new_prog;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21720  			delta += cnt - 1;
d519594ee2445d Amery Hung              2025-02-25  21721  
d519594ee2445d Amery Hung              2025-02-25  21722  			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
d519594ee2445d Amery Hung              2025-02-25  21723  			if (ret < 0)
d519594ee2445d Amery Hung              2025-02-25  21724  				return ret;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21725  		}
169c31761c8d7f Martin KaFai Lau        2024-08-29  21726  	}
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21727  
b09928b976280d Daniel Borkmann         2018-10-24  21728  	if (ops->gen_prologue || env->seen_direct_write) {
b09928b976280d Daniel Borkmann         2018-10-24  21729  		if (!ops->gen_prologue) {
0df1a55afa832f Paul Chaignon           2025-07-01  21730  			verifier_bug(env, "gen_prologue is null");
fd508bde5d646f Luis Gerhorst           2025-06-03  21731  			return -EFAULT;
b09928b976280d Daniel Borkmann         2018-10-24  21732  		}
36bbef52c7eb64 Daniel Borkmann         2016-09-20  21733  		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
36bbef52c7eb64 Daniel Borkmann         2016-09-20  21734  					env->prog);
6f606ffd6dd758 Martin KaFai Lau        2024-08-29  21735  		if (cnt >= INSN_BUF_SIZE) {
0df1a55afa832f Paul Chaignon           2025-07-01  21736  			verifier_bug(env, "prologue is too long");
fd508bde5d646f Luis Gerhorst           2025-06-03  21737  			return -EFAULT;
36bbef52c7eb64 Daniel Borkmann         2016-09-20  21738  		} else if (cnt) {
8041902dae5299 Alexei Starovoitov      2017-03-15  21739  			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
36bbef52c7eb64 Daniel Borkmann         2016-09-20  21740  			if (!new_prog)
36bbef52c7eb64 Daniel Borkmann         2016-09-20  21741  				return -ENOMEM;
8041902dae5299 Alexei Starovoitov      2017-03-15  21742  
36bbef52c7eb64 Daniel Borkmann         2016-09-20  21743  			env->prog = new_prog;
3df126f35f88dc Jakub Kicinski          2016-09-21  21744  			delta += cnt - 1;
d519594ee2445d Amery Hung              2025-02-25  21745  
d519594ee2445d Amery Hung              2025-02-25  21746  			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
d519594ee2445d Amery Hung              2025-02-25  21747  			if (ret < 0)
d519594ee2445d Amery Hung              2025-02-25  21748  				return ret;
36bbef52c7eb64 Daniel Borkmann         2016-09-20  21749  		}
36bbef52c7eb64 Daniel Borkmann         2016-09-20  21750  	}
36bbef52c7eb64 Daniel Borkmann         2016-09-20  21751  
d5c47719f24438 Martin KaFai Lau        2024-08-29  21752  	if (delta)
d5c47719f24438 Martin KaFai Lau        2024-08-29  21753  		WARN_ON(adjust_jmp_off(env->prog, 0, delta));
d5c47719f24438 Martin KaFai Lau        2024-08-29  21754  
9d03ebc71a027c Stanislav Fomichev      2023-01-19  21755  	if (bpf_prog_is_offloaded(env->prog->aux))
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21756  		return 0;
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21757  
3df126f35f88dc Jakub Kicinski          2016-09-21  21758  	insn = env->prog->insnsi + delta;
36bbef52c7eb64 Daniel Borkmann         2016-09-20  21759  
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21760  	for (i = 0; i < insn_cnt; i++, insn++) {
c64b7983288e63 Joe Stringer            2018-10-02  21761  		bpf_convert_ctx_access_t convert_ctx_access;
1f1e864b65554e Yonghong Song           2023-07-27  21762  		u8 mode;
c64b7983288e63 Joe Stringer            2018-10-02  21763  
d6f1c85f22534d Luis Gerhorst           2025-06-03  21764  		if (env->insn_aux_data[i + delta].nospec) {
d6f1c85f22534d Luis Gerhorst           2025-06-03  21765  			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
45e9cd38aa8df9 Yonghong Song           2025-07-03  21766  			struct bpf_insn *patch = insn_buf;
d6f1c85f22534d Luis Gerhorst           2025-06-03  21767  
45e9cd38aa8df9 Yonghong Song           2025-07-03  21768  			*patch++ = BPF_ST_NOSPEC();
45e9cd38aa8df9 Yonghong Song           2025-07-03  21769  			*patch++ = *insn;
45e9cd38aa8df9 Yonghong Song           2025-07-03  21770  			cnt = patch - insn_buf;
45e9cd38aa8df9 Yonghong Song           2025-07-03  21771  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
d6f1c85f22534d Luis Gerhorst           2025-06-03  21772  			if (!new_prog)
d6f1c85f22534d Luis Gerhorst           2025-06-03  21773  				return -ENOMEM;
d6f1c85f22534d Luis Gerhorst           2025-06-03  21774  
d6f1c85f22534d Luis Gerhorst           2025-06-03  21775  			delta    += cnt - 1;
d6f1c85f22534d Luis Gerhorst           2025-06-03  21776  			env->prog = new_prog;
d6f1c85f22534d Luis Gerhorst           2025-06-03  21777  			insn      = new_prog->insnsi + i + delta;
d6f1c85f22534d Luis Gerhorst           2025-06-03  21778  			/* This can not be easily merged with the
d6f1c85f22534d Luis Gerhorst           2025-06-03  21779  			 * nospec_result-case, because an insn may require a
d6f1c85f22534d Luis Gerhorst           2025-06-03  21780  			 * nospec before and after itself. Therefore also do not
d6f1c85f22534d Luis Gerhorst           2025-06-03  21781  			 * 'continue' here but potentially apply further
d6f1c85f22534d Luis Gerhorst           2025-06-03  21782  			 * patching to insn. *insn should equal patch[1] now.
d6f1c85f22534d Luis Gerhorst           2025-06-03  21783  			 */
d6f1c85f22534d Luis Gerhorst           2025-06-03  21784  		}
d6f1c85f22534d Luis Gerhorst           2025-06-03  21785  
62c7989b24dbd3 Daniel Borkmann         2017-01-12  21786  		if (insn->code == (BPF_LDX | BPF_MEM | BPF_B) ||
62c7989b24dbd3 Daniel Borkmann         2017-01-12  21787  		    insn->code == (BPF_LDX | BPF_MEM | BPF_H) ||
62c7989b24dbd3 Daniel Borkmann         2017-01-12  21788  		    insn->code == (BPF_LDX | BPF_MEM | BPF_W) ||
1f9a1ea821ff25 Yonghong Song           2023-07-27  21789  		    insn->code == (BPF_LDX | BPF_MEM | BPF_DW) ||
1f9a1ea821ff25 Yonghong Song           2023-07-27  21790  		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_B) ||
1f9a1ea821ff25 Yonghong Song           2023-07-27  21791  		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_H) ||
1f9a1ea821ff25 Yonghong Song           2023-07-27  21792  		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_W)) {
d691f9e8d4405c Alexei Starovoitov      2015-06-04  21793  			type = BPF_READ;
2039f26f3aca5b Daniel Borkmann         2021-07-13  21794  		} else if (insn->code == (BPF_STX | BPF_MEM | BPF_B) ||
62c7989b24dbd3 Daniel Borkmann         2017-01-12  21795  			   insn->code == (BPF_STX | BPF_MEM | BPF_H) ||
62c7989b24dbd3 Daniel Borkmann         2017-01-12  21796  			   insn->code == (BPF_STX | BPF_MEM | BPF_W) ||
2039f26f3aca5b Daniel Borkmann         2021-07-13  21797  			   insn->code == (BPF_STX | BPF_MEM | BPF_DW) ||
2039f26f3aca5b Daniel Borkmann         2021-07-13  21798  			   insn->code == (BPF_ST | BPF_MEM | BPF_B) ||
2039f26f3aca5b Daniel Borkmann         2021-07-13  21799  			   insn->code == (BPF_ST | BPF_MEM | BPF_H) ||
2039f26f3aca5b Daniel Borkmann         2021-07-13  21800  			   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
2039f26f3aca5b Daniel Borkmann         2021-07-13  21801  			   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
d691f9e8d4405c Alexei Starovoitov      2015-06-04  21802  			type = BPF_WRITE;
880442305a3908 Peilin Ye               2025-03-04  21803  		} else if ((insn->code == (BPF_STX | BPF_ATOMIC | BPF_B) ||
880442305a3908 Peilin Ye               2025-03-04  21804  			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_H) ||
880442305a3908 Peilin Ye               2025-03-04  21805  			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_W) ||
d503a04f8bc0c7 Alexei Starovoitov      2024-04-05  21806  			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_DW)) &&
d503a04f8bc0c7 Alexei Starovoitov      2024-04-05  21807  			   env->insn_aux_data[i + delta].ptr_type == PTR_TO_ARENA) {
d503a04f8bc0c7 Alexei Starovoitov      2024-04-05  21808  			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
d503a04f8bc0c7 Alexei Starovoitov      2024-04-05  21809  			env->prog->aux->num_exentries++;
d503a04f8bc0c7 Alexei Starovoitov      2024-04-05  21810  			continue;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21811  		} else if (insn->code == (BPF_JMP | BPF_EXIT) &&
169c31761c8d7f Martin KaFai Lau        2024-08-29  21812  			   epilogue_cnt &&
169c31761c8d7f Martin KaFai Lau        2024-08-29  21813  			   i + delta < subprogs[1].start) {
169c31761c8d7f Martin KaFai Lau        2024-08-29  21814  			/* Generate epilogue for the main prog */
169c31761c8d7f Martin KaFai Lau        2024-08-29  21815  			if (epilogue_idx) {
169c31761c8d7f Martin KaFai Lau        2024-08-29  21816  				/* jump back to the earlier generated epilogue */
169c31761c8d7f Martin KaFai Lau        2024-08-29  21817  				insn_buf[0] = BPF_JMP32_A(epilogue_idx - i - delta - 1);
169c31761c8d7f Martin KaFai Lau        2024-08-29  21818  				cnt = 1;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21819  			} else {
169c31761c8d7f Martin KaFai Lau        2024-08-29  21820  				memcpy(insn_buf, epilogue_buf,
169c31761c8d7f Martin KaFai Lau        2024-08-29  21821  				       epilogue_cnt * sizeof(*epilogue_buf));
169c31761c8d7f Martin KaFai Lau        2024-08-29  21822  				cnt = epilogue_cnt;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21823  				/* epilogue_idx cannot be 0. It must have at
169c31761c8d7f Martin KaFai Lau        2024-08-29  21824  				 * least one ctx ptr saving insn before the
169c31761c8d7f Martin KaFai Lau        2024-08-29  21825  				 * epilogue.
169c31761c8d7f Martin KaFai Lau        2024-08-29  21826  				 */
169c31761c8d7f Martin KaFai Lau        2024-08-29  21827  				epilogue_idx = i + delta;
169c31761c8d7f Martin KaFai Lau        2024-08-29  21828  			}
169c31761c8d7f Martin KaFai Lau        2024-08-29  21829  			goto patch_insn_buf;
2039f26f3aca5b Daniel Borkmann         2021-07-13  21830  		} else {
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21831  			continue;
2039f26f3aca5b Daniel Borkmann         2021-07-13  21832  		}
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21833  
af86ca4e3088fe Alexei Starovoitov      2018-05-15  21834  		if (type == BPF_WRITE &&
9124a4508007f1 Luis Gerhorst           2025-06-03  21835  		    env->insn_aux_data[i + delta].nospec_result) {
d6f1c85f22534d Luis Gerhorst           2025-06-03  21836  			/* nospec_result is only used to mitigate Spectre v4 and
d6f1c85f22534d Luis Gerhorst           2025-06-03  21837  			 * to limit verification-time for Spectre v1.
d6f1c85f22534d Luis Gerhorst           2025-06-03  21838  			 */
45e9cd38aa8df9 Yonghong Song           2025-07-03  21839  			struct bpf_insn *patch = insn_buf;
af86ca4e3088fe Alexei Starovoitov      2018-05-15  21840  
45e9cd38aa8df9 Yonghong Song           2025-07-03  21841  			*patch++ = *insn;
45e9cd38aa8df9 Yonghong Song           2025-07-03  21842  			*patch++ = BPF_ST_NOSPEC();
45e9cd38aa8df9 Yonghong Song           2025-07-03  21843  			cnt = patch - insn_buf;
45e9cd38aa8df9 Yonghong Song           2025-07-03  21844  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
af86ca4e3088fe Alexei Starovoitov      2018-05-15  21845  			if (!new_prog)
af86ca4e3088fe Alexei Starovoitov      2018-05-15  21846  				return -ENOMEM;
af86ca4e3088fe Alexei Starovoitov      2018-05-15  21847  
af86ca4e3088fe Alexei Starovoitov      2018-05-15  21848  			delta    += cnt - 1;
af86ca4e3088fe Alexei Starovoitov      2018-05-15  21849  			env->prog = new_prog;
af86ca4e3088fe Alexei Starovoitov      2018-05-15  21850  			insn      = new_prog->insnsi + i + delta;
af86ca4e3088fe Alexei Starovoitov      2018-05-15  21851  			continue;
af86ca4e3088fe Alexei Starovoitov      2018-05-15  21852  		}
af86ca4e3088fe Alexei Starovoitov      2018-05-15  21853  
6efe152d4061a8 Kumar Kartikeya Dwivedi 2022-04-25  21854  		switch ((int)env->insn_aux_data[i + delta].ptr_type) {
c64b7983288e63 Joe Stringer            2018-10-02  21855  		case PTR_TO_CTX:
c64b7983288e63 Joe Stringer            2018-10-02  21856  			if (!ops->convert_ctx_access)
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21857  				continue;
c64b7983288e63 Joe Stringer            2018-10-02  21858  			convert_ctx_access = ops->convert_ctx_access;
c64b7983288e63 Joe Stringer            2018-10-02  21859  			break;
c64b7983288e63 Joe Stringer            2018-10-02  21860  		case PTR_TO_SOCKET:
46f8bc92758c62 Martin KaFai Lau        2019-02-09  21861  		case PTR_TO_SOCK_COMMON:
c64b7983288e63 Joe Stringer            2018-10-02  21862  			convert_ctx_access = bpf_sock_convert_ctx_access;
c64b7983288e63 Joe Stringer            2018-10-02  21863  			break;
655a51e536c09d Martin KaFai Lau        2019-02-09  21864  		case PTR_TO_TCP_SOCK:
655a51e536c09d Martin KaFai Lau        2019-02-09  21865  			convert_ctx_access = bpf_tcp_sock_convert_ctx_access;
655a51e536c09d Martin KaFai Lau        2019-02-09  21866  			break;
fada7fdc83c0bf Jonathan Lemon          2019-06-06  21867  		case PTR_TO_XDP_SOCK:
fada7fdc83c0bf Jonathan Lemon          2019-06-06  21868  			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
fada7fdc83c0bf Jonathan Lemon          2019-06-06  21869  			break;
2a02759ef5f8a3 Alexei Starovoitov      2019-10-15  21870  		case PTR_TO_BTF_ID:
6efe152d4061a8 Kumar Kartikeya Dwivedi 2022-04-25  21871  		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
282de143ead96a Kumar Kartikeya Dwivedi 2022-11-18  21872  		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
282de143ead96a Kumar Kartikeya Dwivedi 2022-11-18  21873  		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
282de143ead96a Kumar Kartikeya Dwivedi 2022-11-18  21874  		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
282de143ead96a Kumar Kartikeya Dwivedi 2022-11-18  21875  		 * any faults for loads into such types. BPF_WRITE is disallowed
282de143ead96a Kumar Kartikeya Dwivedi 2022-11-18  21876  		 * for this case.
282de143ead96a Kumar Kartikeya Dwivedi 2022-11-18  21877  		 */
282de143ead96a Kumar Kartikeya Dwivedi 2022-11-18  21878  		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
f2362a57aefff5 Eduard Zingerman        2025-06-25  21879  		case PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED:
27ae7997a66174 Martin KaFai Lau        2020-01-08  21880  			if (type == BPF_READ) {
1f9a1ea821ff25 Yonghong Song           2023-07-27  21881  				if (BPF_MODE(insn->code) == BPF_MEM)
27ae7997a66174 Martin KaFai Lau        2020-01-08  21882  					insn->code = BPF_LDX | BPF_PROBE_MEM |
27ae7997a66174 Martin KaFai Lau        2020-01-08  21883  						     BPF_SIZE((insn)->code);
1f9a1ea821ff25 Yonghong Song           2023-07-27  21884  				else
1f9a1ea821ff25 Yonghong Song           2023-07-27  21885  					insn->code = BPF_LDX | BPF_PROBE_MEMSX |
1f9a1ea821ff25 Yonghong Song           2023-07-27  21886  						     BPF_SIZE((insn)->code);
27ae7997a66174 Martin KaFai Lau        2020-01-08  21887  				env->prog->aux->num_exentries++;
2a02759ef5f8a3 Alexei Starovoitov      2019-10-15  21888  			}
2a02759ef5f8a3 Alexei Starovoitov      2019-10-15  21889  			continue;
6082b6c328b548 Alexei Starovoitov      2024-03-07  21890  		case PTR_TO_ARENA:
6082b6c328b548 Alexei Starovoitov      2024-03-07  21891  			if (BPF_MODE(insn->code) == BPF_MEMSX) {
a91ae3c8931164 Kumar Kartikeya Dwivedi 2025-09-23  21892  				if (!bpf_jit_supports_insn(insn, true)) {
6082b6c328b548 Alexei Starovoitov      2024-03-07  21893  					verbose(env, "sign extending loads from arena are not supported yet\n");
6082b6c328b548 Alexei Starovoitov      2024-03-07  21894  					return -EOPNOTSUPP;
6082b6c328b548 Alexei Starovoitov      2024-03-07  21895  				}
a91ae3c8931164 Kumar Kartikeya Dwivedi 2025-09-23  21896  				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32SX | BPF_SIZE(insn->code);
a91ae3c8931164 Kumar Kartikeya Dwivedi 2025-09-23  21897  			} else {
6082b6c328b548 Alexei Starovoitov      2024-03-07  21898  				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32 | BPF_SIZE(insn->code);
a91ae3c8931164 Kumar Kartikeya Dwivedi 2025-09-23  21899  			}
6082b6c328b548 Alexei Starovoitov      2024-03-07  21900  			env->prog->aux->num_exentries++;
6082b6c328b548 Alexei Starovoitov      2024-03-07  21901  			continue;
c64b7983288e63 Joe Stringer            2018-10-02  21902  		default:
c64b7983288e63 Joe Stringer            2018-10-02  21903  			continue;
c64b7983288e63 Joe Stringer            2018-10-02  21904  		}
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21905  
31fd85816dbe3a Yonghong Song           2017-06-13  21906  		ctx_field_size = env->insn_aux_data[i + delta].ctx_field_size;
f96da09473b52c Daniel Borkmann         2017-07-02  21907  		size = BPF_LDST_BYTES(insn);
1f1e864b65554e Yonghong Song           2023-07-27  21908  		mode = BPF_MODE(insn->code);
31fd85816dbe3a Yonghong Song           2017-06-13  21909  
31fd85816dbe3a Yonghong Song           2017-06-13  21910  		/* If the read access is a narrower load of the field,
31fd85816dbe3a Yonghong Song           2017-06-13  21911  		 * convert to a 4/8-byte load, to minimum program type specific
31fd85816dbe3a Yonghong Song           2017-06-13  21912  		 * convert_ctx_access changes. If conversion is successful,
31fd85816dbe3a Yonghong Song           2017-06-13  21913  		 * we will apply proper mask to the result.
31fd85816dbe3a Yonghong Song           2017-06-13  21914  		 */
f96da09473b52c Daniel Borkmann         2017-07-02  21915  		is_narrower_load = size < ctx_field_size;
46f53a65d2de3e Andrey Ignatov          2018-11-10  21916  		size_default = bpf_ctx_off_adjust_machine(ctx_field_size);
46f53a65d2de3e Andrey Ignatov          2018-11-10  21917  		off = insn->off;
31fd85816dbe3a Yonghong Song           2017-06-13  21918  		if (is_narrower_load) {
f96da09473b52c Daniel Borkmann         2017-07-02  21919  			u8 size_code;
31fd85816dbe3a Yonghong Song           2017-06-13  21920  
f96da09473b52c Daniel Borkmann         2017-07-02  21921  			if (type == BPF_WRITE) {
0df1a55afa832f Paul Chaignon           2025-07-01  21922  				verifier_bug(env, "narrow ctx access misconfigured");
fd508bde5d646f Luis Gerhorst           2025-06-03  21923  				return -EFAULT;
f96da09473b52c Daniel Borkmann         2017-07-02  21924  			}
f96da09473b52c Daniel Borkmann         2017-07-02  21925  
f96da09473b52c Daniel Borkmann         2017-07-02  21926  			size_code = BPF_H;
31fd85816dbe3a Yonghong Song           2017-06-13  21927  			if (ctx_field_size == 4)
31fd85816dbe3a Yonghong Song           2017-06-13  21928  				size_code = BPF_W;
31fd85816dbe3a Yonghong Song           2017-06-13  21929  			else if (ctx_field_size == 8)
31fd85816dbe3a Yonghong Song           2017-06-13  21930  				size_code = BPF_DW;
f96da09473b52c Daniel Borkmann         2017-07-02  21931  
bc23105ca0abde Daniel Borkmann         2018-06-02  21932  			insn->off = off & ~(size_default - 1);
31fd85816dbe3a Yonghong Song           2017-06-13  21933  			insn->code = BPF_LDX | BPF_MEM | size_code;
31fd85816dbe3a Yonghong Song           2017-06-13  21934  		}
f96da09473b52c Daniel Borkmann         2017-07-02  21935  
f96da09473b52c Daniel Borkmann         2017-07-02  21936  		target_size = 0;
c64b7983288e63 Joe Stringer            2018-10-02  21937  		cnt = convert_ctx_access(type, insn, insn_buf, env->prog,
f96da09473b52c Daniel Borkmann         2017-07-02  21938  					 &target_size);
6f606ffd6dd758 Martin KaFai Lau        2024-08-29  21939  		if (cnt == 0 || cnt >= INSN_BUF_SIZE ||
f96da09473b52c Daniel Borkmann         2017-07-02  21940  		    (ctx_field_size && !target_size)) {
f914876eec9e72 Paul Chaignon           2025-08-01  21941  			verifier_bug(env, "error during ctx access conversion (%d)", cnt);
fd508bde5d646f Luis Gerhorst           2025-06-03  21942  			return -EFAULT;
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21943  		}
f96da09473b52c Daniel Borkmann         2017-07-02  21944  
f96da09473b52c Daniel Borkmann         2017-07-02  21945  		if (is_narrower_load && size < target_size) {
d895a0f16fadb2 Ilya Leoshkevich        2019-08-16  21946  			u8 shift = bpf_ctx_narrow_access_offset(
d895a0f16fadb2 Ilya Leoshkevich        2019-08-16  21947  				off, size, size_default) * 8;
6f606ffd6dd758 Martin KaFai Lau        2024-08-29  21948  			if (shift && cnt + 1 >= INSN_BUF_SIZE) {
0df1a55afa832f Paul Chaignon           2025-07-01  21949  				verifier_bug(env, "narrow ctx load misconfigured");
fd508bde5d646f Luis Gerhorst           2025-06-03  21950  				return -EFAULT;
d7af7e497f0308 Andrey Ignatov          2021-08-20  21951  			}
46f53a65d2de3e Andrey Ignatov          2018-11-10  21952  			if (ctx_field_size <= 4) {
46f53a65d2de3e Andrey Ignatov          2018-11-10  21953  				if (shift)
46f53a65d2de3e Andrey Ignatov          2018-11-10  21954  					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
46f53a65d2de3e Andrey Ignatov          2018-11-10  21955  									insn->dst_reg,
46f53a65d2de3e Andrey Ignatov          2018-11-10  21956  									shift);
31fd85816dbe3a Yonghong Song           2017-06-13  21957  				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
31fd85816dbe3a Yonghong Song           2017-06-13  21958  								(1 << size * 8) - 1);
46f53a65d2de3e Andrey Ignatov          2018-11-10  21959  			} else {
46f53a65d2de3e Andrey Ignatov          2018-11-10  21960  				if (shift)
46f53a65d2de3e Andrey Ignatov          2018-11-10  21961  					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
46f53a65d2de3e Andrey Ignatov          2018-11-10  21962  									insn->dst_reg,
46f53a65d2de3e Andrey Ignatov          2018-11-10  21963  									shift);
0613d8ca9ab382 Will Deacon             2023-05-18  21964  				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
e2f7fc0ac6957c Krzesimir Nowak         2019-05-08  21965  								(1ULL << size * 8) - 1);
31fd85816dbe3a Yonghong Song           2017-06-13  21966  			}
46f53a65d2de3e Andrey Ignatov          2018-11-10  21967  		}
1f1e864b65554e Yonghong Song           2023-07-27  21968  		if (mode == BPF_MEMSX)
1f1e864b65554e Yonghong Song           2023-07-27  21969  			insn_buf[cnt++] = BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X,
1f1e864b65554e Yonghong Song           2023-07-27  21970  						       insn->dst_reg, insn->dst_reg,
1f1e864b65554e Yonghong Song           2023-07-27  21971  						       size * 8, 0);
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21972  
169c31761c8d7f Martin KaFai Lau        2024-08-29  21973  patch_insn_buf:
8041902dae5299 Alexei Starovoitov      2017-03-15  21974  		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21975  		if (!new_prog)
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21976  			return -ENOMEM;
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21977  
3df126f35f88dc Jakub Kicinski          2016-09-21  21978  		delta += cnt - 1;
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21979  
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21980  		/* keep walking new program and skip insns we just inserted */
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21981  		env->prog = new_prog;
3df126f35f88dc Jakub Kicinski          2016-09-21  21982  		insn      = new_prog->insnsi + i + delta;
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21983  	}
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21984  
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21985  	return 0;
9bac3d6d548e5c Alexei Starovoitov      2015-03-13 @21986  }
9bac3d6d548e5c Alexei Starovoitov      2015-03-13  21987  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

