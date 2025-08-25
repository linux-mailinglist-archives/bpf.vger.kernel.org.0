Return-Path: <bpf+bounces-66407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F05B34810
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 18:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393F27AE8C6
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514D33019A7;
	Mon, 25 Aug 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baiFo9bD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88002F0694;
	Mon, 25 Aug 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141045; cv=none; b=HlkB2MPlvxNwLB3pAkJoPbQ9YjTqqS1Mg/C0Fz06FVhVXIp5XEjTx6OC3jzAE8XoPhrXC+IB3Tmjliypz2RTX4rxgI7YBQlrKsLJBk/UNu6w1+9k388qj2Jx1A7PjG0O/VRzPk1uNG+PrQ3U8Y6RV2aevie4N83uIijhIQVbP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141045; c=relaxed/simple;
	bh=sEe2Kjb73cyMrklNt7i9Cp03Sqbobdi1D7T+QgIjmDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eG4WWNZL42f4yZ6UFNA2pmX4iURB+iuWONkRl0XEDssLPzwym+pRLu9eg6vUYB+UiEfpK0ayjP+XDnLxxOiC10IhOiAbo9kI4sJ7eiEeuZ2QZlZ5A/6GH+SORPBOiP7P5jiwFQlFuxCm0y5edpkya2ximPU29iIF/Sv7fTA3DME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baiFo9bD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756141044; x=1787677044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sEe2Kjb73cyMrklNt7i9Cp03Sqbobdi1D7T+QgIjmDk=;
  b=baiFo9bDUG8zCllqXePc694tKZAcii/TQRg2MTkdbPkIFC8s0dVSTfvB
   +0ZDx7SqAJMj0SKevOGRrsqZ6j6H/VEqyf9UFmsVN1EqIVM+ZAlTf45Em
   HRZ4l+fghW7YIVhwCZCN84lOZvCYoPeVWoRbk5Pv+JLEwFOhLJWRL/0+t
   NGs3I9BGkcbVv84gSEVHufOmB7ydPGjIQ+XfMN9fKTsWsq4owzxZ/prVC
   KCJHZuMtJCC9MyRHkI/PfAfYP7rs+NZma+EjbzVbN/CVnKlqpGez5hNdQ
   hBw/ua8QLRFu4D9HBhTADJecko7qnKK0fDwja4L+/gomABnDdK++ybJMf
   w==;
X-CSE-ConnectionGUID: D3Mi36EjRbWoXe7XzRyApQ==
X-CSE-MsgGUID: V26QtKM/TK6NFgvdz3UOWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62186815"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62186815"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 09:57:23 -0700
X-CSE-ConnectionGUID: QJvU2XXuQtmQ6GJE7DHYVg==
X-CSE-MsgGUID: TgJFq6KJTFiNM3UGwwHrzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="173744658"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 25 Aug 2025 09:57:19 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqaVQ-000Nrr-1p;
	Mon, 25 Aug 2025 16:57:16 +0000
Date: Tue, 26 Aug 2025 00:56:52 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 5/9] xsk: add xsk_alloc_batch_skb() to build
 skbs in batch
Message-ID: <202508260022.JtJJJkAw-lkp@intel.com>
References: <20250825135342.53110-6-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825135342.53110-6-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/xsk-introduce-XDP_GENERIC_XMIT_BATCH-setsockopt/20250825-220610
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250825135342.53110-6-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next v2 5/9] xsk: add xsk_alloc_batch_skb() to build skbs in batch
config: i386-buildonly-randconfig-001-20250825 (https://download.01.org/0day-ci/archive/20250826/202508260022.JtJJJkAw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250826/202508260022.JtJJJkAw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508260022.JtJJJkAw-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: net/core/skbuff.o: in function `xsk_alloc_batch_skb':
>> skbuff.c:(.text+0x7e69): undefined reference to `xsk_build_skb'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

