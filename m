Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B409A6A29EC
	for <lists+bpf@lfdr.de>; Sat, 25 Feb 2023 14:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBYNHh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Feb 2023 08:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYNHh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Feb 2023 08:07:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D26CA3F
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 05:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677330453; x=1708866453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CGNZQt8Kr49klmQxoFrV8Z//dnuyfXlWU2pzm61Nj3s=;
  b=Kmc2r9obiidfkumovzxoNFu5RSxkOEXeUieJUjso4qKe+la8+hBjTlz+
   JzRuWoMIvtRNVD2ODCNuJgqCwNDAC4OU7l3PESZGvgva+fgNYn376C2tg
   8VyqsYYDjEZPbv00qxKV4H7BZ8gqe5eKNDW7BIqeB8xvoVhXHNJAJ3aGC
   vsEXY1D+fY1wdnaUiZIeemOSuoF6quxhxPEgMUpduBNBr6BQUCsQGnTY0
   m0b77GLL3fTIJfQkK8w8bzVHQSPVIOUfCZQPTiXUa8bJmFGY9R49P02sX
   YfdWgjw08+xcWTl64PF0fnepjkSsFnYadYpsAUv209qdzBB4FQFEPHsFN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="361175127"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="361175127"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 05:07:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="666447465"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="666447465"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Feb 2023 05:07:31 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVuGw-0003CW-1O;
        Sat, 25 Feb 2023 13:07:30 +0000
Date:   Sat, 25 Feb 2023 21:07:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org
Subject: Re: [PATCH] bpf, docs: Document BPF insn encoding in term of stored
 bytes
Message-ID: <202302252028.csJFgGqg-lkp@intel.com>
References: <87y1om25l4.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1om25l4.fsf@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jose,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]
[cannot apply to bpf/master linus/master v6.2 next-20230225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jose-E-Marchesi/bpf-docs-Document-BPF-insn-encoding-in-term-of-stored-bytes/20230225-040647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/87y1om25l4.fsf%40oracle.com
patch subject: [PATCH] bpf, docs: Document BPF insn encoding in term of stored bytes
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/018d3423bad903b4544673361f6df2ea28ce047a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jose-E-Marchesi/bpf-docs-Document-BPF-insn-encoding-in-term-of-stored-bytes/20230225-040647
        git checkout 018d3423bad903b4544673361f6df2ea28ce047a
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302252028.csJFgGqg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/bpf/instruction-set.rst:75: WARNING: Definition list ends without a blank line; unexpected unindent.

vim +75 Documentation/bpf/instruction-set.rst

    70	
    71	  opcode         offset imm          assembly
    72	         src dst
    73	  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
    74	         dst src
  > 75	  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
