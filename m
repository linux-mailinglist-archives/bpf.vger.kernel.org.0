Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4E4DBE2B
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 06:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiCQFXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 01:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiCQFXv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 01:23:51 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0AB1E694E
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 22:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647494142; x=1679030142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O9riE+QTM9AB03NdOoZGqG5XxJxexea7MIkwLX4BB1k=;
  b=NLrgqJjl342kHwqPjk/vJgwRqwvN4px8k6L61xwl2MiES71ayVbcV6fg
   WUiSXS1ZzrUnTKtUJ+jgJs/Fu5tPZVjywsfA/4k70vP+SNFAD4vG4OgK/
   8zx3xb8kD9YcvEZf1eNA9SQsqk6sI2PJ1XgcdyXIUmauO/cNrkxMCx69I
   g1HnyTERnM1ATcYly6+hVB7e/wdmzknj+RlxYIf1J8e9E5HIqLzSu/4fk
   cMFqT4b/uoqf+0RmItuKv5hE/qTjYCXmXcNKB6A2pBTORriCdPvkEcHEf
   6PV7tpnvseCyQlObIf+JCUheo+nXCQ1D55asOANtcQag8uuQaujzHGjF1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317495423"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="317495423"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 21:07:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="581161455"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2022 21:07:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUhQK-000DHE-M3; Thu, 17 Mar 2022 04:07:40 +0000
Date:   Thu, 17 Mar 2022 12:06:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, kafai@fb.com, kpsingh@kernel.org,
        memxor@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, tj@kernel.org, davemarchevsky@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Enable non-atomic allocations in local
 storage
