Return-Path: <bpf+bounces-71959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED73C02BCE
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC18F3A848D
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155A34A3B7;
	Thu, 23 Oct 2025 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6MSX1u9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96626FDB3;
	Thu, 23 Oct 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240713; cv=none; b=hqFrwEKezvGqZYXU4jhs0GF/jpJ/zLZMT/qxAx9DY6kwEMQCwS3AXrnfk+Kd5JORxBrV9oBDvlffu5DfCEo6X6U4vhURHL74IMsWd72hMvoyA5lOokK9ci3easCAIK8UgK+ut+KvA+qyivQaKjBuqQLUW0LX1REepfLgZBWc1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240713; c=relaxed/simple;
	bh=qCt/q5LX7oiI9oMA9mgLnVRZbrHlrL7h0luSCJ9yxLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7JcXPxVeFz88t5j1BOW8aDlvDxuP3OwkzoVp0HpcesQuHYqDqMdEADNwc4ozcVGx6CJRU6BTxYSReiL/rR7jwXcEdClit067SUjXFK71AjO3zn5mLAMrYXZagMVMudp+XceC9EiJdZmJslZfF8aQfJJNGawjut/9GS00TEZkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6MSX1u9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761240712; x=1792776712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qCt/q5LX7oiI9oMA9mgLnVRZbrHlrL7h0luSCJ9yxLI=;
  b=M6MSX1u9S/PUYm2Q+8u5ef7q7uiZgFtVPIe8UmC2aFhq3xrqW49wKzCT
   dWZVy0rynLlMnbia3hChBdAXZgUVatmiojMLBo8ZFeOi1gXZr74hVZ0qh
   GicosbUt7EIMFjTcqh0A6Kb5fszc9PBjou0lFhn4zs0M8c/sXV7aKq5hG
   LYEySvoUhjOCoZcdvC54AnWKD2i14Ap++FyLs8RsERiDqnqlqD7ygr0hy
   XUvuGaLSbdqYAeZ0Wv/dRixZpV3ghaW8LD2zLhMQG3SonlcQNIYOvFxya
   /56EGweWLweoCbVIM+z69lzs3O/XJcMOVMj/30zdQGPs/sXqXiU3rmwGu
   w==;
X-CSE-ConnectionGUID: ONZlS3aVTQGaoJB+DVTItA==
X-CSE-MsgGUID: y23JeTaHT52yOdT0nyOkOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73709585"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="73709585"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:31:52 -0700
X-CSE-ConnectionGUID: PI2AutHWTXSDz/T+HE2Dsw==
X-CSE-MsgGUID: kcm4vEV4Ru6/YP4R0EYWfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="184602122"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 23 Oct 2025 10:31:47 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBzA9-000Djp-0E;
	Thu, 23 Oct 2025 17:31:45 +0000
Date: Fri, 24 Oct 2025 01:30:57 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 3/9] xsk: add xsk_alloc_batch_skb() to build
 skbs in batch
Message-ID: <202510240143.n4pyKF6s-lkp@intel.com>
References: <20251021131209.41491-4-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021131209.41491-4-kerneljasonxing@gmail.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/xsk-introduce-XDP_GENERIC_XMIT_BATCH-setsockopt/20251021-211646
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251021131209.41491-4-kerneljasonxing%40gmail.com
patch subject: [PATCH net-next v3 3/9] xsk: add xsk_alloc_batch_skb() to build skbs in batch
config: powerpc-ep8248e_defconfig (https://download.01.org/0day-ci/archive/20251024/202510240143.n4pyKF6s-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510240143.n4pyKF6s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510240143.n4pyKF6s-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: net/core/skbuff.o: in function `xsk_alloc_batch_skb':
   net/core/skbuff.c:701:(.text+0x61cc): undefined reference to `xsk_build_skb'
>> powerpc-linux-ld: net/core/skbuff.c:701:(.text+0x62ec): undefined reference to `xsk_build_skb'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

