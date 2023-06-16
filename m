Return-Path: <bpf+bounces-2757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E99EB733878
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 20:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7CE281687
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 18:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2015B1DCCF;
	Fri, 16 Jun 2023 18:54:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F21DCCB
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 18:54:16 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522BB3C13
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686941636; x=1718477636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=12gXpbKnTGnZ/Sp0/iPY0+ZciWr9OZerMc0prgXo3Co=;
  b=hoyhRq1CFoixh5t+njQrJK3VQvu381BekrrU3SqysjM3pz1NtPP5GqWn
   SxtS3Hl7M7cjkBWZzuAy91ScihTA28RKdzg2kYLjv7n5gvJ/Txassdrgj
   kavTIdBp9r8pJ/8glPHayl0ibWhrIU1Gch79RG5ByRNfyvvGru0Py8lvT
   DW60Egfp8YJ2zQqN3jL+oI9IADr1ksq62KJi0FB0LA15l653RNyQ8LwKf
   eqd3Dqil7R7IOuvu5g86w3M2bfgUQmg3ms4WJXsntwvLZpqBZ/QTXBMyt
   wPNvBrRj4AioTKyXnu5HPDoi/lCi+yAV79UYbcdwIU8fc+OlCyzjZDfVj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="356778864"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="356778864"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:53:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="887198660"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="887198660"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2023 11:53:50 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qAEZy-0001io-0F;
	Fri, 16 Jun 2023 18:53:50 +0000
Date: Sat, 17 Jun 2023 02:53:29 +0800
From: kernel test robot <lkp@intel.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, quentin@isovalent.com,
	jolsa@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, mykolal@fb.com,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 6/9] btf: generate BTF kind layout for
 vmlinux/module BTF
Message-ID: <202306170238.L0eHQOJd-lkp@intel.com>
References: <20230616171728.530116-7-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616171728.530116-7-alan.maguire@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Alan-Maguire/btf-add-kind-layout-encoding-crcs-to-UAPI/20230617-012110
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230616171728.530116-7-alan.maguire%40oracle.com
patch subject: [PATCH v2 bpf-next 6/9] btf: generate BTF kind layout for vmlinux/module BTF
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230617/202306170238.L0eHQOJd-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230617/202306170238.L0eHQOJd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306170238.L0eHQOJd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
--
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   loongarch64-linux-gcc: error: unrecognized command-line option '-mexplicit-relocs'
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
>> scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   loongarch64-linux-gcc: error: unrecognized command-line option '-mexplicit-relocs'
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found
   scripts/pahole-flags.sh: 29: [[: not found
   scripts/pahole-flags.sh: 32: [[: not found

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

