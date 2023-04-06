Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DA96D8E5A
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 06:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjDFEan (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 00:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjDFEal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 00:30:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCF07686
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 21:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680755439; x=1712291439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q/CzGlFTogMaxbSHq/vVNFjeGjV1uru68m2DH8UFSWk=;
  b=bHK4Tfp1mmQ3ujvqfH2kqQKO1ATX4oUFINfAq4FDaNpCDoGWGP9q78yR
   lIaNMRCr/p415QVsfAW+hRejTh/0H5RgVDChRbIzN2OrVhq0N2UjqUdNX
   oqlzvn+x9Zr0SA04XXX83qJTgtvHaF/wBE6u/fKFx0g7Z1WzjV4FYTiHV
   Uo3zde82ydVEThhYqQy752AAYL1uHMJSLbbCDWCeIzSg5sjiQuycoNR70
   2HmFeJd0LxVLmX4LVH/RFLJHSBBKvd6Pi7/ztrElAYIoUc3ZQHdakB6IT
   vLDWDGfc5981w9XpwOzmJoA0PP8jTDSCzqA94F77j5WThViXpl+faUoJE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="340126927"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="340126927"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 21:30:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="751511532"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="751511532"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2023 21:30:37 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkHGe-000R2s-1N;
        Thu, 06 Apr 2023 04:30:36 +0000
Date:   Thu, 6 Apr 2023 12:30:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhongjun@uniontech.com, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, zhongjun <zhongjun@uniontech.com>
Subject: Re: [PATCH] BPF: make verifier 'misconfigured' errors more meaningful
Message-ID: <202304061244.4wKWT2bk-lkp@intel.com>
References: <20230406014351.8984-1-zhongjun@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406014351.8984-1-zhongjun@uniontech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 738a96c4a8c36950803fdd27e7c30aca92dccefd]

