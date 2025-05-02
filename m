Return-Path: <bpf+bounces-57210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B6AA6E31
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 11:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11164C09B6
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58022E3F0;
	Fri,  2 May 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXRbj5ZM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92F1C1F22;
	Fri,  2 May 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178366; cv=none; b=P+bvbJkG7vm2nEP1PtYrLCzBeL6mxN8lNX31cPNIGNdCYH+lj4L/E6Aev3LcDrox08OakYPI2EmcQlutEMs7Ebnjuve+eBXRQGMI+gFieHQwCwUDHGDMbPpA+yDO1MahM6uQXXcQql3T182mvIG7f38wFYf4Yo0E9Fbmwz76s38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178366; c=relaxed/simple;
	bh=0vDGwkRxEHpSPWuymvoAUvdjVGevzUbu6/dHyqaRLQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2O+gbDAwdVORWrvQD0Tglgkzh1l8OsOpTXLrb3ngSEylE2m11xVxcrHQGLiow38Fa2o6GCsJVdBwNmg7+dnBpSv039nj8WWRIiZxuhvggsxUMxB+fW9dCtJCyMswhiC8VjKWKh93wg9C4FNjKrW+v/D7ZefynnaufRDmsA6ndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXRbj5ZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B19C4CEE4;
	Fri,  2 May 2025 09:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746178364;
	bh=0vDGwkRxEHpSPWuymvoAUvdjVGevzUbu6/dHyqaRLQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXRbj5ZMzy5nqzaMnI8DqiW+nO1n+daIaDg+6cZu5ASlx8PMIfETiqnKBEN39XRqJ
	 pGgNCk5YHP8LCTAQ/U15ERsC9Yzvl89RyHS292x2WuJ4zQXpWUFmHbzDkywQBoCYMu
	 Z6kGND7AVBw0aDI1v+KlKsSpDKiIn70PaQ8JFCXPwhZnpbjHEAoBo6YebFJjUMy5+q
	 ek/8R0TWG/Xq6viAsOAF1mpixsYNDVJ0yP3NOnKeZLldO/USWKCJqHQE06odLrcXqR
	 vNUTjgNQFKwYBmI7zLnafZ7lgtBJlgz/WnIzKr0IvpQm4EtF4+QDHiPsG887mmCXqf
	 J58IQUQSkncKA==
Date: Fri, 2 May 2025 10:32:39 +0100
From: Simon Horman <horms@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org,
	xiyou.wangcong@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next/net v1 1/5] bpf: net_sched: Fix bpf qdisc init
 prologue when set as default qdisc
Message-ID: <20250502093239.GD3339421@horms.kernel.org>
References: <20250501223025.569020-1-ameryhung@gmail.com>
 <20250501223025.569020-2-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501223025.569020-2-ameryhung@gmail.com>

On Thu, May 01, 2025 at 03:30:21PM -0700, Amery Hung wrote:
> Allow .init to proceed if qdisc_lookup() returns NULL as it only happens
> when called by qdisc_create_dflt() in mq/mqprio_init and the parent qdisc
> has not been added to qdisc_hash yet. In qdisc_create(), the caller,
> __tc_modify_qdisc(), would have made sure the parent qdisc already exist.
> 
> In addition, call qdisc_watchdog_init() whether .init succeeds or not to
> prevent null-pointer dereference. In qdisc_create() and
> qdisc_create_dflt(), if .init fails, .destroy will be called. As a
> result, the destroy epilogue could call qdisc_watchdog_cancel() with an
> uninitialized timer, causing null-pointer deference in hrtimer_cancel().
> 
> Fixes: Fixes: c8240344956e ("bpf: net_sched: Support implementation of Qdisc_ops in bpf")

nit: One "Fixes: " is enough.

> Signed-off-by: Amery Hung <ameryhung@gmail.com>

...

