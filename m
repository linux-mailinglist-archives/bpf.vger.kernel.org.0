Return-Path: <bpf+bounces-14061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FEA7DFEFA
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 06:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3A7B213F3
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 05:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FAA1FCE;
	Fri,  3 Nov 2023 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYR0NqZR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919217C5;
	Fri,  3 Nov 2023 05:58:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9DC1AD;
	Thu,  2 Nov 2023 22:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698991077; x=1730527077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Tb/9TRXfkspZ4Qolx6KFNI5OizP54a6MuN04lpTl5k=;
  b=VYR0NqZRQjA9LI5aVJPFeYnp7/zQ5kRADYPZla2NTJBqNYx5HDahe51j
   vzcuiP46k1kutn8gPeIHVwczTNLS+2xXmFukseHgbYb6ZNmJA2byYnnZo
   u0HkbxU2+itfIuHPvJ8AtaXJUDeRnOHrCptvbaR2l7Ue2K4Ddsbzutq0V
   IYBiGoJ89pJsBiWxucxwj3TplmHuAuMS2hmpqnw1wJetfz6+4dXcg8ZAC
   Vwo4OSyuW+cuFSpNDh3VoI6t4xE5LKWLhpFFvGA0XkDCsgY+ls7TK9qkK
   NzLDPzSXztlfRTRyaHytapd4Lza3LkHVh0sWhhQDQVZc6eW3y2KvmaBsD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="379285633"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="379285633"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 22:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="765152051"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="765152051"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Nov 2023 22:57:53 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qynBn-0002H1-2K;
	Fri, 03 Nov 2023 05:57:51 +0000
Date: Fri, 3 Nov 2023 13:57:08 +0800
From: kernel test robot <lkp@intel.com>
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
	andrii@kernel.org, drosen@google.com
Cc: oe-kbuild-all@lists.linux.dev, sinquersw@gmail.com, kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 09/12] bpf, net: switch to dynamic
 registration
Message-ID: <202311031305.1bFdKyKl-lkp@intel.com>
References: <20231101204519.677870-10-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101204519.677870-10-thinker.li@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/thinker-li-gmail-com/bpf-refactory-struct_ops-type-initialization-to-a-function/20231102-044820
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231101204519.677870-10-thinker.li%40gmail.com
patch subject: [PATCH bpf-next v9 09/12] bpf, net: switch to dynamic registration
config: xtensa-randconfig-002-20231102 (https://download.01.org/0day-ci/archive/20231103/202311031305.1bFdKyKl-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311031305.1bFdKyKl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031305.1bFdKyKl-lkp@intel.com/

All errors (new ones prefixed by >>):

   xtensa-linux-ld: kernel/bpf/btf.o: in function `btf_int_show':
   btf.c:(.text+0xb0c4): undefined reference to `bpf_struct_ops_desc_init'
>> xtensa-linux-ld: btf.c:(.text+0xb330): undefined reference to `bpf_struct_ops_desc_init'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

