Return-Path: <bpf+bounces-71223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2EEBEAC71
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447057455B7
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7432253B42;
	Fri, 17 Oct 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTgsisgR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619A3230BE9;
	Fri, 17 Oct 2025 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717169; cv=none; b=LE2xJk4Q0X5ttbnd+mF1Q1Va12WmyWTlRERBIR9dXryJnntL3TCsT/cDJ/boFatQHcbCom1v5Z7hrhMiq47T/zvyp03OC28rLK130JQgBgb4j13xsrJLcKT8PKL88/mDCSlvm1cLLnNWkj3bBIQTcX2Stjzp3wL2bq/AfgQEMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717169; c=relaxed/simple;
	bh=U883nQy7CdW8Ay8/jiRd1iRDrAdiNs0x8eaMXewRKSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izInUyUVvk4Ytid6iR8nl9uR4ES2WvExlLm4tPpDtZYaWWESSCkJWauRLcLkMotTDxB9XSFq9m4C6WDNbnexPnr6r1OR+N4Efex10ErG2mfxiBEK7gtkQwR+qej7Ri9KywFpG1oeFJIxlINYLadagl1oUtKB8WZhgrvvFo+4y3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTgsisgR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760717168; x=1792253168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U883nQy7CdW8Ay8/jiRd1iRDrAdiNs0x8eaMXewRKSo=;
  b=NTgsisgRpOJk1N41YpE7OSuXuFKsTKCsIXULlEbvXzQQbonjuHhMaypZ
   o9MgQV/l1VwxEmfpVqQPwDSbH7mEstD5y5roVBXBwmG3qVhJcrgTkxrvM
   lBm6zLwf7LLgfb6wyaanEBRKumHtqnEanoaGvvJ+c7LdUiCHgKV5MRdGx
   46x4HIt4QMPEk9I2iau5j633kw0c8OHtfjIsIzSSMmfeaFi79Bp2gE4HB
   oSA0HOVQwSaVrctQsIJd3NoVAqJWyLTLQO0HjqIoLf4ujc6W7NXFGXUB0
   uYnCm8Mit98bCK+T+7JD+a6T7yBFv7vg6Dh2bm0TAg7zgn0FXlDCtqRJG
   A==;
X-CSE-ConnectionGUID: t1X0QJY5RbKaStn0WOaeQg==
X-CSE-MsgGUID: nUc+MXVcQk+ZuGpOQ1ASeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="61960312"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="61960312"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 09:06:07 -0700
X-CSE-ConnectionGUID: d2oUwqRJQQCqA8r/JZv3Aw==
X-CSE-MsgGUID: 7IkcJ06MReGjqjP/ly1Bgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="206471088"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 17 Oct 2025 09:06:04 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9mxu-0007Fv-0b;
	Fri, 17 Oct 2025 16:06:02 +0000
Date: Sat, 18 Oct 2025 00:03:12 +0800
From: kernel test robot <lkp@intel.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org,
	ameryhung@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program
 with struct_ops
Message-ID: <202510172346.Djfrforq-lkp@intel.com>
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
config: x86_64-randconfig-161-20251017 (https://download.01.org/0day-ci/archive/20251017/202510172346.Djfrforq-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510172346.Djfrforq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510172346.Djfrforq-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/core.c: In function 'bpf_prog_free_deferred':
>> kernel/bpf/core.c:2881:17: error: implicit declaration of function 'bpf_struct_ops_put'; did you mean 'bpf_struct_ops_find'? [-Wimplicit-function-declaration]
    2881 |                 bpf_struct_ops_put(aux->st_ops_assoc);
         |                 ^~~~~~~~~~~~~~~~~~
         |                 bpf_struct_ops_find


vim +2881 kernel/bpf/core.c

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

