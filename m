Return-Path: <bpf+bounces-60304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3879FAD4C68
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 09:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEC31BC0125
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 07:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF32718B492;
	Wed, 11 Jun 2025 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hc6jQB9+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA82EB11
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749626229; cv=none; b=TmZ/mIClDrRJULMyP7EPhEDYGCp1eL00e672eUmeqtvzj9eZ6h5iugwFM5SKfMkVJZAjZw7Anc0RcRWuYXUmYWekyhNWX4eDyhTkS71A2zAglSSbJ3BneMD73jadMzAOdKQ2gkJxj8l6x8L0y+DFzUNdQikhvVWmqB4o9DPwOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749626229; c=relaxed/simple;
	bh=rfashLWVUaHTJVmENVwbWbGwCB40i+g/hU1l0XJfcB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi3DJCOdK1RUUACmEqFdN+MUpo0tJzUqFw4UV8+0A16wSFGMWO97tVmwu7TncSms83bzL8vK+aad6GfkPnKHYTwrCUy14nCGPsvCy44RT4noWuv4TY8/1I6aqXZtfJ0yaIsZ449cXMl1LN0IVVYyL8eC8sY33ZfOPZbQzOQvGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hc6jQB9+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749626228; x=1781162228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rfashLWVUaHTJVmENVwbWbGwCB40i+g/hU1l0XJfcB0=;
  b=Hc6jQB9+Lguix0dQ79OITSAho/UT0g5xdL5UQrPQfsEIsnTEH0DWL3/y
   uUIseFZrtCxk9M7GH71XTssCPg9fcjvKTocc35ZZfN5jZvWP1zwIT4rP2
   X+bbZ97vVOXvqo66+5Q1z04D6ogCMT3TLAdEVVIyZuvmzDB7VDtsk5DQp
   Bsc50NyXdMr3hm2wcs9ORoJxy/pHaFRudxoKdDa/65BFumiyCiMXG25+K
   nH28pnr4eiGdKIHOUzhT3LEOVwse321Jbm7ZOomZE6TnzSNx9Y+2rX3eq
   9KGPVYJahnHlpDqXo6sN3ovQHnblqL+soY/83ABV6FXdmfCob+WljrYrl
   g==;
X-CSE-ConnectionGUID: GhU4DHFlQtu/JJGE1CSf1Q==
X-CSE-MsgGUID: usoUS3g8Q2yUXTAzQ6As8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62794496"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62794496"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 00:17:08 -0700
X-CSE-ConnectionGUID: n7MYVgDcSTeZYMxaTnqn4A==
X-CSE-MsgGUID: nf4Mf7uvQWeUPp+9OnptFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152318862"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Jun 2025 00:17:04 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPFhl-000A76-2q;
	Wed, 11 Jun 2025 07:17:01 +0000
Date: Wed, 11 Jun 2025 15:16:37 +0800
From: kernel test robot <lkp@intel.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, alexei.starovoitov@gmail.com,
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org,
	martin.lau@kernel.org, ameryhung@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Save struct_ops instance pointer in
 bpf_prog_aux
Message-ID: <202506111427.2VNV9Biy-lkp@intel.com>
References: <20250609232746.1030044-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609232746.1030044-1-ameryhung@gmail.com>

