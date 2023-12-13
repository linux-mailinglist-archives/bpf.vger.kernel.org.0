Return-Path: <bpf+bounces-17654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D33810E28
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 11:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A662F1C20A92
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3660B224E5;
	Wed, 13 Dec 2023 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+9xJWOZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30771A5
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 02:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702462552; x=1733998552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OXsVz8JkSr4ek8h2g/jUDQEgmcN2V5v5DKuQrFzHTsc=;
  b=g+9xJWOZRImPcNdF6L5Wpk1vRgyMMT0cgDH3H7AyOKO5eNlrppl+gjGt
   4FU/v+ZNdOBxmmLmaYvktFZJpVvDOx9MZsDFReUOMVFNzCe1e8bxGuQK/
   mR3+dTW/JW2OPI7IEP6/YgYk4ojHeqRhDqvjtbiE7Wty//WrQlUJ1/qOD
   1DbeH3u75xfA75+B4b+ZTeZhmUuZGQ7L8GOVA6RO2B4XbNbxvbUxUHsCf
   BY39yhJgQ3uBLNuYAL0J7ZPKgsbtggKm1hQ9Ye/sN+nrYKP0CJlnr4ot8
   ENJmFlQbsPiWtQWKdcgXaKemyzoovMTarXhP9GdHdfZkevFTFzLmH7DNn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="459262222"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="459262222"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 02:15:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="777442934"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="777442934"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 13 Dec 2023 02:15:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDMHK-000KOh-2P;
	Wed, 13 Dec 2023 10:15:46 +0000
Date: Wed, 13 Dec 2023 18:15:35 +0800
From: kernel test robot <lkp@intel.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 4/5] bpf: Limit up to 512 bytes for
 bpf_global_percpu_ma allocation
Message-ID: <202312131731.Yh7iYbJG-lkp@intel.com>
References: <20231212223100.2138537-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212223100.2138537-1-yonghong.song@linux.dev>

