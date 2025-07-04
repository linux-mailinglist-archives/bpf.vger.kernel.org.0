Return-Path: <bpf+bounces-62405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49021AF978F
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0D51CA41E3
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B2632622E;
	Fri,  4 Jul 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgTmUMjQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8653074B1;
	Fri,  4 Jul 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645240; cv=none; b=q8OBSR47kGDfL3GfsHrTEMeUlmAZRDIa93Laj7CZUEJi9BT6BM167zpcYrUaZ9CokPlRrBKfEbIHykDSiePTSti7rY8tf+aT9KoRX+vyjt+vCoSkE/WErB+a6+n+Btc4Nc0X5BEtRJObalcU9aoVcPSK/WRgYeNdfQxJBCoC5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645240; c=relaxed/simple;
	bh=MkmKpbXa2WU1gPxLZLRTmJQwGnXz/AJXnzeupkBRIFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXGVmwloeEqccBv/8ZUs6/I9teDFFvNLzraSxYxI0/EqIFrAMb7r0GDtTA2HAhwbMmjlLqpURxNvLbAPM8o/Dr+N67jb0tGUWsn5xczepEDj5sKawcBo//X2x7K9MAbpXlIc5p/fXSdSIBrrwm0B7Gd/FKGlRALnCCu2QdooF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgTmUMjQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751645238; x=1783181238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MkmKpbXa2WU1gPxLZLRTmJQwGnXz/AJXnzeupkBRIFw=;
  b=hgTmUMjQ0wriM+gQA72ONY/ZV1p0KLLhApyLP2OfVvO4V8N87yWIJwmm
   W/i7kTLXCrF0yQhw5uJMf9eBlwD+e/IxdkFeDQQ89MLuz9TED+Q21It2l
   QKQedZnxx0x5SVsZGCRjyvgXH5L1QzzXL+Mpjs2ozfGKtN0FH1JMd3pb2
   89HLCllnOMCeNAPMqcFOCRQkvYHGauFv7hC0q+ZHZQIpXujtPzzUfysoc
   0CKDOFH96FAaaV5gUdT9vABL75baKSR25PACAaOpic9yLJs2rSTWMVqW2
   YYpHQmH4GnbzEYJ+G2gn17TWduCZ5PXGr/IxDsb+NXssxVBMQ/J/i7RU2
   w==;
X-CSE-ConnectionGUID: JgoVjq34S9uNZjMbk8MdNg==
X-CSE-MsgGUID: bft3Fp3wQCma4gg7LYaLNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="53847696"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="53847696"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 09:07:17 -0700
X-CSE-ConnectionGUID: 3OO6OohTSnSnAydMxERCvg==
X-CSE-MsgGUID: adG+EnDtTbKabAV5v9fUJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="185690625"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Jul 2025 09:07:13 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXiwR-0003sB-0T;
	Fri, 04 Jul 2025 16:07:11 +0000
Date: Sat, 5 Jul 2025 00:07:05 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
	rostedt@goodmis.org, jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 01/18] bpf: add function hash table for
 tracing-multi