Hi Amery,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Amery-Hung/bpf-Allow-verifier-to-fixup-kernel-module-kfuncs/20250610-072957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250609232746.1030044-1-ameryhung%40gmail.com
patch subject: [PATCH bpf-next v1 1/4] bpf: Save struct_ops instance pointer in bpf_prog_aux
config: x86_64-randconfig-121-20250611 (https://download.01.org/0day-ci/archive/20250611/202506111427.2VNV9Biy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250611/202506111427.2VNV9Biy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506111427.2VNV9Biy-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/bpf_struct_ops.c:824:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __rcu *__new @@     got void *[assigned] kdata @@
   kernel/bpf/bpf_struct_ops.c:824:29: sparse:     expected void [noderef] __rcu *__new
   kernel/bpf/bpf_struct_ops.c:824:29: sparse:     got void *[assigned] kdata

vim +824 kernel/bpf/bpf_struct_ops.c

   686	
   687	static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
   688						   void *value, u64 flags)
   689	{
   690		struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
   691		const struct bpf_struct_ops_desc *st_ops_desc = st_map->st_ops_desc;
   692		const struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
   693		struct bpf_struct_ops_value *uvalue, *kvalue;
   694		const struct btf_type *module_type;
   695		const struct btf_member *member;
   696		const struct btf_type *t = st_ops_desc->type;
   697		struct bpf_tramp_links *tlinks;
   698		void *udata, *kdata;
   699		int prog_fd, err;
   700		u32 i, trampoline_start, image_off = 0;
   701		void *cur_image = NULL, *image = NULL;
   702		struct bpf_link **plink;
   703		struct bpf_ksym **pksym;
   704		const char *tname, *mname;
   705	
   706		if (flags)
   707			return -EINVAL;
   708	
   709		if (st_ops->flags & ~BPF_STRUCT_OPS_FLAG_MASK)
   710			return -EINVAL;
   711	
   712		if (*(u32 *)key != 0)
   713			return -E2BIG;
   714	
   715		err = check_zero_holes(st_map->btf, st_ops_desc->value_type, value);
   716		if (err)
   717			return err;
   718	
   719		uvalue = value;
   720		err = check_zero_holes(st_map->btf, t, uvalue->data);
   721		if (err)
   722			return err;
   723	
   724		if (uvalue->common.state || refcount_read(&uvalue->common.refcnt))
   725			return -EINVAL;
   726	
   727		tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
   728		if (!tlinks)
   729			return -ENOMEM;
   730	
   731		uvalue = (struct bpf_struct_ops_value *)st_map->uvalue;
   732		kvalue = (struct bpf_struct_ops_value *)&st_map->kvalue;
   733	
   734		mutex_lock(&st_map->lock);
   735	
   736		if (kvalue->common.state != BPF_STRUCT_OPS_STATE_INIT) {
   737			err = -EBUSY;
   738			goto unlock;
   739		}
   740	
   741		memcpy(uvalue, value, map->value_size);
   742	
   743		udata = &uvalue->data;
   744		kdata = &kvalue->data;
   745	
   746		plink = st_map->links;
   747		pksym = st_map->ksyms;
   748		tname = btf_name_by_offset(st_map->btf, t->name_off);
   749		module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
   750		for_each_member(i, t, member) {
   751			const struct btf_type *mtype, *ptype;
   752			struct bpf_prog *prog;
   753			struct bpf_tramp_link *link;
   754			struct bpf_ksym *ksym;
   755			u32 moff;
   756	
   757			moff = __btf_member_bit_offset(t, member) / 8;
   758			mname = btf_name_by_offset(st_map->btf, member->name_off);
   759			ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
   760			if (ptype == module_type) {
   761				if (*(void **)(udata + moff))
   762					goto reset_unlock;
   763				*(void **)(kdata + moff) = BPF_MODULE_OWNER;
   764				continue;
   765			}
   766	
   767			err = st_ops->init_member(t, member, kdata, udata);
   768			if (err < 0)
   769				goto reset_unlock;
   770	
   771			/* The ->init_member() has handled this member */
   772			if (err > 0)
   773				continue;
   774	
   775			/* If st_ops->init_member does not handle it,
   776			 * we will only handle func ptrs and zero-ed members
   777			 * here.  Reject everything else.
   778			 */
   779	
   780			/* All non func ptr member must be 0 */
   781			if (!ptype || !btf_type_is_func_proto(ptype)) {
   782				u32 msize;
   783	
   784				mtype = btf_type_by_id(st_map->btf, member->type);
   785				mtype = btf_resolve_size(st_map->btf, mtype, &msize);
   786				if (IS_ERR(mtype)) {
   787					err = PTR_ERR(mtype);
   788					goto reset_unlock;
   789				}
   790	
   791				if (memchr_inv(udata + moff, 0, msize)) {
   792					err = -EINVAL;
   793					goto reset_unlock;
   794				}
   795	
   796				continue;
   797			}
   798	
   799			prog_fd = (int)(*(unsigned long *)(udata + moff));
   800			/* Similar check as the attr->attach_prog_fd */
   801			if (!prog_fd)
   802				continue;
   803	
   804			prog = bpf_prog_get(prog_fd);
   805			if (IS_ERR(prog)) {
   806				err = PTR_ERR(prog);
   807				goto reset_unlock;
   808			}
   809	
   810			if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
   811			    prog->aux->attach_btf_id != st_ops_desc->type_id ||
   812			    prog->expected_attach_type != i) {
   813				bpf_prog_put(prog);
   814				err = -EINVAL;
   815				goto reset_unlock;
   816			}
   817	
   818			if (st_ops->flags & BPF_STRUCT_OPS_F_THIS_PTR) {
   819				/* Make sure a struct_ops map will not have programs with
   820				 * different this_st_ops. Once a program is associated with
   821				 * a struct_ops map, it cannot be used in another struct_ops
   822				 * map also with BPF_STRUCT_OPS_F_THIS_PTR
   823				 */
 > 824				if (cmpxchg(&prog->aux->this_st_ops, NULL, kdata)) {
   825					bpf_prog_put(prog);
   826					err = -EINVAL;
   827					goto reset_unlock;
   828				}
   829			}
   830	
   831			link = kzalloc(sizeof(*link), GFP_USER);
   832			if (!link) {
   833				bpf_prog_put(prog);
   834				err = -ENOMEM;
   835				goto reset_unlock;
   836			}
   837			bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
   838				      &bpf_struct_ops_link_lops, prog);
   839			*plink++ = &link->link;
   840	
   841			ksym = kzalloc(sizeof(*ksym), GFP_USER);
   842			if (!ksym) {
   843				err = -ENOMEM;
   844				goto reset_unlock;
   845			}
   846			*pksym++ = ksym;
   847	
   848			trampoline_start = image_off;
   849			err = bpf_struct_ops_prepare_trampoline(tlinks, link,
   850							&st_ops->func_models[i],
   851							*(void **)(st_ops->cfi_stubs + moff),
   852							&image, &image_off,
   853							st_map->image_pages_cnt < MAX_TRAMP_IMAGE_PAGES);
   854			if (err)
   855				goto reset_unlock;
   856	
   857			if (cur_image != image) {
   858				st_map->image_pages[st_map->image_pages_cnt++] = image;
   859				cur_image = image;
   860				trampoline_start = 0;
   861			}
   862	
   863			*(void **)(kdata + moff) = image + trampoline_start + cfi_get_offset();
   864	
   865			/* put prog_id to udata */
   866			*(unsigned long *)(udata + moff) = prog->aux->id;
   867	
   868			/* init ksym for this trampoline */
   869			bpf_struct_ops_ksym_init(tname, mname,
   870						 image + trampoline_start,
   871						 image_off - trampoline_start,
   872						 ksym);
   873		}
   874	
   875		if (st_ops->validate) {
   876			err = st_ops->validate(kdata);
   877			if (err)
   878				goto reset_unlock;
   879		}
   880		for (i = 0; i < st_map->image_pages_cnt; i++) {
   881			err = arch_protect_bpf_trampoline(st_map->image_pages[i],
   882							  PAGE_SIZE);
   883			if (err)
   884				goto reset_unlock;
   885		}
   886	
   887		if (st_map->map.map_flags & BPF_F_LINK) {
   888			err = 0;
   889			/* Let bpf_link handle registration & unregistration.
   890			 *
   891			 * Pair with smp_load_acquire() during lookup_elem().
   892			 */
   893			smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_READY);
   894			goto unlock;
   895		}
   896	
   897		err = st_ops->reg(kdata, NULL);
   898		if (likely(!err)) {
   899			/* This refcnt increment on the map here after
   900			 * 'st_ops->reg()' is secure since the state of the
   901			 * map must be set to INIT at this moment, and thus
   902			 * bpf_struct_ops_map_delete_elem() can't unregister
   903			 * or transition it to TOBEFREE concurrently.
   904			 */
   905			bpf_map_inc(map);
   906			/* Pair with smp_load_acquire() during lookup_elem().
   907			 * It ensures the above udata updates (e.g. prog->aux->id)
   908			 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
   909			 */
   910			smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_INUSE);
   911			goto unlock;
   912		}
   913	
   914		/* Error during st_ops->reg(). Can happen if this struct_ops needs to be
   915		 * verified as a whole, after all init_member() calls. Can also happen if
   916		 * there was a race in registering the struct_ops (under the same name) to
   917		 * a sub-system through different struct_ops's maps.
   918		 */
   919	
   920	reset_unlock:
   921		bpf_struct_ops_map_free_ksyms(st_map);
   922		bpf_struct_ops_map_free_image(st_map);
   923		bpf_struct_ops_map_put_progs(st_map);
   924		if (st_ops->flags & BPF_STRUCT_OPS_F_THIS_PTR)
   925			bpf_struct_ops_map_clear_this_ptr(st_map);
   926		memset(uvalue, 0, map->value_size);
   927		memset(kvalue, 0, map->value_size);
   928	unlock:
   929		kfree(tlinks);
   930		mutex_unlock(&st_map->lock);
   931		if (!err)
   932			bpf_struct_ops_map_add_ksyms(st_map);
   933		return err;
   934	}
   935	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

