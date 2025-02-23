Return-Path: <bpf+bounces-52267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E050EA40D5F
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 09:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BEC189C941
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E4F1FCF54;
	Sun, 23 Feb 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhPPoWxu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4081F2C56;
	Sun, 23 Feb 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740298899; cv=none; b=fEy1qzOLvUViNnwfihYzkQ1ONjxMAMx0enmbJbIAOrtxobQVexfc3vMZG9Q/mQHnsRwq7V/goq8zR+2p265zn6gI51WXqWoFoaAe4VjjH898hfffoZvPDbsMJOmIYHI2DUHIL4xlFXDKLR7O7Te0UyhyzifDOzHR19fbt2QlROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740298899; c=relaxed/simple;
	bh=90wQ+ltilL4gvTyMoe64RHL4T1bK+YyA9wK24My8hOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwU2RM/mRX7WX8MFUk4Ac4XNbAThpygBkuq6rWoJPlQ1h39Ksyg8zBPaI2L19DWZ7ZMgXalw7ij/Awi14DpMgAbmMyOXcKEFGJgkiRx1Lg365a5A8n4nGcQtwUoZYxUnfoCjn7WkS4oRu3+p5aFDxglygCOziV2iGUrtFsNYX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhPPoWxu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740298897; x=1771834897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=90wQ+ltilL4gvTyMoe64RHL4T1bK+YyA9wK24My8hOU=;
  b=RhPPoWxurSLhnAX8Bdu7fmhPvu1b0XEpbt0Ua7y3J8WEXgjhON/yTjpF
   rk1iGmUkEapLQYOhUrYfR4waPpnzLLhKcfR7AERkK+p29y5F+at0/Xifi
   uIJk3NOGxUMNxYbQ0SSWLySJEeldrKnz8ahvyiFdq5RLYarb6YQlkeVwN
   T2LY4WuxmEsd4HUebP1ZhSr/yAas6wa7yOA3xyWspth4w6svmr6Q5DHR7
   shr/CiUco7dYvvNUgq2IQMeZbjcCGDQPgeTwK9Jr05x8ZYNpvS/8yHqdl
   eYDZdTPWE5v93j8EmN70pfSsqA37SB30eLKp4zFk7dv7z1o9eqMQ84Q5X
   w==;
X-CSE-ConnectionGUID: oQ2Hp60cRTmtVjfL+oywbg==
X-CSE-MsgGUID: o8nC5pA4SACeBd3vhI/SHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="51709928"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="51709928"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 00:21:36 -0800
X-CSE-ConnectionGUID: MhJcB458TdmF83dgqq/7yg==
X-CSE-MsgGUID: KIBtOcOFSxa6B4eHiNDYsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116282573"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 23 Feb 2025 00:21:32 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tm7Ew-0007DH-22;
	Sun, 23 Feb 2025 08:21:30 +0000
Date: Sun, 23 Feb 2025 16:21:11 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, jpoimboe@kernel.org,
	peterz@infradead.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] objtool: Copy noreturns.h to
 include/linux
Message-ID: <202502231624.0BVpxwbg-lkp@intel.com>
References: <20250223062735.3341-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223062735.3341-2-laoar.shao@gmail.com>

Hi Yafang,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/objtool-Copy-noreturns-h-to-include-linux/20250223-143010
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250223062735.3341-2-laoar.shao%40gmail.com
patch subject: [PATCH v2 bpf-next 1/3] objtool: Copy noreturns.h to include/linux
reproduce: (https://download.01.org/0day-ci/archive/20250223/202502231624.0BVpxwbg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502231624.0BVpxwbg-lkp@intel.com/

All errors (new ones prefixed by >>):

         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[2]: *** [scripts/Makefile.build:102: scripts/mod/devicetable-offsets.s] Error 1
   make[2]: Target 'scripts/mod/' not remade because of errors.
   make[1]: *** [Makefile:1263: prepare0] Error 2
>> diff: tools/tools/objtool/noreturns.h: No such file or directory
   Warning: Kernel ABI header at 'tools/tools/objtool/noreturns.h' differs from latest version at 'tools/objtool/noreturns.h'
   make[3]: *** [Makefile:70: tools/objtool/objtool-in.o] Error 1
   make[3]: Target 'all' not remade because of errors.
   make[2]: *** [Makefile:73: objtool] Error 2
   make[1]: *** [Makefile:1430: tools/objtool] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

