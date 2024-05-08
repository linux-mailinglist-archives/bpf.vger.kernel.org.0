Return-Path: <bpf+bounces-29082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448568BFFEE
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 16:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D171F22769
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE81586151;
	Wed,  8 May 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIwywg5r"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923828562E;
	Wed,  8 May 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178341; cv=none; b=OL3L6/xvesPSqLlLgWQpb4TPsSqKPxgBDl+aQGQNPUSjMO9aqf2/tknGFDIkiBEz7DbJJxxASqJBxA2WnZPFYDxDb8BxN3L0u1zOD3dmtQL7LKIULdpyNMxQma4teGyS7YnkpnfpZyy01MRFX1BkBfawgr+9H7U+1NI7FATpFos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178341; c=relaxed/simple;
	bh=GJmvi/Sx1Tmjcq6Bnii+IMV6C5ZymcNZfpdtfXPoNkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMMQGFGxNh5Qo3KnnWqbpXmydNnHsgmSTuiHaP8N4lg22BdyVLlGrTKRrFnP10GRhu3raaVOzqGts9bLRrxib6ShnpS98Lyc4ryVJiVFzI4KlIvp1TzJHxvHS/Cog/SHgj0rSbvdJeD6dAOzjM2XTr35zm5JDeM4ZCqZZ2IVpes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIwywg5r; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715178340; x=1746714340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GJmvi/Sx1Tmjcq6Bnii+IMV6C5ZymcNZfpdtfXPoNkk=;
  b=KIwywg5rsNOAf3x0WRDbE7scJCaGAFVtqQUocQwvgNJ47/MvMWvmg3pi
   GBiucELq/C/kbe18sK6MNPy1OhvIP3ladVP1tsTuW1cv6iz4kFaCeM3ZZ
   yi11NqyZHyexqQf1s2zFZ3mwFemzczva4KuBmjAUsjseoeOjC1YJnoJwt
   d40hBUMmJnY3iS0umgcg8wYsJAGweRigbYJT3RT7+ay5U1WX0jHz1SPo+
   R14VNbXOf4yjs4vFXLzudfbqU3t45q0XF4td9QGVZRx57U84jXkEVDx0T
   +mDzlFlV+0SaWYUq3Zgl9wQBEoxidgYsd5CapbwnzNKtccke01qoGSNBu
   g==;
X-CSE-ConnectionGUID: Xs8RSaYPQJ6KfLl/ItCm7A==
X-CSE-MsgGUID: xCZeykM7TUqsPmpaEWEeQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14836225"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14836225"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:25:39 -0700
X-CSE-ConnectionGUID: CYCHGa+5QuOPLZYR89aEqg==
X-CSE-MsgGUID: /qEKDGxwR6iaVVUBhdkp7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33703450"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:25:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s4iEd-00000005T34-3Cbf;
	Wed, 08 May 2024 17:25:31 +0300
Date: Wed, 8 May 2024 17:25:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v1 1/1] net: intel: Use *-y instead of *-objs in
 Makefile
Message-ID: <ZjuLW8jA3MuT0oih@smile.fi.intel.com>
References: <20240508132315.1121086-1-andriy.shevchenko@linux.intel.com>
 <6ac025de-9264-4510-ba7f-f9a56c564a80@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac025de-9264-4510-ba7f-f9a56c564a80@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 08, 2024 at 03:35:26PM +0200, Alexander Lobakin wrote:
> > *-objs suffix is reserved rather for (user-space) host programs while
> > usually *-y suffix is used for kernel drivers (although *-objs works
> > for that purpose for now).
> > 
> > Let's correct the old usages of *-objs in Makefiles.
> 
> Wait, I was sure I've seen somewhere that -objs is more new and
> preferred over -y. 

Then you are mistaken.

> See recent dimlib comment where Florian changed -y to
> -objs for example.

So does he :-)

> Any documentation reference that -objs is for userspace and we should
> clearly use -y?

Sure. Luckily it's documented in Documentation/kbuild/makefiles.rst
"Composite Host Programs" (mind the meaning of the word "host"!).

-- 
With Best Regards,
Andy Shevchenko



