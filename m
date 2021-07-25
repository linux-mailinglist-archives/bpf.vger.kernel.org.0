Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694183D5011
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 23:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhGYUWA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 16:22:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:10903 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhGYUWA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Jul 2021 16:22:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="199319001"
X-IronPort-AV: E=Sophos;i="5.84,269,1620716400"; 
   d="gz'50?scan'50,208,50";a="199319001"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2021 14:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,269,1620716400"; 
   d="gz'50?scan'50,208,50";a="661627688"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2021 14:02:27 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m7lGU-0004qM-KJ; Sun, 25 Jul 2021 21:02:26 +0000
Date:   Mon, 26 Jul 2021 05:01:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kbuild-all@lists.01.org, andrii@kernel.org, kernel-team@fb.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH bpf-next 05/14] bpf: allow to specify user-provided
 context value for BPF perf links
Message-ID: <202107260441.7VT03OE1-lkp@intel.com>
References: <20210725173845.2593626-6-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20210725173845.2593626-6-andrii@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrii,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Andrii-Nakryiko/BPF-perf-link-and-user-provided-context-value/20210726-014304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7832c315a55580b578d21777a0c9476c62edd503
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andrii-Nakryiko/BPF-perf-link-and-user-provided-context-value/20210726-014304
        git checkout 7832c315a55580b578d21777a0c9476c62edd503
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/events/core.c:10073:5: error: conflicting types for 'perf_event_set_bpf_prog'
   10073 | int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:87,
                    from kernel/events/core.c:34:
   include/linux/trace_events.h:807:5: note: previous declaration of 'perf_event_set_bpf_prog' was here
     807 | int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 user_ctx);
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/perf_event_set_bpf_prog +10073 kernel/events/core.c

6fb2915df7f074 kernel/perf_event.c  Li Zefan           2009-10-15  10072  
aebdacfee76037 kernel/events/core.c Andrii Nakryiko    2021-07-25 @10073  int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
2541517c32be25 kernel/events/core.c Alexei Starovoitov 2015-03-25  10074  {
2541517c32be25 kernel/events/core.c Alexei Starovoitov 2015-03-25  10075  	return -ENOENT;
2541517c32be25 kernel/events/core.c Alexei Starovoitov 2015-03-25  10076  }
2541517c32be25 kernel/events/core.c Alexei Starovoitov 2015-03-25  10077  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--EVF5PPMfhYS0aIcm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/wNDQHRunKoAAA==

--EVF5PPMfhYS0aIcm--
