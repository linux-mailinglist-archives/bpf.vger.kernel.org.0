Return-Path: <bpf+bounces-42783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F89AB012
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE1E1F23A38
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 13:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453D19F423;
	Tue, 22 Oct 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4TYgQMN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96919EED2;
	Tue, 22 Oct 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605050; cv=none; b=a6fOr+L+1d5yaBOlevW/d98wbGI2IOFN99VIPk/JNQi/GcB87a983MKVaf2V4zthkxS/iSzifA8pt7IdKdfvZNp33Q242rxnndXmuj/4iMGowFSx/Fp5nxQRXFzsF7IOh/6RfSH6JLmnYWxdDlWS8xDAxQ+aT/1OBb1DakaRXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605050; c=relaxed/simple;
	bh=epoMaoM6MMwh/KBGwPkmJaakzhozvJct5sHt4yT4Z9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp65WTpa6TGGkQoyByK+Z2nr+Wf8x46d7sDgA5txXbPXYiL2R6qkzi9XZd9YhrQ7imBBdZCfGmfWjiSzBdfm+VcO7sCEOsNRa/IvzbayKf4a4xAAhelFQGFgrL9ntIad3NyBoYRTnaCyR4DDLTbuIhqwzZO02bxd0gl+tbwqAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4TYgQMN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729605049; x=1761141049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=epoMaoM6MMwh/KBGwPkmJaakzhozvJct5sHt4yT4Z9s=;
  b=U4TYgQMN7o+rXv0y0pJv7HQEgnjo/B38pkJ0c5I4QKjSGi4hYJRLOYB7
   6gP4sevSyF5mBrcuN9ZzTiyBFvsB37xi7VFT9s/uUuj0Xp+LJgv9NYy6h
   tO2wyABY+5DyuXTNxGysnelvNB4c40+RW9CV8+ltslpPy0U2mUGQImWV3
   bXdMeXfZEpkySPOevdIAUmFEgZNhbxc6wMgdV54Gj7ZSE541popMQTs0j
   bseCD/77V3vfNWI/Ocj+TTba26FMlK8v9h3xTUXvt6Pvur1BxtVcE/7ND
   Xs1LJDAtUf3LeFOKWJe30ORr5HWo7JlytwCIoXLKKqMDTCRUGgggaBXSQ
   A==;
X-CSE-ConnectionGUID: 4P+BpasQRxWdd9E9CO+Sxg==
X-CSE-MsgGUID: MKYeqabVSQiWkbyj+v4HhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="40531462"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="40531462"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 06:50:47 -0700
X-CSE-ConnectionGUID: WQvPy/wOQryWrGcK4sqBHA==
X-CSE-MsgGUID: cHeUKNTnTiqUvliz9qbK9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80694139"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 22 Oct 2024 06:50:40 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3FHS-000Tdu-0u;
	Tue, 22 Oct 2024 13:50:38 +0000
Date: Tue, 22 Oct 2024 21:50:28 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Helge Deller <deller@gmx.de>, Jakub Kicinski <kuba@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/5] net: checksum: move from32to16() to generic
 header
Message-ID: <202410222149.3FVJFYYy-lkp@intel.com>
References: <20241021122112.101513-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021122112.101513-2-puranjay@kernel.org>

Hi Puranjay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/net-checksum-move-from32to16-to-generic-header/20241021-202707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241021122112.101513-2-puranjay%40kernel.org
patch subject: [PATCH bpf-next 1/5] net: checksum: move from32to16() to generic header
config: x86_64-randconfig-122-20241022 (https://download.01.org/0day-ci/archive/20241022/202410222149.3FVJFYYy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241022/202410222149.3FVJFYYy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410222149.3FVJFYYy-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/checksum.c:84:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int [assigned] result @@
   lib/checksum.c:84:34: sparse:     expected restricted __wsum [usertype] sum
   lib/checksum.c:84:34: sparse:     got unsigned int [assigned] result
>> lib/checksum.c:84:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] result @@     got restricted __sum16 @@
   lib/checksum.c:84:16: sparse:     expected unsigned int [assigned] result
   lib/checksum.c:84:16: sparse:     got restricted __sum16

vim +84 lib/checksum.c

    35	
    36	#ifndef do_csum
    37	static unsigned int do_csum(const unsigned char *buff, int len)
    38	{
    39		int odd;
    40		unsigned int result = 0;
    41	
    42		if (len <= 0)
    43			goto out;
    44		odd = 1 & (unsigned long) buff;
    45		if (odd) {
    46	#ifdef __LITTLE_ENDIAN
    47			result += (*buff << 8);
    48	#else
    49			result = *buff;
    50	#endif
    51			len--;
    52			buff++;
    53		}
    54		if (len >= 2) {
    55			if (2 & (unsigned long) buff) {
    56				result += *(unsigned short *) buff;
    57				len -= 2;
    58				buff += 2;
    59			}
    60			if (len >= 4) {
    61				const unsigned char *end = buff + ((unsigned)len & ~3);
    62				unsigned int carry = 0;
    63				do {
    64					unsigned int w = *(unsigned int *) buff;
    65					buff += 4;
    66					result += carry;
    67					result += w;
    68					carry = (w > result);
    69				} while (buff < end);
    70				result += carry;
    71				result = (result & 0xffff) + (result >> 16);
    72			}
    73			if (len & 2) {
    74				result += *(unsigned short *) buff;
    75				buff += 2;
    76			}
    77		}
    78		if (len & 1)
    79	#ifdef __LITTLE_ENDIAN
    80			result += *buff;
    81	#else
    82			result += (*buff << 8);
    83	#endif
  > 84		result = csum_from32to16(result);
    85		if (odd)
    86			result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
    87	out:
    88		return result;
    89	}
    90	#endif
    91	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

