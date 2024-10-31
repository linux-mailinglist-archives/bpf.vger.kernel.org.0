Return-Path: <bpf+bounces-43622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCB59B7270
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 03:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630911C23521
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 02:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A222E12DD90;
	Thu, 31 Oct 2024 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEoO7EL8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27033D994;
	Thu, 31 Oct 2024 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730341195; cv=none; b=fJQPnBMotAkrt2mlcbGX+TFNzTXY0grcfc4vk9PvMPBW7TopCtulkaGWp1s1HsU50BoirNlzCIs17kTIaEk+MoTGOwcm5Tw1W0+ldPT0xTSIi/roJ8HBRKJ00XOKf9ztOGnTgCb7haokP84qEQLJsI8f/PJP45DfRuzcc2Op2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730341195; c=relaxed/simple;
	bh=NC9CDOFTbxQbG8x/a/AHSZzkUSoApy76KPCBDimnLaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjq9B+q5/JhNiHkL3tdq/DVEnLvDSaBHHR7cLgpfo6G1xb5wQSvYzOJR7eb3RsLN16SpBIXna0PF31pSZnZQrlMMLULhMSB7ZjWWLSzlxVQMC83QZLBkNyq94jJvT1ur59crzRmHeI9HG3gkjg41bU5lP+sAFNnHke4j34/f7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEoO7EL8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730341192; x=1761877192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NC9CDOFTbxQbG8x/a/AHSZzkUSoApy76KPCBDimnLaU=;
  b=CEoO7EL8w+cFGN9fQgAdLtkWLmHhmp9xfVVUNS0aMcSGXSv2o2QSl7pl
   1qw2JtJOJ4RCCG+zIKgVg+i/S10n8Z7rcPqvuo9dIA5ct89X/ehYf2beZ
   khlRlGCFXSytweLpesNjigJmrdi9rcBgfPrnsBGBcW0k6pyfVEiG05rUj
   Y0TyTUCVM8P4KBiRIU8OTri63Jo+cHedonyVu7HRos13iDIeknt4arctV
   mPcooD8QE0EE80POI10Y5OoEGSgnoRmEmppKj/4T8qDzfOFvDRZV7aYQ6
   /Eg+wqMSKeH/fxSw79ZrEDUv1AwyyzbPgjNIOEUKOygG7jeTru5FMeV+H
   A==;
X-CSE-ConnectionGUID: 5iB9ZxBJSSCN1weyXP0k7w==
X-CSE-MsgGUID: fr0f8wuRS5GICxd4vRtx6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29964351"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="29964351"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 19:19:51 -0700
X-CSE-ConnectionGUID: TVktP3QLRqmkXfoXsTvVmg==
X-CSE-MsgGUID: 2VxImrEYTtqGDDBRJWNxvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87281480"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Oct 2024 19:19:46 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6Kmm-000fYC-1r;
	Thu, 31 Oct 2024 02:19:44 +0000
Date: Thu, 31 Oct 2024 10:19:41 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 05/13] virtio_ring: introduce add api for
 premapped
Message-ID: <202410310925.LuCycrTj-lkp@intel.com>
References: <20241030082453.97310-6-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030082453.97310-6-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-introduce-vring_need_unmap_buffer/20241030-162739
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241030082453.97310-6-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net-next v2 05/13] virtio_ring: introduce add api for premapped
config: x86_64-buildonly-randconfig-003-20241031 (https://download.01.org/0day-ci/archive/20241031/202410310925.LuCycrTj-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410310925.LuCycrTj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410310925.LuCycrTj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio_ring.c:2293: warning: Function parameter or struct member 'premapped' not described in 'virtqueue_add_outbuf_premapped'
>> drivers/virtio/virtio_ring.c:2364: warning: Function parameter or struct member 'premapped' not described in 'virtqueue_add_inbuf_premapped'


vim +2293 drivers/virtio/virtio_ring.c

  2274	
  2275	/**
  2276	 * virtqueue_add_outbuf_premapped - expose output buffers to other end
  2277	 * @vq: the struct virtqueue we're talking about.
  2278	 * @sg: scatterlist (must be well-formed and terminated!)
  2279	 * @num: the number of entries in @sg readable by other side
  2280	 * @data: the token identifying the buffer.
  2281	 * @gfp: how to do memory allocations (if necessary).
  2282	 *
  2283	 * Caller must ensure we don't call this with other virtqueue operations
  2284	 * at the same time (except where noted).
  2285	 *
  2286	 * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
  2287	 */
  2288	int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
  2289					   struct scatterlist *sg, unsigned int num,
  2290					   void *data,
  2291					   bool premapped,
  2292					   gfp_t gfp)
> 2293	{
  2294		return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, premapped, gfp);
  2295	}
  2296	EXPORT_SYMBOL_GPL(virtqueue_add_outbuf_premapped);
  2297	
  2298	/**
  2299	 * virtqueue_add_inbuf - expose input buffers to other end
  2300	 * @vq: the struct virtqueue we're talking about.
  2301	 * @sg: scatterlist (must be well-formed and terminated!)
  2302	 * @num: the number of entries in @sg writable by other side
  2303	 * @data: the token identifying the buffer.
  2304	 * @gfp: how to do memory allocations (if necessary).
  2305	 *
  2306	 * Caller must ensure we don't call this with other virtqueue operations
  2307	 * at the same time (except where noted).
  2308	 *
  2309	 * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
  2310	 */
  2311	int virtqueue_add_inbuf(struct virtqueue *vq,
  2312				struct scatterlist *sg, unsigned int num,
  2313				void *data,
  2314				gfp_t gfp)
  2315	{
  2316		return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, false, gfp);
  2317	}
  2318	EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
  2319	
  2320	/**
  2321	 * virtqueue_add_inbuf_ctx - expose input buffers to other end
  2322	 * @vq: the struct virtqueue we're talking about.
  2323	 * @sg: scatterlist (must be well-formed and terminated!)
  2324	 * @num: the number of entries in @sg writable by other side
  2325	 * @data: the token identifying the buffer.
  2326	 * @ctx: extra context for the token
  2327	 * @gfp: how to do memory allocations (if necessary).
  2328	 *
  2329	 * Caller must ensure we don't call this with other virtqueue operations
  2330	 * at the same time (except where noted).
  2331	 *
  2332	 * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
  2333	 */
  2334	int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
  2335				struct scatterlist *sg, unsigned int num,
  2336				void *data,
  2337				void *ctx,
  2338				gfp_t gfp)
  2339	{
  2340		return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, false, gfp);
  2341	}
  2342	EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
  2343	
  2344	/**
  2345	 * virtqueue_add_inbuf_premapped - expose input buffers to other end
  2346	 * @vq: the struct virtqueue we're talking about.
  2347	 * @sg: scatterlist (must be well-formed and terminated!)
  2348	 * @num: the number of entries in @sg writable by other side
  2349	 * @data: the token identifying the buffer.
  2350	 * @ctx: extra context for the token
  2351	 * @gfp: how to do memory allocations (if necessary).
  2352	 *
  2353	 * Caller must ensure we don't call this with other virtqueue operations
  2354	 * at the same time (except where noted).
  2355	 *
  2356	 * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
  2357	 */
  2358	int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
  2359					  struct scatterlist *sg, unsigned int num,
  2360					  void *data,
  2361					  void *ctx,
  2362					  bool premapped,
  2363					  gfp_t gfp)
> 2364	{
  2365		return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, premapped, gfp);
  2366	}
  2367	EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
  2368	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

