Return-Path: <bpf+bounces-75601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A01BC8B272
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 18:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFCC3A5A44
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28533EB0B;
	Wed, 26 Nov 2025 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPA3AV+A"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66733A008;
	Wed, 26 Nov 2025 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177263; cv=none; b=uYKCJ1fhNZvAdulvx7XoCiStDxNcdWcyLoC9L3pwMFfAzfWkuj+BnKpNZCSjHrIiCB5vPdayGqLYVZKMZy+wcaByHYAUNuAZ1+rCG6Wq/7pVBnaD18+3iN+pjmff001w883Mc50MswCYNTllZHKfhYJuhiEzCiWdjo6LxSHGhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177263; c=relaxed/simple;
	bh=+GFsOaKbBnJD6LH6GD2KtqnN1pVQGiQU0ZkcYuK3pDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwpoYFke7GPdNQq1Nsq66bJNPNSZp/3BHvdUGenuXw9FA+QEOWzNQh/kVpO8+pTzXssoM8U9qKDplqSHMjAtxT47pgferLcVvjG58ulj5fxmA4/xnzfQ2WSjyzv+FYFo4Jw2+xmeIglID4tSdwLb1srFvrRyaN0YaOYSdEklLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPA3AV+A; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764177261; x=1795713261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+GFsOaKbBnJD6LH6GD2KtqnN1pVQGiQU0ZkcYuK3pDs=;
  b=CPA3AV+AeffXSJVIu5WkSmeCcxspnRtIDEIeVpbLKIQsWgb0nmrP+4Nw
   3LKc/aXUaDtx1bPvncwSx6ndtaqBnBHFvDWaQ21J3ZjskSacKobomHhOP
   xlEO0sNn87TnlReGD8gUt1Hy4JxO/JcZaiUdKlGj0LcaH/JVnSDUkWgim
   XannMNn83NWQP6oqN53zTsSES7iSUjPLvCi6vPe0rlyBleeM9+OURH/Hk
   MXC6/V3kAoalVVqWrsDuuKTS3JdrYvolTrXjZn4lTKuecYBa4DMFe8hZY
   c7gla9ZpsI0qCZMCIK90+PNR7EutgQQSmL2S0AyZelpEQUAn6bw4AtdlD
   Q==;
X-CSE-ConnectionGUID: S5ZS0Iv5QXiWulVoit+mhg==
X-CSE-MsgGUID: UFVpAV0rRw+bR/pTldAp+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="65408981"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="65408981"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 09:14:20 -0800
X-CSE-ConnectionGUID: sFgbCYpAT0KNK4WS8uC2ag==
X-CSE-MsgGUID: zU1DriBfQcy6mno888NnDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192628515"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 26 Nov 2025 09:14:18 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8FCA6A0; Wed, 26 Nov 2025 18:14:16 +0100 (CET)
Date: Wed, 26 Nov 2025 18:14:16 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	ast@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
	andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net,
	renauld@google.com, revest@chromium.org, song@kernel.org,
	linux@roeck-us.net, Kui-Feng Lee <sinquersw@gmail.com>,
	John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH v15 3/4] lsm: count the LSMs enabled at compile time
Message-ID: <aSc1aAdOeSuuoKTH@black.igk.intel.com>
References: <20240816154307.3031838-1-kpsingh@kernel.org>
 <20240816154307.3031838-4-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816154307.3031838-4-kpsingh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 16, 2024 at 05:43:06PM +0200, KP Singh wrote:
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
> 
> Without this one would need to generate static calls for the total
> number of LSMs in the kernel (even if they are not compiled) times the
> number of LSM hooks which ends up being quite wasteful.

...

> -/* This counts to 12. Any more, it will return 13th argument. */
> -#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
> -#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> +/* This counts to 15. Any more, it will return 16th argument. */
> +#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _n, X...) _n
> +#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)

You forgot to update _12 in the upper comment.

-- 
With Best Regards,
Andy Shevchenko



