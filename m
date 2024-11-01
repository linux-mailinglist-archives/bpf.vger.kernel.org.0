Return-Path: <bpf+bounces-43704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01949B8A54
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 06:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C12825CE
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 05:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5521014AD3F;
	Fri,  1 Nov 2024 05:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UN5ribLw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA4F149DF7;
	Fri,  1 Nov 2024 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730437697; cv=none; b=L7BsioyXFADbPA3/MMDaO41AnOCVeIZUnsRYE04GyDEKrT9ufjCtUw/yj0nli42fBKzlvg3i+qoBoPszKmN7fMBCrjQNbZAvoEhB+nb0Tyj23jQmIOmPT6jox+zxATjBg7AEqxWfiZ9Kv61ruWqaUHz95QQWf0PMytQUWvFSoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730437697; c=relaxed/simple;
	bh=H7vjDWGQG26wOoS585XzWgyDF2JFLlayqip2raZHkC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTxRW5TSmxLJaYfTRZJSM70CP4H8zh9SAz2CXIghqRdm5tYXfXjTuYh/lvF5/WcywVZHWx2pfJrJx3h+kvOg1Gdw5Sb3vb3loDbDm+4P37mK8fINtPA7uu8ywx+mJSD7bVWh9GktKmDdCnbUeEr5Ska3/UdSJhkfuwzGAmcKbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UN5ribLw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730437696; x=1761973696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H7vjDWGQG26wOoS585XzWgyDF2JFLlayqip2raZHkC8=;
  b=UN5ribLw3cZF1WdxQ5+lmc/pYOr8mw1RlvlFe0N/FnLhK2KQDrHI/044
   SeCykq5Ic+pGFmX7y51j2wvdhu2OOWPmw9Uc1M7ukdt3lrtMxetXMavUp
   5s2adPxIMRKd7cT2md+U6wGWWENDjSZWUXo1knB8DW90opMEqAlQd6+4t
   bG1bzy0fDw1hWrIopBdeKD9t3f6BnvimLjQ/wOSCWZrMFKaUq5iiE4G8Z
   C54Pn4hUWMeUo1YxZo9b1WCsUW9AZj0lloPKoWinj5yrSY/pIzSdMg7lx
   iQeIpjT2MYfMadYaoPpBSMprebZvIlwR9OmFK4jsqZW76i89Xl1rgMd7U
   A==;
X-CSE-ConnectionGUID: aFDhHUPUTkaY1D2XSLUYLQ==
X-CSE-MsgGUID: RSvx8SzER5O/s8yE8ijyYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30091586"
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="30091586"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 22:08:12 -0700
X-CSE-ConnectionGUID: gyuYbdDbS8CwziV/0jEL0g==
X-CSE-MsgGUID: GyW6NjXMRZOc6wgrERN0Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="120315135"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 31 Oct 2024 22:08:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6jtF-000h9r-2s;
	Fri, 01 Nov 2024 05:08:05 +0000
Date: Fri, 1 Nov 2024 13:07:07 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, rostedt@goodmis.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, mhiramat@kernel.org,
	peterz@infradead.org, paulmck@kernel.org, jrife@google.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH trace/for-next 2/3] bpf: decouple BPF link/attach hook
 and BPF program sleepable semantics
Message-ID: <202411011244.LrXOUj8p-lkp@intel.com>
References: <20241031210938.1696639-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031210938.1696639-2-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-decouple-BPF-link-attach-hook-and-BPF-program-sleepable-semantics/20241101-051131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20241031210938.1696639-2-andrii%40kernel.org
patch subject: [PATCH trace/for-next 2/3] bpf: decouple BPF link/attach hook and BPF program sleepable semantics
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20241101/202411011244.LrXOUj8p-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411011244.LrXOUj8p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411011244.LrXOUj8p-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/dev.c: In function 'bpf_xdp_link_attach':
>> net/core/dev.c:9767:9: error: too few arguments to function 'bpf_link_init'
    9767 |         bpf_link_init(&link->link, BPF_LINK_TYPE_XDP, &bpf_xdp_link_lops, prog);
         |         ^~~~~~~~~~~~~
   In file included from include/linux/security.h:35,
                    from include/net/scm.h:9,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:44,
                    from net/core/dev.c:92:
   include/linux/bpf.h:2724:20: note: declared here
    2724 | static inline void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
         |                    ^~~~~~~~~~~~~


vim +/bpf_link_init +9767 net/core/dev.c

aa8d3a716b59db Andrii Nakryiko 2020-07-21  9744  
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9745  int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9746  {
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9747  	struct net *net = current->nsproxy->net_ns;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9748  	struct bpf_link_primer link_primer;
bf4ea1d0b2cb22 Leon Hwang      2023-08-01  9749  	struct netlink_ext_ack extack = {};
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9750  	struct bpf_xdp_link *link;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9751  	struct net_device *dev;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9752  	int err, fd;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9753  
5acc7d3e8d3428 Xuan Zhuo       2021-07-10  9754  	rtnl_lock();
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9755  	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
5acc7d3e8d3428 Xuan Zhuo       2021-07-10  9756  	if (!dev) {
5acc7d3e8d3428 Xuan Zhuo       2021-07-10  9757  		rtnl_unlock();
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9758  		return -EINVAL;
5acc7d3e8d3428 Xuan Zhuo       2021-07-10  9759  	}
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9760  
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9761  	link = kzalloc(sizeof(*link), GFP_USER);
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9762  	if (!link) {
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9763  		err = -ENOMEM;
5acc7d3e8d3428 Xuan Zhuo       2021-07-10  9764  		goto unlock;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9765  	}
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9766  
aa8d3a716b59db Andrii Nakryiko 2020-07-21 @9767  	bpf_link_init(&link->link, BPF_LINK_TYPE_XDP, &bpf_xdp_link_lops, prog);
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9768  	link->dev = dev;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9769  	link->flags = attr->link_create.flags;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9770  
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9771  	err = bpf_link_prime(&link->link, &link_primer);
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9772  	if (err) {
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9773  		kfree(link);
5acc7d3e8d3428 Xuan Zhuo       2021-07-10  9774  		goto unlock;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9775  	}
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9776  
bf4ea1d0b2cb22 Leon Hwang      2023-08-01  9777  	err = dev_xdp_attach_link(dev, &extack, link);
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9778  	rtnl_unlock();
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9779  
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9780  	if (err) {
5acc7d3e8d3428 Xuan Zhuo       2021-07-10  9781  		link->dev = NULL;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9782  		bpf_link_cleanup(&link_primer);
bf4ea1d0b2cb22 Leon Hwang      2023-08-01  9783  		trace_bpf_xdp_link_attach_failed(extack._msg);
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9784  		goto out_put_dev;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9785  	}
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9786  
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9787  	fd = bpf_link_settle(&link_primer);
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9788  	/* link itself doesn't hold dev's refcnt to not complicate shutdown */
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9789  	dev_put(dev);
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9790  	return fd;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9791  
5acc7d3e8d3428 Xuan Zhuo       2021-07-10  9792  unlock:
5acc7d3e8d3428 Xuan Zhuo       2021-07-10  9793  	rtnl_unlock();
5acc7d3e8d3428 Xuan Zhuo       2021-07-10  9794  
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9795  out_put_dev:
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9796  	dev_put(dev);
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9797  	return err;
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9798  }
aa8d3a716b59db Andrii Nakryiko 2020-07-21  9799  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

