Return-Path: <bpf+bounces-66027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF61B2CC81
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 20:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07E63BD3B4
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 18:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762D31E119;
	Tue, 19 Aug 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAKy9ljF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BB3218CF
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629712; cv=none; b=dgufEk1IvzBh9bUWqDVUdGHbIbqj1kOiwBz+9XvLPYa62+LPn8y53orfXpX87tym+P5B1CUjBiWIAojQkJTGs+NOkL3p0xn0dgLJ6zQv5016eMxxiqXvpG57IKwy0fMZ0xlSTU22SFVDNBo7xEscXTRhPjSRJK1Zr5klpkAeo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629712; c=relaxed/simple;
	bh=N0364bt9jMRC3C6+N0XTj3sLdDMekTNts+hQ0L3+ZhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKN12Gw8yauOY3IrEiF7XbFbKgyyHCV2rzO+RQm9bOEXakvIhawxKXNAViuqflsq9+vEdEUzNROtJ+xniyrbjicFLiWskQZrhMWGh4md4rdW/rWGio2ttMmXMlvy4KIqBdnEZ+TYUXMEU+E0E3DphoG2kd2njEuvgFRlaNVx864=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAKy9ljF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755629711; x=1787165711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N0364bt9jMRC3C6+N0XTj3sLdDMekTNts+hQ0L3+ZhA=;
  b=iAKy9ljFzzCfVfJndE+50DJI/vdEfb47rHBLTNV4gD3Zp+InTD3Nsney
   jxF4ziA4Vuk78xLgT9Ly8F8lmrbVIpiyrWU5QZDqBifZUwH15qXuyC3Hr
   StBUsdLKd1PzwmCmQxl+TgN8vXWxIduCKrI2q07YwhGNStTaLn8r5Dkqr
   cfLlWzCYucaHgn/IkmIhwKqX8K4W1oZYoIWYdhLfgqIOHeTnKJXTW36GI
   jglVtxTRu505LAv60a6C+QzvSFByQntnne7w7wZ6jrdwg3ZqK3+Ln4oMg
   CQfABSdnQ/MQjXrnbpc/reRVS5oFhtTkHxpzohERg280WxYgZIPG7mrlF
   A==;
X-CSE-ConnectionGUID: ySos+5MGT8e41IJGjSUCZg==
X-CSE-MsgGUID: rpQ3yEhFQiywjRwNFbFDPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="83313106"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="83313106"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 11:55:10 -0700
X-CSE-ConnectionGUID: 0/ig0LXNStKG9JH+moRfMg==
X-CSE-MsgGUID: fmte1CfuQNaazIakoZsu7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="198785908"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2025 11:55:04 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoRU5-000HIT-06;
	Tue, 19 Aug 2025 18:55:01 +0000
Date: Wed, 20 Aug 2025 02:54:38 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Pingfan Liu <piliu@redhat.com>,
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
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 10/12] arm64/kexec: Add PE image format support
Message-ID: <202508200238.hckz21nw-lkp@intel.com>
References: <20250819012428.6217-11-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819012428.6217-11-piliu@redhat.com>

Hi Pingfan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250819-093420
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250819012428.6217-11-piliu%40redhat.com
patch subject: [PATCHv5 10/12] arm64/kexec: Add PE image format support
config: arm64-kismet-CONFIG_KEXEC_PE_IMAGE-CONFIG_ARCH_SELECTS_KEXEC_FILE-0-0 (https://download.01.org/0day-ci/archive/20250820/202508200238.hckz21nw-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250820/202508200238.hckz21nw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508200238.hckz21nw-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for KEXEC_PE_IMAGE when selected by ARCH_SELECTS_KEXEC_FILE
   WARNING: unmet direct dependencies detected for KEXEC_PE_IMAGE
     Depends on [n]: KEXEC_FILE [=y] && DEBUG_INFO_BTF [=n] && BPF_SYSCALL [=y]
     Selected by [y]:
     - ARCH_SELECTS_KEXEC_FILE [=y] && KEXEC_FILE [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

