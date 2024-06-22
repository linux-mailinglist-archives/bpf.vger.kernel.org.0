Return-Path: <bpf+bounces-32802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5009132B8
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575A7284864
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEB414C5BD;
	Sat, 22 Jun 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSD18QR0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8679FE;
	Sat, 22 Jun 2024 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719044324; cv=none; b=mlq4Hp2BjVeQv6f+8ggt86FceG8+0WsLf40Kxl+qOyprNLmNYLBtjOOxLnbwyRUx4mSmYIPVrG6p4pxkXPSyPmvEfDRu75xHNMM639bWhC/nPMaZyYGOklQC6Y1cQh1z1voYrQhkKAQ5duc94aOPcbimT4Y8YoRv/7B+LGtEZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719044324; c=relaxed/simple;
	bh=pKv2Hji6vCGl1/fWTDRVVwNmWO5EdcUhPV/D5Gro1VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRJe7atjUuWOlSXINISINtoOtKTOmGdiXRKezBwRjsbNeKObBqOtUxvF4RbvqQ/3kM8Fba9f8LOyU+idAWiTq6HSQDD/3hfWNzSnDRy0qBCKWX8rB1YGr2/vegoOS3DNnGhTnIM3tRxChMPZ8CcmR1kFeDZY2rwL4kcoGUhzRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSD18QR0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719044322; x=1750580322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pKv2Hji6vCGl1/fWTDRVVwNmWO5EdcUhPV/D5Gro1VA=;
  b=cSD18QR03AB+nGiwDoZv1Ekwrvt5a2NBz+oSLbHBol8vYM8vBhyI3pOW
   f52KTNBVT3fJmW47CbGeSaag945kVcd8WGNvIbyINZ8wUcXLCGyJONOmg
   eFqWZD8BlvDY/sD9uoagvOFy8sUkm0oFuEr55Dgq5Jp+4RN7RM188s6IY
   +WgXM8EvIN2gbE367FDnr9XeYJsNCwXDye7GjxyXSlP/hgEkzWxZpkTyj
   ps/vwbxEUPsDyICyiE5gpZVjFS6COFbrQxn+qFTz8Qs31W2N6zpkTSA7N
   N9DZKNWAbXnjlq3rYufhA3LAO/kH1UXW/7ywpXhUMCucZjFxI6xXntn5P
   w==;
X-CSE-ConnectionGUID: s/oow2L4Qv+xt9BTm2odfQ==
X-CSE-MsgGUID: PBynriEVSOin9vdEzQoABQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="16314756"
X-IronPort-AV: E=Sophos;i="6.08,257,1712646000"; 
   d="scan'208";a="16314756"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 01:18:42 -0700
X-CSE-ConnectionGUID: SAMQt/BMQvyOuM1Rmm6xsw==
X-CSE-MsgGUID: JpDBx54CTtGaRKZSNuzE8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,257,1712646000"; 
   d="scan'208";a="74023802"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 22 Jun 2024 01:18:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKvxE-0009RU-1n;
	Sat, 22 Jun 2024 08:18:36 +0000
Date: Sat, 22 Jun 2024 16:17:38 +0800
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
Message-ID: <202406221655.xSqDIUk6-lkp@intel.com>
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
config: x86_64-randconfig-r122-20240622 (https://download.01.org/0day-ci/archive/20240622/202406221655.xSqDIUk6-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240622/202406221655.xSqDIUk6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406221655.xSqDIUk6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hid/bpf/hid_bpf_struct_ops.c:280:9: error: incompatible function pointer types initializing 'int (*)(void *)' with an expression of type 'int (void *, struct bpf_link *)' [-Wincompatible-function-pointer-types]
     280 |         .reg = hid_bpf_reg,
         |                ^~~~~~~~~~~
>> drivers/hid/bpf/hid_bpf_struct_ops.c:281:11: error: incompatible function pointer types initializing 'void (*)(void *)' with an expression of type 'void (void *, struct bpf_link *)' [-Wincompatible-function-pointer-types]
     281 |         .unreg = hid_bpf_unreg,
         |                  ^~~~~~~~~~~~~
   2 errors generated.


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