Hi Yonghong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Refactor-to-have-a-memalloc-cache-destroying-function/20231213-063401
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231212223100.2138537-1-yonghong.song%40linux.dev
patch subject: [PATCH bpf-next 4/5] bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20231213/202312131731.Yh7iYbJG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312131731.Yh7iYbJG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312131731.Yh7iYbJG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/verifier.c: In function 'check_kfunc_call':
>> kernel/bpf/verifier.c:12082:115: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
   12082 |                                                 verbose(env, "bpf_percpu_obj_new type size (%d) is greater than %lu\n",
         |                                                                                                                 ~~^
         |                                                                                                                   |
         |                                                                                                                   long unsigned int
         |                                                                                                                 %u


vim +12082 kernel/bpf/verifier.c

 11885	
 11886	static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 11887				    int *insn_idx_p)
 11888	{
 11889		const struct btf_type *t, *ptr_type;
 11890		u32 i, nargs, ptr_type_id, release_ref_obj_id;
 11891		struct bpf_reg_state *regs = cur_regs(env);
 11892		const char *func_name, *ptr_type_name;
 11893		bool sleepable, rcu_lock, rcu_unlock;
 11894		struct bpf_kfunc_call_arg_meta meta;
 11895		struct bpf_insn_aux_data *insn_aux;
 11896		int err, insn_idx = *insn_idx_p;
 11897		const struct btf_param *args;
 11898		const struct btf_type *ret_t;
 11899		struct btf *desc_btf;
 11900	
 11901		/* skip for now, but return error when we find this in fixup_kfunc_call */
 11902		if (!insn->imm)
 11903			return 0;
 11904	
 11905		err = fetch_kfunc_meta(env, insn, &meta, &func_name);
 11906		if (err == -EACCES && func_name)
 11907			verbose(env, "calling kernel function %s is not allowed\n", func_name);
 11908		if (err)
 11909			return err;
 11910		desc_btf = meta.btf;
 11911		insn_aux = &env->insn_aux_data[insn_idx];
 11912	
 11913		insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
 11914	
 11915		if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
 11916			verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
 11917			return -EACCES;
 11918		}
 11919	
 11920		sleepable = is_kfunc_sleepable(&meta);
 11921		if (sleepable && !env->prog->aux->sleepable) {
 11922			verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
 11923			return -EACCES;
 11924		}
 11925	
 11926		/* Check the arguments */
 11927		err = check_kfunc_args(env, &meta, insn_idx);
 11928		if (err < 0)
 11929			return err;
 11930	
 11931		if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 11932			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 11933						 set_rbtree_add_callback_state);
 11934			if (err) {
 11935				verbose(env, "kfunc %s#%d failed callback verification\n",
 11936					func_name, meta.func_id);
 11937				return err;
 11938			}
 11939		}
 11940	
 11941		rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
 11942		rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
 11943	
 11944		if (env->cur_state->active_rcu_lock) {
 11945			struct bpf_func_state *state;
 11946			struct bpf_reg_state *reg;
 11947			u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
 11948	
 11949			if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
 11950				verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
 11951				return -EACCES;
 11952			}
 11953	
 11954			if (rcu_lock) {
 11955				verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
 11956				return -EINVAL;
 11957			} else if (rcu_unlock) {
 11958				bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
 11959					if (reg->type & MEM_RCU) {
 11960						reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
 11961						reg->type |= PTR_UNTRUSTED;
 11962					}
 11963				}));
 11964				env->cur_state->active_rcu_lock = false;
 11965			} else if (sleepable) {
 11966				verbose(env, "kernel func %s is sleepable within rcu_read_lock region\n", func_name);
 11967				return -EACCES;
 11968			}
 11969		} else if (rcu_lock) {
 11970			env->cur_state->active_rcu_lock = true;
 11971		} else if (rcu_unlock) {
 11972			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
 11973			return -EINVAL;
 11974		}
 11975	
 11976		/* In case of release function, we get register number of refcounted
 11977		 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 11978		 */
 11979		if (meta.release_regno) {
 11980			err = release_reference(env, regs[meta.release_regno].ref_obj_id);
 11981			if (err) {
 11982				verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 11983					func_name, meta.func_id);
 11984				return err;
 11985			}
 11986		}
 11987	
 11988		if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 11989		    meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 11990		    meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 11991			release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
 11992			insn_aux->insert_off = regs[BPF_REG_2].off;
 11993			insn_aux->kptr_struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
 11994			err = ref_convert_owning_non_owning(env, release_ref_obj_id);
 11995			if (err) {
 11996				verbose(env, "kfunc %s#%d conversion of owning ref to non-owning failed\n",
 11997					func_name, meta.func_id);
 11998				return err;
 11999			}
 12000	
 12001			err = release_reference(env, release_ref_obj_id);
 12002			if (err) {
 12003				verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 12004					func_name, meta.func_id);
 12005				return err;
 12006			}
 12007		}
 12008	
 12009		if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
 12010			if (!bpf_jit_supports_exceptions()) {
 12011				verbose(env, "JIT does not support calling kfunc %s#%d\n",
 12012					func_name, meta.func_id);
 12013				return -ENOTSUPP;
 12014			}
 12015			env->seen_exception = true;
 12016	
 12017			/* In the case of the default callback, the cookie value passed
 12018			 * to bpf_throw becomes the return value of the program.
 12019			 */
 12020			if (!env->exception_callback_subprog) {
 12021				err = check_return_code(env, BPF_REG_1, "R1");
 12022				if (err < 0)
 12023					return err;
 12024			}
 12025		}
 12026	
 12027		for (i = 0; i < CALLER_SAVED_REGS; i++)
 12028			mark_reg_not_init(env, regs, caller_saved[i]);
 12029	
 12030		/* Check return type */
 12031		t = btf_type_skip_modifiers(desc_btf, meta.func_proto->type, NULL);
 12032	
 12033		if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
 12034			/* Only exception is bpf_obj_new_impl */
 12035			if (meta.btf != btf_vmlinux ||
 12036			    (meta.func_id != special_kfunc_list[KF_bpf_obj_new_impl] &&
 12037			     meta.func_id != special_kfunc_list[KF_bpf_percpu_obj_new_impl] &&
 12038			     meta.func_id != special_kfunc_list[KF_bpf_refcount_acquire_impl])) {
 12039				verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
 12040				return -EINVAL;
 12041			}
 12042		}
 12043	
 12044		if (btf_type_is_scalar(t)) {
 12045			mark_reg_unknown(env, regs, BPF_REG_0);
 12046			mark_btf_func_reg_size(env, BPF_REG_0, t->size);
 12047		} else if (btf_type_is_ptr(t)) {
 12048			ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
 12049	
 12050			if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
 12051				if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
 12052				    meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 12053					struct btf_struct_meta *struct_meta;
 12054					struct btf *ret_btf;
 12055					u32 ret_btf_id;
 12056	
 12057					if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl] && !bpf_global_ma_set)
 12058						return -ENOMEM;
 12059	
 12060					if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
 12061						verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
 12062						return -EINVAL;
 12063					}
 12064	
 12065					ret_btf = env->prog->aux->btf;
 12066					ret_btf_id = meta.arg_constant.value;
 12067	
 12068					/* This may be NULL due to user not supplying a BTF */
 12069					if (!ret_btf) {
 12070						verbose(env, "bpf_obj_new/bpf_percpu_obj_new requires prog BTF\n");
 12071						return -EINVAL;
 12072					}
 12073	
 12074					ret_t = btf_type_by_id(ret_btf, ret_btf_id);
 12075					if (!ret_t || !__btf_type_is_struct(ret_t)) {
 12076						verbose(env, "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct\n");
 12077						return -EINVAL;
 12078					}
 12079	
 12080					if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 12081						if (ret_t->size > BPF_GLOBAL_PERCPU_MA_MAX_SIZE) {
 12082							verbose(env, "bpf_percpu_obj_new type size (%d) is greater than %lu\n",
 12083								ret_t->size, BPF_GLOBAL_PERCPU_MA_MAX_SIZE);
 12084							return -EINVAL;
 12085						}
 12086						mutex_lock(&bpf_percpu_ma_lock);
 12087						err = bpf_mem_alloc_percpu_unit_init(&bpf_global_percpu_ma, ret_t->size);
 12088						mutex_unlock(&bpf_percpu_ma_lock);
 12089						if (err)
 12090							return err;
 12091					}
 12092	
 12093					struct_meta = btf_find_struct_meta(ret_btf, ret_btf_id);
 12094					if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 12095						if (!__btf_type_is_scalar_struct(env, ret_btf, ret_t, 0)) {
 12096							verbose(env, "bpf_percpu_obj_new type ID argument must be of a struct of scalars\n");
 12097							return -EINVAL;
 12098						}
 12099	
 12100						if (struct_meta) {
 12101							verbose(env, "bpf_percpu_obj_new type ID argument must not contain special fields\n");
 12102							return -EINVAL;
 12103						}
 12104					}
 12105	
 12106					mark_reg_known_zero(env, regs, BPF_REG_0);
 12107					regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
 12108					regs[BPF_REG_0].btf = ret_btf;
 12109					regs[BPF_REG_0].btf_id = ret_btf_id;
 12110					if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl])
 12111						regs[BPF_REG_0].type |= MEM_PERCPU;
 12112	
 12113					insn_aux->obj_new_size = ret_t->size;
 12114					insn_aux->kptr_struct_meta = struct_meta;
 12115				} else if (meta.func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl]) {
 12116					mark_reg_known_zero(env, regs, BPF_REG_0);
 12117					regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
 12118					regs[BPF_REG_0].btf = meta.arg_btf;
 12119					regs[BPF_REG_0].btf_id = meta.arg_btf_id;
 12120	
 12121					insn_aux->kptr_struct_meta =
 12122						btf_find_struct_meta(meta.arg_btf,
 12123								     meta.arg_btf_id);
 12124				} else if (meta.func_id == special_kfunc_list[KF_bpf_list_pop_front] ||
 12125					   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
 12126					struct btf_field *field = meta.arg_list_head.field;
 12127	
 12128					mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
 12129				} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
 12130					   meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
 12131					struct btf_field *field = meta.arg_rbtree_root.field;
 12132	
 12133					mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
 12134				} else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
 12135					mark_reg_known_zero(env, regs, BPF_REG_0);
 12136					regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
 12137					regs[BPF_REG_0].btf = desc_btf;
 12138					regs[BPF_REG_0].btf_id = meta.ret_btf_id;
 12139				} else if (meta.func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 12140					ret_t = btf_type_by_id(desc_btf, meta.arg_constant.value);
 12141					if (!ret_t || !btf_type_is_struct(ret_t)) {
 12142						verbose(env,
 12143							"kfunc bpf_rdonly_cast type ID argument must be of a struct\n");
 12144						return -EINVAL;
 12145					}
 12146	
 12147					mark_reg_known_zero(env, regs, BPF_REG_0);
 12148					regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_UNTRUSTED;
 12149					regs[BPF_REG_0].btf = desc_btf;
 12150					regs[BPF_REG_0].btf_id = meta.arg_constant.value;
 12151				} else if (meta.func_id == special_kfunc_list[KF_bpf_dynptr_slice] ||
 12152					   meta.func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
 12153					enum bpf_type_flag type_flag = get_dynptr_type_flag(meta.initialized_dynptr.type);
 12154	
 12155					mark_reg_known_zero(env, regs, BPF_REG_0);
 12156	
 12157					if (!meta.arg_constant.found) {
 12158						verbose(env, "verifier internal error: bpf_dynptr_slice(_rdwr) no constant size\n");
 12159						return -EFAULT;
 12160					}
 12161	
 12162					regs[BPF_REG_0].mem_size = meta.arg_constant.value;
 12163	
 12164					/* PTR_MAYBE_NULL will be added when is_kfunc_ret_null is checked */
 12165					regs[BPF_REG_0].type = PTR_TO_MEM | type_flag;
 12166	
 12167					if (meta.func_id == special_kfunc_list[KF_bpf_dynptr_slice]) {
 12168						regs[BPF_REG_0].type |= MEM_RDONLY;
 12169					} else {
 12170						/* this will set env->seen_direct_write to true */
 12171						if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE)) {
 12172							verbose(env, "the prog does not allow writes to packet data\n");
 12173							return -EINVAL;
 12174						}
 12175					}
 12176	
 12177					if (!meta.initialized_dynptr.id) {
 12178						verbose(env, "verifier internal error: no dynptr id\n");
 12179						return -EFAULT;
 12180					}
 12181					regs[BPF_REG_0].dynptr_id = meta.initialized_dynptr.id;
 12182	
 12183					/* we don't need to set BPF_REG_0's ref obj id
 12184					 * because packet slices are not refcounted (see
 12185					 * dynptr_type_refcounted)
 12186					 */
 12187				} else {
 12188					verbose(env, "kernel function %s unhandled dynamic return type\n",
 12189						meta.func_name);
 12190					return -EFAULT;
 12191				}
 12192			} else if (!__btf_type_is_struct(ptr_type)) {
 12193				if (!meta.r0_size) {
 12194					__u32 sz;
 12195	
 12196					if (!IS_ERR(btf_resolve_size(desc_btf, ptr_type, &sz))) {
 12197						meta.r0_size = sz;
 12198						meta.r0_rdonly = true;
 12199					}
 12200				}
 12201				if (!meta.r0_size) {
 12202					ptr_type_name = btf_name_by_offset(desc_btf,
 12203									   ptr_type->name_off);
 12204					verbose(env,
 12205						"kernel function %s returns pointer type %s %s is not supported\n",
 12206						func_name,
 12207						btf_type_str(ptr_type),
 12208						ptr_type_name);
 12209					return -EINVAL;
 12210				}
 12211	
 12212				mark_reg_known_zero(env, regs, BPF_REG_0);
 12213				regs[BPF_REG_0].type = PTR_TO_MEM;
 12214				regs[BPF_REG_0].mem_size = meta.r0_size;
 12215	
 12216				if (meta.r0_rdonly)
 12217					regs[BPF_REG_0].type |= MEM_RDONLY;
 12218	
 12219				/* Ensures we don't access the memory after a release_reference() */
 12220				if (meta.ref_obj_id)
 12221					regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 12222			} else {
 12223				mark_reg_known_zero(env, regs, BPF_REG_0);
 12224				regs[BPF_REG_0].btf = desc_btf;
 12225				regs[BPF_REG_0].type = PTR_TO_BTF_ID;
 12226				regs[BPF_REG_0].btf_id = ptr_type_id;
 12227			}
 12228	
 12229			if (is_kfunc_ret_null(&meta)) {
 12230				regs[BPF_REG_0].type |= PTR_MAYBE_NULL;
 12231				/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
 12232				regs[BPF_REG_0].id = ++env->id_gen;
 12233			}
 12234			mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 12235			if (is_kfunc_acquire(&meta)) {
 12236				int id = acquire_reference_state(env, insn_idx);
 12237	
 12238				if (id < 0)
 12239					return id;
 12240				if (is_kfunc_ret_null(&meta))
 12241					regs[BPF_REG_0].id = id;
 12242				regs[BPF_REG_0].ref_obj_id = id;
 12243			} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
 12244				ref_set_non_owning(env, &regs[BPF_REG_0]);
 12245			}
 12246	
 12247			if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
 12248				regs[BPF_REG_0].id = ++env->id_gen;
 12249		} else if (btf_type_is_void(t)) {
 12250			if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
 12251				if (meta.func_id == special_kfunc_list[KF_bpf_obj_drop_impl] ||
 12252				    meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_drop_impl]) {
 12253					insn_aux->kptr_struct_meta =
 12254						btf_find_struct_meta(meta.arg_btf,
 12255								     meta.arg_btf_id);
 12256				}
 12257			}
 12258		}
 12259	
 12260		nargs = btf_type_vlen(meta.func_proto);
 12261		args = (const struct btf_param *)(meta.func_proto + 1);
 12262		for (i = 0; i < nargs; i++) {
 12263			u32 regno = i + 1;
 12264	
 12265			t = btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
 12266			if (btf_type_is_ptr(t))
 12267				mark_btf_func_reg_size(env, regno, sizeof(void *));
 12268			else
 12269				/* scalar. ensured by btf_check_kfunc_arg_match() */
 12270				mark_btf_func_reg_size(env, regno, t->size);
 12271		}
 12272	
 12273		if (is_iter_next_kfunc(&meta)) {
 12274			err = process_iter_next_call(env, insn_idx, &meta);
 12275			if (err)
 12276				return err;
 12277		}
 12278	
 12279		return 0;
 12280	}
 12281	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

