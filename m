Return-Path: <bpf+bounces-29112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC488C0405
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 20:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2708328ABA6
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 18:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E2112BF28;
	Wed,  8 May 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nByua/OS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF434128383;
	Wed,  8 May 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191341; cv=none; b=MYP4W9yiCygVkUbHMIpRP5+rIy4zHPSV7VRusg8k2UupAdxG1RSjivExYaQAPuxJ85YxiEsy0gOYfpD80VEdH6pl9yVoDsHaOEx6xw6XOccZ+SBeNq3B6P6mDaiFmX/0XGnhNv2mtLMTW73Icb4LnqlmMHMJ8gG+cIaDgqvJU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191341; c=relaxed/simple;
	bh=sY9CUVNAfqtE1KTKFXhbixYNH/fSPbF+uxQ9ZNfixXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h32/SwuIIe1utHXnld2V50IZc8aLH5Xwi+9VYPrbOIDwwdVzn14Gp15nVYZxVro5N+DrWVIlLkvPdO2Qiq1NgqArtpo+IVJRjO0vSrbGxXzlfqMLIsuLFiHzuRrRuvlk7YnYCqA4jKyL+QRaZ/Jx77l/3EzeyY4DjlzLl6IPE2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nByua/OS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715191340; x=1746727340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sY9CUVNAfqtE1KTKFXhbixYNH/fSPbF+uxQ9ZNfixXU=;
  b=nByua/OSqFS1XTHfLox3SzmttP7PcTOsPoZFi4aPbu4cqFwwldqv2qFD
   /tce95IRpmkOXvdNuFV1IXNqYHuobmkaINzLWpzAkSF4/Sl7u9nP2eB8T
   vW4hoE+Z7QvTZYaJ3z/coCfZSUqHwiS5286H03OAUpWNVVUMYrKf0fEZC
   PYOqVHdmiS1oKFczSYzzbQ7bps2R/u1qFOZ39X+pS6GPuB9X4vMdg/Gnf
   IP0eysdKWsQPtIjdljx4C16TwGX+3rZQZFc8OlF4+z39welqE4qnmCcI7
   qQFyl2LGGyFmMDknWyDuX8bx6sZoFjTqgqQqXl33048MKhbZvc7e0mrF2
   Q==;
X-CSE-ConnectionGUID: rMde/ajmQOSX86PgS9JgnA==
X-CSE-MsgGUID: YBpmEqxrRtmhRAOqgur+LA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11200205"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11200205"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:02:12 -0700
X-CSE-ConnectionGUID: 5Dud2CDiTOGfUDUU5xzjrw==
X-CSE-MsgGUID: NAOZO05YTjKchJ/XBg4Rsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28944992"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:02:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s4lcD-00000005X4F-1ef0;
	Wed, 08 May 2024 21:02:05 +0300
Date: Wed, 8 May 2024 21:02:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH net-next v1 1/1] net: intel: Use *-y
 instead of *-objs in Makefile
Message-ID: <Zju-HVbo0lMsR6Ee@smile.fi.intel.com>
References: <20240508132315.1121086-1-andriy.shevchenko@linux.intel.com>
 <6ac025de-9264-4510-ba7f-f9a56c564a80@intel.com>
 <ZjuLW8jA3MuT0oih@smile.fi.intel.com>
 <5ab7ae5c-79d2-494e-8986-d18d4a8e74bb@intel.com>
 <4038b9d4-6618-46cc-bed8-a0ccd1c92cd2@intel.com>
 <SJ0PR11MB5866F14FA9B7D02BC97942F5E5E52@SJ0PR11MB5866.namprd11.prod.outlook.com>
 <18a6a31f-bccb-4d96-8503-1d80b5eb32e2@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18a6a31f-bccb-4d96-8503-1d80b5eb32e2@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 08, 2024 at 10:58:37AM -0700, Jacob Keller wrote:
> On 5/8/2024 7:42 AM, Loktionov, Aleksandr wrote:
> >> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> Date: Wed, 8 May 2024 16:39:21 +0200
> >>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>> Date: Wed, 8 May 2024 17:25:31 +0300
> >>>> On Wed, May 08, 2024 at 03:35:26PM +0200, Alexander Lobakin
> >> wrote:
> >>>>>> *-objs suffix is reserved rather for (user-space) host
> >> programs
> >>>>>> while usually *-y suffix is used for kernel drivers (although
> >>>>>> *-objs works for that purpose for now).
> >>>>>>
> >>>>>> Let's correct the old usages of *-objs in Makefiles.
> >>>>>
> >>>>> Wait, I was sure I've seen somewhere that -objs is more new and
> >>>>> preferred over -y.
> >>>>
> >>>> Then you are mistaken.
> >>>>
> >>>>> See recent dimlib comment where Florian changed -y to -objs for
> >>>>> example.
> >>>>
> >>>> So does he :-)
> >>>>
> >>>>> Any documentation reference that -objs is for userspace and we
> >>>>> should clearly use -y?
> >>>>
> >>>> Sure. Luckily it's documented in
> >> Documentation/kbuild/makefiles.rst
> >>>> "Composite Host Programs" (mind the meaning of the word
> >> "host"!).
> >>>
> >>> Oh okay, I see. `-objs` is indeed only mentioned in the host
> >> chapter.
> >>
> >> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>
> >> Thanks,
> >> Olek
> > 
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> Yea, reading the makefiles.rst again, it does seem that -objs only is
> intended for host programs. The fact that it works now is an accident.
> Further use of -y is necessary as we also use module-$(CONFIG_SYMBOL) to
> resolve cases where we only include the files if the configuration is set.
> 
> Makes sense to clean this up.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Oops, just sent a v2 to address LKP findings. Can you look at it instead?

-- 
With Best Regards,
Andy Shevchenko



