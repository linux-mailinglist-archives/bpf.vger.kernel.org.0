Return-Path: <bpf+bounces-35682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4109C93CAF1
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 00:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7329E1C2150F
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9E143894;
	Thu, 25 Jul 2024 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cciLxjQF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F6117E9
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721947395; cv=none; b=mz4Ot7RN9QYIltgCU5tk6h3dcNLCcl1rKakgkoQVuKYhNLM4iIhJqzIZPAS8tFvsecr/UMLvApW6/5YfBN8zwdobRElcfztMxIi9EjSHOjFqZNVIWj47zd31Rll2i0GCLa5buFW7oe0sBIHdHbqefBKbNrDK5FxaB5XgyjKvPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721947395; c=relaxed/simple;
	bh=fxEmtupN73ljK7NbDXEwECcOcGADObTT4VYyBy+VBeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/FIObNwIJfOaudAWUL6bjoPGfsfEhIhWRMuhaS1ecOO0aVyzW3od8vWM9qrskZqUm+R41UblhRkQReFoCLzXQxo4tajaKqHBh+5bc/+r42k9/BHUwe2OBal87xZ3FO3C4b16QarEzoR0q5li3PxQwQXA742Fob5kL2rA04cf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cciLxjQF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721947394; x=1753483394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fxEmtupN73ljK7NbDXEwECcOcGADObTT4VYyBy+VBeo=;
  b=cciLxjQFk8chJz4IwL9vq+VqhiRH1xhmXHskzqcwi8YUh5S5yiaUzlEY
   QeVRDrUhLqMfEHy3zpXIFg3N10Ps5Xm7WXlZ5KVKSJ8eIgs85KnRMgnre
   E+Eg9GRYj+4XtW26nxIvNEq4j30mVF1SEesLUmlEWRs903/gRUZ0f4xqe
   Hvs7UeSkqXhpj1stcE8tyR6SfepbPnO/cVohsx/C/Edv+rVNKzgKuv+6S
   phJAU6e0jd+dCLW/wA4eGKIS1fiUM5lf2MCMWf0TH8l/9sSHE06aMmEE1
   /jg28hvmC4yWeOlSU8+rU4Hx5oDpEI/OLVi7knQLga+QmLxFnryMx/9ZQ
   g==;
X-CSE-ConnectionGUID: TDisLA+aTL6k1Q0AwqGh1A==
X-CSE-MsgGUID: rJ8SjhqVRc6oVYvL8PHz9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="31134184"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="31134184"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:43:13 -0700
X-CSE-ConnectionGUID: 4KIUQDxySj+v2EgM4YxDSw==
X-CSE-MsgGUID: PdPwTGDQRQ+qgy4vNQQsXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="53145866"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:43:13 -0700
Date: Thu, 25 Jul 2024 15:43:11 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	osandov@osandov.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next 01/10] lib/buildid: add single page-based
 file reader abstraction
Message-ID: <ZqLU_wQ41RI5syVY@tassilo>
References: <20240724225210.545423-1-andrii@kernel.org>
 <20240724225210.545423-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724225210.545423-2-andrii@kernel.org>

> +static int freader_get_page(struct freader *r, u64 file_off)
> +{
> +	pgoff_t pg_off = file_off >> PAGE_SHIFT;
> +
> +	freader_put_page(r);
> +
> +	r->page = find_get_page(r->mapping, pg_off);
> +	if (!r->page)
> +		return -EFAULT;	/* page not mapped */
> +
> +	r->page_addr = kmap_local_page(r->page);

kmaps are a limited resource on true highmem systems
(something like 16-32)
Can you guarantee that you don't overrun them?

Some of the callers below seem to be in a loop.

You probably won't see any failures unless you test with real highmem.
Given it's a obscure configuration these days, but with some of the
attempts to unmap the page cache by default it might be back in
mainstream.

Also true highmem disables preemption, I assume you took that
into account. If the worst case run time is long enough would
need preemption points.

-Andi

