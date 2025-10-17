Return-Path: <bpf+bounces-71233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B6ABEAFC4
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B50D4E9A6B
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C124A2FD7AC;
	Fri, 17 Oct 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBm78Jyg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615C2FC890;
	Fri, 17 Oct 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720810; cv=none; b=tjG/JlnXd8jepj3qxL83Z1lIGTfcNHkqggTNUWGnj6LPnjlGccm0cu/8mO6NE2J9hXXIeB/tfvLfuibrJ8YJ50YiJwEOYW8gnwuyJKEpEq8S0Li19KiLMbfhIxi4sfK+7+2XnXPhW4c98SXGjo801QB7E08BvYj+zRg+cgR2Nng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720810; c=relaxed/simple;
	bh=fFTymjUFx5j8W2Wiv8exfJyD4zu50oIn71leJwSPxTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuVNtDI23XUabajt2Ovi1J1S24n20653pEi09oPwIDxMKS8aJX3KXseyidpNuQepo60koD/LTebgEKXNccQza7gmdFozbU9l3OPTUe8rDoqVM+dTwbpkmuxA0yOyECaAKy5F193nLfAqbyGlBj24wnZDdqJSBCizNL7bwq9YNtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBm78Jyg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760720808; x=1792256808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fFTymjUFx5j8W2Wiv8exfJyD4zu50oIn71leJwSPxTY=;
  b=BBm78JygNIjw6OMt12wqhhf1Y/r+hfzRTbfKvRV88ZP6VNmtyMlFBc6G
   ldqNKF23EXe1qVVHqVpgMSPpPX+oRbnP1WiDrxX5LPUO0p2u2cL/X2WQr
   Eopm5jkLe0m6znC7JEtU/aWQcgqWJ30nCUKFzB50pgG6bonVLY7KcMHNn
   400GI+PsPefZUXFazSlfakpd5mKEgnqhm9lK8bTCdVyy2kBSEwsO5ETXT
   fgR9n3ZdwlhdiYCaX0t7+DjqVqRFiRgvfzQccpOCKJIlcF5CB8PozygLQ
   RVLzls9jCqY9w0NqkjIGUKyF5kToCCtQaF4Qhk7WYlakEsRYYWi7lHbjA
   A==;
X-CSE-ConnectionGUID: b8qGTA1sRbCH3lmQy/MXHw==
X-CSE-MsgGUID: xgOUn7tnQo6xh7o1zBr8Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="65551802"
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="65551802"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 10:06:48 -0700
X-CSE-ConnectionGUID: 7lUylGYQSMmk17hPrBNpQQ==
X-CSE-MsgGUID: wRr33J/eQrGkUQc/7IrXwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="182478698"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 17 Oct 2025 10:06:45 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9nud-0007at-1U;
	Fri, 17 Oct 2025 17:06:43 +0000
Date: Sat, 18 Oct 2025 01:05:23 +0800
From: kernel test robot <lkp@intel.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org,
	martin.lau@kernel.org, ameryhung@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program
 with struct_ops
Message-ID: <202510180007.IYugtu6G-lkp@intel.com>
References: <20251016204503.3203690-3-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016204503.3203690-3-ameryhung@gmail.com>

Hi Amery,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Amery-Hung/bpf-Allow-verifier-to-fixup-kernel-module-kfuncs/20251017-044703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251016204503.3203690-3-ameryhung%40gmail.com
patch subject: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program with struct_ops
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251018/202510180007.IYugtu6G-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510180007.IYugtu6G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510180007.IYugtu6G-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/core.c:2881:3: error: call to undeclared function 'bpf_struct_ops_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2881 |                 bpf_struct_ops_put(aux->st_ops_assoc);
         |                 ^
   kernel/bpf/core.c:2881:3: note: did you mean 'bpf_struct_ops_find'?
   include/linux/btf.h:538:49: note: 'bpf_struct_ops_find' declared here
     538 | static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
         |                                                 ^
   1 error generated.


vim +/bpf_struct_ops_put +2881 kernel/bpf/core.c

  2863	
  2864	static void bpf_prog_free_deferred(struct work_struct *work)
  2865	{
  2866		struct bpf_prog_aux *aux;
  2867		int i;
  2868	
  2869		aux = container_of(work, struct bpf_prog_aux, work);
  2870	#ifdef CONFIG_BPF_SYSCALL
  2871		bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
  2872		bpf_prog_stream_free(aux->prog);
  2873	#endif
  2874	#ifdef CONFIG_CGROUP_BPF
  2875		if (aux->cgroup_atype != CGROUP_BPF_ATTACH_TYPE_INVALID)
  2876			bpf_cgroup_atype_put(aux->cgroup_atype);
  2877	#endif
  2878		bpf_free_used_maps(aux);
  2879		bpf_free_used_btfs(aux);
  2880		if (aux->st_ops_assoc) {
> 2881			bpf_struct_ops_put(aux->st_ops_assoc);
  2882			bpf_prog_disassoc_struct_ops(aux->prog);
  2883		}
  2884		if (bpf_prog_is_dev_bound(aux))
  2885			bpf_prog_dev_bound_destroy(aux->prog);
  2886	#ifdef CONFIG_PERF_EVENTS
  2887		if (aux->prog->has_callchain_buf)
  2888			put_callchain_buffers();
  2889	#endif
  2890		if (aux->dst_trampoline)
  2891			bpf_trampoline_put(aux->dst_trampoline);
  2892		for (i = 0; i < aux->real_func_cnt; i++) {
  2893			/* We can just unlink the subprog poke descriptor table as
  2894			 * it was originally linked to the main program and is also
  2895			 * released along with it.
  2896			 */
  2897			aux->func[i]->aux->poke_tab = NULL;
  2898			bpf_jit_free(aux->func[i]);
  2899		}
  2900		if (aux->real_func_cnt) {
  2901			kfree(aux->func);
  2902			bpf_prog_unlock_free(aux->prog);
  2903		} else {
  2904			bpf_jit_free(aux->prog);
  2905		}
  2906	}
  2907	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

