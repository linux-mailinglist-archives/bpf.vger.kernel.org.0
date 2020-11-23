Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F16A2C1805
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 22:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbgKWVwC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 16:52:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:9914 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731686AbgKWVwB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 16:52:01 -0500
IronPort-SDR: oUkUD9jIT4Z68d81ndC9P0sI9iMd5AwaG9HrusPqhoJlTHUvd9UCTwIjE6td7xmkg7YTJy4KWl
 XLkbnYf2usCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="168341276"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="gz'50?scan'50,208,50";a="168341276"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 13:52:00 -0800
IronPort-SDR: /ZxpJGqekXQ2eO2HhYdOLfFPct6+I1d5SxUHcIDD7V6X8ixYeRkkPDsO7CB/8J/vzQYSQDx1j2
 pBdrlLicKxHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="gz'50?scan'50,208,50";a="478264932"
Received: from lkp-server01.sh.intel.com (HELO 1138cb5768e3) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2020 13:51:57 -0800
Received: from kbuild by 1138cb5768e3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1khJka-0000DW-Vp; Mon, 23 Nov 2020 21:51:56 +0000
Date:   Tue, 24 Nov 2020 05:51:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@google.com>
Subject: Re: [PATCH 5/7] bpf: Add BPF_FETCH field / create atomic_fetch_add
 instruction
Message-ID: <202011240512.g0AQTfT8-lkp@intel.com>
References: <20201123173202.1335708-6-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20201123173202.1335708-6-jackmanb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brendan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master powerpc/next linus/master v5.10-rc5 next-20201123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Brendan-Jackman/Atomics-for-eBPF/20201124-013549
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: m68k-randconfig-r005-20201123 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b2b5923320904ef8c33183e8e88042588eb99397
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Brendan-Jackman/Atomics-for-eBPF/20201124-013549
        git checkout b2b5923320904ef8c33183e8e88042588eb99397
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/preempt.h:11,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/filter.h:10,
                    from kernel/bpf/core.c:21:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   kernel/bpf/core.c: At top level:
   kernel/bpf/core.c:1358:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1358 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/bpf/core.c:21:
   kernel/bpf/core.c: In function '___bpf_prog_run':
   include/linux/filter.h:899:3: warning: cast between incompatible function types from 'u64 (*)(u64,  u64,  u64,  u64,  u64)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int)'} to 'u64 (*)(u64,  u64,  u64,  u64,  u64,  const struct bpf_insn *)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  const struct bpf_insn *)'} [-Wcast-function-type]
     899 |  ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
         |   ^
   kernel/bpf/core.c:1526:13: note: in expansion of macro '__bpf_call_base_args'
    1526 |   BPF_R0 = (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
         |             ^~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/core.c:1656:5: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1656 |     (atomic64_t *)(s64) (DST + insn->off));
         |     ^
   In file included from kernel/bpf/core.c:21:
   kernel/bpf/core.c: In function 'bpf_patch_call_args':
   include/linux/filter.h:899:3: warning: cast between incompatible function types from 'u64 (*)(u64,  u64,  u64,  u64,  u64)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int)'} to 'u64 (*)(u64,  u64,  u64,  u64,  u64,  const struct bpf_insn *)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  const struct bpf_insn *)'} [-Wcast-function-type]
     899 |  ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
         |   ^
   kernel/bpf/core.c:1743:3: note: in expansion of macro '__bpf_call_base_args'
    1743 |   __bpf_call_base_args;
         |   ^~~~~~~~~~~~~~~~~~~~

vim +1656 kernel/bpf/core.c

  1628	
  1629		STX_ATOMIC_W:
  1630			switch (IMM) {
  1631			case BPF_ADD:
  1632				/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
  1633				atomic_add((u32) SRC, (atomic_t *)(unsigned long)
  1634					   (DST + insn->off));
  1635				break;
  1636			case BPF_ADD | BPF_FETCH:
  1637				SRC = (u32) atomic_fetch_add(
  1638					(u32) SRC,
  1639					(atomic_t *)(unsigned long) (DST + insn->off));
  1640				break;
  1641			default:
  1642				goto default_label;
  1643			}
  1644			CONT;
  1645	
  1646		STX_ATOMIC_DW:
  1647			switch (IMM) {
  1648			case BPF_ADD:
  1649				/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
  1650				atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
  1651					     (DST + insn->off));
  1652				break;
  1653			case BPF_ADD | BPF_FETCH:
  1654				SRC = (u64) atomic64_fetch_add(
  1655					(u64) SRC,
> 1656					(atomic64_t *)(s64) (DST + insn->off));
  1657				break;
  1658			default:
  1659				goto default_label;
  1660			}
  1661			CONT;
  1662	
  1663		default_label:
  1664			/* If we ever reach this, we have a bug somewhere. Die hard here
  1665			 * instead of just returning 0; we could be somewhere in a subprog,
  1666			 * so execution could continue otherwise which we do /not/ want.
  1667			 *
  1668			 * Note, verifier whitelists all opcodes in bpf_opcode_in_insntable().
  1669			 */
  1670			pr_warn("BPF interpreter: unknown opcode %02x (imm: 0x%x)\n",
  1671				insn->code, insn->imm);
  1672			BUG_ON(1);
  1673			return 0;
  1674	}
  1675	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6c2NcOVqGQ03X4Wi--