url:    https://github.com/intel-lab-lkp/linux/commits/zhongjun-uniontech-com/BPF-make-verifier-misconfigured-errors-more-meaningful/20230406-094605
base:   738a96c4a8c36950803fdd27e7c30aca92dccefd
patch link:    https://lore.kernel.org/r/20230406014351.8984-1-zhongjun%40uniontech.com
patch subject: [PATCH] BPF: make verifier 'misconfigured' errors more meaningful
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230406/202304061244.4wKWT2bk-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e5263a5893bdd6f559e1dbc9e585339a933c7351
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhongjun-uniontech-com/BPF-make-verifier-misconfigured-errors-more-meaningful/20230406-094605
        git checkout e5263a5893bdd6f559e1dbc9e585339a933c7351
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304061244.4wKWT2bk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/verifier.c: In function 'convert_ctx_accesses':
>> kernel/bpf/verifier.c:15825:93: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
   15825 |                         verbose(env, "bpf verifier is misconfigured: cnt=%d exceeds limit@%lu\n",
         |                                                                                           ~~^
         |                                                                                             |
         |                                                                                             long unsigned int
         |                                                                                           %u
   kernel/bpf/verifier.c: In function 'do_misc_fixups':
   kernel/bpf/verifier.c:16407:101: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
   16407 |                                 verbose(env, "bpf verifier is misconfigured: cnt=%d exceeds limit@%lu\n",
         |                                                                                                   ~~^
         |                                                                                                     |
         |                                                                                                     long unsigned int
         |                                                                                                   %u
   kernel/bpf/verifier.c:16655:109: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
   16655 |                                         verbose(env, "bpf verifier is misconfigured: cnt=%d exceeds limit@%lu\n",
         |                                                                                                           ~~^
         |                                                                                                             |
         |                                                                                                             long unsigned int
         |                                                                                                           %u


vim +15825 kernel/bpf/verifier.c

 15800	
 15801	/* convert load instructions that access fields of a context type into a
 15802	 * sequence of instructions that access fields of the underlying structure:
 15803	 *     struct __sk_buff    -> struct sk_buff
 15804	 *     struct bpf_sock_ops -> struct sock
 15805	 */
 15806	static int convert_ctx_accesses(struct bpf_verifier_env *env)
 15807	{
 15808		const struct bpf_verifier_ops *ops = env->ops;
 15809		int i, cnt, size, ctx_field_size, delta = 0;
 15810		const int insn_cnt = env->prog->len;
 15811		struct bpf_insn insn_buf[16], *insn;
 15812		u32 target_size, size_default, off;
 15813		struct bpf_prog *new_prog;
 15814		enum bpf_access_type type;
 15815		bool is_narrower_load;
 15816	
 15817		if (ops->gen_prologue || env->seen_direct_write) {
 15818			if (!ops->gen_prologue) {
 15819				verbose(env, "bpf verifier is misconfigured: gen_prologue is NULL\n");
 15820				return -EINVAL;
 15821			}
 15822			cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
 15823						env->prog);
 15824			if (cnt >= ARRAY_SIZE(insn_buf)) {
 15825				verbose(env, "bpf verifier is misconfigured: cnt=%d exceeds limit@%lu\n",
 15826						cnt, ARRAY_SIZE(insn_buf));
 15827				return -EINVAL;
 15828			} else if (cnt) {
 15829				new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
 15830				if (!new_prog)
 15831					return -ENOMEM;
 15832	
 15833				env->prog = new_prog;
 15834				delta += cnt - 1;
 15835			}
 15836		}
 15837	
 15838		if (bpf_prog_is_offloaded(env->prog->aux))
 15839			return 0;
 15840	
 15841		insn = env->prog->insnsi + delta;
 15842	
 15843		for (i = 0; i < insn_cnt; i++, insn++) {
 15844			bpf_convert_ctx_access_t convert_ctx_access;
 15845			bool ctx_access;
 15846	
 15847			if (insn->code == (BPF_LDX | BPF_MEM | BPF_B) ||
 15848			    insn->code == (BPF_LDX | BPF_MEM | BPF_H) ||
 15849			    insn->code == (BPF_LDX | BPF_MEM | BPF_W) ||
 15850			    insn->code == (BPF_LDX | BPF_MEM | BPF_DW)) {
 15851				type = BPF_READ;
 15852				ctx_access = true;
 15853			} else if (insn->code == (BPF_STX | BPF_MEM | BPF_B) ||
 15854				   insn->code == (BPF_STX | BPF_MEM | BPF_H) ||
 15855				   insn->code == (BPF_STX | BPF_MEM | BPF_W) ||
 15856				   insn->code == (BPF_STX | BPF_MEM | BPF_DW) ||
 15857				   insn->code == (BPF_ST | BPF_MEM | BPF_B) ||
 15858				   insn->code == (BPF_ST | BPF_MEM | BPF_H) ||
 15859				   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
 15860				   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
 15861				type = BPF_WRITE;
 15862				ctx_access = BPF_CLASS(insn->code) == BPF_STX;
 15863			} else {
 15864				continue;
 15865			}
 15866	
 15867			if (type == BPF_WRITE &&
 15868			    env->insn_aux_data[i + delta].sanitize_stack_spill) {
 15869				struct bpf_insn patch[] = {
 15870					*insn,
 15871					BPF_ST_NOSPEC(),
 15872				};
 15873	
 15874				cnt = ARRAY_SIZE(patch);
 15875				new_prog = bpf_patch_insn_data(env, i + delta, patch, cnt);
 15876				if (!new_prog)
 15877					return -ENOMEM;
 15878	
 15879				delta    += cnt - 1;
 15880				env->prog = new_prog;
 15881				insn      = new_prog->insnsi + i + delta;
 15882				continue;
 15883			}
 15884	
 15885			if (!ctx_access)
 15886				continue;
 15887	
 15888			switch ((int)env->insn_aux_data[i + delta].ptr_type) {
 15889			case PTR_TO_CTX:
 15890				if (!ops->convert_ctx_access)
 15891					continue;
 15892				convert_ctx_access = ops->convert_ctx_access;
 15893				break;
 15894			case PTR_TO_SOCKET:
 15895			case PTR_TO_SOCK_COMMON:
 15896				convert_ctx_access = bpf_sock_convert_ctx_access;
 15897				break;
 15898			case PTR_TO_TCP_SOCK:
 15899				convert_ctx_access = bpf_tcp_sock_convert_ctx_access;
 15900				break;
 15901			case PTR_TO_XDP_SOCK:
 15902				convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
 15903				break;
 15904			case PTR_TO_BTF_ID:
 15905			case PTR_TO_BTF_ID | PTR_UNTRUSTED:
 15906			/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
 15907			 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
 15908			 * be said once it is marked PTR_UNTRUSTED, hence we must handle
 15909			 * any faults for loads into such types. BPF_WRITE is disallowed
 15910			 * for this case.
 15911			 */
 15912			case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
 15913				if (type == BPF_READ) {
 15914					insn->code = BPF_LDX | BPF_PROBE_MEM |
 15915						BPF_SIZE((insn)->code);
 15916					env->prog->aux->num_exentries++;
 15917				}
 15918				continue;
 15919			default:
 15920				continue;
 15921			}
 15922	
 15923			ctx_field_size = env->insn_aux_data[i + delta].ctx_field_size;
 15924			size = BPF_LDST_BYTES(insn);
 15925	
 15926			/* If the read access is a narrower load of the field,
 15927			 * convert to a 4/8-byte load, to minimum program type specific
 15928			 * convert_ctx_access changes. If conversion is successful,
 15929			 * we will apply proper mask to the result.
 15930			 */
 15931			is_narrower_load = size < ctx_field_size;
 15932			size_default = bpf_ctx_off_adjust_machine(ctx_field_size);
 15933			off = insn->off;
 15934			if (is_narrower_load) {
 15935				u8 size_code;
 15936	
 15937				if (type == BPF_WRITE) {
 15938					verbose(env, "bpf verifier narrow ctx access misconfigured\n");
 15939					return -EINVAL;
 15940				}
 15941	
 15942				size_code = BPF_H;
 15943				if (ctx_field_size == 4)
 15944					size_code = BPF_W;
 15945				else if (ctx_field_size == 8)
 15946					size_code = BPF_DW;
 15947	
 15948				insn->off = off & ~(size_default - 1);
 15949				insn->code = BPF_LDX | BPF_MEM | size_code;
 15950			}
 15951	
 15952			target_size = 0;
 15953			cnt = convert_ctx_access(type, insn, insn_buf, env->prog,
 15954						 &target_size);
 15955			if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf) ||
 15956			    (ctx_field_size && !target_size)) {
 15957				verbose(env, "bpf verifier is misconfigured: ins[%d] cnt=%d ctx_s=%u tg_s=%u\n",
 15958						i, cnt, ctx_field_size, target_size);
 15959				return -EINVAL;
 15960			}
 15961	
 15962			if (is_narrower_load && size < target_size) {
 15963				u8 shift = bpf_ctx_narrow_access_offset(
 15964					off, size, size_default) * 8;
 15965				if (shift && cnt + 1 >= ARRAY_SIZE(insn_buf)) {
 15966					verbose(env, "bpf verifier narrow ctx load misconfigured\n");
 15967					return -EINVAL;
 15968				}
 15969				if (ctx_field_size <= 4) {
 15970					if (shift)
 15971						insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
 15972										insn->dst_reg,
 15973										shift);
 15974					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
 15975									(1 << size * 8) - 1);
 15976				} else {
 15977					if (shift)
 15978						insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
 15979										insn->dst_reg,
 15980										shift);
 15981					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
 15982									(1ULL << size * 8) - 1);
 15983				}
 15984			}
 15985	
 15986			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 15987			if (!new_prog)
 15988				return -ENOMEM;
 15989	
 15990			delta += cnt - 1;
 15991	
 15992			/* keep walking new program and skip insns we just inserted */
 15993			env->prog = new_prog;
 15994			insn      = new_prog->insnsi + i + delta;
 15995		}
 15996	
 15997		return 0;
 15998	}
 15999	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
