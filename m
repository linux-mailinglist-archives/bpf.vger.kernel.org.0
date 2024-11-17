Return-Path: <bpf+bounces-45040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A799D01FE
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 05:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1762D286B7D
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 04:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C311CAF;
	Sun, 17 Nov 2024 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdyUGHov"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE1C372
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731818034; cv=none; b=I6uPwBfvMn/xyowK7DX8ATUm5zE03I69Zf0hPIGb5phICYbUqxbSVZ4dKKMDx8HON9jMYZ08pP9ADL9EENgOkbN9Fd+hMXxp14w7Ygfo3AvItGIWikuoqfYKL0eI3FHlmn59F0hMVXA+8EJaGqNjVc+fm3Jv48XADrBg5j572+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731818034; c=relaxed/simple;
	bh=1Vk2VqWVIURtz19yjFoMywajXg0xlv4tRnDkl7hWAk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6YlBVOwKBfakNjRITDc8sYJEEgeIhZIxAz2GCOPvj6qMor09gLyOgUtgvIGJRlT/DmPcaoz0WQ0fVYk9kztHHvdop/Wqv74QoopaOeba5DhFSyo14kpad2MmxKmJymGbHPl1d4JZVfLMdT8meMydrjiZxng1qAWaFpYvMBBhX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdyUGHov; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731818033; x=1763354033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Vk2VqWVIURtz19yjFoMywajXg0xlv4tRnDkl7hWAk0=;
  b=VdyUGHovtAS/tB/67tyXZP9R3y2A6xIgBLqz2J299XaXJD7AbdiTT3RE
   J0gNO6yng4Yi37fGJHzh0aaOIPPefwPLtjn0ekHhu3schrJRWKBsAV+78
   ukKLtAgNCQhOBO+gbtshQNJdPP16gwMIMS5tXGfuWUSYQqnof71fUbqst
   hwhR3Tn4tJV0InezlSEymHvg8NLjAW8fPyTDlWfE4kOxo0N1GxHddZxOu
   1Oys/MPICY+CO90CSYAwIaZJIVVUXPdCgja5yEMHVJPLlZdBwQekh3Kmi
   Z+CXRUXWTl/Ff5qe5YH7F2iEphFVc1/ZJ/K9e3zGN1vkDYExRKvHfujB7
   w==;
X-CSE-ConnectionGUID: I6+G5NrEQKWjJqP9SdjlVA==
X-CSE-MsgGUID: CgLh5FJBRTi57CA8SC1+lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31174362"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="31174362"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 20:33:52 -0800
X-CSE-ConnectionGUID: w8glA+HLRQCbAs39FYnsQw==
X-CSE-MsgGUID: 7+IDGebWRs6A2QHCVXVrYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="89322304"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 16 Nov 2024 20:33:51 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCWyq-0001Sf-0T;
	Sun, 17 Nov 2024 04:33:48 +0000
Date: Sun, 17 Nov 2024 12:33:09 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Wilson <ryantimwilson@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc: oe-kbuild-all@lists.linux.dev, ryantimwilson@meta.com
Subject: Re: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
Message-ID: <202411171224.YudPDabe-lkp@intel.com>
References: <20241114170721.3939099-1-ryantimwilson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114170721.3939099-1-ryantimwilson@gmail.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Wilson/bpf-Add-multi-prog-support-for-XDP-BPF-programs/20241115-015104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241114170721.3939099-1-ryantimwilson%40gmail.com
patch subject: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
config: arc-defconfig (https://download.01.org/0day-ci/archive/20241117/202411171224.YudPDabe-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171224.YudPDabe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171224.YudPDabe-lkp@intel.com/

All errors (new ones prefixed by >>):

   arc-elf-ld: net/core/dev.o: in function `dev_xdp_attach_netlink.constprop.0':
   dev.c:(.text+0xddb2): undefined reference to `bpf_mprog_detach'
>> arc-elf-ld: dev.c:(.text+0xddb2): undefined reference to `bpf_mprog_detach'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

