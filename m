Return-Path: <bpf+bounces-14941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A197E9174
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 16:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4613C1C2040C
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E4914AB6;
	Sun, 12 Nov 2023 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzjpQTql"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950C14299
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 15:37:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E760A2683
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 07:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699803428; x=1731339428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+rGikK4Qo6QtlUFO84kfV1pxROXDN6ZfNpcss2LyoA=;
  b=LzjpQTqlOYSGGLfu7CW2DHsNasde1VQGPGaE37/x9My1NhxP5YCHlk+v
   8uM15RRFZXBShZHtjzd3Tgmc+/JQTGjSXiVyen1YxY1ZqCtokYWA7/NCn
   kNGBa08VJxbDGUCfBGwR1UOsc6YIiSHz3BTVTaPGMlgE20wKna7/VOjdR
   Bzq1YT/zMJajz0Y4rHePvFMnHauH6WGIVqZAuW8nSaanA2MNdtQgnnI5T
   Nn8oRPyBxiVk5iVdLaIeVLhY29a9qpPgi+4WQmNyHen1WELTCYhm/pYjP
   cv7re1aP735Wq+F6DKtnNbVhLKPiplYSU3km1GP0GfaK4Tzq/MRGeAASo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369664365"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="369664365"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 07:37:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937555804"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="937555804"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2023 07:37:03 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r2CWC-000BEy-31;
	Sun, 12 Nov 2023 15:37:00 +0000
Date: Sun, 12 Nov 2023 23:35:59 +0800
From: kernel test robot <lkp@intel.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, quentin@isovalent.com, eddyz87@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, masahiroy@kernel.org, bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v4 bpf-next 13/17] bpf: support standalone BTF in modules
Message-ID: <202311122307.bjlq3XJ5-lkp@intel.com>
References: <20231112124834.388735-14-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112124834.388735-14-alan.maguire@oracle.com>

Hi Alan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Alan-Maguire/btf-add-kind-layout-encoding-crcs-to-UAPI/20231112-205314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231112124834.388735-14-alan.maguire%40oracle.com
patch subject: [PATCH v4 bpf-next 13/17] bpf: support standalone BTF in modules
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20231112/202311122307.bjlq3XJ5-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311122307.bjlq3XJ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311122307.bjlq3XJ5-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/btf.c: In function 'btf_seq_show':
   kernel/bpf/btf.c:7447:29: warning: function 'btf_seq_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7447 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
         |                             ^~~~~~~~
   kernel/bpf/btf.c: In function 'btf_snprintf_show':
   kernel/bpf/btf.c:7484:9: warning: function 'btf_snprintf_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7484 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
         |         ^~~
   kernel/bpf/btf.c: In function 'btf_populate_kfunc_set':
>> kernel/bpf/btf.c:8153:44: error: implicit declaration of function 'btf_id_renumber'; did you mean 'btf_is_enum64'? [-Werror=implicit-function-declaration]
    8153 |                         set->pairs[i].id = btf_id_renumber(btf, set->pairs[i].id);
         |                                            ^~~~~~~~~~~~~~~
         |                                            btf_is_enum64
   cc1: some warnings being treated as errors


