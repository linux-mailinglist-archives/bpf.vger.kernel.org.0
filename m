Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2EF204954
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 07:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgFWFwg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 01:52:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:39219 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbgFWFwg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 01:52:36 -0400
IronPort-SDR: c8eAmkzmYoPzfwopwxTR/8qeL0WNeFvCDnn6QsugwqXF05Zyv8d5kTOiBCFGb6ErexiDjfK2h2
 d8l7kk67lQ8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="124233652"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="gz'50?scan'50,208,50";a="124233652"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 22:47:33 -0700
IronPort-SDR: uCwG++sUiQnBnrildcxzeEPbAqwB3jsLlNi+L4lAWl8xblEDJeSepHcm96p0Hld3VizdxuY4Qt
 0bVIfQlji0Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="gz'50?scan'50,208,50";a="263204153"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2020 22:47:30 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnbmL-0000cs-QC; Tue, 23 Jun 2020 05:47:29 +0000
Date:   Tue, 23 Jun 2020 13:46:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next v3 05/15] bpf: add bpf_skc_to_tcp6_sock() helper
Message-ID: <202006231350.XQHZJ7GI%lkp@intel.com>
References: <20200623003631.3073864-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20200623003631.3073864-1-yhs@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yonghong,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Yonghong-Song/implement-bpf-iterator-for-tcp-and-udp-sockets/20200623-090149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: parisc-defconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: net/core/filter.o: in function `init_btf_sock_ids':
>> (.text+0xe878): undefined reference to `btf_find_by_name_kind'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--9amGYk9869ThD9tj--
