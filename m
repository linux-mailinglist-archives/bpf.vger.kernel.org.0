Return-Path: <bpf+bounces-34464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A978292DA5B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 22:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5443D1F2424D
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0578EDF71;
	Wed, 10 Jul 2024 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aj1D19/a"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5683CC7
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644307; cv=none; b=khPjKnMCNLgSSsN2szIW3af3rp7l+TKvinBjK5resy86gyJyJmzFPlI7TsP1ej75wlzUxdITJ7fPmnLx3hNR79/w3ZFi3C4i3e2TDdvxglqaU4JVPwoydf9iovXTs0ZqGNUgQ4JAStboD5C0zjgYc21SnX/19rYu3xyYim3WMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644307; c=relaxed/simple;
	bh=vSvqtdK6n6V1yNOytpD4tCWtA293L2IoxKj1bm+MFw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzoWrHNZsTK5OHiv7cOFrAz9UeaLOgbwKWzLl4wByZ/bTN+u8T0XOsTrmu+ghXd7jNos07u6T6U1eSFspza52dYA29pOIvRCRZoJtB97mXofuRQ9LJaGyOA9fAR7UZS0oxsqwBDvXC+8WqjgWLnAZJM4KMhndWKo/NLPKXw2xRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aj1D19/a; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720644306; x=1752180306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vSvqtdK6n6V1yNOytpD4tCWtA293L2IoxKj1bm+MFw0=;
  b=aj1D19/aCRWq++W5BpKG9QKNyRE0xg1HvpY688KL/Se09wtf4gIXBxAK
   DZamzszTcl5uwP5AODPHGXHnp+VArIN/N9fHlcrD75M/pMKiXImIBjmNl
   X/kMWTQAAasCiFQ0SPbulfhpG7w+YBEVQ/3z/Mq/7D8knYEn1crAXjk3I
   a4+Ajk7Di5p4NmZhanfimfMtt0tSIAF/zFKjsx17Fge7Q84GJO2lFs9PN
   j5MtEP8QeMJn6hfna+osHcUIAv3nvTVLwuJpimg3DRSsUuS/TLLcU2R70
   VaF6HjckcOVZ38c8RZFTUamLIqbVh1YN1prQRfXTyM2BEBMVki7Qdxdlg
   w==;
X-CSE-ConnectionGUID: LeYiVlukS4Oll/FpRUZygw==
X-CSE-MsgGUID: nKPGvAzPROeyZ9qbPY3mww==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17834604"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="17834604"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:45:05 -0700
X-CSE-ConnectionGUID: SzGh56rcQ+mNZ1tq8snT7Q==
X-CSE-MsgGUID: xTFXgzvcQMi6tSIpOrkQAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48996086"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:45:05 -0700
Date: Wed, 10 Jul 2024 13:45:04 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	osandov@osandov.com
Subject: Re: [PATCH bpf-next 07/10] lib/buildid: harden build ID parsing
 logic some more
Message-ID: <Zo7y0O8wm0_xZ0li@tassilo>
References: <20240709204245.3847811-1-andrii@kernel.org>
 <20240709204245.3847811-8-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709204245.3847811-8-andrii@kernel.org>

On Tue, Jul 09, 2024 at 01:42:42PM -0700, Andrii Nakryiko wrote:
> Harden build ID parsing logic some more, adding explicit READ_ONCE()
> when fetching values that we then use to check correctness and various
> note iteration invariants.

Just sprinkling READ_ONCE all over doesn't necessarily fix the code.
It is only needed for values that affect a loop or reference.

You have to fix stuff like this 

static inline int parse_build_id(const void *page_addr,
                                 unsigned char *build_id,
                                 __u32 *size,
                                 const void *note_start,
                                 Elf32_Word note_size)
{
        /* check for overflow */
        if (note_start < page_addr || note_start + note_size < note_start)
            ^^^^^^^^^^^^^^^^^^^^^^
                return -EINVAL;


which is C undefined (at least without -fwrapv-pointer) and can easily
be miscompiled if it isn't already.

I suspect the code will need more work, especially since you're
unwilling to consider any defense in depth measures.

-Andi


