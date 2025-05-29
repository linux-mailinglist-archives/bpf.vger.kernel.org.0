Return-Path: <bpf+bounces-59291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71051AC7DC0
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF5B4E7FA2
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918ED1B21BF;
	Thu, 29 May 2025 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSeU1IDb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71572222C1
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748521937; cv=none; b=c4Z9nZZ+eKIIBdJ/LEbY0NGl7TZrkNaiBsSD1kgd7EBZc4oPtQsWUrQ32ER8+52/bYtnCYb4cx6yXKzsct1qKta4xzMdlxmJPp6TsifrZaFvb6bYmdEvLhUAHyPHMXfgvEZwwR+5Fhnycfcyhro7s525BSZtI7acz+BciiSio7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748521937; c=relaxed/simple;
	bh=5tczT80Nk/8Jz8ap+tBGVsKedTDSvW5dC/vIjC8PZ00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tegqmweJ0b3NSkMk5fW9enGWwRHOli7WvmDMan8RQMBkqC3+PU08aen/gLUpaHy9kwfGsZKZ/DEdQBdtiJeVA9RaxS/zpMEyATof2TYkeByV+1TDwrGJ07ljNznVpA5XLKId5T6FC9xHfPUn5uXfSC/32tQX3bHS4pa4aOIOEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSeU1IDb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748521935; x=1780057935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5tczT80Nk/8Jz8ap+tBGVsKedTDSvW5dC/vIjC8PZ00=;
  b=NSeU1IDbg9MxNO/TjhB349oMTCUxjliHa7ie1+Cbke/VzStE9PUd/E00
   8iJpCh1PKyD+cnoRyZLgGMJFVdRqYdiNdGLFuv9VYjlsEhi+TQ7tZDqYu
   KdQPRzp2qFYjysTqtyKVB/Wbkz/V6/3MtGCjkxfXjdoD6Zr/6BmTggS6m
   qU3UMoaPVrmyQj3DXpEN2eR+nVOkrmU6W/4x8yAhbI5HnYj1WB+NcR6Ch
   mGNnkArIngj8JncD7rLCIi98AjTKlL9pKtjpzXMLO3ZtcrgNiqDXAqkEn
   4i1xsh0XTrCPLBuMdJhhDSrFLuf+RftUMnu/2gsmlh3qhY+LsYeBbjrsP
   w==;
X-CSE-ConnectionGUID: l/EIWUFOTJGMPgBZAjKLoQ==
X-CSE-MsgGUID: 6DrcV+pUTb2kKpnYvrgW1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="75970811"
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; 
   d="scan'208";a="75970811"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 05:32:14 -0700
X-CSE-ConnectionGUID: WkcTx/cnS2OQsxC2aU7ELg==
X-CSE-MsgGUID: fo1jR2L4RsWuDT0fS/uhww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; 
   d="scan'208";a="143526206"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2025 05:32:09 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKcQY-000Wfy-1Y;
	Thu, 29 May 2025 12:32:06 +0000
Date: Thu, 29 May 2025 20:31:28 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	kexec@lists.infradead.org, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCHv3 4/9] bpf: Introduce decompressor kfunc
Message-ID: <202505292046.qJy6UU9z-lkp@intel.com>
References: <20250529041744.16458-5-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529041744.16458-5-piliu@redhat.com>

Hi Pingfan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf/master arm64/for-next/core v6.15]
[cannot apply to bpf-next/master linus/master next-20250529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250529-122124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250529041744.16458-5-piliu%40redhat.com
patch subject: [PATCHv3 4/9] bpf: Introduce decompressor kfunc
config: s390-randconfig-002-20250529 (https://download.01.org/0day-ci/archive/20250529/202505292046.qJy6UU9z-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505292046.qJy6UU9z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505292046.qJy6UU9z-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: bpf_decompress+0x36e (section: .text) -> decompress_method (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

