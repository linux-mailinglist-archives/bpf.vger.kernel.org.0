Return-Path: <bpf+bounces-62638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7615AAFC1A0
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 06:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77044A5674
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4013B23D2A9;
	Tue,  8 Jul 2025 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3sdAxC6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0523A98D;
	Tue,  8 Jul 2025 04:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751947881; cv=none; b=HhdcUFB6slYyFHnpgYaUAXMxj16fw/WR3B2ylYDQ+Whz/tdP9s5Ti6BXow6ltKy4+NklPjpJmeohh8IchD9foliEKBoyfo5HPdTf/3Ig72XsbeYTMpw/nWA0UEvdarCQSe/uWHHc1yEPJjRQWJhfOevD5+raqfjxYJK2ug0X1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751947881; c=relaxed/simple;
	bh=rXWlj/9LA/DLJXLyR14GgKkKykP6BE3a/HJ93b2Dcwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVxLW+nz1Y64kWRbPLLWAhNdtsZU5Pur+0DG2Vh4l0acaJIr2yHdfvljybbYAXcDNKAmwdM/VjE9UUvAUkTu/exSecB5pGN74pueV1ShNK2z2XBxEu5Gws+XqnBp4uRG9PuzXoDVad5HxPb/2lNuoVD0vbG9poUj59OYohLXIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3sdAxC6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751947879; x=1783483879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rXWlj/9LA/DLJXLyR14GgKkKykP6BE3a/HJ93b2Dcwk=;
  b=n3sdAxC678OTAeNNqjjuCvb9IHbVeyrdPhvy4gztBalKxdNytNmH0sAi
   XeQMl5zeRxbN3xekFr2DbrnMzmYJzoJA8MiZD1P38hv2U5qRXnLxdOTMH
   qQoHqK6E1h3Cs9fyGYBHNGU6V/WPLaXgEshhSsUcG3+Fk2PvXj+i3sM+o
   /WxonKTA/eS9lSzCs+14Kf6MCn9M3J9r69eY7jJeibw4KqkiD/l2jsBbG
   eawMTmLGFLa72SxwjMyTux86E8hZ67TW89IIgxbuYb+kPvLJdGbTUHBHX
   zYa2SlMXtSNMiOLYJpSQ+J5i2U017sEwQjr3P7b4BX2xvnneSFFcuO7tU
   Q==;
X-CSE-ConnectionGUID: lJS65IxDQACjYu7zmVvchg==
X-CSE-MsgGUID: YXSaYOB9RQ2qLua6VIZ4sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54102830"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="54102830"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 21:11:18 -0700
X-CSE-ConnectionGUID: DZoxYoMGRzil7CEsBfKMlQ==
X-CSE-MsgGUID: u20iTc/lRr6KYeJeE2AD3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="154793097"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Jul 2025 21:11:09 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYzfe-0000yh-1p;
	Tue, 08 Jul 2025 04:11:06 +0000
Date: Tue, 8 Jul 2025 12:10:12 +0800
From: kernel test robot <lkp@intel.com>
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, mattbobrowski@google.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com,
	willemb@google.com, jakub@cloudflare.com, pablo@netfilter.org,
	kadlec@netfilter.org, hawk@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/6] bpf: Add attach_type in bpf_link
Message-ID: <202507081130.devFCURB-lkp@intel.com>
References: <20250707153916.802802-2-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707153916.802802-2-chen.dylane@linux.dev>

Hi Tao,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Chen/bpf-Add-attach_type-in-bpf_link/20250707-234517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250707153916.802802-2-chen.dylane%40linux.dev
patch subject: [PATCH bpf-next 1/6] bpf: Add attach_type in bpf_link
config: i386-randconfig-015-20250708 (https://download.01.org/0day-ci/archive/20250708/202507081130.devFCURB-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250708/202507081130.devFCURB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507081130.devFCURB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/netkit.c:778:32: error: too few arguments to function call, expected 5, have 4
     777 |         bpf_link_init(&nkl->link, BPF_LINK_TYPE_NETKIT,
         |         ~~~~~~~~~~~~~
     778 |                       &netkit_link_lops, prog);
         |                                              ^
   include/linux/bpf.h:2534:6: note: 'bpf_link_init' declared here
    2534 | void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
         |      ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2535 |                    const struct bpf_link_ops *ops, struct bpf_prog *prog,
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2536 |                    enum bpf_attach_type attach_type);
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +778 drivers/net/netkit.c

35dfaad7188cdc Daniel Borkmann 2023-10-24  770  
35dfaad7188cdc Daniel Borkmann 2023-10-24  771  static int netkit_link_init(struct netkit_link *nkl,
35dfaad7188cdc Daniel Borkmann 2023-10-24  772  			    struct bpf_link_primer *link_primer,
35dfaad7188cdc Daniel Borkmann 2023-10-24  773  			    const union bpf_attr *attr,
35dfaad7188cdc Daniel Borkmann 2023-10-24  774  			    struct net_device *dev,
35dfaad7188cdc Daniel Borkmann 2023-10-24  775  			    struct bpf_prog *prog)
35dfaad7188cdc Daniel Borkmann 2023-10-24  776  {
35dfaad7188cdc Daniel Borkmann 2023-10-24  777  	bpf_link_init(&nkl->link, BPF_LINK_TYPE_NETKIT,
35dfaad7188cdc Daniel Borkmann 2023-10-24 @778  		      &netkit_link_lops, prog);
35dfaad7188cdc Daniel Borkmann 2023-10-24  779  	nkl->location = attr->link_create.attach_type;
35dfaad7188cdc Daniel Borkmann 2023-10-24  780  	nkl->dev = dev;
35dfaad7188cdc Daniel Borkmann 2023-10-24  781  	return bpf_link_prime(&nkl->link, link_primer);
35dfaad7188cdc Daniel Borkmann 2023-10-24  782  }
35dfaad7188cdc Daniel Borkmann 2023-10-24  783  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

