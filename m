Return-Path: <bpf+bounces-75224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADCBC77B2B
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 08:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0707334BB5C
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA93375DF;
	Fri, 21 Nov 2025 07:29:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC533555F;
	Fri, 21 Nov 2025 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710192; cv=none; b=r55yIuJeoo7hlM3uPRLVfID2CghGDIhY/QeYYZgMCO6ei94f1ZC36MJVQ+gj2sF89g5yKTt81Kg6x20nZcCvkKp1anriWqlzeV+dGaY5jkehIdRMEmL2zfxc14WugNKbHeCVKUWVe4zeox0TmFKrNMYxq9RPAORbBtWWcWHYMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710192; c=relaxed/simple;
	bh=jDKfdKpI9O3qO0P6eKaq325979TViIXpxU2jkBoWVRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJXIUrpnuxiRxrfoJLqBiy5ebmwIQARpLakFRWyw4G++d6ck2jrX+xB7IF4NL3fqOg3u12MpLIhjCUvYY0pT9wP99yPqjT3BsFvbo49yia8uDz4XrmZHZn/PBR6w+VbhECLEXCOL3mbLWBSdW05qC07n1+FL3Q0AcRSfDpqiywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F189F67373; Fri, 21 Nov 2025 08:29:45 +0100 (CET)
Date: Fri, 21 Nov 2025 08:29:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
	linux-xfs@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [PATCH v3 0/4] make vmalloc gfp flags usage more apparent
Message-ID: <20251121072945.GA30438@lst.de>
References: <TY3PR01MB11346E8536B69E11A9A9DAB0886D6A@TY3PR01MB11346.jpnprd01.prod.outlook.com> <aRyn7Ibaqa5rlHHx@fedora> <aRzPqYfXc6mtR1U9@casper.infradead.org> <aR4SmclGax8584IJ@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR4SmclGax8584IJ@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 10:55:21AM -0800, Vishal Moola (Oracle) wrote:
> > Unexpected gfp: 0x1000000 (__GFP_NOLOCKDEP). Fixing up to gfp: 0x2dc0 (GFP_KERNEL|__GFP_ZERO|__GFP_NOWARN). Fix your code!
> > 
> > I suspect __GFP_NOLOCKDEP should also be permitted by vmalloc.
> 
> As far as I can tell, theres only 1 caller of this.
> Christoph started using vmalloc for this xfs call in commit
> e2874632a621 ("xfs: use vmalloc instead of vm_map_area for buffer backing memory").
> 
> Looks like xfs uses the flag to prevent false positives. Do
> we want to continue this? If so, I'll send a patch adding the flag to
> the whitelist.

I'm not a fan of __GFP_NOLOCKDEP, but it is a valid hint for the
allocator, so it should be supported.

