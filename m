Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4E67651B
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 09:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjAUIkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Jan 2023 03:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUIkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Jan 2023 03:40:15 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB5D13505
        for <bpf@vger.kernel.org>; Sat, 21 Jan 2023 00:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674290413; x=1705826413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xI3poSqYldA3z7VWXsMPjqTZUxLQVrwDmjJ6cRjJLMQ=;
  b=R9CYqybFvbuIY3lSrmpt+epEEGdsVp9CsBO/65VJE0U5pWNnZgmhoQxN
   rTh122WouVd9Hs7zpFUO/XF7PaLVqkiRaeysIlnAUB1IZPjcGq395En7k
   2Hxh++xDRMV35Up3nDhYOgzCiw09XIufQkINYWSSPSmDCNaUGDtkICt7Y
   cGBw/HCr5Wyeo/lkwjqWCPSiCduZSs+o2NpPMl92oPN4yga87UPqgMfQ6
   jhmtwxM14PQFzkIjKuLi9CJpDf0gEZ9/y7w2qqy2dOLc3+DUAR1QqLm4I
   KctzacssufT4L+KZxng7sJU/yveIWCii2h416PcHSLOACQxjyQTt4F29b
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="325806605"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="325806605"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 00:40:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="768978290"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="768978290"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2023 00:40:10 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ9Q1-0003rI-2h;
        Sat, 21 Jan 2023 08:40:09 +0000
Date:   Sat, 21 Jan 2023 16:39:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Refactor release_regno searching logic
Message-ID: <202301211658.eN5W6lCN-lkp@intel.com>
References: <20230121002417.1684602-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121002417.1684602-1-davemarchevsky@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Dave,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marchevsky/bpf-Refactor-release_regno-searching-logic/20230121-082705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230121002417.1684602-1-davemarchevsky%40fb.com
patch subject: [PATCH bpf-next] bpf: Refactor release_regno searching logic
config: powerpc-randconfig-r012-20230119 (https://download.01.org/0day-ci/archive/20230121/202301211658.eN5W6lCN-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/3ad2c350687658a62ca29b15042c86b68ed6a73b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dave-Marchevsky/bpf-Refactor-release_regno-searching-logic/20230121-082705
        git checkout 3ad2c350687658a62ca29b15042c86b68ed6a73b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/verifier.c:7846:20: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
                   if (fn->arg_type[i] == ARG_DONTCARE)
                                    ^
   kernel/bpf/verifier.c:7771:7: note: initialize the variable 'i' to silence this warning
           int i, err, func_id, nargs, release_regno, ref_regno;
                ^
                 = 0
   1 warning generated.


vim +/i +7846 kernel/bpf/verifier.c

  7766	
  7767	static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
  7768				     int *insn_idx_p)
  7769	{
  7770		enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
  7771		int i, err, func_id, nargs, release_regno, ref_regno;
  7772		const struct bpf_func_proto *fn = NULL;
  7773		enum bpf_return_type ret_type;
  7774		enum bpf_type_flag ret_flag;
  7775		struct bpf_reg_state *regs;
  7776		struct bpf_call_arg_meta meta;
  7777		int insn_idx = *insn_idx_p;
  7778		bool changes_data;
  7779	
  7780		/* find function prototype */
  7781		func_id = insn->imm;
  7782		if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
  7783			verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
  7784				func_id);
  7785			return -EINVAL;
  7786		}
  7787	
  7788		if (env->ops->get_func_proto)
  7789			fn = env->ops->get_func_proto(func_id, env->prog);
  7790		if (!fn) {
  7791			verbose(env, "unknown func %s#%d\n", func_id_name(func_id),
  7792				func_id);
  7793			return -EINVAL;
  7794		}
  7795	
  7796		/* eBPF programs must be GPL compatible to use GPL-ed functions */
  7797		if (!env->prog->gpl_compatible && fn->gpl_only) {
  7798			verbose(env, "cannot call GPL-restricted function from non-GPL compatible program\n");
  7799			return -EINVAL;
  7800		}
  7801	
  7802		if (fn->allowed && !fn->allowed(env->prog)) {
  7803			verbose(env, "helper call is not allowed in probe\n");
  7804			return -EINVAL;
  7805		}
  7806	
  7807		if (!env->prog->aux->sleepable && fn->might_sleep) {
  7808			verbose(env, "helper call might sleep in a non-sleepable prog\n");
  7809			return -EINVAL;
  7810		}
  7811	
  7812		/* With LD_ABS/IND some JITs save/restore skb from r1. */
  7813		changes_data = bpf_helper_changes_pkt_data(fn->func);
  7814		if (changes_data && fn->arg1_type != ARG_PTR_TO_CTX) {
  7815			verbose(env, "kernel subsystem misconfigured func %s#%d: r1 != ctx\n",
  7816				func_id_name(func_id), func_id);
  7817			return -EINVAL;
  7818		}
  7819	
  7820		memset(&meta, 0, sizeof(meta));
  7821		meta.pkt_access = fn->pkt_access;
  7822	
  7823		err = check_func_proto(fn, func_id);
  7824		if (err) {
  7825			verbose(env, "kernel subsystem misconfigured func %s#%d\n",
  7826				func_id_name(func_id), func_id);
  7827			return err;
  7828		}
  7829	
  7830		if (env->cur_state->active_rcu_lock) {
  7831			if (fn->might_sleep) {
  7832				verbose(env, "sleepable helper %s#%d in rcu_read_lock region\n",
  7833					func_id_name(func_id), func_id);
  7834				return -EINVAL;
  7835			}
  7836	
  7837			if (env->prog->aux->sleepable && is_storage_get_function(func_id))
  7838				env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
  7839		}
  7840	
  7841		meta.func_id = func_id;
  7842		regs = cur_regs(env);
  7843	
  7844		/* find actual arg count */
  7845		for (nargs = 0; nargs < MAX_BPF_FUNC_REG_ARGS; nargs++)
