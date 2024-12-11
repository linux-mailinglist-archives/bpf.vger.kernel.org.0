Return-Path: <bpf+bounces-46611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA609EC9AE
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDC9169C7B
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDAC1DFE26;
	Wed, 11 Dec 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oh+JIrg8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E619F12A;
	Wed, 11 Dec 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910586; cv=none; b=NMfrtc/erzR9jPmC6jdEZpHG2rdb0MoOks+SvDpLKom6HSJRyaLJaC1ICsoFWO5ucwj3PggJAHp55rfQkuiF4UKjLX8YNHUEZ3NQt/4xOYUvOHeVvoWqHV6bbPF91PybVnmRM7HTrPxnhheS1Z8LoIgyAHEpX6bXkJ5jFzQbLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910586; c=relaxed/simple;
	bh=Mu33YblOXzk38XPlVgibBT01SRKJ7fkjSx4p0sUTn7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE6Sja5ykOmkRq++XG1ph0BiXrYEHcsLGevwBr01/cPk2tCHB1mZsrTHWu7dMmn9+pqQDW6gg18H7n1XTXNK/PKuP5RWI9L9TVni9ogcIJXr5DpK+wGsfWdpOZxOnt7tlq49Yx/tb9x+f/o7R+V0EDwN0lRoWbQIfEWyr9wJLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oh+JIrg8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733910584; x=1765446584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mu33YblOXzk38XPlVgibBT01SRKJ7fkjSx4p0sUTn7A=;
  b=Oh+JIrg8+Lheg2axTZM6JDPQ5u90lPs8ZqMU7D/cH1VL+vB6peQU+53w
   SnbPV4cPDEe4gHp2CxzHPQmnURwAscU6E4N0opiAU+ZcU0Y3nCjpB0ADK
   nRix7aLhc14Ldmis/5ZYy+mB3m78iz/93rnWmRj0b7f9rbsRvWDmN4u/O
   ADQmcq6AbKp9vYTBtsoG5lYVRkWbV+RQsu4QGbKm/8+bbVgQw9qG4U6xi
   eZlg71zcjf9DQTN6DDZnod2OQGkAZmVWq80AvlOJbARzQWjLF+VZq1CaU
   gZuPzAFVPScWJp8+pOeXtmYC8k+4v8jWqBVI21jPLstal8e/CDfUdvIs9
   g==;
X-CSE-ConnectionGUID: fCETeV9yT3+wZouT1FiuNQ==
X-CSE-MsgGUID: RTqKdhqVTWqV8Yg0TqMw8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34184854"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34184854"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 01:49:44 -0800
X-CSE-ConnectionGUID: 1kNx2+FNRe+AgiXSTrzX9w==
X-CSE-MsgGUID: M5BPJqpJRLi9kV3j2LV+eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100684071"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Dec 2024 01:49:39 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLJLc-0006Vh-1n;
	Wed, 11 Dec 2024 09:49:36 +0000
Date: Wed, 11 Dec 2024 17:48:41 +0800
From: kernel test robot <lkp@intel.com>
To: Rong Tao <rtoax@foxmail.com>, andrii.nakryiko@gmail.com, qmo@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	rongtao@cestc.cn
Cc: oe-kbuild-all@lists.linux.dev, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"(open list:BPF (bpftool))" <bpf@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] bpftool: Fix gen object segfault
Message-ID: <202412111714.9jJxt9x6-lkp@intel.com>
References: <tencent_B497E42A7CAF94A35B88EB060E42A2593408@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B497E42A7CAF94A35B88EB060E42A2593408@qq.com>

Hi Rong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Rong-Tao/libbpf-linker-Avoid-using-object-file-as-both-input-and-output/20241206-100435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/tencent_B497E42A7CAF94A35B88EB060E42A2593408%40qq.com
patch subject: [PATCH bpf-next v4 1/2] bpftool: Fix gen object segfault
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412111714.9jJxt9x6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412111714.9jJxt9x6-lkp@intel.com/

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

     PERF_VERSION = 6.13.rc1.g228582f448e8
   gen.c: In function 'do_object':
>> gen.c:1927:9: warning: 'linker' may be used uninitialized [-Wmaybe-uninitialized]
    1927 |         bpf_linker__free(linker);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   gen.c:1879:28: note: 'linker' was declared here
    1879 |         struct bpf_linker *linker;
         |                            ^~~~~~
--
   gen.c: In function 'do_object':
>> gen.c:1927:9: warning: 'linker' may be used uninitialized [-Wmaybe-uninitialized]
    1927 |         bpf_linker__free(linker);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   gen.c:1879:28: note: 'linker' was declared here
    1879 |         struct bpf_linker *linker;
         |                            ^~~~~~
   gen.c: In function 'do_object':
>> gen.c:1927:9: warning: 'linker' may be used uninitialized [-Wmaybe-uninitialized]
    1927 |         bpf_linker__free(linker);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   gen.c:1879:28: note: 'linker' was declared here
    1879 |         struct bpf_linker *linker;
         |                            ^~~~~~
   gen.c: In function 'do_object':
>> gen.c:1927:9: warning: 'linker' may be used uninitialized [-Wmaybe-uninitialized]
    1927 |         bpf_linker__free(linker);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   gen.c:1879:28: note: 'linker' was declared here
    1879 |         struct bpf_linker *linker;
         |                            ^~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

