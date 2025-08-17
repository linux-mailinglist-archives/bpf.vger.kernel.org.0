Return-Path: <bpf+bounces-65841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAE5B29552
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 00:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11065178D25
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 22:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACFB221DA3;
	Sun, 17 Aug 2025 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjiW7zD4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E041C63;
	Sun, 17 Aug 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755468427; cv=none; b=cehex5230ST7ZsCHz8VnAYbrhcalT9nuTu7lWr06dS7sKHPpRWpH8lBQULrdQqBQPEHZCUHGPuBA5yCZlOfgfyGcROZnM5nBSBn9vQIKT5wa3JATTmnUhlBtergBNzcJhDALbO+7CoHPha7t9Dhu7J58mpVlxBB5/O685rWvABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755468427; c=relaxed/simple;
	bh=zpUl0zheLy5NDYN7VEg3PlKRz2DeeuHjGTiWDGX1+1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrN2/0US9qfQmBvXkNjgqJO2BWPG7V4fUbY2Usyz8N+F5V65D0gvSjtnMkModxcLKEhuf8vtPEpzgOJ4nMjTwiMxpb8WotNwhQbXZ45w38nkEQWJnDrzQXjVxKt/RPyZZ1V8JcsVAVHD6UFLRsh9UH9qpeF3ZZL1sN3CG3lSi4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjiW7zD4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755468424; x=1787004424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zpUl0zheLy5NDYN7VEg3PlKRz2DeeuHjGTiWDGX1+1Y=;
  b=DjiW7zD4bUgdzuyx6xh4+YOzyeBJFJEwt2EunIbcXmPneFPiDtZmQLg3
   cGVyP85Cvte4OEyq72ugvlhZnGiI9h2GQPP/BDhBXwPY4Frro04NlMvja
   1qUFZHjuO6zDU+MW+X7cXwtSolin+RGrZrNbAE30bpQeBlt3KmIurWWrU
   tgwHo+DQ/RIl4YTsmzozyAODIoaYDZKrNCwXsY0BBAeDDUdvw4fF6T3iC
   Fp/YtELVTgCYgzAUm5tewTlknDQWju4LGbX60mc5U5S5KE0kS3kexVNFd
   9laa0t7RBQLBgOsnilVrE91inAViNoyipaX9/npzFKqs2NF0Fh3Qilcbo
   Q==;
X-CSE-ConnectionGUID: yDq1T02MRt6mrUkoSoOl+w==
X-CSE-MsgGUID: /kxdx3R4Tf+mMXezluhbxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57799119"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57799119"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 15:07:04 -0700
X-CSE-ConnectionGUID: GlhdEQL6SreESSRdpR4x8w==
X-CSE-MsgGUID: Gl7609VGQE62K4AD3Sdybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="191126910"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 17 Aug 2025 15:07:01 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unlVY-000Dk3-37;
	Sun, 17 Aug 2025 22:06:24 +0000
Date: Mon, 18 Aug 2025 06:05:28 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, stfomichev@gmail.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v4 bpf] xsk: fix immature cq descriptor production
Message-ID: <202508180712.ZeSSNfkM-lkp@intel.com>
References: <20250813171210.2205259-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813171210.2205259-1-maciej.fijalkowski@intel.com>

Hi Maciej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/xsk-fix-immature-cq-descriptor-production/20250814-012129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20250813171210.2205259-1-maciej.fijalkowski%40intel.com
patch subject: [PATCH v4 bpf] xsk: fix immature cq descriptor production
config: x86_64-randconfig-121-20250817 (https://download.01.org/0day-ci/archive/20250818/202508180712.ZeSSNfkM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250818/202508180712.ZeSSNfkM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508180712.ZeSSNfkM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/xdp/xsk.c:49:1: sparse: sparse: symbol '__pcpu_scope_system_xsk_generic_cache' was not declared. Should it be static?

vim +/__pcpu_scope_system_xsk_generic_cache +49 net/xdp/xsk.c

    48	
  > 49	DEFINE_PER_CPU(struct xsk_generic_cache, system_xsk_generic_cache);
    50	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

