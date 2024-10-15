Return-Path: <bpf+bounces-41893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E199DA6F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807131F23028
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9630B1D9A46;
	Tue, 15 Oct 2024 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TslArgC7"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D455154BFF
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950417; cv=none; b=hPfeYWsVf8XRLebnVS3EluEIpTQfd0/oEUppzY1LtragSyvFLLP3V9/u/r2VNVUZudzxck26fJSYsUKReCtml3ikvKLSyfX0XtSSb5YsWCNKO1NPPtpR2pkO2ObRudigWl31p+vF6SVDFXwG6K1xFXnrIPHwtZk60uUQQ6ZFMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950417; c=relaxed/simple;
	bh=9edudUAko8TPwOAXX9QK2AF9uqRWayR2WNyxyfSgzFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=honrkJAu0JZi4oUD+gPlrVo02K1/vTSzDkSofcqTdKFyFHj/2jTjfkJQVEWnsm0JQwxK6MFj+iPSwvOFrKO5aAe/QK7nGgQF9em/v89V7VEWHmnBqHcsuJLZAEP4Ufv2oyT1aFqTKgXwlcKxTyTwal1oregwB7T9VhrXBIJL5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TslArgC7; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Oct 2024 17:00:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728950412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vh3jiunjWIwsOuFiNu4hKpvARjvNFqPFZ+Dwxoe0LFg=;
	b=TslArgC7lZohDr+TNPyhLdypH0ePq5iw1b4E7wfSig4Vl37bf5nG7rABIy9+6srd8pj65f
	0kklSPI/wFWx+MRVNVlcqBnajG57g0ninSKqeUSb6OXpZtoqdCDaIQ2bVwOXO6MHKXNJpo
	fp9u3PUw4JZMTMGJOOFEb0nfNnk6JME=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
Message-ID: <tvugxgpjgxlospwa2evdsvyjr6k4dkijffrmtgw7rc2gbwrvjz@2nkwwnsmlaum>
References: <20241014235631.1229438-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014235631.1229438-1-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 04:56:31PM GMT, Andrii Nakryiko wrote:
> From memfd_secret(2) manpage:
> 
>   The memory areas backing the file created with memfd_secret(2) are
>   visible only to the processes that have access to the file descriptor.
>   The memory region is removed from the kernel page tables and only the
>   page tables of the processes holding the file descriptor map the
>   corresponding physical memory. (Thus, the pages in the region can't be
>   accessed by the kernel itself, so that, for example, pointers to the
>   region can't be passed to system calls.)
> 
> We need to handle this special case gracefully in build ID fetching
> code. Return -EACCESS whenever secretmem file is passed to build_id_parse()
> family of APIs. Original report and repro can be found in [0].
> 
>   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> 
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

