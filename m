Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B368CA0005
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2019 12:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH1KjT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Aug 2019 06:39:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:42409 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfH1KjT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Aug 2019 06:39:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 03:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="gz'50?scan'50,208,50";a="210123944"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2019 03:39:12 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i2vM7-0003l7-VB; Wed, 28 Aug 2019 18:39:11 +0800
Date:   Wed, 28 Aug 2019 18:38:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     kbuild-all@01.org, luto@amacapital.net, davem@davemloft.net,
        daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com, linux-api@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, capabilities: introduce CAP_BPF
Message-ID: <201908281810.Rg8jReyH%lkp@intel.com>
References: <20190827205213.456318-1-ast@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vgl2l3tbz2zbpbdi"
Content-Disposition: inline
In-Reply-To: <20190827205213.456318-1-ast@kernel.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--vgl2l3tbz2zbpbdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexei,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Alexei-Starovoitov/bpf-capabilities-introduce-CAP_BPF/20190828-142441
base:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: ia64-defconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/core.c: In function 'cap_bpf_tracing':
>> kernel/bpf/core.c:2110:31: error: implicit declaration of function 'perf_paranoid_tracepoint_raw' [-Werror=implicit-function-declaration]
            (capable(CAP_BPF) && !perf_paranoid_tracepoint_raw());
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/perf_paranoid_tracepoint_raw +2110 kernel/bpf/core.c

  2106	
  2107	bool cap_bpf_tracing(void)
  2108	{
  2109		return capable(CAP_SYS_ADMIN) ||
> 2110		       (capable(CAP_BPF) && !perf_paranoid_tracepoint_raw());
  2111	}
  2112	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--vgl2l3tbz2zbpbdi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--vgl2l3tbz2zbpbdi--