Message-ID: <202203171134.RcEuYPsA-lkp@intel.com>
References: <20220316195400.2998326-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316195400.2998326-1-joannekoong@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Joanne,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Joanne-Koong/bpf-Enable-non-atomic-allocations-in-local-storage/20220317-035639
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: s390-randconfig-s031-20220313 (https://download.01.org/0day-ci/archive/20220317/202203171134.RcEuYPsA-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/022ee8bbd2bfdefff36373ab838326754fe2bb55
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Joanne-Koong/bpf-Enable-non-atomic-allocations-in-local-storage/20220317-035639
        git checkout 022ee8bbd2bfdefff36373ab838326754fe2bb55
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/verifier.c:13498:47: sparse: sparse: incorrect type in initializer (different base types) @@     expected signed int [usertype] imm @@     got restricted gfp_t @@
   kernel/bpf/verifier.c:13498:47: sparse:     expected signed int [usertype] imm
   kernel/bpf/verifier.c:13498:47: sparse:     got restricted gfp_t
   kernel/bpf/verifier.c:13500:47: sparse: sparse: incorrect type in initializer (different base types) @@     expected signed int [usertype] imm @@     got restricted gfp_t @@
   kernel/bpf/verifier.c:13500:47: sparse:     expected signed int [usertype] imm
   kernel/bpf/verifier.c:13500:47: sparse:     got restricted gfp_t
   kernel/bpf/verifier.c:13726:38: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:63:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:52:47: sparse: sparse: cast from non-scalar

vim +13498 kernel/bpf/verifier.c

 13234	
 13235	/* Do various post-verification rewrites in a single program pass.
 13236	 * These rewrites simplify JIT and interpreter implementations.
 13237	 */
 13238	static int do_misc_fixups(struct bpf_verifier_env *env)
 13239	{
 13240		struct bpf_prog *prog = env->prog;
 13241		enum bpf_attach_type eatype = prog->expected_attach_type;
 13242		bool expect_blinding = bpf_jit_blinding_enabled(prog);
 13243		enum bpf_prog_type prog_type = resolve_prog_type(prog);
 13244		struct bpf_insn *insn = prog->insnsi;
 13245		const struct bpf_func_proto *fn;
 13246		const int insn_cnt = prog->len;
 13247		const struct bpf_map_ops *ops;
 13248		struct bpf_insn_aux_data *aux;
 13249		struct bpf_insn insn_buf[16];
 13250		struct bpf_prog *new_prog;
 13251		struct bpf_map *map_ptr;
 13252		int i, ret, cnt, delta = 0;
 13253	
 13254		for (i = 0; i < insn_cnt; i++, insn++) {
 13255			/* Make divide-by-zero exceptions impossible. */
 13256			if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 13257			    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
 13258			    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
 13259			    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
 13260				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
 13261				bool isdiv = BPF_OP(insn->code) == BPF_DIV;
 13262				struct bpf_insn *patchlet;
 13263				struct bpf_insn chk_and_div[] = {
 13264					/* [R,W]x div 0 -> 0 */
 13265					BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
 13266						     BPF_JNE | BPF_K, insn->src_reg,
 13267						     0, 2, 0),
 13268					BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
 13269					BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 13270					*insn,
 13271				};
 13272				struct bpf_insn chk_and_mod[] = {
 13273					/* [R,W]x mod 0 -> [R,W]x */
 13274					BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
 13275						     BPF_JEQ | BPF_K, insn->src_reg,
 13276						     0, 1 + (is64 ? 0 : 1), 0),
 13277					*insn,
 13278					BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 13279					BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
 13280				};
 13281	
 13282				patchlet = isdiv ? chk_and_div : chk_and_mod;
 13283				cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
 13284					      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
 13285	
 13286				new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
 13287				if (!new_prog)
 13288					return -ENOMEM;
 13289	
 13290				delta    += cnt - 1;
 13291				env->prog = prog = new_prog;
 13292				insn      = new_prog->insnsi + i + delta;
 13293				continue;
 13294			}
 13295	
 13296			/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
 13297			if (BPF_CLASS(insn->code) == BPF_LD &&
 13298			    (BPF_MODE(insn->code) == BPF_ABS ||
 13299			     BPF_MODE(insn->code) == BPF_IND)) {
 13300				cnt = env->ops->gen_ld_abs(insn, insn_buf);
 13301				if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf)) {
 13302					verbose(env, "bpf verifier is misconfigured\n");
 13303					return -EINVAL;
 13304				}
 13305	
 13306				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13307				if (!new_prog)
 13308					return -ENOMEM;
 13309	
 13310				delta    += cnt - 1;
 13311				env->prog = prog = new_prog;
 13312				insn      = new_prog->insnsi + i + delta;
 13313				continue;
 13314			}
 13315	
 13316			/* Rewrite pointer arithmetic to mitigate speculation attacks. */
 13317			if (insn->code == (BPF_ALU64 | BPF_ADD | BPF_X) ||
 13318			    insn->code == (BPF_ALU64 | BPF_SUB | BPF_X)) {
 13319				const u8 code_add = BPF_ALU64 | BPF_ADD | BPF_X;
 13320				const u8 code_sub = BPF_ALU64 | BPF_SUB | BPF_X;
 13321				struct bpf_insn *patch = &insn_buf[0];
 13322				bool issrc, isneg, isimm;
 13323				u32 off_reg;
 13324	
 13325				aux = &env->insn_aux_data[i + delta];
 13326				if (!aux->alu_state ||
 13327				    aux->alu_state == BPF_ALU_NON_POINTER)
 13328					continue;
 13329	
 13330				isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
 13331				issrc = (aux->alu_state & BPF_ALU_SANITIZE) ==
 13332					BPF_ALU_SANITIZE_SRC;
 13333				isimm = aux->alu_state & BPF_ALU_IMMEDIATE;
 13334	
 13335				off_reg = issrc ? insn->src_reg : insn->dst_reg;
 13336				if (isimm) {
 13337					*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
 13338				} else {
 13339					if (isneg)
 13340						*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 13341					*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
 13342					*patch++ = BPF_ALU64_REG(BPF_SUB, BPF_REG_AX, off_reg);
 13343					*patch++ = BPF_ALU64_REG(BPF_OR, BPF_REG_AX, off_reg);
 13344					*patch++ = BPF_ALU64_IMM(BPF_NEG, BPF_REG_AX, 0);
 13345					*patch++ = BPF_ALU64_IMM(BPF_ARSH, BPF_REG_AX, 63);
 13346					*patch++ = BPF_ALU64_REG(BPF_AND, BPF_REG_AX, off_reg);
 13347				}
 13348				if (!issrc)
 13349					*patch++ = BPF_MOV64_REG(insn->dst_reg, insn->src_reg);
 13350				insn->src_reg = BPF_REG_AX;
 13351				if (isneg)
 13352					insn->code = insn->code == code_add ?
 13353						     code_sub : code_add;
 13354				*patch++ = *insn;
 13355				if (issrc && isneg && !isimm)
 13356					*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 13357				cnt = patch - insn_buf;
 13358	
 13359				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13360				if (!new_prog)
 13361					return -ENOMEM;
 13362	
 13363				delta    += cnt - 1;
 13364				env->prog = prog = new_prog;
 13365				insn      = new_prog->insnsi + i + delta;
 13366				continue;
 13367			}
 13368	
 13369			if (insn->code != (BPF_JMP | BPF_CALL))
 13370				continue;
 13371			if (insn->src_reg == BPF_PSEUDO_CALL)
 13372				continue;
 13373			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 13374				ret = fixup_kfunc_call(env, insn);
 13375				if (ret)
 13376					return ret;
 13377				continue;
 13378			}
 13379	
 13380			if (insn->imm == BPF_FUNC_get_route_realm)
 13381				prog->dst_needed = 1;
 13382			if (insn->imm == BPF_FUNC_get_prandom_u32)
 13383				bpf_user_rnd_init_once();
 13384			if (insn->imm == BPF_FUNC_override_return)
 13385				prog->kprobe_override = 1;
 13386			if (insn->imm == BPF_FUNC_tail_call) {
 13387				/* If we tail call into other programs, we
 13388				 * cannot make any assumptions since they can
 13389				 * be replaced dynamically during runtime in
 13390				 * the program array.
 13391				 */
 13392				prog->cb_access = 1;
 13393				if (!allow_tail_call_in_subprogs(env))
 13394					prog->aux->stack_depth = MAX_BPF_STACK;
 13395				prog->aux->max_pkt_offset = MAX_PACKET_OFF;
 13396	
 13397				/* mark bpf_tail_call as different opcode to avoid
 13398				 * conditional branch in the interpreter for every normal
 13399				 * call and to prevent accidental JITing by JIT compiler
 13400				 * that doesn't support bpf_tail_call yet
 13401				 */
 13402				insn->imm = 0;
 13403				insn->code = BPF_JMP | BPF_TAIL_CALL;
 13404	
 13405				aux = &env->insn_aux_data[i + delta];
 13406				if (env->bpf_capable && !expect_blinding &&
 13407				    prog->jit_requested &&
 13408				    !bpf_map_key_poisoned(aux) &&
 13409				    !bpf_map_ptr_poisoned(aux) &&
 13410				    !bpf_map_ptr_unpriv(aux)) {
 13411					struct bpf_jit_poke_descriptor desc = {
 13412						.reason = BPF_POKE_REASON_TAIL_CALL,
 13413						.tail_call.map = BPF_MAP_PTR(aux->map_ptr_state),
 13414						.tail_call.key = bpf_map_key_immediate(aux),
 13415						.insn_idx = i + delta,
 13416					};
 13417	
 13418					ret = bpf_jit_add_poke_descriptor(prog, &desc);
 13419					if (ret < 0) {
 13420						verbose(env, "adding tail call poke descriptor failed\n");
 13421						return ret;
 13422					}
 13423	
 13424					insn->imm = ret + 1;
 13425					continue;
 13426				}
 13427	
 13428				if (!bpf_map_ptr_unpriv(aux))
 13429					continue;
 13430	
 13431				/* instead of changing every JIT dealing with tail_call
 13432				 * emit two extra insns:
 13433				 * if (index >= max_entries) goto out;
 13434				 * index &= array->index_mask;
 13435				 * to avoid out-of-bounds cpu speculation
 13436				 */
 13437				if (bpf_map_ptr_poisoned(aux)) {
 13438					verbose(env, "tail_call abusing map_ptr\n");
 13439					return -EINVAL;
 13440				}
 13441	
 13442				map_ptr = BPF_MAP_PTR(aux->map_ptr_state);
 13443				insn_buf[0] = BPF_JMP_IMM(BPF_JGE, BPF_REG_3,
 13444							  map_ptr->max_entries, 2);
 13445				insn_buf[1] = BPF_ALU32_IMM(BPF_AND, BPF_REG_3,
 13446							    container_of(map_ptr,
 13447									 struct bpf_array,
 13448									 map)->index_mask);
 13449				insn_buf[2] = *insn;
 13450				cnt = 3;
 13451				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13452				if (!new_prog)
 13453					return -ENOMEM;
 13454	
 13455				delta    += cnt - 1;
 13456				env->prog = prog = new_prog;
 13457				insn      = new_prog->insnsi + i + delta;
 13458				continue;
 13459			}
 13460	
 13461			if (insn->imm == BPF_FUNC_timer_set_callback) {
 13462				/* The verifier will process callback_fn as many times as necessary
 13463				 * with different maps and the register states prepared by
 13464				 * set_timer_callback_state will be accurate.
 13465				 *
 13466				 * The following use case is valid:
 13467				 *   map1 is shared by prog1, prog2, prog3.
 13468				 *   prog1 calls bpf_timer_init for some map1 elements
 13469				 *   prog2 calls bpf_timer_set_callback for some map1 elements.
 13470				 *     Those that were not bpf_timer_init-ed will return -EINVAL.
 13471				 *   prog3 calls bpf_timer_start for some map1 elements.
 13472				 *     Those that were not both bpf_timer_init-ed and
 13473				 *     bpf_timer_set_callback-ed will return -EINVAL.
 13474				 */
 13475				struct bpf_insn ld_addrs[2] = {
 13476					BPF_LD_IMM64(BPF_REG_3, (long)prog->aux),
 13477				};
 13478	
 13479				insn_buf[0] = ld_addrs[0];
 13480				insn_buf[1] = ld_addrs[1];
 13481				insn_buf[2] = *insn;
 13482				cnt = 3;
 13483	
 13484				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13485				if (!new_prog)
 13486					return -ENOMEM;
 13487	
 13488				delta    += cnt - 1;
 13489				env->prog = prog = new_prog;
 13490				insn      = new_prog->insnsi + i + delta;
 13491				goto patch_call_imm;
 13492			}
 13493	
 13494			if (insn->imm == BPF_FUNC_task_storage_get ||
 13495			    insn->imm == BPF_FUNC_sk_storage_get ||
 13496			    insn->imm == BPF_FUNC_inode_storage_get) {
 13497				if (env->prog->aux->sleepable)
 13498					insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, GFP_KERNEL);
 13499				else
 13500					insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, GFP_ATOMIC);
 13501				insn_buf[1] = *insn;
 13502				cnt = 2;
 13503	
 13504				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13505				if (!new_prog)
 13506					return -ENOMEM;
 13507	
 13508				delta += cnt - 1;
 13509				env->prog = prog = new_prog;
 13510				insn = new_prog->insnsi + i + delta;
 13511				goto patch_call_imm;
 13512			}
 13513	
 13514			/* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
 13515			 * and other inlining handlers are currently limited to 64 bit
 13516			 * only.
 13517			 */
 13518			if (prog->jit_requested && BITS_PER_LONG == 64 &&
 13519			    (insn->imm == BPF_FUNC_map_lookup_elem ||
 13520			     insn->imm == BPF_FUNC_map_update_elem ||
 13521			     insn->imm == BPF_FUNC_map_delete_elem ||
 13522			     insn->imm == BPF_FUNC_map_push_elem   ||
 13523			     insn->imm == BPF_FUNC_map_pop_elem    ||
 13524			     insn->imm == BPF_FUNC_map_peek_elem   ||
 13525			     insn->imm == BPF_FUNC_redirect_map    ||
 13526			     insn->imm == BPF_FUNC_for_each_map_elem)) {
 13527				aux = &env->insn_aux_data[i + delta];
 13528				if (bpf_map_ptr_poisoned(aux))
 13529					goto patch_call_imm;
 13530	
 13531				map_ptr = BPF_MAP_PTR(aux->map_ptr_state);
 13532				ops = map_ptr->ops;
 13533				if (insn->imm == BPF_FUNC_map_lookup_elem &&
 13534				    ops->map_gen_lookup) {
 13535					cnt = ops->map_gen_lookup(map_ptr, insn_buf);
 13536					if (cnt == -EOPNOTSUPP)
 13537						goto patch_map_ops_generic;
 13538					if (cnt <= 0 || cnt >= ARRAY_SIZE(insn_buf)) {
 13539						verbose(env, "bpf verifier is misconfigured\n");
 13540						return -EINVAL;
 13541					}
 13542	
 13543					new_prog = bpf_patch_insn_data(env, i + delta,
 13544								       insn_buf, cnt);
 13545					if (!new_prog)
 13546						return -ENOMEM;
 13547	
 13548					delta    += cnt - 1;
 13549					env->prog = prog = new_prog;
 13550					insn      = new_prog->insnsi + i + delta;
 13551					continue;
 13552				}
 13553	
 13554				BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
 13555					     (void *(*)(struct bpf_map *map, void *key))NULL));
 13556				BUILD_BUG_ON(!__same_type(ops->map_delete_elem,
 13557					     (int (*)(struct bpf_map *map, void *key))NULL));
 13558				BUILD_BUG_ON(!__same_type(ops->map_update_elem,
 13559					     (int (*)(struct bpf_map *map, void *key, void *value,
 13560						      u64 flags))NULL));
 13561				BUILD_BUG_ON(!__same_type(ops->map_push_elem,
 13562					     (int (*)(struct bpf_map *map, void *value,
 13563						      u64 flags))NULL));
 13564				BUILD_BUG_ON(!__same_type(ops->map_pop_elem,
 13565					     (int (*)(struct bpf_map *map, void *value))NULL));
 13566				BUILD_BUG_ON(!__same_type(ops->map_peek_elem,
 13567					     (int (*)(struct bpf_map *map, void *value))NULL));
 13568				BUILD_BUG_ON(!__same_type(ops->map_redirect,
 13569					     (int (*)(struct bpf_map *map, u32 ifindex, u64 flags))NULL));
 13570				BUILD_BUG_ON(!__same_type(ops->map_for_each_callback,
 13571					     (int (*)(struct bpf_map *map,
 13572						      bpf_callback_t callback_fn,
 13573						      void *callback_ctx,
 13574						      u64 flags))NULL));
 13575	
 13576	patch_map_ops_generic:
 13577				switch (insn->imm) {
 13578				case BPF_FUNC_map_lookup_elem:
 13579					insn->imm = BPF_CALL_IMM(ops->map_lookup_elem);
 13580					continue;
 13581				case BPF_FUNC_map_update_elem:
 13582					insn->imm = BPF_CALL_IMM(ops->map_update_elem);
 13583					continue;
 13584				case BPF_FUNC_map_delete_elem:
 13585					insn->imm = BPF_CALL_IMM(ops->map_delete_elem);
 13586					continue;
 13587				case BPF_FUNC_map_push_elem:
 13588					insn->imm = BPF_CALL_IMM(ops->map_push_elem);
 13589					continue;
 13590				case BPF_FUNC_map_pop_elem:
 13591					insn->imm = BPF_CALL_IMM(ops->map_pop_elem);
 13592					continue;
 13593				case BPF_FUNC_map_peek_elem:
 13594					insn->imm = BPF_CALL_IMM(ops->map_peek_elem);
 13595					continue;
 13596				case BPF_FUNC_redirect_map:
 13597					insn->imm = BPF_CALL_IMM(ops->map_redirect);
 13598					continue;
 13599				case BPF_FUNC_for_each_map_elem:
 13600					insn->imm = BPF_CALL_IMM(ops->map_for_each_callback);
 13601					continue;
 13602				}
 13603	
 13604				goto patch_call_imm;
 13605			}
 13606	
 13607			/* Implement bpf_jiffies64 inline. */
 13608			if (prog->jit_requested && BITS_PER_LONG == 64 &&
 13609			    insn->imm == BPF_FUNC_jiffies64) {
 13610				struct bpf_insn ld_jiffies_addr[2] = {
 13611					BPF_LD_IMM64(BPF_REG_0,
 13612						     (unsigned long)&jiffies),
 13613				};
 13614	
 13615				insn_buf[0] = ld_jiffies_addr[0];
 13616				insn_buf[1] = ld_jiffies_addr[1];
 13617				insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0,
 13618							  BPF_REG_0, 0);
 13619				cnt = 3;
 13620	
 13621				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
 13622							       cnt);
 13623				if (!new_prog)
 13624					return -ENOMEM;
 13625	
 13626				delta    += cnt - 1;
 13627				env->prog = prog = new_prog;
 13628				insn      = new_prog->insnsi + i + delta;
 13629				continue;
 13630			}
 13631	
 13632			/* Implement bpf_get_func_arg inline. */
 13633			if (prog_type == BPF_PROG_TYPE_TRACING &&
 13634			    insn->imm == BPF_FUNC_get_func_arg) {
 13635				/* Load nr_args from ctx - 8 */
 13636				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
 13637				insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
 13638				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
 13639				insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
 13640				insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
 13641				insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
 13642				insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
 13643				insn_buf[7] = BPF_JMP_A(1);
 13644				insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
 13645				cnt = 9;
 13646	
 13647				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13648				if (!new_prog)
 13649					return -ENOMEM;
 13650	
 13651				delta    += cnt - 1;
 13652				env->prog = prog = new_prog;
 13653				insn      = new_prog->insnsi + i + delta;
 13654				continue;
 13655			}
 13656	
 13657			/* Implement bpf_get_func_ret inline. */
 13658			if (prog_type == BPF_PROG_TYPE_TRACING &&
 13659			    insn->imm == BPF_FUNC_get_func_ret) {
 13660				if (eatype == BPF_TRACE_FEXIT ||
 13661				    eatype == BPF_MODIFY_RETURN) {
 13662					/* Load nr_args from ctx - 8 */
 13663					insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
 13664					insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
 13665					insn_buf[2] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
 13666					insn_buf[3] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
 13667					insn_buf[4] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
 13668					insn_buf[5] = BPF_MOV64_IMM(BPF_REG_0, 0);
 13669					cnt = 6;
 13670				} else {
 13671					insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
 13672					cnt = 1;
 13673				}
 13674	
 13675				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 13676				if (!new_prog)
 13677					return -ENOMEM;
 13678	
 13679				delta    += cnt - 1;
 13680				env->prog = prog = new_prog;
 13681				insn      = new_prog->insnsi + i + delta;
 13682				continue;
 13683			}
 13684	
 13685			/* Implement get_func_arg_cnt inline. */
 13686			if (prog_type == BPF_PROG_TYPE_TRACING &&
 13687			    insn->imm == BPF_FUNC_get_func_arg_cnt) {
 13688				/* Load nr_args from ctx - 8 */
 13689				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
 13690	
 13691				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 13692				if (!new_prog)
 13693					return -ENOMEM;
 13694	
 13695				env->prog = prog = new_prog;
 13696				insn      = new_prog->insnsi + i + delta;
 13697				continue;
 13698			}
 13699	
 13700			/* Implement bpf_get_func_ip inline. */
 13701			if (prog_type == BPF_PROG_TYPE_TRACING &&
 13702			    insn->imm == BPF_FUNC_get_func_ip) {
 13703				/* Load IP address from ctx - 16 */
 13704				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -16);
 13705	
 13706				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 13707				if (!new_prog)
 13708					return -ENOMEM;
 13709	
 13710				env->prog = prog = new_prog;
 13711				insn      = new_prog->insnsi + i + delta;
 13712				continue;
 13713			}
 13714	
 13715	patch_call_imm:
 13716			fn = env->ops->get_func_proto(insn->imm, env->prog);
 13717			/* all functions that have prototype and verifier allowed
 13718			 * programs to call them, must be real in-kernel functions
 13719			 */
 13720			if (!fn->func) {
 13721				verbose(env,
 13722					"kernel subsystem misconfigured func %s#%d\n",
 13723					func_id_name(insn->imm), insn->imm);
 13724				return -EFAULT;
 13725			}
 13726			insn->imm = fn->func - __bpf_call_base;
 13727		}
 13728	
 13729		/* Since poke tab is now finalized, publish aux to tracker. */
 13730		for (i = 0; i < prog->aux->size_poke_tab; i++) {
 13731			map_ptr = prog->aux->poke_tab[i].tail_call.map;
 13732			if (!map_ptr->ops->map_poke_track ||
 13733			    !map_ptr->ops->map_poke_untrack ||
 13734			    !map_ptr->ops->map_poke_run) {
 13735				verbose(env, "bpf verifier is misconfigured\n");
 13736				return -EINVAL;
 13737			}
 13738	
 13739			ret = map_ptr->ops->map_poke_track(map_ptr, prog->aux);
 13740			if (ret < 0) {
 13741				verbose(env, "tracking tail call prog failed\n");
 13742				return ret;
 13743			}
 13744		}
 13745	
 13746		sort_kfunc_descs_by_imm(env->prog);
 13747	
 13748		return 0;
 13749	}
 13750	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
