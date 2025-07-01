Return-Path: <bpf+bounces-61938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E091AEECB6
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 05:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75283ADC1D
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 03:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A8C1E1E1E;
	Tue,  1 Jul 2025 03:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCT+O9xE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0451DFD8F;
	Tue,  1 Jul 2025 03:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339243; cv=none; b=bXKVkcv28y6r8CEs1bsRM+A+NdwT6y61Em00e9d/iSH7fvRUhY0ZGMzJ434frshJzJOtAxB+90ZPB1yxvX8U2dzrQ6szq1T3wXp2fmpVfvcnSWd8HIvZWYkYIXLPSn5BDZsT3kmG/IbAI5vWnjMquUMa23pcVeDgvItrkmAqDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339243; c=relaxed/simple;
	bh=1KpvVeS3qFIsYooM0nMl4TF5Db0B7YddNOvZu/Qgbbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+iyJPWdwdkeEYvTOx8Iy4sOt01gzso8p+A/3Wd/ZAufDsxIgzmr5MvoInN7Tr05eFH9pJAIslg14iMWkbH6i78v9A61cwfPg1r6GbO2kTpbmv5/IIuBU5yQPycBjgN/W748T+p32yNI/hYomkaFnHcYvlhqOU8MOAlOorRCeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCT+O9xE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751339242; x=1782875242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1KpvVeS3qFIsYooM0nMl4TF5Db0B7YddNOvZu/Qgbbc=;
  b=JCT+O9xESn1sOozcvO6zkuvV0uwuLI8zmuecwhVGZCnckNNFfidRgFXB
   /eDRTu+U8GZoyDiBo2tzW0ncMgqw+DAsaDd3CEJthk7YdCh25iWqa3ykg
   ZNIDhfEN2X+5c6/vjo/DsfQxHBk9jx1VnO8fKvB43ptkBHmqilwZUWEbb
   2teCEYcuafPOf2Ro1mlTr5GNiwjxNpJP3ScLA3ppOcnFmjOg6hSDAWN4K
   b6bZeonHgDHuQ87ZUmji3A0XXVBTaTsViYbSBGsBJBu9/WtKCjZ856Mlk
   3RGBydXTuZiksETxLvkb6QNVxNX+HO++s6iaiscFzd6ZLlg1H32A7vqkh
   g==;
X-CSE-ConnectionGUID: uISB+mjDS9qMsnTQAipOIw==
X-CSE-MsgGUID: H1KJxmDtRLO5g/M8xYlP+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64184367"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="64184367"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 20:07:21 -0700
X-CSE-ConnectionGUID: MyKt0ACIQCq3O+TCzow1hw==
X-CSE-MsgGUID: 62B+ZbGKTBqSHpoG33YrKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153928743"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2025 20:07:18 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWRL1-000ZbK-1w;
	Tue, 01 Jul 2025 03:07:15 +0000
Date: Tue, 1 Jul 2025 11:06:46 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Arthur Fabre <arthur@arthurfabre.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,
	Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
	kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next 02/13] bpf: Helpers for skb dynptr
 read/write/slice
Message-ID: <202507011044.vjYugeUq-lkp@intel.com>
References: <20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8@cloudflare.com>

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Sitnicki/bpf-Ignore-dynptr-offset-in-skb-data-access/20250630-225941
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8%40cloudflare.com
patch subject: [PATCH bpf-next 02/13] bpf: Helpers for skb dynptr read/write/slice
config: i386-buildonly-randconfig-002-20250701 (https://download.01.org/0day-ci/archive/20250701/202507011044.vjYugeUq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250701/202507011044.vjYugeUq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507011044.vjYugeUq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/bpf/helpers.c:15:
   include/linux/filter.h:1788:1: error: expected identifier or '(' before '{' token
    1788 | {
         | ^
   include/linux/filter.h:1795:1: error: expected identifier or '(' before '{' token
    1795 | {
         | ^
   kernel/bpf/helpers.c: In function '____bpf_snprintf':
   kernel/bpf/helpers.c:1068:9: warning: function '____bpf_snprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1068 |         err = bstr_printf(str, str_size, fmt, data.bin_args);
         |         ^~~
   include/linux/filter.h: At top level:
>> include/linux/filter.h:1785:19: warning: 'bpf_dynptr_skb_write' used but never defined
    1785 | static inline int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst,
         |                   ^~~~~~~~~~~~~~~~~~~~
>> include/linux/filter.h:1792:21: warning: 'bpf_dynptr_skb_slice' used but never defined
    1792 | static inline void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr,
         |                     ^~~~~~~~~~~~~~~~~~~~


vim +/bpf_dynptr_skb_write +1785 include/linux/filter.h

  1784	
> 1785	static inline int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst,
  1786					       u32 offset, const void *src, u32 len,
  1787					       u64 flags);
  1788	{
  1789		return -EOPNOTSUPP;
  1790	}
  1791	
> 1792	static inline void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr,
  1793						 u32 offset, void *buf, u32 len);
  1794	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

