Return-Path: <bpf+bounces-36627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC16394B372
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 01:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2AB6B223E5
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 23:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA101553B7;
	Wed,  7 Aug 2024 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIB4dZ9+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8631E13C8EA
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072446; cv=none; b=ffNkoOEBNCGMBB5T9p7AQsiq+5luktxQbH7mDIC1Y9x5dLP47MbEkfmwgQ33iqPt9ro5aNt0vUHEThjHxVK7QGZ9UyzEgQGHUF5r+e1jOguNbj/2pF4/zDY+MOndn8HnxJ6kmOkVpfdxfwS0I0FxrHLBERF5LzLplAs515ymJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072446; c=relaxed/simple;
	bh=bN/Rybd5MOzLObmdOXMm7M2MQ9RYUwCDFjZRy6IRJpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFN0JqCK8fqI1eH9WqtwRkpefb8rWvA8qo2KF3BgIqLos2ybvsvNTUwZobSV/rqZwvvqeqzNkExm1uHzT459UE2yC+ALVHid4cpVaS8oK+IFjKNWnw76cg44YD512f6NBFscFH/7K6ASFjwVotcg6mXDR6V8Ex3c53qV4b3XJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIB4dZ9+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723072445; x=1754608445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bN/Rybd5MOzLObmdOXMm7M2MQ9RYUwCDFjZRy6IRJpg=;
  b=oIB4dZ9+VZPDaTNJ3wuC3DYtnZz0JAlYH89JqA7mXgB61ESR9SodKHeL
   4FLiWfo0saMGXKH+IlnjJQdIjm4G5NUOn0pm7N+0zLxx4deLfeYUVhMAT
   fergP7jDrpPlmwjZseYjBf1NItSQh/lagIE2pqUaetBlcEq3CcKFwiRM3
   TIlu8J3lLzoZCWXTEtyrkzxEtPzgtAPkajiUDcmoQ8MvA9V+5DzaxXItj
   0XFtnchfNpvbcVcmjiquL8iEaAcEmGW8Iq+a6dGzgaqEl3xxj+IubZAz3
   TfjsI+tXAqiQzRALSJyvmxL8d5Rq25L33fT1QKnD4yRdvXkirQLtFQpxD
   A==;
X-CSE-ConnectionGUID: rtVUuWJhSruX8wz1QwLBiQ==
X-CSE-MsgGUID: pnzSnrwSSoawQ2wXDlJRfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="31844517"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="31844517"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:14:05 -0700
X-CSE-ConnectionGUID: w/bX9Ww1QXKGACyukYKzag==
X-CSE-MsgGUID: 7hDCLiUlQpGrMf3bzthS7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="61889803"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:14:04 -0700
Date: Wed, 7 Aug 2024 16:14:03 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com,
	hannes@cmpxchg.org, osandov@osandov.com, song@kernel.org,
	jannh@google.com
Subject: Re: [PATCH v3 bpf-next 02/10] lib/buildid: add single page-based
 file reader abstraction
Message-ID: <ZrP_u7V-o5VeOCBs@tassilo>
References: <20240730203914.1182569-1-andrii@kernel.org>
 <20240730203914.1182569-3-andrii@kernel.org>
 <ZrOStYOrlFr21jRc@casper.infradead.org>
 <whbw2skd4lrkgqi5e6q6ha54f5vurhw3yiggdndu2xhxlqegtt@fjskvq4hsgfj>
 <ZrOy2GFv5KDmFlZt@casper.infradead.org>
 <n2y5rk74ynongpvbpbsnjzghskmw337bexf2ftcf2fnrgk3knn@3u322cnvwpcm>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2y5rk74ynongpvbpbsnjzghskmw337bexf2ftcf2fnrgk3knn@3u322cnvwpcm>

> Failure is fine if there is no folio or the folio is not uptodate. I
> assume we can do:
> 
> 	folio = __filemap_get_folio(r->mapping, pg_off, 0, 0);
> 	if (!folio || !folio_test_uptodate(folio))
> 		return -EFAULT;
> 
> Is this appropriate here?

Yes EFAULTing is fine for this usage.

-Andi


