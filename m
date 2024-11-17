Return-Path: <bpf+bounces-45041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC839D0200
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 05:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CDC1F230CB
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 04:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81114286;
	Sun, 17 Nov 2024 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUEz25wC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E6DDA8
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731818637; cv=none; b=ZBgFUQ4IW+d4/2c4Tq8Ft4A13T4W9/eiI6lNMflVL/2dtCh/8T+eyR3+hulDdO1u0WvaTesq9KhNZfjpFXkJXvbKI7rJdHhMclPDYMuSb241yKSQpoNrz63J6LF3vnCmiMgktHQsu59yznBCIplPMuEWQxNOVmU36Yz+y56LaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731818637; c=relaxed/simple;
	bh=HQ1l0HFtXZ1+g8fi7xatSYiS6b9qnMHvZ8I248CcOIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hylGF4RypzaD/gFuLyioi2/9mlNrjT+yJXURJBO/Kf7sGGas0e/3VuvsBZFH/yf7sKCUhnC+1W4omnaO6c6pLWE9N06nGUZWELtYjQZykP67olb6797BcjJeIbf2w9YCB1nXOtqplqx08KaWjgy07HpK7COvKCOt2ORkjbOA9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUEz25wC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731818635; x=1763354635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HQ1l0HFtXZ1+g8fi7xatSYiS6b9qnMHvZ8I248CcOIU=;
  b=aUEz25wCEem2rG7Ktim3R5Ol7pS2QRwBoGPyNVNHQd+jck1dYOFs2O4L
   O57Xvk5WUNT6n9QLx2Lekipltci5ChezIHMCKHeRR5+MyarFMat2K7Cum
   vevOxPFUgxsmdmA+cLIOANeqKR/xILvds0laBc+rSNKWXC01yCZd2i1lw
   vJzT8pTYHR8B1HEvX/I/9jiyNvaILIDKDOv2Nkbod06Rd00JAFye+k0zU
   SDY1B9sclOALHWyzvcTbVgqL8FrFKbuE7o+JvF1yxR/Z3ahktvHppPRmx
   mxXu9LW8Dd1LfEuZCGr1I0VD4ve94r5YVhEHKcuhVpTV3Lzha2RZoeiZi
   w==;
X-CSE-ConnectionGUID: Pt/8TeNhT/qgyIlSDgXUxw==
X-CSE-MsgGUID: LfDNlE6eSJ2d03ab4NWCGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="35560906"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="35560906"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 20:43:55 -0800
X-CSE-ConnectionGUID: E+OCPVqJQ7KNfXaFrmth9w==
X-CSE-MsgGUID: udVJSe2oTIe4UuMW8PBpLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="93375793"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Nov 2024 20:43:52 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCX8Y-0001UV-0T;
	Sun, 17 Nov 2024 04:43:50 +0000
Date: Sun, 17 Nov 2024 12:43:32 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Wilson <ryantimwilson@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ryantimwilson@meta.com
Subject: Re: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
Message-ID: <202411171200.F60G1P8R-lkp@intel.com>
References: <20241114170721.3939099-1-ryantimwilson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114170721.3939099-1-ryantimwilson@gmail.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Wilson/bpf-Add-multi-prog-support-for-XDP-BPF-programs/20241115-015104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241114170721.3939099-1-ryantimwilson%40gmail.com
patch subject: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20241117/202411171200.F60G1P8R-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171200.F60G1P8R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171200.F60G1P8R-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/s390/boot/startup.c:14:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:24:
   In file included from include/linux/bpf_mprog.h:6:
>> include/linux/bpf.h:2068:24: warning: field 'hdr' with variable sized type 'struct bpf_prog_array' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
    2068 |         struct bpf_prog_array hdr;
         |                               ^
   1 warning generated.


vim +2068 include/linux/bpf.h

324bda9e6c5add Alexei Starovoitov 2017-10-02  2066  
46531a30364bd4 Pavel Begunkov     2022-01-27  2067  struct bpf_empty_prog_array {
46531a30364bd4 Pavel Begunkov     2022-01-27 @2068  	struct bpf_prog_array hdr;
46531a30364bd4 Pavel Begunkov     2022-01-27  2069  	struct bpf_prog *null_prog;
46531a30364bd4 Pavel Begunkov     2022-01-27  2070  };
46531a30364bd4 Pavel Begunkov     2022-01-27  2071  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

