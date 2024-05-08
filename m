Return-Path: <bpf+bounces-29115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E298C044F
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 20:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40BE1F24587
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 18:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08BF12D1FE;
	Wed,  8 May 2024 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4dHBcmI"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3EA12BE9E;
	Wed,  8 May 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715192865; cv=none; b=MYznzFf4V90bq2xauUrWjYuaZ/pG8IJBSnTrztzFbAN1XAdgCmUOrluzmCkJr4dXdDrBokmBM9gBoH3xJi5rLD6XCCQlXduXKEmvcSgRuPkdsJMTgtNlXFBmJU3rpCYIGWBQIgORefo4B9DzSuLKmvwSrloZ8kD6LrczonUVmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715192865; c=relaxed/simple;
	bh=TQyn2lCiksoMNY+L3Cmit5xvgMlOchLg/3HXre8evts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edsEDS3j0RPY+BwoUi8S8U7Fr9lsZ7L32QqNlYUlzOXfyI2d8VwO9e55GZBMaCUZRFXEEF4dQ+O5bEAzJuwsZzvemqb2c6voH++gKGVDAatp7rWfRwMbf/BhHH6F4e+wBjjHtwD6dXQBC07/IbyjGh6UYYRnDUg1KHGtRe+sBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4dHBcmI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715192864; x=1746728864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TQyn2lCiksoMNY+L3Cmit5xvgMlOchLg/3HXre8evts=;
  b=H4dHBcmI0CQIMpvcgBLfLZ0c69k+BzZv6LIpTb17DmNnAyJYtRhO6xR5
   wLr/C0n8GZTKdQNAd36muZiLm4SNdlhE+SG+ZIvy/QGGY0jqzH/HuXLwL
   RYfpGh0a9IABSSlmo9VSUX5wQ3nW9r7RD0r+OT1FiaGF9dw2aibjDz9sD
   lNmcKFnGRDPx0AK+UvxNUidISEwCav2L/PfSZ2eyqLN1Fvs0BgSiTw0dj
   gQXsjoum2MW9Y4WpZvtp6+9zJtXdKUI2qdPzRRbU28+6dET6V7Dq4/IwZ
   VhJNiuhhAWFvEipK8lAzmZkUcv388wVbkexZUXnaOWy9ewUNaqDOpawgd
   Q==;
X-CSE-ConnectionGUID: HHU7tMSuRsmdxVylYmK5TQ==
X-CSE-MsgGUID: UrZviiP8Qdi+uEx9eP8HZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21746829"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="21746829"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:27:43 -0700
X-CSE-ConnectionGUID: pPHW8MKiSkaurGKf+8RAmQ==
X-CSE-MsgGUID: 6/g+hsMwS+mdRwVMUlc4Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33526172"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:27:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s4m0t-00000005XUW-2oGJ;
	Wed, 08 May 2024 21:27:35 +0300
Date: Wed, 8 May 2024 21:27:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 1/1] net: intel: Use *-y instead of *-objs in
 Makefile
Message-ID: <ZjvEF7haIsMcMh08@smile.fi.intel.com>
References: <20240508180057.1947637-1-andriy.shevchenko@linux.intel.com>
 <1f2eb3d5-649d-4723-af89-ca625070877d@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f2eb3d5-649d-4723-af89-ca625070877d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 08, 2024 at 11:23:39AM -0700, Jacob Keller wrote:
> On 5/8/2024 11:00 AM, Andy Shevchenko wrote:

...

> FWIW I applied v1 and v2, and got only the following range-diff:

> This matches the changes described w.r.t ordering, and everything built
> properly when I tested it on my test kernel tree.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



