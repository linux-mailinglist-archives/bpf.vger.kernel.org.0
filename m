Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C27141784
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2020 13:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgARMpR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Jan 2020 07:45:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:45560 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbgARMpR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Jan 2020 07:45:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 04:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,334,1574150400"; 
   d="gz'50?scan'50,208,50";a="226632304"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2020 04:45:10 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1isnTS-000D0M-3r; Sat, 18 Jan 2020 20:45:10 +0800
Date:   Sat, 18 Jan 2020 20:44:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v2 01/10] bpf: btf: Make some of the API visible
 outside BTF
Message-ID: <202001182045.QaQ0kGP8%lkp@intel.com>
References: <20200115171333.28811-2-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="j7t7g5ldapqxci7t"
Content-Disposition: inline
In-Reply-To: <20200115171333.28811-2-kpsingh@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--j7t7g5ldapqxci7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi KP,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20200116]
[cannot apply to bpf-next/master bpf/master linus/master security/next-testing v5.5-rc6 v5.5-rc5 v5.5-rc4 v5.5-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/KP-Singh/MAC-and-Audit-policy-using-eBPF-KRSI/20200117-070342
base:    2747d5fdab78f43210256cd52fb2718e0b3cce74
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/core.c:27:
>> include/linux/btf.h:148:38: error: static declaration of 'btf_type_by_name_kind' follows non-static declaration
     148 | static inline const struct btf_type *btf_type_by_name_kind(
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   include/linux/btf.h:70:24: note: previous declaration of 'btf_type_by_name_kind' was here
      70 | const struct btf_type *btf_type_by_name_kind(
         |                        ^~~~~~~~~~~~~~~~~~~~~

vim +/btf_type_by_name_kind +148 include/linux/btf.h

   136	
   137	#ifdef CONFIG_BPF_SYSCALL
   138	const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
   139	const char *btf_name_by_offset(const struct btf *btf, u32 offset);
   140	struct btf *btf_parse_vmlinux(void);
   141	struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
   142	#else
   143	static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
   144							    u32 type_id)
   145	{
   146		return NULL;
   147	}
 > 148	static inline const struct btf_type *btf_type_by_name_kind(
   149		struct btf *btf, const char *name, u8 kind)
   150	{
   151		return ERR_PTR(-EOPNOTSUPP);
   152	}
   153	static inline const char *btf_name_by_offset(const struct btf *btf,
   154						     u32 offset)
   155	{
   156		return NULL;
   157	}
   158	#endif
   159	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--j7t7g5ldapqxci7t
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
S7vs/wBwZ7BEV6kAAA==

--j7t7g5ldapqxci7t--
