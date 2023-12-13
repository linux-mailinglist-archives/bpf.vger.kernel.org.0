Return-Path: <bpf+bounces-17684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18726811ACE
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69CD2B2112D
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1210954BEF;
	Wed, 13 Dec 2023 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o34PlFeP"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E67C9
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:21:08 -0800 (PST)
Message-ID: <7aaee542-78e9-4b6b-a2ee-1f47d431f8e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702488066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+/o6LAnz0WQvUU6i1ydt6wPeU/5JU5d/nnHSS3qmgc=;
	b=o34PlFePXQeFg5dCRsgB83QX1wPMRGms/HqjmoaUXsqR6O3NyEeqFtaVC6g5oOVUeXIZGL
	ws/+qamOeed2QyoUfRBiF48l0cYe2EBtpFxV9TzjFSi++TVkyjqSM0hWqeC0MhC/7nTqai
	Bk5Do63sE+iQXDimsaKn7RusKmxpUu4=
Date: Wed, 13 Dec 2023 09:20:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/5] bpf: Limit up to 512 bytes for
 bpf_global_percpu_ma allocation
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231212223100.2138537-1-yonghong.song@linux.dev>
 <202312131731.Yh7iYbJG-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <202312131731.Yh7iYbJG-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/13/23 2:15 AM, kernel test robot wrote:
