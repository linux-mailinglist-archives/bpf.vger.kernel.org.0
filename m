Return-Path: <bpf+bounces-77234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84133CD27FE
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 06:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 339B030198B2
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381802F260E;
	Sat, 20 Dec 2025 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E96iMTu/"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620B2EA731
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 05:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766208213; cv=none; b=jrqQ/IyybOaYfU1e/FukOtBM+JjOGMtwOyeF9dyDXKdJNa3b154Sq8TJgQ5IPwfmXYvbSd3kOmv3PsWGX7WHvT4zkBpb2R+45VyDNb/68SWSpp1hPdPnTQz6O5zdeL2e6UE8zopTx1CESKOkgC8fhF/AJRIDPq7DgCz8jDJzHJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766208213; c=relaxed/simple;
	bh=W5PkXHdHJIz+tWCZ8CQGDXw2qCO5zibc731DreY/XgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmxy29eNOqb6cEfg5B/mXbZuEiD2qcW+3HyKxxMpx1Z23dMvg5fNQnPOrhohtr/g72YnB1pMrbaqvSk06E4REhnHxfcR8wHB6LIQhDjjtQUuiL6wGXcuT2kvPg791z+f8vZ9SMRYYF4Uu/QTKEgyfoVh+hoJBFZgfJm2sp8DqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E96iMTu/; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 21:23:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766208209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NH84hFbT6mBoGZa2DFioRDPIdMVCGgqrsbMckQDnZaw=;
	b=E96iMTu/ccj8rZ2OJ88bXrZmfzS69LJE9K7c+HWRq5tqJTDvsXer0hLUATLYsIb/S+392Y
	68swuO9gt6T7oTDcCCQjUzxYAJAqjy0tpD9z3NtC4Jm8S4LviqvjUsTSL6gmCIC5iFcBue
	mvxY2QGcrGxDW/bBXlI8lcDc5M/rtzM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v2 6/7] bpf: selftests: selftests for memcg stat
 kfuncs
Message-ID: <cipotudex5346rnml5fnzdghlnuhdtsberlhmmphsjrvjyy3bh@ozwywiozr26v>
References: <20251220041250.372179-1-roman.gushchin@linux.dev>
 <20251220041250.372179-7-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220041250.372179-7-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 19, 2025 at 08:12:49PM -0800, Roman Gushchin wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
> 
> Add test coverage for the kfuncs that fetch memcg stats. Using some common
> stats, test scenarios ensuring that the given stat increases by some
> arbitrary amount. The stats selected cover the three categories represented
> by the enums: node_stat_item, memcg_stat_item, vm_event_item.
> 
> Since only a subset of all stats are queried, use a static struct made up
> of fields for each stat. Write to the struct with the fetched values when
> the bpf program is invoked and read the fields in the user mode program for
> verification.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

