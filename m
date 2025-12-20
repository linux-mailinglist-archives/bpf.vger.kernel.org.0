Return-Path: <bpf+bounces-77235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D98EDCD2805
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 06:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9779B301B4BB
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F1E2F290B;
	Sat, 20 Dec 2025 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="edgP2vMF"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15F2EDD63
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766208380; cv=none; b=UWYQUhkcPPaCoJT1L7hZGwfVOzdLqS7L5Hk5hwXO+Y+nboFigodp9fqJ/RYDEpoVxJicXS5/HHTyY+upj5Y5oX9XaT27De2ZJWe9dqjwrcmNtJhKJr3bOTfVop8FxQGBnxai1u685IGHkcTEMtUHruI2103J0orXhFKKHQFHSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766208380; c=relaxed/simple;
	bh=wLss1pwMotFVBfFcg6wQGQsd4/HqBCVIpMsdu5ckb2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODMyxg45Du0n3QgQOG9FzPd72RzrGbeZf5iauHvVmu9YJs5ZsiZXvuu3rK+BtgSAEqVch0bywm81XNR3mTHV1I7gbAA0ypJRX3bhiqz74bMsfb8HuRCt4suvPcCE7XzmWd9viXMaZ9YAU11K4VIH90fXORdhu79pqzQSJ9RFPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=edgP2vMF; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 21:26:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766208375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ikv7T6uUvqOajqS4ukR7vYik/6qml8vwUs1HwhWK7Rw=;
	b=edgP2vMFfvj6dMDrwktqwCDCrHMTBuTN7yxNF0bqlaGM9mvOsbMAOIfByjeRYXZGNFAjsJ
	GKro3G4TvgasBG6wUS+UJJFz2AwgFyY+Iy1mPSo40NFOPiP1KYGF9vJbbJTqhAez9KnWsT
	Xlu4sySSn00g2aM48pC8RTJRcawULaU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v2 7/7] MAINTAINERS: add an entry for MM BPF
 extensions
Message-ID: <e2nhpy4gwzoh6xkc6upew4yehqqonfawl6pfhivdhw3kte4lk5@zdwgi5iciq4v>
References: <20251220041250.372179-1-roman.gushchin@linux.dev>
 <20251220041250.372179-8-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220041250.372179-8-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 19, 2025 at 08:12:50PM -0800, Roman Gushchin wrote:
> Let's create a separate entry for MM BPF extensions: these patches
> often require an attention from both bpf and mm communities.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0030e126fc8..59e3053e1122 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4798,6 +4798,13 @@ L:	bpf@vger.kernel.org
>  S:	Maintained
>  F:	tools/lib/bpf/
>  
> +BPF [MEMORY MANAGEMENT EXTENSIONS]
> +M:	Roman Gushchin <roman.gushchin@linux.dev>

If you don't mind, put JP and I here as well.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