> Hi Yonghong,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Refactor-to-have-a-memalloc-cache-destroying-function/20231213-063401
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20231212223100.2138537-1-yonghong.song%40linux.dev
> patch subject: [PATCH bpf-next 4/5] bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
> config: m68k-defconfig (https://download.01.org/0day-ci/archive/20231213/202312131731.Yh7iYbJG-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312131731.Yh7iYbJG-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312131731.Yh7iYbJG-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>     kernel/bpf/verifier.c: In function 'check_kfunc_call':
>>> kernel/bpf/verifier.c:12082:115: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
>     12082 |                                                 verbose(env, "bpf_percpu_obj_new type size (%d) is greater than %lu\n",
>           |                                                                                                                 ~~^
>           |                                                                                                                   |
>           |                                                                                                                   long unsigned int
>           |                                                                                                                 %u
>
>
> vim +12082 kernel/bpf/verifier.c

Okay, seems '%lu' not portable. Will fix with '%zu' if the code roughly stay the same in the next revision.

>
>   11885	
>   11886	static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   11887				    int *insn_idx_p)
>   11888	{
>   11889		const struct btf_type *t, *ptr_type;
>   11890		u32 i, nargs, ptr_type_id, release_ref_obj_id;
>   11891		struct bpf_reg_state *regs = cur_regs(env);
>   11892		const char *func_name, *ptr_type_name;
>   11893		bool sleepable, rcu_lock, rcu_unlock;
>   11894		struct bpf_kfunc_call_arg_meta meta;
>   11895		struct bpf_insn_aux_data *insn_aux;
>   11896		int err, insn_idx = *insn_idx_p;
>   11897		const struct btf_param *args;
>   11898		const struct btf_type *ret_t;
>   11899		struct btf *desc_btf;
>   11900	
>   11901		/* skip for now, but return error when we find this in fixup_kfunc_call */
>   11902		if (!insn->imm)
>   11903			return 0;
>   11904	
>   11905		err = fetch_kfunc_meta(env, insn, &meta, &func_name);
>   11906		if (err == -EACCES && func_name)
>   11907			verbose(env, "calling kernel function %s is not allowed\n", func_name);
>   11908		if (err)
>   11909			return err;
>   11910		desc_btf = meta.btf;
>   11911		insn_aux = &env->insn_aux_data[insn_idx];
>   11912	
>   11913		insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
>   11914	
>   11915		if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
>   11916			verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
>   11917			return -EACCES;
>   11918		}
>   11919	
>   11920		sleepable = is_kfunc_sleepable(&meta);
>   11921		if (sleepable && !env->prog->aux->sleepable) {
>   11922			verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
>   11923			return -EACCES;
>   11924		}
>   11925	
>   11926		/* Check the arguments */
>   11927		err = check_kfunc_args(env, &meta, insn_idx);
>   11928		if (err < 0)
>   11929			return err;
>   11930	
>   11931		if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>   11932			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
>   11933						 set_rbtree_add_callback_state);
>   11934			if (err) {
>   11935				verbose(env, "kfunc %s#%d failed callback verification\n",
>   11936					func_name, meta.func_id);
>   11937				return err;
>   11938			}
>   11939		}
>   11940	
>   11941		rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
>   11942		rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
>   11943	
>   11944		if (env->cur_state->active_rcu_lock) {
>   11945			struct bpf_func_state *state;
>   11946			struct bpf_reg_state *reg;
>   11947			u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
>   11948	
>   11949			if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
>   11950				verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
>   11951				return -EACCES;
>   11952			}
>   11953	
>   11954			if (rcu_lock) {
>   11955				verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
>   11956				return -EINVAL;
>   11957			} else if (rcu_unlock) {
>   11958				bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
>   11959					if (reg->type & MEM_RCU) {
>   11960						reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
>   11961						reg->type |= PTR_UNTRUSTED;
>   11962					}
>   11963				}));
>   11964				env->cur_state->active_rcu_lock = false;
>   11965			} else if (sleepable) {
>   11966				verbose(env, "kernel func %s is sleepable within rcu_read_lock region\n", func_name);
>   11967				return -EACCES;
>   11968			}
>   11969		} else if (rcu_lock) {
>   11970			env->cur_state->active_rcu_lock = true;
>   11971		} else if (rcu_unlock) {
>   11972			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
>   11973			return -EINVAL;
>   11974		}
>   11975	
>   11976		/* In case of release function, we get register number of refcounted
>   11977		 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
>   11978		 */
>   11979		if (meta.release_regno) {
>   11980			err = release_reference(env, regs[meta.release_regno].ref_obj_id);
>   11981			if (err) {
>   11982				verbose(env, "kfunc %s#%d reference has not been acquired before\n",
>   11983					func_name, meta.func_id);
>   11984				return err;
>   11985			}
>   11986		}
>   11987	
>   11988		if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>   11989		    meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>   11990		    meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>   11991			release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
>   11992			insn_aux->insert_off = regs[BPF_REG_2].off;
>   11993			insn_aux->kptr_struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
>   11994			err = ref_convert_owning_non_owning(env, release_ref_obj_id);
>   11995			if (err) {
>   11996				verbose(env, "kfunc %s#%d conversion of owning ref to non-owning failed\n",
>   11997					func_name, meta.func_id);
>   11998				return err;
>   11999			}
>   12000	
>   12001			err = release_reference(env, release_ref_obj_id);
>   12002			if (err) {
>   12003				verbose(env, "kfunc %s#%d reference has not been acquired before\n",
>   12004					func_name, meta.func_id);
>   12005				return err;
>   12006			}
>   12007		}
>   12008	
>   12009		if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
>   12010			if (!bpf_jit_supports_exceptions()) {
>   12011				verbose(env, "JIT does not support calling kfunc %s#%d\n",
>   12012					func_name, meta.func_id);
>   12013				return -ENOTSUPP;
>   12014			}
>   12015			env->seen_exception = true;
>   12016	
>   12017			/* In the case of the default callback, the cookie value passed
>   12018			 * to bpf_throw becomes the return value of the program.
>   12019			 */
>   12020			if (!env->exception_callback_subprog) {
>   12021				err = check_return_code(env, BPF_REG_1, "R1");
>   12022				if (err < 0)
>   12023					return err;
>   12024			}
>   12025		}
>   12026	
>   12027		for (i = 0; i < CALLER_SAVED_REGS; i++)
>   12028			mark_reg_not_init(env, regs, caller_saved[i]);
>   12029	
>   12030		/* Check return type */
>   12031		t = btf_type_skip_modifiers(desc_btf, meta.func_proto->type, NULL);
>   12032	
>   12033		if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
>   12034			/* Only exception is bpf_obj_new_impl */
>   12035			if (meta.btf != btf_vmlinux ||
>   12036			    (meta.func_id != special_kfunc_list[KF_bpf_obj_new_impl] &&
>   12037			     meta.func_id != special_kfunc_list[KF_bpf_percpu_obj_new_impl] &&
>   12038			     meta.func_id != special_kfunc_list[KF_bpf_refcount_acquire_impl])) {
>   12039				verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
>   12040				return -EINVAL;
>   12041			}
>   12042		}
>   12043	
>   12044		if (btf_type_is_scalar(t)) {
>   12045			mark_reg_unknown(env, regs, BPF_REG_0);
>   12046			mark_btf_func_reg_size(env, BPF_REG_0, t->size);
>   12047		} else if (btf_type_is_ptr(t)) {
>   12048			ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
>   12049	
>   12050			if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
>   12051				if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
>   12052				    meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>   12053					struct btf_struct_meta *struct_meta;
>   12054					struct btf *ret_btf;
>   12055					u32 ret_btf_id;
>   12056	
>   12057					if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl] && !bpf_global_ma_set)
>   12058						return -ENOMEM;
>   12059	
>   12060					if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
>   12061						verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
>   12062						return -EINVAL;
>   12063					}
>   12064	
>   12065					ret_btf = env->prog->aux->btf;
>   12066					ret_btf_id = meta.arg_constant.value;
>   12067	
>   12068					/* This may be NULL due to user not supplying a BTF */
>   12069					if (!ret_btf) {
>   12070						verbose(env, "bpf_obj_new/bpf_percpu_obj_new requires prog BTF\n");
>   12071						return -EINVAL;
>   12072					}
>   12073	
>   12074					ret_t = btf_type_by_id(ret_btf, ret_btf_id);
>   12075					if (!ret_t || !__btf_type_is_struct(ret_t)) {
>   12076						verbose(env, "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct\n");
>   12077						return -EINVAL;
>   12078					}
>   12079	
>   12080					if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>   12081						if (ret_t->size > BPF_GLOBAL_PERCPU_MA_MAX_SIZE) {
>   12082							verbose(env, "bpf_percpu_obj_new type size (%d) is greater than %lu\n",
>   12083								ret_t->size, BPF_GLOBAL_PERCPU_MA_MAX_SIZE);
>   12084							return -EINVAL;
>   12085						}
>   12086						mutex_lock(&bpf_percpu_ma_lock);
>   12087						err = bpf_mem_alloc_percpu_unit_init(&bpf_global_percpu_ma, ret_t->size);
>   12088						mutex_unlock(&bpf_percpu_ma_lock);
>   12089						if (err)
>   12090							return err;
>   12091					}
>   12092	
[...]

