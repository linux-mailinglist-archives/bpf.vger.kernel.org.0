Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115AB6DAC3A
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 13:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbjDGL3P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 07:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240454AbjDGL3O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 07:29:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD87976F
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 04:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680866933; x=1712402933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3cd0xBqmZLwCm19Q3/0HNGu6ZRBFjmnCA9agGLJ4pq0=;
  b=OabP5GTCvQKT+H0UQZ3Sacidk6PCtHUmzW8AT56MMEs8rdaNf+zHkLN0
   bV4A9tkw7sQZRR3vr6Q7kclw7QQWA5bAL+jLDnlzym28qpiGGK15mdNMr
   OuxVMezHdCiVtbUn8ucRUguCbeNTIovsbfjPGy+r5lxrM8Lho8AqfWlPu
   KC6D2psbu8xYWrBLprC0mgDFs3xZLR9UzpAzXM0CF633kLoFGpqIZcowT
   0OI+CoAuCmFeSZivOOCzgRI07g3Aqb5FvPwVoJz64UwVzMzpJw8Gu5IvL
   rFjJzIc8gaqgT9pWCd5bnMdCllvqGtdVmPUOpd1thDD8rRL22HdPQnEpP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="322612302"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="322612302"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 04:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="637676759"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="637676759"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Apr 2023 04:28:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkkGp-000SRY-0A;
        Fri, 07 Apr 2023 11:28:43 +0000
Date:   Fri, 7 Apr 2023 19:28:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhongjun@uniontech.com, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        zhongjun <zhongjun@uniontech.com>
Subject: Re: [PATCH] BPF: replace low-entropy member with macro
Message-ID: <202304071944.aYRCuc4u-lkp@intel.com>
References: <20230407033418.2295-1-zhongjun@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407033418.2295-1-zhongjun@uniontech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 919e659ed12568b5b8ba6c2ffdd82d8d31fc28af]

url:    https://github.com/intel-lab-lkp/linux/commits/zhongjun-uniontech-com/BPF-replace-low-entropy-member-with-macro/20230407-113614
base:   919e659ed12568b5b8ba6c2ffdd82d8d31fc28af
patch link:    https://lore.kernel.org/r/20230407033418.2295-1-zhongjun%40uniontech.com
patch subject: [PATCH] BPF: replace low-entropy member with macro
config: x86_64-randconfig-a002-20230403 (https://download.01.org/0day-ci/archive/20230407/202304071944.aYRCuc4u-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f8ee7d5ddcfe866f9b9b4f18dff368764ea854e5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhongjun-uniontech-com/BPF-replace-low-entropy-member-with-macro/20230407-113614
        git checkout f8ee7d5ddcfe866f9b9b4f18dff368764ea854e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/ethernet/netronome/nfp/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304071944.aYRCuc4u-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/netronome/nfp/bpf/verifier.c:814:57: error: no member named 'orig_idx' in 'struct bpf_insn_aux_data'
           meta = nfp_bpf_goto_meta(nfp_prog, meta, aux_data[off].orig_idx);
                                                    ~~~~~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/verifier.c:827:52: error: no member named 'orig_idx' in 'struct bpf_insn_aux_data'
                   } else if (meta->jmp_dst->n != aux_data[tgt_off].orig_idx) {
                                                  ~~~~~~~~~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/verifier.c:830:23: error: no member named 'orig_idx' in 'struct bpf_insn_aux_data'
                                   aux_data[tgt_off].orig_idx);
                                   ~~~~~~~~~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/verifier.c:17:46: note: expanded from macro 'pr_vlog'
           bpf_verifier_log_write(env, "[nfp] " fmt, ##__VA_ARGS__)
                                                       ^~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/bpf/verifier.c:848:57: error: no member named 'orig_idx' in 'struct bpf_insn_aux_data'
           meta = nfp_bpf_goto_meta(nfp_prog, meta, aux_data[off].orig_idx);
                                                    ~~~~~~~~~~~~~ ^
   4 errors generated.


vim +814 drivers/net/ethernet/netronome/nfp/bpf/verifier.c

a32014b351662f Jakub Kicinski 2019-01-22  806  
a32014b351662f Jakub Kicinski 2019-01-22  807  int nfp_bpf_opt_replace_insn(struct bpf_verifier_env *env, u32 off,
a32014b351662f Jakub Kicinski 2019-01-22  808  			     struct bpf_insn *insn)
a32014b351662f Jakub Kicinski 2019-01-22  809  {
a32014b351662f Jakub Kicinski 2019-01-22  810  	struct nfp_prog *nfp_prog = env->prog->aux->offload->dev_priv;
a32014b351662f Jakub Kicinski 2019-01-22  811  	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
a32014b351662f Jakub Kicinski 2019-01-22  812  	struct nfp_insn_meta *meta = nfp_prog->verifier_meta;
a32014b351662f Jakub Kicinski 2019-01-22  813  
a32014b351662f Jakub Kicinski 2019-01-22 @814  	meta = nfp_bpf_goto_meta(nfp_prog, meta, aux_data[off].orig_idx);
a32014b351662f Jakub Kicinski 2019-01-22  815  	nfp_prog->verifier_meta = meta;
a32014b351662f Jakub Kicinski 2019-01-22  816  
a32014b351662f Jakub Kicinski 2019-01-22  817  	/* conditional jump to jump conversion */
a32014b351662f Jakub Kicinski 2019-01-22  818  	if (is_mbpf_cond_jump(meta) &&
a32014b351662f Jakub Kicinski 2019-01-22  819  	    insn->code == (BPF_JMP | BPF_JA | BPF_K)) {
a32014b351662f Jakub Kicinski 2019-01-22  820  		unsigned int tgt_off;
a32014b351662f Jakub Kicinski 2019-01-22  821  
a32014b351662f Jakub Kicinski 2019-01-22  822  		tgt_off = off + insn->off + 1;
a32014b351662f Jakub Kicinski 2019-01-22  823  
a32014b351662f Jakub Kicinski 2019-01-22  824  		if (!insn->off) {
a32014b351662f Jakub Kicinski 2019-01-22  825  			meta->jmp_dst = list_next_entry(meta, l);
a32014b351662f Jakub Kicinski 2019-01-22  826  			meta->jump_neg_op = false;
a32014b351662f Jakub Kicinski 2019-01-22  827  		} else if (meta->jmp_dst->n != aux_data[tgt_off].orig_idx) {
a32014b351662f Jakub Kicinski 2019-01-22  828  			pr_vlog(env, "branch hard wire at %d changes target %d -> %d\n",
a32014b351662f Jakub Kicinski 2019-01-22  829  				off, meta->jmp_dst->n,
a32014b351662f Jakub Kicinski 2019-01-22  830  				aux_data[tgt_off].orig_idx);
a32014b351662f Jakub Kicinski 2019-01-22  831  			return -EINVAL;
a32014b351662f Jakub Kicinski 2019-01-22  832  		}
a32014b351662f Jakub Kicinski 2019-01-22  833  		return 0;
a32014b351662f Jakub Kicinski 2019-01-22  834  	}
a32014b351662f Jakub Kicinski 2019-01-22  835  
a32014b351662f Jakub Kicinski 2019-01-22  836  	pr_vlog(env, "unsupported instruction replacement %hhx -> %hhx\n",
a32014b351662f Jakub Kicinski 2019-01-22  837  		meta->insn.code, insn->code);
a32014b351662f Jakub Kicinski 2019-01-22  838  	return -EINVAL;
a32014b351662f Jakub Kicinski 2019-01-22  839  }
9a06927e778bc4 Jakub Kicinski 2019-01-22  840  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