Message-ID: <202507042321.HJfEZMgT-lkp@intel.com>
References: <20250703121521.1874196-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703121521.1874196-2-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/bpf-add-function-hash-table-for-tracing-multi/20250703-203035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250703121521.1874196-2-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next v2 01/18] bpf: add function hash table for tracing-multi
config: i386-randconfig-062-20250704 (https://download.01.org/0day-ci/archive/20250704/202507042321.HJfEZMgT-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507042321.HJfEZMgT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507042321.HJfEZMgT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/kfunc_md.c:14:23: sparse: sparse: symbol 'default_mds' was not declared. Should it be static?
>> kernel/bpf/kfunc_md.c:21:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct kfunc_md_array [noderef] __rcu *[addressable] [toplevel] kfunc_mds @@     got struct kfunc_md_array * @@
   kernel/bpf/kfunc_md.c:21:43: sparse:     expected struct kfunc_md_array [noderef] __rcu *[addressable] [toplevel] kfunc_mds
   kernel/bpf/kfunc_md.c:21:43: sparse:     got struct kfunc_md_array *
>> kernel/bpf/kfunc_md.c:186:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t const [usertype] *v @@     got struct atomic_t [noderef] __rcu * @@
   kernel/bpf/kfunc_md.c:186:26: sparse:     expected struct atomic_t const [usertype] *v
   kernel/bpf/kfunc_md.c:186:26: sparse:     got struct atomic_t [noderef] __rcu *
>> kernel/bpf/kfunc_md.c:111:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct kfunc_md_array *mds @@     got struct kfunc_md_array [noderef] __rcu *extern [addressable] [toplevel] kfunc_mds @@
   kernel/bpf/kfunc_md.c:111:32: sparse:     expected struct kfunc_md_array *mds
   kernel/bpf/kfunc_md.c:111:32: sparse:     got struct kfunc_md_array [noderef] __rcu *extern [addressable] [toplevel] kfunc_mds
>> kernel/bpf/kfunc_md.c:153:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct kfunc_md_array *old_mds @@     got struct kfunc_md_array [noderef] __rcu *extern [addressable] [toplevel] kfunc_mds @@
   kernel/bpf/kfunc_md.c:153:17: sparse:     expected struct kfunc_md_array *old_mds
   kernel/bpf/kfunc_md.c:153:17: sparse:     got struct kfunc_md_array [noderef] __rcu *extern [addressable] [toplevel] kfunc_mds
   kernel/bpf/kfunc_md.c:194:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t const [usertype] *v @@     got struct atomic_t [noderef] __rcu * @@
   kernel/bpf/kfunc_md.c:194:26: sparse:     expected struct atomic_t const [usertype] *v
   kernel/bpf/kfunc_md.c:194:26: sparse:     got struct atomic_t [noderef] __rcu *
>> kernel/bpf/kfunc_md.c:214:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *v @@     got struct atomic_t [noderef] __rcu * @@
   kernel/bpf/kfunc_md.c:214:21: sparse:     expected struct atomic_t [usertype] *v
   kernel/bpf/kfunc_md.c:214:21: sparse:     got struct atomic_t [noderef] __rcu *
   kernel/bpf/kfunc_md.c:238:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t const [usertype] *v @@     got struct atomic_t [noderef] __rcu * @@
   kernel/bpf/kfunc_md.c:238:30: sparse:     expected struct atomic_t const [usertype] *v
   kernel/bpf/kfunc_md.c:238:30: sparse:     got struct atomic_t [noderef] __rcu *
>> kernel/bpf/kfunc_md.c:126:21: sparse: sparse: dereference of noderef expression
   kernel/bpf/kfunc_md.c:139:31: sparse: sparse: dereference of noderef expression
   kernel/bpf/kfunc_md.c:140:17: sparse: sparse: dereference of noderef expression
   kernel/bpf/kfunc_md.c:186:57: sparse: sparse: dereference of noderef expression
   kernel/bpf/kfunc_md.c:194:57: sparse: sparse: dereference of noderef expression
   kernel/bpf/kfunc_md.c:197:13: sparse: sparse: dereference of noderef expression
   kernel/bpf/kfunc_md.c:248:35: sparse: sparse: dereference of noderef expression
   kernel/bpf/kfunc_md.c:249:17: sparse: sparse: dereference of noderef expression

vim +/default_mds +14 kernel/bpf/kfunc_md.c

    12	
    13	#define MIN_KFUNC_MD_ARRAY_BITS 4
  > 14	struct kfunc_md_array default_mds = {
    15		.used = ATOMIC_INIT(0),
    16		.hash_bits = MIN_KFUNC_MD_ARRAY_BITS,
    17		.mds = {
    18			[0 ... ((1 << MIN_KFUNC_MD_ARRAY_BITS) - 1)] = HLIST_HEAD_INIT,
    19		},
    20	};
  > 21	struct kfunc_md_array __rcu *kfunc_mds = &default_mds;
    22	EXPORT_SYMBOL_GPL(kfunc_mds);
    23	
    24	static DEFINE_MUTEX(kfunc_md_mutex);
    25	
    26	static int kfunc_md_array_inc(void);
    27	
    28	static void kfunc_md_release_rcu(struct rcu_head *rcu)
    29	{
    30		struct kfunc_md *md;
    31	
    32		md = container_of(rcu, struct kfunc_md, rcu);
    33		/* Step 4, free the md */
    34		kfree(md);
    35	}
    36	
    37	static void kfunc_md_release_rcu_tasks(struct rcu_head *rcu)
    38	{
    39		struct kfunc_md *md;
    40	
    41		md = container_of(rcu, struct kfunc_md, rcu);
    42		/* Step 3, wait for the nornal progs and bfp_global_caller to finish */
    43		call_rcu_tasks(&md->rcu, kfunc_md_release_rcu);
    44	}
    45	
    46	static void kfunc_md_release(struct percpu_ref *pcref)
    47	{
    48		struct kfunc_md *md;
    49	
    50		md = container_of(pcref, struct kfunc_md, pcref);
    51		percpu_ref_exit(&md->pcref);
    52	
    53		/* Step 2, wait for sleepable progs to finish. */
    54		call_rcu_tasks_trace(&md->rcu, kfunc_md_release_rcu_tasks);
    55	}
    56	
    57	struct kfunc_md *kfunc_md_get(unsigned long ip)
    58	{
    59		struct kfunc_md_array *mds;
    60		struct kfunc_md *md;
    61	
    62		rcu_read_lock();
    63		mds = rcu_dereference(kfunc_mds);
    64		md = __kfunc_md_get(mds, ip);
    65		rcu_read_unlock();
    66	
    67		return md;
    68	}
    69	EXPORT_SYMBOL_GPL(kfunc_md_get);
    70	
    71	static struct kfunc_md *__kfunc_md_create(struct kfunc_md_array *mds, unsigned long ip,
    72						  int nr_args)
    73	{
    74		struct kfunc_md *md = __kfunc_md_get(mds, ip);
    75		int err;
    76	
    77		if (md) {
    78			md->users++;
    79			return md;
    80		}
    81	
    82		md = kzalloc(sizeof(*md), GFP_KERNEL);
    83		if (!md)
    84			return NULL;
    85	
    86		md->users = 1;
    87		md->func = ip;
    88		md->nr_args = nr_args;
    89	
    90		err = percpu_ref_init(&md->pcref, kfunc_md_release, 0, GFP_KERNEL);
    91		if (err) {
    92			kfree(md);
    93			return NULL;
    94		}
    95	
    96		hlist_add_head_rcu(&md->hash, kfunc_md_hash_head(mds, ip));
    97		atomic_inc(&mds->used);
    98	
    99		return md;
   100	}
   101	
   102	struct kfunc_md *kfunc_md_create(unsigned long ip, int nr_args)
   103	{
   104		struct kfunc_md *md = NULL;
   105	
   106		mutex_lock(&kfunc_md_mutex);
   107	
   108		if (kfunc_md_array_inc())
   109			goto out;
   110	
 > 111		md = __kfunc_md_create(kfunc_mds, ip, nr_args);
   112	out:
   113		mutex_unlock(&kfunc_md_mutex);
   114	
   115		return md;
   116	}
   117	EXPORT_SYMBOL_GPL(kfunc_md_create);
   118	
   119	static int kfunc_md_array_adjust(bool inc)
   120	{
   121		struct kfunc_md_array *new_mds, *old_mds;
   122		struct kfunc_md *md, *new_md;
   123		struct hlist_node *n;
   124		int size, hash_bits, i;
   125	
 > 126		hash_bits = kfunc_mds->hash_bits;
   127		hash_bits += inc ? 1 : -1;
   128	
   129		size = sizeof(*new_mds) + sizeof(struct hlist_head) * (1 << hash_bits);
   130		new_mds = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
   131		if (!new_mds)
   132			return -ENOMEM;
   133	
   134		new_mds->hash_bits = hash_bits;
   135		for (i = 0; i < (1 << new_mds->hash_bits); i++)
   136			INIT_HLIST_HEAD(&new_mds->mds[i]);
   137	
   138		/* copy all the mds from kfunc_mds to new_mds */
   139		for (i = 0; i < (1 << kfunc_mds->hash_bits); i++) {
   140			hlist_for_each_entry(md, &kfunc_mds->mds[i], hash) {
   141				new_md = __kfunc_md_create(new_mds, md->func, md->nr_args);
   142				if (!new_md)
   143					goto err_out;
   144	
   145				new_md->bpf_prog_cnt = md->bpf_prog_cnt;
   146				new_md->bpf_origin_call = md->bpf_origin_call;
   147				new_md->users = md->users;
   148	
   149				memcpy(new_md->bpf_progs, md->bpf_progs, sizeof(md->bpf_progs));
   150			}
   151		}
   152	
 > 153		old_mds = kfunc_mds;
   154		rcu_assign_pointer(kfunc_mds, new_mds);
   155		synchronize_rcu();
   156	
   157		/* free all the mds in the old_mds. See kfunc_md_put() for the
   158		 * complete release process.
   159		 */
   160		for (i = 0; i < (1 << old_mds->hash_bits); i++) {
   161			hlist_for_each_entry_safe(md, n, &old_mds->mds[i], hash) {
   162				percpu_ref_kill(&md->pcref);
   163				hlist_del(&md->hash);
   164			}
   165		}
   166	
   167		if (old_mds != &default_mds)
   168			kfree_rcu(old_mds, rcu);
   169	
   170		return 0;
   171	
   172	err_out:
   173		for (i = 0; i < (1 << new_mds->hash_bits); i++) {
   174			hlist_for_each_entry_safe(md, n, &new_mds->mds[i], hash) {
   175				percpu_ref_exit(&md->pcref);
   176				hlist_del(&md->hash);
   177				kfree(md);
   178			}
   179		}
   180		return -ENOMEM;
   181	}
   182	
   183	static int kfunc_md_array_inc(void)
   184	{
   185		/* increase the hash table if greater than 90% */
 > 186		if (atomic_read(&kfunc_mds->used) * 10 < (1 << (kfunc_mds->hash_bits)) * 9)
   187			return 0;
   188		return kfunc_md_array_adjust(true);
   189	}
   190	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

