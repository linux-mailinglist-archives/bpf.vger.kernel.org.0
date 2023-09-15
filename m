Return-Path: <bpf+bounces-10123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED947A12F3
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 03:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BDD1C210A6
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD08809;
	Fri, 15 Sep 2023 01:30:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D1736A;
	Fri, 15 Sep 2023 01:30:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774942100;
	Thu, 14 Sep 2023 18:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694741415; x=1726277415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vr3J5yITMZMwzb6kn5cbU3EF+ievSZvNqJtPlPY4kgs=;
  b=EvFj4Qu/pNooCh3Set7EU65eL30vULdQ3zcBQzs4olS0GI6+f9OEwdbq
   6tOPDeIhpNze2v7hxhwmm6HEhbgyH2oIXPl+K6sBmUy1ILvpOppsCTx72
   I7rQcD/GmCjMQgD866YwhhwdP2tKXcBZX5VKioPi3KjNtuaHrxWCbvpiR
   arvJFQ2fYNHhBt3A3Sz8Zx0WEQFe7qeWwPOqfK7TSaIAPhwZUPwsb7ee8
   vBfqroqoCn86sGGn7c1tonh6S5w6iiEyEt3uzaBNxuqVk1c16M8W8bQGv
   gIJN6B4nheFkRWub8PZfPpcf7ZNXEuIlES9kkQWKibXKuoclfr5oxwfgH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="410070055"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="410070055"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 18:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="779903343"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="779903343"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2023 18:30:08 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qgxeo-0002Gl-1B;
	Fri, 15 Sep 2023 01:30:06 +0000
Date: Fri, 15 Sep 2023 09:29:09 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	kuba@kernel.org, toke@kernel.org, willemb@google.com,
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, hawk@kernel.org,
	yoong.siang.song@intel.com, netdev@vger.kernel.org,
	xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v2 2/9] xsk: add TX timestamp and TX checksum
 offload support
Message-ID: <202309150941.EhULA98J-lkp@intel.com>
References: <20230914210452.2588884-3-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914210452.2588884-3-sdf@google.com>

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/xsk-Support-tx_metadata_len/20230915-051153
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230914210452.2588884-3-sdf%40google.com
patch subject: [PATCH bpf-next v2 2/9] xsk: add TX timestamp and TX checksum offload support
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20230915/202309150941.EhULA98J-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150941.EhULA98J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309150941.EhULA98J-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/net/xdp_sock_drv.h:9,
                    from drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:44:
>> include/net/xdp_sock.h:183:52: warning: 'struct xsk_tx_metadata_comp' declared inside parameter list will not be visible outside of this definition or declaration
     183 | static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_comp *compl,
         |                                                    ^~~~~~~~~~~~~~~~~~~~


vim +183 include/net/xdp_sock.h

   182	
 > 183	static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_comp *compl,
   184						    const struct xsk_tx_metadata_ops *ops,
   185						    void *priv)
   186	{
   187	}
   188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

