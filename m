Return-Path: <bpf+bounces-35683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0D493CAF3
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 00:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A5328308E
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0654713B58B;
	Thu, 25 Jul 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwrEXJhN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4013A40F
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721947510; cv=none; b=OffyqUwk0WRFhLC16nl0pHWMqohJ9BdczrSEHLSgKOGWkmo+IM9cOwcvvRLASqwOgE+gRLRSyTFbBkNI2qj+pnO+390NaXD7CMz8OJ8bEgZTe/fx+E1wzdLhjC+VtBiS0CVEXqOiMUILND9fA1AFmMTdCNulisUYTKK8rx6nVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721947510; c=relaxed/simple;
	bh=wa0i97Arv3R7zWU+J9jYul3SRq3C3EZXSTybRawhVpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkazI1uC0nv0P8pg4sE8J4ET67JD9vw0AfGCAeKxoOHFj6w3jpOQIN5yl7dBTao0os2vGGtq4JfSkR+AZNOTu4WXIdMEVY9i26kzY/UmBVn+rDB2ZLD1o626kj3HYgroffvNlfL3U4dbgrMk6RjBi+K8n/4hj6MBE13YMMpS+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwrEXJhN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721947509; x=1753483509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wa0i97Arv3R7zWU+J9jYul3SRq3C3EZXSTybRawhVpI=;
  b=FwrEXJhNaXnrMsVBm6NW6kTQ8BA0sydZBRYge8Vsc2s/9Y0iB2TIBWoE
   D2JIG/5wjQBz+pppKhA1T1SAnp81LpB9VmLMsmCFTctOVZfRsuWqKzszo
   SZP906izdDR3EbsOtWxoIIXuxPyT2HcvoEI8VFpifGDG+hGA95gLHtei9
   w9uwq3vEr2/9Wbpik3SVwzoO/Dly241gDBNHV0Bw9JO+92i0HhLgwtr40
   IrNXR5toAIm08IAiva1IbJDs0vwqVpJCWnwU6kDQpRrVbS5cfHBmrQwUH
   7JWu8atRyI8AYFPFMprt8hRFtzJ+LVaz00Q29UsUuTXIj7DiYsNuR+1AV
   g==;
X-CSE-ConnectionGUID: fH5ILxOiQFusg0rgyP27ug==
X-CSE-MsgGUID: pmwfjEAGRwW7Zjv6r2eZJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19907607"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="19907607"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:45:09 -0700
X-CSE-ConnectionGUID: /CAkRQ9oQjibyGexYuPX7Q==
X-CSE-MsgGUID: 5RTO3smYTQeU6TB6wuGjHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="52970373"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:45:08 -0700
Date: Thu, 25 Jul 2024 15:45:07 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	osandov@osandov.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next 02/10] lib/buildid: take into account e_phoff
 when fetching program headers
Message-ID: <ZqLVc7gqQQ9PMIbD@tassilo>
References: <20240724225210.545423-1-andrii@kernel.org>
 <20240724225210.545423-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724225210.545423-3-andrii@kernel.org>

> @@ -214,13 +214,14 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
>  
>  	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
>  	phnum = ehdr->e_phnum;
> +	phoff = READ_ONCE(ehdr->e_phoff);
>  
>  	/* only supports phdr that fits in one page */
>  	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
>  		return -EINVAL;
>  
>  	for (i = 0; i < phnum; ++i) {
> -		phdr = freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
> +		phdr = freader_fetch(r, phoff + i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));

What happens if phoff is big enough that this computation wraps?


