Return-Path: <bpf+bounces-43156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043AD9B0218
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 14:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF191F23468
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6212036EC;
	Fri, 25 Oct 2024 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwO5w2i1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1451FF7B9;
	Fri, 25 Oct 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858872; cv=none; b=KvKSWDMEQsiQkEsr7xlcWxHeUKmSIHvN7uqNNMHyNzvFIlX2/e9PA9p0JLt0YAaLKX+Skk6fmrU8qYKBXa+jLxhbPGCEg4gT1mWhm1wwADY0obfp9oK2Rnm1fCukdOAYtqAWW7dssOWzm0iGB8kqrBEQ0ZbKeAAjGSHRsnJH5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858872; c=relaxed/simple;
	bh=ECh8L1JTwvTvPl5/biMTYEKVaK8Uk1kPpsq2nQQkP8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p02SPD/fZXvmEjLqBr7/RPWenPKpWjiG4Lu/Kstd7xdix9BOHe67KJU+KbnKwKI6dhmnt9xKR4wV7TFXzCMc71y0APYG6Jjo8lrmxYEJ+8C/sMe4XSoeKtCMDtcrm9xeT5hUaeUd4Cg/R/rFJdyIVkmC1csqraXStTHXYNs3oZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwO5w2i1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729858870; x=1761394870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ECh8L1JTwvTvPl5/biMTYEKVaK8Uk1kPpsq2nQQkP8k=;
  b=DwO5w2i13kVgMC91tTYT2D944GPIo2ffqmep9hPCcXnmfAUGSoH+6sc5
   0O+N7DGRePhQLawEP70ri1ZktBUbD2PC/nSqyBX4IoR1XpmpWZNXimMme
   PnVml31q29MrcwHeuXvUraIlp/Uy9FVxxV2WeYNGEo2Eqx8Mvu5Z/O0H6
   n6beju7Gsu7PnZW0/uIjaJ7EH+zOWPT4/ZgvZmh73yHU1EP1XpmFh61dS
   L1wWV9QgciouF5R4veU/bI6G89hi0EMhEGlyrnnJHzCe+IIlNDiCyYgCy
   kToP55dySR9xDWNM2Jwktq1moylnfX4QosaG4QOsY3rwqJZIWr+Le/1cI
   w==;
X-CSE-ConnectionGUID: AG8+m1dNTHCgRGC2wwO8pw==
X-CSE-MsgGUID: vyac1KxeQhyDKhf9KYmMow==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="33330273"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="33330273"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 05:21:09 -0700
X-CSE-ConnectionGUID: uVsKt88ES6+e2Sc5uTEPdg==
X-CSE-MsgGUID: xECAlVmiRhikNljeEW7g6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85460860"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Oct 2024 05:21:03 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4JJN-000YDR-1U;
	Fri, 25 Oct 2024 12:21:01 +0000
Date: Fri, 25 Oct 2024 20:20:06 +0800
From: kernel test robot <lkp@intel.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	guwen@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	dtcccc@linux.alibaba.com
Subject: Re: [PATCH bpf-next 2/4] bpf: allow to access bpf_prog during
 bpf_struct_access
Message-ID: <202410251955.HSEjo06V-lkp@intel.com>
References: <1729737768-124596-3-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729737768-124596-3-git-send-email-alibuda@linux.alibaba.com>

Hi Wythe,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/D-Wythe/bpf-export-necessary-sympols-for-modules/20241024-104903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/1729737768-124596-3-git-send-email-alibuda%40linux.alibaba.com
patch subject: [PATCH bpf-next 2/4] bpf: allow to access bpf_prog during bpf_struct_access
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241025/202410251955.HSEjo06V-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251955.HSEjo06V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251955.HSEjo06V-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hid/bpf/hid_bpf_struct_ops.c:146:30: error: initialization of 'int (*)(struct bpf_verifier_log *, const struct bpf_reg_state *, const struct bpf_prog *, int,  int)' from incompatible pointer type 'int (*)(struct bpf_verifier_log *, const struct bpf_reg_state *, int,  int)' [-Wincompatible-pointer-types]
     146 |         .btf_struct_access = hid_bpf_ops_btf_struct_access,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/bpf/hid_bpf_struct_ops.c:146:30: note: (near initialization for 'hid_bpf_verifier_ops.btf_struct_access')


vim +146 drivers/hid/bpf/hid_bpf_struct_ops.c

ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  142  
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  143  static const struct bpf_verifier_ops hid_bpf_verifier_ops = {
bd0747543b3d97 Benjamin Tissoires 2024-06-08  144  	.get_func_proto = bpf_base_func_proto,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  145  	.is_valid_access = hid_bpf_ops_is_valid_access,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08 @146  	.btf_struct_access = hid_bpf_ops_btf_struct_access,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  147  };
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  148  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