> 7846			if (fn->arg_type[i] == ARG_DONTCARE)
  7847				break;
  7848	
  7849		release_regno = helper_proto_find_release_arg_regno(env, fn, nargs);
  7850		if (release_regno < 0)
  7851			return release_regno;
  7852	
  7853		ref_regno = args_find_ref_obj_id_regno(env, regs, nargs);
  7854		if (ref_regno < 0)
  7855			return ref_regno;
  7856		else if (ref_regno > 0)
  7857			meta.ref_obj_id = regs[ref_regno].ref_obj_id;
  7858	
  7859		if (release_regno > 0) {
  7860			if (!regs[release_regno].ref_obj_id &&
  7861			    !register_is_null(&regs[release_regno]) &&
  7862			    !arg_type_is_dynptr(fn->arg_type[release_regno - BPF_REG_1])) {
  7863				verbose(env, "R%d must be referenced when passed to release function\n",
  7864					release_regno);
  7865				return -EINVAL;
  7866			}
  7867	
  7868			meta.release_regno = release_regno;
  7869		}
  7870	
  7871		/* check args */
  7872		for (i = 0; i < nargs; i++) {
  7873			err = check_func_arg(env, i, &meta, fn);
  7874			if (err)
  7875				return err;
  7876		}
  7877	
  7878		err = record_func_map(env, &meta, func_id, insn_idx);
  7879		if (err)
  7880			return err;
  7881	
  7882		err = record_func_key(env, &meta, func_id, insn_idx);
  7883		if (err)
  7884			return err;
  7885	
  7886		/* Mark slots with STACK_MISC in case of raw mode, stack offset
  7887		 * is inferred from register state.
  7888		 */
  7889		for (i = 0; i < meta.access_size; i++) {
  7890			err = check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
  7891					       BPF_WRITE, -1, false);
  7892			if (err)
  7893				return err;
  7894		}
  7895	
  7896		/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
  7897		 * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
  7898		 * is safe to do directly.
  7899		 */
  7900		if (meta.uninit_dynptr_regno) {
  7901			if (regs[meta.uninit_dynptr_regno].type == CONST_PTR_TO_DYNPTR) {
  7902				verbose(env, "verifier internal error: CONST_PTR_TO_DYNPTR cannot be initialized\n");
  7903				return -EFAULT;
  7904			}
  7905			/* we write BPF_DW bits (8 bytes) at a time */
  7906			for (i = 0; i < BPF_DYNPTR_SIZE; i += 8) {
  7907				err = check_mem_access(env, insn_idx, meta.uninit_dynptr_regno,
  7908						       i, BPF_DW, BPF_WRITE, -1, false);
  7909				if (err)
  7910					return err;
  7911			}
  7912	
  7913			err = mark_stack_slots_dynptr(env, &regs[meta.uninit_dynptr_regno],
  7914						      fn->arg_type[meta.uninit_dynptr_regno - BPF_REG_1],
  7915						      insn_idx);
  7916			if (err)
  7917				return err;
  7918		}
  7919	
  7920		if (meta.release_regno) {
  7921			err = -EINVAL;
  7922			/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
  7923			 * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
  7924			 * is safe to do directly.
  7925			 */
  7926			if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
  7927				if (regs[meta.release_regno].type == CONST_PTR_TO_DYNPTR) {
  7928					verbose(env, "verifier internal error: CONST_PTR_TO_DYNPTR cannot be released\n");
  7929					return -EFAULT;
  7930				}
  7931				err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
  7932			} else if (meta.ref_obj_id) {
  7933				err = release_reference(env, meta.ref_obj_id);
  7934			} else if (register_is_null(&regs[meta.release_regno])) {
  7935				/* meta.ref_obj_id can only be 0 if register that is meant to be
  7936				 * released is NULL, which must be > R0.
  7937				 */
  7938				err = 0;
  7939			}
  7940			if (err) {
  7941				verbose(env, "func %s#%d reference has not been acquired before\n",
  7942					func_id_name(func_id), func_id);
  7943				return err;
  7944			}
  7945		}
  7946	
  7947		switch (func_id) {
  7948		case BPF_FUNC_tail_call:
  7949			err = check_reference_leak(env);
  7950			if (err) {
  7951				verbose(env, "tail_call would lead to reference leak\n");
  7952				return err;
  7953			}
  7954			break;
  7955		case BPF_FUNC_get_local_storage:
  7956			/* check that flags argument in get_local_storage(map, flags) is 0,
  7957			 * this is required because get_local_storage() can't return an error.
  7958			 */
  7959			if (!register_is_null(&regs[BPF_REG_2])) {
  7960				verbose(env, "get_local_storage() doesn't support non-zero flags\n");
  7961				return -EINVAL;
  7962			}
  7963			break;
  7964		case BPF_FUNC_for_each_map_elem:
  7965			err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
  7966						set_map_elem_callback_state);
  7967			break;
  7968		case BPF_FUNC_timer_set_callback:
  7969			err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
  7970						set_timer_callback_state);
  7971			break;
  7972		case BPF_FUNC_find_vma:
  7973			err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
  7974						set_find_vma_callback_state);
  7975			break;
  7976		case BPF_FUNC_snprintf:
  7977			err = check_bpf_snprintf_call(env, regs);
  7978			break;
  7979		case BPF_FUNC_loop:
  7980			update_loop_inline_state(env, meta.subprogno);
  7981			err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
  7982						set_loop_callback_state);
  7983			break;
  7984		case BPF_FUNC_dynptr_from_mem:
  7985			if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE) {
  7986				verbose(env, "Unsupported reg type %s for bpf_dynptr_from_mem data\n",
  7987					reg_type_str(env, regs[BPF_REG_1].type));
  7988				return -EACCES;
  7989			}
  7990			break;
  7991		case BPF_FUNC_set_retval:
  7992			if (prog_type == BPF_PROG_TYPE_LSM &&
  7993			    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
  7994				if (!env->prog->aux->attach_func_proto->type) {
  7995					/* Make sure programs that attach to void
  7996					 * hooks don't try to modify return value.
  7997					 */
  7998					verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
  7999					return -EINVAL;
  8000				}
  8001			}
  8002			break;
  8003		case BPF_FUNC_dynptr_data:
  8004			for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
  8005				if (arg_type_is_dynptr(fn->arg_type[i])) {
  8006					struct bpf_reg_state *reg = &regs[BPF_REG_1 + i];
  8007	
  8008					if (meta.ref_obj_id) {
  8009						verbose(env, "verifier internal error: meta.ref_obj_id already set\n");
  8010						return -EFAULT;
  8011					}
  8012	
  8013					meta.ref_obj_id = dynptr_ref_obj_id(env, reg);
  8014					break;
  8015				}
  8016			}
  8017			if (i == MAX_BPF_FUNC_REG_ARGS) {
  8018				verbose(env, "verifier internal error: no dynptr in bpf_dynptr_data()\n");
  8019				return -EFAULT;
  8020			}
  8021			break;
  8022		case BPF_FUNC_user_ringbuf_drain:
  8023			err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
  8024						set_user_ringbuf_callback_state);
  8025			break;
  8026		}
  8027	
  8028		if (err)
  8029			return err;
  8030	
  8031		/* reset caller saved regs */
  8032		for (i = 0; i < CALLER_SAVED_REGS; i++) {
  8033			mark_reg_not_init(env, regs, caller_saved[i]);
  8034			check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
  8035		}
  8036	
  8037		/* helper call returns 64-bit value. */
  8038		regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
  8039	
  8040		/* update return register (already marked as written above) */
  8041		ret_type = fn->ret_type;
  8042		ret_flag = type_flag(ret_type);
  8043	
  8044		switch (base_type(ret_type)) {
  8045		case RET_INTEGER:
  8046			/* sets type to SCALAR_VALUE */
  8047			mark_reg_unknown(env, regs, BPF_REG_0);
  8048			break;
  8049		case RET_VOID:
  8050			regs[BPF_REG_0].type = NOT_INIT;
  8051			break;
  8052		case RET_PTR_TO_MAP_VALUE:
  8053			/* There is no offset yet applied, variable or fixed */
  8054			mark_reg_known_zero(env, regs, BPF_REG_0);
  8055			/* remember map_ptr, so that check_map_access()
  8056			 * can check 'value_size' boundary of memory access
  8057			 * to map element returned from bpf_map_lookup_elem()
  8058			 */
  8059			if (meta.map_ptr == NULL) {
  8060				verbose(env,
  8061					"kernel subsystem misconfigured verifier\n");
  8062				return -EINVAL;
  8063			}
  8064			regs[BPF_REG_0].map_ptr = meta.map_ptr;
  8065			regs[BPF_REG_0].map_uid = meta.map_uid;
  8066			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
  8067			if (!type_may_be_null(ret_type) &&
  8068			    btf_record_has_field(meta.map_ptr->record, BPF_SPIN_LOCK)) {
  8069				regs[BPF_REG_0].id = ++env->id_gen;
  8070			}
  8071			break;
  8072		case RET_PTR_TO_SOCKET:
  8073			mark_reg_known_zero(env, regs, BPF_REG_0);
  8074			regs[BPF_REG_0].type = PTR_TO_SOCKET | ret_flag;
  8075			break;
  8076		case RET_PTR_TO_SOCK_COMMON:
  8077			mark_reg_known_zero(env, regs, BPF_REG_0);
  8078			regs[BPF_REG_0].type = PTR_TO_SOCK_COMMON | ret_flag;
  8079			break;
  8080		case RET_PTR_TO_TCP_SOCK:
  8081			mark_reg_known_zero(env, regs, BPF_REG_0);
  8082			regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
  8083			break;
  8084		case RET_PTR_TO_MEM:
  8085			mark_reg_known_zero(env, regs, BPF_REG_0);
  8086			regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
  8087			regs[BPF_REG_0].mem_size = meta.mem_size;
  8088			break;
  8089		case RET_PTR_TO_MEM_OR_BTF_ID:
  8090		{
  8091			const struct btf_type *t;
  8092	
  8093			mark_reg_known_zero(env, regs, BPF_REG_0);
  8094			t = btf_type_skip_modifiers(meta.ret_btf, meta.ret_btf_id, NULL);
  8095			if (!btf_type_is_struct(t)) {
  8096				u32 tsize;
  8097				const struct btf_type *ret;
  8098				const char *tname;
  8099	
  8100				/* resolve the type size of ksym. */
  8101				ret = btf_resolve_size(meta.ret_btf, t, &tsize);
  8102				if (IS_ERR(ret)) {
  8103					tname = btf_name_by_offset(meta.ret_btf, t->name_off);
  8104					verbose(env, "unable to resolve the size of type '%s': %ld\n",
  8105						tname, PTR_ERR(ret));
  8106					return -EINVAL;
  8107				}
  8108				regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
  8109				regs[BPF_REG_0].mem_size = tsize;
  8110			} else {
  8111				/* MEM_RDONLY may be carried from ret_flag, but it
  8112				 * doesn't apply on PTR_TO_BTF_ID. Fold it, otherwise
  8113				 * it will confuse the check of PTR_TO_BTF_ID in
  8114				 * check_mem_access().
  8115				 */
  8116				ret_flag &= ~MEM_RDONLY;
  8117	
  8118				regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
  8119				regs[BPF_REG_0].btf = meta.ret_btf;
  8120				regs[BPF_REG_0].btf_id = meta.ret_btf_id;
  8121			}
  8122			break;
  8123		}
  8124		case RET_PTR_TO_BTF_ID:
  8125		{
  8126			struct btf *ret_btf;
  8127			int ret_btf_id;
  8128	
  8129			mark_reg_known_zero(env, regs, BPF_REG_0);
  8130			regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
  8131			if (func_id == BPF_FUNC_kptr_xchg) {
  8132				ret_btf = meta.kptr_field->kptr.btf;
  8133				ret_btf_id = meta.kptr_field->kptr.btf_id;
  8134			} else {
  8135				if (fn->ret_btf_id == BPF_PTR_POISON) {
  8136					verbose(env, "verifier internal error:");
  8137					verbose(env, "func %s has non-overwritten BPF_PTR_POISON return type\n",
  8138						func_id_name(func_id));
  8139					return -EINVAL;
  8140				}
  8141				ret_btf = btf_vmlinux;
  8142				ret_btf_id = *fn->ret_btf_id;
  8143			}
  8144			if (ret_btf_id == 0) {
  8145				verbose(env, "invalid return type %u of func %s#%d\n",
  8146					base_type(ret_type), func_id_name(func_id),
  8147					func_id);
  8148				return -EINVAL;
  8149			}
  8150			regs[BPF_REG_0].btf = ret_btf;
  8151			regs[BPF_REG_0].btf_id = ret_btf_id;
  8152			break;
  8153		}
  8154		default:
  8155			verbose(env, "unknown return type %u of func %s#%d\n",
  8156				base_type(ret_type), func_id_name(func_id), func_id);
  8157			return -EINVAL;
  8158		}
  8159	
  8160		if (type_may_be_null(regs[BPF_REG_0].type))
  8161			regs[BPF_REG_0].id = ++env->id_gen;
  8162	
  8163		if (helper_multiple_ref_obj_use(func_id, meta.map_ptr)) {
  8164			verbose(env, "verifier internal error: func %s#%d sets ref_obj_id more than once\n",
  8165				func_id_name(func_id), func_id);
  8166			return -EFAULT;
  8167		}
  8168	
  8169		if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_id)) {
  8170			/* For release_reference() */
  8171			regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
  8172		} else if (is_acquire_function(func_id, meta.map_ptr)) {
  8173			int id = acquire_reference_state(env, insn_idx);
  8174	
  8175			if (id < 0)
  8176				return id;
  8177			/* For mark_ptr_or_null_reg() */
  8178			regs[BPF_REG_0].id = id;
  8179			/* For release_reference() */
  8180			regs[BPF_REG_0].ref_obj_id = id;
  8181		}
  8182	
  8183		do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
  8184	
  8185		err = check_map_func_compatibility(env, meta.map_ptr, func_id);
  8186		if (err)
  8187			return err;
  8188	
  8189		if ((func_id == BPF_FUNC_get_stack ||
  8190		     func_id == BPF_FUNC_get_task_stack) &&
  8191		    !env->prog->has_callchain_buf) {
  8192			const char *err_str;
  8193	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
