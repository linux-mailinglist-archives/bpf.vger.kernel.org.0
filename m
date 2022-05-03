Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A161518AFA
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 19:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiECR0y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 May 2022 13:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbiECR0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 May 2022 13:26:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554FA240BE
        for <bpf@vger.kernel.org>; Tue,  3 May 2022 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651598601; x=1683134601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e4PDE2mGbZRg4qxmE9bSu18bomIt8xkIzFptIx2JBiY=;
  b=kc3+LFkaWDaQ5eCOyNwFepcHz8oqJlJbMDGcDvl5gf5csajQTUmpfpJx
   dHp0lEuG03iDFR3mS93rfWEGJ7V3QASH+wyhQMU5I8IeUXzz0tJDr97cG
   nZ3OXZ41aE/Piz+p0ZAUim/Egb5oYwvnQysPZ/HWuq7RqV2NNZ6/R9ITu
   Znnzi/PGMFqhweKJCf9fzxrExJ2aKZFMjIha/miGtbQqOSl2yCk49oeuE
   FfqRHH6zAiNM5N1JJZDmpwkZmD61lhm69vIKAZ3N/7gc/YamioglA973A
   5ORGiQQzqKXo3V6eZmvQkTzaqDwTVpMxkSnzBm2nhUCGQaiRTvjbshdwl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248081515"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="248081515"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 10:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="708110663"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 May 2022 10:23:19 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlwF4-000AeX-O0;
        Tue, 03 May 2022 17:23:18 +0000
Date:   Wed, 4 May 2022 01:22:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 04/12] libbpf: Add btf enum64 support
Message-ID: <202205040133.jd7yTwg5-lkp@intel.com>
References: <20220501190023.2578209-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501190023.2578209-1-yhs@fb.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Add-64bit-enum-value-support/20220502-030301
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220504/202205040133.jd7yTwg5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
tools/lib/bpf/relo_core.c:348 bpf_core_fields_are_compat() warn: if();

Old smatch warnings:
tools/lib/bpf/relo_core.c:349 bpf_core_fields_are_compat() warn: if();

vim +348 tools/lib/bpf/relo_core.c

   314	
   315	/* Check two types for compatibility for the purpose of field access
   316	 * relocation. const/volatile/restrict and typedefs are skipped to ensure we
   317	 * are relocating semantically compatible entities:
   318	 *   - any two STRUCTs/UNIONs are compatible and can be mixed;
   319	 *   - any two FWDs are compatible, if their names match (modulo flavor suffix);
   320	 *   - any two PTRs are always compatible;
   321	 *   - for ENUMs, names should be the same (ignoring flavor suffix) or at
   322	 *     least one of enums should be anonymous;
   323	 *   - for ENUMs, check sizes, names are ignored;
   324	 *   - for INT, size and signedness are ignored;
   325	 *   - any two FLOATs are always compatible;
   326	 *   - for ARRAY, dimensionality is ignored, element types are checked for
   327	 *     compatibility recursively;
   328	 *   - everything else shouldn't be ever a target of relocation.
   329	 * These rules are not set in stone and probably will be adjusted as we get
   330	 * more experience with using BPF CO-RE relocations.
   331	 */
   332	static int bpf_core_fields_are_compat(const struct btf *local_btf,
   333					      __u32 local_id,
   334					      const struct btf *targ_btf,
   335					      __u32 targ_id)
   336	{
   337		const struct btf_type *local_type, *targ_type;
   338	
   339	recur:
   340		local_type = skip_mods_and_typedefs(local_btf, local_id, &local_id);
   341		targ_type = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
   342		if (!local_type || !targ_type)
   343			return -EINVAL;
   344	
   345		if (btf_is_composite(local_type) && btf_is_composite(targ_type))
   346			return 1;
   347		if (btf_kind(local_type) != btf_kind(targ_type)) {
 > 348			if (btf_is_enum(local_type) && btf_is_enum64(targ_type)) ;
   349			else if (btf_is_enum64(local_type) && btf_is_enum(targ_type)) ;
   350			else return 0;
   351		}
   352	
   353		switch (btf_kind(local_type)) {
   354		case BTF_KIND_PTR:
   355		case BTF_KIND_FLOAT:
   356			return 1;
   357		case BTF_KIND_FWD:
   358		case BTF_KIND_ENUM:
   359		case BTF_KIND_ENUM64: {
   360			const char *local_name, *targ_name;
   361			size_t local_len, targ_len;
   362	
   363			local_name = btf__name_by_offset(local_btf,
   364							 local_type->name_off);
   365			targ_name = btf__name_by_offset(targ_btf, targ_type->name_off);
   366			local_len = bpf_core_essential_name_len(local_name);
   367			targ_len = bpf_core_essential_name_len(targ_name);
   368			/* one of them is anonymous or both w/ same flavor-less names */
   369			return local_len == 0 || targ_len == 0 ||
   370			       (local_len == targ_len &&
   371				strncmp(local_name, targ_name, local_len) == 0);
   372		}
   373		case BTF_KIND_INT:
   374			/* just reject deprecated bitfield-like integers; all other
   375			 * integers are by default compatible between each other
   376			 */
   377			return btf_int_offset(local_type) == 0 &&
   378			       btf_int_offset(targ_type) == 0;
   379		case BTF_KIND_ARRAY:
   380			local_id = btf_array(local_type)->type;
   381			targ_id = btf_array(targ_type)->type;
   382			goto recur;
   383		default:
   384			return 0;
   385		}
   386	}
   387	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
