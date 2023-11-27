Return-Path: <bpf+bounces-15946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92027FA668
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 17:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157331C20B66
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D6636AFA;
	Mon, 27 Nov 2023 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KW/vBdLv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B82DD
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 08:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701102641; x=1732638641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rGzJ1QaEH/PqUrNDck8MUUtdEmE462mhfXEPR3qma8s=;
  b=KW/vBdLvZY/IQmKBe1OWR11UHQv+IDpWLWvY9ejxXqxt7uDMfQJjP9L7
   uxno5l8q5Ua0MhdyXSf9kLu9nDoLw/vmR2pz3By8pDsrzsd0vtYLcFXvp
   dIWdPPsalWOxq4ox2yWB1RLd0EYlXvTwlEzU0uw8cMJ/4MuKBm3y56/5k
   tSRZM2V7yqjXQhXAJy6CxhM6Gz/bKqXlpkToKykqSA7OTu8leS2xjOrYJ
   25LjuwXt/KcH8AcsTODR9lOF7hkZ0w7lf19cUZo2b3PEr5bQjciWOHgQI
   fAt96YU2ZekRCrl4JeLbtFxsKdEs6qTMXWj8Z3pfyT4hHphzLRjCaGuSQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="14297139"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="14297139"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 08:30:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="859103289"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="859103289"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Nov 2023 08:30:04 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r7eUk-0006Qd-16;
	Mon, 27 Nov 2023 16:30:02 +0000
Date: Tue, 28 Nov 2023 00:26:57 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Lee Jones <lee@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf, x64: Fix prog_array_map_poke_run map poke update
Message-ID: <202311272311.WsiMBsbq-lkp@intel.com>
References: <20231127094525.1366740-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127094525.1366740-1-jolsa@kernel.org>

Hi Jiri,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/bpf-x64-Fix-prog_array_map_poke_run-map-poke-update/20231127-174900
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20231127094525.1366740-1-jolsa%40kernel.org
patch subject: [PATCH bpf] bpf, x64: Fix prog_array_map_poke_run map poke update
config: parisc-randconfig-r071-20231127 (https://download.01.org/0day-ci/archive/20231127/202311272311.WsiMBsbq-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231127/202311272311.WsiMBsbq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311272311.WsiMBsbq-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: kernel/bpf/arraymap.o: in function `prog_array_map_poke_run':
>> (.text+0x103c): undefined reference to `__bpf_arch_text_poke'
>> hppa-linux-ld: (.text+0x106c): undefined reference to `__bpf_arch_text_poke'
   hppa-linux-ld: (.text+0x1090): undefined reference to `__bpf_arch_text_poke'
   hppa-linux-ld: (.text+0x10c0): undefined reference to `__bpf_arch_text_poke'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

