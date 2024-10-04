Return-Path: <bpf+bounces-41021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349A2991111
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEDA1C2303F
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CA61ADFF8;
	Fri,  4 Oct 2024 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPUy9Z1k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A211231CA4;
	Fri,  4 Oct 2024 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075711; cv=none; b=DQ7SCMCAp7icQJ73Xr6sle6lkGlSkX7JL+OjP0FfP1ZkPMUpg2/OTIN0e84pLW4D9ViYgzVp4FbBUstFePdDSxHtro9eSElvjuB438OChvBXTqQAdQroNVtn7l6TRP4ZKN/xOTT4Hi8ZHl+OtY5FagTEDm05Kyz8XWaTh+O/ICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075711; c=relaxed/simple;
	bh=3f+ug6lYjvQo/vvQH8GrXUafldTscvyZcEnh1TwlRC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfQbJRw+jrovvnFh0zekeMh7Jkqt2Rgbu3whkN2mIqSWFcyTOS0u6ct4Z2/z+xWUtOepfTuu6bxX4Q84iUZTW49NZBZonJHH6u1rPvOtYTAT0FvFWaIIdMVxg22gqnXLwY2CcKu6E7UB5CZ2Fiz2KILTo+czHW6eTY0G5Xw2Af0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPUy9Z1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A07EC4CEC6;
	Fri,  4 Oct 2024 21:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728075710;
	bh=3f+ug6lYjvQo/vvQH8GrXUafldTscvyZcEnh1TwlRC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPUy9Z1kSaef3gOhk/lWDQ9VHIni4MMAm7mTH20o1M+TUSAAGyORsfgk+kcp/oWu+
	 c6fv+O4drhRlJpqu8Ylbj0N03aQk/WddC3WwJZD5Np/S4V6G9d3j5Exwe0kPvjOLTh
	 RJi3SIip9ErF5BnA9Ib9KcT6VtwPIS6GKzgbzJ6IUhxYnKSuSvv/1L7aNGhbUoV83M
	 5+HUW2qzOyXTle/ZKYPHZgaiO6c6zmstdC7GIdBARtSblxJAoS1LtSBK1tmhSlcUr5
	 5hr/3RTT27XQtXqz0S5Y1+s15AmtVpBje7GC2X6A7/3DUHlas0EZmdBK6z9LujcSHT
	 fAFak8qGzxkMQ==
Date: Fri, 4 Oct 2024 18:01:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves v4 0/4] Emit global variables in BTF
Message-ID: <ZwBXuqV4rbNPB5T6@x1>
References: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
 <ZwBXA6VCcyF-0aPb@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwBXA6VCcyF-0aPb@x1>

On Fri, Oct 04, 2024 at 05:58:48PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Oct 04, 2024 at 10:26:24AM -0700, Stephen Brennan wrote:
> > Hi all,
> > 
> > This is v4 of the series which adds global variables to pahole's generated BTF.
> > 
> > Since v3:
> > 
> > 1. Gathered Alan's Reviewed-by + Tested-by, and Jiri's Acked-by.
> > 2. Consistently start shndx loops at 1, and use size_t.
> > 3. Since patch 1 of v3 was already applied, I dropped it out of this series.
> > 
> > v3: https://lore.kernel.org/dwarves/20241002235253.487251-1-stephen.s.brennan@oracle.com/
> > v2: https://lore.kernel.org/dwarves/20240920081903.13473-1-stephen.s.brennan@oracle.com/
> > v1: https://lore.kernel.org/dwarves/20240912190827.230176-1-stephen.s.brennan@oracle.com/
> > 
> > Thanks everyone for your review, tests, and consideration!
> 
> Looks ok, I run the existing regression tests:
> 
> acme@x1:~/git/pahole$ tests/tests 
>   1: Validation of BTF encoding of functions; this may take some time: Ok
>   2: Pretty printing of files using DWARF type information: Ok
>   3: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
> /home/acme/git/pahole
> acme@x1:~/git/pahole$
> 
> And now I'm building a kernel with clang + Thin LTO + Rust enabled in
> the kernel to test other fixes I have merged and doing that with your
> patch series.
> 
> Its all in the next branch and will move to master later today or
> tomorrow when I finish the clang+LTO+Rust tests.

Ah, please consider looking at the test/ scripts and try to write a
simple test that will encode global vars from the running kernel and
then use bpftool to dump them and look for some of the well known kernel
global variables being encoded to match expectations, so that we have
this feature continuously tested vai tests/tests.

If now the increase in size due to global vars is of N%, please consider
checking if that is off by some unreasonable margin, etc.

Thanks!

- Arnaldo

