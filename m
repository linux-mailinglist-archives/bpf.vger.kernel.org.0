Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F822D4F53
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 01:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgLJAXD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 19:23:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:4671 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbgLJAXD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 19:23:03 -0500
IronPort-SDR: PEqb1ot+xb1MKz0LY5WwUpREHREMosX/mWQu7Bx30OAcwDa4KRy++BkXp6mT3o2Yt0VBM/S7s3
 kFIVLzZGAvrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="161222761"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="gz'50?scan'50,208,50";a="161222761"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 16:22:21 -0800
IronPort-SDR: 52cADnH1r0yOaiQUlc7MUeAZYgCmWG61AFyOTnztJtAM8kQDb8coDmRfIrkMqiPhUR9QNu8PXZ
 A44zNnTWPXiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="gz'50?scan'50,208,50";a="376724163"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Dec 2020 16:22:18 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kn9ir-0000XE-EL; Thu, 10 Dec 2020 00:22:17 +0000
Date:   Thu, 10 Dec 2020 08:22:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Subject: Re: [PATCH bpf-next v4 09/11] bpf: Add bitwise atomic instructions
Message-ID: <202012100813.QjYZ7tix-lkp@intel.com>
References: <20201207160734.2345502-10-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20201207160734.2345502-10-jackmanb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brendan,

I love your patch! Yet something to improve:

[auto build test ERROR on 34da87213d3ddd26643aa83deff7ffc6463da0fc]

url:    https://github.com/0day-ci/linux/commits/Brendan-Jackman/Atomics-for-eBPF/20201208-001343
base:    34da87213d3ddd26643aa83deff7ffc6463da0fc
config: m68k-randconfig-r022-20201209 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2a65bda50b756e76e985b1d2bba80b3023a9cdc3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Brendan-Jackman/Atomics-for-eBPF/20201208-001343
        git checkout 2a65bda50b756e76e985b1d2bba80b3023a9cdc3
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/core.c:1350:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1350 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/bpf/core.c:21:
   kernel/bpf/core.c: In function '___bpf_prog_run':
   include/linux/filter.h:1000:3: warning: cast between incompatible function types from 'u64 (*)(u64,  u64,  u64,  u64,  u64)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int)'} to 'u64 (*)(u64,  u64,  u64,  u64,  u64,  const struct bpf_insn *)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  const struct bpf_insn *)'} [-Wcast-function-type]
    1000 |  ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
         |   ^
   kernel/bpf/core.c:1518:13: note: in expansion of macro '__bpf_call_base_args'
    1518 |   BPF_R0 = (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
         |             ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:1638:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1638 |      (atomic64_t *)(s64) (DST + insn->off)); \
         |      ^
   kernel/bpf/core.c:1644:3: note: in expansion of macro 'ATOMIC_ALU_OP'
    1644 |   ATOMIC_ALU_OP(BPF_ADD, add)
         |   ^~~~~~~~~~~~~
   kernel/bpf/core.c:1638:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1638 |      (atomic64_t *)(s64) (DST + insn->off)); \
         |      ^
   kernel/bpf/core.c:1645:3: note: in expansion of macro 'ATOMIC_ALU_OP'
    1645 |   ATOMIC_ALU_OP(BPF_AND, and)
         |   ^~~~~~~~~~~~~
   kernel/bpf/core.c:1638:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1638 |      (atomic64_t *)(s64) (DST + insn->off)); \
         |      ^
   kernel/bpf/core.c:1646:3: note: in expansion of macro 'ATOMIC_ALU_OP'
    1646 |   ATOMIC_ALU_OP(BPF_OR, or)
         |   ^~~~~~~~~~~~~
   kernel/bpf/core.c:1638:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1638 |      (atomic64_t *)(s64) (DST + insn->off)); \
         |      ^
   kernel/bpf/core.c:1647:3: note: in expansion of macro 'ATOMIC_ALU_OP'
    1647 |   ATOMIC_ALU_OP(BPF_XOR, xor)
         |   ^~~~~~~~~~~~~
   kernel/bpf/core.c:1657:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1657 |      (atomic64_t *)(u64) (DST + insn->off),
         |      ^
   kernel/bpf/core.c:1667:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1667 |      (atomic64_t *)(u64) (DST + insn->off),
         |      ^
   In file included from kernel/bpf/core.c:21:
   kernel/bpf/core.c: In function 'bpf_patch_call_args':
   include/linux/filter.h:1000:3: warning: cast between incompatible function types from 'u64 (*)(u64,  u64,  u64,  u64,  u64)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int)'} to 'u64 (*)(u64,  u64,  u64,  u64,  u64,  const struct bpf_insn *)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  const struct bpf_insn *)'} [-Wcast-function-type]
    1000 |  ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
         |   ^
   kernel/bpf/core.c:1756:3: note: in expansion of macro '__bpf_call_base_args'
    1756 |   __bpf_call_base_args;
         |   ^~~~~~~~~~~~~~~~~~~~
   {standard input}: Assembler messages:
>> {standard input}:3068: Error: operands mismatch -- statement `orl %a1,%d0' ignored
   {standard input}:3068: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `casl %d4,%d0,(%a6)' ignored
   {standard input}:3116: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `casl %d1,%d5,(%a6,%d0.l)' ignored
   {standard input}:3163: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `casl %d4,%d0,(%a6)' ignored
>> {standard input}:3225: Error: operands mismatch -- statement `andl %a1,%d0' ignored
   {standard input}:3225: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `casl %d4,%d0,(%a6)' ignored
>> {standard input}:3290: Error: operands mismatch -- statement `eorl %a1,%d0' ignored
   {standard input}:3290: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `casl %d4,%d0,(%a6)' ignored
   {standard input}:3316: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `casl %d0,%d5,(%a0)' ignored

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vkogqOf2sHV7VnPd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
L/mHCZbI9n/6pfVALaYBAA==

--vkogqOf2sHV7VnPd--
