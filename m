Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD9944E0E2
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 04:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhKLDqE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 22:46:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:24339 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhKLDqE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 22:46:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="213793946"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="gz'50?scan'50,208,50";a="213793946"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 19:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="gz'50?scan'50,208,50";a="733728830"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2021 19:43:09 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mlNT2-000HYu-QS; Fri, 12 Nov 2021 03:43:08 +0000
Date:   Fri, 12 Nov 2021 11:42:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf] bpf: Make CONFIG_DEBUG_INFO_BTF depend upon
 CONFIG_BPF_SYSCALL
Message-ID: <202111121155.LRtqvtpx-lkp@intel.com>
References: <20211112015934.527181-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20211112015934.527181-1-memxor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kumar,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf/master]

url:    https://github.com/0day-ci/linux/commits/Kumar-Kartikeya-Dwivedi/bpf-Make-CONFIG_DEBUG_INFO_BTF-depend-upon-CONFIG_BPF_SYSCALL/20211112-100114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
config: openrisc-buildonly-randconfig-r003-20211111 (attached as .config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ea181ce7046ae7f916b4ede6b04c48416d89b0b2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kumar-Kartikeya-Dwivedi/bpf-Make-CONFIG_DEBUG_INFO_BTF-depend-upon-CONFIG_BPF_SYSCALL/20211112-100114
        git checkout ea181ce7046ae7f916b4ede6b04c48416d89b0b2
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/btf.c: In function 'btf_seq_show':
   kernel/bpf/btf.c:5876:29: error: function 'btf_seq_show' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
    5876 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
         |                             ^~~~~~~~
   kernel/bpf/btf.c: In function 'btf_snprintf_show':
   kernel/bpf/btf.c:5913:9: error: function 'btf_snprintf_show' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
    5913 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
         |         ^~~
   kernel/bpf/btf.c: At top level:
>> kernel/bpf/btf.c:6349:8: error: redefinition of 'struct kfunc_btf_id_list'
    6349 | struct kfunc_btf_id_list {
         |        ^~~~~~~~~~~~~~~~~
   In file included from include/linux/bpf_verifier.h:8,
                    from kernel/bpf/btf.c:19:
   include/linux/btf.h:275:8: note: originally defined here
     275 | struct kfunc_btf_id_list {};
         |        ^~~~~~~~~~~~~~~~~
>> kernel/bpf/btf.c:6399:26: error: conflicting types for 'bpf_tcp_ca_kfunc_list'; have 'struct kfunc_btf_id_list'
    6399 | DEFINE_KFUNC_BTF_ID_LIST(bpf_tcp_ca_kfunc_list);
         |                          ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/btf.c:6395:34: note: in definition of macro 'DEFINE_KFUNC_BTF_ID_LIST'
    6395 |         struct kfunc_btf_id_list name = { LIST_HEAD_INIT(name.list),           \
         |                                  ^~~~
   In file included from include/linux/bpf_verifier.h:8,
                    from kernel/bpf/btf.c:19:
   include/linux/btf.h:276:33: note: previous declaration of 'bpf_tcp_ca_kfunc_list' with type 'struct kfunc_btf_id_list'
     276 | static struct kfunc_btf_id_list bpf_tcp_ca_kfunc_list __maybe_unused;
         |                                 ^~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/btf.c:6400:26: error: conflicting types for 'prog_test_kfunc_list'; have 'struct kfunc_btf_id_list'
    6400 | DEFINE_KFUNC_BTF_ID_LIST(prog_test_kfunc_list);
         |                          ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/btf.c:6395:34: note: in definition of macro 'DEFINE_KFUNC_BTF_ID_LIST'
    6395 |         struct kfunc_btf_id_list name = { LIST_HEAD_INIT(name.list),           \
         |                                  ^~~~
   In file included from include/linux/bpf_verifier.h:8,
                    from kernel/bpf/btf.c:19:
   include/linux/btf.h:277:33: note: previous declaration of 'prog_test_kfunc_list' with type 'struct kfunc_btf_id_list'
     277 | static struct kfunc_btf_id_list prog_test_kfunc_list __maybe_unused;
         |                                 ^~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +6349 kernel/bpf/btf.c

14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6348  
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02 @6349  struct kfunc_btf_id_list {
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6350  	struct list_head list;
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6351  	struct mutex mutex;
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6352  };
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6353  
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6354  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6355  
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6356  void register_kfunc_btf_id_set(struct kfunc_btf_id_list *l,
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6357  			       struct kfunc_btf_id_set *s)
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6358  {
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6359  	mutex_lock(&l->mutex);
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6360  	list_add(&s->list, &l->list);
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6361  	mutex_unlock(&l->mutex);
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6362  }
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6363  EXPORT_SYMBOL_GPL(register_kfunc_btf_id_set);
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6364  
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6365  void unregister_kfunc_btf_id_set(struct kfunc_btf_id_list *l,
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6366  				 struct kfunc_btf_id_set *s)
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6367  {
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6368  	mutex_lock(&l->mutex);
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6369  	list_del_init(&s->list);
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6370  	mutex_unlock(&l->mutex);
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6371  }
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6372  EXPORT_SYMBOL_GPL(unregister_kfunc_btf_id_set);
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6373  
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6374  bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist, u32 kfunc_id,
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6375  			      struct module *owner)
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6376  {
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6377  	struct kfunc_btf_id_set *s;
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6378  
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6379  	if (!owner)
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6380  		return false;
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6381  	mutex_lock(&klist->mutex);
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6382  	list_for_each_entry(s, &klist->list, list) {
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6383  		if (s->owner == owner && btf_id_set_contains(s->set, kfunc_id)) {
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6384  			mutex_unlock(&klist->mutex);
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6385  			return true;
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6386  		}
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6387  	}
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6388  	mutex_unlock(&klist->mutex);
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6389  	return false;
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6390  }
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6391  
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6392  #endif
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6393  
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6394  #define DEFINE_KFUNC_BTF_ID_LIST(name)                                         \
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6395  	struct kfunc_btf_id_list name = { LIST_HEAD_INIT(name.list),           \
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6396  					  __MUTEX_INITIALIZER(name.mutex) };   \
14f267d95fe4b08 Kumar Kartikeya Dwivedi 2021-10-02  6397  	EXPORT_SYMBOL_GPL(name)
0e32dfc80bae53b Kumar Kartikeya Dwivedi 2021-10-02  6398  
0e32dfc80bae53b Kumar Kartikeya Dwivedi 2021-10-02 @6399  DEFINE_KFUNC_BTF_ID_LIST(bpf_tcp_ca_kfunc_list);
c48e51c8b07aba8 Kumar Kartikeya Dwivedi 2021-10-02 @6400  DEFINE_KFUNC_BTF_ID_LIST(prog_test_kfunc_list);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--T4sUOijqQbZv57TR
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
JlH1pG28LZXO/w8jiVkyqXUBAA==

--T4sUOijqQbZv57TR--
