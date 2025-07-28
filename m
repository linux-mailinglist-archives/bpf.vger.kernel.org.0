Return-Path: <bpf+bounces-64557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35536B142B3
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 22:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595D0541E3F
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD7277CA3;
	Mon, 28 Jul 2025 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRJH+neC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940521D585;
	Mon, 28 Jul 2025 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753733440; cv=none; b=Dn3Nevhx/3QRsTZBwUUr+LcNBfw3iQyZ2ox88eDFpgcZZ/7loBCqPH01OXzttQWV5hMJ5sN4z0EdrC1CRrEnO+uFuJt+qQC6OVvDHVbORH+ejEL4cqn1DTIwEcMOP9HRmkvYqfYzPh04Xp7xPjBQFHD+YxtEDxpNMRDHLA8xH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753733440; c=relaxed/simple;
	bh=9czKtzndhU42pjVNgVo1eafEPoqJB+ePVk974yb3RR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqM6PIZtA6/P+DvtlMh+NdTzYB1XF6GRtWg66E+M0NJtRGBrszgAgrmMAjhaSWOXCwD9sKs/q9RxQBNPjG9xz58lj+m6p0ejEFAeikA+R8WnuvLSWyBSGCLJ/7yE1qxnyrxB1gRkgFBQeHpIyb2M+0PwELkkGYjWTYHuJ5SjSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRJH+neC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753733440; x=1785269440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9czKtzndhU42pjVNgVo1eafEPoqJB+ePVk974yb3RR4=;
  b=VRJH+neCm/jdZfrFNXEtxhdUk7x1pCCN+qMF3+iay5ytN/FZzKEixa5c
   m1uKt7I/fPCVzuiHqjb/TFyatpftpCU1BWrYAki7rXZ0EUPpMMG90d2sq
   KLk5yhm5QL+XMY1N+Dy3WuJUEAiYq4kEkzb173I5ejyCDGr4Zc+/SBrYQ
   Xuf1UESD9E7DulEcT0PPQTdXqHPpwOC+DQ7gL6GrOJo3mPANJAUn0sECS
   qvI9n4WcrUXY5AgUcCZw4dy4Y9IqzUQgpj6xBuUtLY8EydSbc7Iv9bink
   6xccJOTRTkzISsW2Vcsx5nDUkaiQlgey7+4qJWIu61X8O/UmZwvuYg87a
   A==;
X-CSE-ConnectionGUID: FgxpGzJOTO2EZghrs2iLqQ==
X-CSE-MsgGUID: uX6sfd7nQAODhESO0XY1mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67427113"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="67427113"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 13:10:39 -0700
X-CSE-ConnectionGUID: MDD9vg80Q7OmTCQyFXuKsA==
X-CSE-MsgGUID: hSQTySyvSj2GjI1iB8bC9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162856915"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 28 Jul 2025 13:10:35 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugUB6-0000jP-30;
	Mon, 28 Jul 2025 20:10:32 +0000
Date: Tue, 29 Jul 2025 04:10:26 +0800
From: kernel test robot <lkp@intel.com>
To: Mahe Tardy <mahe.tardy@gmail.com>, lkp@intel.com
Cc: oe-kbuild-all@lists.linux.dev, alexei.starovoitov@gmail.com,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	coreteam@netfilter.org, daniel@iogearbox.net, fw@strlen.de,
	john.fastabend@gmail.com, mahe.tardy@gmail.com,
	martin.lau@linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [PATCH bpf-next v3 3/4] bpf: add bpf_icmp_send_unreach
 cgroup_skb kfunc
Message-ID: <202507290356.HyFMR3K0-lkp@intel.com>
References: <20250728094345.46132-4-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728094345.46132-4-mahe.tardy@gmail.com>

Hi Mahe,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Mahe-Tardy/net-move-netfilter-nf_reject_fill_skb_dst-to-core-ipv4/20250728-174736
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250728094345.46132-4-mahe.tardy%40gmail.com
patch subject: [PATCH bpf-next v3 3/4] bpf: add bpf_icmp_send_unreach cgroup_skb kfunc
config: s390-randconfig-001-20250729 (https://download.01.org/0day-ci/archive/20250729/202507290356.HyFMR3K0-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507290356.HyFMR3K0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507290356.HyFMR3K0-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: net/core/filter.o: in function `bpf_icmp_send_unreach':
   filter.c:(.text+0xf7b8): undefined reference to `ip_route_reply_fetch_dst'
>> s390-linux-ld: filter.c:(.text+0xf7ea): undefined reference to `__icmp_send'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

