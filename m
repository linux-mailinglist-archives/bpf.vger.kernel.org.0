Return-Path: <bpf+bounces-41299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41B499595A
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D04285BC2
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 21:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2113215026;
	Tue,  8 Oct 2024 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tdkGR0qn"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79112C859
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423582; cv=none; b=Dqit6PZMuDaJamelSl2/7MtJxeeq9/h00UF3cz5U+J5iKj1BJeT1dLQjjE/hSPGKLrWjbbCiaGH4h35/1QIp6u1TrwWrqfYN2+IRzs16K85k80DDELdWQt5JTSWXCib/LIfxguIiYxAi5Jm3UttmQJZcKvzCszY4HiiSu4kJwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423582; c=relaxed/simple;
	bh=7Fk9hEbyJa/5s/TjAYnY21mhwMhyHGcSiSWIhGqiyj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYdKwpP852EYl/Ou1gUueTizuhvokqEKo4YdTB3ng5WkagwDoILgs7azdLxLV5Bou932zg0tU1DDYPYovljar60KnEZ1vIagLOOJbRatXYbhRHOAC7kpm2m0o38pNT9CnuMFHnaKCz8IyIfwWTZUSQiipfQtfejbHV4KE+MGRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tdkGR0qn; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 8 Oct 2024 14:39:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728423577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=upcROJIFe0W5gBFb4ALFX5lsfVgqMc+rHei4YQkYfl0=;
	b=tdkGR0qnlVBzBzEZBwL+0FMRxd1cajezHtvnnvFP+/jvi4Y9uNrcinS8xppfVjW9wDnC68
	NU2LDbgF9gBaG6svpO6+RS6qH8CJ8Ec5PeHL8YG/a01AEpdrvXjQW6aAfaHFUU096bd7dl
	GVwka/+eDZ7Y9Kdxw9HuOn1I31F09Dc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Rik van Riel <riel@surriel.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] bpf: use kvzmalloc to allocate BPF  verifier environment
Message-ID: <rf7i4y4zsm5yspnvebn6msj5r5dfvde3qvkti65fnhngcueqj3@landndtl6she>
References: <20241008170735.16766766@imladris.surriel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008170735.16766766@imladris.surriel.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 08, 2024 at 05:07:35PM GMT, Rik van Riel wrote:
> The kzmalloc call in bpf_check can fail when memory is very fragmented,
> which in turn can lead to an OOM kill.
> 
> Use kvzmalloc to fall back to vmalloc when memory is too fragmented to
> allocate an order 3 sized bpf verifier environment.
> 
> Admittedly this is not a very common case, and only happens on systems
> where memory has already been squeezed close to the limit, but this does
> not seem like much of a hot path, and it's a simple enough fix.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

It seems like a temporary allocation, so using kvmalloc* seems
reasonable.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

