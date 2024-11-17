Return-Path: <bpf+bounces-45039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9EA9D01F6
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 04:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2080C1F22D6D
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 03:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F511712;
	Sun, 17 Nov 2024 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHnAiepZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC0EAFA
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 03:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731814667; cv=none; b=Rng4EyWmqvqElavFOdhra+QI4mbRpiu17mZg4uRelTgN1Ilq3ExFNmkALkfQeqKDfNdEjpr0UjZ4suPPt3Awel86cifasbzTI0apbWZTSHRvH66nt5Uw6TdRim7fcr9ePse7qgCYFIHwR60OFCKkdjmLfi386qiHnD/XsA0M1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731814667; c=relaxed/simple;
	bh=DJ02RtNjrNPMn5Ag6Ve0e9HpyEO3fCUM3EcDrUJ0ROY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGoPHoc/9n53Z2MN5MSApRuYs4AmvwalBYe+7NPZd0Xo552cdIHZ/uM7bHpW1yQOH8oubj66Sj2olRt/0NT9EkVhC28U3ix2NgEJnVs4gNaZddWFeCfYhVsDlZOuGpq6FQeXVKu+HRGePLtw7BQKiWs+/CFRPQpootaqtjBGRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHnAiepZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731814666; x=1763350666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DJ02RtNjrNPMn5Ag6Ve0e9HpyEO3fCUM3EcDrUJ0ROY=;
  b=dHnAiepZaRUFNUh58yHnvY+w+UlKwdLdmmg98dnUXcdb5FJQnBj6BKqv
   60XUgYNGYLflKOENRIJs3vZ64pX8zPFXZFBrhx12Rcsy7qL8SMlqdNrtq
   lefFJejs4XIL9vXMbkdhC7OWhFnSUNGiTWXgytDLrO6U9KSXDZ8rtYCFM
   /A9+H7yl3HLuqdtFsFeINZyMZwEQM90aYbPfD9nmpUpW0yYgZK02zw2kS
   6bz/Zo5TibTzZotnhTD0YQ8cvyuNhhjjVuDZiYiY8tSzN2s0H1Nx3PW7X
   HZ1NCBNrtiD9rPOKq9+bA7Jlm8U1e07KuLtiIssIsvaMhN6aOH7S7HdN8
   g==;
X-CSE-ConnectionGUID: bVNvsatyRD2dZ+Ui6QP6bQ==
X-CSE-MsgGUID: rqksREolRSC4aHb/1vE2mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="35558698"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="35558698"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 19:37:45 -0800
X-CSE-ConnectionGUID: oK2cWgXRQKq6Tb1rTFy8yg==
X-CSE-MsgGUID: enb6Q7l8S6q6byp8BWuj8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="88802284"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Nov 2024 19:37:43 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCW6W-0001Mn-20;
	Sun, 17 Nov 2024 03:37:40 +0000
Date: Sun, 17 Nov 2024 11:36:57 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Wilson <ryantimwilson@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc: oe-kbuild-all@lists.linux.dev, ryantimwilson@meta.com
Subject: Re: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
Message-ID: <202411171129.PWAzidIE-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Wilson/bpf-Add-multi-prog-support-for-XDP-BPF-programs/20241115-015104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241114170721.3939099-1-ryantimwilson%40gmail.com
patch subject: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20241117/202411171129.PWAzidIE-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171129.PWAzidIE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171129.PWAzidIE-lkp@intel.com/

All errors (new ones prefixed by >>):

   or1k-linux-ld: net/core/dev.o: in function `dev_xdp_attach_netlink.constprop.0':
>> dev.c:(.text+0x12290): undefined reference to `bpf_mprog_detach'
>> dev.c:(.text+0x12290): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `bpf_mprog_detach'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

