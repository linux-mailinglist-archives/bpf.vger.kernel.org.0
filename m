Return-Path: <bpf+bounces-64469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030B4B132C9
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 03:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D511721B7
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 01:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50A2BD04;
	Mon, 28 Jul 2025 01:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwEBu+cy"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F985137E
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753666323; cv=none; b=XtNoX4DLZ/eHNhBwtL2ZYLTvg7hgAZ2m17W6eWOwxBNLsXo49FukLJXcIzVdX4pWdfaRxTT6Xj3LdH+KM+/egF+qE25+FsIgjwj+lFR5jZHkRq6z//3U7zqQKT/+VZmS+HU/5c1xbp8LkA2hG+XtYfDkEjjLK/wmM9cSwBaohQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753666323; c=relaxed/simple;
	bh=1+JKE2iPg0Q81HZUjpfT6uxTsIImsKvoEz92D3a/8L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk/9rrPyCQslwCytGT4XZBwj+zGNTwgm0maF0beTBK9u33/YrNMv7ZxFPRJvSShWVPCstvCqKuT37BJbhJqMhIdgabIpDYBXCEnRUINP7DixbXerGPenarFqLcidYF9KDB56v3ppmcJPf2t7s0GXL9Z8SKrGwD0Kgsz09VzIgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwEBu+cy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753666322; x=1785202322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+JKE2iPg0Q81HZUjpfT6uxTsIImsKvoEz92D3a/8L4=;
  b=mwEBu+cyOEEcraxCJ/YApN8fqEeUAL83dmLkAOQ9Rp7rLsLIdx6CAT/m
   BQYYkV7wmR5OO2pkO1loJNgDa0sncx21e/X2hxG58xy7qUi2YPknYmbAn
   Sl3mblHkD6YpxdsN2TJL+fDxV5Hxbeegmn5WUI4y+gpq4zd+yFK1fpcm3
   8I/upm+RNzY2XKoZBdMcDETdRUAvqXo+lghB1IxxiBwUYeuFiroMD7pA6
   PJ0bAp6q6Co7DjpMMCszKd/VY4TBjl4Uf/NLojCbe2XPg0fKwDbll0K46
   hlaUxtL0xx0/daOaPNM2h7A1prrl/hsAVcW2zmti/ivW3RmV2IoItXbYj
   A==;
X-CSE-ConnectionGUID: PUHGu3paSs+JK7rYR0q4zg==
X-CSE-MsgGUID: r5n9bVWiTTCv9BQONokbGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="66176910"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="66176910"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 18:32:01 -0700
X-CSE-ConnectionGUID: n0RcUT1rQb6jF1SEzpIjnQ==
X-CSE-MsgGUID: RilZvfzJTxix+hnUEmtrTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162344083"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 Jul 2025 18:32:00 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugCib-000075-2Z;
	Mon, 28 Jul 2025 01:31:57 +0000
Date: Mon, 28 Jul 2025 09:31:32 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, andrii@kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/4] bpf: Move cgroup iterator helpers to bpf.h
Message-ID: <202507280945.m9sXKC5J-lkp@intel.com>
References: <20250727223223.510058-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727223223.510058-3-daniel@iogearbox.net>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Borkmann/bpf-Move-bpf-map-owner-out-of-common-struct/20250728-063408
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250727223223.510058-3-daniel%40iogearbox.net
patch subject: [PATCH bpf-next 3/4] bpf: Move cgroup iterator helpers to bpf.h
config: hexagon-randconfig-001-20250728 (https://download.01.org/0day-ci/archive/20250728/202507280945.m9sXKC5J-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250728/202507280945.m9sXKC5J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507280945.m9sXKC5J-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/socket.c:55:
>> include/linux/bpf-cgroup.h:510:9: warning: 'for_each_cgroup_storage_type' macro redefined [-Wmacro-redefined]
     510 | #define for_each_cgroup_storage_type(stype) for (; false; )
         |         ^
   include/linux/bpf.h:218:9: note: previous definition is here
     218 | #define for_each_cgroup_storage_type(stype) \
         |         ^
   1 warning generated.


vim +/for_each_cgroup_storage_type +510 include/linux/bpf-cgroup.h

de9cbbaadba5ad Roman Gushchin     2018-08-02  477  
6fc88c354f3af8 Dave Marchevsky    2021-08-19  478  #define cgroup_bpf_enabled(atype) (0)
fefba7d1ae198d Daan De Meyer      2023-10-11  479  #define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, atype, t_ctx) ({ 0; })
fefba7d1ae198d Daan De Meyer      2023-10-11  480  #define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, atype) ({ 0; })
d74bad4e74ee37 Andrey Ignatov     2018-03-30  481  #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
3007098494bec6 Daniel Mack        2016-11-23  482  #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
3007098494bec6 Daniel Mack        2016-11-23  483  #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk,skb) ({ 0; })
61023658760032 David Ahern        2016-12-01  484  #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk) ({ 0; })
f5836749c9c04a Stanislav Fomichev 2020-07-06  485  #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) ({ 0; })
fefba7d1ae198d Daan De Meyer      2023-10-11  486  #define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype, flags) ({ 0; })
aac3fc320d9404 Andrey Ignatov     2018-03-30  487  #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk) ({ 0; })
aac3fc320d9404 Andrey Ignatov     2018-03-30  488  #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk) ({ 0; })
fefba7d1ae198d Daan De Meyer      2023-10-11  489  #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
fefba7d1ae198d Daan De Meyer      2023-10-11  490  #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
fefba7d1ae198d Daan De Meyer      2023-10-11  491  #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
fefba7d1ae198d Daan De Meyer      2023-10-11  492  #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
859051dd165ec6 Daan De Meyer      2023-10-11  493  #define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
fefba7d1ae198d Daan De Meyer      2023-10-11  494  #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
fefba7d1ae198d Daan De Meyer      2023-10-11  495  #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
859051dd165ec6 Daan De Meyer      2023-10-11  496  #define BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
fefba7d1ae198d Daan De Meyer      2023-10-11  497  #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
fefba7d1ae198d Daan De Meyer      2023-10-11  498  #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
859051dd165ec6 Daan De Meyer      2023-10-11  499  #define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
40304b2a1567fe Lawrence Brakmo    2017-06-30  500  #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
6fc88c354f3af8 Dave Marchevsky    2021-08-19  501  #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
32927393dc1ccd Christoph Hellwig  2020-04-24  502  #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
0d01da6afc5402 Stanislav Fomichev 2019-06-27  503  #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, \
0d01da6afc5402 Stanislav Fomichev 2019-06-27  504  				       optlen, max_optlen, retval) ({ retval; })
9cacf81f816111 Stanislav Fomichev 2021-01-15  505  #define BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sock, level, optname, optval, \
9cacf81f816111 Stanislav Fomichev 2021-01-15  506  					    optlen, retval) ({ retval; })
0d01da6afc5402 Stanislav Fomichev 2019-06-27  507  #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
0d01da6afc5402 Stanislav Fomichev 2019-06-27  508  				       kernel_optval) ({ 0; })
3007098494bec6 Daniel Mack        2016-11-23  509  
8bad74f9840f87 Roman Gushchin     2018-09-28 @510  #define for_each_cgroup_storage_type(stype) for (; false; )
8bad74f9840f87 Roman Gushchin     2018-09-28  511  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

