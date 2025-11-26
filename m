Return-Path: <bpf+bounces-75609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7582FC8BB1E
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 20:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A213A21FC
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED433FE1F;
	Wed, 26 Nov 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqwtSScF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE2229E110;
	Wed, 26 Nov 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186297; cv=none; b=Qp897cdq63ixeizqe1Yto4/w+q6Ja4cu7E44GJEjYv/GN2ShjmHPJwadN55EPAsV7yX5kNSr40dDs3yQl1i4FMK27ZpLwrOGJprcREb6h60rcHfZfi5Yto1q/sHu8TWoI+mtw89Jk8XRxB8BDA4k5m7vRmsqByKqZKAfHvh62tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186297; c=relaxed/simple;
	bh=CAgoLkcKGmrNOaExZbEqf5/GTNcLuZBZHX4JOfOxTaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj4EujSThoyytRFNxq2kv9g3hbRuEaanP0gkQ9u++oAYpc5ClVhAULoOT60rakGMfEohMV0NJLgIaV2gL72gJ0XuY8IK13nCtEj0QSGRaU+gURPjN2zMMhM+m8ENHglAZsP8dnKunei1/JWS/FafS7pAM3tRonSmn4PZVvRiUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqwtSScF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764186296; x=1795722296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CAgoLkcKGmrNOaExZbEqf5/GTNcLuZBZHX4JOfOxTaI=;
  b=AqwtSScFc/yLFWWOm1O5HmstAdVKLX7B7Mhl9lqQKJp9Xkw+AKxDpHPv
   r83GQgdLHl4KXRhuQF2umg8v9n3xZopEC9GsiV7zadvREZbiSbE0T6AO+
   y4yzoVu8eERm4jwTUGEf7mbwYAU8XVjsUVsLDl6yEKyp2zXuVjR/zVqZS
   aFqumaSGGVGJXKPPR74HOAiCUsOOSDsdniy+/eqzEZ3DFyeCnr6qhbLfy
   74Bx6mxY3T+yQOU92hpCZYN8jcHTvB/RHGjiZAwcYQALTA+1PxAOVGErY
   qYaZJ2xLhu35ORxKH/eK/y19mSvm/3s84+mUKkNHSTzJtgq8p8Z/WXByg
   Q==;
X-CSE-ConnectionGUID: Dq3G1t1qQ9qDQAg7/XD6bg==
X-CSE-MsgGUID: 1LY1p81UTrWlc+N7yc1Rng==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66194208"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="66194208"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 11:44:55 -0800
X-CSE-ConnectionGUID: AWoYAO75SFGhOfLf8MVRmw==
X-CSE-MsgGUID: Kw0A2qbPR1S27QQJKt5ntw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="192285019"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 11:44:51 -0800
Date: Wed, 26 Nov 2025 21:44:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, ast@kernel.org, casey@schaufler-ca.com,
	andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net,
	renauld@google.com, revest@chromium.org, song@kernel.org,
	linux@roeck-us.net, Kui-Feng Lee <sinquersw@gmail.com>,
	John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH v15 3/4] lsm: count the LSMs enabled at compile time
Message-ID: <aSdYsPvRhVwvLoHU@smile.fi.intel.com>
References: <20240816154307.3031838-1-kpsingh@kernel.org>
 <20240816154307.3031838-4-kpsingh@kernel.org>
 <aSc1aAdOeSuuoKTH@black.igk.intel.com>
 <19ac18b9e00.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ac18b9e00.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 02:02:24PM -0500, Paul Moore wrote:
> On November 26, 2025 12:14:21 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Fri, Aug 16, 2024 at 05:43:06PM +0200, KP Singh wrote:

...

> > > -/* This counts to 12. Any more, it will return 13th argument. */
> > > -#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10,
> > > _11, _12, _n, X...) _n
> > > -#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7,
> > > 6, 5, 4, 3, 2, 1, 0)
> > > +/* This counts to 15. Any more, it will return 16th argument. */
> > > +#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10,
> > > _11, _12, _13, _14, _15, _n, X...) _n
> > > +#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 15, 14, 13, 12, 11,
> > > 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> > 
> > You forgot to update _12 in the upper comment.
> 
> Do you plan to send a patch to fix this?

Not really. Too lazy to write a commit message for it.
Appreciate if you or the initial author or somebody else
can do that.

-- 
With Best Regards,
Andy Shevchenko



