Return-Path: <bpf+bounces-64589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12EAB146F0
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 05:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D363B8F3B
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 03:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67938221F0F;
	Tue, 29 Jul 2025 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXnVZKJd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C427221D92;
	Tue, 29 Jul 2025 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753760607; cv=none; b=p3Y03ei1JavsPTi7r+1epd8/nvEpaBdRjqmoePQWGlN5vWXNp52NxjUIePpphipUjntt8xM4WHH8MTWXs15wZYVgfeTp/7roPNusQSOXmqae5lQCi0qTgdvDsmdBzs/zXYoX/Bqbsv5/31MG4aEYplc49+pGAEPPCcaAdPcvfmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753760607; c=relaxed/simple;
	bh=MSHUoTMwY9oyY7Q1By+Pt8D/32X7z1oJYuHmG752vAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMvImE7Rdv0kUSlXmJ4FjRSFwbBHeH5GO+jDU9m+VbNBA85y3I6a6/67OUJ28gyqu28/h8oTXSWkhZm7TTvBW/QaTNyV0G+O3yfNT8p316g0qWZ/af2oZA/BzJfdU54yUsaorCbC1azQqEud19FtjTYbH1XJr13S7DaIvtCSGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXnVZKJd; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753760605; x=1785296605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MSHUoTMwY9oyY7Q1By+Pt8D/32X7z1oJYuHmG752vAk=;
  b=KXnVZKJduo1izaWZ6KJGoChfgyx7AL7YF+5a7lRCvS7q5Tl8Fi8Y0ZRF
   XkA8swUlpSZR3L4BQ9mWo6JQUpYl4xQiuJKrfGxxxet9WGIA3kuyuVaZ1
   Ax3AAdi5YnwfygZn0hRAHaNC3v1lPdcXJjAcTyqTKTL4dpIadjU9jLyMm
   aJtoMc4DNL0losDTW6b8IGqqHpd8OjHgP1EC8C7rNv0DdwDxKuQIHWxjB
   omkT/snzPxpo3rX88eiJgFcH8ukGhHAp7T4yEfGKTgD7qwawKxizNaKSQ
   tfNItF4CWrmEBX3iAlB4gp6QKuGVucAZ0QhjJttiOqGONFKc5EJyT9/Dv
   g==;
X-CSE-ConnectionGUID: 95OAQGZmTN6YA6TVmYAbJQ==
X-CSE-MsgGUID: e31MsPbTSVWiXnTEsWq4yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="56169093"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="56169093"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 20:43:24 -0700
X-CSE-ConnectionGUID: SXW922UHQ2KYmkp/06qCFA==
X-CSE-MsgGUID: ObdttVA4S2SxFdfQh85pxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="186235766"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Jul 2025 20:43:21 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugbFH-0000xL-2p;
	Tue, 29 Jul 2025 03:43:19 +0000
Date: Tue, 29 Jul 2025 11:43:12 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
	mhiramat@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com, revest@chromium.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/4] fprobe: use rhashtable
Message-ID: <202507291147.Fov8pl4N-lkp@intel.com>
References: <20250728041252.441040-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728041252.441040-2-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/fprobe-use-rhashtable/20250728-121631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250728041252.441040-2-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next 1/4] fprobe: use rhashtable
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20250729/202507291147.Fov8pl4N-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507291147.Fov8pl4N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507291147.Fov8pl4N-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/trace/fprobe.c:8:
>> include/linux/fprobe.h:29:20: error: field has incomplete type 'struct rhash_head'
      29 |         struct rhash_head       hlist;
         |                                 ^
   include/linux/fprobe.h:29:9: note: forward declaration of 'struct rhash_head'
      29 |         struct rhash_head       hlist;
         |                ^
>> kernel/trace/fprobe.c:71:17: error: initializer element is not a compile-time constant
      71 |         .key_offset             = offsetof(struct fprobe_hlist_node, addr),
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.
--
   In file included from kernel/trace/trace_fprobe.c:9:
>> include/linux/fprobe.h:29:20: error: field has incomplete type 'struct rhash_head'
      29 |         struct rhash_head       hlist;
         |                                 ^
   include/linux/fprobe.h:29:9: note: forward declaration of 'struct rhash_head'
      29 |         struct rhash_head       hlist;
         |                ^
   1 error generated.


vim +29 include/linux/fprobe.h

    11	
    12	struct fprobe;
    13	typedef int (*fprobe_entry_cb)(struct fprobe *fp, unsigned long entry_ip,
    14				       unsigned long ret_ip, struct ftrace_regs *regs,
    15				       void *entry_data);
    16	
    17	typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
    18				       unsigned long ret_ip, struct ftrace_regs *regs,
    19				       void *entry_data);
    20	
    21	/**
    22	 * struct fprobe_hlist_node - address based hash list node for fprobe.
    23	 *
    24	 * @hlist: The hlist node for address search hash table.
    25	 * @addr: One of the probing address of @fp.
    26	 * @fp: The fprobe which owns this.
    27	 */
    28	struct fprobe_hlist_node {
  > 29		struct rhash_head	hlist;
    30		unsigned long		addr;
    31		struct fprobe		*fp;
    32	};
    33	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