vim +8153 kernel/bpf/btf.c

  8046	
  8047	static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
  8048					  const struct btf_kfunc_id_set *kset)
  8049	{
  8050		struct btf_kfunc_hook_filter *hook_filter;
  8051		struct btf_id_set8 *add_set = kset->set;
  8052		bool vmlinux_set = !btf_is_module(btf);
  8053		bool add_filter = !!kset->filter;
  8054		struct btf_kfunc_set_tab *tab;
  8055		struct btf_id_set8 *set;
  8056		u32 set_cnt;
  8057		int ret;
  8058	
  8059		if (hook >= BTF_KFUNC_HOOK_MAX) {
  8060			ret = -EINVAL;
  8061			goto end;
  8062		}
  8063	
  8064		if (!add_set->cnt)
  8065			return 0;
  8066	
  8067		tab = btf->kfunc_set_tab;
  8068	
  8069		if (tab && add_filter) {
  8070			u32 i;
  8071	
  8072			hook_filter = &tab->hook_filters[hook];
  8073			for (i = 0; i < hook_filter->nr_filters; i++) {
  8074				if (hook_filter->filters[i] == kset->filter) {
  8075					add_filter = false;
  8076					break;
  8077				}
  8078			}
  8079	
  8080			if (add_filter && hook_filter->nr_filters == BTF_KFUNC_FILTER_MAX_CNT) {
  8081				ret = -E2BIG;
  8082				goto end;
  8083			}
  8084		}
  8085	
  8086		if (!tab) {
  8087			tab = kzalloc(sizeof(*tab), GFP_KERNEL | __GFP_NOWARN);
  8088			if (!tab)
  8089				return -ENOMEM;
  8090			btf->kfunc_set_tab = tab;
  8091		}
  8092	
  8093		set = tab->sets[hook];
  8094		/* Warn when register_btf_kfunc_id_set is called twice for the same hook
  8095		 * for module sets.
  8096		 */
  8097		if (WARN_ON_ONCE(set && !vmlinux_set)) {
  8098			ret = -EINVAL;
  8099			goto end;
  8100		}
  8101	
  8102		/* We don't need to allocate, concatenate, and sort module sets, because
  8103		 * only one is allowed per hook. Hence, we can directly assign the
  8104		 * pointer and return.
  8105		 */
  8106		if (!vmlinux_set) {
  8107			tab->sets[hook] = add_set;
  8108			goto do_add_filter;
  8109		}
  8110	
  8111		/* In case of vmlinux sets, there may be more than one set being
  8112		 * registered per hook. To create a unified set, we allocate a new set
  8113		 * and concatenate all individual sets being registered. While each set
  8114		 * is individually sorted, they may become unsorted when concatenated,
  8115		 * hence re-sorting the final set again is required to make binary
  8116		 * searching the set using btf_id_set8_contains function work.
  8117		 */
  8118		set_cnt = set ? set->cnt : 0;
  8119	
  8120		if (set_cnt > U32_MAX - add_set->cnt) {
  8121			ret = -EOVERFLOW;
  8122			goto end;
  8123		}
  8124	
  8125		if (set_cnt + add_set->cnt > BTF_KFUNC_SET_MAX_CNT) {
  8126			ret = -E2BIG;
  8127			goto end;
  8128		}
  8129	
  8130		/* Grow set */
  8131		set = krealloc(tab->sets[hook],
  8132			       offsetof(struct btf_id_set8, pairs[set_cnt + add_set->cnt]),
  8133			       GFP_KERNEL | __GFP_NOWARN);
  8134		if (!set) {
  8135			ret = -ENOMEM;
  8136			goto end;
  8137		}
  8138	
  8139		/* For newly allocated set, initialize set->cnt to 0 */
  8140		if (!tab->sets[hook])
  8141			set->cnt = 0;
  8142		tab->sets[hook] = set;
  8143	
  8144		/* Concatenate the two sets */
  8145		memcpy(set->pairs + set->cnt, add_set->pairs, add_set->cnt * sizeof(set->pairs[0]));
  8146		if (btf->standalone_btf) {
  8147			u32 i;
  8148	
  8149			/* renumber BTF ids since BTF is standalone and has been mapped to look
  8150			 * like split BTF, while BTF kfunc ids are still old unmapped values.
  8151			 */
  8152			for (i = set->cnt; i < set->cnt + add_set->cnt; i++)
> 8153				set->pairs[i].id = btf_id_renumber(btf, set->pairs[i].id);
  8154		}
  8155	
  8156		set->cnt += add_set->cnt;
  8157	
  8158		sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
  8159	
  8160	do_add_filter:
  8161		if (add_filter) {
  8162			hook_filter = &tab->hook_filters[hook];
  8163			hook_filter->filters[hook_filter->nr_filters++] = kset->filter;
  8164		}
  8165		return 0;
  8166	end:
  8167		btf_free_kfunc_set_tab(btf);
  8168		return ret;
  8169	}
  8170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

