Return-Path: <bpf+bounces-36114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 386D7942537
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 06:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88661F240BF
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 04:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F412F18C08;
	Wed, 31 Jul 2024 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzX1IEjK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A817BB6;
	Wed, 31 Jul 2024 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722398702; cv=none; b=KI6CvtXbgnLF0ijTctKZMloIPVEosr//gjtkN0W7pegLiCx/Y24KlfaQQ9ouOeNKo4WfJ5wxIIweS64t0G/MqdOyEmwY6gULrJh1obbnga/rUNDc6vLr+tRD3JE7eCrnaPqDO+doAaumdT4JT/7MGVxifan0WY//HD4L0Tjicu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722398702; c=relaxed/simple;
	bh=d6algDVYoftIHDHhjf16Zeq4a+y/Awxuwre1H3Pn0+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrq+IXIoX9wwC9Nrdnq+vjCJeRFpHooQq92McRmsQDhS3YjirF71uU8d8mZbO+aci1NPq8hs1Cym52UAfIQBbYydBnaqApo1Z6uAzl7ah++2RDdIQVN22ID1lKqFKJkVZfpLyy5Hxn+YW3ltjmFBajX9/aMFvYVCCf0XX59JtBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzX1IEjK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722398701; x=1753934701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d6algDVYoftIHDHhjf16Zeq4a+y/Awxuwre1H3Pn0+8=;
  b=NzX1IEjKtzcjjJtirzB79sXeM4Z95TN+Ef4C1UnCSe2mQkjIwo8CEQ4P
   gjexdgRYt3aqFbOCViaQFyfsOxIy0+QPTfhk1WIDTD3rkRJGt9BcDRSWx
   SjYlfhOBJUDaIwJ0pJq/6GKvtTZ8VaWYtCzkZezTv+i1834e6m+uKlCCe
   lUMVjWmi70auNO3c6jzajSVcHe+qD/EjjbyTC73Hm0tA1nZChqrGq61FA
   hD2IeInq9+QcRpVa8dbbS7RPxtwKSMHZET69K5IGxDTnd+aLMD9SZiKU6
   Fcs4+vfF52/J+E23m67OOdJ2V9xN/vtQ9E01EG4OwAuf/4FyPQ2zOUl36
   g==;
X-CSE-ConnectionGUID: OKfpQ7IKT8mknwrKu1im6Q==
X-CSE-MsgGUID: 5TiVbyXORLuS0k4O7HYPCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="24016064"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="24016064"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 21:05:00 -0700
X-CSE-ConnectionGUID: muf4eRAQRxS5oGwELv4tqg==
X-CSE-MsgGUID: CN/5l5RDTxm25BbJwSepfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="59183050"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 21:04:59 -0700
Date: Tue, 30 Jul 2024 21:04:58 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	osandov@osandov.com, song@kernel.org, jannh@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 01/10] lib/buildid: harden build ID parsing
 logic
Message-ID: <Zqm36i0Afe48193Z@tassilo>
References: <20240730203914.1182569-1-andrii@kernel.org>
 <20240730203914.1182569-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730203914.1182569-2-andrii@kernel.org>

>  	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
>  		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
>  
> +		name_sz = READ_ONCE(nhdr->n_namesz);
> +		desc_sz = READ_ONCE(nhdr->n_descsz);
>  		if (nhdr->n_type == BUILD_ID &&
> -		    nhdr->n_namesz == sizeof("GNU") &&
> -		    !strcmp((char *)(nhdr + 1), "GNU") &&
> -		    nhdr->n_descsz > 0 &&
> -		    nhdr->n_descsz <= BUILD_ID_SIZE_MAX) {
> -			memcpy(build_id,
> -			       note_start + note_offs +
> -			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
> -			       nhdr->n_descsz);
> -			memset(build_id + nhdr->n_descsz, 0,
> -			       BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> +		    name_sz == note_name_sz &&
> +		    strcmp((char *)(nhdr + 1), note_name) == 0 &&

Doesn't the strcmp need a boundary check to be inside note_size too?

Other it may read into the next page, which could be unmapped, causing a fault.
Given it's unlikely that this happen, and the end has guard pages,
but there are some users of set_memory_np.

You could just move the later checks earlier.

The rest looks good to me.

-Andi


