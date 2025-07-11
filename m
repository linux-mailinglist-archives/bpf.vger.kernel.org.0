Return-Path: <bpf+bounces-62987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B3BB01044
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 02:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A411C82737
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 00:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D94BDF42;
	Fri, 11 Jul 2025 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwEulz0H"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D8C13D
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194123; cv=none; b=UBxG5ozXh0rtTmAjsAnQVcakMfoxFrTXztutRzxZt5juUuQgmqDqkbHyD8X8aClmQXkncbU7ZypMHzg0DOVn4z9//Ri7LjFhusegunxBxEWRVxvQdKRV5IeoD3DruJc2GYytoibjy+mjXNOS0ipctabMv6TaKY5Uo9ZzgoMidIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194123; c=relaxed/simple;
	bh=uW8qZejl2fzr/fsTLEgQKFxG+XoPUs/l7q/JHEQ8kdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HokylPvJ5aI34zrCNG0v9cKR48cRa2pF3QFJeDbrap6xR3uhvA9ZiCIWIk7aAh+hMM1YkEbgi27OXoIeHppf7axD51Jo+1WWmsPMuf3P8I3Ibcm/srMijLmMA2VNbuxbUmIyJEO9C2pnybmgacMhz0RaBNJWxtAgNHbdHSgcGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwEulz0H; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752194122; x=1783730122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uW8qZejl2fzr/fsTLEgQKFxG+XoPUs/l7q/JHEQ8kdg=;
  b=mwEulz0H78g+v3KbuvZ3nmyvliAAt3hQa5D2s/wyNbRP3r46IpTKvfvH
   NCet7PXmK2ynLY1XNS8ek18zahXdhzuW9XLg+C4A9FObk48WoLLJzdhQU
   OCLRc/usYg/AVpTo8oo7l/usfWMqG2j5RlCoQmUbNBWi/edhj6qiAqUFF
   jiMMHrKQjgFUhOWvpKPddzTWvgReYsNfTcCb6GXD8UorU9yK+ow3idgze
   3+OrUOK294VvvJYKq38sImmESyOe43wciBZXfxxyQwHiq/1NfzLI/BPE4
   L/87FB5bJ2AW14T8pF3Q4TQO+EKnc1BKL/QKJXXWOl6pGalpCB7IFBwX/
   g==;
X-CSE-ConnectionGUID: t6H3p6o/Q9Oh7rj6crdokQ==
X-CSE-MsgGUID: q/0WY85cQbW/rSrjGkSLtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54361953"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="54361953"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 17:32:19 -0700
X-CSE-ConnectionGUID: 7QWP6bSZRsu4ecuxuAQW0Q==
X-CSE-MsgGUID: D7j44jBSSyay68TNi57aSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="160248982"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jul 2025 17:32:16 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua1gU-0005eF-0P;
	Fri, 11 Jul 2025 00:32:14 +0000
Date: Fri, 11 Jul 2025 08:32:09 +0800
From: kernel test robot <lkp@intel.com>
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, martin.lau@linux.dev,
	daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
	andrii@kernel.org, Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: add bpf_icmp_send_unreach
 cgroup_skb kfunc
Message-ID: <202507110812.bV4X2x0X-lkp@intel.com>
References: <20250710102607.12413-4-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710102607.12413-4-mahe.tardy@gmail.com>

Hi Mahe,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Mahe-Tardy/net-move-netfilter-nf_reject_fill_skb_dst-to-core-ipv4/20250710-182905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250710102607.12413-4-mahe.tardy%40gmail.com
patch subject: [PATCH bpf-next v1 3/4] bpf: add bpf_icmp_send_unreach cgroup_skb kfunc
config: i386-buildonly-randconfig-002-20250711 (https://download.01.org/0day-ci/archive/20250711/202507110812.bV4X2x0X-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507110812.bV4X2x0X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507110812.bV4X2x0X-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: net/core/filter.o: in function `bpf_icmp_send_unreach':
>> filter.c:(.text+0x11e97): undefined reference to `ip_route_reply_fetch_dst'
>> ld: filter.c:(.text+0x11eaf): undefined reference to `__icmp_send'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

