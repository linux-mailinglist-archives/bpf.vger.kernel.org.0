Return-Path: <bpf+bounces-32803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E18E9132C3
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 10:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C34284846
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 08:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB6B14D290;
	Sat, 22 Jun 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YosAV3lB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35D335B5;
	Sat, 22 Jun 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719044925; cv=none; b=AJ9Gz7FmyqEU8XCf6R+Q0oHPPgpkxNvFz7hsbmFOMgshaxoNzIBSykPeEbjg/NlAGpwJPwABmZTNwzelQYVn8PbFc9VqKA+a1oWjId+Ly5FvPQG48hbNv9cbYxPs26+nWIHI0Mr2ZimEP0xKD4zKFaGoc/sa7EEgWoFkDQmb62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719044925; c=relaxed/simple;
	bh=I36hrDGCl16z50N/hx++eF1frdHWfm/lr4cjAYqIPJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqLp2/xbCKiFOVXUX/aTDyskK3l7wWkAH/OGph0Yq3Pw/+4rLANrRBeozR5zICmOaz3ITBileA1MO1wkkMMtVfMMO07YYNlD7fyfty7DCDANX6GEXe9QosB9G3bQyPTQFyatuLdWEDeLi4EGZftYrg5F1K4UEUF9Kb3bvvjqqMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YosAV3lB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719044924; x=1750580924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I36hrDGCl16z50N/hx++eF1frdHWfm/lr4cjAYqIPJw=;
  b=YosAV3lB1rwWvzoC8QJs4jo62U2xGinlzx3Nj642LBMZBGLiHadgjWVD
   8yr7z6JCzhtpuTNwTnEgqKWQrZyzE7AsCPO/CXFKiPe+grIeytW2jQdlY
   BetZyyMjzJ4zQXbIS+XYBrLUowrphX9KGb4WhwBQiOorUDWOX0fQw336g
   PD+cWCqeAC2J3VbVJyvYPfxjm0AiMEpiPcGbsgTb1lUiRUTMWsx8gtDrN
   SrRKEJyYm3OYqyeOKvkXEdz4D/iYzcGVAdgZyqZWhny9zcMEVaJnTmRmi
   SnFyU9BeHfD2C4eCy1xqIWrBaTz52DHSLA7H7Y3TKrmyFv7V148ywZSyN
   A==;
X-CSE-ConnectionGUID: 1ForCOQjTIazyQOjqEuY9A==
X-CSE-MsgGUID: ex+r3gOKRJ+ZJ9OlZrJwyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="18988373"
X-IronPort-AV: E=Sophos;i="6.08,257,1712646000"; 
   d="scan'208";a="18988373"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 01:28:43 -0700
X-CSE-ConnectionGUID: cmQVtE8pSWe4ihT/bVxuiQ==
X-CSE-MsgGUID: juhYmWpiTe6FYYwhG2UfUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,257,1712646000"; 
   d="scan'208";a="47751938"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Jun 2024 01:28:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKw6v-0009SY-0R;
	Sat, 22 Jun 2024 08:28:37 +0000
Date: Sat, 22 Jun 2024 16:28:23 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Kui-Feng Lee <thinker.li@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	linux-input@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <202406221626.JK0Nnkxy-lkp@intel.com>
References: <ZnB9X1Jj6c04ufC0@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnB9X1Jj6c04ufC0@sirena.org.uk>

Hi Mark,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[cannot apply to linus/master v6.10-rc4 next-20240621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Brown/linux-next-build-failure-after-merge-of-the-bpf-next-tree/20240618-022240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/ZnB9X1Jj6c04ufC0%40sirena.org.uk
patch subject: linux-next: build failure after merge of the bpf-next tree
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240622/202406221626.JK0Nnkxy-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240622/202406221626.JK0Nnkxy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406221626.JK0Nnkxy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: error: initialization of 'int (*)(void *)' from incompatible pointer type 'int (*)(void *, struct bpf_link *)' [-Werror=incompatible-pointer-types]
     280 |         .reg = hid_bpf_reg,
         |                ^~~~~~~~~~~
   drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: note: (near initialization for 'bpf_hid_bpf_ops.reg')
>> drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: error: initialization of 'void (*)(void *)' from incompatible pointer type 'void (*)(void *, struct bpf_link *)' [-Werror=incompatible-pointer-types]
     281 |         .unreg = hid_bpf_unreg,
         |                  ^~~~~~~~~~~~~
   drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: note: (near initialization for 'bpf_hid_bpf_ops.unreg')
   cc1: some warnings being treated as errors


vim +280 drivers/hid/bpf/hid_bpf_struct_ops.c

ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  274  
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  275  static struct bpf_struct_ops bpf_hid_bpf_ops = {
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  276  	.verifier_ops = &hid_bpf_verifier_ops,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  277  	.init = hid_bpf_ops_init,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  278  	.check_member = hid_bpf_ops_check_member,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  279  	.init_member = hid_bpf_ops_init_member,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08 @280  	.reg = hid_bpf_reg,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08 @281  	.unreg = hid_bpf_unreg,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  282  	.name = "hid_bpf_ops",
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  283  	.cfi_stubs = &__bpf_hid_bpf_ops,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  284  	.owner = THIS_MODULE,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  285  };
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  286  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

